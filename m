Return-Path: <stable+bounces-15253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F031838483
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CDC1C2A6B5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F66DD10;
	Tue, 23 Jan 2024 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bsESXM3o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9936EB61;
	Tue, 23 Jan 2024 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975412; cv=none; b=WHM4T7toZmscswZQtYcVHJGj6vtY4NZnrupNXiKFtaB2LVIKnpXQO9rmY0DFCjiCkebYeuaCAVf8fNYt5kJR7/61xNCemsISVq5TGU91x5OZZ/W0VVyNngOwR2aMmZ7g59CBkEeDVZA05v9VeR8+PADRwT1ptR9wBvYGGPgvcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975412; c=relaxed/simple;
	bh=mjqMEibQVMT0DS3eHAsiBQOrjwX+DQSW75jhtsrYUK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1kuvzoO83jQQSNEmNr/i0Mm5KvQRn2sRB4LZA4u7cbyhbBGVnwIpX7Sol3dZJ22+sdFdax0i3P8zWtfITm31As74+DkAJp+xkx27Awt+1Isvg8qw+31f2LPynbDTbnAmbjXtltUbx/aeJ+ojJ+DEQb8BLBuAZHhLEbVPTa3KAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bsESXM3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269B0C43390;
	Tue, 23 Jan 2024 02:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975412;
	bh=mjqMEibQVMT0DS3eHAsiBQOrjwX+DQSW75jhtsrYUK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsESXM3oHVm2uU1nd/ceuPcY7CSIFIJKTtov1nYDZhTzp/h2A1JZWJNFB0EBt/Ij2
	 1LO5PAoMf0O00npyD9XM1Ex8N5WwAJy+eV+P3vztxqoR4yPgte1cn+02FznlMd/wtm
	 Y+ikkXd9uVd6bZ9KrXvtz1KR3p1P+6FnFyrTuXZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.6 371/583] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: fix path to header
Date: Mon, 22 Jan 2024 15:57:02 -0800
Message-ID: <20240122235823.361348029@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 21a1d02579ae75fd45555b84d20ba55632a14a19 upstream.

Fix the path to bindings header in description.

Fixes: e1c4c5436b4a ("dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp binding")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231218130553.45893-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -62,12 +62,12 @@ properties:
   "#clock-cells":
     const: 1
     description:
-      See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
+      See include/dt-bindings/phy/phy-qcom-qmp.h
 
   "#phy-cells":
     const: 1
     description:
-      See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
+      See include/dt-bindings/phy/phy-qcom-qmp.h
 
   orientation-switch:
     description:



