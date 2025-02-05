Return-Path: <stable+bounces-112829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D29A28E99
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8439F162DE6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07B14A088;
	Wed,  5 Feb 2025 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bvVg9Gz7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497AF13C9C4;
	Wed,  5 Feb 2025 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764903; cv=none; b=fuMYMc56JO94beo6UQnDHYgjktt/db9cEaUgeYwQnAdsnkx07DMgprFCXIPUBjMXxzL6VhFY5pjUL6/8eBtHOMDceu2vTGy5KLEfeE9FnT5sQpKHNIK42/H80ssTCDqcV7r9VQeC+BHYZzQigtsZj04x+b8yagG7TW9CwzRIMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764903; c=relaxed/simple;
	bh=O5kA18C9aLhP5X/baRKbeeS9UAYX3cC85K2vfcT3Hec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4a4ETRsABcOxHBwtY4O25Vsgi4LLl37x7wI5r+NFgbthy1Xcs57DZfkTNsVrK655Ul11poLuAFphGsKtWOf8ig672oNTQnxKLhXpjS6ZS/nzuakxdS6kLuTl80qRxQTPTNCCikfG4VFRdnyUvQxO/XoOKjWf9gnEWOFlVmuJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bvVg9Gz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95192C4CED1;
	Wed,  5 Feb 2025 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764903;
	bh=O5kA18C9aLhP5X/baRKbeeS9UAYX3cC85K2vfcT3Hec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvVg9Gz7QI885zegSjEJrTq5r4wrVIMB+YDvY+yrH5bTEyGUciZEho53Zu1S4aCG+
	 ZmOM0BiUOoh52UmjeclzuptgYMk/8FOhRFRnWfsFNEwhJwFxvhb2ktchCc2Oy4VJNG
	 ZldnkqAWRGsPyeDJ+nFbI1a9R+ZWtMKnduQbFIIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wojciech Macek <wmacek@google.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" <nfraprado@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 196/393] arm64: dts: mediatek: mt8186: Move wakeup to MTU3 to get working suspend
Date: Wed,  5 Feb 2025 14:41:55 +0100
Message-ID: <20250205134427.798458658@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 253b4e96f5783fddede1b82274a7b4e0aa57d761 ]

The current DT has the wakeup-source and mediatek,syscon-wakeup
properties in the XHCI nodes, which configures USB wakeup after powering
down the XHCI hardware block. However, since the XHCI controller is
behind an MTU3 (USB3 DRD controller), the MTU3 only gets powered down
after USB wakeup has been configured, causing the system to detect a
wakeup, and results in broken suspend support as the system resumes
immediately.

Move the wakeup properties to the MTU3 nodes so that USB wakeup is only
enabled after the MTU3 has powered down.

With this change in place, it is possible to suspend and resume, and
also to wakeup through USB, as tested on the Google Steelix (Lenovo 300e
Yoga Chromebook Gen 4).

Fixes: f6c3e61c5486 ("arm64: dts: mediatek: mt8186: Add MTU3 nodes")
Reported-by: Wojciech Macek <wmacek@google.com>
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20241106-mt8186-suspend-with-usb-wakeup-v1-1-07734a4c8236@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 2c184f9e0fc39..a63c59bc8e978 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1545,6 +1545,8 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg 0x420 2>;
 			status = "disabled";
 
 			usb_host0: usb@11200000 {
@@ -1558,8 +1560,6 @@
 					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_XHCI>;
 				clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
 				interrupts = <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH 0>;
-				mediatek,syscon-wakeup = <&pericfg 0x420 2>;
-				wakeup-source;
 				status = "disabled";
 			};
 		};
@@ -1611,6 +1611,8 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg 0x424 2>;
 			status = "disabled";
 
 			usb_host1: usb@11280000 {
@@ -1624,8 +1626,6 @@
 					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_XHCI>;
 				clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck","xhci_ck";
 				interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH 0>;
-				mediatek,syscon-wakeup = <&pericfg 0x424 2>;
-				wakeup-source;
 				status = "disabled";
 			};
 		};
-- 
2.39.5




