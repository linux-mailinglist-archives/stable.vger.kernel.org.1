Return-Path: <stable+bounces-249432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJaEG727C2q3LgUAu9opvQ
	(envelope-from <stable+bounces-249432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:24:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1714A57606E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E7633041A02
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D4248F62;
	Tue, 19 May 2026 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/GabZSf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3BEEA8
	for <stable@vger.kernel.org>; Tue, 19 May 2026 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153766; cv=none; b=OefOblO5iaPNahdsruH/LviKPNaZbhwQkA7i8U15/6aA9hIEoAy0oARoeCcsWHsLh+mw6v6GeaqRVbDJ+1X0Yj5HCO0I9QSj2XWEiI6UxvLwHA+MX68w6uiR3IVNtFdQtFrAHnT1jjy0IVW+6+0wajjOnyJSqVezyU929IhthmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153766; c=relaxed/simple;
	bh=hieqZPCYXxdqXS7WlrIvgT/G5tRBSgO35mlbhUrsnd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggsCErDR97PNHBsjQZQxVXzQvNzFaf/aPDdzHyk2JZR25nT7klbiJIaVjOmcwLQs1wwCR5j6YPKRWGd/nqYseQB14ur7dXdGtM2/erCIhQJX4FtY7/ncfNMusTyD7K2ZtH5UrFsbx5FEZgd1f0TEzk0N7cRiJxb1SP+/Bnci7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/GabZSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599B9C2BCB7;
	Tue, 19 May 2026 01:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779153765;
	bh=hieqZPCYXxdqXS7WlrIvgT/G5tRBSgO35mlbhUrsnd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/GabZSf4irtfgeEWipSMHH6U3pMjEIzJsYAkMaxQwf6ZexwTL2mEx0sQPyH/Vjku
	 fpJW6ac2fn65O9uPlhzSyPdiOBya31rYiy7oF/nrOXmIS0vQoRli7sk7N3Bn+giSX2
	 qelEbYC02pr7q808qYJkt6IzSP7VGArIQYUYQevmdGYrRKv6GIJKRT42smhrZvD0Wb
	 Zeu7GJWQJa7c4R2iImd26I/R+boSesZOKTE7k1CQpDg0JPK5K9v463prtcgxTBPMxt
	 JYErsEUTKNNsUASltdW90HNlWsq8JhR9nD3V85V/fkjEgzvEtgUV97HzgNWVpW+EHO
	 NG4vkwT9azRXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mptcp: pm: ADD_ADDR rtx: allow ID 0
Date: Mon, 18 May 2026 21:22:43 -0400
Message-ID: <20260519012243.2020041-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051201-lumber-mullets-8690@gregkh>
References: <2026051201-lumber-mullets-8690@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249432-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1714A57606E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 03f324f3f1f7619a47b9c91282cb12775ab0a2f1 ]

ADD_ADDR can be sent for the ID 0, which corresponds to the local
address and port linked to the initial subflow.

Indeed, this address could be removed, and re-added later on, e.g. what
is done in the "delete re-add signal" MPTCP Join selftests. So no reason
to ignore it.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-2-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied the 3-line deletion to net/mptcp/pm_netlink.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b88246b8f21c1..bcff6b0b2e8fc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -223,9 +223,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
-	if (!entry->addr.id)
-		return;
-
 	if (mptcp_pm_should_add_signal(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;
-- 
2.53.0


