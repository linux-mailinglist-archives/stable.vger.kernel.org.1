Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2533A70379E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbjEORXR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbjEORW6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:22:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C01248E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F42462BDD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83490C433EF;
        Mon, 15 May 2023 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171252;
        bh=mCWVx0uhSf9MOzZrWYFdGP9bFtRZm4nitNEcklG3UOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5tay/X1PW0enP+HmCfaEYQOUgCbiFRpRY59nVlDHhZpqt+wS1RI6k7k+ik9xY1h+
         jnnpG2HUOUpGso93uZ+FmQ1UPOdtkxEt+1TJRhDu4I5a00D/SY5WdCd/WA5YTMuc2x
         H8MnQJPr7AAZaqDK5aZLxKQY8yGt0PY6oorLglho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.2 150/242] smb3: fix problem remounting a share after shutdown
Date:   Mon, 15 May 2023 18:27:56 +0200
Message-Id: <20230515161726.391813932@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit 716a3cf317456fa01d54398bb14ab354f50ed6a2 upstream.

xfstests generic/392 showed a problem where even after a
shutdown call was made on a mount, we would still attempt
to use the (now inaccessible) superblock if another mount
was attempted for the same share.

Reported-by: David Howells <dhowells@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: <stable@vger.kernel.org>
Fixes: 087f757b0129 ("cifs: add shutdown support")
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/connect.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2754,6 +2754,13 @@ cifs_match_super(struct super_block *sb,
 
 	spin_lock(&cifs_tcp_ses_lock);
 	cifs_sb = CIFS_SB(sb);
+
+	/* We do not want to use a superblock that has been shutdown */
+	if (CIFS_MOUNT_SHUTDOWN & cifs_sb->mnt_cifs_flags) {
+		spin_unlock(&cifs_tcp_ses_lock);
+		return 0;
+	}
+
 	tlink = cifs_get_tlink(cifs_sb_master_tlink(cifs_sb));
 	if (tlink == NULL) {
 		/* can not match superblock if tlink were ever null */


