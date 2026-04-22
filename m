Return-Path: <stable+bounces-240276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFPoAWdl6GmpJwIAu9opvQ
	(envelope-from <stable+bounces-240276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:06:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D81442474
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7366230665AF
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319AF29D26E;
	Wed, 22 Apr 2026 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ar/CUHGd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iwdxmyto"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5F2505AA
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837753; cv=none; b=iWiBe45Z+KxHD1fY09Ep3+StdP4VJRaofDrk3S5ERPB8iIL5EbXMA/vYdHl/UCKfFZj2e+HtzT4xsc1xuDC4pUM0EEGzC3QBErEgvxOcuEOWbFxCOfCg5fZyWsQVw9Z0wI6PfYnsivDbXMp16ghzYsBbD9cFffVKrSqU/hXP2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837753; c=relaxed/simple;
	bh=RhFRLlIrjEyLFZIjMhkbMlMfeYE/d1JO3bZyxo2u2Rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rP0PI+d2neafnfXYLq2Wnv30Zw1loVG+C35/BXIAkryZn2A9Jjcx38TCJnst0Z8STvJIccleaqI+C4sQTPuzTTvEPyq90GAwG7PNeBIB2ACTWfrgrC2M6pwYxgG6d3ELHqtDwnWikMcsJlo6CyhqIvMK3j4Y2ePz37/sPbPJmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ar/CUHGd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iwdxmyto; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M4oUlW2000975
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P3nGx0uGWf5/fdHyton5z0NTOdFkPwqGvS8tV5dTIN8=; b=Ar/CUHGduT+LrL8d
	VKJ88rtqH3A+ELi3Fy7xnZRuyWHzW90mcH7ASGNMzIJWTDc4Q9FTK94dfYqnQ8D9
	eWZ/IFnRwtnHg6veu4pHSE/0pU2lF5SQ7U2ntGOgHCXbbn4M3d1El1WvV5XMTJAE
	wOB2I633WIYdulJzf704otEliQrVoAg9w6Y5shUMfWfHTWXm+jrPcuawjuExVWPF
	TFilDsNHFBGAvYkHTw5SoGSDDr3PHj52bSiFmoOjw94Y+5MwVYgC906gBllscTwI
	LxL27BdPEtFg6KwB+vpRKG7tcN5hwC5ZCqSRKtCF8/93M9KsQtvPxlSKMKlaYegP
	bAZxfQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenf9ww2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8eb52a22e85so666659385a.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 23:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776837750; x=1777442550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3nGx0uGWf5/fdHyton5z0NTOdFkPwqGvS8tV5dTIN8=;
        b=iwdxmytoabkrcRXbx5oS35qr7f6GTpxtEJdYRd1+5Yv1uYw0/ZZa1xJiAkAVNqXi9Q
         /VjvagDfsWiZyhbG8eaJmkhdCnpjNhapy8IzgU7vrzPSQV7f6+xB4eRt5BL6ABISTuR5
         xllxINzcEqLWQrBC2TEUcbiL7Fo5RnD34rfzliCIZaLehpial+RXrRlBtqYhiHTTSJW3
         yFb7Jis331qvVffIBxhhEd+lgylP7MN4dun0vXtCkpS+CZhrrX2OhK07SLx6HPTxl8Wi
         8+qwqMKiLuhp87SNRseB/NDXdGqSRFURcgYWNw76NlpoxS95QJU6B48hMdhp+x26MunT
         eTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837750; x=1777442550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P3nGx0uGWf5/fdHyton5z0NTOdFkPwqGvS8tV5dTIN8=;
        b=OiTIaIzCVYFuoMbKhDR2/MoUVqsXafvEz5YQJtnZS8jSO+qvvkNlTYVbUWcX6nGHeA
         +5WOo9gMbuvwevmgOwe940TkE1mXRDvp2EcG8evXu4XFGO6Y0YW76hoKtY06TyRRcZf/
         9sbHdtxtH4kGp4ZV4+S/e2mShPuIG6axJ9s6s4gZmiA5aBsuqmUEK++GnoiwUCCorpF+
         R5nIXKjivhpifeEnOV/++U4Wp3nMKBnaYuLV+Iu1BovKoJ6IcImiGB8IE9/7fYZwMFJF
         QarCMtEcWRQaJTiE7IwnfoGY/QG3R34u0VUfmI6NbKIzbtimlnu2bJBku5PscpR1mJ5K
         IGpg==
X-Forwarded-Encrypted: i=1; AFNElJ/ubDPOTa/1aKTqRWsPbBYrDPGU4MBGEz+Ly5qUrdXSbN/ph38DQhFYQNx7hccfR8Ie+t7GJLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEa/XzfQzN3Am5+EAKhECuU7jZagzkA8rWnuXprGRm7p7vz3U
	1v+XZQbZGvWnh4sCcNN+m0D3ghmw4tP1lkIgmZiTtbf3a+rr1sxnV/Z95tPC/jth9ipsMVbqpgD
	IgFv+7HsaYIkdG8JlPh5mEoQ/icHLfp0poMq4jN1O4RbfX0dReeH9tDGetYM=
X-Gm-Gg: AeBDietoJ9U7g+ccDDQbCMGWsLWoYUZHxPuCwN9f+9jkDf9s1FIvgTpr3rbqcU4rO66
	TU8+USKM0QDLJI8j189xLWkgt9nHXjpiDx443tsLZfy3fUzIF6z6BLCUmn8veXDVo4KsQpN/8Ru
	w6mXlemnilYvNmUxEpiQCbqQYdnEeR9UnQI/CvdLMz/dkQ1uIGUq7WQ29B5YBAvQiv/139rCd/h
	gkfwu/3yAGFCh5/nLpvFVdipONQEs9PAqWTNcQUpExOV9dIOI1wP10UXyz/xNyacPFOO2n/vw2n
	rIsGn13V7JgEpR8B29ZK7m0VXDkK28hLL5Gwm/fBM2kbnsQaUBi0DH8uqnlQwU3WWGcuk8xJvgG
	S87hvcrmt8zT2kUalhqHTAPgZsACUyCtbfk/le3A7Z0rAvV5wViJtLq97MWFYCbR1qSEjPI78nF
	qifd7FLBT1+UDFA1W4hg==
X-Received: by 2002:a05:620a:7083:b0:8c9:fb69:e708 with SMTP id af79cd13be357-8e78fd216d0mr2899669185a.25.1776837749701;
        Tue, 21 Apr 2026 23:02:29 -0700 (PDT)
X-Received: by 2002:a05:620a:7083:b0:8c9:fb69:e708 with SMTP id af79cd13be357-8e78fd216d0mr2899664385a.25.1776837749172;
        Tue, 21 Apr 2026 23:02:29 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef12122800sm237379985a.18.2026.04.21.23.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 23:02:28 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 14:01:55 +0800
Subject: [PATCH v4 5/5] phy: qcom: edp: Add PHY-specific LDO config for eDP
 low vdiff
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-edp_phy-v4-5-c38bef2d027b@oss.qualcomm.com>
References: <20260422-edp_phy-v4-0-c38bef2d027b@oss.qualcomm.com>
In-Reply-To: <20260422-edp_phy-v4-0-c38bef2d027b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776837726; l=7071;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=RhFRLlIrjEyLFZIjMhkbMlMfeYE/d1JO3bZyxo2u2Rk=;
 b=3gY99s4GmyTX2jrAG6gyXVJtdhicODfINJMMTDprC2ZutH8VdZaqjWTItYXEIIKiion8e9ewo
 tonr+NGmVzpC2hxStRLzzdqOLfgeq0dG17TUlsKcMOT0h+lp4V8zIfe
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: 2_DNMuQNiBxaoTA4rYJjyVMNWD56hpPc
X-Authority-Analysis: v=2.4 cv=fozsol4f c=1 sm=1 tr=0 ts=69e86476 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Wstf64DO4dhji1mrokQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1NiBTYWx0ZWRfX7qbZ46c8YE2T
 QrQoudgylZ8ZIu92higx5XKFFabDZtdWQqtai8uTTTb7yhpSWjKovfCUa1ptljBnSoTs0VFxNU0
 WsLcuFi8xBwAmFVtoS1V9wmtPIkXZ6Izww+QGbLReM6yhgC4P9euTlOsNclQcD0Nw9dRRYY3d3n
 zNTGOKnrFyuSzoHA/peCIQpnmXARyiYm9rjbvjcnABbgxWlgq75MgAHmUAYBewo4pAieLbLyt8v
 R4uODa0MtPNgzbszhdcT2PMJ+L76nH/8PJ/u3MWsDM/SPkR2gY7Q2/OtTXBsL3H42IjTr3sTuZo
 ENe90uotcBz7gYGDwTv3a8GCHhgJhuh2u2w1XXr2UShxg+5iqhMHHnLY4XrIVLx2z8xu0ES+93D
 6uhUg58uocLy1lBpX8Ig/Brd3aEyqRUJk2fB+qFnp/F0VTg5RQ2L0zbK7htPd1KcPhIdpIl5TQM
 bx+Odo/mgF3Pj5KZdHw==
X-Proofpoint-GUID: 2_DNMuQNiBxaoTA4rYJjyVMNWD56hpPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220056
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240276-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 65D81442474
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For eDP low vdiff, the LDO setting depends on the PHY version rather
than being a simple 0x0 or 0x1 value. Introduce a PHY callback to program
the correct LDO setting according to the HPG.

Since SC7280/SC8180X uses different LDO settings from SA8775P/SC8280XP,
introduce qcom_edp_phy_ops_v3 to keep the LDO setting correct.

Cc: stable@vger.kernel.org
Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # SC8280XP X13s
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 88 ++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index bbd45f709a4b..3a5284522bab 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -81,6 +81,7 @@ struct phy_ver_ops {
 	int (*com_clk_fwd_cfg)(const struct qcom_edp *edp);
 	int (*com_configure_pll)(const struct qcom_edp *edp);
 	int (*com_configure_ssc)(const struct qcom_edp *edp);
+	int (*com_ldo_config)(const struct qcom_edp *edp);
 };
 
 struct qcom_edp_phy_cfg {
@@ -339,7 +340,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	const struct qcom_edp_swing_pre_emph_cfg *cfg;
 	unsigned int v_level = 0;
 	unsigned int p_level = 0;
-	u8 ldo_config;
+	int ret;
 	u8 swing;
 	u8 emph;
 	int i;
@@ -365,13 +366,13 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	if (swing == 0xff || emph == 0xff)
 		return -EINVAL;
 
-	ldo_config = edp->is_edp ? 0x0 : 0x1;
+	ret = edp->cfg->ver_ops->com_ldo_config(edp);
+	if (ret)
+		return ret;
 
-	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
 	writel(emph, edp->tx0 + TXn_TX_EMP_POST1_LVL);
 
-	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
 	writel(swing, edp->tx1 + TXn_TX_DRV_LVL);
 	writel(emph, edp->tx1 + TXn_TX_EMP_POST1_LVL);
 
@@ -595,6 +596,52 @@ static int qcom_edp_com_configure_pll_v4(const struct qcom_edp *edp)
 	return 0;
 }
 
+static int qcom_edp_ldo_config_v3(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 ldo_config;
+
+	if (!edp->is_edp)
+		ldo_config = 0x0;
+	else if (dp_opts->link_rate <= 2700)
+		ldo_config = 0x81;
+	else
+		ldo_config = 0x41;
+
+	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
+	writel(dp_opts->lanes > 2 ? ldo_config : 0x00, edp->tx1 + TXn_LDO_CONFIG);
+
+	return 0;
+}
+
+static int qcom_edp_ldo_config_v4(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 ldo_config;
+
+	if (!edp->is_edp)
+		ldo_config = 0x0;
+	else if (dp_opts->link_rate <= 2700)
+		ldo_config = 0xc1;
+	else
+		ldo_config = 0x81;
+
+	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
+	writel(dp_opts->lanes > 2 ? ldo_config : 0x00, edp->tx1 + TXn_LDO_CONFIG);
+
+	return 0;
+}
+
+static const struct phy_ver_ops qcom_edp_phy_ops_v3 = {
+	.com_power_on		= qcom_edp_phy_power_on_v4,
+	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_v4,
+	.com_bias_en_clkbuflr	= qcom_edp_com_bias_en_clkbuflr_v4,
+	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v4,
+	.com_configure_pll	= qcom_edp_com_configure_pll_v4,
+	.com_configure_ssc	= qcom_edp_com_configure_ssc_v4,
+	.com_ldo_config		= qcom_edp_ldo_config_v3,
+};
+
 static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
 	.com_power_on		= qcom_edp_phy_power_on_v4,
 	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_v4,
@@ -602,6 +649,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
 	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v4,
 	.com_configure_pll	= qcom_edp_com_configure_pll_v4,
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v4,
+	.com_ldo_config		= qcom_edp_ldo_config_v4,
 };
 
 static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
@@ -618,7 +666,7 @@ static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v3,
-	.ver_ops = &qcom_edp_phy_ops_v4,
+	.ver_ops = &qcom_edp_phy_ops_v3,
 };
 
 static const struct qcom_edp_phy_cfg sc8180x_dp_phy_cfg = {
@@ -626,7 +674,7 @@ static const struct qcom_edp_phy_cfg sc8180x_dp_phy_cfg = {
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg_v2,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v2,
-	.ver_ops = &qcom_edp_phy_ops_v4,
+	.ver_ops = &qcom_edp_phy_ops_v3,
 };
 
 static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
@@ -811,6 +859,24 @@ static int qcom_edp_com_configure_pll_v6(const struct qcom_edp *edp)
 	return 0;
 }
 
+static int qcom_edp_ldo_config_v6(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 ldo_config;
+
+	if (!edp->is_edp)
+		ldo_config = 0x0;
+	else if (dp_opts->link_rate <= 2700)
+		ldo_config = 0x51;
+	else
+		ldo_config = 0x91;
+
+	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
+	writel(dp_opts->lanes > 2 ? ldo_config : 0x00, edp->tx1 + TXn_LDO_CONFIG);
+
+	return 0;
+}
+
 static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
 	.com_power_on		= qcom_edp_phy_power_on_v6,
 	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_v6,
@@ -818,6 +884,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
 	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v4,
 	.com_configure_pll	= qcom_edp_com_configure_pll_v6,
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v6,
+	.com_ldo_config		= qcom_edp_ldo_config_v6,
 };
 
 static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
@@ -998,6 +1065,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v8 = {
 	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v8,
 	.com_configure_pll	= qcom_edp_com_configure_pll_v8,
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v8,
+	.com_ldo_config		= qcom_edp_ldo_config_v6,
 };
 
 static struct qcom_edp_phy_cfg glymur_phy_cfg = {
@@ -1013,7 +1081,6 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	const struct qcom_edp *edp = phy_get_drvdata(phy);
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
 	unsigned long pixel_freq;
-	u8 ldo_config = 0x0;
 	int ret;
 	u32 val;
 	u8 cfg1;
@@ -1022,11 +1089,10 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	if (edp->cfg->edp_swing_pre_emph_cfg && !edp->is_edp)
-		ldo_config = 0x1;
+	ret = edp->cfg->ver_ops->com_ldo_config(edp);
+	if (ret)
+		return ret;
 
-	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
-	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
 	writel(0x00, edp->tx0 + TXn_LANE_MODE_1);
 	writel(0x00, edp->tx1 + TXn_LANE_MODE_1);
 

-- 
2.43.0


