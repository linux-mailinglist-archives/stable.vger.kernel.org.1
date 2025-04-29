Return-Path: <stable+bounces-138175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 642E3AA16BE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D4C7AB85A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FB8242D68;
	Tue, 29 Apr 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RjBppcOi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F81917E3;
	Tue, 29 Apr 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948407; cv=none; b=r30u6Xfc58JgiNeaB/pBgeMTNgAJ+ytdNy27Td74W2+dBkFWws6AL0W+CrWMdxxIClyxtr1qx7louPWVjGpmjyk5OJA0VTdTy+bwhNjJGDK+HcemT8ZNktdjrAC7H7+avYZTe7EHjM3YkPT+zso2eE39VIpsQy6Ak7/Pt8ibXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948407; c=relaxed/simple;
	bh=Ki3i2Rqe8ShcBUhEzanqRzhzLGaAlaMVLpM5H5PJfYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb8bvDvpRpcxxmNgwqVjQ45u1+ilyaQ5acmGTvoNXmquc9J4U1B/m3xbj3kZ97xYCmPLSHK2lnvypT82NCzYKp833zsw1V5eAA2pru7E4CVWLqQ834dpK4cGNKRKaV9AvD0BrwjPhja4ICqA+Ubw/E1eR8yWy3vzWNnqp7TE7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RjBppcOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD096C4CEE3;
	Tue, 29 Apr 2025 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948407;
	bh=Ki3i2Rqe8ShcBUhEzanqRzhzLGaAlaMVLpM5H5PJfYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjBppcOirDxJZNvLU5bafUXl91Iqq8aNI2Z1Lka/KiCECOXMYumm5lgr9lD98S3OA
	 aKcGKgW2HotTZ73sf8sZrOb2zhQEuW8Xp18izbX/0Tb8d/12YgEtCCRcC9krbAz9EF
	 wj9yuqtFlET07L2vA9Xp/5j/S5jb3Bdi3wXRMsZ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keerthy <j-keerthy@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 6.12 279/280] arm64: dts: ti: k3-j784s4-j742s2-main-common: Correct the GICD size
Date: Tue, 29 Apr 2025 18:43:40 +0200
Message-ID: <20250429161126.548510996@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>

commit 398898f9cca1a19a83184430c675562680e57c7b upstream.

Currently we get the warning:

"GICv3: [Firmware Bug]: GICR region 0x0000000001900000 has
overlapping address"

As per TRM GICD is 64 KB. Fix it by correcting the size of GICD.

Cc: stable@vger.kernel.org
Fixes: 9cc161a4509c ("arm64: dts: ti: Refactor J784s4 SoC files to a common file")
Link: https://lore.kernel.org/r/20250218052248.4734-1-j-keerthy@ti.com
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -195,7 +195,7 @@
 		ranges;
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
+		reg = <0x00 0x01800000 0x00 0x10000>, /* GICD */
 		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
 		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
 		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */



