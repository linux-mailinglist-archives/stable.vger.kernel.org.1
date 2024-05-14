Return-Path: <stable+bounces-44874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10318C54C6
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70DE4B2288E
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FED6BFBB;
	Tue, 14 May 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8QRZIMo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209A54903;
	Tue, 14 May 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687427; cv=none; b=Y50WHetAIcKbuERsy1kpfsjcp0cBW4l16Y9nEmamDoqUewXp/aLgKYxR0l96ViTmC/DkUAjppDAIRPw/6ImBwONDcpyEZa4bTJI3p8fb95LHQ7jlYieKTmcJd94B5s3Eqamo/nvIzEqiOkKMvUYV6h275HLTSkdQrCOS6FPGJns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687427; c=relaxed/simple;
	bh=d02LYnzHPeMyuCePOUnaNFoZ2OV0QeGnh+86FwJZlig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hk25VnzhEiqILvrhv4x0XrdACkURPYvrDgXNJtNvUS/1VsZlRIF6+IV83KmVPu+zpdvfcZGeQgjPJzwjrJUkGGaNXfFJnjdIiaqxqDF3zS6t8URUI+6BA58ToRzui58ZEUCzu/pKX95O9rcTLCLC3qBc/FX4ImBuuZrrgShL5R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8QRZIMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3F8C2BD10;
	Tue, 14 May 2024 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687426;
	bh=d02LYnzHPeMyuCePOUnaNFoZ2OV0QeGnh+86FwJZlig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8QRZIMoW8l/Z+oDeqJvdtws+jh3odp2arW44663uUDYiIdv8yvPOZ58d3Asm6b0R
	 iZntTo9m3B0s/C2j2xU2dUHLsdN0p+9lTDFYVvEBjQOnpX0mwWU5eGSsSUEd0xlNkS
	 q4z/PhX2kFGtskuwNvW0IgT8fZwgdR3Ik5D33wBQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 061/111] gpu: host1x: Do not setup DMA for virtual devices
Date: Tue, 14 May 2024 12:19:59 +0200
Message-ID: <20240514100959.453640384@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 8ab58f6841b19423231c5db3378691ec80c778f8 ]

The host1x devices are virtual compound devices and do not perform DMA
accesses themselves, so they do not need to be set up for DMA.

Ideally we would also not need to set up DMA masks for the virtual
devices, but we currently still need those for legacy support on old
hardware.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240314154943.2487549-1-thierry.reding@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/bus.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 6e3b49d0de66d..b113c8e0acd02 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -335,11 +335,6 @@ static int host1x_device_uevent(struct device *dev,
 	return 0;
 }
 
-static int host1x_dma_configure(struct device *dev)
-{
-	return of_dma_configure(dev, dev->of_node, true);
-}
-
 static const struct dev_pm_ops host1x_device_pm_ops = {
 	.suspend = pm_generic_suspend,
 	.resume = pm_generic_resume,
@@ -353,7 +348,6 @@ struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
 	.uevent = host1x_device_uevent,
-	.dma_configure = host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
 };
 
@@ -442,8 +436,6 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
-	of_dma_configure(&device->dev, host1x->dev->of_node, true);
-
 	device->dev.dma_parms = &device->dma_parms;
 	dma_set_max_seg_size(&device->dev, UINT_MAX);
 
-- 
2.43.0




