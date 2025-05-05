Return-Path: <stable+bounces-141398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C33AAB6DC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A951BA3A9F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43921ABBC;
	Tue,  6 May 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUTCbBXp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595C38B4E5;
	Mon,  5 May 2025 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486077; cv=none; b=XNvYsFX6vgkMMivoTSDy1poIeWXa1K+QN7KOZpvhjm6GKAXVwdgHpGxEi56Mp2EKEGS4TgNq31z33d+T/TlMixyW49uDK9l174DofGU1v1CmCYp5JbWD82n2O7L9t6G3yVPqAc1E4ciFQsY/u6KHafMkfVaJNGbOjfOLPrCnE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486077; c=relaxed/simple;
	bh=nRXZWQ0Huk6GYkFIlGU5Ccxqrz5dQqiUNH2qI+MsMxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttHQkia2z2hNCh32WoI9Y2cHNk0mWfVkJLDwjw7QuVGxMvLJbmlPhTf2BEr0nbEVmATJ/pinBYrBjDEqkvCy5q3wnX7b54brvoZ1uxX/08pcsrDuJH3d3PenLBUNp/2ZPgwQt6nUnzODWlYY3Q6cJE+9x8/XZUajKUCHAcJp45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUTCbBXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFCBC4CEEF;
	Mon,  5 May 2025 23:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486077;
	bh=nRXZWQ0Huk6GYkFIlGU5Ccxqrz5dQqiUNH2qI+MsMxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUTCbBXp+yJscuHBWJEEVvI3Yd02XMDapCEm8Gu8u5EA42xMHdGbz545b10n2rZMI
	 Zflvh+npbOe1fGxEn2DeADrPOX4/p2aL0Upkgbu+O/ZEyHPiXSqEnZ5gJ9v1Bszdb6
	 VeY7D4TPlBDGMZv49fnJL5Zc945iaTMLabGpxds0z88WP9cxuFXal35nzTDjGhvG2N
	 Xg7bHIaPQOJ0Idf6FLnVr6KroufIFku8spEv1O/6pKHC7u/JpKix8HqRFfSW5t5Q3y
	 cHXCC6800OSuyAIcY8UZviNfK1JWc3tzwD6ecm+j0iGXw/6VO0baxBHOKrkX4skjzj
	 pt++mEV7ofLXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 143/294] firmware: arm_ffa: Set dma_mask for ffa devices
Date: Mon,  5 May 2025 18:54:03 -0400
Message-Id: <20250505225634.2688578-143-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 7865438b36960..d885e1381072a 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -191,6 +191,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
+	dev->dma_mask = &dev->coherent_dma_mask;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->id = id;
-- 
2.39.5


