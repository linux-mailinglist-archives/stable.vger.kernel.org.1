Return-Path: <stable+bounces-154858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E37AE1159
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 04:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB384A2EC7
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 02:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6B41C6FF4;
	Fri, 20 Jun 2025 02:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="c8e9LJC2"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1800.securemx.jp [210.130.202.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25B23CE
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750387880; cv=none; b=aZz9zrIwNcqtdjP23HcXo63LO6htv12TxBXM5LUhDE8vQYcd2KaaxTg077poyci4+dIkSCXM3QJzbSW+0nEqyJ0P/IFSqDLL1gzjqEPIH/5ybPcbL4DCeZtuwMmmnzzDcD1t3CEpr449HEYacUQDvPAFUEbbPVJLMrhmGP31qJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750387880; c=relaxed/simple;
	bh=Ste5a9umI3kJtXRgSJE5CM/JE2VIKdpsHauZHo5nXfo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NMJzce9y5tI0VcK5kUrMD1j3TQbVoxC1F3ccncu7EjIXpWgrQzldXq58BcWWtb7wYC6yuMfgOY/yhlXZUEBz062LmcveUtmp1mgl0Se+7ZvodL8XmVvY829BPbrpAowutKUDXQ+xtfQoOCvoxwtjFf3dv9PHCTFesAS35G4hPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=c8e9LJC2; arc=none smtp.client-ip=210.130.202.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1800) id 55K1AK441027564; Fri, 20 Jun 2025 10:10:20 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1750381801;x=1751591401;bh=Ste5a9umI3kJtXRgSJE5CM/JE2VIKdpsHauZHo5nXfo=;b=c8e
	9LJC2jbXpjz02ywt/83HPBJRFo4zleexhWHhb6h/xmv5p50aS4VEmtdUDI98rk/N+th0RIzgHCKUR
	NgUa93p7bMaHDVDtY5fgFGHq8ZNFjam91qjFsQ0EKRs31Ta8QSRN9dP9zkWraThZipxzOeyi5BCwU
	CZw2X4yDJEjIkf+NV8Df4xRGMjC4AO/QpEsFx62lfSf7tfinmCTQPyC/Xb5gVJunTAcI01+44UCD/
	IUWrnufC1BOCayj0BNIjAtX7dfHuAg6jAVwvJCFTifIAxs9NQa0ZNFPBYGkg8t+n1561UjH8Y56xV
	CYPh0hkXmIR/xOrMpAQMHCpUOL7rXYw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 55K1A1aQ3100969; Fri, 20 Jun 2025 10:10:01 +0900
X-Iguazu-Qid: 2yAbAvUQOulDXivw6K
X-Iguazu-QSIG: v=2; s=0; t=1750381800; q=2yAbAvUQOulDXivw6K; m=EU1J//4IWXVMwh2b9xms/ykRkJoXSRHSVj9VxIlX7SE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 55K19wnb701107
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 10:09:59 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: cip-dev@lists.cip-project.org,
        Colin Foster <colin.foster@in-advantage.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 6.6 1/2] ARM: dts: am335x-bone-common: Increase MDIO reset deassert time
Date: Fri, 20 Jun 2025 10:09:55 +0900
X-TSB-HOP2: ON
Message-Id: <1750381796-6607-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
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
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index 96451c8a815c..4867ff28c97e 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -385,7 +385,7 @@
 		/* Support GPIO reset on revision C3 boards */
 		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <300>;
-		reset-deassert-us = <6500>;
+		reset-deassert-us = <13000>;
 	};
 };
 
-- 
2.25.1



