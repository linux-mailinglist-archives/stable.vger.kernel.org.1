Return-Path: <stable+bounces-141126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE06BAAB0D2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9863A944B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5083255B8;
	Tue,  6 May 2025 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3qW7sRl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7375F35F7F0;
	Mon,  5 May 2025 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485249; cv=none; b=QGrGCxzj4Pk5g7AMDKlb6zPIpDCHObjyGprb/gWg8nFIKjSC5WUardEhmcxh31ypu+3zuasZ0pGKcaippxAqhsF+ou/z2pVNH53lb7Ibdw4XuR2WyQ5Uq6J/1BO/c4JD4bTO1MCPYvSvSyOAbgJjnAJDyYFIIxLkozCpZIbkEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485249; c=relaxed/simple;
	bh=9elIbN0ee7YCS6XH2gjwAqOeBDXjnu76EVBthsCsdTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ucIuj0NQBCxk7ytyAO5+Ipb/0wqOyIFT+owx66xgwodJyYN4G3DqHNehe47N2LdPgD+U7+xkdF8vKniZAWmTn7vlj7CW3DHHEuBD+DeYNJnlKaAML9scpqEhxW5D0gSPoApHzcM7Gy3S5PYEDF6YeDhgC53J298pa2rSXSSud60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3qW7sRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2096C4CEED;
	Mon,  5 May 2025 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485249;
	bh=9elIbN0ee7YCS6XH2gjwAqOeBDXjnu76EVBthsCsdTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3qW7sRl877zQmGhgbQRaFT0Wj5zXKxcSLpjpNuazfM8SEKYtDTjahjsBRNlZD3S/
	 HanT3nSVik1BD0K92+KJsgDstO6HS4DGXb1SBzWGpCWoHs0fkXNuc6l+Rl/PQ+jVdN
	 IQa4FSuv1WeULGzvEivNFgFWaOlKHA0aJhZqN23ziV+2sQ++ROSjqhvubtMTUagazm
	 RgHq7uwI/FvmROz/ev6nZMvVTYyqsGacjn14ExD3/dXGJKUmfP5N25mKMZkpWMv7PL
	 IimEQZR4IahBgAc2fplOHgqnVMW8OaDnbMtLf4ct8wycIfIc7mhIgsqDbmVU/5h+Nj
	 plUJ3damoa0mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 235/486] firmware: arm_ffa: Set dma_mask for ffa devices
Date: Mon,  5 May 2025 18:35:11 -0400
Message-Id: <20250505223922.2682012-235-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit cc0aac7ca17e0ea3ca84b552fc79f3e86fd07f53 ]

Set dma_mask for FFA devices, otherwise DMA allocation using the device pointer
lead to following warning:

WARNING: CPU: 1 PID: 1 at kernel/dma/mapping.c:597 dma_alloc_attrs+0xe0/0x124

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Message-Id: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index dfda5ffc14db7..dea3eb741d95d 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -212,6 +212,7 @@ ffa_device_register(const struct ffa_partition_info *part_info,
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
+	dev->dma_mask = &dev->coherent_dma_mask;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->id = id;
-- 
2.39.5


