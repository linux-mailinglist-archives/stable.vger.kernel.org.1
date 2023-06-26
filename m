Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A4073E860
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjFZSZR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjFZSYt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F9D10CC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B39560E76
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56606C433C9;
        Mon, 26 Jun 2023 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803844;
        bh=neA9qgU3dCAsv5QE8daUZ122pqBqvw9cm8lilPq1gEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuUA6Xe7sdgQmsoTLkDexaGBvFwgv1qhyOCt1Yev3OhkFrMuPO741STlX25u6xNgf
         Oz2s8KSlIvGoc7fqTasPbGX8v4TD26J9OkZSN8UoVxcwJN9KxMNrcgG0QZX3WZmJUy
         5nG76RaWdD8fSNx/hMstKrGvP8RaQ98wQP5Qo4I0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Coverity Scan <scan-admin@coverity.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.3 197/199] ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()
Date:   Mon, 26 Jun 2023 20:11:43 +0200
Message-ID: <20230626180814.377177329@linuxfoundation.org>
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

commit 48b47f0caaa8a9f05ed803cb4f335fa3a7bfc622 upstream.

Uninitialized rd.delegated_inode can be used in vfs_rename().
Fix this by setting rd.delegated_inode to NULL to avoid the uninitialized
read.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/vfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -769,6 +769,7 @@ retry:
 	rd.new_dir		= new_path.dentry->d_inode,
 	rd.new_dentry		= new_dentry,
 	rd.flags		= flags,
+	rd.delegated_inode	= NULL,
 	err = vfs_rename(&rd);
 	if (err)
 		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);


