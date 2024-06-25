Return-Path: <stable+bounces-55413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA7916377
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632D9B20FF3
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B701494D5;
	Tue, 25 Jun 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U5JG0c8s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EFD1465A8;
	Tue, 25 Jun 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308830; cv=none; b=oIih2RTGELrEeay27ucAbEcVf2BdiBAamSXpuNPVduFFclkuKrjJlngzIWDJmcuZW3dZAzt1CRwwzAMruTCyIRAlVOALPCk0e7mDT6MZvDo+/awlGY+mkIsi8iroRi9GR6VdOvn9Cud3KZ1hePrY2xEb7izXzCSGHtQtDYCVjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308830; c=relaxed/simple;
	bh=eeJLAwzspyz2Brdsd1KiQM1lBdqkxVlAwXVfLVDmfcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TykfW30MQL1qVzrLvn93RkKAiqKI9nj/QUGJS5z4igZX639+A3EWF3kPjCu6ItINsj8VBUqzNQhipDRPDyVv9XnpH5cyj7493guWafWK2ZH2lTuMSo3cQ+RM5MAJLnoD0wpzD3usWJCziCvntcMubDd+jUFvUs0oJvaR7ryL1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U5JG0c8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1FAC32786;
	Tue, 25 Jun 2024 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308830;
	bh=eeJLAwzspyz2Brdsd1KiQM1lBdqkxVlAwXVfLVDmfcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5JG0c8sgWEKBiAe7OUtcIKnRYtjXaYlyIiLQqQK+j9qVI/Q7NYh0no3ATL21wQqV
	 jXmSbwZCf7uGSuQsarRTOzbVfo+/FUYjrL/b2v+HnjqJFDLDN49Af5hn9bcimY9BGA
	 MLsfOcLDOM8HwZ8FLHrR2rHsrX9q8GEfPJwO9mQ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 6.9 235/250] arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc
Date: Tue, 25 Jun 2024 11:33:13 +0200
Message-ID: <20240625085557.075122307@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Li <Frank.Li@nxp.com>

commit dfd239a039b3581ca25f932e66b6e2c2bf77c798 upstream.

The gpio in "reg_usdhc2_vmmc" should be 7 instead of 19.

Cc: stable@vger.kernel.org
Fixes: 307fd14d4b14 ("arm64: dts: imx: add imx8qm mek support")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -36,7 +36,7 @@
 		regulator-name = "SD1_SPWR";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
-		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		gpio = <&lsio_gpio4 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 };



