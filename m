Return-Path: <stable+bounces-198604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF5ACA1418
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEAA732F9649
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217D32F763;
	Wed,  3 Dec 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lfxds+U4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68632ED59;
	Wed,  3 Dec 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777092; cv=none; b=GnhUiZ5YfDbyyGR93mBvm7kkuLwXMTSfUoZH8QLIbf9ZyJMc1jm3PRx16V0Dva+3KqqGF7iS3L3hzlKCoego4vdUQUdlt2auPepDEK2Pt2IvrQDf+PmQcc7Z3Qx0Y+qRwPcpR18+1asY4E/OsJN3Nf2YsOWvWojzlxJL4noWTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777092; c=relaxed/simple;
	bh=Q5L58/OoCqMsuekIGRul2N93B5hT8dAUdRijkLAJjrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVpA9S5Q//cwAPnsxGrAGX5BogEME1DgG86U1eO1qMcYsc5hYWzOeSGIIoyyZcA9G0Bl8wDlvPwvKCxDXZ4aPaFT/28f0wKpgIMbZB5aqDqFjONqsVGQGpHAC2zQclkSlRPFidTMFBRxTpysVGh3w6uLT0BQ24SZMbbD663JaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lfxds+U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C801C4CEF5;
	Wed,  3 Dec 2025 15:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777092;
	bh=Q5L58/OoCqMsuekIGRul2N93B5hT8dAUdRijkLAJjrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lfxds+U4yA42SrrLRYszIYRzuFUe0BrEFjL8KNmIds/VI5nkhJWtjQG6ETCRrJzyJ
	 eKhSABPjmD59sE+T8CxEs5U6lSKBFreVLre2G7VzBgeoqmVy7O/C6CIHSmFLDuJZTP
	 35YMoU91KhnBTAvAohCFtjRAp+RiA6DAyZQtY34o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maarten Zanders <maarten@zanders.be>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 6.17 080/146] ARM: dts: nxp: imx6ul: correct SAI3 interrupt line
Date: Wed,  3 Dec 2025 16:27:38 +0100
Message-ID: <20251203152349.392495539@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maarten Zanders <maarten@zanders.be>

commit 1b03346314b791ad966d3c6d59253328226a2b2d upstream.

The i.MX6UL reference manual lists two possible interrupt lines for
SAI3 (56 and 57, offset +32). The current device tree entry uses
the first one (24), which prevents IRQs from being handled properly.

Use the second interrupt line (25), which does allow interrupts
to work as expected.

Fixes: 36e2edf6ac07 ("ARM: dts: imx6ul: add sai support")
Signed-off-by: Maarten Zanders <maarten@zanders.be>
Cc: stable@vger.kernel.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -339,7 +339,7 @@
 					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
 					reg = <0x02030000 0x4000>;
-					interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6UL_CLK_SAI3_IPG>,
 						 <&clks IMX6UL_CLK_SAI3>,
 						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;



