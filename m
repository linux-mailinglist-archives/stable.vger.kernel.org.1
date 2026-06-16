Return-Path: <stable+bounces-263536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LfZjCS/KMGqkXQUAu9opvQ
	(envelope-from <stable+bounces-263536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:59:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F268BC88
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:59:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JiWb7Sbl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263536-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263536-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F6AD3022979
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24B73C1967;
	Tue, 16 Jun 2026 03:59:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967423C512
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:59:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781582360; cv=none; b=PjkZ8s0LJgrU8eYUsGWAXbmcIBsI9tJvJSH1M/vyv31OSZVhmrQ7coH0sKdnFW0V9/J8f0G5sO7ZOFCGFc7FBpbGi1hdmb8j3dTeZkYDOmZiDSApmNiuECzBdFuUEC34LEeyUJgwi91wWXAmtD1Va5zn0L7pD+230TjLRLB4LDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781582360; c=relaxed/simple;
	bh=L34TZaG1CUVgkDV70qyr7WmbibCSp0fzLCwFbSIScKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRObUG9VSTQW0Qbp8qhbDXc91oqemLuN/FXnFOR+URw5Y1iH/B70s6b+vCQlq5L2J0KuTPiqdmTue1C2ge+9BFYZt5+thssXbJw+sGLvxNcfHo807eVMjBwyEUBHI5JQyEVpehW1/TbUt8Kelhj8/OdOD/d0J0MZxgBWU/POLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiWb7Sbl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36891F000E9;
	Tue, 16 Jun 2026 03:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781582359;
	bh=1816sFV7Tx9wVvSCP7UoL0prADHo03NdjfpXZs4w48M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JiWb7Sbl4L1ZOE0DljFrnFjdujpbFjM+BLQCdFD/pBGCxdykDeWvB9sVaWT4NS6CZ
	 2Mlw/NYEsu2U0moeevcnQX2jjMsYvEMZOr3pjI41Q0RKnwORNtltnFOQ2ohzuzql4E
	 L7WwkPhHB/KmLu8wxPvOajeD5esuZCsAbKsSGrXlZiurh477LM5OEEvjAUZVxYsAgJ
	 SWNhsLYaBErLh7Q7pdWVSyW0gJ//GZymgCoJpQ9QeG4ToZhH6oHdMdx7GvOoqbm7dx
	 NNFYJkmWN2TAEDv4f3tJ5fmyfHrwjZ0IW3OSbsKu04UPccfEpg3lcjThNx9xR4cEl0
	 Lk3TUUhdXYgFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: fix missing wakeups in edge scenarios
Date: Mon, 15 Jun 2026 23:59:17 -0400
Message-ID: <20260616035917.2802898-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061537-frostbite-collide-666a@gregkh>
References: <2026061537-frostbite-collide-666a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263536-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:pabeni@redhat.com,m:matttbe@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 671F268BC88

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9d8d28738f24b75616d6ca7a27cb4aed88520343 ]

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-1-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 38550c44a20193..ccda3a7bcfd401 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2242,7 +2242,11 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	}
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
-	return !skb_queue_empty(&msk->receive_queue);
+
+	ret = !skb_queue_empty(&msk->receive_queue);
+	if (ret && mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+	return ret;
 }
 
 static unsigned int mptcp_inq_hint(const struct sock *sk)
-- 
2.53.0


