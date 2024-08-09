Return-Path: <stable+bounces-66214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B202A94CE7E
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD6B1F22387
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3051917F8;
	Fri,  9 Aug 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aq+PVtu1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19818C926
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198810; cv=none; b=OpuN6KOUXLE7ev95hh9sfwhXEMF5vcFCf0wQoUxYrJkyi/E7qChit8mNTB6y3pVyiGXgrYgjKD2QPDynRQUFSUYhAnnT2BvBE9eOsikcHr710NuELtqkg+c0XqzWHU7SsGLnOmuTN1t1/979DISoDuP4GbmYNb5PsROSS8vOU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198810; c=relaxed/simple;
	bh=bVgdE0xbmtsNbhApHvyrh/3ImcXByRAKhepUvGUHHmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FO3LOJOirpn6ySycY0jyqdxTumWtuGyxriEUWnzoLlUvXvOsZV7EqlXJ1kelXcfHWydb45Ml8LLhexFmvVAKu43vCPbZuXy/DxlvYLFKOeuIOCw0WbXY7B1dW0sAAFDEQVGRRkcsBmVv7qJA8nJfpuHyfHiB7iMdG0ci0UGpAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aq+PVtu1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4796ZZSX011387
	for <stable@vger.kernel.org>; Fri, 9 Aug 2024 10:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=krOn7BHuf6LLRzyjaZpDz/zL
	MdlE2M+au9P/DAJ3zWA=; b=aq+PVtu1DdNn9gpepv3ANa5jKjS0y6RHml5dO38U
	q2RdqgSz+Dt3eaAfE6DaHUp1bv05DFuBkuLzFsOaGnYVFbY6kZ7mr/le8Q1ysXOk
	G6Xua1GFOATbHkkulcJJRJSaMX+oFEb0oQHwF1bcFDS7HTzxIx53ZFmP/p+vgpFK
	P3Ez7iP+03HsGQYbtqAEAbvpBvRsSvbL6K+xxlTMMq7sP4OcdX88Ao+QFkmyJzIG
	zD2zuQRXzOidG0OsWiCDh9zu7mYiRjqN0XDOjqL7WkgvKiCjiLW5wvMSpaENHFtS
	Hr06GXjIALqkpxd+vRh5pyvM3up1wQ7HJ6H0JO60MnsfmA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vpuvm39t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 09 Aug 2024 10:20:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479AK7lA016149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 9 Aug 2024 10:20:07 GMT
Received: from hu-ssakore-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 9 Aug 2024 03:20:04 -0700
From: Santosh Sakore <quic_ssakore@quicinc.com>
To: <fastrpc.upstream@qti.qualcomm.com>
CC: <quic_ekangupt@quicinc.com>, <--cc=quic_bkumar@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v1 02/41] mptcp: pm: deny endp with signal + subflow + port
Date: Fri, 9 Aug 2024 15:48:10 +0530
Message-ID: <20240809101849.1814-3-quic_ssakore@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4m9j4tXHFw-_eAwRFEpsLS9OijS35LRN
X-Proofpoint-GUID: 4m9j4tXHFw-_eAwRFEpsLS9OijS35LRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_07,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090074

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

As mentioned in the 'Fixes' commit, the port flag is only supported by
the 'signal' flag, and not by the 'subflow' one. Then if both the
'signal' and 'subflow' flags are set, the problem is the same: the
feature cannot work with the 'subflow' flag.

Technically, if both the 'signal' and 'subflow' flags are set, it will
be possible to create the listening socket, but not to establish a
subflow using this source port. So better to explicitly deny it, not to
create some confusions because the expected behaviour is not possible.

Fixes: 09f12c3ab7a5 ("mptcp: allow to use port and non-signal in set_flags")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-2-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 37954a0b087d..c921d07e5940 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1328,8 +1328,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	if (addr.addr.port && !(addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "flags must have signal when using port");
+	if (addr.addr.port && !address_use_port(&addr)) {
+		GENL_SET_ERR_MSG(info, "flags must have signal and not subflow when using port");
 		return -EINVAL;
 	}
 
-- 
2.17.1


