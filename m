Return-Path: <stable+bounces-148986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F0ACAF97
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1F27AE438
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D778221F12;
	Mon,  2 Jun 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mh3gctdB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D7221F0A;
	Mon,  2 Jun 2025 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872169; cv=none; b=I2qzfGPIJv/h3TZPSXXQFeVYK4kvCTpfZ5huRZryLg4qRG+qqllrI87ejTd7qQC2EUlL+/jiseBPUm9gw0lFWmrrzibmmFMDqA5aidlgOXWjbS76g4qk6FAoXr/wPTRW4QUDve8A8SQDz2FNkMoOcDYdxSjBy8rIHJfgeIn450g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872169; c=relaxed/simple;
	bh=qD8gyQtvzLXoSeSoSWBxeIIXlVbo0B4xaXOdl9lU4Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPF0VzMmawlwxDGBm8eOcpDYgkYJGFUVh/nGKEpcfUtq6j2lYwfcj2NwJkCy+tJrGedcr3aIh86ohjwaCphQWXl5O75lAdE9w9xISEE2fVEsKkiVyNw7MDgNhs2ogCKz/KyS3SUsTPH9pxJz+oVGZdUVE9ebDZyxcNweyTBN4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mh3gctdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DE8C4CEEB;
	Mon,  2 Jun 2025 13:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872168;
	bh=qD8gyQtvzLXoSeSoSWBxeIIXlVbo0B4xaXOdl9lU4Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mh3gctdBpjIH6P2mau6UajEmSjLuzor9X13ASxB3wNiLmqQRl9IAzcbJvfDITbIUL
	 +Ci4NPWXvYnj7rYF3vG3Ix8nXQPcIOyqeaG6yt8WNYAUTCrYxVX65DEl7X1ifFXjR0
	 ROhn8TGI2nTD5c+KmK/xDgsXfaUE3zrhhrwX547Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
	Neha Malcom Francis <n-francis@ti.com>,
	Jai Luthra <jai.luthra@linux.dev>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 6.15 32/49] arm64: dts: ti: k3-am62x: Rename I2C switch to I2C mux in OV5640 overlay
Date: Mon,  2 Jun 2025 15:47:24 +0200
Message-ID: <20250602134239.206732699@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
References: <20250602134237.940995114@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>

commit b22cc402d38774ccc552d18e762c25dde02f7be0 upstream.

The OV5640 device tree overlay incorrectly defined an I2C switch
instead of an I2C mux. According to the DT bindings, the correct
terminology and node definition should use "i2c-mux" instead of
"i2c-switch". Hence, update the same to avoid dtbs_check warnings.

Fixes: 635ed9715194 ("arm64: dts: ti: k3-am62x: Add overlays for OV5640")
Cc: stable@vger.kernel.org
Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Jai Luthra <jai.luthra@linux.dev>
Link: https://lore.kernel.org/r/20250415111328.3847502-8-y-abhilashchandra@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso      |    2 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
@@ -22,7 +22,7 @@
 	#size-cells = <0>;
 	status = "okay";
 
-	i2c-switch@71 {
+	i2c-mux@71 {
 		compatible = "nxp,pca9543";
 		#address-cells = <1>;
 		#size-cells = <0>;
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
@@ -22,7 +22,7 @@
 	#size-cells = <0>;
 	status = "okay";
 
-	i2c-switch@71 {
+	i2c-mux@71 {
 		compatible = "nxp,pca9543";
 		#address-cells = <1>;
 		#size-cells = <0>;



