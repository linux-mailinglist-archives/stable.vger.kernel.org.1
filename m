Return-Path: <stable+bounces-223675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPK+OCHermm/JQIAu9opvQ
	(envelope-from <stable+bounces-223675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:50:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CB723AE35
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8EB8302B20B
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4C3D34A1;
	Mon,  9 Mar 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hIycF+ri";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dUq1NndT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B133D348B
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067497; cv=none; b=oV5VFcrWnsAMasiBdXFkpQXXevQCAIHzxw4ELMORYo0bQUEz8xReF3jFCJKUUG7gSFJ9Zve0Kpd/QJlTgc2+FhnCPgIDWveFSURw5SzVc25unUPOTy/1AyMWXs+YPPcrqzeruySCBUbAfuR5/vzaprQ3WycuJeRwbjy2p+/LVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067497; c=relaxed/simple;
	bh=fxH1veD+kpffYQiZ+e79p3JhbxkA92PQ/Xt0yhjG5zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SwLpcRnVp7dbXM3Qnv/5uLgOVVMdfmodT+6PJ7X82t4drdNIgFoxfk4DMmjc92ndQ8O4K2MPY9W0dpMAcqczrzVYG5vmci673ZHt4s0RTomyTX8Ex7GnMphZmYbFLaHJrjf8IUroeHGwZcQEnYWAZPYGa72p/qfCtA3VgEK9PFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hIycF+ri; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dUq1NndT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629EY3wE830621
	for <stable@vger.kernel.org>; Mon, 9 Mar 2026 14:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VkpszuqmGmuP+de517wzNg
	dO3IYx2diAtd5lrcL4LOE=; b=hIycF+ri4U9yxV52k54SVPk26Iv4ilQ7OrTrU9
	9DNC4zRIHqJ2eTr/Dh5xLPzXAFPEDg6F7dHE0xHBFe8hoaaKXgDe3XUuYYJF0qUf
	wzM5FOs8QT5mE4JUsk3C8UTo8UjPbP6SnkGdtZzPUYApXONUyNDJIX0jUBnk6Myn
	jFgSb1NVJ4C0Ry9dFm+U4xqT8OI+O+23Wp51/uDlGUF/TOsdtP7YXlUKPCO1eY0S
	xRX+pA6xBuSeeAJoQayXyoRNWTAQwF+SqLZPeRyUum1e8VfxstrK36rAE3+Xh6DA
	TnG/Al81F6LMDPrS+EagqFyItBbej3iIoIP9+EAVnAsHYDMA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct03281pr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Mar 2026 14:44:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd827a356aso745228285a.3
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773067493; x=1773672293; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VkpszuqmGmuP+de517wzNgdO3IYx2diAtd5lrcL4LOE=;
        b=dUq1NndT5wOeOBZ2fQ93DNkYi31jVzGDY50LP4BCahqdd2f51rt4J+TjIvnZ1aBiyK
         KBYCLOskNFRFXUMd5l+VSX0NrKvr1TWDGMHu3Z/ztaJBCkbNt7lcrBks0zOsdlPy48ne
         cmkYEBnH/pHyeQB/UVnCiXyyhUnfDs+NoYEpKeLFVlIK5DIzpTPTZCIUzfivJb38wmQ8
         eoeIU8nQnU5G+DN/8Hb4ZsHDHb3dhWXirTFOoTQ08FJwM5I8BpiGWgGxXBDeRtWIZbn1
         pRLSEwQqNhzVnu2WmkQa4/M31FlRvjBnm+sBqBJyJqoQfRN1dFph15mgcoXZXRt9mvX8
         Xk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067493; x=1773672293;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkpszuqmGmuP+de517wzNgdO3IYx2diAtd5lrcL4LOE=;
        b=JwhuO8al4vhrJq4oub+9SpSDGSx5kAWBhxuqdy54Gsw4w3krV6/ZjADoPaE8EfI+72
         74OWA7oY0KPLSGt9U1maXSe+X9NxrvWvcSHokigwxV3wuGpbQptP+zrcPWguKZCmncCj
         IhSi2fs5lTV1P0TiDLm3v4Ux3m98A+fnV9FQ1HJuAahd/N2fZQkLoQjXlcsVY5iHUDFw
         Ch12y1YHNYIu0ESVbJYnPmvt7XwSPMKkoiGO5GT1qpXoSjdybBKkKThuI+HfQcfVx1fE
         u1bV7Ea5ek36Gi2CVsOYX8Zh01xch8H68CFjJlvYDi77kGIJplA7hvV4m6hz/DWAnqV2
         A3KA==
X-Forwarded-Encrypted: i=1; AJvYcCU6Sy8N8RTzbjADnihruGnKH5h9CmPqRZjmzREROGsi+L1JYXcfaEN+4CMmr038UhmaidC+DYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8QyfOz1Wo04TKr9uaqIJsWjhOVARw4Bb0tlrDMxSi1RMM8GX
	w03RmBFRfz7go5OEhVDdSzSObG1+x/k94CesFVhBEPA3OG7tQbevM1rI+xQBZQtEbqIzftfq/BB
	1BAnYbI74+4LwTdiohXtvOTHnNVWRCN8a8LxsmxrLJ/P580pAgF9by4Xf7OCr6DLgkUk=
X-Gm-Gg: ATEYQzzL8v05VS05o3X1k1GZex527IY4+va0dYEqCFa7cOVXBZ/e9O9lB/DxeF526N4
	VuInXzgWfHelVYWvjIU7ra95i3+jIywFYZCx+AWxnkEZZXwoGpAVKogjYkJ1JqTVnsgRRob0VGq
	dogtdoe+ZpVaGGWlypmEMR2hcwxINKummYyqmw+jdb3lsZMQLtg2mOAX7cfkZgV6XP7Y2HgtQCV
	ql1xlmGHncMag0Yy4Tsm0+C7CSzJw1GOFoyl1iD4x4jZlxw99V9HPCeVAaMKkugJK34RnB8mksU
	rGQbNDys6ouyFCWKtv9sj54L65lD0b/IS7MG4d169FKCuVJJJs2HsSMCouc+dLyjvy0PfyugMLP
	kbR5pXhHYCbKtbiTyNOLrgCpBSsKdlg==
X-Received: by 2002:a05:620a:290e:b0:8b2:e5da:d317 with SMTP id af79cd13be357-8cd6d461199mr1405400685a.54.1773067493170;
        Mon, 09 Mar 2026 07:44:53 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:8b2:e5da:d317 with SMTP id af79cd13be357-8cd6d461199mr1405396085a.54.1773067492590;
        Mon, 09 Mar 2026 07:44:52 -0700 (PDT)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dada3b43sm27650278f8f.13.2026.03.09.07.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:44:51 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 16:44:45 +0200
Subject: [PATCH] arm64: dts: qcom: hamoa: Fix OPP tables for all
 DisplayPort controllers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANzcrmkC/yXMQQqDMBCF4avIrB2IRkv1KuJiEqd1RE1IbBHEu
 xvb5Qfv/QdEDsIR2uyAwF+J4taEIs/AjrS+GWVIhlKVD6VVgyMtjvAlOw5eo/MeNzIzY1Vr86S
 atbEK0tsHTqNfuev/jh8zsd3uHJznBXihzkx7AAAA
X-Change-ID: 20260309-hamoa-fix-dp3-opp-table-453b8a5e3bc0
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3989;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=fxH1veD+kpffYQiZ+e79p3JhbxkA92PQ/Xt0yhjG5zo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBprtzdH2Qrp7LUSZydRIBrjCGaKjPEeVe3MaElv
 UveVDtJKDmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaa7c3QAKCRAbX0TJAJUV
 VvFgD/4tcm+j+xELqQS8Zh/WSsYyOw02i0k07u822dZNUE9Gf84GGS38DFz4TWH1O01g/k4dFL5
 RqGluQcMP18AvsBvslvrtu8qNMh53sMGBIIpWpr/qyhk8J/NUDyNvd6yFeYzSjPGfzwFrttW+ym
 2myiD/7TIM87fjE62sNaTldQf9aO7EcPqLTcXjarXr2uSsHHIr9zkxcT705ehWrXCdHG/OyVDYX
 30F1EGKpUOLCGqnSAB9KkgZx39wm7W73O/5ycHzB7Jkw2acDc0nO4g9FOWQNYSXb8dnHliKKnwm
 1ahVHl8l5DN4cXogRJwqq/KDpYApj4ktUEIL5cwRqZsFUCVqpsrcObDU6KN6nqt1cYh3i6KhD/u
 NztpINmFL0GOpQHfP1qex+2BmBfriXj/aWR7cLZE7MFyU1ZcFKILMCxsHyj+myfVviCun74113c
 DwFcvV8qG5KLX/evdGtS5xCgfcXAeq9C0AgR4TxoswZkOIVi+9dHuZvIfvOw2FfzpTM2poDVt2m
 2Yit+dMyQ2mDGb2+B12RekqCPpzm/NQP5vRMtgIKByAVg+cWdd8+DNMSxPjyzrVjcr7oiOk9pId
 agdWe5gB41tgXvi9VdGXHE4GIoVp7NdSka9yYJARzO8k9M6L7O3dRSNMqYjqyOvG3ubvd3i7fSh
 lESvRgmDbop5MXg==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX/la3z923wZFP
 liylFMbqTvRz5DNcKVxRM9H9cVKMioEkHKkRq0BtltJSqYMknXBN9f771+8o+zwCiKVFFPETU0I
 XEf3QZWbqcjdpqLVMtqJusfT5SI5YaJ03xVcAbeiBhVQbhDHWiEaOvY8vlj9xZf+Jq3nwTeyGxF
 xW6sfCCKGR+ji29h8enWeU1DtG7M+hp4mnfQhZzqSx6uL2dSAaYj3nMF6L/0T7deIICUjO2hPgk
 22Ehsttwta/3jJfGYCa+qVrQGIATWdAzfO9zl5S07eg/l3bpO7cjHe1JQ7uNerA832MFjSzBOjG
 ha3pxy1loA+xP9SQBtqXD5iTg/EFJIh7ZsltRJmyPlpK7eCM+tLtCYo1X0/M8gH/4MoCgmL90s/
 aJBwarK9/7F2Jnvzw+eNBkAkUp00tR5XYgpQaFxM45GeOMNIf57FeESAbQntNYbnYLfFuqPxF54
 HgCfJGKBjBsGPRjyLQQ==
X-Proofpoint-ORIG-GUID: _jGsVbRMa4aJO7iSpzsm2s440MAWPnuf
X-Proofpoint-GUID: _jGsVbRMa4aJO7iSpzsm2s440MAWPnuf
X-Authority-Analysis: v=2.4 cv=WtEm8Nfv c=1 sm=1 tr=0 ts=69aedce6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JWXbo1LX0rybKiAwq2AA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
X-Rspamd-Queue-Id: 76CB723AE35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-223675-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

According to internal documentation, the corners specific for each rate
from the DP link clock are:
 - LOWSVS_D1 -> 19.2 MHz
 - LOWSVS    -> 270 MHz
 - SVS       -> 540 MHz (594 MHz in case of DP3)
 - SVS_L1    -> 594 MHz
 - NOM       -> 810 MHz
 - NOM_L1    -> 810 MHz
 - TURBO     -> 810 MHz

So fix all tables for each of the four controllers according to the
documentation.

The 19.2 @ LOWSVS_D1 isn't needed as the controller will select 162 MHz
for RBR, which falls under the 270 MHz and it will vote for that LOWSVS
in that case.

Cc: stable@vger.kernel.org # v6.9+
Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 49 +++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 4b0784af4bd3..645bc412b0aa 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -5658,18 +5658,18 @@ mdss_dp0_out: endpoint {
 				mdss_dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
+						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
 					opp-540000000 {
 						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
 						required-opps = <&rpmhpd_opp_svs_l1>;
 					};
 
@@ -5747,18 +5747,18 @@ mdss_dp1_out: endpoint {
 				mdss_dp1_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
+						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
 					opp-540000000 {
 						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
 						required-opps = <&rpmhpd_opp_svs_l1>;
 					};
 
@@ -5835,18 +5835,18 @@ mdss_dp2_out: endpoint {
 				mdss_dp2_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
+						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
 					opp-540000000 {
 						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
 						required-opps = <&rpmhpd_opp_svs_l1>;
 					};
 
@@ -5918,19 +5918,14 @@ mdss_dp3_out: endpoint {
 				mdss_dp3_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
+						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
+						required-opps = <&rpmhpd_opp_svs>;
 					};
 
 					opp-810000000 {

---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260309-hamoa-fix-dp3-opp-table-453b8a5e3bc0

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


