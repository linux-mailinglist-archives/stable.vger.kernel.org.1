Return-Path: <stable+bounces-240273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGEDLGlk6GmpJwIAu9opvQ
	(envelope-from <stable+bounces-240273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:02:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022E4423AB
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA5F6301EC75
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240092D77E9;
	Wed, 22 Apr 2026 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cf1Olo02";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TRTjXQUW"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE87B2505AA
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837733; cv=none; b=fEPV19/j5v0GTfEuqka+kvweMpR/d0zvwibLhJEtTMZDlGFsZ5Q57itphxiQuiLmNCvu3Moy83Ug/T2jzSkOctAFloiSjggLWzVxGD6yqrzgOVsZwBznFXUiLdXXoH2cOblK6y6ANM596taep3YMrnBSUT7FtkHpWxYgmobhC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837733; c=relaxed/simple;
	bh=aFSvRHF5TyWCpuwZ48kSZW9StI15Mat3A1Go9duK9TU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fkXt9e3WYuHPjfYB172p/vY0tvAxrRRK6KoExRCiAd3NVzBnlR4VptPplpUsxRm2cRExmNmYfO+DrHqLiUSEkapWAXdLGwftL/NdVS7De0/ZTNTjUwDH+j1jGR0VrCGYzBEgJwZd9W8GTyJjiZGxjW7nCVbqOmD2GSj1+6Oi7N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cf1Olo02; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TRTjXQUW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M4xQbr2123735
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GDn9/QN5j3kDRhyol4ojzl
	wNnIM0CIsP7N6m3h6CsA4=; b=cf1Olo02ApM9jNheKk0PZBB/HWXybNOKYUtZTh
	CqnG0bJ/tC0/EA97S36a7AVunn1bo9vYirXTWDLMldmkwMbU74w2UFE6hPkk54Xr
	Hn32MkGo+YgUDcGjJHofRFNrsZJe3+hYdVQNRW7ijCHWlhrgb4MAHP3kVRE1qZ/3
	kEP0APDx1D8powJLgA+A2USKyiY4QKgGNBjdcWDVYK6DOX8hIXFgcgerw/rS19lb
	zfMqDwFxpmiS+ag04st4ItS/Zu82ezkpmr6n4PownNWI75zjRMBLcjdTi0sL1nSj
	NgYB+5N5t4DtaprGsGOphfk4rx8/3lRSDMlNtp7MJ+9vsVeQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfsw0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8d5b5d607d1so977101885a.3
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 23:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776837731; x=1777442531; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDn9/QN5j3kDRhyol4ojzlwNnIM0CIsP7N6m3h6CsA4=;
        b=TRTjXQUWerQLiZYytaU2JYm35aDBy6t2Gy6a8NOxPIefq3j/26rSlhyo5SEIsdkFhD
         btHJwmdQcDvZdjxzkbjeDLMa2WJT5dm437yoZGRlbIK+YBVfbKsYQSYakRgH5arWyrFf
         G54GCF+S97XaiHFfJ0NHN3n5G1AIfCV1Pmi/sBN8c1aFkoYZLDODTPWSSlkwxoOfi6EX
         hJ6MBatH4NiNvSetes5vNjqauJ9pvcY5x39wCyS80dkCyXQZYHhZAack6Ur65d5o4w94
         5/NCTjKysrCK8RnuU4R33reW1oTXBillZ36yjxLrBRelDwBEq+IzYqYiGoB2lhV5zm05
         14Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837731; x=1777442531;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDn9/QN5j3kDRhyol4ojzlwNnIM0CIsP7N6m3h6CsA4=;
        b=WY5xL+7Rn2BLPCKGiklgXr7ZNHXZ5btDVPLCjYGQUGqCZUcaY+0ng04PEk/wb6ls8O
         PEF8QbFviFMfIbFLfpaVrHpMCp0byvvO+GuhwmTmPbbStlhOU8ocsdYHz72Y98fE8upu
         rcsXzTpY9ZPvvWmXugookUuDECu0np2a9Q9eoaq1lK3EiG3HBz1Wyra0Ih0WOrQK2eAx
         GKPPPl30SJnr6IN0zFoDhm/BFNBg4pPwyxElrMDdKgwE7+9uOShcdpY4Hjg2H9aoiZsR
         GHzwzQFD2dHgeDHGbWMbcrSuj59NHgUU9Yvv0uNr4LVS4CDPN1sYPhRylSXIjEojGZrx
         3axg==
X-Forwarded-Encrypted: i=1; AFNElJ+6JKbBLtepIziGxqnif27kHek1K4UYRk9bkpghSpikwi3gNgmj6v4abpVt1ji0DxvfMFrqZTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgO0Srk4MCJ9s/9GSxAcfivVnaRl8zVZ+LVUwm+8685Ez6C2O5
	cmyNN1ZtWrAjok0FcQlg3z+lkz8trW5XqD0s5Rq1UvsCfwKX8kbgv1bwARgxlUfDxycahoSYdvG
	i9eXoX8pDZ1+XF3dyrcr4nZa5JOfOy5C6JISucgmMe4uSsOEySBCsyLuFvjo=
X-Gm-Gg: AeBDievGSrNlxznycxUeh9ZVO6vb6NydAuA0Ef9AJwocbQdtdGjxptCriajOk49ZU2U
	Ggc7QYE6dsj5SJj4Ogh5GVNn57r6dozxsDptdCQxlU30EMTOkeS8wbZPLm7Fz9FfaPEUZrDUywx
	0MwasNQbOvKz0jFvAbw3BRPt2abqhle1EqZZrXZrGWA88WNXALKw8wwrKL5zXCC0elvyqQ02iVn
	tlWblCx3ZoeoXrJHQVvr9wzdRN10Jm8P7XngtUr9M189oCu2q9NrCjAlQmSTqqctaesgNMUWCGR
	U5YDPI6YR9DF7Mvw+CnHevPLmccs039xkGJkKUsU29EoV/8R2YwLbjYaZgENgzGAIjNEBUxdHkB
	nf/pbfJsY1QNG7/xsvqBcZNy8G5Khc8bfA4z1t0o4/Bz4t7ywfbE/etA9DzKvAODa5lJA9LLd9O
	3de1LCSHrAGwSuAg1RwQ==
X-Received: by 2002:a05:620a:284a:b0:8cd:b317:b464 with SMTP id af79cd13be357-8e792b596b8mr3051065185a.61.1776837730928;
        Tue, 21 Apr 2026 23:02:10 -0700 (PDT)
X-Received: by 2002:a05:620a:284a:b0:8cd:b317:b464 with SMTP id af79cd13be357-8e792b596b8mr3051059985a.61.1776837730333;
        Tue, 21 Apr 2026 23:02:10 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef12122800sm237379985a.18.2026.04.21.23.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 23:02:09 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v4 0/5] phy: qcom: edp: Add DP/eDP switch for phys
Date: Wed, 22 Apr 2026 14:01:50 +0800
Message-Id: <20260422-edp_phy-v4-0-c38bef2d027b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5k6GkC/22Oz27CMAyHX6XKeUFOXIjLifdA05Q/zhpp0JKUa
 gj13RfKgQPzwdLP8vfZd1E4Jy5i39xF5jmVNJxraD8a4Xt7/maZQs1Cg96Bhq3kMH6N/U0q9hY
 5gGk9iLo9Zo7pdzUdP5858+VahdNzKJwtLP1wOqVp3zjmHVsE35IhYkXYEkIXqVMcyEYXjQFtv
 Xi4+lSmId/WJ2e1yt7+mZUEqVERaeciRnUYStlcrvbncXJT26qa8YUj6BeOFfeWagXToYN/8GV
 Z/gD1kGrCMAEAAA==
X-Change-ID: 20260205-edp_phy-1eca3ed074c0
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776837726; l=1988;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=aFSvRHF5TyWCpuwZ48kSZW9StI15Mat3A1Go9duK9TU=;
 b=MSd8D1kAFZdRDD5N9Rl1pwyDYZX9J8ByeFUAmw89nBvWXN3I6O1ASr3+aPNgxY9IXcztW08yL
 tTsfP8thnR8DASNNZXSBNQwgXfp8fHMNpdfpEu1NKpkYo2BLcxNb30/
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=OdioyBTY c=1 sm=1 tr=0 ts=69e86464 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=M-2OMZX0rM6BGFiE4MwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: -WEueKDOGxNPV1nSyrv748b5iyq1jA1Z
X-Proofpoint-GUID: -WEueKDOGxNPV1nSyrv748b5iyq1jA1Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1NiBTYWx0ZWRfX2SAHen0Jc3F3
 Ultn7EdYOynxzT5vZ1nwTJuEPdYBvcHse3a8gdUkWZTFTfR8lnvwicigaYXxPqXXlAAJWNuVZzk
 EcOgfQKmmpVZSE3yP2dMndqxNkQKV6VpF82ezqMEv99VdeSOd/EfyoNN2hszIMiFM/0cXOfVkb8
 QLHr567ytTib09JhL6MkEPUER8D0Wb2GpMFzLlvlOpR06y8weV/Ag1jStHLD7Z87M1c9x3Ph2S6
 4tZuxOzA84w0VfiZxOdPc2qscC5oGyhev0FPdIPIxmMG40/43Iva/a8s7cnNkNqs3SwE/Pr67CC
 zkHN9lz7EQ8HPZlB19qIyOupcjBVtxvRgBmAp/UOlwSpKEpNglNUSX12aUlQW52nyru3+7bS2Ry
 VrwdxG/yBdpI/rleUTT5fsXG4UI1jgh2ZtXHBlloVI9aqgE3YecG42uDDcPzgWK/9R1M13795dT
 t2HeUGkiwSnKqZAe3VQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220056
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240273-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[yongxing.mou@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3022E4423AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the PHY selects the DP/eDP configuration tables in a fixed way,
choosing the table when enable. This driver has known issues:
1. The selected table does not match the actual platform mode.
2. It cannot support both modes at the same time.

As discussed here[1], this series:
1. Cleans up duplicated and incorrect tables based on the HPG.
2. Fixes the LDO programming error in eDP mode.
3. Adds DP/eDP mode switching support.

Note: x1e80100/sa8775p/sc7280/SC8280XP have been tested, while
glymur/sc8180x have not been tested.

[1] https://lore.kernel.org/all/20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com/

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v4:
- Splite changes.[Dmitry]
- Add sc8180x tables in a single chagne.[Dmitry][Konrad]
- Link to v3: https://lore.kernel.org/r/20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com

Changes in v3:
- Rebase to next-20260224.[Dmitry]
- Only enable TX1 LDO when lane counts > 2.[Konrad]
- Link to v2: https://lore.kernel.org/all/20260213-edp_phy-v2-0-43c40976435e@oss.qualcomm.com/

Changes in v2:
- Combine the third patch with the first one.[Dmitry]
- Fix code formatting issues.[Konrad][Dmitry]
- Update the commit message description.[Dmitry][Konrad]
- Fix kodiak swing/pre_emp table values.[Konrad]

---
Yongxing Mou (5):
      phy: qcom: edp: Unify generic DP/eDP swing and pre-emphasis tables
      phy: qcom: edp: Add eDP/DP mode switch support
      phy: qcom: edp: Add SC7280/SC8180X swing/pre-emphasis tables
      phy: qcom: edp: Fix AUX_CFG8 programming for DP mode
      phy: qcom: edp: Add PHY-specific LDO config for eDP low vdiff

 drivers/phy/qualcomm/phy-qcom-edp.c | 221 ++++++++++++++++++++++++++++--------
 1 file changed, 173 insertions(+), 48 deletions(-)
---
base-commit: bee6ea30c48788e18348309f891ed8afbf7702ac
change-id: 20260205-edp_phy-1eca3ed074c0

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>


