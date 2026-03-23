Return-Path: <stable+bounces-228679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BS6LkhmwWlESwQAu9opvQ
	(envelope-from <stable+bounces-228679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:11:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 474432F7B67
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8290331BA7A6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAC93B19C5;
	Mon, 23 Mar 2026 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xfihHu07"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997423B0AF1;
	Mon, 23 Mar 2026 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276836; cv=none; b=WdLe8gtkGFbePTPtBKs8Hr8wqj8SmWzJAPEGz9eXSYQ5U8IGDRg+1n38P1K5RFcfTRy9xOT0pyKCcmf9AowJdk5UVGZfSxK6Z5SD3yfcxLHnWBHPRoj1fooEimWhgv/TrI2oOMqUW28KEKMqxMVTfY28yCUI6tiZlm4Qk80iQqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276836; c=relaxed/simple;
	bh=IY3HOV3IuyNTsc6/SvGD8i7MRf3Zxo8l8fvH0K5atkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NO6DsF5USympmmZFoRDyWWerscjF1y8P0CaHilzO3qqPjApLL5kP0tkdsn6E0VsG+YBREzWbg8LzlgXOJNVNidVVxLTcDDUiJD1cfxxvNxksOsgPfdsjg7pA0FaOQM3JzSEg3qmHGPWsdT0+hyzEMe2pRa8zdHC1MOONvKX6xrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xfihHu07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FE2C4CEF7;
	Mon, 23 Mar 2026 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276836;
	bh=IY3HOV3IuyNTsc6/SvGD8i7MRf3Zxo8l8fvH0K5atkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xfihHu07JFxNaUavFc6koPFmyWeOQ0Nok6NoQwX47D2oo6oc1cFD6dS8CZ6sefipA
	 UVleWnzuJCX9Aw4hCwS+DyHZt9UMeq7zr2BTamPc1jc+jlSmd7cy3QaMmY8Qi7icyt
	 gGUAVgZrS8Rzu7fSwkc3Nzxrz7Kbwxfa7/A0LBvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 221/460] smb: client: Compare MACs in constant time
Date: Mon, 23 Mar 2026 14:43:37 +0100
Message-ID: <20260323134531.929588608@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228679-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,manguebit.org:email]
X-Rspamd-Queue-Id: 474432F7B67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

commit 26bc83b88bbbf054f0980a4a42047a8d1e210e4c upstream.

To prevent timing attacks, MAC comparisons need to be constant-time.
Replace the memcmp() with the correct function, crypto_memneq().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsencrypt.c   |    3 ++-
 fs/smb/client/smb2transport.c |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -24,6 +24,7 @@
 #include <linux/iov_iter.h>
 #include "../common/arc4.h"
 #include <crypto/aead.h>
+#include <crypto/utils.h>
 
 static size_t cifs_shash_step(void *iter_base, size_t progress, size_t len,
 			      void *priv, void *priv2)
@@ -257,7 +258,7 @@ int cifs_verify_signature(struct smb_rqs
 /*	cifs_dump_mem("what we think it should be: ",
 		      what_we_think_sig_should_be, 16); */
 
-	if (memcmp(server_response_sig, what_we_think_sig_should_be, 8))
+	if (crypto_memneq(server_response_sig, what_we_think_sig_should_be, 8))
 		return -EACCES;
 	else
 		return 0;
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -19,6 +19,7 @@
 #include <linux/mempool.h>
 #include <linux/highmem.h>
 #include <crypto/aead.h>
+#include <crypto/utils.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "smb2proto.h"
@@ -732,7 +733,8 @@ smb2_verify_signature(struct smb_rqst *r
 	if (rc)
 		return rc;
 
-	if (memcmp(server_response_sig, shdr->Signature, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(server_response_sig, shdr->Signature,
+			  SMB2_SIGNATURE_SIZE)) {
 		cifs_dbg(VFS, "sign fail cmd 0x%x message id 0x%llx\n",
 			shdr->Command, shdr->MessageId);
 		return -EACCES;



