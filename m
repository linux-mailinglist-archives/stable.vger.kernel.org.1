Return-Path: <stable+bounces-192018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 275CAC289F7
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 06:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60D2234754F
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 05:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85816252904;
	Sun,  2 Nov 2025 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="racG1avF"
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D933AC15;
	Sun,  2 Nov 2025 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762062374; cv=none; b=FFmGiyTWU6Dpc2boT0WzThJ3khWGFt1N8iqin1bky6KriCuqy3VFUaEBs9+PoFZr7cRzCRUGebz95FMzbJTUHxv82rhzldVmBiJPRG9aqnczLcryui+HV7tWjnsmzi+Xw2GKnHnwmmN1u/Bdx5jNY6rDqDM04LWlQLydIpQZpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762062374; c=relaxed/simple;
	bh=daat7R8xq6WK19JnkdNaKb1Ss5KWbqJ9ZIemeuq71BE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sxoSadLxS30jTCvsQxkgoMzcGY9RAKpvH0xCkLVbdo1CRmcBd1y0gA0iqyHKcv7iPuD8zBoOH5X+yuEXABTzgN3bTj4GLcooOMFkrejdzEMAwVez9ifYPlDfJduDbBCh0xylafaSEZnUrVdupjDVFMvED0Zmu6f6Z9ZBtc1hfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=racG1avF; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=H6lPk
	TPqXuPoT+a08uI3jvE4cRGosn0mKlnPqrfFbgk=; b=racG1avFBTKvtLtXgscv+
	EWUxh7Tvy3gazh4Tj36IMMWK/JlT+R6gpTv42JIlRj2NR6UDoaoxyiuJ7Z874Vp8
	WMgoopJ89ivfF6uZQiOtYvTv90xGI1YfM4eA5tVGBonM/Prl7C4v0gx1dEmj3Ldr
	YOsc0cOj6MqzMFd8Tb98bU=
Received: from estar-Super-Server.. (unknown [103.233.162.254])
	by web2 (Coremail) with SMTP id yQQGZQDXvwoD8AZpXsWvBA--.9738S2;
	Sun, 02 Nov 2025 13:45:53 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 RESEND] net/dccp: validate Reset/Close/CloseReq in DCCP_REQUESTING
Date: Sun,  2 Nov 2025 13:45:24 +0800
Message-Id: <20251102054524.3972849-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQDXvwoD8AZpXsWvBA--.9738S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF13uFWruF4DZrWDJF43KFg_yoWrtF47pF
	yxKrWYkr1DJryxtFnayw4DXr15Cr48ArWfGr9FqrWUZ3WDXFyfZrZxKr4jvry5CFZ3C342
	93y2qFZ5Cr47Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUfuciUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQIOAWkF6ffKZwAAsT

Dear maintainers of Linux kernel, this is a resend version of the patch
with a clarified commit message based on the previous feedback
<CAL+tcoCJf8gHNW9O6B5qX+kM7W6zeVPYqbqji2kMqnDNuGWZww@mail.gmail.com>.
We haven't received any reply yet, so we resend it again. The code change
is the same; only the description is improved to better explain the issue,
 impact and rationale. Thanks for your time and review.

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


