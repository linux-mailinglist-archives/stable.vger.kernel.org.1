Return-Path: <stable+bounces-230311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMGNBB29w2kRtwQAu9opvQ
	(envelope-from <stable+bounces-230311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:46:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DEC3233EA
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98C663034DC2
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D073F3BED7F;
	Wed, 25 Mar 2026 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SaUEpGDP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J7QHEEMN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B62395DA5
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435489; cv=none; b=o5V2y/8DxVy2ZVjFsaonJSlzZgEJ6Z7j1B3jxq0zLTkkxECqZbDZq0ZjGmQdLHZwABBzqsK6HClnYg4VwtKeH53hsTWLLt/e7rnJydTSbk67XsQvMW43R59QqHuFrGxHeEFdfncc83NqDZHbxOEpa6g9nI7u2k/q0+HHhb11GLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435489; c=relaxed/simple;
	bh=VUckc1SdCNWURMt3QHIG/kYLSzYqTmALMFLTy9j3q9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1tGd1hGpGhrjYeGjSlwG1jue9R69If3uMNpLPGZtOvU0habNm91F2Fdilsr4RQC3/0uWN1zE+p7r4HwbGNTl6RkbVP22/U7mrTNvNcc3EcsX2WkOlEo9rsCveXy3w/hR5sUDhPoGr+0VDiOaI58HmhSEOexDeB+hA15XyHKrBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SaUEpGDP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J7QHEEMN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PAQZpO2884887
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 10:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ufmukem2JRe
	bh6l819czpXtmpvPfo+OtOsxaUsB7OdE=; b=SaUEpGDPQpb8ngfVjbGra2zTUk5
	FfKp4nIbTqWqPuh0ffH84bPugQq6YfCIMZSDK7cXxXYDZjH+4wFrUC9JlaCC5MAA
	04fQwRe3VaTJP0h4jhkG7cja0P5Of7SAuxlbxz0FDlCCgD0wFXzwrFPNqSuF99hf
	25U+j77Uszvhp0u9l9aGIZBG8Wwu+F4yA24P4h63N6NL7hcsLlLATQ0Lpuu3YZwd
	+SD+fHTtes2YVuiHPK3z/NxV3YtxEkbKQFO5WblaycEu8dzR7Cgmxn02cw8VrhGc
	Pt3O3ijGQVbNE3MUndZx/oAFqTrXmgCXIz2QetvgSOmtvdITX0CO1Njx51w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dy4g2bd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 10:44:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35641c14663so8386730a91.2
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 03:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774435486; x=1775040286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufmukem2JRebh6l819czpXtmpvPfo+OtOsxaUsB7OdE=;
        b=J7QHEEMNmD8fI+e1elAZVwOn75WdQ7WmhTb5sUgfKyplH3dbGDdLe/yutxhBxyQXZP
         Rp8j3PVUNqNVSkHsZwYJsx3rH+5a9eTLsQ/V804LUlKMD2mz3KA5Iz4Mr9Z6S3bLrmMQ
         3haH5xtey9w3cXR+6LR0vgjIhkyLVjE8DmalUJ96ygxEhze1YcyigknvrhXVWkPQWXFA
         bxyBcJqc4ow4yhl+6MqwqQuorqCZIzSv21G2xo6bhQjJUbLY5jlAWMRCTkAMRzGiKj5Z
         8V35ghqfJWLwwXnTnYnV0qX+0Tc2sdV06it04AgWmggmnMBB2H1Nc5WznOmO2NaTl7ji
         QHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774435486; x=1775040286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ufmukem2JRebh6l819czpXtmpvPfo+OtOsxaUsB7OdE=;
        b=n1dP6Buxk0sjpkAJ5CiVyM1FIVNgd8J1DbYhNu1a8XXQg0Lqf7DtiU5dLWbCmUCuAh
         Z7NWhr+JymAJKzh/VMVDns7fYWvqS/rWagCeQOgjbKUChMgMZpFCU7k1fREPap9zDL3r
         C+BmDMatXoI1+G5YDoZZufMhcXsMK9nQaR7jwou59YLAVblm2bfsgLH+NXPGAgJgy6kb
         dRA18cuuU/EjtCWC/f9OmUWnOidKoox21x7TJkY16yb2JZ58Ur5QozoutsQ8JFc5mJP3
         X9qn5wMSdsu+XOp35zecQlruLNB2bCr4TrGi8JnOQvpkGZkUQiJHHCAsNHny1Ytc6kyF
         E0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnW1WL+gEtlRBe50cE54zr9bEH2YziccaW0up9c9u0pFfGy43LLGmbl6hHiKB1R+tGj3dkbII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOImsrE1RLofPIaLUNYpkvZM/+YNcAp98b1hZRCHtc9VujvfU2
	ZphV0QQWPxC/DPiTpEE59rJTk3NTxlIYfu0gCwFCn2fVm5G7mPwBREpUb1Shh4j/X4DtLQSHunz
	wLS6GsEENdA6GQBCElw8LJz15XLrMI01qURwrfAKcJmPRVAIfBgSW2iKQEKs=
X-Gm-Gg: ATEYQzzv5C8BrXjpzePyYXedvsJqJqI9aFnmcUqA9DUOq1t11ZI7BSO/vyoSbbs+dnz
	rsXE4fFOpLSsTwyIXGYEx7afFC6QqbKw3zqg197poKwx1K5u9jq2bIR05GZkidsfG9cpb/bcGfq
	fnEcoIqcUCGwkEuDR8jtM1Ol0sZzMZ4mmj9jsTBbLkZJAyvTLQWI8grmELRphoGHpemL/NYC8IS
	wbAGLEyEQlKuLLPFDf3aaRTYds1PYCzI24p+qRRBZPoMQ+q1yGJEzpBoEdIfaaGZ2BWbjdvDe+d
	415pY0hnzxunO/EQkeNt9GfLnMhdD0mEDRe3grYPQ/NveEhboKMizSWlYy4SWucpcDMY1RCvZ7n
	azMFvvWRHUgzSYuH/1UumeAOh3FNjr0BlE41a
X-Received: by 2002:a05:6a20:3d1c:b0:39b:c686:6306 with SMTP id adf61e73a8af0-39c4ace66aemr2930382637.30.1774435486279;
        Wed, 25 Mar 2026 03:44:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:39b:c686:6306 with SMTP id adf61e73a8af0-39c4ace66aemr2930342637.30.1774435485700;
        Wed, 25 Mar 2026 03:44:45 -0700 (PDT)
Received: from work ([120.60.74.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c6besm17867251b3a.32.2026.03.25.03.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:44:45 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        yimingqian591@gmail.com, chris.lew@oss.qualcomm.com, mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] net: qrtr: ns: Limit the maximum lookups per socket
Date: Wed, 25 Mar 2026 16:14:15 +0530
Message-ID: <20260325104415.104972-3-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325104415.104972-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260325104415.104972-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3NiBTYWx0ZWRfXyAbkZQtILHpS
 L6dK1PlwR5JzFiWTw7pAZWw49GOPYv7TCuk5BYZgk0NyoywTKRasMr+O1TLXyX9loQ7YdUXRctm
 WgFrYgecjhte+ISg2uHEb4GiG72t+WGjjvtw1zzn/BcLrJkq34GPE3arEaltUsmxwGZ3fRek7VD
 q4qPXcr+inelGc3kEP+IVtgI4yMtD9YY9ISgu6JzCs5/AufU87OS0yZlGz9kXabYYti2oyzaH9a
 myKyRTPdquKW8Y7U7ZfdVak5XYb2yrIQxQpJafANHIpn8hCSBkYAo40SguCdPSP+hjN6pZd+2Db
 OgPD9AVs62W+uAQwFV161fwLeeR+54XKtC2ILilYwRS8+AUGzLxQfq5s9+WXg94uIwYL/Z45CVg
 IMZhpRS9p72juMxctRi0qy7N+NEtOTMuF2Noj8L7a1zhNrKgIu8yN6BoIejlKg745SHPsD3gg4w
 0uVtlijcmb/Xz47RrFA==
X-Proofpoint-ORIG-GUID: AeKLB06GEvl9oEAk_fpeE9IpmF0dH5L-
X-Proofpoint-GUID: AeKLB06GEvl9oEAk_fpeE9IpmF0dH5L-
X-Authority-Analysis: v=2.4 cv=eeUwvrEH c=1 sm=1 tr=0 ts=69c3bc9f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=DfnuZq+CPLWApegUcJV09w==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=X_qntSa0dJ9H4pJGHfIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250076
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-230311-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 99DEC3233EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Current code does no bound checking on the number of lookups a client can
perform per socket. Though the code restricts the lookups to local clients,
there is still a possibility of a malicious local client sending a flood of
NEW_LOOKUP messages over the same socket.

Fix this issue by limiting the maximum number of lookups to 64 per socket.
Note that, limit of 64 is chosen based on the current platform
requirements. If requirement changes in the future, this limit can be
increased.

Cc: stable@vger.kernel.org
Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 net/qrtr/ns.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index fb4e8a2d370d..707fde809939 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -70,10 +70,11 @@ struct qrtr_node {
 	u32 server_count;
 };
 
-/* Max server limit is chosen based on the current platform requirements. If the
- * requirement changes in the future, this value can be increased.
+/* Max server, lookup limits are chosen based on the current platform requirements.
+ * If the requirement changes in the future, these values can be increased.
  */
 #define QRTR_NS_MAX_SERVERS 256
+#define QRTR_NS_MAX_LOOKUPS 64
 
 static struct qrtr_node *node_get(unsigned int node_id)
 {
@@ -545,11 +546,24 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 	struct qrtr_node *node;
 	unsigned long node_idx;
 	unsigned long srv_idx;
+	u8 count = 0;
 
 	/* Accept only local observers */
 	if (from->sq_node != qrtr_ns.local_node)
 		return -EINVAL;
 
+	/* Make sure the client performs only maximum allowed lookups */
+	list_for_each_entry(lookup, &qrtr_ns.lookups, li) {
+		if (lookup->sq.sq_node == from->sq_node &&
+		    lookup->sq.sq_port == from->sq_port)
+			count++;
+	}
+
+	if (count >= QRTR_NS_MAX_LOOKUPS) {
+		pr_err_ratelimited("QRTR client node exceeds max lookup limit!\n");
+		return -ENOSPC;
+	}
+
 	lookup = kzalloc_obj(*lookup);
 	if (!lookup)
 		return -ENOMEM;
-- 
2.51.0


