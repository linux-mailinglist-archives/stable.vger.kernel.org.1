Return-Path: <stable+bounces-95920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5BD9DFA10
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 05:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEF01623E6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 04:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A821F8AC5;
	Mon,  2 Dec 2024 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z8Ki21Qy"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6951D63E5
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733115486; cv=none; b=ew/m5aO+u/fTCiqA/QujFxS1HOhKjnvrYq66FaYaWgPxRZKAIEnHynqMLnyRjr/444tV1YRI4N4fgTUR+r5q16UJVfYXGECLA1+kkngdNaGnzm2J+06dH/izdtNtCBPpej/cGEN+AL+MoCmgLhvg8lSqk+4hLffj1sdsojedKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733115486; c=relaxed/simple;
	bh=nwOnFLjkl/AZuun/GsZ/MT/Esupxc6jZTrkx7WlRFtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IF02xH3V10hpgcdXItRNUcVfupSpHAFPmgiiGOaUbJc3RC/nAyNnXNSionL6s0ihG5BfwCh5gKGglEqkmjXvL4m76yfZ1OhgkhZ3uh7ysSHUUpiYVCiC4FH50ncmAgTEoflE3dEaXz3HEK8RbaNBFw5QNqJfhM4gRe4iYm0DtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z8Ki21Qy; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ea68fc1a7cso1532991b6e.0
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 20:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733115484; x=1733720284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDhO31tk1fZx5nO1D34ac67vgcEF+XlfAfCpGqdW5mI=;
        b=Z8Ki21QyBsU+eNA1HqdAEMXlqb8i6Lqzc+ho+oawDBf6rqhZLn6l2zV8SvyIL+6Ov8
         k2yo2xowBhYTJqQK0YVyFVncFpUBCSzwAwiIcaREDtTifvsh7tp5Ku4aAHWKi7DQQgHZ
         zuF5ez44A8VthW+XNgkVDBN8Kqn43nhqIDYtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733115484; x=1733720284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDhO31tk1fZx5nO1D34ac67vgcEF+XlfAfCpGqdW5mI=;
        b=DG9GQOTu0thRjbQ9bw8hG3YpYhJvw8upfVShv1LjDZ5MTm2iQUDHfi5DMT1wvvI5As
         OGemb52yjA6xg3mOhtD758AtF5m09UInTSJHdD/ScIUqIH5FH6uwGSM/opzfDzyBeonM
         GHlMx1HtMoLxuuRAgNlG4Gu1B5VcjAcLmx9U/G7rJyk3tvvoedAHW7NXd+l+jXHGJbPs
         76M8F1htVdpfgaGqxOsM8mSde3QuqOPgk2pIr6zORCLdKfM+jko5omGXUxXQ+WJkvbn+
         ucsUh9oE/TXEl/Bq3d47oHLJbkn2Dqw8F2TInGzQNro1TacmASQEDW+rhdS2Z5Iod/q2
         FifQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/DcO5T7hZrH9XJDwI2N0MdHyaZ8EHLdk2W3NcUKTx1PqNVWmp5Kgo/2dO1NaqGh9QDpnzZjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdP/GK/2f+zO7RCddZiifzmY+tehUtgs9n4k5+6SM3nxrqv2XO
	sjM3DuStrYVuB0MS6gbIZ/abWeLd6HHQlB/QWD3nqJ28y3bFVG/h0KUV/5kqpg==
X-Gm-Gg: ASbGncvw0zyRHtXDAldZy3L1ZBxaXnWSdO/KN+t27FiUdkClvfP7nsyDlA5fgCSsBvD
	47DMyLg1jjIuc3Vz4IBcw5MeyZ+3ZdgKxx6GQff1GIhd2AYA76pEySHicd4bebu2480AwettZli
	eW2qRN8NBDWgaKGmmNwNk265RBRWX3qK2xn1voB+6htU6Tuytn62f2B1nKAjzrl54WCFYJUD32w
	9cP+npTHhDbVluiMDiIhVVRHD3q0c0kG0J4Grw7CL3Buf+GnzBSE6ORtp5da5x7sL2R
X-Google-Smtp-Source: AGHT+IFb+ZRLH+3t3GZ+Wqs0KteaVy0F6ImlvlAlGAnh/Pchain6QOhSaXFDzaByBXFgCM7QNb8V/Q==
X-Received: by 2002:a05:6808:2018:b0:3e6:3860:596b with SMTP id 5614622812f47-3ea6db6410dmr21148963b6e.8.1733115484363;
        Sun, 01 Dec 2024 20:58:04 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:94c8:21f5:4a03:8964])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d5be4sm6970599a12.3.2024.12.01.20.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:58:03 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: fsl: cpm_qe: Limit matching to nodes with "fsl,qe"
Date: Mon,  2 Dec 2024 12:57:55 +0800
Message-ID: <20241202045757.39244-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise the binding matches against random nodes with "simple-bus"
giving out all kinds of invalid warnings:

    $ make CHECK_DTBS=y mediatek/mt8188-evb.dtb
      SYNC    include/config/auto.conf.cmd
      UPD     include/config/kernel.release
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      DTC [C] arch/arm64/boot/dts/mediatek/mt8188-evb.dtb
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: compatible:0: 'fsl,qe' was expected
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: compatible: ['simple-bus'] is too short
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000:compatible:0: 'fsl,qe-ic' was expected
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000:reg: [[0, 201326592, 0, 262144], [0, 201588736, 0, 2097152]] is too long
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000:#interrupt-cells:0:0: 1 was expected
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000: '#redistributor-regions', 'ppi-partitions' do not match any of the regexes: 'pinctrl-[0-9]+'
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: 'reg' is a required property
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: 'bus-frequency' is a required property
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#

Fixes: ecbfc6ff94a2 ("dt-bindings: soc: fsl: cpm_qe: convert to yaml format")
Cc: Frank Li <Frank.Li@nxp.com>
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
index 89cdf5e1d0a8..9e07a2c4d05b 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
@@ -21,6 +21,14 @@ description: |
   The description below applies to the qe of MPC8360 and
   more nodes and properties would be extended in the future.
 
+select:
+  properties:
+    compatible:
+      contains:
+        const: fsl,qe
+  required:
+    - compatible
+
 properties:
   compatible:
     items:
-- 
2.47.0.338.g60cca15819-goog


