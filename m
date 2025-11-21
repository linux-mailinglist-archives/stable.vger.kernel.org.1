Return-Path: <stable+bounces-195637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC96AC794C9
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E7564EBB46
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8CE27B358;
	Fri, 21 Nov 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wHXNA5Y4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26892275B18;
	Fri, 21 Nov 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731239; cv=none; b=l5BDy0DyZSAdQfwJe18+SNZFPqRLX8U2N2kZOw0+JucUJyjn5fZyLEZGaFhxnfQmqCwSXJhlt5UoYelM+R97bb6g7qfW9dDUwvwELdvX8o18zUdIUsKmaPld7zFTtXkPEixQ1Hz5bt44KjNShvY+YrL++2L5Au9j7BfmDpboanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731239; c=relaxed/simple;
	bh=wD7TIGSHESKxO3hr9KhuCEoENkCWT7ZXfVzpzqcBmh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzJOBeEgMw024SFpW/TSPoaKa1cT0LCl0IpB3C6bUFHM3OAfxHorOze3LYb6qSZA5ke8p4hCzARjAAtDj3KQovDmpx5w+E/fp8hN6gstrBK7gZvTtVQQ26qeoKcWX9b91jR1QM0kO1D4V3mt5KcILg3YArS1qKZ2m+umizuIyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wHXNA5Y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7B8C4CEF1;
	Fri, 21 Nov 2025 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763731238;
	bh=wD7TIGSHESKxO3hr9KhuCEoENkCWT7ZXfVzpzqcBmh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wHXNA5Y40deRf1fxsJy53YGKqQCmIOKuZqgZ/B71MhCw04Nuxong07cmV7jCosuPh
	 38l3pC+P2mjb99f3/ynjbYJDEafSIlra9iwabcjHe1vtSf0z3be/OOn04mwyEihahn
	 xTLP1uC6CvpAfqibHWTAKQhOiNTbgXGo1cmZvADg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 138/247] ARM: dts: imx6ull-engicam-microgea-rmm: fix report-rate-hz value
Date: Fri, 21 Nov 2025 14:11:25 +0100
Message-ID: <20251121130159.680420022@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130154.587656062@linuxfoundation.org>
References: <20251121130154.587656062@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

[ Upstream commit 62bf7708fe80ec0db14b9179c25eeeda9f81e9d0 ]

The 'report-rate-hz' property for the edt-ft5x06 driver was added and
handled in the Linux kernel by me with patches [1] and [2] for this
specific board.

The v1 upstream version, which was the one applied to the customer's
kernel, used the 'report-rate' property, which was written directly to
the controller register. During review, the 'hz' suffix was added,
changing its handling so that writing the value directly to the register
was no longer possible for the M06 controller.

Once the patches were accepted in mainline, I did not reapply them to
the customer's kernel, and when upstreaming the DTS for this board, I
forgot to correct the 'report-rate-hz' property value.

The property must be set to 60 because this board uses the M06 controller,
which expects the report rate in units of 10 Hz, meaning the actual value
written to the register is 6.

[1] 625f829586ea ("dt-bindings: input: touchscreen: edt-ft5x06: add report-rate-hz")
[2] 5bcee83a406c ("Input: edt-ft5x06 - set report rate by dts property")
Fixes: ffea3cac94ba ("ARM: dts: imx6ul: support Engicam MicroGEA RMM board")
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
index 5d1cc8a1f5558..8d41f76ae270b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
@@ -136,7 +136,7 @@
 		interrupt-parent = <&gpio2>;
 		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
-		report-rate-hz = <6>;
+		report-rate-hz = <60>;
 		/* settings valid only for Hycon touchscreen */
 		touchscreen-size-x = <1280>;
 		touchscreen-size-y = <800>;
-- 
2.51.0




