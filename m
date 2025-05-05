Return-Path: <stable+bounces-141632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4AEAAB51F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCC63ACE05
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE10488CB8;
	Tue,  6 May 2025 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeJvgyXQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90A2F4F53;
	Mon,  5 May 2025 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486962; cv=none; b=KRZ9JZcSHS7hbVZkKBgVjGPFLAR76qhaZ4AyIvZ9y/306FWw466hUNNz2ksI6NbhWc/aRM5f4M+3rrX90XxLygqdNd146ZAtBvYRixMNZMzItD96zvrsmq7onSCY/tUw5hAmQ5zjVbn9y/4g1UTrczV3ynnIW0sIYf5ar3kbfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486962; c=relaxed/simple;
	bh=ObOcuQ7uehgIs7wkMXNdM1MgdTP7bxAc1+4SriNNzwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCnaEDldlDqnb7bxd+BxeMy8p6N21dvt1skheWQmxItEonVns4LuqRbZ4/2JG6U1nV6rMZjESQGprQzALvRjrhh3Xeo8QOPRRwBZ5VW5NJMCgCn8QekL+9puTvR4IWy+TmVI4aPFNQH8osf8FjuQBZH22YwwxBTijBhCWZ1rbd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeJvgyXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DB9C4CEF5;
	Mon,  5 May 2025 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486961;
	bh=ObOcuQ7uehgIs7wkMXNdM1MgdTP7bxAc1+4SriNNzwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VeJvgyXQkTiajGMPSbj3AcmnY4iYsgWxfd8kFW+5jzCOZ6p659d+rek9Aszy6bMx4
	 mdSkWGIQSuigMFYqjVt6S+xbPoWr74Xt4pKccjrwT/hWQMs7uon7W8jD4D6pNTniS0
	 cx4W6ERbtqcZKT8q2fo6TI4hqLxaJUY4frfdXoOIuNcaWMyZXiYNu3od8jmj8v3zEW
	 pS/VCKLt/NuT5q4TXfBtVtg79thbsiPE/Mr5Mg4CQUlvMUBAV0rHnIqz3x5QBdXE7a
	 pxoapd/ehA/cLsyhf3Gd7kV7O6hnijEB90RC38wQHmdlMUqlCSX3Aw5IZSrjpVD3+G
	 XtVxp7C5JG7MQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 081/153] firmware: arm_ffa: Set dma_mask for ffa devices
Date: Mon,  5 May 2025 19:12:08 -0400
Message-Id: <20250505231320.2695319-81-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index f79ba6f733ba4..27820a59ce25e 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -190,6 +190,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
+	dev->dma_mask = &dev->coherent_dma_mask;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->id = id;
-- 
2.39.5


