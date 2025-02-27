Return-Path: <stable+bounces-119816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52958A47779
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACAF188EB15
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4818722686B;
	Thu, 27 Feb 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfO1Gbxl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2340224B00;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644100; cv=none; b=RijK7hdEawBlU6Wf54yQWdDtWN1x4x4YBRMcqtf1q4TKpuHMXoQTqL4Y7k3YXxC+ucJs0NFvjXkwGsL7AfmwDkaPOmdUYAH0inNEXGni6bdJ1wBxErUJonH5vmR8EuxlLBzLIrFVWo+hsGQV0Ukdq1fqQNbUkB969VyL0/hdYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644100; c=relaxed/simple;
	bh=mcUPR1aggB75LARfw7KOJ+hvk8u5or9Rv76qOw3suGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG7p9X6SvQTX5C/UswX3rnHJaVop2K52SE2TQQZsSzuOvKO+pdQlM1rdWukJzUGx7z4X9hOoi8eD8VEupApSqPt4ECsprpbszwNvkfzfY29pbKy3Fh1NUl+DIktpaTKLTFfMWDMZZdmyoC9A+g/7Zv+FirgJ6l8oQc2ID7W+Ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfO1Gbxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C355C4CEFA;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644100;
	bh=mcUPR1aggB75LARfw7KOJ+hvk8u5or9Rv76qOw3suGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nfO1GbxlQiw+vtfoZu3Kh+LysBIgk5If8+O52dXO96XZLDm+KwfeZVnXGjYQMH3hN
	 b5V2YYu4HoLaeFBwrNU2GgmWIlXya8bVbzJGmWvR/S9dYFRFdNv4Fo0V9hbDp9sCnJ
	 erYIijFb+/0mfBNx/zRFYhSXXJ4jbwaMPI6bES9YyncjGvZ03CFVbGKjEQI9Zqkk3J
	 XZgX3+AcJRt1XxFAxHalKgQnhsVuMkt3GEFfon3CMSOF6zf3LRYm5ojstFNwZeVmoq
	 nLtQTw6Z3TixAqnKLKAPm2086QGaXDI/9iE9TntZ95RX4L4wcProYADAtuE92XGRGw
	 rDUoXYRNCqj9g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tnZ33-000000006md-3WQY;
	Thu, 27 Feb 2025 09:15:13 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Subject: [PATCH 5/8] arm64: dts: qcom: x1e80100-hp-x14: mark l12b and l15b always-on
Date: Thu, 27 Feb 2025 09:13:54 +0100
Message-ID: <20250227081357.25971-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250227081357.25971-1-johan+linaro@kernel.org>
References: <20250227081357.25971-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The l12b and l15b supplies are used by components that are not (fully)
described (and some never will be) and must never be disabled.

Mark the regulators as always-on to prevent them from being disabled,
for example, when consumers probe defer or suspend.

Fixes: 6f18b8d4142c ("arm64: dts: qcom: x1e80100-hp-x14: dt for HP Omnibook X Laptop 14")
Cc: stable@vger.kernel.org	# 6.14
Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
index cd860a246c45..ab5addb33b7a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
@@ -633,6 +633,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -654,6 +655,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l16b_2p9: ldo16 {
-- 
2.45.3


