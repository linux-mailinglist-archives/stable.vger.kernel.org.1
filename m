Return-Path: <stable+bounces-189924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9B0C0C18A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9B03B47AD
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA52DCBFA;
	Mon, 27 Oct 2025 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H5jUtI92"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8592DCBEC
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549786; cv=none; b=YUTNZPiP0PD+7FHErp7PbtIh9lwfDdVPuWoHKNeXDOPu58ZI24xkY6IJpsMMPCzafTnQv076brxPQ911Ldw3Y3DXkkxJmunYZ8J+FRxUcnMOmx7IpWxBRKHrnlC5e+nuaAV1TrzyqiRVzvfSd6VDeRzscYW7q02etroKiD7ff58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549786; c=relaxed/simple;
	bh=awoN2I2g8ICI+nRCK1sw6MV1ZjH1T5PKeSvGMxe11oA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eM7lW9fZYR2hMy7NW2/eBZVezHEcGixLYjzZ+VLZqC5FEvPonYxv2dlrAcvqxeY2QN2PoEzqhV1bYrGxN/D1YEmLTJCmNwy8PFZEJ7F01w5c34x1Fbk84iJq/OhBo01wZO+zihglv59KaGU5xhMhsrJnWSqAgIBLBphV7/wY3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H5jUtI92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E78AC4CEF1;
	Mon, 27 Oct 2025 07:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761549784;
	bh=awoN2I2g8ICI+nRCK1sw6MV1ZjH1T5PKeSvGMxe11oA=;
	h=Subject:To:Cc:From:Date:From;
	b=H5jUtI92W1tbZ3Z294WRxH+ydMzJs8ckolICmKaT7pNHSB7LlDO4Plh6yFKy0tU9Y
	 NY1nrlrqjgs3SKpxZNyiybAq6dlKN2V6Ka5yQKoABKsHHscKZLqb4GEuOvB3NpO9fT
	 cpx7o1MeW2kCbqTliiPUAxWHXDtnmc9OxoKmBxHI=
Subject: FAILED: patch "[PATCH] dt-bindings: usb: dwc3-imx8mp: dma-range is required only for" failed to apply to 6.1-stable tree
To: xu.yang_2@nxp.com,Frank.Li@nxp.com,conor.dooley@microchip.com,gregkh@linuxfoundation.org,jun.li@nxp.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Oct 2025 08:23:01 +0100
Message-ID: <2025102701-refinish-carrot-c75e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 268eb6fb908bc82ce479e4dba9a2cad11f536c9c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102701-refinish-carrot-c75e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 268eb6fb908bc82ce479e4dba9a2cad11f536c9c Mon Sep 17 00:00:00 2001
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 19 Sep 2025 14:25:34 +0800
Subject: [PATCH] dt-bindings: usb: dwc3-imx8mp: dma-range is required only for
 imx8mp

Only i.MX8MP need dma-range property to let USB controller work properly.
Remove dma-range from required list and add limitation for imx8mp.

Fixes: d2a704e29711 ("dt-bindings: usb: dwc3-imx8mp: add imx8mp dwc3 glue bindings")
Cc: stable <stable@kernel.org>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
index baf130669c38..73e7a60a0060 100644
--- a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
@@ -89,13 +89,21 @@ required:
   - reg
   - "#address-cells"
   - "#size-cells"
-  - dma-ranges
   - ranges
   - clocks
   - clock-names
   - interrupts
   - power-domains
 
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


