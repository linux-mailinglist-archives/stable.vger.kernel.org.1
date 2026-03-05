Return-Path: <stable+bounces-223188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FKkN9RYqWkh5wAAu9opvQ
	(envelope-from <stable+bounces-223188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 11:20:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61720F9A2
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC7CD30E1CF5
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3E837D134;
	Thu,  5 Mar 2026 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a+P+Un8E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JtSXN7jZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B69E37D13B
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705848; cv=none; b=c8GkgP3kb7AyULfvg7sBjXOK95E9AmLn0hSrsa9BuOrdI6LlGoD6IKGDp57HoNRXBFSiKpddQ2uIPAForKFlG70qmGlxSMuJXC7myt/3ZCMIEBmOOVSttBatINxPPwZwTXPold5+KxTm2QFaFVCBAPRw19eNsj8x1l6V7yQk7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705848; c=relaxed/simple;
	bh=76JSLPRliwCH2DQGBr/s11LQAsmvDKZNerj3OgMQbbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJclSOwzN6Mo8kuk/CV6YnAMHkxtLMRdkfdFKPiM4qPuJOyfjdWDdgrvcZzU94LxHK/9dKKlyYuUShhjYDoXUxRH8t8gEqLs4Y2mVFR/XJ8pgI7xPiJR3AMZBaULiRoNcm1RV1OJDdSKpsD+T2/LfwvKxgpQgREjvib4HglAl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a+P+Un8E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JtSXN7jZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AG5RC2118325
	for <stable@vger.kernel.org>; Thu, 5 Mar 2026 10:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JjlwyC37ZMKEW9uWvYiZHV/c8H3CQ/IJn8+Myzw34aM=; b=a+P+Un8ECkESr8ly
	CflvRw6US4IorqTkLiPc+zarpjfU9UI8qHAnvrLSFbnioFXPYul8a1Dgb1qbYSlc
	OLcyJNZU9h6zxjcdAoNeAy0EjVIuQkUBax14r3G7rWY27lLTrDLfwbwrh+E8SmR2
	3ba9gdRblRo5N6HE/i9sCO5my6BaY1ahs+AqcBeVnfSSXpPhgD64ANBmZWCzSm7z
	Z6beQXB/1oe4S6vx+Eo63UBGr35bSS2gSzEFtS5r9HRwm8JqU0i0xziAeuoPTFJg
	Oj4rWs4YMEzv+psA/vpXC8BrL0z8CN8wAgBgWRzxpY+5Hw16SpPYC3gcyxZzFCnK
	9d0kBQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0m2w7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Mar 2026 10:17:26 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89a0c0d4f69so139207626d6.1
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 02:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772705845; x=1773310645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjlwyC37ZMKEW9uWvYiZHV/c8H3CQ/IJn8+Myzw34aM=;
        b=JtSXN7jZyStq+MXTrHaeeG5TM6+ybGcbvPtnavY8k9plVNf0O3A5F+IWzmX23mYW7w
         mlW8dz3KPWCy/QcmoT2doUclh4YkheL8vOZx/6oUd4W1DwZnjvoR+qWRtwxG8PHusVSY
         yki3mL9ay1RmYIz0o6/z9ZkoeKvENDDNG+p6OAu6Xl6HwAEzxc6QV1oC34jLEnnzl/h2
         /Iby7C0iR/hmt9YXUmly6zpreeM8XJvz1JkxSdHzPiiSTZGql0zGgsOVz09gZkbVEvcV
         y526GBPdekt5cpOMT5kqaSRBjJ9y7alqY9qrNLF0NavyOz0jYkyWIasg5Rbnjogjzsm+
         9mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772705845; x=1773310645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JjlwyC37ZMKEW9uWvYiZHV/c8H3CQ/IJn8+Myzw34aM=;
        b=Y+gS+ZGxBY+zaVBptVR9kSpPEHyMb90jTxqf67sSHLt6BsNYsxIHpssouaLfiXFCQ1
         3dept0xXJZRPXiJKccgyeOxlYDO4Ye6qn4TKG+qjfxWVixbU6mS7BuXbLBv5G0PqH3qY
         +VH8kMf2BCMid6sztj9OR+0PD6si38T2XAgyvM0xYmeLmKJMsY2guYSz0USmdhFN8Fk2
         DANNNEv7Wjw+kxmGQ+GlEq0Jo22Ol992EGBffRDsSRBEOJgtf5o69TzlXmnMb1T9g7eJ
         zwnEHQWPlJiE9KYxeG29b6rVxW4DA18fvgMMrbpuNsZjOl3rv02CRSbPqtWkSaRPgc2q
         uCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvtcERHkZFUSYozmmx3qi9ebcI4SCmYMYLGHNNTHthsyQtOfKuLWmuUy79JneufuAAAaRWaks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgXCweHxKI5/8rEQyqbZPhOJ+wPdZ1bralI6FjgcyAGOtRQYxU
	3ZGSsIyc92uxh+Ch8JgJnMAkKQK10ebPMBZIKnymgXZZaSzSIsWZtdQ47qJKJe7/9UVfCZfeNxX
	+9spFAB94P1QSptklTDQ6aHEWxx0vX03783vVY7Lbr4ATtUP7ZJiUUFsLQ+Q=
X-Gm-Gg: ATEYQzzIJVuGQIiB30LTmgbXblrurKhaOkL/ig5TnJ1vbCiWdKwBRIs5Qz+qiwZx5US
	wxh2EEPVOJTSkRkNvXor+q4LqmSUFX8kxU4WaVPaVx8s33M5JdOidCKDZz53fM6sc1o63XkrMkk
	1Q7wgYQcRZIZUyB8HyDZsbf5s1Iwx1jTFtmMXbDSjvuCiNbcgGc36t5SoxMPBluV0OJIpWN6iLK
	j77x9DW2WBgUjZJrxBhwTffAHCIkfCi1z4IXDImQtzW672m7Qu6tA8w8uTZk7mnz1Gdkqk4IL+c
	rJSyXY2OxiLb5SKNrJieXXTWkegkAoOEXbyRUP6QGfoiL2o/D2hhb96H5B0ncOY8T+4o6AKgp83
	nasaA36Hh/cjQv1IcVPDfEjjrqrGnlj3gez4wEOe5wxXPRSLFDW0xspmFifbNm4z/F0Q831pIqs
	obWesFa3M=
X-Received: by 2002:a05:6214:623:b0:89a:77b:837e with SMTP id 6a1803df08f44-89a244779b0mr20540426d6.6.1772705845339;
        Thu, 05 Mar 2026 02:17:25 -0800 (PST)
X-Received: by 2002:a05:6214:623:b0:89a:77b:837e with SMTP id 6a1803df08f44-89a244779b0mr20540246d6.6.1772705844891;
        Thu, 05 Mar 2026 02:17:24 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507451cda0asm194096731cf.24.2026.03.05.02.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:17:24 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 18:17:07 +0800
Subject: [PATCH v5 2/2] drm/msm/dpu: Correct the SA8775P
 intr_underrun/intr_underrun index
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-mdss_catalog-v5-2-06678ac39ac7@oss.qualcomm.com>
References: <20260305-mdss_catalog-v5-0-06678ac39ac7@oss.qualcomm.com>
In-Reply-To: <20260305-mdss_catalog-v5-0-06678ac39ac7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Mahadevan <quic_mahap@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772705829; l=1244;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=tO41DjAOfQzqwZFbNKiKJu3u3O77mCrCtRYIBZJ6ZXY=;
 b=zlSVe181QTt/TFKu3KzUdOpSymLiiZyQyFbIa9D5xvvJSW+y7BQK/5zMvgHFA1dusq9HOeCAe
 lPO6wmfzSQ2BA24CSjzaVP6TSOf7rpK2iAM/J6jZgCGc1Oh7H9L+eyU
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=e6wLiKp/ c=1 sm=1 tr=0 ts=69a95836 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6ltB2YlUPjWEuFaGMccA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WpIPe4DGjKk9Bbqo1D8sJWsIUq1twV0w
X-Proofpoint-GUID: WpIPe4DGjKk9Bbqo1D8sJWsIUq1twV0w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA4MiBTYWx0ZWRfX710rWH6e7dG3
 H15tCVzkbKrivrd+XyslZSC38Wpi+MkOm/gNoSXM1e9p6vYDl/JAVmslnOiU5Nvu/IjsYOQbZko
 tJqUh553VZ2w61IKfDXFshXtvXuKaJs1jRLR1VSEzSV4Wim+x/DeFI3iOn9Y8cpEinEF7REotR1
 7gD67X2Cz0jaH/tydFkWhkM/Lv3gJkjw1vD0bcbnsvZGL6ajR3wslb4u1y8cdTSFRCaT8N40sYq
 UFQTW0whVk7ncoQ4hhZPK+l3Gt0OxJmZ0PWlRwYuw8zRs31awOwPzU6P+kIJcWEk0UxOZID0Dtg
 Pipkj5dPeJD1Zp0q7vEOQTpmiudRqxNntppaj2mpcxFwMJMkSA39k+y3lvid6n7LXscW0Vm+L4P
 IKemJglV0C2O0YkWXQCPWC08htGspPKAFx5yX7MOii0gSY3gZDlAiqq9gLlE7QlmHxWmyhR52WO
 2PhGAwV7s+NDSP2BFhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050082
X-Rspamd-Queue-Id: 8C61720F9A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223188-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yongxing.mou@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The intr_underrun and intr_vsync indices have been swapped, just simply
corrects them.

Cc: stable@vger.kernel.org
Fixes: b139c80d181c ("drm/msm/dpu: Add SA8775P support")
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
index 6b24e9e84dec..00fd0c8cc115 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
@@ -366,8 +366,8 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
 		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
-		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
-		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
 	}, {
 		.name = "intf_7", .id = INTF_7,
 		.base = 0x3b000, .len = 0x280,

-- 
2.43.0


