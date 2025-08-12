Return-Path: <stable+bounces-167817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D79AB231F8
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610BF3A9E5D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882EA280037;
	Tue, 12 Aug 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdHPs3tW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675D2F5E;
	Tue, 12 Aug 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022090; cv=none; b=Inf/bMdZkCnRdHUms1NShknx3v6TE1dtREUO4+c6/0ujbcnGwTZ8o40sv/FUw2b8q91Qys/Gd8e6/MiFLgsCwIaU/fU0PsY92wFB1/C9wzqdzS3AvrzNtu30SFn5rxNkII/E+9Nlp7VRAuXzbZxItzHZcs6EL+vuT9NC6MHyPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022090; c=relaxed/simple;
	bh=lr41ogaqO8maQzQeCsuPBbex1QlDDluT4m7t84JbAt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hyil4WoM2VIN1cnf+g/eAolfFndERDHPdTxgFCAP+tOiLI3JUvbPt1PEEA8zYjP1M7uf8NgTU4F481YHpJLP70UxvoO833CsEuCLHhwwwocHEvbfIpncolQY9K/YgTaWP6WbNDPl9WwMhWPpAbpI0WMjbF5sKDqOJ4SFYawPCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdHPs3tW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A685AC4CEF0;
	Tue, 12 Aug 2025 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022090;
	bh=lr41ogaqO8maQzQeCsuPBbex1QlDDluT4m7t84JbAt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdHPs3tWpVh0wnchPTVdu8SKjaHiVPFufZV3Oq1Yrg2wgBFuB1ooLRqvJ/qhINh7F
	 7xXcrRG4OFEUlwK+0FO14FFZV4Ax+bFuqQGYnqD0FhmcjzE/ARCWFSla3eDDXEr+jD
	 zt/OjSu8XeV7LxSHljsyH9Ah0zzxpys65dvTR5Tk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Annette Kobou <annette.kobou@kontron.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 052/369] ARM: dts: imx6ul-kontron-bl-common: Fix RTS polarity for RS485 interface
Date: Tue, 12 Aug 2025 19:25:49 +0200
Message-ID: <20250812173016.722993313@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Annette Kobou <annette.kobou@kontron.de>

[ Upstream commit 47ef5256124fb939d8157b13ca048c902435cf23 ]

The polarity of the DE signal of the transceiver is active-high for
sending. Therefore rs485-rts-active-low is wrong and needs to be
removed to make RS485 transmissions work.

Signed-off-by: Annette Kobou <annette.kobou@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
index 29d2f86d5e34..f4c45e964daf 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
@@ -168,7 +168,6 @@ &uart2 {
 	pinctrl-0 = <&pinctrl_uart2>;
 	linux,rs485-enabled-at-boot-time;
 	rs485-rx-during-tx;
-	rs485-rts-active-low;
 	uart-has-rtscts;
 	status = "okay";
 };
-- 
2.39.5




