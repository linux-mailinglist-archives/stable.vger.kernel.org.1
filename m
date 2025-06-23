Return-Path: <stable+bounces-157956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA08AE565A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600EF188CCDE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BAF1E3DCD;
	Mon, 23 Jun 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cUQTOH1m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698F221FC7;
	Mon, 23 Jun 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717131; cv=none; b=bMF2IoPi0NE4O24uKvatjKrIGRypWNAoTgBT+9Gnq8W4z5OSF4vLlB5TsHZJAaQNverWYtzhtxsMEH0VyoeD3oX+aAloMdc7MVHCOvcF9h33L537ZbncOHc87ujBxsf//2u7U0d+yqwgQKKB3hzevdGVIxCpq2WANdgE2fFiwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717131; c=relaxed/simple;
	bh=fvRCe91wRLrjMl0VswqNTkYxKbq6j8REdSGpjYZXE7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkU4X/0oI6j7I5Vbjqi/DoeRozXPhj5xV22nXxt/+VARtTOIKZYzaxSlzT+Eb/3V9YFzJEx1gCxIGhxrQT3MTVW8+THNOr+r0sbHEYEw015MJE+pzf1jX9SjxL7FusGBBoWlquSewLCVLi7WwWnf3eT9eilIEY1jN9U4KXw435U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cUQTOH1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AE7C4CEEA;
	Mon, 23 Jun 2025 22:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717131;
	bh=fvRCe91wRLrjMl0VswqNTkYxKbq6j8REdSGpjYZXE7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUQTOH1magBlsh0ccu9szqB91/4YyRIHTGVJc5yjoU0XmlUaVUBIgTNtBRAmg40Ob
	 +cv9GbOo4Ga9+4EVWonyYR4ggrsci+y7UDefK/BKqiik0Dswwn1W2eTfpDqAcr/dTJ
	 yrNGBDj4mSsHfNVD0I0Ud3zkvAKxABeGQLNoToNM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Diederik de Haas <didi.debian@cknow.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Niklas Cassel <cassel@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 6.1 370/508] PCI: dw-rockchip: Fix PHY function call sequence in rockchip_pcie_phy_deinit()
Date: Mon, 23 Jun 2025 15:06:55 +0200
Message-ID: <20250623130654.446652976@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Diederik de Haas <didi.debian@cknow.org>

commit 286ed198b899739862456f451eda884558526a9d upstream.

The documentation for the phy_power_off() function explicitly says that it
must be called before phy_exit().

Hence, follow the same rule in rockchip_pcie_phy_deinit().

Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
[mani: commit message change]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org	# v5.15+
Link: https://patch.msgid.link/20250417142138.1377451-1-didi.debian@cknow.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -275,8 +275,8 @@ static int rockchip_pcie_phy_init(struct
 
 static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
 {
-	phy_exit(rockchip->phy);
 	phy_power_off(rockchip->phy);
+	phy_exit(rockchip->phy);
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {



