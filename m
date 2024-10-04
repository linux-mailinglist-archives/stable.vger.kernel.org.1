Return-Path: <stable+bounces-80775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F309909E2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341B0B25174
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706EB1D9A53;
	Fri,  4 Oct 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z1ce+2XP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F21741DC;
	Fri,  4 Oct 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061425; cv=none; b=ZlbTGoXI4znlmnW5XdkfP8xDdjqTlLfvBu5C4vFLJwr4wbGapZQqf4nitp9b/keSGtBkQqxGQLeGToB31zEP/z5vsPvTDNyyw9byE1es6UCENnpyhei8Ml0YYmG7LY0fuU5bEDeK8ELO+FLqmqZDY17aQ11reSwobwMjfBYrUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061425; c=relaxed/simple;
	bh=igEPTiDKybVwYSpyE7F9ShWaH+mo81BdwY1qzIPisaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+pXu7jxwsh63yC2n6UEZR7pn9Y6+VS/EATYMw6KHNCMYjHFZ6VYztUD8to4YKM6C5CA7Rb9eAoAmpqU3q3zaSP4VEGX5HcAsQVFcSFplumNf8Y0R/0asFEbD1gH68a3qhTgZpf1XNszQkzdza5xwI7tUU9ITRB/j36/T9JHW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z1ce+2XP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494GfvNH031803;
	Fri, 4 Oct 2024 17:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=L
	Djwz1Ek2M+IBdgYOtoqZUS2gXwsaolP2u/A0oZJi2g=; b=Z1ce+2XPC0pSJxxe4
	QJ5NYKw++eXNNj9M0P3FdlxyKK6PlcoQnmT2ciw1CkFFWZuKeUW5Tx7WNxEEaSiC
	xkMcoTOl6ejzexoqe1hAyfpUnUZO6nLDR74INRXtRlaU//2oIhXJGhyQokvat0M0
	T2ZS/LhHiuPFS9aJpW0N2a6QqAIASXNBgJ83HXwRFctoiawffqOJGOsvX/KOirCP
	7qEoagHr0GL89gBR0j6H8EcegIYR7+T6Oswc4wpB3VPRFQ38LFiwWs6EY62Ng2rc
	IJiG9l7Wh5JkA/u+vwSF5k2DaJbkMJqJlGJCettvDff2p/RLOcDf5tbIJMvrQAL6
	PKnvw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204922ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:03:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494FIcT4005989;
	Fri, 4 Oct 2024 17:03:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056tdy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:03:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494GxlJm035743;
	Fri, 4 Oct 2024 17:03:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422056tdvr-2;
	Fri, 04 Oct 2024 17:03:33 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, kuba@kernel.org, gregkh@linuxfoundation.org,
        roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        sherry.yang@oracle.com
Subject: [PATCH 5.15.y 1/2] net: add pskb_may_pull_reason() helper
Date: Fri,  4 Oct 2024 10:03:27 -0700
Message-ID: <20241004170328.10819-2-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241004170328.10819-1-sherry.yang@oracle.com>
References: <20241004170328.10819-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040118
X-Proofpoint-GUID: 1GXuJrhcDboHuEFJSomJhmytFf08G4He
X-Proofpoint-ORIG-GUID: 1GXuJrhcDboHuEFJSomJhmytFf08G4He

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1fb2d41501f38192d8a19da585cd441cf8845697 ]

pskb_may_pull() can fail for two different reasons.

Provide pskb_may_pull_reason() helper to distinguish
between these reasons.

It returns:

SKB_NOT_DROPPED_YET           : Success
SKB_DROP_REASON_PKT_TOO_SMALL : packet too small
SKB_DROP_REASON_NOMEM         : skb->head could not be resized

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8bd67ebb50c0 ("net: bridge: xmit: make sure we have at least eth header len bytes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Sherry: bp to 5.15.y. Minor conflicts due to missing commit
d427c8999b07 ("net-next: skbuff: refactor pskb_pull") which is not
necessary in 5.15.y. Ignore context change.
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 include/linux/skbuff.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b230c422dc3b..f92e8fe4f5eb 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2465,13 +2465,24 @@ static inline void *pskb_pull(struct sk_buff *skb, unsigned int len)
 	return unlikely(len > skb->len) ? NULL : __pskb_pull(skb, len);
 }
 
-static inline bool pskb_may_pull(struct sk_buff *skb, unsigned int len)
+static inline enum skb_drop_reason
+pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
 {
 	if (likely(len <= skb_headlen(skb)))
-		return true;
+		return SKB_NOT_DROPPED_YET;
+
 	if (unlikely(len > skb->len))
-		return false;
-	return __pskb_pull_tail(skb, len - skb_headlen(skb)) != NULL;
+		return SKB_DROP_REASON_PKT_TOO_SMALL;
+
+	if (unlikely(!__pskb_pull_tail(skb, len - skb_headlen(skb))))
+		return SKB_DROP_REASON_NOMEM;
+
+	return SKB_NOT_DROPPED_YET;
+}
+
+static inline bool pskb_may_pull(struct sk_buff *skb, unsigned int len)
+{
+	return pskb_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
 }
 
 void skb_condense(struct sk_buff *skb);
-- 
2.46.0


