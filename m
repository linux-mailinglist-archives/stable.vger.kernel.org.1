Return-Path: <stable+bounces-30868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE1E8892F9
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE122A247A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5BC289DA8;
	Mon, 25 Mar 2024 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow0kswNJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88628A586;
	Sun, 24 Mar 2024 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324061; cv=none; b=HbnULv2Mb8LndojrZVgASldaG+A4IGNVQBQF3NYY5q7rsxNtIyrjhPGA2mer419oAOveN2LSfqJQlJJ87dxz2MJ5ITuFIZ7PnjhlxEmFxbzbZZhGaCgsOqMNxal8FSKXIQOKkuQBUKoNzm1Ri3+LTBTG20RVxa6N9dytFxOFZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324061; c=relaxed/simple;
	bh=7glZ54lDGMxIj2YZQVQKCzWFHNfN2XPYLHalDBSTC/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nqebq4BhD+LoG8PaRqWkr0vBl0C6wWAalAYCC44Fp3kdqq3N68dIEUew6sl535bjd29lUzCCzTrS3nvvJJmx4nL/LERWc3WEzvgwNi91FCT5Sp0lCO7KfiqGaK7EzLHwnfXPctlRMjJQWCN8Q+ss2oFbYx7EdcIBsIUgoeQNMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow0kswNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08E8C43390;
	Sun, 24 Mar 2024 23:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324060;
	bh=7glZ54lDGMxIj2YZQVQKCzWFHNfN2XPYLHalDBSTC/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ow0kswNJ0az9svmRra3fDfGf7WgvbVk+7Sx/685KMyO/y9nK3sh8b+mQaxaHvjDIk
	 qM3N38XazWSOBSc9XJrp1/QLV7jy9MiF4gSXGzsoYG96u6uK+NLJnTkdh28u/ew1Ac
	 nperJHjCwUa3eWYliYKHsuCpYuctQH0lhpVjGmIrZV/ycyOVeegd241jVbQPHD3/Ze
	 tfTEpcI2NQtk1bFntHsbzu13aVilRw4wRut8MxNK6fv6BIeTxGTH9cT24/WzFlJnKQ
	 w+Pmz5/cELwCgzJmQQM89KL0E2TRrKFjN8JAYhELC/zhx0wZk7d99LhWiXmi0EzPJo
	 xJ/OQnq0BXAQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 061/183] ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
Date: Sun, 24 Mar 2024 19:44:34 -0400
Message-ID: <20240324234638.1355609-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michal Vokáč <michal.vokac@ysoft.com>

[ Upstream commit 023bd910d3ab735459f84b22bb99fb9e00bd9d76 ]

This change does not have any functional effect. The switch works just
fine without this patch as it has full access to all the addresses
on the bus. This is simply a clean-up to set the node name address
and reg address to the same value.

Fixes: 15b43e497ffd ("ARM: dts: imx6dl-yapp4: Use correct pseudo PHY address for the switch")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 4d1e65c307f86..e86f409ca8801 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -118,7 +118,7 @@ phy_port3: phy@2 {
 
 		switch@10 {
 			compatible = "qca,qca8334";
-			reg = <10>;
+			reg = <0x10>;
 			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
-- 
2.43.0


