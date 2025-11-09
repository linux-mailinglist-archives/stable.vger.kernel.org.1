Return-Path: <stable+bounces-192851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EC1C44355
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 18:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57533B42DB
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20C53043AF;
	Sun,  9 Nov 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="PO3jGN4O"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE9303A39
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707977; cv=none; b=MbBL0ENaFYhVmbCVxKmRpsMEYNbPzptIREXW3f0tM/ZXrTJCveBVled9A8hMymDDTC06ZKJRJQkODyueliEahEdFouA4JjcABQNBEDF0giuLN1nKYFcFBv8DQ2QVfTwEPaw5yg9uY1+LKFbCJlTA8RAoiBICImaRLf/510QbEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707977; c=relaxed/simple;
	bh=hixGnyCiJkbLF2rf11XmLlhnL534vXHietAHClgNN5E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kPsNA1kA23Lh7Gz5Ch3PVhY0Y2IQtqbJdKcReSC72MjioM41cfW2wjYvzCbHI6bnW2uBezfwGZEAg7x+aLlW7x23yAhhTmY7r0Fr/Bsva4H41vqQeQhrXVTSeuiBJnRSsUIJbLpBrX+b/KaJFjXBRjKa5TyloGly38AZq1WJXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=PO3jGN4O; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762707963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZGL6vN01C4fpVYtMS2FjDXAheoK7OIOq3/QZwzVz6I0=;
	b=PO3jGN4Ozros9j3l2U07INj40Af2D4ml7LcHGzWPa7uIZ8xTXXkGjohxb2akm+VFyvrJKV
	T9FM5+PSPHXFV2snPZ8DPCTCxbpj55UVzS2v90khbSFokWOK4+ObTg7FeKrcGQeFYmby3p
	aVxoCpzYuQAZjF0wJZVsvbVlx75VKbbB7ulLGPJZNFuxcWcAJlZ7YDbs2hcmRkoac4nZEC
	LWLIDcz6YaoPzzWqmjIN2JYid3HIvORz9/GrZmJT7W02h0BCL3QLHLF/PdqR7PO9I3v8G3
	NvKb6mON2bwIVt/gwqYsERVbsNhLVnbcxB1O7AgglQC/tuv4Vg74yhHOVmXe7A==
From: Diederik de Haas <diederik@cknow-tech.com>
Subject: [PATCH 0/2] Fixes for PineNote DT validation issues
Date: Sun, 09 Nov 2025 18:05:25 +0100
Message-Id: <20251109-rk3566-pinenote-dt-fixes-upstream-v1-0-ed38d200cc04@cknow-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANXJEGkC/x3MQQrCMBBG4auUWTvQJG1BryIuov2jg5iGmVSE0
 rs3uPzg8TYyqMDo0m2k+IrJkhvcqaPHK+YnWOZm8r0fnevPrO8wThMXychLBc+Vk/xgvBarivh
 hl+7BI6UhIFL7FMW/aJvrbd8PUHkyX3MAAAA=
X-Change-ID: 20251109-rk3566-pinenote-dt-fixes-upstream-1fb32eff43ea
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel@sholland.org>
Cc: hrdl <git@hrdl.eu>, phantomas <phantomas@phantomas.xyz>, 
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Diederik de Haas <diederik@cknow-tech.com>, 
 stable@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

These patches fix the following DeviceTree validation issues on the
PineNote dtb files:

    Warning (graph_child_address): /i2c@fe5c0000/tcpc@60/connector/ports:
      graph node has single child node 'port@0', #address-cells/#size-cells
      are not necessary

    usb2phy@fe8a0000 (rockchip,rk3568-usb2phy): otg-port: 'port' does not
      match any of the regexes: '^pinctrl-[0-9]+$'

And with these 2 fixes, there are no more DT validation issues :-)

The fix for the 2nd issue also fix these kernel errors:

  rockchip-usb2phy fe8a0000.usb2phy: Failed to create device link (0x180) with supplier port0 for /usb2phy@fe8a0000/otg-port
  rockchip-usb2phy fe8a0000.usb2phy: Failed to create device link (0x180) with supplier 3-0060 for /usb2phy@fe8a0000/otg-port

Cheers,
  Diederik

Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
---
Diederik de Haas (2):
      arm64: dts: rockchip: Simplify usb-c-connector port on rk3566-pinenote
      arm64: dts: rockchip: Move otg-port to controller on rk3566-pinenote

 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi | 27 +++++++++--------------
 1 file changed, 10 insertions(+), 17 deletions(-)
---
base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
change-id: 20251109-rk3566-pinenote-dt-fixes-upstream-1fb32eff43ea

Best regards,
-- 
Diederik de Haas <diederik@cknow-tech.com>


