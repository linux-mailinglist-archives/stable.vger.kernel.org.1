Return-Path: <stable+bounces-64558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CA1941E6B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D895C1F25568
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47001A76DB;
	Tue, 30 Jul 2024 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Obv5PbIs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726371A76C1;
	Tue, 30 Jul 2024 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360518; cv=none; b=ldA2xwx3jQzaS046z7/TSFPChScA+WQCN6XCN4mw1H48FR1aOsow/+qxC3oqtqjuthIvd4TmgeAth+ytnjE3HAoXbLK5Zcf5SQ7ewlyq+bA1cJYrHw+JnQV22o9cC379XZ50QF1ynpnci3jD3koT74YxqC7qsaQC/unHI8tmwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360518; c=relaxed/simple;
	bh=O2FUSQCw4hqWtsbDoZ5o4CVKqLP2i+FV/4ZPA7LaNGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAOskb9hDSbmYfpS0mloQUNeT32/Dzw9yPXPcSCtEtCG4PZDQY8K1gOR79lQQJztqoZNrXA7vFMa1yP9Xtvfc4d6o80639+46d3X2yJFQQuuy0ue/MHpWAooehHUL6EPHu+r5vb4ADi3WCzq2c9lQ1gUQg7Yy+u42OZY3xJ29LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Obv5PbIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAC4C4AF0E;
	Tue, 30 Jul 2024 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360518;
	bh=O2FUSQCw4hqWtsbDoZ5o4CVKqLP2i+FV/4ZPA7LaNGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Obv5PbIsyTfBC4FQbSd7+xW7qmFS4BBhHtNQRtCcM6p56Af/FPS7hzN2nandNotie
	 vI2JBsUsM5F7XiH4JWBVzlpK86H9YTeT1eTC34rVU7MQ9ScEaphGp5+3Lva2kyOOjG
	 ZOdjAsONJjQAE/2wi1wEVp+PbmUIm5UTWpgcM+xQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.10 722/809] MIPS: dts: loongson: Add ISA node
Date: Tue, 30 Jul 2024 17:49:58 +0200
Message-ID: <20240730151753.454783293@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

commit da3f62466e5afc752f8b72146bbc4700dbba5a9f upstream.

ISA node is required by Loongson64 platforms to initialize
PIO support.

Kernel will hang at boot without ISA node.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -52,6 +52,13 @@
 			0 0x40000000 0 0x40000000 0 0x40000000
 			0xfe 0x00000000 0xfe 0x00000000 0 0x40000000>;
 
+		isa@18000000 {
+			compatible = "isa";
+			#size-cells = <1>;
+			#address-cells = <2>;
+			ranges = <1 0x0 0x0 0x18000000 0x4000>;
+		};
+
 		pm: reset-controller@1fe07000 {
 			compatible = "loongson,ls2k-pm";
 			reg = <0 0x1fe07000 0 0x422>;



