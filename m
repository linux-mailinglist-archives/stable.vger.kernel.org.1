Return-Path: <stable+bounces-83093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64A995728
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 20:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C0D287693
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA19212D30;
	Tue,  8 Oct 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y7K2NvRZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FB1E0DBC
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413505; cv=none; b=Ky9yQjG9q4QWK5RGClbV1C4PKkDwaPOkZ5bHqhJWNdd8GQhqOwp1FvHsw41ciqzhPCeymSOMPweH3fpkrwTJhQXxXc4UlWr5EOEK1aQ2dY1xqgJcDu7UclHjXDgCLRiSS0rboXcCA1Cb/E64HZq0JH/qLddtDhDa+LZazV4+3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413505; c=relaxed/simple;
	bh=wDG9yUmkwHux0KZVHPa3cmwnlxnSL2irruQuNGnHAUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twmkH8cQuODJUXeLt2UUNPHRkFRWWf5Mhmg1TaDptJLE4mOHEki6Y/U9Bc73v4aQwFTX3GMWLoUGhql+IWG4rVdF2hRCnk1jO0+QwsODQGuM2gU7AaR5B0JKpqcKbE2nOC76Mg8nRCxgJHL8UmgVXQmsPTkKwv3Z8Ktk93vSKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y7K2NvRZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498FCTnR029351;
	Tue, 8 Oct 2024 18:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yus1BHid8/yiWDqs+at2GI5X
	leUivDVhV1n049CyTjM=; b=Y7K2NvRZxQh5DKDbAnkujUeXCLNM83TKJ6+EQJw5
	euHk5eOUexl8luZ8L3m/oCJW/LCR2LV3mRZYFzeYHub1IBfzUyXaXsdOaQsDpgAv
	2MSalTcvJ5tDRI3rqjPuz9zA5NM49k8tKvfcAZVrfys1GpdT43v82YCOCaYNTSgW
	eb+2/5ui42jDqi10a/TeKBffTRVQ34fxDfS+tfR9+6opPL9OTVDRKdSufPKIjeSR
	T+kop+/glZJd2RxhAhBr01kWU3KX6+8+yy+z2WW/7J63oCCyQf+gaXdTek6wVqfe
	SRbCgXjfEIJgvXDthKoxIevjutzeJ0iJ+eeKNvRTaQBWzg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424yj02643-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 18:51:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 498IpbFg006300
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 18:51:37 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Oct 2024 11:51:37 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: <stable@vger.kernel.org>
CC: <quic_tdas@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.4.y] clk: qcom: clk-rpmh: Fix overflow in BCM vote
Date: Tue, 8 Oct 2024 11:50:52 -0700
Message-ID: <20241008185052.22599-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2024100719-exploring-umbrella-b6ca@gregkh>
References: <2024100719-exploring-umbrella-b6ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V7JMWOsUtMP_eu7Af4f9xH6BmpKOp5w_
X-Proofpoint-ORIG-GUID: V7JMWOsUtMP_eu7Af4f9xH6BmpKOp5w_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080121

Valid frequencies may result in BCM votes that exceed the max HW value.
Set vote ceiling to BCM_TCS_CMD_VOTE_MASK to ensure the votes aren't
truncated, which can result in lower frequencies than desired.

Fixes: 04053f4d23a4 ("clk: qcom: clk-rpmh: Add IPA clock support")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
Reviewed-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Link: https://lore.kernel.org/r/20240809-clk-rpmh-bcm-vote-fix-v2-1-240c584b7ef9@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
(cherry picked from commit a4e5af27e6f6a8b0d14bc0d7eb04f4a6c7291586)
Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---
 drivers/clk/qcom/clk-rpmh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index d7586e26acd8..f83ac6e8d660 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -270,6 +270,8 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
 			cmd_state = c->aggr_state;
 	}
 
+	cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
+
 	if (c->last_sent_aggr_state == cmd_state) {
 		mutex_unlock(&rpmh_clk_lock);
 		return 0;
-- 
2.17.1


