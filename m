Return-Path: <stable+bounces-244183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAXGEKUG+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:03:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A764CFE0B
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B40483074AE2
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E5B48165E;
	Tue,  5 May 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP/KAfUN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79248165B;
	Tue,  5 May 2026 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993296; cv=none; b=Tfj2x1HoqLDtn6sFnSlz2SQQ2zMtK7Opk9etpELoRlyhQVnq95sxwOTELe53s52W1wr0Ic2DNNiTLwlCOyqfg4mWX0xNkMKQ9sQ4ksepXST5xCjF/YkvwLApOJHwAqdh46I5GT9uxHFf72MPi+cUVDmnI+FGppmG3FPUSL3W69g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993296; c=relaxed/simple;
	bh=9lEqNr5o96brxW53kM1HDMOvIp5F6keFzu1PTTOw344=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hmFwiWpXIuKHt7/P9fLILUY9Pasut+yvACk2FQ41qpbDjm2mkJxeLjcPwQgHtZlC+vVbxR/0io7scTQAajXSGn8vbz0EPFHZWYH2MtQRSXjfLZKYTz3P5u91RuMQEctHJDsRCNmxiGaTCO1NDO7DqSlFj8kE7vcABlUsS0tJf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP/KAfUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF61C2BCB4;
	Tue,  5 May 2026 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993296;
	bh=9lEqNr5o96brxW53kM1HDMOvIp5F6keFzu1PTTOw344=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XP/KAfUN1RLfOzWfb5obwrakZVSKFNQDwj+eEzQrrYCDv5xyKebWy//b7YlQR8pB1
	 qw45xMq1XC+6sIRfLKZzr+abklWS1XTXkay0ZkVBx0yHcWURxxi/zIUPf8kgd+G+4f
	 xe+vEdmh8hJy74t7M63BiS82mMFQ/O/HLwM6E+ugqNBlouFrfSoeMHyeLD0eWCDpxM
	 qbTdu3g24JEVpXfJ1yZzKBX4/l1U2xUXuA1IMan77AItcSmQjvBR91vdMQvQZbBiOI
	 2UoJc5qXC8gUU2zo7TQaQ79TPogwdW92R2ZweXiIhAbaLnhOlt+9khakXj+k8furpM
	 RB8YwKIZkJWVw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 May 2026 17:00:52 +0200
Subject: [PATCH net 04/11] mptcp: pm: ADD_ADDR rtx: always decrease sk
 refcount
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-4-fca8091060a4@kernel.org>
References: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
In-Reply-To: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9lEqNr5o96brxW53kM1HDMOvIp5F6keFzu1PTTOw344=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ/sdly9yruWTVjm25NoXzgV4vJCfs/pj6NXDfT4K/pv
 6VtJeeEOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbysYyRYaNN3ZdbMZ/XGjzd
 xtCy6If25L6ej82pzHe4727UNrPvOMDwz0bt1Nm4x7W2AmdPWZ2Y9+hVy9nat4W1JUbXX1R+8d+
 iwQQA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: B5A764CFE0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244183-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to a new 'exit' label to call
__sock_put() (which will become sock_put() in the next commit) to fix
this potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3912128d9b86..2a01bf1b5bfd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -331,11 +331,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -373,6 +370,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	__sock_put(sk);
 }
 

-- 
2.53.0


