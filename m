Return-Path: <stable+bounces-6812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48938147EF
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 13:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE77285A22
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D952F2C68A;
	Fri, 15 Dec 2023 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C/7qGxAk"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304C2D79D
	for <Stable@vger.kernel.org>; Fri, 15 Dec 2023 12:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9850C433C8;
	Fri, 15 Dec 2023 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702642944;
	bh=AH+1nXnzMeYQqMRtbURifilmfmK0d+ySkLVzATGJ3/8=;
	h=Subject:To:From:Date:From;
	b=C/7qGxAkcDllMeT+OpvTmjcXkw1rkDqy0WSYhhYdB7lpV7ICr6nZNJbIUeGHYw1pl
	 PY+M0TOiya/NjdxQKtb+1gSzv2JYpluVtsGKLQkai1m4CkTxKO7VLflaeHrL6JOWPP
	 z50H0y1fNYmdIuhm8Is+3kTOw0ig8iVrmO9tDwnk=
Subject: patch "dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp" added to char-misc-linus
To: festevam@denx.de,Stable@vger.kernel.org,conor.dooley@microchip.com,gregkh@linuxfoundation.org,srinivas.kandagatla@linaro.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Dec 2023 13:22:13 +0100
Message-ID: <2023121513-sputter-stole-9274@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a2a8aefecbd0f87d6127951cef33b3def8439057 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <festevam@denx.de>
Date: Fri, 15 Dec 2023 11:13:57 +0000
Subject: dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp

Both imx23.dtsi and imx28.dtsi describe the OCOTP nodes in
the format:

compatible = "fsl,imx28-ocotp", "fsl,ocotp";

Document the "fsl,ocotp" entry to fix the following schema
warning:

efuse@8002c000: compatible: ['fsl,imx23-ocotp', 'fsl,ocotp'] is too long
from schema $id: http://devicetree.org/schemas/nvmem/mxs-ocotp.yaml#

Fixes: 2c504460f502 ("dt-bindings: nvmem: Convert MXS OCOTP to json-schema")
Cc:  <Stable@vger.kernel.org>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20231215111358.316727-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
index f43186f98607..d9287be89877 100644
--- a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
@@ -15,9 +15,11 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-ocotp
-      - fsl,imx28-ocotp
+    items:
+      - enum:
+          - fsl,imx23-ocotp
+          - fsl,imx28-ocotp
+      - const: fsl,ocotp
 
   reg:
     maxItems: 1
@@ -35,7 +37,7 @@ unevaluatedProperties: false
 examples:
   - |
     ocotp: efuse@8002c000 {
-        compatible = "fsl,imx28-ocotp";
+        compatible = "fsl,imx28-ocotp", "fsl,ocotp";
         #address-cells = <1>;
         #size-cells = <1>;
         reg = <0x8002c000 0x2000>;
-- 
2.43.0



