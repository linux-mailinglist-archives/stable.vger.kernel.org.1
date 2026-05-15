Return-Path: <stable+bounces-247322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE42F6ChBmoMlgIAu9opvQ
	(envelope-from <stable+bounces-247322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:31:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2EB5493C9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2506630604A6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3F3D5239;
	Fri, 15 May 2026 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqIKx34G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DBD3D412C;
	Fri, 15 May 2026 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819297; cv=none; b=JNMl1NlCwoho+j18YyGceux04y4JEpbYRhZFzwJLuYnP1jODnopnopGhxMzBYmuORvPono71JXns41vdVVNdpAFXMBYi64/Kh/rp1Nbg1c0edYgnm51o66HuYKI+2j/DM/UC2GJMyHo45Tb9PiJPvd37HK6uO2Uz330XLeW6cGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819297; c=relaxed/simple;
	bh=8Q4veE2pixKdG2Hn7ZQPBXIgIhaLZqlRWfE2OTr3Kas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8nSXkOb1wYe09TghXmVdGCPPA1BImzOZre4kdNXKbP4M1eHKiJpRj9UW87cyA8dSTbuojnKqkNVK0lXbAayc/xOSB2iV9UcqDpRCuczoufv/BObd7iF/IVbXYB2GmJhu2bbsVJwo6V26a/is6ISe7+zcZU89xMERftH+GQ28Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqIKx34G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE49CC2BCB0;
	Fri, 15 May 2026 04:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778819297;
	bh=8Q4veE2pixKdG2Hn7ZQPBXIgIhaLZqlRWfE2OTr3Kas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gqIKx34GRy6wAY2QbGGu0hpg8TX5W5QKPDO92XebEqwv2sz2HUfnUY8QFSnM48Bjb
	 iYgdAq4rz4kQpOxzZLzFdDj3sW6DuuKoY1ik+kgYQaYTOX5rpbjP1s/wZNDzyDGGp3
	 hEUf37hJ/1R5hBXH62j48LeiQiMxgvgXFifq2HdcQfxy8dWOaIW1Hnc3wmHYstqDJc
	 1cUmZ+LuP3gmPHpWl4GD4EWi8J/ZlDm+IjFjDD1vsC45lk69zQy17gi+QJEhC+Ixfk
	 jzNbM6YwCeZtR1Fk9CZR2GnT+y26NZC6ne53VuC2dgH6eCuwsaPx8JvH+3dTj4pcV0
	 RPRh+QxS/9+Ow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 May 2026 06:27:33 +0200
Subject: [PATCH net v2 2/6] mptcp: pm: fix ADD_ADDR timer infinite retry on
 option space insufficient
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-2-701e96419f2f@kernel.org>
References: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
In-Reply-To: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumaze@google.com>, 
 Li Xiasong <lixiasong1@huawei.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4928; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sPnzFdsNttVGUezP0ccoEY3L+m3b4Tf5peNFQD479qA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqBqDLcYJA4WE6mqKzqstI/rKwiEv8H6EB1XDh7
 3mwBNeAA0CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagagywAKCRD2t4JPQmmg
 c9HPEADticNuhZOZ9gpX5QCh/YKkeF3BeN7tSiZwQRRZlp/1/FnZj14D+g9l5fvZAcr12vjMXRy
 BSQduzLSgy8oSYpmfjwk1qHbZaphbTr5Oo+LCpxdroOhH8dgeFXoeEHBlSWhvB+fvlupyvvQA7N
 /xKR7obww0zREXK9c45WYbBrvZURRJoOuHVf/ci8ZUheJNFUqlJ6srdwdmQaNkQ9X0MrpFpwhPU
 DxcJ1lxOd+Y0b8/SSECeHalC+K15U+V3aKUQbZLE/4yIHAgQHcTnSb3zUnWVaVlqgQm2elf2/ao
 jueqbYgpkD0Wwibg5iv/ZEC6BGAG8tTfftplbXdbWtfLzif3OTdiOq45MLYaomGdLnJ9G0ery+g
 tdKDjPCWF4LW0GupY3bAblVrRnIe51mbFVC5TV+J4YktGoZptqkKFsDt6nhNACwL1f1LtFE6S31
 Z4/k2zAMIXEWsTRwQHiOphgC+P6zHaBmO0GAHV4+hlrbq5/Lmh8wF7Aji5Oba4vRyBG6Dj04/XQ
 KF4rPRiVGD5poB2ri9ShXzImn3f8Srx75Fg/rysT7rO0DIW0IBPxj7AxXeiv/6MDY/fV9oQXaHn
 B750NXOyPnI5eUfFoHnhgjJTtunpZdbdsAYlT0+utzdWLDrpnzPs01EsvTML9pHBIEKmrCVfKNo
 L+nTB2+b50wKClw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: EE2EB5493C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247322-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Action: no action

From: Li Xiasong <lixiasong1@huawei.com>

When TCP option space is insufficient (e.g., when sending ADD_ADDR with an
IPv6 address and port while tcp_timestamps is enabled), the original code
jumped to out_unlock without clearing the addr_signal flag. This caused
mptcp_pm_add_timer to keep rescheduling indefinitely, not sending ADD_ADDR,
preventing subsequent addresses in the endpoint list from being announced.

Handle this case by clearing the ADD_ADDR signal and skipping the matching
ADD_ADDR retransmission entry. The skip path cancels the matching timer
(with id check) and advances PM state progression, preserving forward
progress to subsequent PM work.

This cancellation is inherently best-effort. A concurrent add_timer
callback may already be running and may acquire pm.lock before the
cancel path updates entry state. In that case, one final ADD_ADDR
transmit attempt can still be executed.

Once the cancel path sets entry->retrans_times to ADD_ADDR_RETRANS_MAX,
the callback-side retrans_times check suppresses further ADD_ADDR
retransmissions.

Note that when an ADD_ADDR is being prepared, a pure-ACK is queued. On
the output side, it means that it is fine to skip non-pure-ACK packets,
when drop_other_suboptions is set: a pure-ACK will be processed soon
after.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: add a note for sashiko-nipa's: it's a false positive.
---
 net/mptcp/pm.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3c152bf66cd5..3e770c7407e1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -364,7 +364,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	if (!mptcp_pm_should_add_signal_addr(msk)) {
+	/* The cancel path (mptcp_pm_del_add_timer()) can race with this
+	 * callback. Once cancel updates retrans_times to MAX, suppress further
+	 * retransmissions here. If this callback acquires pm.lock first, one
+	 * final transmit attempt is still possible.
+	 */
+	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX &&
+	    !mptcp_pm_should_add_signal_addr(msk)) {
 		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
@@ -414,8 +420,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	/* Note: entry might have been removed by another thread.
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
-	if (stop_timer)
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	if (stop_timer) {
+		if (check_id)
+			sk_stop_timer(sk, &entry->add_timer);
+		else
+			sk_stop_timer_sync(sk, &entry->add_timer);
+	}
 
 	rcu_read_unlock();
 	return entry;
@@ -882,6 +892,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions)
 {
+	bool skip_add_addr = false;
 	int ret = false;
 	u8 add_addr;
 	u8 family;
@@ -903,24 +914,49 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	}
 
 	*echo = mptcp_pm_should_add_signal_echo(msk);
-	port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
-
-	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
-	if (remaining < mptcp_add_addr_len(family, *echo, port))
-		goto out_unlock;
-
 	if (*echo) {
 		*addr = msk->pm.remote;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
+		port = !!msk->pm.remote.port;
+		family = msk->pm.remote.family;
 	} else {
 		*addr = msk->pm.local;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
+		port = !!msk->pm.local.port;
+		family = msk->pm.local.family;
 	}
-	WRITE_ONCE(msk->pm.addr_signal, add_addr);
+
+	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
+		struct net *net = sock_net((struct sock *)msk);
+
+		if (!*drop_other_suboptions)
+			goto out_unlock;
+
+		if (*echo) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
+		} else {
+			skip_add_addr = true;
+			MPTCP_INC_STATS(net, MPTCP_MIB_ADDADDRTXDROP);
+		}
+		goto drop_signal_mark;
+	}
+
 	ret = true;
 
+drop_signal_mark:
+	WRITE_ONCE(msk->pm.addr_signal, add_addr);
+
 out_unlock:
 	spin_unlock_bh(&msk->pm.lock);
+
+	/* On pure-ACK option-space exhaustion, stop retrying this ADD_ADDR:
+	 * clear the signal bit, cancel the matching retransmission timer, and
+	 * let the PM state machine progress.
+	 */
+	if (skip_add_addr) {
+		mptcp_pm_del_add_timer(msk, addr, true);
+		mptcp_pm_subflow_established(msk);
+	}
 	return ret;
 }
 

-- 
2.53.0


