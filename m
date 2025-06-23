Return-Path: <stable+bounces-157633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F163CAE54E8
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47551BC2E61
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59F6218580;
	Mon, 23 Jun 2025 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="udOQyuRP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848161E87B;
	Mon, 23 Jun 2025 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716345; cv=none; b=XuHZZZTKsUdJbmOE+jpfYkUgzBAwbIK4ULXJq4lCiIm4QzwZOwgdYpGA46pHvrXedLZ7HNzp2yW6l8wgedZh9g5R8A8Am08rGF3ggFp/TxlDg8RtXiACdQdpiY4ayD1AZKu1ajXm46w04vwg9E7c6klkStiImSGx6T14f9vRkfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716345; c=relaxed/simple;
	bh=pYAkAbY2p6AsIoSksAXZ/HZHu2sbbd7pqzXfsFFNoWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFxQSTENKmmKGfryV+bwGt9Gjq9pCKb4Vz6VugqYoBrI3d6uaOJMBmMzQ5o7j2BAag51ATBM0Hc/Y0m3juKkEovGrG0w68VskYza0OYbF5uNe7UM8cjOpUTp/XXKd6eutc1Q7GZOcmw0to9YAX49tk+crVku1d+SHtdHvPF4NHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=udOQyuRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF0BC4CEEA;
	Mon, 23 Jun 2025 22:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716345;
	bh=pYAkAbY2p6AsIoSksAXZ/HZHu2sbbd7pqzXfsFFNoWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udOQyuRP1aSCaWjLORM/v/KA2qPj5xwi5Q3pD8yh0SC8aJ2Cm3DreOVvuQY9t7vG7
	 C4BuEX/t1PuywQMWgJ/Q39wbhhelsbp+97fOearLVEmhSoHNZJRXqYGau3cHFe48i/
	 i5g2irgfyECkof0+VyREb6oRLpXmvxpGAMN+ztXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 314/411] tcp: always seek for minimal rtt in tcp_rcv_rtt_update()
Date: Mon, 23 Jun 2025 15:07:38 +0200
Message-ID: <20250623130641.544852370@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b879dcb1aeeca278eacaac0b1e2425b1c7599f9f ]

tcp_rcv_rtt_update() goal is to maintain an estimation of the RTT
in tp->rcv_rtt_est.rtt_us, used by tcp_rcv_space_adjust()

When TCP TS are enabled, tcp_rcv_rtt_update() is using
EWMA to smooth the samples.

Change this to immediately latch the incoming value if it
is lower than tp->rcv_rtt_est.rtt_us, so that tcp_rcv_space_adjust()
does not overshoot tp->rcvq_space.space and sk->sk_rcvbuf.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250513193919.1089692-8-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8859a38b45d5e..000557f5c54bc 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -641,10 +641,12 @@ EXPORT_SYMBOL(tcp_initialize_rcv_mss);
  */
 static void tcp_rcv_rtt_update(struct tcp_sock *tp, u32 sample, int win_dep)
 {
-	u32 new_sample = tp->rcv_rtt_est.rtt_us;
-	long m = sample;
+	u32 new_sample, old_sample = tp->rcv_rtt_est.rtt_us;
+	long m = sample << 3;
 
-	if (new_sample != 0) {
+	if (old_sample == 0 || m < old_sample) {
+		new_sample = m;
+	} else {
 		/* If we sample in larger samples in the non-timestamp
 		 * case, we could grossly overestimate the RTT especially
 		 * with chatty applications or bulk transfer apps which
@@ -655,17 +657,9 @@ static void tcp_rcv_rtt_update(struct tcp_sock *tp, u32 sample, int win_dep)
 		 * else with timestamps disabled convergence takes too
 		 * long.
 		 */
-		if (!win_dep) {
-			m -= (new_sample >> 3);
-			new_sample += m;
-		} else {
-			m <<= 3;
-			if (m < new_sample)
-				new_sample = m;
-		}
-	} else {
-		/* No previous measure. */
-		new_sample = m << 3;
+		if (win_dep)
+			return;
+		new_sample = old_sample - (old_sample >> 3) + sample;
 	}
 
 	tp->rcv_rtt_est.rtt_us = new_sample;
-- 
2.39.5




