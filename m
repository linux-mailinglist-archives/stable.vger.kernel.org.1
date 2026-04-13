Return-Path: <stable+bounces-237408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEnUOv8g3WneaAkAu9opvQ
	(envelope-from <stable+bounces-237408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:59:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297D3F071D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B9063040555
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2E03264F2;
	Mon, 13 Apr 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dP30lIKB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C6325490;
	Mon, 13 Apr 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099378; cv=none; b=LSGF14rfDedgU0NXhL4FHX1w+ozU1lSTQcqUT/XRvNqy/LWQdW89Y9CmaBaeK0e+hI9U0c5zEV8ZAGlsMnJ0GUDu2WAGGT9fLz1Ds9Gm/nT+Gsh1sHP1gZN4f0cHAgBTZVwH6o/s6QJbtOcMamRsQsPu8dhAqwMvHXR1z30VRPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099378; c=relaxed/simple;
	bh=5vVsgnxo87IuJvSlgP6OpDuGVHBRdBv74GVngPrB9EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzTbAlN+HV1P7XnKOdUhIWA0KLlDkAaMHkxNYCRX+WCFURPRytiu4lcqoWF2X6sNC47wULcLyBEow6pxqTLiQav7h7vmH5I2EK7vbaN4ROEBlfeKQbhVEO1fNFXEU9YrmIxIQUWZl+TtvM1yGc5Ee7JmOXhPbM/Ir7LLpHNqdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dP30lIKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C62C2BCAF;
	Mon, 13 Apr 2026 16:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099378;
	bh=5vVsgnxo87IuJvSlgP6OpDuGVHBRdBv74GVngPrB9EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dP30lIKB2YBJe2JguWCeoIzwkPwelXRXe5M6A0OBAE0CQ3rPeDXl3kft55H7fCOeN
	 pvm7OlrwKRPES0733igp0C65pIrEhZYNiEwGX+aiY7GupeRotP7SAqReRYDjz0ibE5
	 oWKif3ZWOBkhdu019Umnf9+ZWHo/dWPpxSdFReyU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 285/491] ASoC: Intel: catpt: Fix the device initialization
Date: Mon, 13 Apr 2026 17:58:50 +0200
Message-ID: <20260413155829.714600433@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237408-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 9297D3F071D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 5a184f1cb43a8e035251c635f5c47da5dc3e3049 ]

The DMA mask shall be coerced before any buffer allocations for the
device are done.  At the same time explain why DMA mask of 31 bits is
used in the first place.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: 7a10b66a5df9 ("ASoC: Intel: catpt: Device driver lifecycle")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260320101217.1243688-1-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/catpt/device.c | 10 +++++++++-
 sound/soc/intel/catpt/dsp.c    |  3 ---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/catpt/device.c b/sound/soc/intel/catpt/device.c
index a701799597956..db67509f051ad 100644
--- a/sound/soc/intel/catpt/device.c
+++ b/sound/soc/intel/catpt/device.c
@@ -263,7 +263,15 @@ static int catpt_acpi_probe(struct platform_device *pdev)
 	if (IS_ERR(cdev->pci_ba))
 		return PTR_ERR(cdev->pci_ba);
 
-	/* alloc buffer for storing DRAM context during dx transitions */
+	/*
+	 * As per design HOST is responsible for preserving firmware's runtime
+	 * context during D0 -> D3 -> D0 transitions.  Addresses used for DMA
+	 * to/from HOST memory shall be outside the reserved range of 0xFFFxxxxx.
+	 */
+	ret = dma_coerce_mask_and_coherent(cdev->dev, DMA_BIT_MASK(31));
+	if (ret)
+		return ret;
+
 	cdev->dxbuf_vaddr = dmam_alloc_coherent(dev, catpt_dram_size(cdev),
 						&cdev->dxbuf_paddr, GFP_KERNEL);
 	if (!cdev->dxbuf_vaddr)
diff --git a/sound/soc/intel/catpt/dsp.c b/sound/soc/intel/catpt/dsp.c
index 38a92bbc1ed56..2c67d2d35cdae 100644
--- a/sound/soc/intel/catpt/dsp.c
+++ b/sound/soc/intel/catpt/dsp.c
@@ -125,9 +125,6 @@ int catpt_dmac_probe(struct catpt_dev *cdev)
 	dmac->dev = cdev->dev;
 	dmac->irq = cdev->irq;
 
-	ret = dma_coerce_mask_and_coherent(cdev->dev, DMA_BIT_MASK(31));
-	if (ret)
-		return ret;
 	/*
 	 * Caller is responsible for putting device in D0 to allow
 	 * for I/O and memory access before probing DW.
-- 
2.53.0




