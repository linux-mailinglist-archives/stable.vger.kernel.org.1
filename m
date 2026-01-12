Return-Path: <stable+bounces-208057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14CD11606
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04FCD3044224
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329B346E6B;
	Mon, 12 Jan 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yf0pnwDr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gcsRJUBY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6E346A1E
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208523; cv=none; b=PraXnDH7NYi81km8qMCW/a7vIAuraORtfBVGKcBPBA9qEuUheSLsHP1RGk1C1j2sp1vkRzybgCaZoI+EedlCrskZX50t4suEXzy5v/KnKzt4UEDqNczXdpxiKYEb3bLcMAarxfRBo6WHTqZmPOBIUgBMJ4hnrh4esDXT7eNwCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208523; c=relaxed/simple;
	bh=IfMTHWeSro6nfybMYt/k6VzicXJpbK9tibQn3pvSKLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OR8lnTItML//GxUOzqxc2ViNTN2qQ+T0VeT4pLCmxAGdrygO2COT4XSTkTCd+SkUx7kS79urwbJXFB7GUJkrFfrpus9e/U9bGVaPgJJhDGGv88DLhpKVIU3qo1NVfWMXR5wcbFtAMR6VL/Na82Yb+VCAM3+6F8SD/6xMLEvtErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yf0pnwDr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gcsRJUBY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C8FpFK263654
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 09:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gxYe8bPZc5O
	mrCJIO3gg3XeKjkXn1uCm2zaZeYGQq9k=; b=Yf0pnwDrIc6lMuyc9sMDxTnQoI9
	E58e7QmNE3pKtlZlWukPMqhXI0DRDx5RY6qirpArQh4zypI+rLA8V6zj2+PJLtpx
	mTqG1oSxx49bjW2soq1e1Eo1QvpJHmgl+8ibPOM1d6irg87xde6itf5WbGukauyN
	njgQuIHwo48u/Wpj/bnzVCpUeKBTaARwthR/qyn0GGsmoQfTl9vt3x4um9te0pwG
	R8ef72CB0LVYX/KncX97PTmQPc5bsNi6l/FpITI1d3m8VkF2KRzjG+rVw7OjEBgt
	z+A7GgUaUhGsCa+Y6R9ZIr6Xik81Fpke94i/Rj/Z+FgMYc8dh2XumRyqEcA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bm8kytbnb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 09:02:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b234bae2a7so1769700085a.3
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 01:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768208520; x=1768813320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxYe8bPZc5OmrCJIO3gg3XeKjkXn1uCm2zaZeYGQq9k=;
        b=gcsRJUBYgveD8YKyzkrGGrdq0sxO6QnHYQ9imlaUQNuet93WdwemNb3//J/FaoxSsz
         8pjhlnz3nUw6cWJYALVJrUI7NF7PFI8LS5SGnoHSG1Wy0DANaIKseGEpi212DxTRLH3u
         ai7GhwVyPQYp0LaCbem20i4fV1JokosPjpZgDOUh1AIJ91hgj2e2R82ki6xers+ffxMM
         yAirBuTjkskimgHxaBCAQIEdbfrANjxcO6grfSHTn9FRJAIUG725CmkB0Naf1/fr1BP2
         yLBqRZTg81ZZinOt+9HnA7nPDk95z41xK0N23G/sO0vrkVRgWKe2uv1Q5OfeWUuWN5XT
         Aa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768208520; x=1768813320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gxYe8bPZc5OmrCJIO3gg3XeKjkXn1uCm2zaZeYGQq9k=;
        b=t3flhOSFyb2IrAKjGSR+xEo0PcGLZqa/VEhGhVHdEqD8tDQREc5HQvCOjeMru7sjuZ
         8Lj/bTadPPBJ9KzdhJoQTPWDweAHLikMCCV5rLqOu8KkRB6+9X+gsYw0mJY++fHnVzGL
         XStasptKn1gyC9dW2WW10Kp6HeZNJNdcrQN5lo8FynA3V0TGzegh1aic/4IFQNO0KcKN
         42XfbV58q1J09yqpBeUz6nsCHIeDlH3haeNTSHkspgKQVYyHZeiUdY+LbZq2+Vwb8QR+
         q5PIZJbU5uznTkX2cPfuilM5A1zbOn1rjxNzQFPXlpiMeey7jGSwMZkW3j5Nvnh5cUXh
         wt/g==
X-Forwarded-Encrypted: i=1; AJvYcCUAbXVk2dr5UyRdIdbl3w73mdq7QzRfxIzGYRUdU+QYhxPfi8ldUYqrwu4yJsKGB5j7SU3P+/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmcw+AzCFDGXjdUKJozIa3/plShPgL9ITkniuLDolCaGmbbldV
	CAdGw/UceBSZDjuosvtClEmCx8FsdOft29nrU9MI8I565X9zoNmeaMA79fw1g1FTB0nT/KgPHLn
	0xJXw2DbnuOqKCWchlQKnMBUxwIzhmPAppqEVsjl0Jy0KzdZcPoTeHNf5PbE=
X-Gm-Gg: AY/fxX5PrBG29GRBjFKZwEJGLuBko3vgp8UJoa7DbBpBhRwz3eNcnrTbH6VaWXavM7+
	kDIOFo3ukXaBFLpqm28I9GLIfg1Pk5zN2KdvbNIzYmZor5OAt9VmppavtWO88gbFQyN052hjXZf
	WbomZ3Dl0Al3JAggqQfm62YYiaqp1yhcOy2HPTF9VvitgdoEmE4NxtOhr9lkQK0wCuFFauESksd
	Y6j8xYbF4SIVgtGh4SxNrZToA9smWfAAk35y4dH1q/iD34fQsuXR13VW2VDrIC+h6ZXyMrsnPXb
	dWwPkmHX3XHn/VjucdLJlxEiRjhftbgZkA8lMlK9t398+mDmDZPqCQo8NRCT5ibbXacMbfqyWQU
	OvNJmjPYsTOw6b1WRFxkVHd0mCw==
X-Received: by 2002:a05:620a:1a11:b0:8be:e02f:92cb with SMTP id af79cd13be357-8c389375858mr2497946885a.6.1768208520084;
        Mon, 12 Jan 2026 01:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXSEeJS775UBms4zYG59E6HPBx9N2t8Z8LqIceulkET1O4SU7Lt3cwHfldrGNZ9p/IE9oWHw==
X-Received: by 2002:a05:620a:1a11:b0:8be:e02f:92cb with SMTP id af79cd13be357-8c389375858mr2497943585a.6.1768208519653;
        Mon, 12 Jan 2026 01:01:59 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef885sm337980525e9.9.2026.01.12.01.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:01:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: usb: realtek,rts5411: Disallow unevaluated properties
Date: Mon, 12 Jan 2026 10:01:51 +0100
Message-ID: <20260112090149.69100-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112090149.69100-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260112090149.69100-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=IfMTHWeSro6nfybMYt/k6VzicXJpbK9tibQn3pvSKLw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZLiBINN8rNb+D4NxSuBR+mSgW9+VVU1z85uA4
 KMbzIH6cdOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWS4gQAKCRDBN2bmhouD
 18bDD/9A2IAOUVX0r3Jfo7d6lDfcRXk8nW/3s/mn62tIxcPcDD03Uvqf+fksuL8JIyFc2gCc1Kk
 WB12KfIBBpnJQ+tEavDZvIKLULfVWKhdo0SyZ/V0EDRpTw7ElzykQOA4j+2qtFH/XEJzdAfNVcQ
 97kO20wOeqVNM5Z7XcHs7x+xSppf7k7jmfpcvxSw96IsrRBIPRDqzrvi0YKgiTe51Nm/2T7roZz
 DVUbNsYw6ljsjRGJYN1chJ1CY+/El7JNYpbdIvtRkPm0d0ozh9PJHhjcTnSC50/qKY2fhFukj+t
 lLv897TZI3wC0A6I/tudgu2mHCl92lLyqzRoP1T30zAJjBBgRCVLR5Gah/nRXv85fF59+8tIogY
 DiIl8+42UK6PMSI/BjyqUVrzyW9lx06WPz2moue1MYK/pjsYxfhAM8K6mRGf9Xx+kHuo715ofI3
 xqrk/dRS39svgxvMG7kne/8FRvjiiTvxIXEC8OMCbFrGG1iA5KK4lIPgbGFfmJaxLoPTSlAoSUx
 NvMsc6SbesK5v85S1Cfb2wFHBAJrro3mU0mav08KvMOZtfT6kMVIpqdia5efExYD908/mBO4lcr
 nM2fkRrYgm4VBW9CsthUppW0vSIqKKcepCD7ueH+XYGQUt0mVGZdN95islSKjYPqKD5lKb9r0qI f3YC2+Atzn/ViLg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Tj0ty_t05wkQVhpjZztzh4FisxqzaN96
X-Authority-Analysis: v=2.4 cv=ZuDg6t7G c=1 sm=1 tr=0 ts=6964b888 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lvJHC8f6i3d4RnviQSwA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Tj0ty_t05wkQVhpjZztzh4FisxqzaN96
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA3MCBTYWx0ZWRfX83smpBYArj7V
 aKjzi4MIUJVq64+ghER9Mw6mksXr8jxnF5fQVUSezqWC3g5F5iers5+g8XrjZvgrvpgcF3YRMFv
 EMnODNxf0ZuOiNnShqrE/lPZ7GTiiueCIQ3WIE2zInQfDalkpwr1Kwg9BZRwIFXWKdZ1tFhuaxV
 P9xJDcZP8RYEwuAAVANfGiJ3HjlZU6ZJOl6Q020RMaUD8p10Q5xSVWWYqkhKFSgNIOdGynf/B+P
 eK/eYW955Xs5rYExA/zil6wF5ngtYboNiWETcumYH3U9rU/F89Cu+MwlJgh/3AvZmKrEP1v64mV
 PuApp1Kn9s1GjFZgBXDEjf+JhSU5HTt6rjMX8lFyVqanFpJim7QEz5MTQRaXTsNNVq2kySRiHK2
 rpBj3KpW2waEzNmXAIoqeBzL0S1zs+RHE4dC5y0a8VdqKnWo8su6l1av8qXCIfEF33Gbcyw8jAe
 9IcJcWJ+KabRzsXJo4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120070

Review given to v2 [1] of commit 76cbb3eabf0b ("dt-bindings: usb:
realtek,rts5411: Adapt usb-hub.yaml") asked to use
unevaluatedProperties, but this was ignored by the author probably
because current dtschema does not allow to use both additionalProperties
and unevaluatedProperties.  As an effect, this binding does not end with
unevaluatedProperties and allows any properties to be added.

Fix this by reverting the approach suggested at v2 review and using
simpler definition of "reg" constraints.

Link: https://lore.kernel.org/r/20250416180023.GB3327258-robh@kernel.org/ [1]
Fixes: 76cbb3eabf0b ("dt-bindings: usb: realtek,rts5411: Adapt usb-hub.yaml")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/usb/realtek,rts5411.yaml     | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
index a020afaf2d6e..a86afa8fdc91 100644
--- a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
+++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
@@ -19,6 +19,10 @@ properties:
           - usbbda,5411
           - usbbda,411
 
+  reg:
+    minimum: 1
+    maximum: 4
+
   vdd-supply:
     description:
       phandle to the regulator that provides power to the hub.
@@ -37,17 +41,13 @@ properties:
             minimum: 1
             maximum: 4
 
-additionalProperties:
-  properties:
-    reg:
-      minimum: 1
-      maximum: 4
-
 required:
   - peer-hub
   - compatible
   - reg
 
+unevaluatedProperties: false
+
 examples:
   - |
     usb {
-- 
2.51.0


