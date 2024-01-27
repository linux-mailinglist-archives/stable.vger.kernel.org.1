Return-Path: <stable+bounces-16051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41183E8D8
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 02:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540F41C20D86
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABABE3D75;
	Sat, 27 Jan 2024 01:04:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8064680
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.114.144.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706317445; cv=none; b=ciW8PkL6+MITm5HqMG0PDj0KHhdyofILfkiu1hTVLMxed8z1dEFCvSUbHnr4w3vKrzCRuo5WheV5hd5ilUub4dkFWiMNAahCeWPhwq3taEui5uQ3fbVhKgXV6mIL7aPYZM435KPnZYhMz9KkKEq3KXbENU6w1FVUOPb1GmtLpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706317445; c=relaxed/simple;
	bh=E3LeCSSeW3ijrVXeMiMApWnAp/zgSqpgxK2XENGilLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XkP2q6+f5dCZJTcd5hdDJCPnBdajkJWGREEpxVXqlD0l3rEAnZ7kdolnR+C7IiNkcJrW0/M38XdVzvWFUSSgjb8BTx/9Mywva/SNiwcQunu5HzztnqaDXxA9xXWQBjT7FJH/01Q1igerF9iYZs8HQhg25nbCdj4S9ntY5gItA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au; spf=pass smtp.mailfrom=jsg.id.au; arc=none smtp.client-ip=193.114.144.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsg.id.au
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.43])
	by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id 022e812b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 27 Jan 2024 12:03:59 +1100 (AEDT)
Received: from largo.jsg.id.au (localhost [127.0.0.1])
	by largo.jsg.id.au (OpenSMTPD) with ESMTP id 9d6aea8a;
	Sat, 27 Jan 2024 12:03:59 +1100 (AEDT)
From: Jonathan Gray <jsg@jsg.id.au>
To: gregkh@linuxfoundation.org
Cc: mario.limonciello@amd.com,
	stable@vger.kernel.org
Subject: [PATCH 6.7.y] Revert "drm/amd: Enable PCIe PME from D3"
Date: Sat, 27 Jan 2024 12:03:59 +1100
Message-Id: <20240127010359.10723-1-jsg@jsg.id.au>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 05f7a3475af0faa8bf77f8637c4a40349db4f78f.

duplicated a change made in 6.7
6967741d26c87300a51b5e50d4acd104bc1a9759

Cc: stable@vger.kernel.org # 6.7
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f4174eebe993..c0e8e030b96f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2265,8 +2265,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 		pci_wake_from_d3(pdev, TRUE);
 
-		pci_wake_from_d3(pdev, TRUE);
-
 		/*
 		 * For runpm implemented via BACO, PMFW will handle the
 		 * timing for BACO in and out:
-- 
2.43.0


