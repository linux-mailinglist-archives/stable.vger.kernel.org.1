Return-Path: <stable+bounces-204510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BFECEF511
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 21:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BA7A3012CCD
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373172D47E2;
	Fri,  2 Jan 2026 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R9a9LxPv"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22F2D0601
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386271; cv=none; b=OJoPk/X7QYJxpiQQAUfurD4JBTcn3S9XOAXQSjtS5eWdnuzN9CVGPaZorHpbEE50/tflQA9sVgeSN127TPbIWtT8YVSKxxxP9X4zp46SqIyHoO6LOsotgqm7gvzuRQc1UCBko7+0Gv5apF9vqGrUuAjsgK2U0jlboNJhw8VY3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386271; c=relaxed/simple;
	bh=X74VSjzFx/Jn+/0tOS2TqRD7kKgB6qgW3ZYm+8tSvv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXpRRuKKOLQGFHGrEL1k3+DOtpDJqqXeeQ/t4FTRWSob0Dxc/sn6RmYyHjNVojJC1d0O7R/7FiJAIlJgmXytLYrtZvwKykZpmrxxq6rcU63H167tcP736QxSMdG8Gz+6Q5mVzsEavxBfYySatbN6ETshNlhtBX8sB7OwHxbU9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R9a9LxPv; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602Bvf252987747;
	Fri, 2 Jan 2026 20:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=be9ON
	+mNf26bRX7oVCHWNtGKUQhmTiOswiPOukCq+94=; b=R9a9LxPvJhRN7RkxedYpt
	OZ7MG4sTOoXLNqNnYdoktCz6v+aZnBsCGay7eaJ+1KMR1KWjdnx7ja+XLv7tIvGh
	dqEjWJ5yduWAJlfGfzOcHWs4B0wCJOfaoU8cs2WINo7MurYJujG/l6w6dlzV/J+g
	iDpypdOsDTry9AoQeh7tnIf4FTgkxD9BiclsDkxZSEY3fAHk3iQgq+35bT1ThQEG
	KtkgDqrTsbv5kdn6BNiLHKjGrPezxU2qAPi1f5lshwium+Kzude0vwgkC+/3J+kS
	Y4lHyDZjLEvHci80bcPw0eLrGta9965qCyqS9/bab2JZ1iAlVXPhc6KNop0Hi8dG
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba5va5ea7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 20:37:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602HNDf7023129;
	Fri, 2 Jan 2026 20:37:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5wa66kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 20:37:43 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 602KbZ4b025726;
	Fri, 2 Jan 2026 20:37:43 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5wa66fb-5;
	Fri, 02 Jan 2026 20:37:42 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Justin Iurman <justin.iurman@uliege.be>, Paolo Abeni <pabeni@redhat.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 4/7] net: ipv6: ioam6: use consistent dst names
Date: Fri,  2 Jan 2026 12:37:24 -0800
Message-ID: <20260102203727.1455662-5-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
References: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601020184
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4NSBTYWx0ZWRfX5kwSob67qVFX
 Es7zbP1z29+t3hscEnNhj97AAFLztp4zJg0EXnBrlnCiypaJ2KZy6QddiYvELdcCKDsOgG4eZyV
 MoD9UeB4ltqAz6EPGWr4CHR2wG53BKkRJbyVaVM9+7jbf6V+Ip0+ZRofAM2CFcwQ5Ez/g+LA0kD
 yjWiCIBvjn4hnZiEft641Gd7zfyRCOQCToAXG75D/zIOXAr4bBXG963wlE3IKn2tUGzGcU6LMHC
 +hxzkDna4va7KtN8094ikGpU5ulZhueZQbjik7Hq988FZtebkTNqqSb4HrJOIMDPVloqLaRkgtL
 s0xk+0cZBCUCF/hQpX1ep40IZeU2PxM9+d8+9/SRGJalqiILdMcF40iib5n/k2iwgrXR7zSKm4R
 ZKIGGIbTPoeEua20d/TfWLDfzUr5yEhIT6JFsKlUD6KlzGmduO8jiuvhnmRDIm/IeSydKtZFk+E
 zlwzl7dGDFemx4VNB/w==
X-Authority-Analysis: v=2.4 cv=NMvYOk6g c=1 sm=1 tr=0 ts=69582c98 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=4keTfLkQCm82A-Nz85sA:9 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: dzHd3Z4ZTRe_iMDsm93ztRRBeJDPqALS
X-Proofpoint-ORIG-GUID: dzHd3Z4ZTRe_iMDsm93ztRRBeJDPqALS

From: Justin Iurman <justin.iurman@uliege.be>

[ Upstream commit d55acb9732d981c7a8e07dd63089a77d2938e382 ]

Be consistent and use the same terminology as other lwt users: orig_dst
is the dst_entry before the transformation, while dst is either the
dst_entry in the cache or the dst_entry after the transformation

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Link: https://patch.msgid.link/20250415112554.23823-2-justin.iurman@uliege.be
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit d55acb9732d981c7a8e07dd63089a77d2938e382)
[Harshit: Backport to 6.12.y[
Stable-dep-of: 99a2ace61b21 ("net: use dst_dev_rcu() in sk_setup_caps()")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/ipv6/ioam6_iptunnel.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 647dd8417c6c..163b9e47eb9f 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -338,7 +338,8 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 
 static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb), *cache_dst = NULL;
+	struct dst_entry *orig_dst = skb_dst(skb);
+	struct dst_entry *dst = NULL;
 	struct ioam6_lwt *ilwt;
 	int err = -EINVAL;
 	u32 pkt_cnt;
@@ -346,7 +347,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IPV6))
 		goto drop;
 
-	ilwt = ioam6_lwt_state(dst->lwtstate);
+	ilwt = ioam6_lwt_state(orig_dst->lwtstate);
 
 	/* Check for insertion frequency (i.e., "k over n" insertions) */
 	pkt_cnt = atomic_fetch_inc(&ilwt->pkt_cnt);
@@ -354,7 +355,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto out;
 
 	local_bh_disable();
-	cache_dst = dst_cache_get(&ilwt->cache);
+	dst = dst_cache_get(&ilwt->cache);
 	local_bh_enable();
 
 	switch (ilwt->mode) {
@@ -364,7 +365,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP)
 			goto out;
 
-		err = ioam6_do_inline(net, skb, &ilwt->tuninfo, cache_dst);
+		err = ioam6_do_inline(net, skb, &ilwt->tuninfo, dst);
 		if (unlikely(err))
 			goto drop;
 
@@ -374,7 +375,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		/* Encapsulation (ip6ip6) */
 		err = ioam6_do_encap(net, skb, &ilwt->tuninfo,
 				     ilwt->has_tunsrc, &ilwt->tunsrc,
-				     &ilwt->tundst, cache_dst);
+				     &ilwt->tundst, dst);
 		if (unlikely(err))
 			goto drop;
 
@@ -392,7 +393,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (unlikely(!cache_dst)) {
+	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
 
@@ -403,20 +404,20 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_mark = skb->mark;
 		fl6.flowi6_proto = hdr->nexthdr;
 
-		cache_dst = ip6_route_output(net, NULL, &fl6);
-		if (cache_dst->error) {
-			err = cache_dst->error;
+		dst = ip6_route_output(net, NULL, &fl6);
+		if (dst->error) {
+			err = dst->error;
 			goto drop;
 		}
 
 		/* cache only if we don't create a dst reference loop */
-		if (dst->lwtstate != cache_dst->lwtstate) {
+		if (orig_dst->lwtstate != dst->lwtstate) {
 			local_bh_disable();
-			dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
+			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(cache_dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 		if (unlikely(err))
 			goto drop;
 	}
@@ -424,16 +425,16 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	/* avoid lwtunnel_output() reentry loop when destination is the same
 	 * after transformation (e.g., with the inline mode)
 	 */
-	if (dst->lwtstate != cache_dst->lwtstate) {
+	if (orig_dst->lwtstate != dst->lwtstate) {
 		skb_dst_drop(skb);
-		skb_dst_set(skb, cache_dst);
+		skb_dst_set(skb, dst);
 		return dst_output(net, sk, skb);
 	}
 out:
-	dst_release(cache_dst);
-	return dst->lwtstate->orig_output(net, sk, skb);
+	dst_release(dst);
+	return orig_dst->lwtstate->orig_output(net, sk, skb);
 drop:
-	dst_release(cache_dst);
+	dst_release(dst);
 	kfree_skb(skb);
 	return err;
 }
-- 
2.50.1


