Return-Path: <stable+bounces-96023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6EE9E02E6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B5F286DA5
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B11BA95C;
	Mon,  2 Dec 2024 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ZIbY4t6t"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCAE1FC115
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144970; cv=none; b=iqmXs5LFEC4r2ZKhd652UXM3AJyjpBJd0UJ2+RXBAgSp/CCJg2o0jrW5ySoGKE91qLvvzQIh6mttQ+qUJmZ0X1DP0gM0reWOru6+5xcGBBd960D2YkCWPmTfjX3F5TTqCnLRMzB7ItOpmzWPSrBWbHPEnb9DoL0Ce9VcFDfmVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144970; c=relaxed/simple;
	bh=AsmS0O0LobS4HF34MnQU1zcw4SRgmr4teuSJuhQf67w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ru3A6DXbHwFYYMu8bjoquZdv9dVWatpjwdAUjQAbHkJ89MwdyIeA5bqPdHDTO7s6rwfF7xfxlHSc9/RxBp11pQZHDR4xdMygoPy4CQWSBknBy+kIbI5CRFYJ9MAIFJORtrANyCCXBqi/hYvarUUz22tXPiiU9P0WmRcoiBEl5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ZIbY4t6t; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 2EA89A00FF;
	Mon,  2 Dec 2024 14:09:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=YOuKY9km4OF/f7YVbyq/
	ULvcl4sIlXanZsvH0J4LkgQ=; b=ZIbY4t6tS+Cu7W7rtSkFpmGcXTWhJIv6mAH2
	e4yj/LpFRN6UTSwNcDAyBefoVWku+xepRWcbN0VMCzZboqKFC/RugXNxt3ZkD/mC
	qe1LfQ8d8gVPg7/Nv4OOPglRBCwUrarydgYD2DZxBMvtK9AsU9Xw01NYQHGczhtt
	aPJwkLDNuhkA8p1x+X+wFToSG6MS7SCVP4yvJroFQ9RPNRhOilpXW04J8qX4BDAn
	Qmm4ojOOk7kfVUo3dBWhZlerdonxf1vLcEvXLqcDAPlUlqZUwioJDrDvEjL/4mrn
	B4HwSo5D3QZk1SBwuE8ehDiPv3Nw0nszkt2baAVq1deVuRSVYHFKYSgHI0vfaLo3
	S3XZ8XPisUS9IbZyc/kLgdvNBpLbo7QZrIGEEOR1/7+yM+8LFXaAMEO47/GzRYN9
	iUHG9MN5wRYhyEn5pAj7u83QWJDl/rMc+rHkCi756lOxiEKGLnRFmLQJ+W+x85ks
	DU14EDs6L9/urKrbiKptbnMgevBjjzcsOnxH5sNcvJrdiTEpeU6Fnj6HxcGUQd8j
	Q1MX5ofyspfOP11/72rXOhjn9e1T4iI75IJMEl1LlixZ5ChVzCHo+7Q1LYm+pgGj
	fod2T7pGuG9EVLsWin5ew2Q37lkmKYy4Gb4uOVR/eU6a2XP6qw7zK69EdP8WPXHg
	Y4qiYco=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 v2 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon, 2 Dec 2024 14:07:33 +0100
Message-ID: <20241202130733.3464870-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202130733.3464870-1-csokas.bence@prolan.hu>
References: <20241202130733.3464870-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733144964;VERSION=7982;MC=931571948;ID=156981;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637261

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add fsl,pps-channel property to select where to connect the PPS signal.
This depends on the internal SoC routing and on the board, for example
on the i.MX8 SoC it can be connected to an external pin (using channel 1)
or to internal eDMA as DMA request (channel 0).

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
---
 Documentation/devicetree/bindings/net/fsl,fec.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
index 5536c06139ca..24e863fdbdab 100644
--- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -183,6 +183,13 @@ properties:
     description:
       Register bits of stop mode control, the format is <&gpr req_gpr req_bit>.
 
+  fsl,pps-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description:
+      Specifies to which timer instance the PPS signal is routed.
+    enum: [0, 1, 2, 3]
+
   mdio:
     $ref: mdio.yaml#
     unevaluatedProperties: false
-- 
2.34.1



