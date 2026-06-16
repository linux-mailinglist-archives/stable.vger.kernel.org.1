Return-Path: <stable+bounces-266044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LYCqLXSVMWqpnQUAu9opvQ
	(envelope-from <stable+bounces-266044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:27:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE24B69420A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:26:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DDjOIGue;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266044-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266044-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42B8830243E2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3481B477E57;
	Tue, 16 Jun 2026 18:26:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175D477986;
	Tue, 16 Jun 2026 18:26:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634366; cv=none; b=pSnr7lvr9XeDnNMpn3GfF125GJeo48CwZ9ihE9mMGs8hOiBxJoc1hikduZPkcWnonCvlOEay0hqwhMrIU5YLdKlJW8YYxU005KFANDINlZrtUJ5vtX35Nil1NFq/Ji8GJfQbl0KNgM9LlyWyoPnfYDylGoFqroUAo0angvYcm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634366; c=relaxed/simple;
	bh=TkieGkAVzzF+NWWarRr6AsehzUIsUEhpSb/+v0ddTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pvkr+TQMMtwFRBLP3TRjl/Kgg4t3wNr6pyuZ0U6VMHO33MrY2c/X6Do6hr3R6ESTMmdNhb6IeLvwGHGMFY7EdeQxgheebUQB9eYyBkD+aCBk1+WtTQaglUTq2kj8BIIV/v6RAPNszvSZPDzidmGkqQB5VcUMakSRLrgyAAL+CmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DDjOIGue; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089881F000E9;
	Tue, 16 Jun 2026 18:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634364;
	bh=i8U7jsS+PX4rro+JC8TfiikaSFz/bHhTJnWGar7iM5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDjOIGueiMlWpvYB5CDegNU0xGmgMqVTra7HFD4Or0UBRHCm8Hjxth45IkdJBdOtb
	 /sApFOBV0V+gi/ZFhyLfEUzgylA0TmaVPENo2+awtWzoUerxMwU1sFH22SlMOFpMys
	 JNn1thcMafuo4VkSc8UFotOxtdEkRFc++vG8RNi4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: [PATCH 5.15 250/411] lib/crypto: mpi: Fix integer underflow in mpi_read_raw_from_sgl()
Date: Tue, 16 Jun 2026 20:28:08 +0530
Message-ID: <20260616145114.254670132@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wunner.de,linux.win,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-266044-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lukas@wunner.de,m:ignat@linux.win,m:jarkko@kernel.org,m:ebiggers@kernel.org,m:yimingqian591@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,wunner.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE24B69420A

5.15-stable review patch.  If anyone has any objections, please let me know.

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
 lib/mpi/mpicoder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/mpi/mpicoder.c
+++ b/lib/mpi/mpicoder.c
@@ -453,7 +453,7 @@ MPI mpi_read_raw_from_sgl(struct scatter
 	lzeros = 0;
 	len = 0;
 	while (nbytes > 0) {
-		while (len && !*buff) {
+		while (len && !*buff && lzeros < nbytes) {
 			lzeros++;
 			len--;
 			buff++;



