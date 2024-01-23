Return-Path: <stable+bounces-13880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F5837E8A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7401C212D2
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139525BAE7;
	Tue, 23 Jan 2024 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1DKyhACk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F35732A;
	Tue, 23 Jan 2024 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970653; cv=none; b=kBenzfSbNrS33RKkN83qHq/wVMS6p/JAwM9oXw/xaE9nlEosjVJBxF1nFAWwoAf4Dgs/q/2gTybatwovviKmdjx7lxnvnNvP4ddBEFQb2NK9ZXRPSoefIlBDZHdmAPAKqvnqIL+gDuqKrKVgcUB/LmXAPwUxjFAWECxfyb65/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970653; c=relaxed/simple;
	bh=+OxAHl4gilmsuBtynJc/FbdbKZckl0jNuvG4OqqZNIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeRCRhP+Hi3sUdOf8of25G2d+o0RF1xhoInrFy5X9XNd8uRwaGHAxxGxHVgwAxAe/d9itT68eqW6dfubs0nhaV0rLJYAHJlVMSRgBsn3+GdNKRBnnsZ9q45J0O9sG7eK+Vsln7rMH7Gen1J+bpcT8NKgyhMK3yHpfLncX1f7opA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1DKyhACk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA42EC433F1;
	Tue, 23 Jan 2024 00:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970653;
	bh=+OxAHl4gilmsuBtynJc/FbdbKZckl0jNuvG4OqqZNIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1DKyhACkXO666zV/lnZBsaR6D59x4toKKscye3eEpMGY0Gr7htbU7NTA1uIqIwTqG
	 jryNmLgP48lVxsovUAl75Wf9Y26Lm4gD4XemNQibt3NaEdkCJdBK4fTfpPVTrOkSIX
	 P5v4pJSRR7iEPZEw/liScoglEslN8IaVcVw01JQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nitin Yadav <n-yadav@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 079/417] arm64: dts: ti: k3-am62a-main: Fix GPIO pin count in DT nodes
Date: Mon, 22 Jan 2024 15:54:07 -0800
Message-ID: <20240122235754.439142617@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nitin Yadav <n-yadav@ti.com>

[ Upstream commit 7dc4af358cc382c5d20bd5b726e53ef0f526eb6d ]

Fix number of gpio pins in main_gpio0 & main_gpio1 DT nodes according
to AM62A7 datasheet[0].

[0] https://www.ti.com/lit/gpn/am62a3 Section: 6.3.10 GPIO (Page No. 52-55)
Fixes: 5fc6b1b62639 ("arm64: dts: ti: Introduce AM62A7 family of SoCs")
Signed-off-by: Nitin Yadav <n-yadav@ti.com>
Link: https://lore.kernel.org/r/20231027065930.1187405-1-n-yadav@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index bc4b50bcd177..9301ea388802 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -245,7 +245,7 @@ main_gpio0: gpio@600000 {
 			     <193>, <194>, <195>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		ti,ngpio = <87>;
+		ti,ngpio = <92>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 77 0>;
@@ -263,7 +263,7 @@ main_gpio1: gpio@601000 {
 			     <183>, <184>, <185>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		ti,ngpio = <88>;
+		ti,ngpio = <52>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 78 0>;
-- 
2.43.0




