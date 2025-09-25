Return-Path: <stable+bounces-181734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA3EBA0193
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 17:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CE94C3E66
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1C52E1746;
	Thu, 25 Sep 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9eZagnl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9C1DE4EF;
	Thu, 25 Sep 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812496; cv=none; b=kuaEyM4ItGjHB8Wj5n2yBPYjOpH34NBApWKxXAwvPMDhukDrz3RJz6bw2KYKVrSQ0VVwD4kVhxoy3kGYzs74r3j8iwuottmYZd8VEesix/3PEVciY7WR9RuDlSewOttl5o73b94/13qUWB2pO49SLIAPx4fcRXCPbYH9+9IFE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812496; c=relaxed/simple;
	bh=HBMKAro78ZNFv7LCJEgpDLhewdaAREFXTDxX6fc0Jhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iIr0yjD3wLTnoM8kbRKCTNMLzgmJWdth9EbOVm9MYA9UvSaMrTWxTQPRfNcUcmHZE3j67EIWcqXJ8rPoMGmjdkrYnXhyGAKGKLSdkVP7Ufqbz3dFmImSu1UXif4j3NJ9NZ6mPAISYpfLRZvkUlkvgQZb52hoJNITZm1SqdQHl9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9eZagnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5E9C4CEF0;
	Thu, 25 Sep 2025 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758812495;
	bh=HBMKAro78ZNFv7LCJEgpDLhewdaAREFXTDxX6fc0Jhs=;
	h=From:To:Cc:Subject:Date:From;
	b=p9eZagnlb2exRZ2TXxx1d+IN8AQ9UQQV0/BCt/ggJaBfaroEU1/1ZuvHZMSg4eaYd
	 LKlBmZuLlu2Ws+UmQFmxbPZNzbtMpQ3URJtJBSo58Ofi3m222QQvISk10f+w4UAi7N
	 foNhjRRTZRgEoorRWw29WG85c2bumHhhQ2J9QBG1SPceJ74C4fXTNCw1VmuvDXTBp8
	 X/n1mmnYRLUw43do55pprykU9rV7Ll+3aC+SjuN5XslGg7r+fyJ4+KOTkpx6OtGeXW
	 UwbpISMl1uHvTSHDNn4TPw2SXNOAO/MLiOeQbW943gdtqCqss+JCAoYVCWbBNXObEN
	 dPBrwS2W8c74A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1nTM-000000006Jh-3Oke;
	Thu, 25 Sep 2025 17:01:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] amba: tegra-ahb: fix device leak on smmu enable
Date: Thu, 25 Sep 2025 17:00:07 +0200
Message-ID: <20250925150007.24173-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the ahb platform device when
looking up its driver data while enabling the smmu.

Note that holding a reference to a device does not prevent its driver
data from going away.

Fixes: 89c788bab1f0 ("ARM: tegra: Add SMMU enabler in AHB")
Cc: stable@vger.kernel.org	# 3.5
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/amba/tegra-ahb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index c0e8b765522d..f23c3ed01810 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -144,6 +144,7 @@ int tegra_ahb_enable_smmu(struct device_node *dn)
 	if (!dev)
 		return -EPROBE_DEFER;
 	ahb = dev_get_drvdata(dev);
+	put_device(dev);
 	val = gizmo_readl(ahb, AHB_ARBITRATION_XBAR_CTRL);
 	val |= AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE;
 	gizmo_writel(ahb, val, AHB_ARBITRATION_XBAR_CTRL);
-- 
2.49.1


