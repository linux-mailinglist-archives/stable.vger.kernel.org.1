Return-Path: <stable+bounces-237285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKfJAsUh3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-237285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:03:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 882013F0950
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97CD430C41A9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F323191D0;
	Mon, 13 Apr 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FIyCIK1l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7E317153;
	Mon, 13 Apr 2026 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099063; cv=none; b=kMKFnorbwV725gsZlp1Y1m9V1zj1CzDf/PsBmxHmdhhL6qJlcDHWE8Kp/l7Fh///BwxwPP9n/WY6ZycaSxOnwXG+LL6kfFIcH0ANdUU20ENDG4waanwNVuo4mx+Sq/2tNBfvwwj7AbvBSLiJ/XkYyIB91LbeJnqGiVWEJnBnPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099063; c=relaxed/simple;
	bh=DpBD27Qc041yW227T1bhhjWvUGt2enVPd6LO00676gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHT8FkvpOm/DETU3RYVDcip4LU0olWn5ykDQ3D0X710KbumBVvPpecDL0I35X+v/sW2IVl2ZNkGYQ84TupxSTF18CKfVo3JUplOJ3yGxPFVQ/bYxRjLG4BuiTy4mg1Gm2QBuWvPM65B/ge66DLEMMsRzTbre57aewW5aFr3Tj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FIyCIK1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8169AC2BCAF;
	Mon, 13 Apr 2026 16:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099062;
	bh=DpBD27Qc041yW227T1bhhjWvUGt2enVPd6LO00676gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIyCIK1la/ShBFCcYJjKLFUJ2ZdtGjqGXA4tp/28ZzS7ylHdhKkPEVhScsBLtktLV
	 kAP7uX/AGOFTcIf1icLSPnniT2aYNRijdusWlB206ca8g4WWCAFv7R+XCSSZJ3JQV0
	 nEZEJDcVn4GTeqFTf14V97g5usbXav8wReipOYHg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.10 195/491] smb: client: Compare MACs in constant time
Date: Mon, 13 Apr 2026 17:57:20 +0200
Message-ID: <20260413155826.371693100@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237285-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,manguebit.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 882013F0950
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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
 fs/cifs/cifsencrypt.c   |    3 ++-
 fs/cifs/smb2transport.c |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -36,6 +36,7 @@
 #include <linux/fips.h>
 #include <crypto/arc4.h>
 #include <crypto/aead.h>
+#include <crypto/algapi.h>
 
 int __cifs_calc_signature(struct smb_rqst *rqst,
 			struct TCP_Server_Info *server, char *signature,
@@ -255,7 +256,7 @@ int cifs_verify_signature(struct smb_rqs
 /*	cifs_dump_mem("what we think it should be: ",
 		      what_we_think_sig_should_be, 16); */
 
-	if (memcmp(server_response_sig, what_we_think_sig_should_be, 8))
+	if (crypto_memneq(server_response_sig, what_we_think_sig_should_be, 8))
 		return -EACCES;
 	else
 		return 0;
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -31,6 +31,7 @@
 #include <asm/processor.h>
 #include <linux/mempool.h>
 #include <linux/highmem.h>
+#include <crypto/algapi.h>
 #include <crypto/aead.h>
 #include "smb2pdu.h"
 #include "cifsglob.h"
@@ -687,7 +688,8 @@ smb2_verify_signature(struct smb_rqst *r
 	if (rc)
 		return rc;
 
-	if (memcmp(server_response_sig, shdr->Signature, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(server_response_sig, shdr->Signature,
+			  SMB2_SIGNATURE_SIZE)) {
 		cifs_dbg(VFS, "sign fail cmd 0x%x message id 0x%llx\n",
 			shdr->Command, shdr->MessageId);
 		return -EACCES;



