Return-Path: <stable+bounces-21925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6677085D934
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AE7B24767
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A406BFCF;
	Wed, 21 Feb 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kJ0xLY11"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1069972;
	Wed, 21 Feb 2024 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521336; cv=none; b=n+nInuRIpOG/fG5Z/Y0/XtdTvbmGA7aV6CSlZWQ/AL+W6c1Qwlskqf3jJjOL0CtY6gkQhms1u/MP/9hvx0M97kEE6tA3Hx3fo/q/E2WghaWZAyDYdYRFNcCtfzxbHIEw7G63RFY6v+sVcr10HYivC4MuZjcrZlEUmdU4i+/ieJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521336; c=relaxed/simple;
	bh=AZfGF/vo317lH1VTaM7a47ExxBZxtdjbASpnnK9kaIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qf1BSXI5rTZBvv49ec/NO1ZG7IYZAWDcLiRh277Pa622hIFEHhb64/TdULfmm2WMvwJJkCxPIlDXWuiGZnKz8PLnGvqmbkOURhl78E2W5gKV4erSP/YZFm8FyXMkZ8U2jmT00zr+3DtzuYOpqawFXVFzrQqqOB1PF8Tm0xj3xWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kJ0xLY11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3909DC433C7;
	Wed, 21 Feb 2024 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521336;
	bh=AZfGF/vo317lH1VTaM7a47ExxBZxtdjbASpnnK9kaIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJ0xLY11MVPwoIjFsGCT0hXI7qTlhZqVFvBifDPEaqZ9qnrlSienaN77cni+2sdAO
	 74kSQgRLJmLvhyLqLaDSJFWoMPQgN+CQnN/SCjzAP1Cm7SHoXvXjzjG0dBHGRlmZZh
	 G5oZm7Kix3/Li3OurlWwEvOyqkKlTmXJwiAdy7mk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/202] ARM: dts: imx27: Fix sram node
Date: Wed, 21 Feb 2024 14:06:28 +0100
Message-ID: <20240221125934.606841158@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
References: <20240221125931.742034354@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 2fb7b2a2f06bb3f8321cf26c33e4e820c5b238b6 ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

Pass them to fix the following dt-schema warnings:

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx27.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 39e75b997bdc..ecfb07c8e185 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -588,6 +588,9 @@
 		iram: iram@ffff4c00 {
 			compatible = "mmio-sram";
 			reg = <0xffff4c00 0xb400>;
+			ranges = <0 0xffff4c00 0xb400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
2.43.0




