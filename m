Return-Path: <stable+bounces-208056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7EAD115F7
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC6AC301F019
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FFF346ADA;
	Mon, 12 Jan 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxTiHQSC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JRcR9Q3X"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9ED22AE65
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208521; cv=none; b=rRRg86zvPBdIN6ColfWVtrPi6vumvuFNu0lRKOFEJeNI1M9kKTMt3+QrtHHL0VtLQhJrEE4+BixblTKWicauvHEPxlB6Pzl/DNouBKVHRpBcaTu7tBLFRK41FU9LJ7ODkfH0vo4Rzif/HKaJLCCSzEJ9wvKjeJ9nVL6pozYlh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208521; c=relaxed/simple;
	bh=BLROFHNZKkkPGtWZHyLHCOUejGGnOYD9zfyf1eBR4TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CslCGFjiuzv/BSaMuFyVShBX+VmK32YD4FHNZxG9t9LIHG79oLT6CEaUPvA0xOo+UndwGTQE+plehQlsvjR8U6FOZGDnMG9H7ic6Bh9SowOMgSvXG5UtrykieBBhdMuyeZUwKt06EvpvLWNRZMPOcsn91Neo6FMSLSwJGHzVwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxTiHQSC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JRcR9Q3X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C4XWPo2070456
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 09:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mgdaUWwr6+5woyi1qG/Wu6i0aaAM89h66Ju
	4UFAfius=; b=GxTiHQSCksTcmDJztqiOLptF7wXWTj/F5x1u5mkmGLpsSIyYXJz
	HTSmMXbHC5usKCaG3dN49VzCigIi9qnYntwylsTUXVRivuh2WYdsfUhMV90f6K1Q
	XY0OA53kKw4yUo4qxu6fn7boJD88pMoKLzxvBywjEztH8J0xCfI1xr79aMIY4oIf
	GLZsFlb1YTApi3ztWqv27zNkYyqcPQtS3Y6ckXLdlVTMOUjy3nSqVBDdUL6oWlmg
	cGJMUeSe5x7PxeUHdmCCvY/uBvr1bWSNvlVhdDkKbJ2EbgKG+e7Vgj0XfqBgi42u
	EDSy0YImkbqFvptPq80L+QOaW/dvxoAKlzA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfham915-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 09:01:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c2a3a614b5so1419389985a.0
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 01:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768208518; x=1768813318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgdaUWwr6+5woyi1qG/Wu6i0aaAM89h66Ju4UFAfius=;
        b=JRcR9Q3XU8S3ydsqn3RvhjhzACV8gJxGksFStJd/8reeNt1kAnKwfZO/VQ/qQIUFN+
         jNKiFz+40g0/YtxNG2hg+aGv6TovFllznd3dqlIO6Ur0bc+YT5sxtHkiFhOqBgXXMTZo
         myfQSigq7iHYQkHiKc5w6jbCsEAkUMbDwFP0qTEEnxN1tMpB9cRDnD/1g0mrKLiC8qtx
         jH5Pgqpu0DrqPO2Y9iMstcou7oPsYgQcAfk0HrTUsr6GJixtIccUi6mFBfTuKPQfAOr4
         bOrGxM2uQEFbmrT4BAuj2ELncXgo0qMmwaXxGtqSLXPbAUrM0ZPaHRALzbYVn/sAjNo/
         InXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768208518; x=1768813318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgdaUWwr6+5woyi1qG/Wu6i0aaAM89h66Ju4UFAfius=;
        b=XKUkRPa4f3Sw3QXoVfL/fxhNNZes72Fq+1s/GmocGZAD1T4iDzVMrH2mTK5CEBxl4B
         vO3oReKFFcUm9iztYj1CosTKFQQBq1MsyXpkrRtAEaAesVPOvyOqxLhcV1HDC7+avty4
         e7mGjeCkUFQbDO+jjTnDprNSKdSrfwREF88s6DTtAmLzSPPZLJtprAoKtPjNTWC3q5Rg
         MEgcGLOLWynMr7zCYSyZca1COhL6XQjQb3jkCjalL8A6fCSEiqJwr98dczgknnTfxTiz
         AtAZbwnUvZdQzr8DvcdRc68+sBLtw69OWw3zBCQLHfBcfG79+Hs7p+LWnYl7Vc/AHVsl
         GJug==
X-Forwarded-Encrypted: i=1; AJvYcCUBfcgU4GwQoZsgfF70YXj8+aJTtygKJSFtxBFPVQsyoPRe+n7zYjQWlELY2g/wa4br9w2ES10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2aGGSdmHWq6iQBrGnrxpaRWPiArzd3kR1jlVXNq0Ifrs8kZ/
	+u7MZM+9eNfLBvWt7MHSQ0bX3ponpvpS220Z8yluIt6Zp2S2Hh/rm/uCi875ssR2mcxdacSy+7T
	pkPbGD3XzOgiThyjlKLStbZBIKFsbONSEQPuwEerdr2QKFzCcneRbxdzqeAk=
X-Gm-Gg: AY/fxX6x2CxiE9N4Rj/nuvujjtS+aJW0K1NPoD2Gr+hhd4y9uXx5RiHlu/QSklY66Tz
	pDaO+4hzmLNvYD1M5zIHF7fBT0iEf2dtNuu8/38kisKy2UVUYzU2w36W9x0gO2Q0Ywc60n5eUzc
	1p+in8yGM6/dIw7JYZ8QiJrtZbaDh99IjW+xrKJJ/kz7K/NR2q88gQhYJt97yUjPp7oTgQkPGy3
	nGvG2W0xoWJDT74/PMvlUe2tElmKCMqJjPF3Q1LpeTxtYSkFH7h9y5VTw7AyDQH5qONzNPBnIUV
	M+/hUdmbe6eQ27L1nRBCfS5PHzu4EzwAregm2s2iaR47eXuAJRvW1BdXAUL2AdyhY/FesX7X4HP
	VcZi9cFxCdW4RnUo/U8Z7bCbvew==
X-Received: by 2002:a05:620a:4806:b0:8b2:63ae:6343 with SMTP id af79cd13be357-8c37f51e983mr3207142685a.28.1768208518521;
        Mon, 12 Jan 2026 01:01:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv2cFfIDCeSZvf2r+blH1IRTUYxe0FVYEo/QkHo4cqy3mqlaDuTBCyzrOK+uVMGyKaf3Oapw==
X-Received: by 2002:a05:620a:4806:b0:8b2:63ae:6343 with SMTP id af79cd13be357-8c37f51e983mr3207139685a.28.1768208518080;
        Mon, 12 Jan 2026 01:01:58 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef885sm337980525e9.9.2026.01.12.01.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:01:57 -0800 (PST)
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
Subject: [PATCH 1/2] dt-bindings: usb: parade,ps5511: Disallow unevaluated properties
Date: Mon, 12 Jan 2026 10:01:50 +0100
Message-ID: <20260112090149.69100-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=BLROFHNZKkkPGtWZHyLHCOUejGGnOYD9zfyf1eBR4TQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZLh+DfsOlKCOYKsIcvmjoVyQYl914CcaDIxe6
 XJ6tReNcz2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWS4fgAKCRDBN2bmhouD
 168ZD/4hrbO1vbTlaDZ0+JeJkXrtmzvD0/OeFYwPoI6GhN/G6gEqZJ/sXe87tG+G3IV8cVtW7ea
 NNaiW2murRhNiTtQoyvufSh44Bk3eHbbvANR4aNbFLdInbhkK5qzBVhKzM63+IH6FtFNsemJRd0
 Oqogql0kttnp0OnN6W9sMVWzsLtl+hrNkj6R8l0nYQNoxFCceWG/7HNdqfzNKtjhZ4j+Ba175b3
 XQPc//HzN0S2GsvkU1FUPZiDNrq6nBg8856CdfrczOgZSTlTVXF7jjazMskny5MapPvDQ/BAY/d
 ZIf9j0vm3pnQ53hQFxUOkeLuuc0jW0dezGMGOadIXSy75FfkhT2AO8BIzZbnmuRbR36dynA3mlW
 i54APdisb23RRLLqCnBNc2dPqj0PXJ8HPdKUB+MUCtXRc59yWqtPEJ8RRhfgGx29z7qxjXdSNnJ
 rWsWW6e52M9OwGGc/0lJVhHOcKEouQl98FQHZBkPRilgU2vEngT3nO0witthm0QGu1Y1Oq5fvjg
 zlFbDmDhpXrGuY9XEKIN6D0BANq551zrR8c5FyEY7C2nHA8HXXLcDuSF8h000kvsmON7t9CtDS1
 z4j0fwNgqinmjwAQ5koF7ESbCdAddONN9Ew2M4HmNHTmrWRLcpVt0c6dOH7MwKta6OqYhpOQPTe bnC/2ycdCsaGCQQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CM1Jntqq-HsMrGF0IC0yeXeEhAX-0dtT
X-Authority-Analysis: v=2.4 cv=bOEb4f+Z c=1 sm=1 tr=0 ts=6964b887 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=II4pLX60nxjcN9S5XbQA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: CM1Jntqq-HsMrGF0IC0yeXeEhAX-0dtT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA3MCBTYWx0ZWRfX6k/mMkSNvD43
 XVjqrpfCQ5QkLUPVrpgaj7KNFcusT+uAp6jC9vr3Tc1d3UjZQof8mf/JlfpDyr5GUjNvFsNvV0U
 zGi+IsBeL401mn6wu6Hm1CfmNZ1M1v2+lfnv1YyZ7uUKWcBPWMKKfAyxfxIS9MnfGhMTxD9rc8C
 fVBEc2Wah3wCVoWPlbh3vR5m4Jk911uvSQXQupKAwhVIFSttwuY414+H3ACSNjTWB+SCuouHTgF
 hXxcRdELqqAv4kvMXjDk2CYSAaj0gGUjtDHJpTUXDBCa6ASwVszSIh3cdb94SaicCJ6TKEqCDBq
 5zfXrUbi5qU1YpueYuZ3hadkwE2j9zBzwRBtGeBfiOOhE/P7F5EK+GvZn2iVXUI0dAeRoI/laMn
 XIj4RC4eVN5tuaga+zvUkpK1ITSsjKnIAt17tqPsoIbpxJ6saol+Hmj1qiziqSPGY/lRUfRiqVP
 ZmHWhIqWPxEotBwygxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120070

Review given to v2 [1] of commit fc259b024cb3 ("dt-bindings: usb: Add
binding for PS5511 hub controller") asked to use unevaluatedProperties,
but this was ignored by the author probably because current dtschema
does not allow to use both additionalProperties and
unevaluatedProperties.  As an effect, this binding does not end with
unevaluatedProperties and allows any properties to be added.

Fix this by reverting the approach suggested at v2 review and using
simpler definition of "reg" constraints.

Link: https://lore.kernel.org/r/20250416180023.GB3327258-robh@kernel.org/ [1]
Fixes: fc259b024cb3 ("dt-bindings: usb: Add binding for PS5511 hub controller")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/usb/parade,ps5511.yaml       | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/parade,ps5511.yaml b/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
index 10d002f09db8..154d779e507a 100644
--- a/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
+++ b/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
@@ -15,6 +15,10 @@ properties:
       - usb1da0,5511
       - usb1da0,55a1
 
+  reg:
+    minimum: 1
+    maximum: 5
+
   reset-gpios:
     items:
       - description: GPIO specifier for RESETB pin.
@@ -41,12 +45,6 @@ properties:
             minimum: 1
             maximum: 5
 
-additionalProperties:
-  properties:
-    reg:
-      minimum: 1
-      maximum: 5
-
 required:
   - peer-hub
 
@@ -67,6 +65,8 @@ allOf:
       patternProperties:
         '^.*@5$': false
 
+unevaluatedProperties: false
+
 examples:
   - |
     usb {
-- 
2.51.0


