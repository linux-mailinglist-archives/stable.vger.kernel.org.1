Return-Path: <stable+bounces-203278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 848EDCD8691
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 08:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9046302EF70
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC57930C615;
	Tue, 23 Dec 2025 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M+CLeqrW"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA62D0C8A
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766476139; cv=none; b=gaJS1OPLbaj0MurL1GR7/qV2jlb/Cnpqag6iXyW7lz/7QGh/OcxoOa0QqEkhZrrbJejDqNRNeNQ8PzfmcCrRJlE3FO/rBM/Ry/FCzoiEgEOKeBHpZDCNyBn6AC4+2LHT54GxAZIeyCr5y28EcpW06WBquu8ZhacZ8eeyw9gIvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766476139; c=relaxed/simple;
	bh=rcMivwbpLDSuRQiPAY1S5YZ/j3nyXSgNms8MUEjIS20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E58QccCj97ozrYqxb5kzihEx4FO1Un8/mLSQvDehCHLgLcLv4SoYSDTVOiUpwVx8oLdgNaP+ZWsFDcFI7TjV4SvEsfU1Smv+Tf7CMth/gqlILzKsXibzXA1zcRCxR8+Am3dFWE3oTE4tPrmwg1GCrmZ0riwB3oCNJoYRR9IJwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M+CLeqrW; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5599314b31dso132215e0c.3
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 23:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766476137; x=1767080937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MB5/klIZLcRdn29G8MESTTyUAHutoCNjLyvX9pZr2o=;
        b=Wg0pOB0KT/mHuqGyriiol5iZbvwG9pEKfLSy7ieDX97pIqwwaQI8aI+RpzsTzxbF7T
         KEG/NTciVd8qsWb8PeoDqR6v3MYGsyzCRHgpDhToU3MVhWQR7xp7FmnXPe/4dGKuZCJ/
         ecSC1ESN7cIpXm+pqKKXH+vv6J7pev2uyInj+CeS281QBn6r+whESlSm7yaFCrqqU+M4
         aiIz5vDfZz0LNZrlRgyHNtzpw7JEfgittJCKwREg+KEAijv5u2/ktUKNT91wFevCdksZ
         L2w51fQpN2Lft8zugiF+zyxkzcmgylKkeGw+njRwHfgKjuG5T5+FBs7959yXwqRGX2K2
         YPTw==
X-Gm-Message-State: AOJu0YzcLXzNMnqxXVBgZgWpnBP4b81IiiP2PqcSJXcxc+VMHIU8VPbt
	BXm8AgAQB31OPqUAcrwr/NzxZZ7p9hrFcbkJhd0OA1v8taGAO3324VW1BdjIQi7DKgv/VLfyNkA
	6LutfcNa9NpcKjpg42z3tO+CHeFrgxS6h+tL9T1pA+0+a6c5TakB3TVJmYQPOAsqPt1MkgnNKbT
	RuvNcOYh8l4iyiNclHkmcGnRvvBPROdC0xECo9mSdIXXWOL1l43rq8QkBfD4lJNVAG8gifimz0x
	NidfOwr13hWR/tyiBtaMMvA3az7TYs=
X-Gm-Gg: AY/fxX4p0V9uqwenk11H/Kjt5cQGsorbWGEnfGdVNDFTs+zsWSllYricKH0YU80Z5Fx
	uqfoEXpfhWImDHimPaagVo0LqbWUQkLuwo4pGmfhxFGH3lkpmdLCAK88dR3kqZ5bA3apZSw5Kx9
	y7AHJtN78q6ra0h3k7qKeh++mpmERAPScg60abROuS3/aS5J8VB1Fu0SdlxmhmRsPBtumvgmZR+
	AmvdKvHCJcLHKcXVi4vziZHxUXAWB0Ivzg524YsTtDa786WY/HoI6d2HDm85pOCMcuHJavVaW7W
	8VDkm/AJ2K01USZFa9CAit9I8fMuEclqtQ881stq3s8lBour/tbGy6D3TNPWT/Z2AG1fxF8wzRO
	Xv7u8jOHKIqa5eRV8pjeOfBC2utZRCVUMdKZr5QUypGTVzgSzwn82HZqWu2rCL98Q38m4DFVW+J
	qqCwavmELHXJXU1VS+NQ73ot/B7DTwdlIavN2j9qtNs9XjOK8bUNKCnTZQ8o778Q==
X-Google-Smtp-Source: AGHT+IHdvZiHtC1/Wc80EGhoYV5AVzKkE/OUq41M1cVWV9hLQ+cFrgndi/9tArWjyrTage2IhFgO8Xqz8Dgg
X-Received: by 2002:a67:c999:0:b0:5e5:6656:d495 with SMTP id ada2fe7eead31-5eb1a84d0dcmr1832573137.7.1766476136906;
        Mon, 22 Dec 2025 23:48:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-10.dlp.protect.broadcom.com. [144.49.247.10])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5eb1ac566a6sm1946317137.4.2025.12.22.23.48.55
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 23:48:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8bbb6031cfdso169430285a.1
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 23:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766476135; x=1767080935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9MB5/klIZLcRdn29G8MESTTyUAHutoCNjLyvX9pZr2o=;
        b=M+CLeqrWYxBqkVwKBHuG8+ifXsX9UhvSJLFH8wMCu1RZYW+faBDGYZCsMTmlbqz4Sn
         g2mchP7xChzOJmz3BHPmLpOGlp+CJZJ25LJWU0cQellPgLF4G1K6OhTaQMlDBSAgnYCT
         vXnqeZbU4PYeq5CBHsgkB7yEzu83xEFrpGKNs=
X-Received: by 2002:a05:620a:4588:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c0906edaddmr1517802085a.9.1766476135238;
        Mon, 22 Dec 2025 23:48:55 -0800 (PST)
X-Received: by 2002:a05:620a:4588:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c0906edaddmr1517800785a.9.1766476134826;
        Mon, 22 Dec 2025 23:48:54 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0971ee247sm1018753185a.27.2025.12.22.23.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 23:48:54 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	Bharat.Bhushan@nxp.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y] bus: fsl-mc-bus: fix KASAN use-after-free in fsl_mc_bus_remove()
Date: Tue, 23 Dec 2025 07:46:25 +0000
Message-ID: <20251223074625.1428715-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

commit 928ea98252ad75118950941683893cf904541da9 upstream.

In fsl_mc_bus_remove(), mc->root_mc_bus_dev->mc_io is passed to
fsl_destroy_mc_io(). However, mc->root_mc_bus_dev is already freed in
fsl_mc_device_remove(). Then reference to mc->root_mc_bus_dev->mc_io
triggers KASAN use-after-free. To avoid the use-after-free, keep the
reference to mc->root_mc_bus_dev->mc_io in a local variable and pass to
fsl_destroy_mc_io().

This patch needs rework to apply to kernels older than v5.15.

Fixes: f93627146f0e ("staging: fsl-mc: fix asymmetry in destroy of mc_io")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20220601105159.87752-1-shinichiro.kawasaki@wdc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index dd7791f48537..4f13e7d8101b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1085,14 +1085,14 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 static int fsl_mc_bus_remove(struct platform_device *pdev)
 {
 	struct fsl_mc *mc = platform_get_drvdata(pdev);
+	struct fsl_mc_io *mc_io;
 
 	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
 		return -EINVAL;
 
+	mc_io = mc->root_mc_bus_dev->mc_io;
 	fsl_mc_device_remove(mc->root_mc_bus_dev);
-
-	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
-	mc->root_mc_bus_dev->mc_io = NULL;
+	fsl_destroy_mc_io(mc_io);
 
 	return 0;
 }
-- 
2.43.7


