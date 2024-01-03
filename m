Return-Path: <stable+bounces-9446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE473823267
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88844286EFB
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D531BDF4;
	Wed,  3 Jan 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zGfXzxyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9891BDF1;
	Wed,  3 Jan 2024 17:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8CBC433C7;
	Wed,  3 Jan 2024 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301602;
	bh=TTvivtZlDUsaeVNLtZhoVzszUWwHMDfTIo561PEaqTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zGfXzxyTlZHGBEVGePnCd+TAk8nZ+mpKTuEZKA9uyznd4kbgq25S2rdZo+yY8ANIc
	 nxUPcz/NwOmKzp4giNOqWqRC1GwrGJeBsP5aONgv/sutfY7NFbwhKzJjFo7UeRx36I
	 72lBnX5pSggGtaVWV0IqlKlI1whTHL7/TmA/g6M4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 74/95] ARM: dts: Fix occasional boot hang for am3 usb
Date: Wed,  3 Jan 2024 17:55:22 +0100
Message-ID: <20240103164905.108506952@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
References: <20240103164853.921194838@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 9b6a51aab5f5f9f71d2fa16e8b4d530e1643dfcb ]

With subtle timings changes, we can now sometimes get an external abort on
non-linefetch error booting am3 devices at sysc_reset(). This is because
of a missing reset delay needed for the usb target module.

Looks like we never enabled the delay earlier for am3, although a similar
issue was seen earlier with a similar usb setup for dm814x as described in
commit ebf244148092 ("ARM: OMAP2+: Use srst_udelay for USB on dm814x").

Cc: stable@vger.kernel.org
Fixes: 0782e8572ce4 ("ARM: dts: Probe am335x musb with ti-sysc")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f53695ecbb782..7daf6ae2cd9af 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -349,6 +349,7 @@ usb: target-module@47400000 {
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>,
 					<SYSC_IDLE_SMART_WKUP>;
+			ti,sysc-delay-us = <2>;
 			clocks = <&l3s_clkctrl AM3_L3S_USB_OTG_HS_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
-- 
2.43.0




