Return-Path: <stable+bounces-16049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364283E8D6
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 02:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C343A2817AD
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4415A3D75;
	Sat, 27 Jan 2024 01:00:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32D8C09
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.114.144.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706317217; cv=none; b=KHx+mEJPWfm8j48MwZXjwJVoOWVCONwn0QV+qJmh6tmKlMMTrzBDVQBrVnWxmLi1thTfAGl0GUpDcosqowh+Aps/U50kXdtqWEwEAMFyhqpJCswutAudbF1BRYQtsZ8phztmeqmJmyd8JJ0oDKXIfAs4w6IcCZWibQmws38hSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706317217; c=relaxed/simple;
	bh=ZZP3CNm9A2Vq05O9AzFYSTa7ux7QW9zl3hTs/qmxnmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XHgz52QPhLuFvD9ILo/YBDTf/8uH+74YAJGuIoLAQmsA3wYCtcD32qaeKR475K+fV3Vk2fRs2oZ8mwLMZvwcbRo1dTxgcpWuIGXT7iLpmkgCivzfNnf3L2ATaHwjJBwwy5VLDknZZatwmI8fel3Wj+TjuLdNUJIGmNUVecWLx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au; spf=pass smtp.mailfrom=jsg.id.au; arc=none smtp.client-ip=193.114.144.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsg.id.au
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.43])
	by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id 2b8984c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 27 Jan 2024 12:00:08 +1100 (AEDT)
Received: from largo.jsg.id.au (localhost [127.0.0.1])
	by largo.jsg.id.au (OpenSMTPD) with ESMTP id bba1b8e5;
	Sat, 27 Jan 2024 12:00:07 +1100 (AEDT)
From: Jonathan Gray <jsg@jsg.id.au>
To: gregkh@linuxfoundation.org
Cc: mario.limonciello@amd.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] Revert "drm/amd: Enable PCIe PME from D3"
Date: Sat, 27 Jan 2024 12:00:07 +1100
Message-Id: <20240127010007.77686-1-jsg@jsg.id.au>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 0c8d252d0a20a412ec30859afef6393aecfdd3cd.

duplicated a change made in 6.1.66
c6088429630048661e480ed28590e69a48c102d6

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a8e1f2cfe12d..b9983ca99eb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2202,8 +2202,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 		pci_wake_from_d3(pdev, TRUE);
 
-		pci_wake_from_d3(pdev, TRUE);
-
 		/*
 		 * For runpm implemented via BACO, PMFW will handle the
 		 * timing for BACO in and out:
-- 
2.43.0


