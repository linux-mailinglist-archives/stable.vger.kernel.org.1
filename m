Return-Path: <stable+bounces-249293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP7MAucZC2reDQUAu9opvQ
	(envelope-from <stable+bounces-249293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:53:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA4756E13B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9E5330C3505
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD41DC9B5;
	Mon, 18 May 2026 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZeBNj4j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2851FBEA8
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111956; cv=none; b=bWd10FovYnZa9DnaJn6VXQmyD8uGKYZTFHj0mW7VPfBW6gWj/1cCkWHUVryIq4YaB0yKXd7Pf4B0vdZfbH825v5e603HOQQjJTZoB0Vcy3Ro9my+jDC/kUezkxacUw7MtoIvefwF5nIx7NUaImpF6oC80nKiFB82IulRAneychM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111956; c=relaxed/simple;
	bh=dqZ1XQfdK6ZwoUQc1t/uQ2J3IfS2qurbEVnC+CFRlHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hK4YW0NeigoCxEA4pUuNNIasMo3TJb3SQ2JS3tm+jmsgbplCtPCSP7mLKMj+LS3ep7mbYgT3Mqv1IHEo9P5zCimLlTitdg7KLKjB4XCOIgAYZVN6J6lB4TRxWOpU4wrj0zxUX8sOLWob9qCrpsqS6mPASAJ5xvj0qHrs/m9YZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZeBNj4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C385C2BCB7;
	Mon, 18 May 2026 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111956;
	bh=dqZ1XQfdK6ZwoUQc1t/uQ2J3IfS2qurbEVnC+CFRlHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZeBNj4jwmZva7MxGHqJDSQcuIrlgyQBlFWf9om/sCJV5QwsIS3RLuEG5/TpDr7VV
	 Z24REWwRlC2+bntf3Fm5C1TGTO+G72J+QsFDF6Mk76VvPZbaacFppn8/aAWCVuVvOS
	 MdAjOfn2j19rmeJrwK6COgGKC2tzJFf81o6itfQyrCX0X98mE/2dTv2X0xAObpQQjl
	 1a0ZgvSXYJF+yOWYplNYJXJDIe04BQwZrzEqyf8Yc63n1HG+ylElzIeM1xccT7gmps
	 0di63GeULYjjjbhLxW3VbjJaD8eS45yMKVOnUa5h619ZLL1wnFh5cwVcd+uZfy0B21
	 fp9/XtfWYKakA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: ADD_ADDR rtx: allow ID 0
Date: Mon, 18 May 2026 09:45:52 -0400
Message-ID: <20260518134552.1136532-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051200-safehouse-jumbo-e3af@gregkh>
References: <2026051200-safehouse-jumbo-e3af@gregkh>
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
	TAGGED_FROM(0.00)[bounces-249293-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 5FA4756E13B
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
[ relocated the 3-line deletion from net/mptcp/pm.c to net/mptcp/pm_netlink.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3ac09bfe6e4b2..6781fedf71734 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -304,9 +304,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
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


