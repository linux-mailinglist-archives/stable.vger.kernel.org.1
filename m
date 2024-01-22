Return-Path: <stable+bounces-13346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DD1837CAC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6ECB28620
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A37C1350F2;
	Tue, 23 Jan 2024 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jvc8uxiF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B61350D6;
	Tue, 23 Jan 2024 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969351; cv=none; b=L/2R5fi9aS3SsbhVvDCXleagTQaU8SCT4dDsy5gb6LFacdJI04j3+Q1wxyMzcj5YHP5pppsnv09M/HGQGEhFaWX1FhzxTovVRxbC900JnHkmup49+6UDuErWUJBvagJhQRkEcU7K2pAumptQovilrrzMP7E93tqZgD13EyshMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969351; c=relaxed/simple;
	bh=DxKF9E1ohGYBT/7BNkCWqxYwQ4LQ9wgZGzbxI4yCENc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6BYGcvoDM3GM+R3JLg0T+QyBnXcT070KdL8rjOl8VXB1SBuz6XOrLK+m5UzYHeOWhGFUkVqSRhrLlhs6rN1iUQNnWT2PZqCFe63YIfLZRqeQ5NHCREmjDIN06bjl7rtbEgza8AKASzT9EIpEKitPmVyeBT7i/qwD5k+oKGYGz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jvc8uxiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB41AC433F1;
	Tue, 23 Jan 2024 00:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969350;
	bh=DxKF9E1ohGYBT/7BNkCWqxYwQ4LQ9wgZGzbxI4yCENc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jvc8uxiF14ybLPBd7h5HCF1GeeAoSDuemWLvwbhe/8GlveIRx1Ido6p5BRre15kRB
	 hI596VOQE7v8ol7PA/hKBjaalgelEb5nI1+gIzzc+6aEwjAGD5FqtqSd8dp6YTpEKf
	 cdJmAKVIo6YUbly5eVsTlHyZwAJgESTU8kcZwr70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eugen Hristev <eugen.hristev@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 165/641] arm64: dts: mediatek: mt8186: fix address warning for ADSP mailboxes
Date: Mon, 22 Jan 2024 15:51:09 -0800
Message-ID: <20240122235823.182711172@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugen Hristev <eugen.hristev@collabora.com>

[ Upstream commit 840e341bed3c4331061031dc9db0aff04abafb4b ]

Fix warnings reported by dtbs_check :

arch/arm64/boot/dts/mediatek/mt8186.dtsi:1163.35-1168.5: Warning (simple_bus_reg):
 /soc/mailbox@10686000: simple-bus unit address format error, expected "10686100"
arch/arm64/boot/dts/mediatek/mt8186.dtsi:1170.35-1175.5: Warning (simple_bus_reg):
 /soc/mailbox@10687000: simple-bus unit address format error, expected "10687100"

by having the right bus address as node name.

Fixes: 379cf0e639ae ("arm64: dts: mediatek: mt8186: Add ADSP mailbox nodes")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Link: https://lore.kernel.org/r/20231204135533.21327-1-eugen.hristev@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 021397671099..2fec6fd1c1a7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1160,14 +1160,14 @@ adsp: adsp@10680000 {
 			status = "disabled";
 		};
 
-		adsp_mailbox0: mailbox@10686000 {
+		adsp_mailbox0: mailbox@10686100 {
 			compatible = "mediatek,mt8186-adsp-mbox";
 			#mbox-cells = <0>;
 			reg = <0 0x10686100 0 0x1000>;
 			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
-		adsp_mailbox1: mailbox@10687000 {
+		adsp_mailbox1: mailbox@10687100 {
 			compatible = "mediatek,mt8186-adsp-mbox";
 			#mbox-cells = <0>;
 			reg = <0 0x10687100 0 0x1000>;
-- 
2.43.0




