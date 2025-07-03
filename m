Return-Path: <stable+bounces-160120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2D0AF81BF
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 22:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43C458544B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D129029B20D;
	Thu,  3 Jul 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nIXl5Wqh"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72F29346E;
	Thu,  3 Jul 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751573230; cv=none; b=uZBkP7spMx1H6/O5e5GsV5Ne/8hJ8MxGQV4bQGeDJ/cFDM6xuZiReh/Z03JgKEoTXf12cRMZa9dn6O6Ab2EhpOIcyCeGAj0mnNQa+o5ZF2Xb/q5IPkggGt/ixu1B7H3atQX1Q85mhQnOv9xOjvhcsprilN4fa+IeebX6Ktd7ReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751573230; c=relaxed/simple;
	bh=P8X9lUX6YXwb4ldvN8doG8ZPZ/TXdmcB5s+r7njzT+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpF6yEnHSM63LE6jndp4kK3E43AQPDfhNdDD4x6TGR9TKHPAW07//Nxmeg3U8qnW8xYCVqj4VNADKKBVZxuEQg6tbKW4rvuz3PWz1Ir9rFD8SBO7yYAj9W1R6BpuCIbyzGdA+CVmEeUPBywdzp0KAsqy3jkQITOHSKrVQT6j0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nIXl5Wqh; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751573226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SlVMuoxK+UaJh1Cl0Sk2GerD7Dh9W8QH+OqcnTRuvpU=;
	b=nIXl5Wqhm2RDeHwATLWjn55F8ANSq8FfIjWEzGLFA1aKwdqNzBLqtgJSglDMQaNTfYgXgl
	2CXhfNykc3r+2xXiXOf+S57b3jg9C8fWqeVLP9xlWm2xrjnFLIqgIgwUiQ3bL1NIfZcIRz
	lPI0RUjjLCtuHuS7+A5YPRRzqW4Wn2g=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ad1816a: Fix potential NULL pointer deref in snd_card_ad1816a_pnp()
Date: Thu,  3 Jul 2025 22:06:13 +0200
Message-ID: <20250703200616.304309-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use pr_warn() instead of dev_warn() when 'pdev' is NULL to avoid a
potential NULL pointer dereference.

Cc: stable@vger.kernel.org
Fixes: 20869176d7a7 ("ALSA: ad1816a: Use standard print API")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/isa/ad1816a/ad1816a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 99006dc4777e..5c9e2d41d900 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -98,7 +98,7 @@ static int snd_card_ad1816a_pnp(int dev, struct pnp_card_link *card,
 	pdev = pnp_request_card_device(card, id->devs[1].id, NULL);
 	if (pdev == NULL) {
 		mpu_port[dev] = -1;
-		dev_warn(&pdev->dev, "MPU401 device busy, skipping.\n");
+		pr_warn("MPU401 device busy, skipping.\n");
 		return 0;
 	}
 
-- 
2.50.0


