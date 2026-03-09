Return-Path: <stable+bounces-223572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uML1G9egrmm2GwIAu9opvQ
	(envelope-from <stable+bounces-223572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:28:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DDB2370C7
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A023300FED2
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194A7081F;
	Mon,  9 Mar 2026 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ecBCETJX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25392D27E
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052070; cv=none; b=MKS7o9Gu18mzS5mzm30/ymaalTl3ky7EcGTy7KXgRO9sf164hTgBzarKH6m8Awca3T+MdIUAhi4LAYWkpBLYOT++NZ/QRvSbD4tPUvMr24XJlgeuIhLuhDsCHoOSgMdvy5YcU652COtJXQlgBWrkgFCZdUj9r4ox+MVRWwu8y8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052070; c=relaxed/simple;
	bh=1YPY7mMY6mY70nxI7yxOgm9drfqfhA8LTHWTLyzfT8w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CBHzrFnft6ju0biCCg0Us+Qzx31ejcdAVux2WXievVFAXIavZBy71Fc/pfGnS2l7eIHTcAPgGbFgz6QSgPDVonDOA4tVo2K3mFNalwzOS+uBrfFd783X4FWmE856RVP8vxhxcJ4ej39oxA8xKQNaH3KTxg5jJfz77z5vWp2i4K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ecBCETJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8EEC4CEF7;
	Mon,  9 Mar 2026 10:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773052070;
	bh=1YPY7mMY6mY70nxI7yxOgm9drfqfhA8LTHWTLyzfT8w=;
	h=Subject:To:Cc:From:Date:From;
	b=ecBCETJXg6V0v54SudDUmbTRGepzdSqJW160uuOLtVKKkP9t9XvMJUjcNLJscYtAK
	 mLd5M3xjeORtn2IZc0AkktJ8SfRRBkG29OyvwxOyCmev6LveqgEumyuUSVR0K2ymq6
	 cHOjRTNyCnu7NpR/WOH+HdBx2TDQef8PYDxCPtw8=
Subject: FAILED: patch "[PATCH] smb: client: Compare MACs in constant time" failed to apply to 6.1-stable tree
To: ebiggers@kernel.org,pc@manguebit.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:27:35 +0100
Message-ID: <2026030935-prefix-posture-49df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72DDB2370C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223572-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.227];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,manguebit.org:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 26bc83b88bbbf054f0980a4a42047a8d1e210e4c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030935-prefix-posture-49df@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26bc83b88bbbf054f0980a4a42047a8d1e210e4c Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 17 Feb 2026 20:27:02 -0800
Subject: [PATCH] smb: client: Compare MACs in constant time

To prevent timing attacks, MAC comparisons need to be constant-time.
Replace the memcmp() with the correct function, crypto_memneq().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb1encrypt.c b/fs/smb/client/smb1encrypt.c
index 0dbbce2431ff..bf10fdeeedca 100644
--- a/fs/smb/client/smb1encrypt.c
+++ b/fs/smb/client/smb1encrypt.c
@@ -11,6 +11,7 @@
 
 #include <linux/fips.h>
 #include <crypto/md5.h>
+#include <crypto/utils.h>
 #include "cifsproto.h"
 #include "smb1proto.h"
 #include "cifs_debug.h"
@@ -131,7 +132,7 @@ int cifs_verify_signature(struct smb_rqst *rqst,
 /*	cifs_dump_mem("what we think it should be: ",
 		      what_we_think_sig_should_be, 16); */
 
-	if (memcmp(server_response_sig, what_we_think_sig_should_be, 8))
+	if (crypto_memneq(server_response_sig, what_we_think_sig_should_be, 8))
 		return -EACCES;
 	else
 		return 0;
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 8b9000a83181..81be2b226e26 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -20,6 +20,7 @@
 #include <linux/highmem.h>
 #include <crypto/aead.h>
 #include <crypto/sha2.h>
+#include <crypto/utils.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "smb2proto.h"
@@ -617,7 +618,8 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 	if (rc)
 		return rc;
 
-	if (memcmp(server_response_sig, shdr->Signature, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(server_response_sig, shdr->Signature,
+			  SMB2_SIGNATURE_SIZE)) {
 		cifs_dbg(VFS, "sign fail cmd 0x%x message id 0x%llx\n",
 			shdr->Command, shdr->MessageId);
 		return -EACCES;


