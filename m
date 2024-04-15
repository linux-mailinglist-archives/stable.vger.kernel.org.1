Return-Path: <stable+bounces-39513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A78A51F0
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A22B1F2359A
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2F879952;
	Mon, 15 Apr 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deW+e51E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8978C84
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188354; cv=none; b=Z/A94i1Cj+dts3kIXHnuuo3+hZ2gGP5aL+tpfXWi2olpJhv6Hjw9GK8slQlQj3vZj3yk1dUjMfBKcJlvCsqAdiHxga7MXXjSd7VW8lB1NMVwbrAPKrv3N2P2+1qVMLRy3iLZd17M6kCIWH6ptFZTG4NXjIcpvscUJBCn5PPo3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188354; c=relaxed/simple;
	bh=E9W4tldl4DXWYd3N/LcioFAH+jHdAnGhZTtALjKqGPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxZ2BxtuSMSLmCgnj/gxLtYH2TMnCkNiNEgYNn2p3mq7lmjZfivnPTVRGSJbRdxO/6+DlU1dJHVta7o83BVE2GFE1dIiN/j4cwCZATh0p+yJjQrQG63fLJT8O1CuIDrfKk+x4oCON3h89V7EwRAUCYVwMzt3Y7qArIxi3P9gcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deW+e51E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5E5C113CC;
	Mon, 15 Apr 2024 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188354;
	bh=E9W4tldl4DXWYd3N/LcioFAH+jHdAnGhZTtALjKqGPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deW+e51EI53yAD62eIvweq2y4M8W7xQF51gg0lLA3B1oTWBE14fqCqaQFDXq6nb0B
	 SQEk0WGhWPOpr7ZoB9JnrRGhbIKM6vDWj+FYZG8DEwmHhlO8uCA4KJYPU/6I8a+Q3Q
	 tNwiIGptZ5eXQuH2RcXvUczet2qusp3nYIz9uCeO/8qFRQHJUwxF2SdSwr6g4Bi3VC
	 d8AWD/wFi88WNNqch/YnZmZjuqIByiQUtJSC9KqYIVBNKRVs1VeASUUjw5WeiOPq81
	 4IfqBB86XlZ/J2Fj2ACPo/7gZfsLfS4bJIkb9DDycW3CmwZW1pzNa5DiMDOvDvfGyM
	 bQfaZlVBitmNA==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 045/190] PCI: keystone: Don't discard .probe() callback
Date: Mon, 15 Apr 2024 06:49:35 -0400
Message-ID: <20240415105208.3137874-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 7994db905c0fd692cf04c527585f08a91b560144 ]

The __init annotation makes the ks_pcie_probe() function disappear after
booting completes. However a device can also be bound later. In that case,
we try to call ks_pcie_probe(), but the backing memory is likely already
overwritten.

The right thing to do is do always have the probe callback available.  Note
that the (wrong) __refdata annotation prevented this issue to be noticed by
modpost.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Link: https://lore.kernel.org/r/20231001170254.2506508-5-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index 54fe75fd46b9d..6696d3999bffc 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -388,7 +388,7 @@ static int ks_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __init ks_pcie_probe(struct platform_device *pdev)
+static int ks_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
@@ -455,7 +455,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_driver ks_pcie_driver __refdata = {
+static struct platform_driver ks_pcie_driver = {
 	.probe  = ks_pcie_probe,
 	.remove = ks_pcie_remove,
 	.driver = {
-- 
2.43.0


