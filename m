Return-Path: <stable+bounces-96316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661089E1ED2
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFD6280A68
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517521F4702;
	Tue,  3 Dec 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="WBHvV9p7"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC411E1C33
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235368; cv=none; b=tXIQw5NPjhJEQfaFaOcJz0Kc7U2NtzbXSTBc3hfgbFyGrAC9gqQnOm8SP1un4WeKqmxreurVzeIudmE7h8RVGMOSZ1qF3dHhN0FCZCyH3zVCJ/XwJQUWvMvS+0x1QOEjCFp0BvqRLyk/kQcrJl72XAQ+d1hvCNQjbaJTd2Sxgc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235368; c=relaxed/simple;
	bh=IIcVbhuQPHfwWUqLKc1AhRds3MVIB8X1uXDnOYZLJUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgbDBit5fuZ6/7F8SOfpJ5ZTZlQMxQvWb1dNGYJbYgPLR41tUcRfFDfuZ3U6IZDfszgMY4ioujAWQz/WX5OVhaYyNOPd1Yw+uchlr+HsSL2Ur0ACQG4l/djLWTKyaMgs62qUieg8fZV144/iknPM3aQp9p4kMm6IcrgDShtX4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=WBHvV9p7; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 776DDA0120;
	Tue,  3 Dec 2024 15:16:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=4jVV7O5ydmCRNe1Kb5Db
	sQ86T+boqlJDOq5G7zOoO4M=; b=WBHvV9p7ApjjJbnJJVb7QfZhjsFUHfseEtmV
	7jiOYXQKOOjg3mpeqmUVJMHkETmqscsBL5JBzbrkaBeltOF4zn6P3hJ1OyRPLVVO
	qvXggsibaXMbpxirQKlLR1ZvHBMD9C2TROwQEi9JCK6z9zZbCUc/EZpAA6nKouEn
	VH7IeOWwG4nNfUd0GJ6RY8iG6g7nqG6ddTxRcW5U/j0JGUydCMU0a/K00xuHUaws
	DCReX/Z76/S/0FowA4/+UkSpTdgUku67YDtyvBznzOCu4XvOofnv6l8M6j7JLM/W
	ba663XfwxRQwceVcAgDSRRWmtfqP3d824zFtBsuwCoPgMqhh4xeor4QkisHRVXK7
	emQuXQKzEV3VDjHQmlhUFmKlUKPPc2SRAStyAUwRbRIChO/Yl40EXMSm93AsP+pW
	q9wQZY9JdA3VOkVIbfA8jai4Dkv6eFxL2+fKr0xHvVxFCKJ1pdVjxKGFcOq/Q+V7
	T8OtMVMUWcAFPUmDg0B20ag79d4NndJJW0SuGp/4ngfSd+ZjScFM8z/Q4XlBwWql
	W6nt3RjgG4oJEGlUJJKrgJv99dxnETCNuOkVci8ArRUXGOC6zofTcwrRpKyp3vJH
	HmZb1Cd2kBdDK5NW4/l4ejb4nV2577sHiXJ8MKndYllBTEaBiyGSaA/qWEyi48aF
	Xpx7cNo=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11 v4 1/3] dt-bindings: net: fec: add pps channel property
Date: Tue, 3 Dec 2024 15:15:58 +0100
Message-ID: <20241203141600.3600561-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203141600.3600561-1-csokas.bence@prolan.hu>
References: <20241203141600.3600561-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733235361;VERSION=7982;MC=1065761526;ID=166215;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637D67

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add fsl,pps-channel property to select where to connect the PPS signal.
This depends on the internal SoC routing and on the board, for example
on the i.MX8 SoC it can be connected to an external pin (using channel 1)
or to internal eDMA as DMA request (channel 0).

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
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



