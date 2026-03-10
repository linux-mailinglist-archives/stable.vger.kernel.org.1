Return-Path: <stable+bounces-224556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNBnEEp2sGnJjQIAu9opvQ
	(envelope-from <stable+bounces-224556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:51:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D51532572E6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43F9030465DF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E677F35A38B;
	Tue, 10 Mar 2026 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvKQoaJw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989C35A38A;
	Tue, 10 Mar 2026 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172267; cv=none; b=tm7qxLAce8jYT3nPprQVRels9hx+kSU2dZisbm7/EBMAjelA0YhIuWVIrmUvsuE03cKPFj9HFnHQDTTO71h+ldDVExZevwc9Nm0AZLDBR+DrsaUfxqprtD75wClUcWU84qtwK90oZlQpwQAb9Be+4xwgJbSDza7ZaTWJ5jklLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172267; c=relaxed/simple;
	bh=PHVqUmdZOJoCMt1Z2VcfyTE7sGV0SetRg8yMWp20OkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kl2yJ86VU43C5WAiTPUUNjFQWZc/sn0a3zW4Oz/wSqJnPY/A8V6fTUGzzFGgsnWrgvYm4H5oJpkgEkt9ujaZeU1ZUX/HyAG0cyZKa8M0lbxUhLP/Rp15UCwOnh8GiLVg4vq51Ayaa9kA1fGFOJHNPgNCF/7knD3KcGR6w5ftH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvKQoaJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3F6C19423;
	Tue, 10 Mar 2026 19:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773172267;
	bh=PHVqUmdZOJoCMt1Z2VcfyTE7sGV0SetRg8yMWp20OkI=;
	h=From:To:Cc:Subject:Date:From;
	b=lvKQoaJwEl9VFCiAKvp5nfgXxOlSV+4li4sni0hylLks/6hWQT+dzpQ4YcaFrbcrA
	 N/swEd0egd964vxTXBetj3krrhVOKGwzbiYoQhLIXEDEm9cPtvK+MuTCQKLqkbom7O
	 35DOP5FkmM/tG/9iui7B51nUjrtF0qAGDTqhPSgPA2KPECY0vAa0lxfjmAmZNkwS03
	 Jlavg8j0Xq9Zp5UZHTMEmBEIPT6kB1p+EB39zocwteLv0mjZ0AW/XVBGJ7YgKPPC7c
	 4K5MQVwexNK9y5qWv38tB9kTYIHSdb74nRqPsMBfHO5U937CeXEcRqX2n3E7rtMyfE
	 uazen/Gd1YriA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1] smb: client: Compare MACs in constant time
Date: Tue, 10 Mar 2026 12:51:03 -0700
Message-ID: <20260310195103.70705-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D51532572E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224556-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

commit 26bc83b88bbbf054f0980a4a42047a8d1e210e4c upstream.

To prevent timing attacks, MAC comparisons need to be constant-time.
Replace the memcmp() with the correct function, crypto_memneq().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/cifsencrypt.c   | 3 ++-
 fs/smb/client/smb2transport.c | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index d3d4cf6321fd5..743098804edcc 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -21,10 +21,11 @@
 #include <linux/random.h>
 #include <linux/highmem.h>
 #include <linux/fips.h>
 #include "../common/arc4.h"
 #include <crypto/aead.h>
+#include <crypto/algapi.h>
 
 int __cifs_calc_signature(struct smb_rqst *rqst,
 			struct TCP_Server_Info *server, char *signature,
 			struct shash_desc *shash)
 {
@@ -241,11 +242,11 @@ int cifs_verify_signature(struct smb_rqst *rqst,
 		return rc;
 
 /*	cifs_dump_mem("what we think it should be: ",
 		      what_we_think_sig_should_be, 16); */
 
-	if (memcmp(server_response_sig, what_we_think_sig_should_be, 8))
+	if (crypto_memneq(server_response_sig, what_we_think_sig_should_be, 8))
 		return -EACCES;
 	else
 		return 0;
 
 }
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 763cf946e8491..73d281abd265a 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -17,10 +17,11 @@
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 #include <linux/mempool.h>
 #include <linux/highmem.h>
 #include <crypto/aead.h>
+#include <crypto/algapi.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "smb2proto.h"
 #include "cifs_debug.h"
 #include "smb2status.h"
@@ -697,11 +698,12 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 	rc = server->ops->calc_signature(rqst, server, true);
 
 	if (rc)
 		return rc;
 
-	if (memcmp(server_response_sig, shdr->Signature, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(server_response_sig, shdr->Signature,
+			  SMB2_SIGNATURE_SIZE)) {
 		cifs_dbg(VFS, "sign fail cmd 0x%x message id 0x%llx\n",
 			shdr->Command, shdr->MessageId);
 		return -EACCES;
 	} else
 		return 0;

base-commit: f2ddafa93a259310ca47507153b7811ec54ab7fd
-- 
2.53.0


