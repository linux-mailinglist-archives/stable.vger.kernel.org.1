Return-Path: <stable+bounces-241435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNNTELG/72mLFQEAu9opvQ
	(envelope-from <stable+bounces-241435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:57:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A75684799B7
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09CF63052713
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CA0421F05;
	Mon, 27 Apr 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phhMefp/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B5421F00;
	Mon, 27 Apr 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319694; cv=none; b=DJHd4StlDVQQO6//W9Nmx5EeuDSoeDw40C3dPD0y9K9lHfb36OWFRsqYUV3l2t05uZwG8aV82mgzOffLkVl53FrEpi55sFmEcnww4xpoW6+B/pkmr7ubUtU3eUcU5+ZeGfzWbwHs2zK35DUJzkp+RGJvHA8hz9dxnqPPX3FXuAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319694; c=relaxed/simple;
	bh=przPaxcMyBQzUmg2GX2M3OT2M/7tS8ONkDW/LqeDsoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdSLmEIN81Lxi1UOubMdP3g0pEPjN/cFWrUy5F/9ukU0ffQPlJKgergz4649a0/L6zXguBUte3Lz7e7jzP3rDUtMF1Ii0SHxS7kBt8wX7e4dP2tq5MqMZqCvqwObpMZ5GCidE9TH/mYg929ztGrG1mjyG77QVzlr+WTsLG98Bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phhMefp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F413EC2BCB7;
	Mon, 27 Apr 2026 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319694;
	bh=przPaxcMyBQzUmg2GX2M3OT2M/7tS8ONkDW/LqeDsoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=phhMefp/bubG1wz7S69WSbqk2q9hthM4+xhqV8oyp/3VIXb+nsgE4CTpfO8I5nP01
	 YIAAIdWDfhSOeimUtGYHSQxDGKNl+efO60p/rDmDix2mFad5uAohHZlbQqrZdqgpq+
	 viiKxt8okhLVdGsthpCpBdoNy0XtePLbYQSmRbDRzEwKBphgPDoqKh+FDXw7AQYpU+
	 WJdwXsi+ESkkfcBZnhlmX/Q3k9Dw6EIy4Jksdr2+6Rvn9HrFAbUA6dBNWgj6E8Qwzl
	 qTbH9Ly2kysB5U3IiD/C+dtrA7/lZ7qsfnNzeKqvPeO6c5B+HHux308408BlGcDciP
	 Z3yuEivMMHWDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Apr 2026 21:54:36 +0200
Subject: [PATCH net 4/4] mptcp: pm: kernel: reset fullmesh counter after
 flush
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-4-7432b7f279fa@kernel.org>
References: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
In-Reply-To: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=przPaxcMyBQzUmg2GX2M3OT2M/7tS8ONkDW/LqeDsoE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLf72fgsAvJVZ6SxHpSN1d0RQ6vm0/JW54d66pP/jqg4
 S4vu/5xRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEREvjEybD1hnKrt+kp5v+e/
 jHcNRl9qFy0XNo5Je2jzsrd/tmzvBIZ/OjVrlLYEyDF4vVFxX3Bjq4LK56j8gviXEla/lZ78Wru
 PFQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: A75684799B7
X-Rspamd-Action: no action
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
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241435-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]

This variable counts how many MPTCP endpoints have a 'fullmesh' flag
set. After having flushed all MPTCP endpoints, it is then needed to
reset this counter.

Without this reset, this counter exposed to the userspace is wrong, but
also non-fullmesh endpoints added after the flush will not be taken into
account to create subflows in reaction to ADD_ADDRs.

Fixes: f88191c7f361 ("mptcp: pm: in-kernel: record fullmesh endp nb")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260422-mptcp-inc-limits-v6-0-903181771530%40kernel.org?part=15
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 0ebf43be9939..c9f1e5af3cd3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1278,6 +1278,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->endp_subflow_max, 0);
 	WRITE_ONCE(pernet->endp_laminar_max, 0);
+	WRITE_ONCE(pernet->endp_fullmesh_max, 0);
 	pernet->endpoints = 0;
 }
 

-- 
2.53.0


