Return-Path: <stable+bounces-66213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E3C94CE7F
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8880BB21312
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46621917CE;
	Fri,  9 Aug 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KJ9rM/lr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA518C926
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198807; cv=none; b=OsZHKOWRGZkOpR3dw3J1ggoxRCKoxCjASC7xuVMqv6H1MUHoRh0WWOPc2COa/Nx7jKp+0Puqg3k9UwZWaKpk5eDxrqENCMnmROB4QhWHYlWQiEgz1eDcHmns631Id54fSYpQxRBYpED02FGb5sTa0t3Dy5zpqUbLrF6gghbA/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198807; c=relaxed/simple;
	bh=AGbjLZ4Q2qmFynnVtHCOEhMNd+KmF45eoZYhq3lKfDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0RCUFI/N9G3mJHVgsNE0myld6xRXLjT4l+Fu9WErdPEPOHcI2/YHcHMNaMcZzR5+624p2z+wfSDafkPnjIu/YiAyJxpvdYJDSE+qh/Ol/+jpO5a2+QkBkGmDIW5Qrj+X6sQV7CE9m+bVHKlJFz9H0yn6UrpsuLblnOp6P0zITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KJ9rM/lr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478MviNi001372
	for <stable@vger.kernel.org>; Fri, 9 Aug 2024 10:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YO5znEvqvSLMzvIzoh1+SETU
	io9Pw/kTn63ifAKWSE4=; b=KJ9rM/lrbf6L2p7ug76g73yzFO9esEe+rWMpVOLH
	qCJWJOsgEY0PHpmfnzzki79XErZOo3PY9gzrbLz+haS4Zu5xSJlBd067fE6Ctqv9
	bIIDTyMVN5tDeir5XCWWOKOjic2bgST9uWEXtPUiWcayctspunaIDmaD+x4+UQ8k
	2HxkooP4/H2yqPBXDWkvlpP13UiAf8gi1FMqmVfDGPkNNPaWtvGfm3CcHXNTec11
	m3gWiQ1uLck/PVo6TEuCyIuE7en4e0BscvGcB0fY8ee9TsBWdaSD64UW8fmpVBIy
	qrYWlitJqdfJCxu3aFRfbiW9y/EY9UGUXFtKgHGvgnH0fg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vfav507x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 09 Aug 2024 10:20:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479AK4SD011266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 9 Aug 2024 10:20:04 GMT
Received: from hu-ssakore-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 9 Aug 2024 03:20:02 -0700
From: Santosh Sakore <quic_ssakore@quicinc.com>
To: <fastrpc.upstream@qti.qualcomm.com>
CC: <quic_ekangupt@quicinc.com>, <--cc=quic_bkumar@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v1 01/41] mptcp: fully established after ADD_ADDR echo on MPJ
Date: Fri, 9 Aug 2024 15:48:09 +0530
Message-ID: <20240809101849.1814-2-quic_ssakore@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240809101849.1814-1-quic_ssakore@quicinc.com>
References: <20240809101849.1814-1-quic_ssakore@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cPKboRXlVVbSRuXOUAkLeEZ8EhW_6EeO
X-Proofpoint-GUID: cPKboRXlVVbSRuXOUAkLeEZ8EhW_6EeO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_07,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=478 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090074

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Before this patch, receiving an ADD_ADDR echo on the just connected
MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
resulting in an MP_RESET. That's because only ACKs with a DSS or
ADD_ADDRs without the echo bit were allowed.

Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
we are not supposed to send an ADD_ADDR before because it requires to be
in full established mode first. For the MP_JOIN 3WHS, that's different:
the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
can be received on the recently created one. The other peer will already
be in fully established, so it is allowed to send that.

We can then relax the conditions here to accept the ADD_ADDR echo for
MPJ subflows.

Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-1-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a68382a4fe9..ac2f1a54cc43 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -958,7 +958,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	if (subflow->remote_key_valid &&
 	    (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo))) {
+	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
+	      (!mp_opt->echo || subflow->mp_join)))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */
-- 
2.17.1


