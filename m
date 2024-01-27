Return-Path: <stable+bounces-16050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D0483E8D7
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 02:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B422820B9
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CAE3D75;
	Sat, 27 Jan 2024 01:01:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421B6104
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.114.144.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706317316; cv=none; b=ZrVYFZ7J6POw/KqKcTvr1LccHOFsbvrN9FifJxPNQ06Q27emyQHkT//lqOUdU161QCv8fuvaz0o2sazsy5Zp9QBVWpq9YT8TntP2oku2EDDPN3mqDlf0YwoHBjKGJ8GvoYBeTok02xhdpWVb3ItiHfxr+ozi8HVpysT8tYbVYlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706317316; c=relaxed/simple;
	bh=HTqlUd1DvB/oc7FW6Ru/2s2ZnD8Hm6dM0KbYPx84auc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCEcx08XWPgSDPeaFZWo0ZT3Hq9seNy3GmNirJ/1527jkFJFrFw9HQf0VeTpsNr+eqzyfbOG+xBNUuAt2xOHoXtVQ6J9XK+E2s1S+Mh8Xy8EJxf8gIyQiGeNBioMEXFGKBXc7MxKMzYEhW3wxVcReXlBlRg4CUSSULeG49hMfHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au; spf=pass smtp.mailfrom=jsg.id.au; arc=none smtp.client-ip=193.114.144.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsg.id.au
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.43])
	by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id a4f52a22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 27 Jan 2024 12:01:50 +1100 (AEDT)
Received: from largo.jsg.id.au (localhost [127.0.0.1])
	by largo.jsg.id.au (OpenSMTPD) with ESMTP id a0743e9a;
	Sat, 27 Jan 2024 12:01:50 +1100 (AEDT)
From: Jonathan Gray <jsg@jsg.id.au>
To: gregkh@linuxfoundation.org
Cc: mario.limonciello@amd.com,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] Revert "drm/amd: Enable PCIe PME from D3"
Date: Sat, 27 Jan 2024 12:01:50 +1100
Message-Id: <20240127010150.38720-1-jsg@jsg.id.au>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 847e6947afd3c46623172d2eabcfc2481ee8668e.

duplicated a change made in 6.6.5
49227bea27ebcd260f0c94a3055b14bbd8605c5e

Cc: stable@vger.kernel.org # 6.6
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 635b58553583..2c35036e4ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2197,8 +2197,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 		pci_wake_from_d3(pdev, TRUE);
 
-		pci_wake_from_d3(pdev, TRUE);
-
 		/*
 		 * For runpm implemented via BACO, PMFW will handle the
 		 * timing for BACO in and out:
-- 
2.43.0


