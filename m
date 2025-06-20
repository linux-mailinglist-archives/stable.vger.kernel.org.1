Return-Path: <stable+bounces-154845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71FEAE1095
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 03:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F0A6A132F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 01:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78C944C63;
	Fri, 20 Jun 2025 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="xGITznBV"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C14186A
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382009; cv=none; b=cp24fglf+jskx9jhfyRl1mmjGtv7iNklrsg6gHWumf4RCyyGpMY+W5gf0K0VTfGkJeXrvm5KWDabx9Cc1l+QM93fOFH9S2+HqclybbHgO4TmGqv0WIl8wILt6b62XkRHa36pZegzNEVvk/msjy7xXydzmb2eiXYBbH/W4Y8u0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382009; c=relaxed/simple;
	bh=XtX+io/IcD0dCnLVDFticywsyiaRb6sWCyon/+LD6aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qzNojCNnKxCSZgQ4Srcs1YpRtlXHA993srGLrM+7FgMAvi6eaVSUU6hX3K2QQIshse4KryNOJ452pF+ryAEsBPAMG4KuSONqIKy78F7cm/lWTtiEjuK/d5GFXZtI/nI/frDFJ1lw9ja5sfBnHDi0VflKFqh5bx260/cQUiEFaT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=xGITznBV; arc=none smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1750381994;x=1751591594;bh=XtX+
	io/IcD0dCnLVDFticywsyiaRb6sWCyon/+LD6aU=;b=xGITznBVUv6f2kQnm73HqjzsOoj5GIGPXO
	mr1hJkjCzQdaTfYT4oMoU9ORsoV56bnXNTY8GG2XYQ7790zMPVMF8IYVDLza8vQcoof79Uruhv5aj
	lzoVkxCLPoa8j0Ux/CY1M6egkCPdOsQA9DHXLxbCvS0AL7fIaWaR+JRez20rAfKyFOQLPJKTOOExB
	JLJqxHbklrGDdlNHX3416C10QAEaqsuOIjDF0nxlKI0Vnd02Rid6ZmqHkVPT23R2mNBkZaGOvrUB5
	wOrU0D5SRShJwhxOQgBJpi9l7Jr8oaoqfP27TmUBp4vFdYLNYaehAWxYvFQvQcFBstRzUDdL0CfNQ
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55K1DD7l043984; Fri, 20 Jun 2025 10:13:13 +0900
X-Iguazu-Qid: 2rWhEqwpmMMDo9Nahm
X-Iguazu-QSIG: v=2; s=0; t=1750381993; q=2rWhEqwpmMMDo9Nahm; m=3Dkr/BaQSEyyLQWciD/IXWkxv4Zm7bHOEDCS1Sc+9Gg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 55K1DBxX425524
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 10:13:12 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: cip-dev@lists.cip-project.org,
        Colin Foster <colin.foster@in-advantage.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.4 - 6.1 2/3] ARM: dts: am335x-bone-common: Increase MDIO reset deassert time
Date: Fri, 20 Jun 2025 10:13:06 +0900
X-TSB-HOP2: ON
Message-Id: <1750381987-6825-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1750381987-6825-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1750381987-6825-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Colin Foster <colin.foster@in-advantage.com>

commit b9bf5612610aa7e38d58fee16f489814db251c01 upstream.

Prior to commit df16c1c51d81 ("net: phy: mdio_device: Reset device only
when necessary") MDIO reset deasserts were performed twice during boot.
Now that the second deassert is no longer performed, device probe
failures happen due to the change in timing with the following error
message:

SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5

Restore the original effective timing, which resolves the probe
failures.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
Link: https://lore.kernel.org/r/20240531183817.2698445-1-colin.foster@in-advantage.com
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index e2efc4256bcb..b58b8b76724b 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -384,7 +384,7 @@
 		/* Support GPIO reset on revision C3 boards */
 		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <300>;
-		reset-deassert-us = <6500>;
+		reset-deassert-us = <13000>;
 	};
 };
 
-- 
2.25.1



