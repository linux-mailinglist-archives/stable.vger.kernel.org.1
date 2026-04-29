Return-Path: <stable+bounces-241889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOasEsgE8mmsmgEAu9opvQ
	(envelope-from <stable+bounces-241889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:16:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E76A6494A53
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DDD13068F7A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688393FBED2;
	Wed, 29 Apr 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OM2qgAVG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7673FBEBD
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468319; cv=none; b=tGwTsoy1WdytrWUoDhLK7mjbpz8Cw1fvfDW67Obdtk3IBLMNO0spF4IVgMa+o7F6vTRBgBrReFI5b3gRCMz3vUMR5ME/s2iNEE3MshC6GnSsoexkONRA1vEzKKnD1ttVfwhqi2GgYwtS3Dy7o+smwdklv7TMQgv7I4qyW42PDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468319; c=relaxed/simple;
	bh=q1S+03aGlcH6n28TvbZ1L4it7+K5AeVq24YPPGzZ2I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IoNl51kARXj3ptZlhqqPy7jQXTyY/yub8QgmDlKYn+5q+MVRKOtiFy7wwZOU9/Jurow+t9LUJtqhmD7zl6O2PwFw/LnUTofSzomfbYbbbDRXAUluRJ7iNwlpQpJ+o0FoAEIHnrrUqn2xv4bxIK1T4YnhRF1gW9uRpRqkfVBdLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OM2qgAVG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-448528f4e69so307369f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777468315; x=1778073115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JCJJgoNCZ5gGQkcl+YQnJFPiiEiR515Ip28lGR0OcA=;
        b=OM2qgAVGiXx6gBYTnLqyewl/sVYxfsEPzJHFvxfy2GF/peKZUUXJHNn5d2Io6JJ7GF
         zOor7AXV/ARNROons4cq6GmKhGS12c57A92AVyROFnTEJMDUh8i7bGp0SMZRCZfGIyYT
         7NIFeum0effEdGdemIPxH6nSWNA1nJBk66tkOTGp0F0wPKYHRfV0wj1MXr3t23h0wdSa
         YiI33hxYSe6ud32eZj8JdhPkDNfEhaamYYOHtELKyssVhxF1RmOtJr1ht3lDoC9A3Ixu
         1Ul5jR4TvgYbHn3pUPypsbmemQnLq1EOuRruUhzdhMnxtNc9LTKv3wRef7AcUbI/dZJm
         1MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468315; x=1778073115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7JCJJgoNCZ5gGQkcl+YQnJFPiiEiR515Ip28lGR0OcA=;
        b=bvOD/SbPULdIwUsfhmYGt8saYiGZYCX3Kfq9wu+mEPM7cqKIZlY36KFEivyIoifTUR
         wKO7g2orvkEKwdCGSEXVHKq7mqgcQF/48zuly2L2PwGTSudq8G533pyb+aNcBmSuIEsZ
         UHgq2EOAzwYMNgdE3DXs4IB0HtpLLlMNsTwriuWYrD0Ol97wHSpKpKZPiejh9RSQvvtf
         +qscoQ4KNEbN7BSdT9H5XVO+fZaYsTeO6bHueyu//Uk0PSpjXPN94nIrzi86p3vp3xUn
         splEPwe0OjNYKXmnotxrQdzxtZ4rAXWKiXwJfdogAf0N3sbrwDs+Fa8cYc6GS37j6Hmb
         VwXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lz1YJvzNYTCYyf2dP/18sPFKrWr2u24wHL82yhfaD/trKaXg9jwFZarG9PkyEq0vWH9tNtgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFb23QJr2Znml/niNGIfeK0ZDZaKPjA8GdhStWAUFGprDWdYOa
	eZhb9ruKu0f9w/xE6UpA9Z53Gzwc0xi2IGj4AzNDBFqhHzfDEmEaqD0tMHZnsVRFFFc=
X-Gm-Gg: AeBDievUux9kBBTHzUIMj1U7OmG33mrxvVLrauidRnD5qP0PTbmr+g8jcbNix0SVTGh
	vjc0cZrlLzAkW6fJ6o+S3x+QzbHvsypUjJ4rsSvF+dTxsRJgDr1uppTVVlrTgV+cNCmz7Wrl9Zp
	ioRyEu9B2GiTwZ/Z2B8hHGdvcCJTiD4uMLbdapWk3z+2Le5XU8Hk/p/IrIvVZWaVzBrt2xXcFSB
	avvqhnQwgk7O/KTDIaDg3BX5nXoBWXmTLWfobLnUpqRZsBzm4QOh0O8ODVkWeZ8675uvdsCOXCh
	86qTdJpTqDOS0HBLmQx03EWtCLdH2mfIIzNeQ9kz6+mrZuZfG7jyxNgWJVfpLNpBY6MEpC7CSFC
	MeuDGWZ68zo3wxG1AAp0GTwkWWSqp+RiFGXFlgrxWN/N8CDhQUsgKBGyPg7VazZKNThRafN87vf
	hCwRvKE74UollJ+hv8sA29kcGsCDKKsEWUFoicsSwrYKRIVVimhFKAJoibsXoyzhrVD8YQaNz2j
	FWtck49xSEwV/jFsw==
X-Received: by 2002:a5d:5f83:0:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-446496d7958mr13247989f8f.26.1777468314477;
        Wed, 29 Apr 2026 06:11:54 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca67b9sm4752867f8f.34.2026.04.29.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:11:53 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 29 Apr 2026 13:11:53 +0000
Subject: [PATCH v3 4/6] firmware: samsung: acpm: Validate SRAM shared
 memory and queue pointers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-acpm-fixes-sashiko-reports-v3-4-47cf74ab09ad@linaro.org>
References: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
In-Reply-To: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468311; l=3318;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=q1S+03aGlcH6n28TvbZ1L4it7+K5AeVq24YPPGzZ2I0=;
 b=Vg9Aq4hjk+3SdpYiyCFYei12SF/+xSvtM3lyisaToANK/5u1mqS2/n17ihJi1MyptTCu7yyiN
 oSXoNoWnjfQBZOF7NiENy941dWjDk3deXwUbalPXuFT9pK5A5euN62h
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: E76A6494A53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241889-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]

Sashiko identified multiple missing validation checks [1].

The ACPM driver reads queue pointers (rx_front, rx_rear, tx_front) and
configuration parameters (qlen) directly from shared SRAM without
verifying their validity. Relying blindly on firmware-provided values
leaves the kernel vulnerable to crashes or infinite loops if the
firmware misbehaves.

This patch fixes three specific vulnerabilities:

1. RX path infinite loop and OOB read: The rear pointer ('i') is used
   to calculate the MMIO address before the modulo operation is applied.
   If 'rx_front' or 'i' are >= achan->qlen, the driver performs an
   out-of-bounds read. Furthermore, because 'i' is mathematically capped
   by the modulo operator, if 'rx_front' is >= qlen, 'i' will never
   equal 'rx_front', causing the CPU to spin forever and deadlock the
   polling thread.
2. TX path out-of-bounds: 'tx_front' is used to calculate queue indices.
   If it exceeds the queue length, it causes invalid state tracking and
   out-of-bounds memory accesses during __iowrite32_copy().
3. Divide-by-zero panics: 'qlen' is read from SRAM during channel
   initialization. If 'qlen' is 0, any subsequent modulo operations
   (% achan->qlen) will trigger a divide-by-zero kernel panic.

Protect the kernel by strictly validating the initialization parameters
and MMIO queue offsets immediately after reading them.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index bd0d48e9d157..e4d8d1120192 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -230,6 +230,13 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 	rx_front = readl(achan->rx.front);
 	i = readl(achan->rx.rear);
 
+	if (rx_front >= achan->qlen || i >= achan->qlen) {
+		dev_err(achan->acpm->dev,
+			"Invalid RX queue pointers from firmware: front=%u rear=%u qlen=%u\n",
+			rx_front, i, achan->qlen);
+		return -EIO;
+	}
+
 	tx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, xfer->txd[0]);
 
 	if (i == rx_front) {
@@ -439,6 +446,14 @@ int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 
 	scoped_guard(mutex, &achan->tx_lock) {
 		tx_front = readl(achan->tx.front);
+
+		if (tx_front >= achan->qlen) {
+			dev_err(achan->acpm->dev,
+				"Invalid TX front pointer from firmware: %u (qlen: %u)\n",
+				tx_front, achan->qlen);
+			return -EIO;
+		}
+
 		idx = (tx_front + 1) % achan->qlen;
 
 		ret = acpm_wait_for_queue_slots(achan, idx);
@@ -574,6 +589,12 @@ static int acpm_channels_init(struct acpm_info *acpm)
 
 		acpm_chan_shmem_get_params(achan, chan_shmem);
 
+		if (!achan->qlen) {
+			dev_err(dev, "Invalid shared memory parameters for channel %d: qlen=%u\n",
+				i, achan->qlen);
+			return -EIO;
+		}
+
 		ret = acpm_achan_alloc_cmds(achan);
 		if (ret)
 			return ret;

-- 
2.54.0.545.g6539524ca2-goog


