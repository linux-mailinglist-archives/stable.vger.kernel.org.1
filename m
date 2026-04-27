Return-Path: <stable+bounces-241221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKcqDCoE72kj3wAAu9opvQ
	(envelope-from <stable+bounces-241221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:37:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E238C46DA3F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AD793027DA9
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 06:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC7439099B;
	Mon, 27 Apr 2026 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oARk0f0p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gBVWpszm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE4390998
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271746; cv=none; b=Mfde5Y8hIKl9EYtJZTSae/P8SQK5gzCd9eENz6XmQiShHj7neQrSil/5vQUNiVec43Q9aIrX4gbFEREsgAxM6Mu27e4WH4MQFj1W3f3CaRhB8leABvx/9JtZGlPWfv32P3SdMxy5Oj5VffJKaKp3CIOanZwh8HTG5hkWDfbT2VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271746; c=relaxed/simple;
	bh=aO28WQilAxZVtQvI+wCGetkRJaY0+sEy2pV+6FVXyTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMjye3jDh9qJKXKZ9tKtlEKdb2m1TvtEc2i7XQMK2b3QofHDlwdr/KvfnEylrK2YA75+8zrT2ldpDcrisJrc6bSb6IfmfFbPK2BuOrHbwCt3PilnSlLSunoNv+z1VMZE5CRHoXPnTzLd92EopdAOipAAG3f0dz6S8s9ZkVnh6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oARk0f0p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gBVWpszm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QGr9Kh1716741
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hiUBwHms4Hb1isi9MNvxSr7/NA/P2eiTLjhGmjdWM4I=; b=oARk0f0pCY8Mf9Hz
	Fya6UQRmjX6wEXmriNLNQ7YjlHchBZHOKHsWXxPWlzDw2TS7uwQzPhsi1N0SV3f3
	Ze53DZRO4zHFg9jvU+wovEAzSdgN8TvEIfGqLNzRa79DZuBVXaAf0uddaKzvuhVh
	55r97B+DJjktE0BtKycy3UxenvyhWgUmjR1bwDAToZfW2j6JvX3vZTLaEmS0npa0
	k8zmrvTxuTfYyOkLDu2PhuxiraKIqH7ZJ1hV0KfVlbzqj2Lt54tUepgpJ4JH1OI9
	pOmakGQHfpZq9driQNNPXi8jd0qeOHiyVw2PxcSn8z1AOF38j5IEuBbtzB5cyTiO
	4g/pmg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnmr4pwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:35:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eb82634cbeso1369884785a.1
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777271743; x=1777876543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiUBwHms4Hb1isi9MNvxSr7/NA/P2eiTLjhGmjdWM4I=;
        b=gBVWpszmoTZtCrnSFsO0bICrOqJK643kWyO1ushHyyACXwzQwaUF0sJW71UqXHfWnI
         6bv21xEzNgDt1Q8Fcmi3Iu1l96gcQPvhalcDoyJH37ok4WTTMYDIfN8d5SDAZAnD/AbN
         KAG2bsLrd2gTK+2eG/2ppX/ZjknJVHZ1AvKNkhjEcuJOlZioGcUyVZZq/EnlOOd5WA1B
         ReJc4l5eXsXrw/6dKi4qAHsEYRvaxi6alkwP83X20EaiCrku4qSlz4yztphlbrvAZmCj
         ru2lZZQABNM/hHJzxyZat53+MvVoxSbYaY8ZNktuzIx7LplS2KmirYdk1c42QDOFLWMH
         9dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777271743; x=1777876543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hiUBwHms4Hb1isi9MNvxSr7/NA/P2eiTLjhGmjdWM4I=;
        b=fOog8HY50dTM36RtDDgWsVyDGH4gL+GtMOgvKxAWJKvB8UI1qMk/K+X3hYNfPUCfay
         Bo8EBIIskWEAUnbxZx+9ZtdPmefNR/aqQaTbqxaQLIH+S85jPhYf+xQYHwTzFs4Di2dh
         oNHHbQArzJAqP2zfGO2SmLZ+vvdQV85nlEA2MjynLHhoZNK7VONswdMOiNvPFMbJQfxC
         1BgbFqST37+bxpsgwV5PcAZtputAl31PzIZfQVl37xfF3sylDf6vAO3bMTPf953L3ZDZ
         sUV34EEzYVREXqTsxh68IKoqGwdrP2mT+KB7jHtyU3clLMENtOGdkHPOGC7SA3XPiDlh
         afvg==
X-Forwarded-Encrypted: i=1; AFNElJ+iR/VjUTWrlTJMoFWlutAF60zuUmOSEGmXD5WHxeXNHPFApI/YzOkliRRlkCRy6q+NdFUosA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUMzKSY6ecKT0wdcwYQiGYdD043DFwriez6Tc9QHtvelamQzA
	Uad9UDTBm7vDqX3v21ae5I9QUS0415GH0V0Sr4yqGfNy1m8eE/G8KDeawWEZxo86T81X1fhdxtl
	/1GB993XSDIEJKxPsMWtQPX6KtkZSaqJHnUj5QbJlu/8D4w8uomuq6nP6BN8=
X-Gm-Gg: AeBDievb2UGLoaeS/TINnpVYu33akXKCyxTPnDnm4zA+U09TzbiWA57irRsUv2ukifl
	tQEyRwItbN4HELN3cw66DYKQOlxHJTI5t53KeTAC13cFTNU8qH2q6c5in76kaUb1hDAcTzDiPim
	CGRyHzHK1ro3WBpJpDZL5GL9Q9TVzgaE+BvzyXrCMjRBxYEYzy1OxeYh8FBEjMiiQMFjEK4Fl0h
	EUUGmgytmZf8ehIe2IByfglh1176R29Wx0rF+bL8tHTyanEUGgvv+uQ+u6FkXHzrMP2Em6j36Xq
	uqzEt1NBujNORhGtqbhSdqCDDljM5CuNxgFji72Lef+FoxoZXRm3zifymzVkEh1TNKUGa+CTaA0
	e4p8NdCo2b2+bMiJxD5G1Buo3IAYSuBz1nJbYmsTklGi8mAGCe3aFd0JDgnTaz5E4AdRB9n7roY
	hqf0zLqkfMv5fVBGxDVQ==
X-Received: by 2002:a0c:e003:0:b0:8a2:1149:3337 with SMTP id 6a1803df08f44-8b0280cbac0mr536922106d6.24.1777271743151;
        Sun, 26 Apr 2026 23:35:43 -0700 (PDT)
X-Received: by 2002:a0c:e003:0:b0:8a2:1149:3337 with SMTP id 6a1803df08f44-8b0280cbac0mr536921836d6.24.1777271742775;
        Sun, 26 Apr 2026 23:35:42 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac7d4e6sm251899256d6.20.2026.04.26.23.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 23:35:42 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:35:22 +0800
Subject: [PATCH v5 4/5] phy: qcom: edp: Fix AUX_CFG8 programming for DP
 mode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-edp_phy-v5-4-3bb876824475@oss.qualcomm.com>
References: <20260427-edp_phy-v5-0-3bb876824475@oss.qualcomm.com>
In-Reply-To: <20260427-edp_phy-v5-0-3bb876824475@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777271722; l=1322;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=aO28WQilAxZVtQvI+wCGetkRJaY0+sEy2pV+6FVXyTc=;
 b=KhT8bRFH9JS6NuUlvP1bcZQMegP1Zye5cxMcaApOj1lBr2zb4OC7W9m2Q7pfbKczPsrAsty3K
 WxNAK+1XhaKDXx9A2RQ4WZtSERsqPM3AN5McM+OZsqiUec4ko+30Wmf
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=aqCCzyZV c=1 sm=1 tr=0 ts=69ef03bf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SO9rCO7GgoKHDwPkKK0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: qrODZZEJc_iWVdVDE9TcCFfdKBRjkHJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2OCBTYWx0ZWRfX6PZp8asXuOb4
 zXK/frj41Ytl7b9F/pfOhdvkV+4pKPAjH1PyopXyK1pt+koSExpvhWKv1vzoulOtC7Rmo8okwoa
 25iWmz5a/nGO5vJ4ICNmnP2NXxkvOiEY9ujJLWuT2UOhRi0ZZVvxhQyOv8L+Zsn9ena0ycv4WOS
 +zU1ZT1Gds1Nlf2xlXScezNrzC6DqeBTvGR+bH+KkGYoNaTjRjluVG7VzeYfR1tYULMuN9dNN7y
 u+Tg2iNmqNMUEK9NvsGhumz18Xj0e8Q0tyz19ztf+htpxrvp0xfp7laG+n63nObNQm8kLknTOVC
 eucHgxHLCRV4AOBrcUEK6bBK7MGedQBLFeVV9knp3I7UXYz+ABDrFC/J/KxSct4RJ7ObEIaDzg+
 YxZoHuo+8XzfKRTPU98DwoR/pJWnjO/srWIrjUzisEKgmjYFSEvcrbh8rVdPnsPQOOl6Thc1JFl
 DawegLGoCO47saefWWg==
X-Proofpoint-ORIG-GUID: qrODZZEJc_iWVdVDE9TcCFfdKBRjkHJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270068
X-Rspamd-Queue-Id: E238C46DA3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241221-lists,stable=lfdr.de];
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

AUX_CFG8 depends on whether the PHY is operating in eDP or DP mode, not
the selected swing/pre-emphasis table. All supported platforms already
have the proper tables, so remove the unnecessary check.

Cc: stable@vger.kernel.org
Fixes: 6078b8ce070c ("phy: qcom: edp: Add set_mode op for configuring eDP/DP submode")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 3e613b374032..3a848f18a8d6 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -325,12 +325,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
 	       edp->edp + DP_PHY_PD_CTL);
 
-	/*
-	 * TODO: Re-work the conditions around setting the cfg8 value
-	 * when more information becomes available about why this is
-	 * even needed.
-	 */
-	if (edp->cfg->dp_swing_pre_emph_cfg && !edp->is_edp)
+	if (!edp->is_edp)
 		aux_cfg[8] = 0xb7;
 
 	writel(0xfc, edp->edp + DP_PHY_MODE);

-- 
2.43.0


