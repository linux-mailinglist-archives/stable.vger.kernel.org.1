Return-Path: <stable+bounces-244181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aASdLXkG+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:02:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C64CFDF5
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E24E53064451
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C052480DD5;
	Tue,  5 May 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsAIMpoE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCED480974;
	Tue,  5 May 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993294; cv=none; b=SVm6lKcWMqvyGL9IQLDFSGJC4LG8JBTfZVpN21SpkiF7R7mdBhLMogHLL0Vp4zPuGaKkJQh21Xuigu4pD7xjp7xGFcm5+EQSMFkhgZm9gVJwE+Kx4FcrBfx3SHdiQsosppFAd4L15LVo7IM2q2BUSghK409vHqNqXUka/LsryLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993294; c=relaxed/simple;
	bh=Bcs35Z3gYm7xwLE3VZxEnozcC4S4AZ2W+dU9mPhm5wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s6nUq7FtfSeZ13oTQJ1OHCz1MOlXS7QCrt6fcRmHIM0ee86mvIvFeTLcj9Na1iCXx9P1MH0MNS7OYD2OzjOpE06bfpXUig7M45iziI/LaAR4pYAAzYC+CmF9iZ0n+PnGYXwCa8SOudk+KXV7XwuhOXpVTKx3jzjkKWj5kAmdsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsAIMpoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA611C2BCF4;
	Tue,  5 May 2026 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993291;
	bh=Bcs35Z3gYm7xwLE3VZxEnozcC4S4AZ2W+dU9mPhm5wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hsAIMpoEcEoUgzGn7ZkTxBziZFn8GBov81vOhBBBzcmOzKmUW50bMSwdA2wDLlCiu
	 H8AykWl35tkizlsNEObXPlLHgey9Us0s6mwGNQ0IA1ycxBui/caqBcBPaPctafd8tR
	 FoOmWvEHjrM436tziE+AOv3SuCUHzZSYbQPZzbVBQWeBesfCkk85ae1eY59gX18N1G
	 9vudKR6vzQqSQ2vTL9FRX70hmKCnJd5ptrnKzK42TdcDqQkTC6BmoW+cmthl9lULaJ
	 K0OMXOft7fOFMdZltiA9UkLhfdW7w7GAMMh6Il3Iyik3OEa/+1ENjwKvJZpjdVjrNc
	 JPSHwjycEOo6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 May 2026 17:00:50 +0200
Subject: [PATCH net 02/11] mptcp: pm: ADD_ADDR rtx: allow ID 0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-2-fca8091060a4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Bcs35Z3gYm7xwLE3VZxEnozcC4S4AZ2W+dU9mPhm5wk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ/sdlEfYzJmlnaz+dfoRGzXfCSRuWNWtfNC4u1vee8X
 Xwl/vHTjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlULWFkuOyn+PzvVP+wJfp9
 K/S+TF4tX3146drfjF9Yw7Svx+c0PGRkaJRzyPpvF9jJHCpufWcPO1/wrdMHZs6oe/1o27GdTwT
 /MgMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 392C64CFDF5
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
	TAGGED_FROM(0.00)[bounces-244181-lists,stable=lfdr.de];
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

ADD_ADDR can be sent for the ID 0, which corresponds to the local
address and port linked to the initial subflow.

Indeed, this address could be removed, and re-added later on, e.g. what
is done in the "delete re-add signal" MPTCP Join selftests. So no reason
to ignore it.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 57a456690406..5056eb8db24e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -337,9 +337,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
-	if (!entry->addr.id)
-		return;
-
 	if (mptcp_pm_should_add_signal_addr(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;

-- 
2.53.0


