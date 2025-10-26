Return-Path: <stable+bounces-189766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4908C0A5A0
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 10:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAAB3A9B5D
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DFC1917CD;
	Sun, 26 Oct 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="rT+dnhsp"
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D27BA3D;
	Sun, 26 Oct 2025 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761471935; cv=none; b=FFU44P0cZscC0ik9/aBEm04XDhGl8xLaAB/o25hma776xULcor1/67BC2ab+RkYuaawdn8GmOw5SoHM/yNwxRFtoToW1L4B6uxTFyGirKbAESRyQ6pvwimuhVP7MMrAJzRABT+cGucBWpQ1utx0upLo4/izpipcvwjobN+NJxyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761471935; c=relaxed/simple;
	bh=xBnkMbU5LPW/ByA6yBUTuR5R4BJYX1dWFXFSbs1kEY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KAw2Glc/qS5lPUZb8lWAuGo+BB8uZNG8bHn4nPBqCtLW+FYzWemKqzvLbCllea3g7M6gjkib5ZJTAFFxaSyXqaRNA5gtbXQ0GiTh+fa9aFWPd/PwVaAEB6sjvFRNO0orsskRiA7RnVAMTL5gS40fYjFtcF1+utZB2q0xgsGzsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=rT+dnhsp; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=9YIt7ruUm8P8zHlzSMb4xWNgs3nRvcOTja
	H9d6uRHzg=; b=rT+dnhsp5wx2i7ZgOxfME6H54Ud+IuKIQHTXkZKBDHRJThQ7Pc
	jhpmM29FcgUMj4zxdhm1PrEoKvsv5ADKdSfmSzPVAuaYBfptWtnizlq+a3d+dmN8
	1eYsYiGNDrq+QlhTSdAvCigwvisDzIjBrfkcqpptGwc3PRl3mxIQq6fAM=
Received: from estar-Super-Server.. (unknown [103.233.162.254])
	by web3 (Coremail) with SMTP id ygQGZQBHAtmI7f1oDaI5BQ--.55062S2;
	Sun, 26 Oct 2025 17:44:57 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: zhaoyz24@mails.tsinghua.edu.cn
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND v3] net/dccp: validate Reset/Close/CloseReq in DCCP_REQUESTING
Date: Sun, 26 Oct 2025 17:44:23 +0800
Message-Id: <20251026094423.941754-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929062609.3771416-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20250929062609.3771416-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQBHAtmI7f1oDaI5BQ--.55062S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF17tryfJryrAF1DKw1rJFb_yoWrWF4fpF
	y7KrW5Kr4DJryxtFnayw4kXr15Cr48AryfGFnFqrW8Z3WDZryfu39IkFWjvry5CFZak342
	g3y2qFZ5Gr47Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JU4mhwUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQEFAWj67Ia3TAABsG

This is a resend with a clarified commit message based on earlier feedback.
The code change is the same; only the description is improved to better
explain the issue, impact and rationale. I appreciate your time.

This patch should be applied to stable versions *only* before Linux 6.16,
since DCCP implementation is removed in Linux 6.16.

Affected versions include:
- 3.1-3.19
- 4.0-4.20
- 5.0-5.19
- 6.0-6.15

DCCP sockets in DCCP_REQUESTING state do not check the sequence number
or acknowledgment number for incoming Reset, CloseReq, and Close packets.

As a result, an attacker can send a spoofed Reset packet while the client
is in the requesting state. The client will accept the packet without
verification and immediately close the connection, causing a denial of
service (DoS) attack.

This patch moves the processing of Reset, Close, and CloseReq packets
into dccp_rcv_request_sent_state_process() and validates the ack number
before accepting them.

We tested it on Ubuntu 24.04 LTS (Linux 6.8) and it worked as expected.

Fixes: c0c2015056d7b ("dccp: Clean up slow-path input processing")
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


