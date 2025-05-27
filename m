Return-Path: <stable+bounces-147408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DFDAC578A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034691739B2
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27102798F8;
	Tue, 27 May 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WArFm+8H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7573C01;
	Tue, 27 May 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367250; cv=none; b=XLZmT+8pyoaYjArJABLBh8nZHtLilNBLzthQ9BvDrXfeXFCprKMfntXWKUgDBcu+60h97TBsHLVaLA8EmLj4W6VPFV4+Q4CJgIUiuu8J7qeH8xO0eKHOXCbs56nJhVU7Iq9vOlDz+C3YVUz7bw63R5GtsP/RxNv7vQ/fFJjxZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367250; c=relaxed/simple;
	bh=qZf4mFjVbcwn/vc5avP3kiFrZdRyHzyRLJpLACzAnro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bb/r7iOsLqxJBAi8ozUA5hHA/fBTFzprsIEffKZ/jLFyeFkP0RuWUdGR/NDUxuVoxwXaRkhoRsyePKYrZQ+bCq2YUrqkEFu2ntexermP14an2hf7Nxx9Cxh0UBf4NOAEusGBvdy53n0Fg1DrGyn4qsjoQ67pGpvvfFB3Jt3QSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WArFm+8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC71C4CEE9;
	Tue, 27 May 2025 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367250;
	bh=qZf4mFjVbcwn/vc5avP3kiFrZdRyHzyRLJpLACzAnro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WArFm+8Hh60ienxMCR8WYmVr3zt5nIBGLFUZEhVHVlvl4CeCCwiiwV8M6vLkDtD3c
	 zstFM8j4zgDm7/vdVaPqbNR43KCHm9p7q7ug50+qUopqLixr9km/8rmAGWJKH4GCaS
	 Aaih68C8roJ/f9cfuZ4yNM2iltb7nL8N37HPQL10=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 327/783] firmware: arm_ffa: Set dma_mask for ffa devices
Date: Tue, 27 May 2025 18:22:04 +0200
Message-ID: <20250527162526.377021403@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index fa09a82b44921..eacde92802f58 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -213,6 +213,7 @@ ffa_device_register(const struct ffa_partition_info *part_info,
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
+	dev->dma_mask = &dev->coherent_dma_mask;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->id = id;
-- 
2.39.5




