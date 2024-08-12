Return-Path: <stable+bounces-66489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D5094EC4A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA395B2164B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF43D14B95B;
	Mon, 12 Aug 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KY+lUAaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE201366
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464235; cv=none; b=SFyIP5/fXiyFiSsKILkxVRBMgjm5TsMvA63RwiIc4SbgnzPraFt15ekL0BcN5D1IIMgf1taYLNoAfZMfrTJ6k0GsQcSAUarKnhT5sr+8oLE06lK2xdfc3dnvcpbOcLS02SQ/SCoBrZ6CHpzeYL45UDWTkphE0TyW4xNLWxckrlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464235; c=relaxed/simple;
	bh=XCb9PO7RoY8vZCfonXODrXaX1BLjJWMB9bwMwcd9aIY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nZftaM838b1nPuA9QrqRd+bmtMHUxgHsA/F6NM1nksGQ2+wb5+5szcLSikj8rkJC4YP17GglHqwYDQL+30z3Pvwk9ldX6DVlRFB00488naOv4CUPVihuWrFmOyq6oo9krqiF2o7GdtOWMbIwVxQVd/plGlRwj1GanMevN6kVotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KY+lUAaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC45C32782;
	Mon, 12 Aug 2024 12:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464235;
	bh=XCb9PO7RoY8vZCfonXODrXaX1BLjJWMB9bwMwcd9aIY=;
	h=Subject:To:Cc:From:Date:From;
	b=KY+lUAaI9QwXYQF+HpR9BbtmAfBgUs0muWhuLenME12Z4hUNASuHJo4ifOjZZjM3N
	 51vBj80OegNmgIjnWLmprXMmAJ696B3nvReZr94tlAnT4fDvdIzkEyrSP7LJg4PfUJ
	 uccQ8PF2LDtcgzKA2iXxxIKlQnkrI/bOaOI2GZm8=
Subject: FAILED: patch "[PATCH] smb3: fix setting SecurityFlags when encryption is required" failed to apply to 5.15-stable tree
To: stfrench@microsoft.com,bharathsm@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:03:52 +0200
Message-ID: <2024081252-boney-keenly-ca0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1b5487aefb1ce7a6b1f15a33297d1231306b4122
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081252-boney-keenly-ca0f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

1b5487aefb1c ("smb3: fix setting SecurityFlags when encryption is required")
d2346e283631 ("cifs: fix setting SecurityFlags to true")
2ac7069ad764 ("Documentation, arch: Remove leftovers from CIFS_WEAK_PW_HASH")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b5487aefb1ce7a6b1f15a33297d1231306b4122 Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Wed, 31 Jul 2024 21:38:50 -0500
Subject: [PATCH] smb3: fix setting SecurityFlags when encryption is required

Setting encryption as required in security flags was broken.
For example (to require all mounts to be encrypted by setting):

  "echo 0x400c5 > /proc/fs/cifs/SecurityFlags"

Would return "Invalid argument" and log "Unsupported security flags"
This patch fixes that (e.g. allowing overriding the default for
SecurityFlags  0x00c5, including 0x40000 to require seal, ie
SMB3.1.1 encryption) so now that works and forces encryption
on subsequent mounts.

Acked-by: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/Documentation/admin-guide/cifs/usage.rst b/Documentation/admin-guide/cifs/usage.rst
index fd4b56c0996f..c09674a75a9e 100644
--- a/Documentation/admin-guide/cifs/usage.rst
+++ b/Documentation/admin-guide/cifs/usage.rst
@@ -742,7 +742,7 @@ SecurityFlags		Flags which control security negotiation and
 			  may use NTLMSSP               		0x00080
 			  must use NTLMSSP           			0x80080
 			  seal (packet encryption)			0x00040
-			  must seal (not implemented yet)               0x40040
+			  must seal                                     0x40040
 
 cifsFYI			If set to non-zero value, additional debug information
 			will be logged to the system error log.  This field
diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index c71ae5c04306..4a20e92474b2 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -1072,7 +1072,7 @@ static int cifs_security_flags_proc_open(struct inode *inode, struct file *file)
 static void
 cifs_security_flags_handle_must_flags(unsigned int *flags)
 {
-	unsigned int signflags = *flags & CIFSSEC_MUST_SIGN;
+	unsigned int signflags = *flags & (CIFSSEC_MUST_SIGN | CIFSSEC_MUST_SEAL);
 
 	if ((*flags & CIFSSEC_MUST_KRB5) == CIFSSEC_MUST_KRB5)
 		*flags = CIFSSEC_MUST_KRB5;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index f6d1f075987f..b9f46d29a441 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1881,7 +1881,7 @@ static inline bool is_replayable_error(int error)
 #define   CIFSSEC_MAY_SIGN	0x00001
 #define   CIFSSEC_MAY_NTLMV2	0x00004
 #define   CIFSSEC_MAY_KRB5	0x00008
-#define   CIFSSEC_MAY_SEAL	0x00040 /* not supported yet */
+#define   CIFSSEC_MAY_SEAL	0x00040
 #define   CIFSSEC_MAY_NTLMSSP	0x00080 /* raw ntlmssp with ntlmv2 */
 
 #define   CIFSSEC_MUST_SIGN	0x01001
@@ -1891,11 +1891,11 @@ require use of the stronger protocol */
 #define   CIFSSEC_MUST_NTLMV2	0x04004
 #define   CIFSSEC_MUST_KRB5	0x08008
 #ifdef CONFIG_CIFS_UPCALL
-#define   CIFSSEC_MASK          0x8F08F /* flags supported if no weak allowed */
+#define   CIFSSEC_MASK          0xCF0CF /* flags supported if no weak allowed */
 #else
-#define	  CIFSSEC_MASK          0x87087 /* flags supported if no weak allowed */
+#define	  CIFSSEC_MASK          0xC70C7 /* flags supported if no weak allowed */
 #endif /* UPCALL */
-#define   CIFSSEC_MUST_SEAL	0x40040 /* not supported yet */
+#define   CIFSSEC_MUST_SEAL	0x40040
 #define   CIFSSEC_MUST_NTLMSSP	0x80080 /* raw ntlmssp with ntlmv2 */
 
 #define   CIFSSEC_DEF (CIFSSEC_MAY_SIGN | CIFSSEC_MAY_NTLMV2 | CIFSSEC_MAY_NTLMSSP | CIFSSEC_MAY_SEAL)
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 9a06b5594669..83facb54276a 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -82,6 +82,9 @@ int smb3_encryption_required(const struct cifs_tcon *tcon)
 	if (tcon->seal &&
 	    (tcon->ses->server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
 		return 1;
+	if (((global_secflags & CIFSSEC_MUST_SEAL) == CIFSSEC_MUST_SEAL) &&
+	    (tcon->ses->server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
+		return 1;
 	return 0;
 }
 


