Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1B37F50E0
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 20:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjKVTnM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 14:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjKVTnM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 14:43:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF691A4
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 11:43:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4C1C433C7;
        Wed, 22 Nov 2023 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700682188;
        bh=bHSXaGE7risSkHKeKQONjkPIfegl/PVO1WinOEL+5xk=;
        h=Subject:To:Cc:From:Date:From;
        b=Ebfuo5fr390Nh4SutLfxCkcvpHTXuFimvD3vm3EddZaJrf256IdYdUsn4GfOQqzq4
         x1WeoCWcxuSrBt+xglI1HW6/dbdoYXjgGUbbKasLQ4qMwKGyqhu5mk/Y0xhN5iN3yz
         Cq0xLNiJF6OSUmVLtKRWvGQgC9VZhEQNJR+4Vu8k=
Subject: FAILED: patch "[PATCH] ksmbd: fix slab out of bounds write in smb_inherit_dacl()" failed to apply to 5.15-stable tree
To:     linkinjeon@kernel.org, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 19:43:05 +0000
Message-ID: <2023112205-eleven-enrich-934c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x eebff19acaa35820cb09ce2ccb3d21bee2156ffb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112205-eleven-enrich-934c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

eebff19acaa3 ("ksmbd: fix slab out of bounds write in smb_inherit_dacl()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eebff19acaa35820cb09ce2ccb3d21bee2156ffb Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 5 Nov 2023 12:46:24 +0900
Subject: [PATCH] ksmbd: fix slab out of bounds write in smb_inherit_dacl()

slab out-of-bounds write is caused by that offsets is bigger than pntsd
allocation size. This patch add the check to validate 3 offsets using
allocation size.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-22271
Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 6c0305be895e..51b8bfab7481 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1107,6 +1107,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		struct smb_acl *pdacl;
 		struct smb_sid *powner_sid = NULL, *pgroup_sid = NULL;
 		int powner_sid_size = 0, pgroup_sid_size = 0, pntsd_size;
+		int pntsd_alloc_size;
 
 		if (parent_pntsd->osidoffset) {
 			powner_sid = (struct smb_sid *)((char *)parent_pntsd +
@@ -1119,9 +1120,10 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pgroup_sid_size = 1 + 1 + 6 + (pgroup_sid->num_subauth * 4);
 		}
 
-		pntsd = kzalloc(sizeof(struct smb_ntsd) + powner_sid_size +
-				pgroup_sid_size + sizeof(struct smb_acl) +
-				nt_size, GFP_KERNEL);
+		pntsd_alloc_size = sizeof(struct smb_ntsd) + powner_sid_size +
+			pgroup_sid_size + sizeof(struct smb_acl) + nt_size;
+
+		pntsd = kzalloc(pntsd_alloc_size, GFP_KERNEL);
 		if (!pntsd) {
 			rc = -ENOMEM;
 			goto free_aces_base;
@@ -1136,6 +1138,27 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		pntsd->gsidoffset = parent_pntsd->gsidoffset;
 		pntsd->dacloffset = parent_pntsd->dacloffset;
 
+		if ((u64)le32_to_cpu(pntsd->osidoffset) + powner_sid_size >
+		    pntsd_alloc_size) {
+			rc = -EINVAL;
+			kfree(pntsd);
+			goto free_aces_base;
+		}
+
+		if ((u64)le32_to_cpu(pntsd->gsidoffset) + pgroup_sid_size >
+		    pntsd_alloc_size) {
+			rc = -EINVAL;
+			kfree(pntsd);
+			goto free_aces_base;
+		}
+
+		if ((u64)le32_to_cpu(pntsd->dacloffset) + sizeof(struct smb_acl) + nt_size >
+		    pntsd_alloc_size) {
+			rc = -EINVAL;
+			kfree(pntsd);
+			goto free_aces_base;
+		}
+
 		if (pntsd->osidoffset) {
 			struct smb_sid *owner_sid = (struct smb_sid *)((char *)pntsd +
 					le32_to_cpu(pntsd->osidoffset));

