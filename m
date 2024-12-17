Return-Path: <stable+bounces-105028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602389F555D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0EC188AAE3
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223D1F8919;
	Tue, 17 Dec 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="a+taq0mm"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC11F4703
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457860; cv=none; b=l5iXiMBveK6wpSD8pGvfscrJQbOLBJLQPAO1qVN26IE9haRJQNMvV7J529RtFnlabA13YkOezRhYcdgNf42ir+3z0fh5nzehrSdZO1uDymoRXMa1eFMNfGYQ1I2tNGfNca9NuVVPL5VjsCBd2u3n30+E8Uw+tcSjT4Hw6+bruME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457860; c=relaxed/simple;
	bh=z2DkbMYkTph1UTHyTsTSsbXYM/0WeXWwIP2pLbEImJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wnuiu+UhsE19/nmcw7nNF4GrWAja3S7bfLehP/WHO0V3/YwVDYAF931RzJd23dd9oWHd7PfyAMXIHd1SmQgAPVqPmn5TjceUPZCcTZcOWI4L+lgTwa3yF4qC4phy39ezAee7rX0NSYNV4nsH8Oavwl3op11pqcc23XCVi2qP1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=a+taq0mm; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1CA85A0BEA;
	Tue, 17 Dec 2024 18:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=D8I9hiUit/OZsJvzmsYY
	2EWgY89GziM5Y4gaKHbM5Es=; b=a+taq0mmCcdkfPqaGMqpwapTSxJo+XKCNUQz
	5+XslmbMMwO3APQ6jJ0vU2MGPEkH9986JdAp8f4DVQf60S0okz556ZM3XNttO7Wi
	NIt6OV4OTevS5PxubMFAPnMo5wsqc3dCXAMtvGZH8SUQvyXo3nuMlDJc0yikm2KU
	IJ7QIWYHn//BACB8RvKMu57s2h5/AMViemhngTA4qRQzWz937fmXmgDRP7Cklfgp
	r7OxybeOZejO8SpQlMxFq3RZEXlrCY73dpq6WSsNkwAHf4vbpGKtmNl1EEfo9Zir
	hYHDPr3kK8B1VWQ3LBP2opKH6tejFhJuPLLSody1uR4bQr2SSPbE9ESirCRVIM3v
	zcciWMy61XwN/ni1o146V9UR9EqKOFLKKV2+ukGVlO9pJE9ZdIc2efGl10ZwOroT
	m7ZpTOi84xe2lOtJtfPe90Jm23Ff5RteB1xKvQ4ZKuglOW+zY0maCWqYsiVchlOM
	SrrwukwYlcOsUtNVtivj9f7LE70U1fGFS7xYupiy5BNmucAE+0C6m42TbyKKkkWb
	1ec2iD78HLvEX1oXuhe2yAEert7FJQVGBCMKNj1rw5LqpTimIAtYleGE497gXwbR
	N52rq8GTTwejWvg41x79Fc+5bPo+sriK4Zb6JPgw0kDBhrrylx+gfIm98/I1mz2h
	GWsApo8=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6 1/3] dt-bindings: net: fec: add pps channel property
Date: Tue, 17 Dec 2024 18:50:40 +0100
Message-ID: <20241217175042.284122-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217175042.284122-1-csokas.bence@prolan.hu>
References: <20241217175042.284122-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734457848;VERSION=7982;MC=1571237902;ID=67965;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948556D766B

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
index b494e009326e..9925563e5e14 100644
--- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -182,6 +182,13 @@ properties:
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



