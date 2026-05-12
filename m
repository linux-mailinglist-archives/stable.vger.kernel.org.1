Return-Path: <stable+bounces-245969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEX7FiNpA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-245969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:53:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6152643B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142C9311567C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E2B4C0433;
	Tue, 12 May 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vyw1knPL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B794C9576;
	Tue, 12 May 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608017; cv=none; b=fdglcBm9BHQ8l2r8yS/bSeAWDg5PRaqh23WvqWSFJ3LtaZ6qGShRNI2Mr6NnE3B7UNcKqVwAgoXh78oiEL1K1hWxaeGlQzhKhcDdqARsFBQtp6ltzCFxQ/SEJkE8KsA06wQWNaPv/jkur7Zg589q39E3kAPspgG8Cp3TfiDiAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608017; c=relaxed/simple;
	bh=EM8KcX0/Kak9fZDcCU/pNhVtBuaiRBvhJ3suGTI/Bco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pe6jp34BkjcIyY7RBiSq3ooUvOazTTNK8IybeunU7hfN3sfbHtRFBHD+uLMaHsFl6vnfuusBeQPh4FWQabuQWy9Hn3BCDiEIovKRdHJ2YMoepBKj1Q3HETJQvkqxMzhZPJPcGDfyit+hwIO09K3qX5cOHw9k7cGZtfbizEIuWDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vyw1knPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581B9C2BD00;
	Tue, 12 May 2026 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608016;
	bh=EM8KcX0/Kak9fZDcCU/pNhVtBuaiRBvhJ3suGTI/Bco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vyw1knPLGK1l9/NTIek1PG87PgaAYI8ouymLHTjSa5Mtt2TAJox+5GT1Grdt25LMB
	 Nb24HOSkvaUyyjl+Vqw9EPBsphcDjJRe0McFaG1YIQrlo34+UUN4kjEsdNEuK587UT
	 B55xXXktjVtqbl2EipW0cryMfBo8O8G2fEzw0AWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: [PATCH 6.12 124/206] lib/crypto: mpi: Fix integer underflow in mpi_read_raw_from_sgl()
Date: Tue, 12 May 2026 19:39:36 +0200
Message-ID: <20260512173935.482141416@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C6D6152643B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wunner.de,linux.win,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245969-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/crypto/mpi/mpicoder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/crypto/mpi/mpicoder.c
+++ b/lib/crypto/mpi/mpicoder.c
@@ -346,7 +346,7 @@ MPI mpi_read_raw_from_sgl(struct scatter
 	lzeros = 0;
 	len = 0;
 	while (nbytes > 0) {
-		while (len && !*buff) {
+		while (len && !*buff && lzeros < nbytes) {
 			lzeros++;
 			len--;
 			buff++;



