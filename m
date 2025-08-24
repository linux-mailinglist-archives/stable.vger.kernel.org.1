Return-Path: <stable+bounces-172699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D3DB32E30
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 10:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A0B204D55
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5525B259C92;
	Sun, 24 Aug 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="SyLxoB3m"
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79DB11712;
	Sun, 24 Aug 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024637; cv=none; b=KMdiSIRN6U/jDXorpy+lBVki8t3L8pS8tIW0qjTUWLJZgWZXhMSL42C7N8BF3YoG0JLkiMjIXrnpubvRnqczwhIS0Czt6yul8VGoQGPyK2UTDYdt4uBDgRKQQtt4B2gqiZ0pOz3kpilMMj/W9lMOaNS5iJcVGrmpHzucI71AJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024637; c=relaxed/simple;
	bh=lZp2Cl0qc6wb8coserP5WWmHbjV72Qo/rkklVqayqQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TvkBeCkYnULv0cJy9Vr0V4LC0qdY3EJIdwOksUAIAEdgn6G2pjgbzZsYlXtZgtDPs4+g6yMkT+8ZyeuY08wuI7ia5FbWkeX6HavMll2sOY4F/QJMLM2P///MtpzuNJvaa96s/jRnn36A+Wco56GUXd35xi/8ONNx9vvcUVjRu8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=SyLxoB3m; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=jHWpd
	ARc43w4tAS2FUEDvn/HU28I0sReMTwTlphHACk=; b=SyLxoB3m5zHK+aGgQnCP3
	SPUBvsnQDkz7sM9obKcYn5PMkpWwQDsDbIa9WPMR+YwTO/HBqKkhgWLClpnabKBY
	G36EjReSws0azMCCqHrIWydII/N2XwOz7wAQj2fJwDaPi85PafDSBVT5i2yMM9Zn
	N2PcB0BWM+MnNKBCJxPm4E=
Received: from estar-Super-Server.. (unknown [103.233.162.254])
	by web3 (Coremail) with SMTP id ygQGZQBXbCIlz6poet8KGg--.37470S2;
	Sun, 24 Aug 2025 16:37:00 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net/dccp: validate Reset/Close/CloseReq in DCCP_REQUESTING
Date: Sun, 24 Aug 2025 16:36:53 +0800
Message-Id: <20250824083653.1227318-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQBXbCIlz6poet8KGg--.37470S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWktFyUuryxWry5Jry7KFg_yoWrJw4Upa
	4xKFZ8Kr4DJFyxtFnayw4kXr1Ykr48AryfGFnFqrW8ZF1DJryfZ390krWjvry3CFZ3C342
	93y7WFWrCw47Xa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUjZXOUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQQEAWiqNtp+LgAAs+

DCCP sockets in DCCP_REQUESTING state do not check the sequence number
or acknowledgment number for incoming Reset, CloseReq, and Close packets.

As a result, an attacker can send a spoofed Reset packet while the client
is in the requesting state. The client will accept the packet without
verification and immediately close the connection, causing a denial of
service (DoS) attack.

This patch moves the processing of Reset, Close, and CloseReq packets
into dccp_rcv_request_sent_state_process() and validates the ack number
before accepting them.

This fix should apply to Linux 5.x and 6.x, including stable versions.
Note that DCCP was removed in Linux 6.16, so this patch is only relevant
for older versions. We tested it on Ubuntu 24.04 LTS (Linux 6.8) and
it worked as expected.

Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: stable@vger.kernel.org
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


