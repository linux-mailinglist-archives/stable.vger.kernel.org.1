Return-Path: <stable+bounces-149016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B63FACAFCE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054B7480F4B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73371DE881;
	Mon,  2 Jun 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="brYVmyLF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC52C327B;
	Mon,  2 Jun 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872621; cv=none; b=AYv7FZqDionHgfFlZ0pVwQVX666iRHE8S8gBd7Q1/NBtB6RNT3FIqSsMFO6WgAXV6Xg/uBSbwIRUJEvVzrbtjZb6LlK+Y2BrjtIwIXavCWJN6w/KGkxt5wApX+AaFScn9zjBCbT+dlthyeg/7ttLZ8oC8XCD1HZgEtwDnRwB7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872621; c=relaxed/simple;
	bh=iAx4e+fb88pMnfpqYYiA8OBldNQ+YUlqePvnj2SJEOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCHn63KHfKbALEdSlSLL+TigAW7CUJcmGKVShqbZNMaYE47zlELy/GLb1KcAywJcEqMR72dl9PtaN0lS1RDdv6mqe/Y0N9oEkEKyTnJ3INYU09Vjy6A3aozEiIi9jYrEiZWYOliRLlp277ftKAitgOHE/K1TkosUS8sfK/l3oFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=brYVmyLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3515C4CEEB;
	Mon,  2 Jun 2025 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872621;
	bh=iAx4e+fb88pMnfpqYYiA8OBldNQ+YUlqePvnj2SJEOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brYVmyLFKKZPUt6Y3/jfFrTJX10026sfYnzUfjh0nDhnAhhisvCj0OMEZYshT6cnZ
	 S/Cht3LDw9W7ezPlek83wJqwrI9Ud8POoTNeuq1hn4dmPQeM0FBJ7j1lPiGt87H8xL
	 Ck+OgeM5wB1F959QQRXBzCaQYHR1RqbEXpw077dY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 6.14 02/73] arm64: dts: socfpga: agilex5: fix gpio0 address
Date: Mon,  2 Jun 2025 15:46:48 +0200
Message-ID: <20250602134241.773062075@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134241.673490006@linuxfoundation.org>
References: <20250602134241.673490006@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

commit a6c9896e65e555d679a4bc71c3cdfce6df4b2343 upstream.

Use the correct gpio0 address for Agilex5.

Fixes: 3f7c869e143a ("arm64: dts: socfpga: agilex5: Add gpio0 node and spi dma handshake id")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 51c6e19e40b8..7d9394a04302 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -222,9 +222,9 @@ i3c1: i3c@10da1000 {
 			status = "disabled";
 		};
 
-		gpio0: gpio@ffc03200 {
+		gpio0: gpio@10c03200 {
 			compatible = "snps,dw-apb-gpio";
-			reg = <0xffc03200 0x100>;
+			reg = <0x10c03200 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			resets = <&rst GPIO0_RESET>;
-- 
2.49.0




