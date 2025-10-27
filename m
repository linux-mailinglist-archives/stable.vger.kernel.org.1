Return-Path: <stable+bounces-190028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342FC0EFFA
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B17024F832A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A8130B500;
	Mon, 27 Oct 2025 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcxwE5jv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA1B2C11CF
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579238; cv=none; b=ct8FiEKHCoD6RC6o2YUoBRV2GsEnQrQEYmnNgBhNQW5sOeZy+ndg7ZNwstRzt09NQHxHgGf5M0rrMZmkRHi1S1O6LgUqX2JhlEesjBLp+iSwduBgCG1x8fHlVwWNqS0H2HMCrNio81NY5Fn3EHJx72MrH0tMaT03wwzoq0ru5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579238; c=relaxed/simple;
	bh=kmDXcFGmBXvmS2fKYLglQmDQwoNErk+/6/UpvE5QyOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp+OC5dfb+YASd/R/RZq9+H0zpHVWxt78j1+HihlrTz33Z6Z8jpYyOq1ci1RTHoUEyolvL/ZTQCLwVFdSVgEscgBMsvdFCXrxX82egGpC3/QQLoPZmBd5WGF+k7wBKe8KtzEhIuQfTfIOSTn576W5TzKkHG+e84F9xnzJMuTe0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcxwE5jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BEFC4CEF1;
	Mon, 27 Oct 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761579238;
	bh=kmDXcFGmBXvmS2fKYLglQmDQwoNErk+/6/UpvE5QyOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcxwE5jvBSW+dESp3pcVF3eal8SX5R9pFDmPE/g37agdJybWJK0re9usqQ9Lt6mxU
	 32lfluQCU0xXS8AYsW7mki37zJUH8d/VnUB9qeLagcy0wSIp6/707Yl+Sip5gvZtlk
	 HJ+45KufvH/ZRzEbXMPaW9PiTzp2UKWGcJFoPogmr23odTFyk4Yaed3zj01YJENfAX
	 RyQikEAjaAB6QlzZzskflVXB9KN6d6C+ct/YjJz0bpRVD0HVJ/tW1Vfs45SAIedk8T
	 tmhgRbAMCi1LPFYHQJ1IHAPCjmXMSvho2cwKpikhNdo3enR+62HBaMtwlCDxT3P9PE
	 9CAqNXEwytIrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	stable <stable@kernel.org>,
	Jun Li <jun.li@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dt-bindings: usb: dwc3-imx8mp: dma-range is required only for imx8mp
Date: Mon, 27 Oct 2025 11:33:55 -0400
Message-ID: <20251027153355.553181-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102701-refinish-carrot-c75e@gregkh>
References: <2025102701-refinish-carrot-c75e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 268eb6fb908bc82ce479e4dba9a2cad11f536c9c ]

Only i.MX8MP need dma-range property to let USB controller work properly.
Remove dma-range from required list and add limitation for imx8mp.

Fixes: d2a704e29711 ("dt-bindings: usb: dwc3-imx8mp: add imx8mp dwc3 glue bindings")
Cc: stable <stable@kernel.org>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml       | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
index 01ab0f922ae83..82467e670a7c8 100644
--- a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
@@ -82,12 +82,20 @@ required:
   - reg
   - "#address-cells"
   - "#size-cells"
-  - dma-ranges
   - ranges
   - clocks
   - clock-names
   - interrupts
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: fsl,imx8mp-dwc3
+    then:
+      required:
+        - dma-ranges
+
 additionalProperties: false
 
 examples:
-- 
2.51.0


