Return-Path: <stable+bounces-251835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJd4AFn8DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-251835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:24:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFCA596085
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588A8376FBCB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5496A369D7E;
	Wed, 20 May 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GWBd7EXF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004536F901;
	Wed, 20 May 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299013; cv=none; b=fzaE1m7Mp86wBzQAIvAXjlxvxy06fKsdEG8DLsOxHczD7BQOoyJrCK/VTmTa1VcBVIZ9GDcDKMu4tVUpCMgvAaCc60Rq3mjjqxYo9EUTbP1DSWdV7BBGnBn+rC3V3xeFQRpp0083V+4Y+BTdaHK/rIXkRHtfXq+obTf4ukfxYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299013; c=relaxed/simple;
	bh=EVZIqEWVLxBOC7HhJMlUWZctuwrdddtY6J1DapbqRiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1hX38rFlA7viH8E+MpRKeQhlG0DcLjjOEEkC0CTpRBozk3jf0RypOVOx0Ae+BGk+sG0eu0HH9kfu/F5XGzZECts8/sDZaHfmQ8qb9akGLgt6hfcv1iuBFpm/8wpqF1T7h6khfz3cl5YG71AX+cBy0U9Nt6KZWAPxWUrqqxh7kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GWBd7EXF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C6D1F000E9;
	Wed, 20 May 2026 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299012;
	bh=zWVCaPYtJ/JmLOcXsgBAr69wKJUYAWmhdO2UWcneNDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GWBd7EXFml2tYZG4Z2yH9HoUa8zz2fPwSy0op/8w3E9WiLMghciTFcJdzpQzevzWL
	 ugcPjTRYM7xMvZzWHTNgb0GYOWjD9Q1Zng/6cY8QF0+iIQgS/o3Xocn2RcHlUXom18
	 9OgCcRzegKvBY4+8886PAQRhb+Yo23qUe5RhbASo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 630/957] tcp: inline tcp_chrono_start()
Date: Wed, 20 May 2026 18:18:33 +0200
Message-ID: <20260520162148.191212035@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251835-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vmlinux.new:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3FFCA596085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d6d4ff335db2d9242937ca474d292010acd35c38 ]

tcp_chrono_start() is small enough, and used in TCP sendmsg()
fast path (from tcp_skb_entail()).

Note clang is already inlining it from functions in tcp_output.c.

Inlining it improves performance and reduces bloat :

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 1/0 up/down: 1/-84 (-83)
Function                                     old     new   delta
tcp_skb_entail                               280     281      +1
__pfx_tcp_chrono_start                        16       -     -16
tcp_chrono_start                              68       -     -68
Total: Before=25192434, After=25192351, chg -0.00%

Note that tcp_chrono_stop() is too big.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Link: https://patch.msgid.link/20260308123549.2924460-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 267bf3cf9a6f ("tcp: annotate data-races in tcp_get_info_chrono_stats()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h     | 25 ++++++++++++++++++++++++-
 net/ipv4/tcp_output.c | 24 ------------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7647ed5c732c1..6805961726dc1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2124,7 +2124,30 @@ enum tcp_chrono {
 	__TCP_CHRONO_MAX,
 };
 
-void tcp_chrono_start(struct sock *sk, const enum tcp_chrono type);
+static inline void tcp_chrono_set(struct tcp_sock *tp, const enum tcp_chrono new)
+{
+	const u32 now = tcp_jiffies32;
+	enum tcp_chrono old = tp->chrono_type;
+
+	if (old > TCP_CHRONO_UNSPEC)
+		tp->chrono_stat[old - 1] += now - tp->chrono_start;
+	tp->chrono_start = now;
+	tp->chrono_type = new;
+}
+
+static inline void tcp_chrono_start(struct sock *sk, const enum tcp_chrono type)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	/* If there are multiple conditions worthy of tracking in a
+	 * chronograph then the highest priority enum takes precedence
+	 * over the other conditions. So that if something "more interesting"
+	 * starts happening, stop the previous chrono and start a new one.
+	 */
+	if (type > tp->chrono_type)
+		tcp_chrono_set(tp, type);
+}
+
 void tcp_chrono_stop(struct sock *sk, const enum tcp_chrono type);
 
 /* This helper is needed, because skb->tcp_tsorted_anchor uses
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b94efb3050d2f..b00bd5044b322 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2813,30 +2813,6 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 	return false;
 }
 
-static void tcp_chrono_set(struct tcp_sock *tp, const enum tcp_chrono new)
-{
-	const u32 now = tcp_jiffies32;
-	enum tcp_chrono old = tp->chrono_type;
-
-	if (old > TCP_CHRONO_UNSPEC)
-		tp->chrono_stat[old - 1] += now - tp->chrono_start;
-	tp->chrono_start = now;
-	tp->chrono_type = new;
-}
-
-void tcp_chrono_start(struct sock *sk, const enum tcp_chrono type)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	/* If there are multiple conditions worthy of tracking in a
-	 * chronograph then the highest priority enum takes precedence
-	 * over the other conditions. So that if something "more interesting"
-	 * starts happening, stop the previous chrono and start a new one.
-	 */
-	if (type > tp->chrono_type)
-		tcp_chrono_set(tp, type);
-}
-
 void tcp_chrono_stop(struct sock *sk, const enum tcp_chrono type)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-- 
2.53.0




