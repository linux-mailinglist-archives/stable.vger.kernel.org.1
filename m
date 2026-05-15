Return-Path: <stable+bounces-247789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD0xAHQrB2ppsQIAu9opvQ
	(envelope-from <stable+bounces-247789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:19:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C133551423
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C613034B1D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08414481AB9;
	Fri, 15 May 2026 14:12:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA93CC7C5;
	Fri, 15 May 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854377; cv=none; b=dqWIFscI6zjI9nIeVUCWbcPxrqRg2hF/3g9pa6HTus4YU8vUILAR5CFiYCyj4rS4HsCKSs4qd2wAE693y37FQNS5w5RxQI9wZpxGL1YJJvhYHsECNgNzV0j7AUgZybyCdLFiS/YeFxUcagI0YJ0bS4WHcWEchT7ZQ2B7af/xknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854377; c=relaxed/simple;
	bh=G7X4JCRz268Rl2Qhi1tq+hbnRYpNYtxE67LEFk1e7bU=;
	h=From:Date:Subject:To:Cc:Message-Id; b=cDQF9J9UxONYKVoHia2AK+BtVEr6xXIPQG7tL075/FvnaZheW2tzemsskKLYdWf5HU4pC6N4U9drqERewlkVBD/CODuPhvPvVVCNC1TGp7fpgtLd+/VaxjA1LKLU7SE3WFUFuhAyTdW8XmPm5WZEJnMu3SgEk0+rQmS5PxhVLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id D0DA635B;
	Fri, 15 May 2026 16:12:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BA651602DFAC; Fri, 15 May 2026 16:12:47 +0200 (CEST)
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 15 May 2026 16:12:47 +0200
Subject: [PATCH 5.15-stable] lib/crypto: mpi: Fix integer underflow in
 mpi_read_raw_from_sgl()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, Ignat Korchagin <ignat@linux.win>, Jarkko Sakkinen <jarkko@kernel.org>, Yiming Qian <yimingqian591@gmail.com>
Message-Id: <20260515141247.BA651602DFAC@h08.hostsharing.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 5C133551423
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247789-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.win,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h08.hostsharing.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.win:email]
X-Rspamd-Action: no action

commit 8c2f1288250a90a4b5cabed5d888d7e3aeed4035 upstream.

Yiming reports an integer underflow in mpi_read_raw_from_sgl() when
subtracting "lzeros" from the unsigned "nbytes".

For this to happen, the scatterlist "sgl" needs to occupy more bytes
than the "nbytes" parameter and the first "nbytes + 1" bytes of the
scatterlist must be zero.  Under these conditions, the while loop
iterating over the scatterlist will count more zeroes than "nbytes",
subtract the number of zeroes from "nbytes" and cause the underflow.

When commit 2d4d1eea540b ("lib/mpi: Add mpi sgl helpers") originally
introduced the bug, it couldn't be triggered because all callers of
mpi_read_raw_from_sgl() passed a scatterlist whose length was equal to
"nbytes".

However since commit 63ba4d67594a ("KEYS: asymmetric: Use new crypto
interface without scatterlists"), the underflow can now actually be
triggered.  When invoking a KEYCTL_PKEY_ENCRYPT system call with a
larger "out_len" than "in_len" and filling the "in" buffer with zeroes,
crypto_akcipher_sync_prep() will create an all-zero scatterlist used for
both the "src" and "dst" member of struct akcipher_request and thereby
fulfil the conditions to trigger the bug:

  sys_keyctl()
    keyctl_pkey_e_d_s()
      asymmetric_key_eds_op()
        software_key_eds_op()
          crypto_akcipher_sync_encrypt()
            crypto_akcipher_sync_prep()
              crypto_akcipher_encrypt()
                rsa_enc()
                  mpi_read_raw_from_sgl()

To the user this will be visible as a DoS as the kernel spins forever,
causing soft lockup splats as a side effect.

Fix it.

Reported-by: Yiming Qian <yimingqian591@gmail.com> # off-list
Fixes: 2d4d1eea540b ("lib/mpi: Add mpi sgl helpers")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.4+
Reviewed-by: Ignat Korchagin <ignat@linux.win>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/59eca92ff4f87e2081777f1423a0efaaadcfdb39.1776003111.git.lukas@wunner.de
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/mpi/mpicoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
index 3cb6bd148fa9..b6efe618e614 100644
--- a/lib/mpi/mpicoder.c
+++ b/lib/mpi/mpicoder.c
@@ -453,7 +453,7 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
 	lzeros = 0;
 	len = 0;
 	while (nbytes > 0) {
-		while (len && !*buff) {
+		while (len && !*buff && lzeros < nbytes) {
 			lzeros++;
 			len--;
 			buff++;
-- 
2.51.0


