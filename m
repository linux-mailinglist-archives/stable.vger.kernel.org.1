Return-Path: <stable+bounces-118751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E030BA41AEE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC057A5A7D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE092505B3;
	Mon, 24 Feb 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NE6wrNmx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA092505B1
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392864; cv=none; b=arB/VR3Crwtrda3nMN42/JP4Cl2jyl3W3GO1ZLMzKm6MoJ8kWIpl1cJKYBm7PHIwj+ttj0xJBaK+2lRj/Bm4G97YyqM4ik8qS+5bntC51CXbAWBherqh3ehKZOsFeUVv/8rDmns94pnpEYhmeoVOGiY2najN1uOeoj5ntkq/l7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392864; c=relaxed/simple;
	bh=NIIgnOBjV7b1mfJo9XFf7FmdmrRbbndxuwcWB1CtD0U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MfuXbVjCUSVXZ1bZenS8oGhTaol9HyMIBwVupJFkAKP4QgZkwla5sHTQvzQEUt6KMnxRmneca3WFqDY6M1vTzIOJA12cbodnh83/2XJFJGYHF3Ra8xYWSLXx0Iz2iemwrnn6wNHM52BGrtWjyui+vO1bPtVNiS5q/a6nvfOKalA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NE6wrNmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02B7C4CED6;
	Mon, 24 Feb 2025 10:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392864;
	bh=NIIgnOBjV7b1mfJo9XFf7FmdmrRbbndxuwcWB1CtD0U=;
	h=Subject:To:Cc:From:Date:From;
	b=NE6wrNmxmxzSnViHo+SsJW1J5ZYj1eItQHeMaq2kcLs4gQZpBRNbQXhrXKXJ/DVBA
	 50EP0mcKnYlkkZKN6iwKBWVdYgdHOfbJlhV/Ez9SaoYtCNrIlXCft/LU1E+gjfJktU
	 NPPppNg0nNu9e3fjr4L6PT6HS0oD3dAU0YIOkUEo=
Subject: FAILED: patch "[PATCH] arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck" failed to apply to 6.6-stable tree
To: lukasz.czechowski@thaumatec.com,heiko@sntech.de,quentin.schulz@cherry.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:27:38 +0100
Message-ID: <2025022438-automated-recycled-cc12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5ae4dca718eacd0a56173a687a3736eb7e627c77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022438-automated-recycled-cc12@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ae4dca718eacd0a56173a687a3736eb7e627c77 Mon Sep 17 00:00:00 2001
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 21 Jan 2025 13:56:04 +0100
Subject: [PATCH] arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

UART controllers without flow control seem to behave unstable
in case DMA is enabled. The issues were indicated in the message:
https://lore.kernel.org/linux-arm-kernel/CAMdYzYpXtMocCtCpZLU_xuWmOp2Ja_v0Aj0e6YFNRA-yV7u14g@mail.gmail.com/
In case of PX30-uQ7 Ringneck SoM, it was noticed that after couple
of hours of UART communication, the CPU stall was occurring,
leading to the system becoming unresponsive.
After disabling the DMA, extensive UART communication tests for
up to two weeks were performed, and no issues were further
observed.
The flow control pins for uart5 are not available on PX30-uQ7
Ringneck, as configured by pinctrl-0, so the DMA nodes were
removed on SoM dtsi.

Cc: stable@vger.kernel.org
Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Link: https://lore.kernel.org/r/20250121125604.3115235-3-lukasz.czechowski@thaumatec.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index 2c87005c89bd..e80412abec08 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -397,6 +397,8 @@ &u2phy_host {
 };
 
 &uart5 {
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
 	pinctrl-0 = <&uart5_xfer>;
 };
 


