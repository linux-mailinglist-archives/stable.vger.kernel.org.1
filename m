Return-Path: <stable+bounces-211376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCk0I8Jlc2mivQAAu9opvQ
	(envelope-from <stable+bounces-211376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 13:12:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B175936
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 13:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E67D63017BC6
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F137329386;
	Fri, 23 Jan 2026 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A+DxtUJf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VnQCSDPO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C52EB876
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170366; cv=none; b=aXJDuU9dCJPI2iMW9mgNDB/4bp2yK81jJIHD3nTDm5i6Nao+K885+NFsA/OKso2Swo0askH78B/X5i6+iygvEG9F7A+cC1aPdM8uIM5AhtyL9aakOJJUrS8n1TQ/4IYUm3DMkQZC4uuUQW9S2nd0IR4rAL+7nZ1nbsiAGwLHt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170366; c=relaxed/simple;
	bh=8q+2Na3PKf7MhkrNMBhjn7/ES2UJJmcUb8wMU3jlfrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cg7E0erqqT8vIc2Uf+5raY7L2gqzq/Jh9fA0WpQ92+4TDoIZU3p+v4vhZkxw/1HxP96X4FyauILndt8k+xv0xOdFfMvWMXIvjpsvofh7z0fRVvtPQBTUPlL1ZXF9PH3q9M81jafPtNeP13uSXldyLsvmBz0OBVCUmo0Vwrrppoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A+DxtUJf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VnQCSDPO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N7ihJT1267903
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 12:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YkmeV/dutdxiR4NWAGqpTb
	SHxF/BLbjYEpwtGgo/NWU=; b=A+DxtUJfnuOPx2eSlvOX/kX/dt3BIc/p+kn1Tx
	y+kGVGKPlmCNxNrsm5DHbljWrxpMyyGI72Q5gktgyFOVGEJbUhNJFKIfsZXCkKCT
	uWPGHeBeEMW2wImTqL9MYdsuf9yKLqUF4QyKBOfu7wy6FDD2rhZOp4jKxgd99u/O
	4CtaQ1ShcdwIM0e7ybpQXbDpu8geZg0oy20E1evYq/HTNKaW/qcpDEKHtdBfLzPY
	RKRhws594g01MswTwdgbNfpfAXY5SAT9EPXMRdlR8Le7fZ8l0uSNFyLAwGW6gTPA
	qWl/b/ksy045JZLxMXLEfRZK1DD25+B/WppGplbytfiGAWPw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv4v990vw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 12:12:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7fc82eff4adso1822878b3a.1
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 04:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769170363; x=1769775163; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YkmeV/dutdxiR4NWAGqpTbSHxF/BLbjYEpwtGgo/NWU=;
        b=VnQCSDPOqWTeaVfw2DQL4WSzRzhqoHzTOfWnlWw6u8ZWFkNd45rx6dv8ttZ7F+bO6Q
         T1gR3xOKGgJLfrpDLHKsOZ6PfObg4ZxlQBnBuEKesX0flphJFKpe5HEOe8i24BK9+DSa
         aWnNr+dGLzsPwcfkX6xBjcMEMmkcLM2FszMSzXKoqivv0L2SOQX7PfhtDnmLo0WSVHYq
         hiNcoavVUAjBqxU/YCDZ16MRRY2eRQVWBf5hQj+9uazKGk+tK1fMsT+bJX1DPc1DxR0+
         IQL+WuNO8JvY55E2Pv/ElPWAYEQswLjetELy/00cTfxxsuBDXxUI35LMrqCTplcRyonT
         lPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769170363; x=1769775163;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkmeV/dutdxiR4NWAGqpTbSHxF/BLbjYEpwtGgo/NWU=;
        b=QZWLJPIJYJHS6GtQRYmE4EoPgnStCQdKtxHS66nFokE4eT9xPczPiMeayAEYqYZh4B
         vF+FuHeuGW+CCGveqHepcNdQGLt9DaDTMNu3pqx2F0AUTvl7LSw4UdUcGL/eIbpcrw6F
         evrdFQGorxkOkFdtEkWLHfozft7oD05GLAg9z+DKr6FA9ZHxVFqW3AUdZAs5w5hioVaZ
         k9PxC9fHnhdEWd69V2D0tRYT6haI9GEBOlz1fmyH1SUwbEjLQyYRY6C3BKNcEFVH6u+0
         JyMNya05hivx5+ZTDaIvw9dsz+y9FFnlcTGBlwwifYCi8KFUZp6gAFgiC45BQB8d0Cm2
         rs0g==
X-Forwarded-Encrypted: i=1; AJvYcCXVGULUZYq2BBgTeAFMWEd/Xz/JgKJum7Kd5hR5lG5HAHyVNiEvY/bOINv9jeQnnGXySqBGM9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaIS/XZhUMP2cyYOK6dNEUISQGBfeQ88vDPtuEx69O0X8bd6h
	DaK++tSh2oyrQ8FV71SlvWzenO6lUqllm21+/3m/iTP7C9cmDcwfrdM/vUlcYKTegwD0H6hmyQL
	7mkMHfYMWqe5qlQBlTB685Xq4oM82sbaf03Ka0QJhvYog+aTeq4WVeP9TBvI=
X-Gm-Gg: AZuq6aI4I7k5td1ExU3aUCjNhC18gcDYHEvZ8+hvyMnq22h+e0WbKgxVI8OEEl2kPAS
	eCXmWHfo+esmP1VOBeAsOxwpyqftnFqksWWLXZiqd2zwtnQfVNsNjjUqG5wJrP7qPgCKAZkCIaV
	ZZqJ+XUCRrDUMqG+DEDayMvZweninPKiLhGnXQ3fUQtD003070U5tdb2gVJvIJRnFhYSlMU/wo4
	H2HVs9chNS+JNGi4Y/XT9m3TmXwu3UZppVexYyVy9+1RjtrpeOYdGKBPS5jZMTnAw9Q9tv+xNYv
	ZTqFGpj+9IMeUqVwNBk/on755K8aaKbjMYwvBkg7QPJX0Pho0JWneutyW9cdkN6UdUDN5ERdQsr
	AZOaYQGTUYhFjqcVXfmFoF0OqtqQhVorkqCZ4OrS0CGgW
X-Received: by 2002:a05:6a00:1825:b0:81f:804f:af26 with SMTP id d2e1a72fcca58-8219ede8a3emr6160310b3a.19.1769170363400;
        Fri, 23 Jan 2026 04:12:43 -0800 (PST)
X-Received: by 2002:a05:6a00:1825:b0:81f:804f:af26 with SMTP id d2e1a72fcca58-8219ede8a3emr6160281b3a.19.1769170362909;
        Fri, 23 Jan 2026 04:12:42 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873bf53sm2109288b3a.45.2026.01.23.04.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:12:42 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 17:42:27 +0530
Subject: [PATCH] arm64: dts: qcom: kodiak: Fix PCIe1 PHY ref clock voting
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-fix_pcie1_phy_clk-v1-1-38f82ea01792@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKplc2kC/x2MQQqAIBAAvxJ7TlArpb4SIaFbLkWJQhTS35OOA
 zOTIWEkTDBUGSJelOg8Coi6AuvnY0VGrjBILhUXsmEL3SZYQmGCf4zdN6a4c12v5dxqAaULEYv
 0P8fpfT/jbnDsYwAAAA==
X-Change-ID: 20260123-fix_pcie1_phy_clk-60dd5972a471
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769170359; l=1779;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=8q+2Na3PKf7MhkrNMBhjn7/ES2UJJmcUb8wMU3jlfrE=;
 b=VCsTBBgl5eqKY2BrpNC66+H9WobjZ+V0pF+azJfaot1c4n9hilbpFzFGKm3wRpvgZSR0A7adw
 +NW14FjdtP3Dq/01ruRiLkRUxzq/AQ6fLbCrTs0LUGH6TAb59DXm+c/
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: t9-qY-dv8S57y8KrhXBtLAi99qg6jpPD
X-Proofpoint-ORIG-GUID: t9-qY-dv8S57y8KrhXBtLAi99qg6jpPD
X-Authority-Analysis: v=2.4 cv=H7TWAuYi c=1 sm=1 tr=0 ts=697365bc cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_k9ig2nQFDp-gxZIyLcA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEwMCBTYWx0ZWRfX9BfvDF30kWZB
 0QrETCpWoGfjraCtGy1In1WjEZbB/f6X5WeOAN5iIDvjv0dDwdCSUBov/RkKNegsqRylL3lyusl
 IRFtuao9R5Ik5VWGcvxBZAMWWJcGwbDYsGAigonMMU3U49KEPrUAwEHF0PO1K215XzPezehdk4b
 tOrjTJbVMY4aV+Kszsh6MyASyemD8VQCiNTLJFshSFmwxu7cuFNT1nmPx+5kPAwqqJh01Si/SN1
 UH1ADOu9LMhdZvijjBG/vF1MI17kI3vuSWj+kkTpxh9lc41xOg9nY5m4JEhjwxX0Y/a3UIcTlj4
 nz+88gFTH5xTgH15/Eay/pstsK3WNdR7q8TUw5t2AjaG6AJX0nc7gNuGw6KRa+Oa3vYgtOpiMif
 8aDi3+DEOJfIV0hUtT2/YycsFOQdOwBtu2NIQr2QqIOjzHnmCUEhAlBsIswOKgFmlz/cB92Hf3p
 cWKhlYSXRncuv/m9dRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211376-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 033B175936
X-Rspamd-Action: no action

GCC_PCIE_CLKREF_EN controls a repeater that provides the reference clock
only to the PCIe0 PHY. PCIe1 PHY receives its refclk directly from the CXO
source.

If the PCIe1 driver in HLOS votes for or against GCC_PCIE_CLKREF_EN, it
will inadvertently modify the refclk to PCIe0 as well. Since PCIe0 is
managed by WPSS while PCIe1 is managed in HLOS, there is no mechanism to
coordinate these votes. As a result, HLOS may disable this repeater
during suspend and cut off the PCIe0 PHY refclk while PCIe0 is still
active.

Replace the unused GCC_PCIE_CLKREF_EN clock entry with RPMH_CXO_CLK to
reflect the actual hardware wiring and prevent unintended changes to
PCIe0 clocking.

Fixes: 92e0ee9f83b3 ("arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index c2ccbb67f800cb9927627f991e3d97174cc73c64..1bd5f907e4915efeabd836dea12735b94626294a 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -2440,7 +2440,7 @@ pcie1_phy: phy@1c0e000 {
 			reg = <0 0x01c0e000 0 0x1000>;
 			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
-				 <&gcc GCC_PCIE_CLKREF_EN>,
+				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_PCIE1_PHY_RCHNG_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK>;
 			clock-names = "aux",

---
base-commit: c072629f05d7bca1148ab17690d7922a31423984
change-id: 20260123-fix_pcie1_phy_clk-60dd5972a471

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


