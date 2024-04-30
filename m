Return-Path: <stable+bounces-42356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395458B7296
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE0B1C2299D
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E7212C805;
	Tue, 30 Apr 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XrYPEhpb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272691E50A;
	Tue, 30 Apr 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475405; cv=none; b=BEaGumeY9JeDXyp93OBIuBKaT+kP8plMUPNAG5Zdg+gHDRZF97ISpOtBH0wgMHBLhIZ8N0F5yDuuSxDYfZFreM168W2PB3kBxRVOUS1eMGLDcY2MlRlUC/S18v+DMXZLWhz9RbK6TBFcLBCuldHS0GZfDpW4vEq/vqWedCfyXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475405; c=relaxed/simple;
	bh=/jBvmapyQJ694o2UsZ0v/dSLFfYqGmUFzPhkf7g7z5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yms/PWz4VwkiHzXZ1YRANrgJPQ97bNXMmbCvj9aErI8xvDh6zGTaG+ygnEQHyf0pd583qAt8PJl8LkfNZr454siqVti7iXCbjZbQbrrGa6D5LPonyQwGOGn75k+DkspzVW1/3T81EtQPPDqyBbkOPL2/S2mHzKJUG59IGwjHbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XrYPEhpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5CCC2BBFC;
	Tue, 30 Apr 2024 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475404;
	bh=/jBvmapyQJ694o2UsZ0v/dSLFfYqGmUFzPhkf7g7z5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrYPEhpb/dZ8DzMcstBTcWc53dE3M2JB2rnRpAzutHUVUzHeFPUlsXDLeqgcPsY60
	 hvYYsInvsIjfvXBLHDvHYtpVHIRn2to9DtPt0GH2z1k7dctNaJU5qdY0fsausi/QbU
	 9WRBx26xakcBqq+3yTsASrtPmpOGi9xF2C5SqEp8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Heimpold <michael.heimpold@chargebyte.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 085/186] ARM: dts: imx6ull-tarragon: fix USB over-current polarity
Date: Tue, 30 Apr 2024 12:38:57 +0200
Message-ID: <20240430103100.501645495@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Heimpold <michael.heimpold@chargebyte.com>

[ Upstream commit d7f3040a565214a30e2f07dc9b91566d316e2d36 ]

Our Tarragon platform uses a active-low signal to inform
the i.MX6ULL about the over-current detection.

Fixes: 5e4f393ccbf0 ("ARM: dts: imx6ull: Add chargebyte Tarragon support")
Signed-off-by: Michael Heimpold <michael.heimpold@chargebyte.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-common.dtsi
index 3fdece5bd31f9..5248a058230c8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-common.dtsi
@@ -805,6 +805,7 @@
 		     &pinctrl_usb_pwr>;
 	dr_mode = "host";
 	power-active-high;
+	over-current-active-low;
 	disable-over-current;
 	status = "okay";
 };
-- 
2.43.0




