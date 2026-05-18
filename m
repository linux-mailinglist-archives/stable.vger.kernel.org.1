Return-Path: <stable+bounces-249315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPstOn4qC2pAEAUAu9opvQ
	(envelope-from <stable+bounces-249315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:04:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7081C56F839
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58833340DAA9
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE8B26A1AC;
	Mon, 18 May 2026 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/81NSGY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F551F4C96
	for <stable@vger.kernel.org>; Mon, 18 May 2026 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115657; cv=none; b=EieTloQHkEfKkS8sMSDGQk28A+C4KJftEokbOOfZuAwD91BCu7iGNgWWJJy+8++/KO786kZt+0VbY5YHioVRnkhZuDkePfTJe2klMCis7YuDEIvL03/Q17yFXZj7QqwQPAWagtIiI1LHfXg6Ak7+aRXmEJIBId1DE+ytqjUYxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115657; c=relaxed/simple;
	bh=WQy72p4tLQcoVeD28VSgqlSlJ2+9Dzc3ZQY8Upg06Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yx4GxOHpFoioeInhySyFBOUxYX8PUyBkLpI+abWvUPwYzuvzToRmqK9dCmB2EuWyyOnTB34ivMsVkX66CvUruPQ6+033dZnUbSepAWCcex42So2BNAzGmb52LuyY9RsD2gWxpxyEjJhn8R7NCGUaSZVPC1HEJuR/40X9YoXC8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/81NSGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D174AC2BCB7;
	Mon, 18 May 2026 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779115657;
	bh=WQy72p4tLQcoVeD28VSgqlSlJ2+9Dzc3ZQY8Upg06Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/81NSGYtH7eWiyHmiKss/y+3JqwLzgEIbBJyD44WxepAtSbHrlvWmt3RJ/S11X3K
	 WhWP6/X8G154FknuHqqAPc8v/QMBoZb7SLaJ7RELvN3F/ujmx+vum/2WMt3i5NVISp
	 QnOubmZh2nEjy8JMv0POuXgyBWVXcg/iAURIRzs+5pL1RMbZKXI0G0GeR38XpZN4gm
	 4Xyzx2jcmGdjOCCyDwytoPg0hQ5LXbvohGeVvs4Zc2zBNtMWlVPHTmyxrdT9R54OPX
	 vQLiBpsEaJ2qEbOY8Dq6i2S/Oqyqkpy2ckQV8qf9CP4YyQ0Z4iPPgyv81jW/HpD/2b
	 /xOxNGFW7SQnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
Date: Mon, 18 May 2026 10:47:34 -0400
Message-ID: <20260518144734.1381693-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051230-anime-juniper-5ad1@gregkh>
References: <2026051230-anime-juniper-5ad1@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249315-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7081C56F839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 9634cb35af17019baec21ca648516ce376fa10e6 ]

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
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-4-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ reused existing `out:` label instead of introducing a new `exit:` label since stable's `out:` only does `__sock_put(sk)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3ac09bfe6e4b2..74eb91ff2a87c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -298,11 +298,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto out;
 
 	if (!entry->addr.id)
 		return;
-- 
2.53.0


