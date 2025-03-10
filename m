Return-Path: <stable+bounces-122243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB661A59EC2
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE41B3A8BD3
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F4223026D;
	Mon, 10 Mar 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tQqaSX9M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF42253FE;
	Mon, 10 Mar 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627936; cv=none; b=GjrMpJjIO9/XrhEEOIMhl1wk2Q8PEEMXnA+JWPkMKCCAHRqeAn9Rpsd2UkbeU0if6tTQdNG8wntJHxFGlUEE+D5raG6IVQxFfPrmM2FiLSTPewazBNti7bxFSIbfP5rRchQbDYxHUakjTjOlT4LTIFZPBt5VA/M5U28cOzgOmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627936; c=relaxed/simple;
	bh=tpp+wP6cNWZIpkhEGTxLkWw5mLV7EItUrmB2kZi4nnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1N3xVJOnCGdUxE785745phmRM//xVVBjcrzNxNVEISI9aEDVS/v8QPNPyxX05ZOuSsRwbcXJ5BY+uF4/5XB8GdMAq9C15WD5VLiUpb/yfMK0LYTht66l1HlV/RSnbuX5ry2FkgVLLSrn/+blM72kjvfQJUckKIqMPRga+BXLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tQqaSX9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CCFC4CEE5;
	Mon, 10 Mar 2025 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627936;
	bh=tpp+wP6cNWZIpkhEGTxLkWw5mLV7EItUrmB2kZi4nnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQqaSX9MjP1oP3LJsXJHxiAGgb0lBDidXuGGasAmqON7VNWEiMFDWz22NA4Jm7wvy
	 4nesdiAdmwBSeTxJMXB9W1SfPbC0G2mxKq2pgKLaaOdSboVwLko73HxQOqs5VCzKBC
	 3HQIHEnC2q97qoAtHt2sUqKnR3mUniNoc/AE60kE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 005/145] arm64: dts: rockchip: add rs485 support on uart5 of px30-ringneck-haikou
Date: Mon, 10 Mar 2025 18:04:59 +0100
Message-ID: <20250310170434.958553347@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>

[ Upstream commit 5963d97aa780619ffb66cf4886c0ca1175ccbd3e ]

A hardware switch can set the rs485 transceiver into half or full duplex
mode.

Switching to the half-duplex mode requires the user to enable em485 on
uart5 using ioctl, DE/RE are both connected to GPIO0_B5 which is the
RTS signal for uart0. Implement GPIO0_B5 as rts-gpios with RTS_ON_SEND
option enabled (default) so that driver mode gets enabled while sending
(RTS high) and receiver mode gets enabled while not sending (RTS low).

In full-duplex mode (em485 is disabled), DE is connected to GPIO0_B5 and
RE is grounded (enabled). Since GPIO0_B5 is implemented as rts-gpios, the
driver mode gets enabled whenever we want to send something and RE is not
affected (always enabled) in this case by the state of RTS.

Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Link: https://lore.kernel.org/r/20240208-dev-rx-enable-v6-2-39e68e17a339@theobroma-systems.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Stable-dep-of: 5ae4dca718ea ("arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index de0a1f2af983b..56f73c17363fd 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -226,6 +226,7 @@ &uart0 {
 
 &uart5 {
 	pinctrl-0 = <&uart5_xfer>;
+	rts-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
-- 
2.39.5




