Return-Path: <stable+bounces-15052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAFA83849F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E94AB2C593
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60BC64A8A;
	Tue, 23 Jan 2024 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ffk+aqLR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F08634FB;
	Tue, 23 Jan 2024 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975038; cv=none; b=kC/ID/8OJxwRB4hugSLI0ykuiSeroTBv2wpoyvIY8/2PySNCNvunLJRQVj9H0R/kGM+/gJ/7m/gIwFAFa0kAwtUna0K0CJYnVnUCEa4A8Vhy2tVlZyOp0oZGQKRcoJUZrx3v7F+tVawOgAJVzwljPKRCSpYDjH9W3U1bcIm92nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975038; c=relaxed/simple;
	bh=K9n71+0B4hMsspnxMt9xW4qXfZucKAvtbY29GDFa7ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id7gbL8hfzCWaALDdzyYnTtrc8q5iEIK9KK6WqqifbNPiNc9wNTT5oHiHPx65t2sjRp8cbwBRaPlOa4ms6TXhqAmdoXPhfYdMsHj3PYeqS+d0bfjk9G7/xut/SXqmoDRzD9XQtGQzDw2OV4WY2zk0BvdnP8FrTVpdtUnfCqsbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ffk+aqLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27607C43399;
	Tue, 23 Jan 2024 01:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975038;
	bh=K9n71+0B4hMsspnxMt9xW4qXfZucKAvtbY29GDFa7ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ffk+aqLRIzT74XAEkoiF1JQ8xtYVD9be/GlUv+QfCIwLzfSL0vSQz6892AVmNSHl2
	 SGPmE5i66CeFQ1wB+MTrUWe8AN7OHDcbosaLgP404A5tzaoGp1Dv4eFzs4oeO0f/es
	 cP1uq31Y6pKTkSzbrrTR/YwzSJRx0KTTz3bqo54Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>,
	Peter Krystad <peter.krystad@linux.intel.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang.tang@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 335/374] mptcp: mptcp_parse_option() fix for MPTCPOPT_MP_JOIN
Date: Mon, 22 Jan 2024 15:59:51 -0800
Message-ID: <20240122235756.561882512@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 89e23277f9c16df6f9f9c1a1a07f8f132339c15c ]

mptcp_parse_option() currently sets OPTIONS_MPTCP_MPJ, for the three
possible cases handled for MPTCPOPT_MP_JOIN option.

OPTIONS_MPTCP_MPJ is the combination of three flags:
- OPTION_MPTCP_MPJ_SYN
- OPTION_MPTCP_MPJ_SYNACK
- OPTION_MPTCP_MPJ_ACK

This is a problem, because backup, join_id, token, nonce and/or hmac fields
could be left uninitialized in some cases.

Distinguish the three cases, as following patches will need this step.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Peter Krystad <peter.krystad@linux.intel.com>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang.tang@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20240111194917.4044654-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 012e0e352276..c7d6997b31c8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -118,8 +118,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_JOIN:
-		mp_opt->suboptions |= OPTIONS_MPTCP_MPJ;
 		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
+			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYN;
 			mp_opt->backup = *ptr++ & MPTCPOPT_BACKUP;
 			mp_opt->join_id = *ptr++;
 			mp_opt->token = get_unaligned_be32(ptr);
@@ -130,6 +130,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->token, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_SYNACK) {
+			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYNACK;
 			mp_opt->backup = *ptr++ & MPTCPOPT_BACKUP;
 			mp_opt->join_id = *ptr++;
 			mp_opt->thmac = get_unaligned_be64(ptr);
@@ -140,11 +141,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->thmac, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_ACK) {
+			mp_opt->suboptions |= OPTION_MPTCP_MPJ_ACK;
 			ptr += 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
 			pr_debug("MP_JOIN hmac");
-		} else {
-			mp_opt->suboptions &= ~OPTIONS_MPTCP_MPJ;
 		}
 		break;
 
-- 
2.43.0




