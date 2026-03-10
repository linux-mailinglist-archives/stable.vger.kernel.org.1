Return-Path: <stable+bounces-224555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IAHNDJ2sGnJjQIAu9opvQ
	(envelope-from <stable+bounces-224555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:51:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803192572CA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 353C53063B5B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA7235A380;
	Tue, 10 Mar 2026 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhBhcIny"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27183542CF;
	Tue, 10 Mar 2026 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172264; cv=none; b=W4Cdz9q0IdlikkmXQ9iWpRa3QfQRpqiBCscmpBDHyDbPgvaDMr01oFgF04iNPdByHdvxGhrzVGWXl+SSdVxrveY7zvBqRhy60DyD3ryMrveysGrT3/jEGs8a+EX4A+vYFN7np8BOqlS68t/alBDxfiRpyFccEY7hPTPSNLVQ5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172264; c=relaxed/simple;
	bh=Ad47JaXsywSU6JBLYbdP676mE2ZoM/HobzD5EQN8XWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfx76IuO8vjyvpdd1hI+wHkkpvDLK8Ym29dY+T14UEVkW6PC0C1sO0M6/z6VGOJyS//63xKE256AjBdT25t3rKnUwyJezx9OuRjXLOiJ/nWMNA0Ef1JeX1a5O6bO/Qh2FN4296VcOHu2QRCsMWiP1poaB8XonO0+NCTlDt204wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhBhcIny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2EEC19423;
	Tue, 10 Mar 2026 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773172263;
	bh=Ad47JaXsywSU6JBLYbdP676mE2ZoM/HobzD5EQN8XWc=;
	h=From:To:Cc:Subject:Date:From;
	b=rhBhcIny72YQS4nwBDnRFNpkRyNRkrynLzNBNd1XZ1w5DvPDFsZwc0RAMonGjfXaI
	 a7RrOEL+HF6GJdLrdnJdyOey8+XZJUTtC7+43VneVLLIyQbXp5vWJFPN30iTW+uf8c
	 1wkUL6fdTAKysXUe3B8vSXn1bkPYSWb7pUFlSiEsNY3c9gC0J73Dv0HYeocRvQz1eO
	 YquToz2UTm50h3em5n1oOSnB5fcSdgDS6JZPcpX8NGL1czE8NjxUqFTIqKB9vzhsVC
	 rxr65WcDZ+YvtyZpSJJiKyzh8ns0vLcnVoRtyzvq1mMBbMw9qm6/+7xY5YMFoUuWtY
	 YWlrYi/HizebQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6] smb: client: Compare MACs in constant time
Date: Tue, 10 Mar 2026 12:50:58 -0700
Message-ID: <20260310195058.70682-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 803192572CA
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
	TAGGED_FROM(0.00)[bounces-224555-lists,stable=lfdr.de];
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
index da3d003cb43db..3d6b663212335 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -21,10 +21,11 @@
 #include <linux/random.h>
 #include <linux/highmem.h>
 #include <linux/fips.h>
 #include "../common/arc4.h"
 #include <crypto/aead.h>
+#include <crypto/utils.h>
 
 /*
  * Hash data from a BVEC-type iterator.
  */
 static int cifs_shash_bvec(const struct iov_iter *iter, ssize_t maxsize,
@@ -369,11 +370,11 @@ int cifs_verify_signature(struct smb_rqst *rqst,
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
index 99081e9d6283a..daf8ba2cd8a10 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -17,10 +17,11 @@
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 #include <linux/mempool.h>
 #include <linux/highmem.h>
 #include <crypto/aead.h>
+#include <crypto/utils.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "smb2proto.h"
 #include "cifs_debug.h"
 #include "smb2status.h"
@@ -730,11 +731,12 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
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

base-commit: 4fc00fe35d46b4fc8dac2eb543a0e3d44bb15f47
-- 
2.53.0


