Return-Path: <stable+bounces-42281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B43F8B723B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FB51F23AB0
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED012C819;
	Tue, 30 Apr 2024 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0IWCTlUa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A5612C530;
	Tue, 30 Apr 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475152; cv=none; b=S1egtrqfX8T4OFKpFvJ8kKjA9qFT+UM4YoNxNm3DyfM/Nuh3tJ8VPsiufW7lCA1bIH9SIFv4entuyjInhIi7oB89x8xJaey41+qR2P3L59OEY/I+AMguKpejzZ1dTunEA35VQ6pJuU2GwV2Oyzu8IOjC8nApnGlTgwlZWiW3sWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475152; c=relaxed/simple;
	bh=2waA15l35+VW0f4uzFUcA8qsIcV122iMy7fXGgkTh18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeEcAhf7Hij8XvPb8C3QLXOl4wba3HpWCc4Rd7A8NbAikqoB+cW23DfHfdBo1SRVzrHtAg7m8rjjvo8sZiuBHkEomISjQP+j5OVzD8PK7cyaXamjeOscyTiq7EtkdfjHOd1KsqsY7WzdojY62qYm3wrRhMcKZEqeoS8rvjNLuq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0IWCTlUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8BDC2BBFC;
	Tue, 30 Apr 2024 11:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475152;
	bh=2waA15l35+VW0f4uzFUcA8qsIcV122iMy7fXGgkTh18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0IWCTlUaBOAuMouEAqUe3+i0wqyOUiS3oPImdD3M3R5nMQmHkK/tzQ1vAEwK4VWyx
	 utEXlXYn7SZndg1yOGqGG3MhCRL0OxvOU3VQFegshffr1kjxTh4S3sk3twF19MARCZ
	 ch1pVhncvcNxKwrW2okylETT2R+1kXvclXjB2hlk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 010/186] arm64: dts: rockchip: Remove unsupported node from the Pinebook Pro dts
Date: Tue, 30 Apr 2024 12:37:42 +0200
Message-ID: <20240430103058.319107737@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dragan Simic <dsimic@manjaro.org>

[ Upstream commit 43853e843aa6c3d47ff2b0cce898318839483d05 ]

Remove a redundant node from the Pine64 Pinebook Pro dts, which is intended
to provide a value for the delay in PCI Express enumeration, but that isn't
supported without additional out-of-tree kernel patches.

There were already efforts to upstream those kernel patches, because they
reportedly make some PCI Express cards (such as LSI SAS HBAs) usable in
Pine64 RockPro64 (which is also based on the RK3399);  otherwise, those PCI
Express cards fail to enumerate.  However, providing the required background
and explanations proved to be a tough nut to crack, which is the reason why
those patches remain outside of the kernel mainline for now.

If those out-of-tree patches eventually become upstreamed, the resulting
device-tree changes will almost surely belong to the RK3399 SoC dtsi.  Also,
the above-mentioned unusable-without-out-of-tree-patches PCI Express devices
are in all fairness not usable in a Pinebook Pro without some extensive
hardware modifications, which is another reason to delete this redundant
node.  When it comes to the Pinebook Pro, only M.2 NVMe SSDs can be installed
out of the box (using an additional passive adapter PCB sold separately by
Pine64), which reportedly works fine with no additional patches.

Fixes: 5a65505a6988 ("arm64: dts: rockchip: Add initial support for Pinebook Pro")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
Link: https://lore.kernel.org/r/0f82c3f97cb798d012270d13b34d8d15305ef293.1711923520.git.dsimic@manjaro.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 054c6a4d1a45f..294eb2de263de 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -779,7 +779,6 @@
 };
 
 &pcie0 {
-	bus-scan-delay-ms = <1000>;
 	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
 	pinctrl-names = "default";
-- 
2.43.0




