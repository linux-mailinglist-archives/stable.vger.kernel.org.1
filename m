Return-Path: <stable+bounces-213302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLCsMcpWgmntSQMAu9opvQ
	(envelope-from <stable+bounces-213302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:12:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0BEDE62B
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 066A130A70BE
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 20:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8674936997D;
	Tue,  3 Feb 2026 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNsbNWJn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F4368294
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149576; cv=none; b=emQg++NlLqCn8kQfcnpX0c9MaM3tMLct1CUhSZAmQy8X7TMFnLp7pZ0Yp6ed968W+mWe2HaMGUpuiCiJsn3OWPT7lz0tjJaW0n5X3+UysY7dMGFm9acqS8ibMhLqjTS0jwNd9LZ0G+kY/Ih+txVTaPqoOhOQeXTN3V0dM8Juwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149576; c=relaxed/simple;
	bh=JbrEjWohCf8J/nWyLoFrmYJldxd8NrXGLI6mqW5zXYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJ2B3PDaNiNZmSUAfFQY3s6nbCCjH/3jvNYU/KBlR6VLFaDylcIP9zLz6V6gdHm0a/NU4QbS29W5ZvvAD8GEFYMCGr3xo5IosI4tWND5ba+OnD+F9h80ESh4fBrnj3dwTL9tY7ZDjVqHUPpOC1kNExGfdkVGlfOyyCswIXL81OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNsbNWJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21A5C116D0;
	Tue,  3 Feb 2026 20:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770149575;
	bh=JbrEjWohCf8J/nWyLoFrmYJldxd8NrXGLI6mqW5zXYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNsbNWJn5pnK6ewQVXkB0Vuqy9rE7o+R6YMZhk35C7v0TD/FTANj9F8st1c21e4LI
	 5f2miN0L4wYnNO0a5uHetYUVinLj9E/9CYwt3+BTBu2nRKbd29VEoqv+ZECmMWviAJ
	 KWBdiJlzOXySvnBMxqTj6y/lqtwjhDGjQtuKwEyn6lEXjozZXlqakpinYNIynzheP/
	 XRzCiM0pilyVUcJOLBSgNfKkGO6ICWXat8px8EDBHqr3oMghOLidZS1As3lEbSWVTA
	 rgxMRkKYrYOAmZiQHftF8/dHg9s+l1Msg+WxL3AItqGD3BqX9DTVjCGy5cya69eBRC
	 +DTWm6sUcIXVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Marco Angaroni <marco.angaroni@italtel.com>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: avoid dup SUB_CLOSED events after disconnect
Date: Tue,  3 Feb 2026 15:12:53 -0500
Message-ID: <20260203201253.1382543-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020301-obscurity-amazingly-b0be@gregkh>
References: <2026020301-obscurity-amazingly-b0be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213302-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,italtel.com:email]
X-Rspamd-Queue-Id: 2A0BEDE62B
X-Rspamd-Action: no action

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 280d654324e33f8e6e3641f76764694c7b64c5db ]

In case of subflow disconnect(), which can also happen with the first
subflow in case of errors like timeout or reset, mptcp_subflow_ctx_reset
will reset most fields from the mptcp_subflow_context structure,
including close_event_done. Then, when another subflow is closed, yet
another SUB_CLOSED event for the disconnected initial subflow is sent.
Because of the previous reset, there are no source address and
destination port.

A solution is then to also check the subflow's local id: it shouldn't be
negative anyway.

Another solution would be not to reset subflow->close_event_done at
disconnect time, but when reused. But then, probably the whole reset
could be done when being reused. Let's not change this logic, similar
to TCP with tcp_disconnect().

Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Cc: stable@vger.kernel.org
Reported-by: Marco Angaroni <marco.angaroni@italtel.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/603
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260127-net-mptcp-dup-nl-events-v1-1-7f71e1bc4feb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 423243d0d27ab..4e3cad26b3b01 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2568,8 +2568,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
-	/* The first subflow can already be closed and still in the list */
-	if (subflow->close_event_done)
+	/* The first subflow can already be closed or disconnected */
+	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 		return;
 
 	subflow->close_event_done = true;
-- 
2.51.0


