Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6D73E85D
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjFZSY7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjFZSYo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F4D1FF0
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB99360F53
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FECC433CB;
        Mon, 26 Jun 2023 18:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803850;
        bh=1SNA1AhD3meXTukFvadt6ADtVpWTZQxnT38MVcWf1G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vguNLPRm77EODBBaNseRbC/azmHMXX9k6o+oVIYPymtx5/A3I03zS41NXK0JgdPBk
         zvJj8kvHfMqah9enHHSyATPQnkjgMq2uZx7TO5VXa+1b0AxWgLfZZxWTcaeVZK2H/q
         eqBDBzvaOnf9lyRYeidia7WSTNpiEJoO0EGsNvT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.3 199/199] ksmbd: call putname after using the last component
Date:   Mon, 26 Jun 2023 20:11:45 +0200
Message-ID: <20230626180814.466695834@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 6fe55c2799bc29624770c26f98ba7b06214f43e0 upstream.

last component point filename struct. Currently putname is called after
vfs_path_parent_lookup(). And then last component is used for
lookup_one_qstr_excl(). name in last component is freed by previous
calling putname(). And It cause file lookup failure when testing
generic/464 test of xfstest.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/vfs.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -86,12 +86,14 @@ static int ksmbd_vfs_path_lookup_locked(
 	err = vfs_path_parent_lookup(filename, flags,
 				     &parent_path, &last, &type,
 				     root_share_path);
-	putname(filename);
-	if (err)
+	if (err) {
+		putname(filename);
 		return err;
+	}
 
 	if (unlikely(type != LAST_NORM)) {
 		path_put(&parent_path);
+		putname(filename);
 		return -ENOENT;
 	}
 
@@ -108,12 +110,14 @@ static int ksmbd_vfs_path_lookup_locked(
 	path->dentry = d;
 	path->mnt = share_conf->vfs_path.mnt;
 	path_put(&parent_path);
+	putname(filename);
 
 	return 0;
 
 err_out:
 	inode_unlock(parent_path.dentry->d_inode);
 	path_put(&parent_path);
+	putname(filename);
 	return -ENOENT;
 }
 


