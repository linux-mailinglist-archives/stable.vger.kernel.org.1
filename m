Return-Path: <stable+bounces-192131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C329C29C73
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 02:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0498D3AD9B3
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 01:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810AF26E6F5;
	Mon,  3 Nov 2025 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="CbtdSTH9"
X-Original-To: stable@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8956185E4A
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762133028; cv=none; b=A4uoDOisrzuzxz4u1M0PZPN41x+tAwvGCl0k/mUhJgpCosbR8I2kBhbGLiVgEodnc84+CZcS76BGjzBV98cQIJ2gfzfJLGvlSZHH6IqB9m++GeM0m/WtaNXDlFRe9yafBticJ1Abjn4SUfxz//h8AnQekLLCw+0C6WbgLW6P+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762133028; c=relaxed/simple;
	bh=H6pEghhtQJP9C7NtIlzwpeRjrgDm93jQDVQzqlpDyeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AHZLRWIpIG54gp364Mh/nGd9yWBluv/TZyTaHL7DFv/TiWLGVSUQcquROLuQejbnB/k152zzT4+Uw12uQyaIiFfBvIcevvk9pWO2wb7znR8G/CMhYvONk5u3z4tM/b+6uFyOHoQdrgEP64Tpxfe6/d5FPrdphS1vGUQIi2sWUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=CbtdSTH9; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=PWLeG
	Ss6IpvbyFThhcFwhA5zOZWy84Sphv6fkjK8jhI=; b=CbtdSTH9KpN3Th+2FmSaV
	0jS0+HS4XACvb0yTqJkDLswKnl1zHxDkB0zWEfvwHO29pFMYa5yC1NkDZBrjlVLq
	8jKBzwuqgWJd+9PO9W3xatZEzSwV+IEdTRPxvNpmM0vLKLjy6hnjjkOhtc+2LOEu
	rbxiIVI4OvLxUSY3gaUhQA=
Received: from estar-Super-Server.. (unknown [103.233.162.254])
	by web3 (Coremail) with SMTP id ygQGZQBXFdwLBAhpbR7oBQ--.48249S2;
	Mon, 03 Nov 2025 09:23:32 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: stable@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Subject: [PATCH] dccp: validate incoming Reset/Close/CloseReq in DCCP_REQUESTING
Date: Mon,  3 Nov 2025 09:23:07 +0800
Message-Id: <20251103012307.4017900-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQBXFdwLBAhpbR7oBQ--.48249S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWktFyrXw4xGw4rJFWfuFg_yoWrAw1UpF
	yxKFWYkr1DJryxtF9ayw4kXr15Cr48AryfGr9FqrWUZF1DXr93Z398trWjvry3CFZ3C342
	93yIgFZ5Gr47Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUQF4iUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQEPAWkHO3eM9QADsW

DCCP sockets in DCCP_REQUESTING state do not check the sequence number
or acknowledgment number for incoming Reset, CloseReq, and Close packets.

As a result, an attacker can send a spoofed Reset packet while the client
is in the requesting state. The client will accept the packet without any
verification before receiving the reply from server and immediately close
the connection, causing a denial of service (DoS) attack. The vulnerability
makes the attacker able to drop the pending connection for a specific 5-tuple.
Moreover, an off-path attacker with modestly higher outbound bandwidth can
continually inject forged control packets to the victim client and prevent
connection establishment to a given destination port on a server, causing
a port-level DoS.

This patch moves the processing of Reset, Close, and CloseReq packets into
dccp_rcv_request_sent_state_process() and validates the ack number before
accepting them.

This patch should be applied to stable versions *only* before Linux 6.16,
since DCCP implementation is removed in Linux 6.16.

Affected versions include:
- 3.1-3.19
- 4.0-4.20
- 5.0-5.19
- 6.0-6.15

We tested it on Ubuntu 24.04 LTS (Linux 6.8) and it worked as expected.

Fixes: c0c2015056d7b ("dccp: Clean up slow-path input processing")
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/dccp/input.c | 54 ++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/net/dccp/input.c b/net/dccp/input.c
index 2cbb757a8..0b1ffb044 100644
--- a/net/dccp/input.c
+++ b/net/dccp/input.c
@@ -397,21 +397,22 @@ static int dccp_rcv_request_sent_state_process(struct sock *sk,
 	 *	     / * Response processing continues in Step 10; Reset
 	 *		processing continues in Step 9 * /
 	*/
+	struct dccp_sock *dp = dccp_sk(sk);
+
+	if (!between48(DCCP_SKB_CB(skb)->dccpd_ack_seq,
+				dp->dccps_awl, dp->dccps_awh)) {
+		dccp_pr_debug("invalid ackno: S.AWL=%llu, "
+					"P.ackno=%llu, S.AWH=%llu\n",
+					(unsigned long long)dp->dccps_awl,
+			(unsigned long long)DCCP_SKB_CB(skb)->dccpd_ack_seq,
+					(unsigned long long)dp->dccps_awh);
+		goto out_invalid_packet;
+	}
+
 	if (dh->dccph_type == DCCP_PKT_RESPONSE) {
 		const struct inet_connection_sock *icsk = inet_csk(sk);
-		struct dccp_sock *dp = dccp_sk(sk);
-		long tstamp = dccp_timestamp();
-
-		if (!between48(DCCP_SKB_CB(skb)->dccpd_ack_seq,
-			       dp->dccps_awl, dp->dccps_awh)) {
-			dccp_pr_debug("invalid ackno: S.AWL=%llu, "
-				      "P.ackno=%llu, S.AWH=%llu\n",
-				      (unsigned long long)dp->dccps_awl,
-			   (unsigned long long)DCCP_SKB_CB(skb)->dccpd_ack_seq,
-				      (unsigned long long)dp->dccps_awh);
-			goto out_invalid_packet;
-		}
 
+		long tstamp = dccp_timestamp();
 		/*
 		 * If option processing (Step 8) failed, return 1 here so that
 		 * dccp_v4_do_rcv() sends a Reset. The Reset code depends on
@@ -496,6 +497,13 @@ static int dccp_rcv_request_sent_state_process(struct sock *sk,
 		}
 		dccp_send_ack(sk);
 		return -1;
+	} else if (dh->dccph_type == DCCP_PKT_RESET) {
+		dccp_rcv_reset(sk, skb);
+		return 0;
+	} else if (dh->dccph_type == DCCP_PKT_CLOSEREQ) {
+		return dccp_rcv_closereq(sk, skb);
+	} else if (dh->dccph_type == DCCP_PKT_CLOSE) {
+		return dccp_rcv_close(sk, skb);
 	}
 
 out_invalid_packet:
@@ -658,17 +666,19 @@ int dccp_rcv_state_process(struct sock *sk, struct sk_buff *skb,
 	 *		Set TIMEWAIT timer
 	 *		Drop packet and return
 	 */
-	if (dh->dccph_type == DCCP_PKT_RESET) {
-		dccp_rcv_reset(sk, skb);
-		return 0;
-	} else if (dh->dccph_type == DCCP_PKT_CLOSEREQ) {	/* Step 13 */
-		if (dccp_rcv_closereq(sk, skb))
-			return 0;
-		goto discard;
-	} else if (dh->dccph_type == DCCP_PKT_CLOSE) {		/* Step 14 */
-		if (dccp_rcv_close(sk, skb))
+	if (sk->sk_state != DCCP_REQUESTING) {
+		if (dh->dccph_type == DCCP_PKT_RESET) {
+			dccp_rcv_reset(sk, skb);
 			return 0;
-		goto discard;
+		} else if (dh->dccph_type == DCCP_PKT_CLOSEREQ) {	/* Step 13 */
+			if (dccp_rcv_closereq(sk, skb))
+				return 0;
+			goto discard;
+		} else if (dh->dccph_type == DCCP_PKT_CLOSE) {		/* Step 14 */
+			if (dccp_rcv_close(sk, skb))
+				return 0;
+			goto discard;
+		}
 	}
 
 	switch (sk->sk_state) {
-- 
2.34.1


