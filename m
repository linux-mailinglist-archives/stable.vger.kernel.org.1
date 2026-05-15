Return-Path: <stable+bounces-247321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHbxHiuhBmoMlgIAu9opvQ
	(envelope-from <stable+bounces-247321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:29:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8752B549326
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0298B3026135
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BDE3D45E7;
	Fri, 15 May 2026 04:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7GwFW2b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293E3D4103;
	Fri, 15 May 2026 04:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819291; cv=none; b=oJHhHPjmq2dI+0R/AbcpSTRC4oljxXg7MaigyX/6ga7riqIpjj6v3+RSZlsj4Z6QUZxTZaAc4yOEEmRSmYuE0YrZ0KKcqIxRPWgtYR5uJVH7XYQF8JDwY7/McKeibYINUTAjYa/1LjhYGIbNnTIDMBxqP89QEfOSx5UGwntc25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819291; c=relaxed/simple;
	bh=qQvn5axOR+yyPoQDWmxod2/JnSKoOIIR/aijmbsFW08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OH7VsWkMSjVgkJhIlVRWzwWFAEg16v0TyBX9W49FP6wH3Ci0N7Y4PVNFHUaK1VYOYT+5ayYAMJaek+1Bm4JHlq6JX0SkfJMdh3G9Nd9B4yb2SDj1vcTLIBp/dz6VAW9nIULq6JhV//IzrqdGB1WF3x5LYWve9eDdrjiXDaTbV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7GwFW2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6284AC2BCB0;
	Fri, 15 May 2026 04:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778819290;
	bh=qQvn5axOR+yyPoQDWmxod2/JnSKoOIIR/aijmbsFW08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F7GwFW2bvGWtBJMJ/SWBFZs/qMW8nitfD6DuEIXwVCAppM6bi1ulBI9AyLqCQilYb
	 8IRpDpD2bwy05O8a6WQrc7q5GQkphxuRIgOq90Ui7Nn3hegDr+zMtwpF7Zi91j1d5d
	 u/Q65+KlPT7VbDNAwUtBy0AW/3BydTRnyW9ujxoypw30sdQJ3McOim/IGN/TESMrXV
	 LPETmMenKoYuknahpyn7FeEkI5WxrWrUJT8vFERHWWj5OOMK/PXQRK/acK1pRAR2Vg
	 M+hewsHfL5CtgHK4z5t/W8M8Afh8lq7lwhd3YeJQVB8LOmY/z+uYW+ZN8liVyuYU2W
	 Xdp4tzQakpQiw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 May 2026 06:27:32 +0200
Subject: [PATCH net v2 1/6] mptcp: do not drop partial packets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-1-701e96419f2f@kernel.org>
References: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
In-Reply-To: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumaze@google.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3127; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=doSwMYEfSiK6uGg6E6Qa8BN/Nu92k84XWlJ5BdjtdXs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqBqDKbnJLNZZ8c8s5pHZvcBHGHJIpaxSHCFZNV
 heMNzxSNl2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagagygAKCRD2t4JPQmmg
 c/aTEACWjZEsrwGSQLpwSGVLtJu+sJryxm+vfcCfTgd3mIcxKwbypG7w54BvenJt+IbR8D7ATnH
 SC1d6TPSiQ1tz9LtvkNifBRh19nu7P7/KN/Ia96k8Op6g+euCHEQfRO/YaA5IrsYjyLEKOEfZe1
 tmjT0ciNLc//AGnNv95ZhxmtfFRZ8x3V8sflSc9DTH9GVQth2u4KOFeWBP6uh9FaUP868mif1/k
 KNCiki4rlhIeoyploQkO2QdnFCi/vFyMeUunVEtwcpK4HNC5lEyGCnTwQHxr6aKXlWG0VXCg1QR
 ghCyLmxL7C5JKTDamK3Nlw7ZMAbmqTaWZS1ZCsEBNClraGUvf67VyyxMppXP6lIxc9wvdtDT+Ne
 SuIdTJYefDuaeZfoDc/qgH/YEtO2WycjgLTI62CIATaNYjORi8iqjsvvXTGb/IEHcHreVL6sP7r
 x2l0VF/pUUImCkAfGxfznm9PZMLaxtH1ePf27EQ1wFt9eWN0PmOMvt71WL0mdQFP0CPH9dZX6aa
 5uJWNHOkNYhfSsOrxfR9wcWVdMibuKOeyL0zMMTG0SWIiSVRMJ6xeZCI9l/vUKT+mEutH5lcv/U
 b1uleHE9Otj+17EdIBqfd8Ek6qAq2KDs2Q3JbAjBiMlt4aep4ZUHVu7MYnKjmTHPrS2LvNDURXs
 e41aE7ws1WzTy3g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 8752B549326
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247321-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

When a packet arrives with map_seq < ack_seq < end_seq, the beginning
of the packet has already been acknowledged but the end contains new
data. Currently the entire packet is dropped as "old data," forcing
the sender to retransmit.

Instead, skip the already-acked bytes by adjusting the skb offset and
enqueue only the new portion. Update bytes_received and ack_seq to
reflect the new data consumed.

A previous attempt at this fix has been sent by Paolo Abeni [1], but had
issues [2]: it also added a zero-window check and changed rcv_wnd_sent
initialization, which caused test regressions. This version addresses
only the partial packet handling without modifying receive window
accounting.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/c9b426a4e163aa3c4fe8b80c79f1a610f47ae7d8.1763075056.git.pabeni@redhat.com [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600 [2]
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
[pabeni@redhat.com: update map]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: (Paolo)
  - update map_seq, too (AI tool)
v2: (Shardul)
  - Drop the mptcp_try_coalesce() attempt for partial packets, since
    non-zero offset always prevents coalescing (Paolo).
  - https://lore.kernel.org/20260422143931.43281-1-shardul.b@mpiricsoftware.com
v1: (Shardul)
  - https://lore.kernel.org/20260422120954.8877-1-shardul.b@mpiricsoftware.com
v0: (Paolo)
  - https://lore.kernel.org/mptcp/c9b426a4e163aa3c4fe8b80c79f1a610f47ae7d8.1763075056.git.pabeni@redhat.com
---
 net/mptcp/protocol.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4546a8b09884..859df49e16dc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -397,12 +397,26 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
+	/* Completely old data? */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
+	/* Partial packet: map_seq < ack_seq < end_seq.
+	 * Skip the already-acked bytes and enqueue the new data.
 	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-	mptcp_drop(sk, skb);
-	return false;
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+				      MPTCP_SKB_CB(skb)->map_seq;
+	msk->bytes_received += copy_len;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)

-- 
2.53.0


