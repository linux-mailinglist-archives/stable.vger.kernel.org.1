Return-Path: <stable+bounces-112634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E590A28DD1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5094C3A45A8
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C95156225;
	Wed,  5 Feb 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1JjNfn26"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3488155747;
	Wed,  5 Feb 2025 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764227; cv=none; b=hX7QbtYKPwD7HRWcvnaig7Jt2svl136solr2weHvIPpVewRCizm1jnN3DgKp92XebgWwNqEOfhHRc10dA6cdheTOLXNXAM5rd5H7UyGucIG08Jm3ZcukhVT5S6A57L9OFthToFB2owNxuW44mgi0kvvK/FcrTA2aUu6MqRpQ9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764227; c=relaxed/simple;
	bh=feOuHYnZY4HlkUkb3lhdJ6QHSiIB1p6wnldGbLNEl50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7B+k4dzQgGNqdka3AaMqkIqvTOtBhJlXdRELz9kgISQ2VQaK6kcdbOLPbBljB+S4rgZl9c8HFPjxI9/nJs+Kpbkv5E7JZz4/A/5GAuQGeiV2HEuv0G5uiFljIggB6Q7R5ltewkPWOOpNHUglanwdgh/OMRmwx/ytYU+duQt7b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1JjNfn26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28D7C4CED1;
	Wed,  5 Feb 2025 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764227;
	bh=feOuHYnZY4HlkUkb3lhdJ6QHSiIB1p6wnldGbLNEl50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1JjNfn26MvqOYflmssB6IWPCOQwkcBG11BIl4dQK5nvFA7+WcvXf0rp7oilI+rMQW
	 T0yf6cv0OTa50pUBzppTJzJMhqsLu/fH88x8S5NhT4popnT17JxeU+LVCdrz3UYo3B
	 /ddwQysBHpMVQUAKokelWNJdT/Cyq02jBkwSlGEo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mahdi Arghavani <ma.arghavani@yahoo.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Haibo Zhang <haibo.zhang@otago.ac.nz>,
	David Eyers <david.eyers@otago.ac.nz>,
	Abbas Arghavani <abbas.arghavani@mdu.se>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 151/393] tcp_cubic: fix incorrect HyStart round start detection
Date: Wed,  5 Feb 2025 14:41:10 +0100
Message-ID: <20250205134426.078538241@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahdi Arghavani <ma.arghavani@yahoo.com>

[ Upstream commit 25c1a9ca53db5780757e7f53e688b8f916821baa ]

I noticed that HyStart incorrectly marks the start of rounds,
leading to inaccurate measurements of ACK train lengths and
resetting the `ca->sample_cnt` variable. This inaccuracy can impact
HyStart's functionality in terminating exponential cwnd growth during
Slow-Start, potentially degrading TCP performance.

The issue arises because the changes introduced in commit 4e1fddc98d25
("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows")
moved the caller of the `bictcp_hystart_reset` function inside the `hystart_update` function.
This modification added an additional condition for triggering the caller,
requiring that (tcp_snd_cwnd(tp) >= hystart_low_window) must also
be satisfied before invoking `bictcp_hystart_reset`.

This fix ensures that `bictcp_hystart_reset` is correctly called
at the start of a new round, regardless of the congestion window size.
This is achieved by moving the condition
(tcp_snd_cwnd(tp) >= hystart_low_window)
from before calling `bictcp_hystart_reset` to after it.

I tested with a client and a server connected through two Linux software routers.
In this setup, the minimum RTT was 150 ms, the bottleneck bandwidth was 50 Mbps,
and the bottleneck buffer size was 1 BDP, calculated as (50M / 1514 / 8) * 0.150 = 619 packets.
I conducted the test twice, transferring data from the server to the client for 1.5 seconds.
Before the patch was applied, HYSTART-DELAY stopped the exponential growth of cwnd when
cwnd = 516, and the bottleneck link was not yet saturated (516 < 619).
After the patch was applied, HYSTART-ACK-TRAIN stopped the exponential growth of cwnd when
cwnd = 632, and the bottleneck link was saturated (632 > 619).
In this test, applying the patch resulted in 300 KB more data delivered.

Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows")
Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Haibo Zhang <haibo.zhang@otago.ac.nz>
Cc: David Eyers <david.eyers@otago.ac.nz>
Cc: Abbas Arghavani <abbas.arghavani@mdu.se>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Tested-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_cubic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 0fd78ecb67e75..5ff7be13deb6b 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -392,6 +392,10 @@ static void hystart_update(struct sock *sk, u32 delay)
 	if (after(tp->snd_una, ca->end_seq))
 		bictcp_hystart_reset(sk);
 
+	/* hystart triggers when cwnd is larger than some threshold */
+	if (tcp_snd_cwnd(tp) < hystart_low_window)
+		return;
+
 	if (hystart_detect & HYSTART_ACK_TRAIN) {
 		u32 now = bictcp_clock_us(sk);
 
@@ -467,9 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock *sk, const struct ack_sample
 	if (ca->delay_min == 0 || ca->delay_min > delay)
 		ca->delay_min = delay;
 
-	/* hystart triggers when cwnd is larger than some threshold */
-	if (!ca->found && tcp_in_slow_start(tp) && hystart &&
-	    tcp_snd_cwnd(tp) >= hystart_low_window)
+	if (!ca->found && tcp_in_slow_start(tp) && hystart)
 		hystart_update(sk, delay);
 }
 
-- 
2.39.5




