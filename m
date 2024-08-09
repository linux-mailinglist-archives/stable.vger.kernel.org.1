Return-Path: <stable+bounces-66215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C9F94CE80
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743E9B2130F
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12471917CE;
	Fri,  9 Aug 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FnuC9kfA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8641C6E
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198827; cv=none; b=hc4Dw5D7NeVlWya97Vp9XRm+jUH0tMrofFN0I0BR3TNX/Y1NbMMbX0Isk246e7DWRnDCCMzbVC52pc8MxHN+cDXjT4IBgYOty33qawZwNSxgDjjC0DrOHzkriLFVHixdbyRAz5340Et/QU6KJFKPqDYXKVDCJpZUWdL3pRdCRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198827; c=relaxed/simple;
	bh=QYqESGO1l1f3kBBkTQA4pMSFvbmV2YnMzzKTSHvCPsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ng5aEA3YdsdhWhj0Q49oAVEnJhtHmJfIy4S/9XjghvZ4Gt/sr/wKbyenUJanNBY1Nd0Q6A9pOloSpqlcUEb9fNr3vf//MvZ/1KCMlV9DGi9gYBWe54RquiiirYzqV48SDQj2V3SNzDCiCfhNAmN/91Oe28kYVzoMNclBEKU5jWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FnuC9kfA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479A5X0q032654
	for <stable@vger.kernel.org>; Fri, 9 Aug 2024 10:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cYYyn9YUuPabcUUooJ4uzBJb
	Z9xDp+9Y5WIRBoSdGyY=; b=FnuC9kfAZf+UJK7mfY4zWOFiibxboXe9ra2/kKUK
	b6FnDOk4x0+OismcLFPV05MMA8dd99s20CWmWpTApOa5uSzvjmUivuvndxhrdU3p
	jZzIbtY05NgkdWDUbO+V/h99YyM48ru6whXCT//dBg5+n9QQqQusIXMKB3r38l/G
	szlHvGQrYBddrAK88hR06MxpCzpucXoupexrBk62pwywWbGr5vTG2UZSgGWHAiGQ
	W23oRB8jX2Vg37eOMZRUgRPDEzz0XIp8CmqKAG4xzNF3LBGIhBp/paSzCwtrfkv2
	HPB3rAA8si+A0V8G/2HdDv8n9uv3d12L34NBzcx9zKJhPw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vfav5086-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 09 Aug 2024 10:20:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479AKCAJ006539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 9 Aug 2024 10:20:12 GMT
Received: from hu-ssakore-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 9 Aug 2024 03:20:10 -0700
From: Santosh Sakore <quic_ssakore@quicinc.com>
To: <fastrpc.upstream@qti.qualcomm.com>
CC: <quic_ekangupt@quicinc.com>, <--cc=quic_bkumar@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v1 05/41] mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
Date: Fri, 9 Aug 2024 15:48:13 +0530
Message-ID: <20240809101849.1814-6-quic_ssakore@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2OBeChU2JkBpC5z-Q8o2akC4YsSFGIJb
X-Proofpoint-GUID: 2OBeChU2JkBpC5z-Q8o2akC4YsSFGIJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_07,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090075

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Up to the 'Fixes' commit, having an endpoint with both the 'signal' and
'subflow' flags, resulted in the creation of a subflow and an address
announcement using the address linked to this endpoint. After this
commit, only the address announcement was done, ignoring the 'subflow'
flag.

That's because the same bitmap is used for the two flags. It is OK to
keep this single bitmap, the already selected local endpoint simply have
to be re-used, but not via select_local_address() not to look at the
just modified bitmap.

Note that it is unusual to set the two flags together: creating a new
subflow using a new local address will implicitly advertise it to the
other peer. So in theory, no need to advertise it explicitly as well.
Maybe there are use-cases -- the subflow might not reach the other peer
that way, we can ask the other peer to try initiating the new subflow
without delay -- or very likely the user is confused, and put both flags
"just to be sure at least the right one is set". Still, if it is
allowed, the kernel should do what has been asked: using this endpoint
to announce the address and to create a new subflow from it.

An alternative is to forbid the use of the two flags together, but
that's probably too late, there are maybe use-cases, and it was working
before. This patch will avoid people complaining subflows are not
created using the endpoint they added with the 'subflow' and 'signal'
flag.

Note that with the current patch, the subflow might not be created in
some corner cases, e.g. if the 'subflows' limit was reached when sending
the ADD_ADDR, but changed later on. It is probably not worth splitting
id_avail_bitmap per target ('signal', 'subflow'), which will add another
large field to the msk "just" to track (again) endpoints. Anyway,
currently when the limits are changed, the kernel doesn't check if new
subflows can be created or removed, because we would need to keep track
of the received ADD_ADDR, and more. It sounds OK to assume that the
limits should be properly configured before establishing new
connections.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-5-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/mptcp/pm_netlink.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2be7af377cda..4cae2aa7be5c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -512,8 +512,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -579,6 +579,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &local->addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
+
+		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = local;
 	}
 
 subflow:
@@ -589,9 +592,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		local = select_local_address(pernet, msk);
-		if (!local)
-			break;
+		if (signal_and_subflow) {
+			local = signal_and_subflow;
+			signal_and_subflow = NULL;
+		} else {
+			local = select_local_address(pernet, msk);
+			if (!local)
+				break;
+		}
 
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
-- 
2.17.1


