Return-Path: <stable+bounces-125914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F4EA6DEB3
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568E3188D1DE
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C4725DB0B;
	Mon, 24 Mar 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TfArfQE3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920902A1BA
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830285; cv=none; b=VNvlIgaN1WBBrXhfc/VWR6cZE65GECJQLjht0VuCywmY455RZX3O3gGZkgotBCaT8P41DUvyonLsh8Wdvvwhi6uF6pISgZ5OYziuUV2ojrmmCbEXIEPcEMt2yE99qJlUbExUaxFyC8eSGwDkVFILGyCFku7U2tvfg0vXx2v6xPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830285; c=relaxed/simple;
	bh=12Q239uBLVQx8JR9tv5WTxiZwPj54Ja7gw1uxXSqjyc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C/NAu8j6fRkDBizSz8x/9Y9XgNxzTlBIiox4/SDZVQy/jqzYcluu/KWZm44dOE+HrdlYokIu1wcDfMuNMAS0JgaKMP48bZRQEcT4npPy6PZodrG8RHKvC9rD8neevELuQmnRqMU7loLt2PNpRYIbhIEihXoGR7heu8erUHYUuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TfArfQE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FD5C4CEDD;
	Mon, 24 Mar 2025 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830285;
	bh=12Q239uBLVQx8JR9tv5WTxiZwPj54Ja7gw1uxXSqjyc=;
	h=Subject:To:Cc:From:Date:From;
	b=TfArfQE38hn922A09a3kVB4QWGfy2fY25jJVSv14QzYDICpPkEPrXTBXEdrXNYC8V
	 c6Y3U/k8hS7/ATOnzDCI50wNOy5eEHXdQ2xD6v/tird7RejwbdcxUNpDkTtU7eFLHY
	 pxbpYTWDIKiTFaFTRZHizosWNP1fAkd0tx3vY3Ls=
Subject: FAILED: patch "[PATCH] arm64: dts: rockchip: fix pinmux of UART5 for PX30 Ringneck" failed to apply to 6.6-stable tree
To: quentin.schulz@cherry.de,heiko@sntech.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:30:02 -0700
Message-ID: <2025032402-unfilled-snooze-0c70@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 55de171bba1b8c0e3dd18b800955ac4b46a63d4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032402-unfilled-snooze-0c70@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55de171bba1b8c0e3dd18b800955ac4b46a63d4b Mon Sep 17 00:00:00 2001
From: Quentin Schulz <quentin.schulz@cherry.de>
Date: Tue, 25 Feb 2025 12:53:30 +0100
Subject: [PATCH] arm64: dts: rockchip: fix pinmux of UART5 for PX30 Ringneck
 on Haikou

UART5 uses GPIO0_B5 as UART RTS but muxed in its GPIO function,
therefore UART5 must request this pin to be muxed in that function, so
let's do that.

Fixes: 5963d97aa780 ("arm64: dts: rockchip: add rs485 support on uart5 of px30-ringneck-haikou")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Link: https://lore.kernel.org/r/20250225-ringneck-dtbos-v3-2-853a9a6dd597@cherry.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 6d45a19413ce..1a59e8b1dc46 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -194,6 +194,13 @@ sd_card_led_pin: sd-card-led-pin {
 			  <3 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	uart {
+		uart5_rts_pin: uart5-rts-pin {
+			rockchip,pins =
+			  <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm0 {
@@ -228,6 +235,9 @@ &uart0 {
 };
 
 &uart5 {
+	/* Add pinmux for rts-gpios (uart5_rts_pin) */
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart5_xfer &uart5_rts_pin>;
 	rts-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };


