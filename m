Return-Path: <stable+bounces-218439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA34LQhTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD318F664
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24E2D31D56C0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267320C012;
	Wed, 25 Feb 2026 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YPKdRkOa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656018B0A;
	Wed, 25 Feb 2026 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983260; cv=none; b=DxMextcbGwOKF7Fv9FG1jthtCihNRy8iJDQN5Emt57HJuTFJKWweNvECtkwUXHkqWaXbE+oAf67P1qNIWbwoEgio+OuhSQ2rd7jn175va8lztJW9chLV9qKPnQ7WxJGV9HQ8Vt9RSj1Rjo1izvmRtKA0BcHqaX+0erakQURtdL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983260; c=relaxed/simple;
	bh=UgqGNqUxZ7M4EBZFwCAreSZf8CYK8OHALnuHeTQqzCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcd1Yh8flvhn5l60XQ2QGIkkUuTajh2C4MoPLJ2dwcdeBYHG6acAv7Iri97UCGzVJULFx6c+v677IYSuQFvTI7fXFCdQQGw5QgImqfBo06HAhgaY7K4HWCAPoBYStn0m7bZTBaEnEvZKDYCLHaBdgzfx3l5//jGS0vyUFphTXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YPKdRkOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BB6C116D0;
	Wed, 25 Feb 2026 01:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983260;
	bh=UgqGNqUxZ7M4EBZFwCAreSZf8CYK8OHALnuHeTQqzCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPKdRkOaeHWdhj8squVtUnyt9cfvXmrI/tkX24Cmv7pqw0ZygD+hJqghZFIkcmTgc
	 Il1oRbhb3FDMKRFHFLghzPUJ66HBHSywWNBOmdIDHOoikm19mW9Vvs0fE5U8xRp2Ba
	 5dgv1Q8EDJuqtEeMLujem8R6XB9tO4gQqTYz4K6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 402/781] mptcp: fix receive space timestamp initialization
Date: Tue, 24 Feb 2026 17:18:31 -0800
Message-ID: <20260225012409.564860088@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218439-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 72AD318F664
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 70274765fef555af92a1532d5bd5450c691fca9d ]

MPTCP initialize the receive buffer stamp in mptcp_rcv_space_init(),
using the provided subflow stamp. Such helper is invoked in several
places; for passive sockets, space init happened at clone time.

In such scenario, MPTCP ends-up accesses the subflow stamp before
its initialization, leading to quite randomic timing for the first
receive buffer auto-tune event, as the timestamp for newly created
subflow is not refreshed there.

Fix the issue moving the stamp initialization out of the mentioned helper,
at the data transfer start, and always using a fresh timestamp.

Fixes: 013e3179dbd2 ("mptcp: fix rcv space initialization")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260203-net-next-mptcp-misc-feat-6-20-v1-2-31ec8bfc56d1@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 8 ++++----
 net/mptcp/protocol.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cfa38bdaf2a92..bad9fc0f27d9c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2082,8 +2082,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 	msk->rcvq_space.copied += copied;
 
-	mstamp = div_u64(tcp_clock_ns(), NSEC_PER_USEC);
-	time = tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
+	mstamp = mptcp_stamp();
+	time = tcp_stamp_us_delta(mstamp, READ_ONCE(msk->rcvq_space.time));
 
 	rtt_us = msk->rcvq_space.rtt_us;
 	if (rtt_us && time < (rtt_us >> 3))
@@ -3543,6 +3543,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
+	msk->rcvq_space.time = mptcp_stamp();
 
 	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
@@ -3560,8 +3561,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 	msk->rcvq_space.copied = 0;
 	msk->rcvq_space.rtt_us = 0;
 
-	msk->rcvq_space.time = tp->tcp_mstamp;
-
 	/* initial rcv_space offering made to peer */
 	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
 				      TCP_INIT_CWND * tp->advmss);
@@ -3757,6 +3756,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
+	WRITE_ONCE(msk->rcvq_space.time, mptcp_stamp());
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 66e9735007912..39afd44e072f2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -915,6 +915,11 @@ static inline bool mptcp_is_fully_established(struct sock *sk)
 	       READ_ONCE(mptcp_sk(sk)->fully_established);
 }
 
+static inline u64 mptcp_stamp(void)
+{
+	return div_u64(tcp_clock_ns(), NSEC_PER_USEC);
+}
+
 void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
-- 
2.51.0




