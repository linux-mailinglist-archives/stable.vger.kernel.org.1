Return-Path: <stable+bounces-225221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEdtObIxs2ntSwAAu9opvQ
	(envelope-from <stable+bounces-225221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:35:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4607127A12C
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C25EB315D25F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8460F36BCE8;
	Thu, 12 Mar 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MZddNuAS"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE8389DED;
	Thu, 12 Mar 2026 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351307; cv=none; b=ez1Cs3D41ocwYLJywbJh2nro2LtQu/QwIcTur8bXs2jHDBi5c/GZBWNSjTewk6sZEqI2UGlJWiF5mX2xUtOfaByc30nblQMF1Kziu3SwCNfdp08o9QbemzafYr6AdCGSFiBgyABYvjZhKQyhzMMzaJEkJb891k28x1fmcl9QGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351307; c=relaxed/simple;
	bh=euqSfLBmeaCLZHWPklfYFKyXd9/jNfEqOAD7t8grm+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=arQLRF32ZR9Jbou7p3IRhAobCESBFznh1zwqcDWdbW+2udjbsG3/z4ZcNj02hagDSbgPdX6R/t667jdoi050veR18azzndaOKs2sJxJ9XFIWWKqbBGUmEk+1akzhP4bA2pzy/X9/GsjbMoga4bizM8car6hB7vaKVZlGkg2cD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MZddNuAS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+mkbco2DYpLYIg6W0/gxXvZBYfuan5aT8DY6Oq7vk00=; b=MZddNuAS3xkEribzB1lOgfihEh
	As2RkO47FakZb9QC92IG5wWB9t2fpkqMt+xm+GD1qRX6WpoBqZzRPLdSRmqbLjGJRmNfG6miy4jbC
	KOVMOg8DKBYU54NMWJLOgOISKfACrwWGPyMPhdigQ/2daWzNfZN2N6BZeaq3KEw2B2TvSnLQF0i6e
	92rQyUJkf4IoO7TUQKVZilortrby1ElMVW8zkPyoTVgbMWN+ywAez+rWRkKgpLP6eL7+j9Q3sPGRx
	bDySr3Uvd5A8hBniO9emE5W13Ij6nWDZMzLWTt3wiX/BY6Rk+LjSDLk0yyQKdui18aG2uVbsdBpl3
	jk5YdsyA==;
Received: from [189.7.87.203] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w0ngH-00ElyQ-Fp; Thu, 12 Mar 2026 22:34:57 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 12 Mar 2026 18:34:24 -0300
Subject: [PATCH v7 2/5] pmdomain: bcm: bcm2835-power: Increase ASB control
 timeout
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
In-Reply-To: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Chema Casanova <jmcasanova@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com, stable@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=euqSfLBmeaCLZHWPklfYFKyXd9/jNfEqOAD7t8grm+8=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpszFr76DUXmoAsyJGsXd/N9TtDJyMFCabSqnNX
 F10hpKOuLSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCabMxawAKCRA/8w6Kdoj6
 qj2DCADAlWnt1dBmx5rDtgiehKMjC3M22RREyzbuB2SQps4zINZ0KPZnq6bmm02OwNmAQ/7ssES
 fqFDltfhMdukQo0X4s5RRzCCoS0AevB+l0EizpPkRPOqETx0OFq4Exm46qbuvvhr2ktYfNMs9Mz
 6lWqTRviy15/peur+G5BZonMhWAydDYwAvnCk+dPPQOnppSs/ZAsHPAbiJXQ4ySjaKPDrRXfFdT
 B6YjxiTQCBgCArL6lFVcHgJcuZydO1HF7TPZPd5qk6RVx40HP9v8HnCiN8Z1BIJotOlZuJmEu8K
 VkIeA5jzXH5lVrDzNSE2vsX+XqxByfZ/hXYb3sa/EofZiBUo
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225221-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,broadcom.com,gmx.net,igalia.com,raspberrypi.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.242];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4607127A12C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bcm2835_asb_control() function uses a tight polling loop to wait
for the ASB bridge to acknowledge a request. During intensive workloads,
this handshake intermittently fails for V3D's master ASB on BCM2711,
resulting in "Failed to disable ASB master for v3d" errors during
runtime PM suspend. As a consequence, the failed power-off leaves V3D in
a broken state, leading to bus faults or system hangs on later accesses.

As the timeout is insufficient in some scenarios, increase the polling
timeout from 1us to 5us, which is still negligible in the context of a
power domain transition. Also, move the start timestamp to after the
MMIO write, as the write latency is counted against the timeout,
reducing the effective wait time for the hardware to respond.

Cc: stable@vger.kernel.org
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Maíra Canal <mcanal@igalia.com>

---
To: Ulf Hansson <ulf.hansson@linaro.org>
To: Ray Jui <rjui@broadcom.com>
To: Scott Branden <sbranden@broadcom.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/pmdomain/bcm/bcm2835-power.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index 0450202bbee2513c9116a36abaa839b460550935..1815eb4ee69b9b672b5e314402f1cc9897c57dcb 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 		break;
 	}
 
-	start = ktime_get_ns();
-
 	/* Enable the module's async AXI bridges. */
 	if (enable) {
 		val = readl(base + reg) & ~ASB_REQ_STOP;
@@ -176,9 +174,10 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 	}
 	writel(PM_PASSWORD | val, base + reg);
 
+	start = ktime_get_ns();
 	while (!!(readl(base + reg) & ASB_ACK) == enable) {
 		cpu_relax();
-		if (ktime_get_ns() - start >= 1000)
+		if (ktime_get_ns() - start >= 5000)
 			return -ETIMEDOUT;
 	}
 

-- 
2.53.0


