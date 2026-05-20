Return-Path: <stable+bounces-250828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJqKNSP0DWoF5AUAu9opvQ
	(envelope-from <stable+bounces-250828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:49:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1096C594A89
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEF6B30A9C80
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C73F0762;
	Wed, 20 May 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="piX8r96x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EDD3EFD22;
	Wed, 20 May 2026 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296412; cv=none; b=D9cWV2JAHOZoiQN/LFkT+7FbCBuj6U5mHfaRPwPO4A+wmEJED/9oR6EFfXS1Z6G6u9W/M64ffMSnOv0qa5sVaLef5rdeIcTcfnqXWRQvD1KRa8Mig6VVegYRc1e3J9bHjpca0oEDh0pYX/1AfmI4v8mnCXWU/OjeXW4g1HP6wMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296412; c=relaxed/simple;
	bh=fk3lzRXpNfkz+IgBOPS9hfJ3IQWQnLrcg5i+PTB0ixI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWexQH4gzy3+vFsZNVgPhZN3bsmBE0XvJh7svaTGsLqemU7Wero1jK7nposqb7NkySkHJ3hWdle2U3KzeMkVN64mV+t6lwoRoKr80wJPrhOm9gtl1E0Wu9PvfKZrXMgDY5VPLEFvhjcScANi2yn52ABzl9tXYoHMC9CFgUA253Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=piX8r96x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD081F000E9;
	Wed, 20 May 2026 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296411;
	bh=sDtqvqKkgm7U3Wp8LiaET7FFq1XfQKcYhW9cvn5HUjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=piX8r96xN8OC1+xlpbbHQejkBcekdi3qlg1ova3NjkPhg2vFWjTcGxYql3rsX2TRc
	 08q054+TZ4u8fn+8PGZkpehWIkCpac3MbEl6Ev854HUCUiMOH/q8kl6mXW1bu3c4Nc
	 PRgovZ919f+KvtuOLbhgc4YXIcBkY0WR0v1X4OAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0790/1146] tcp: annotate data-races around tp->srtt_us
Date: Wed, 20 May 2026 18:17:20 +0200
Message-ID: <20260520162206.103601353@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250828-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1096C594A89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 290b693ce7c9d48588d88b15a782a3efc6fa036b ]

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: e8bd8fca6773 ("tcp: add SRTT to SCM_TIMESTAMPING_OPT_STATS")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260416200319.3608680-12-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c       | 5 +++--
 net/ipv4/tcp_input.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 80274554eaa12..566a04088fdc5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3656,7 +3656,8 @@ static void tcp_enable_tx_delay(struct sock *sk, int val)
 	if (delta && sk->sk_state == TCP_ESTABLISHED) {
 		s64 srtt = (s64)tp->srtt_us + delta;
 
-		tp->srtt_us = clamp_t(s64, srtt, 1, ~0U);
+		WRITE_ONCE(tp->srtt_us,
+			   clamp_t(s64, srtt, 1, ~0U));
 
 		/* Note: does not deal with non zero icsk_backoff */
 		tcp_set_rto(sk);
@@ -4501,7 +4502,7 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 			  READ_ONCE(tp->bytes_retrans), TCP_NLA_PAD);
 	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, READ_ONCE(tp->dsack_dups));
 	nla_put_u32(stats, TCP_NLA_REORD_SEEN, READ_ONCE(tp->reord_seen));
-	nla_put_u32(stats, TCP_NLA_SRTT, tp->srtt_us >> 3);
+	nla_put_u32(stats, TCP_NLA_SRTT, READ_ONCE(tp->srtt_us) >> 3);
 	nla_put_u16(stats, TCP_NLA_TIMEOUT_REHASH, tp->timeout_rehash);
 	nla_put_u32(stats, TCP_NLA_BYTES_NOTSENT,
 		    max_t(int, 0, tp->write_seq - tp->snd_nxt));
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eee460d19e254..c6c55c51a6409 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1133,7 +1133,7 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
 
 		tcp_bpf_rtt(sk, mrtt_us, srtt);
 	}
-	tp->srtt_us = max(1U, srtt);
+	WRITE_ONCE(tp->srtt_us, max(1U, srtt));
 }
 
 void tcp_update_pacing_rate(struct sock *sk)
-- 
2.53.0




