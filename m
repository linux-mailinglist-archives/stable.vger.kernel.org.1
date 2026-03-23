Return-Path: <stable+bounces-229893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCV7DHV+wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:55:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1BE2FA9DD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3850311C998
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB9A3AE6F8;
	Mon, 23 Mar 2026 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bxRleNBs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F937B02A;
	Mon, 23 Mar 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283147; cv=none; b=aKNoYDKR+7E3FS2+4bqgy92b3FhVqGoKH5k2vFY004WsZVyfR5inEHQbONcKhvYI9GZdqGXTmHb0b2prl9ZP/1SmkVIML45C6NghwblXfKL8x/GIlEEB7em1XjDrRQ1cIis+Qd4BDDTcYuYo/KDQJUsZKf2m4BzxBgJbR3CL+XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283147; c=relaxed/simple;
	bh=wQiiuc3vLB9GpJ+jH1nAkKYS7UBS1tgrLrsqd4LsDRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFf/07I7HZTUd2TiR0oXGhdO4/ya64BwyG3W3INHwiaoULYXcJZUaZmfor7PKG++R6Zroby6CEqILOAKK/S/rqxFMjH4LsVG6/v+WC8cFn054TV3/mzvr8LgYpHX325zVh483RGN8zDuhkwcFg07yjtuHI8qCjsUF4W1JF9ZQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bxRleNBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A884C2BC9E;
	Mon, 23 Mar 2026 16:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283146;
	bh=wQiiuc3vLB9GpJ+jH1nAkKYS7UBS1tgrLrsqd4LsDRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxRleNBsJWHOG9j/8C0H/nSOd8G9bRpbDfDRif/vhNGdFSfbt2Uy5rvkZshevP5ku
	 o8xZPwbqibzfufUb3F4YOz3tilvxSSrpTLu+ZA1p27h1Fqi9TPgJdGypX1kriyOc0w
	 7P1P3WNU7v3rcx+16yEmkXNGL/VUYoaivGcYK1RI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 417/481] netfilter: xt_CT: drop pending enqueued packets on template removal
Date: Mon, 23 Mar 2026 14:46:39 +0100
Message-ID: <20260323134535.353063093@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,netfilter.org,strlen.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-229893-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.912];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,strlen.de:email]
X-Rspamd-Queue-Id: 7F1BE2FA9DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit f62a218a946b19bb59abdd5361da85fa4606b96b ]

Templates refer to objects that can go away while packets are sitting in
nfqueue refer to:

- helper, this can be an issue on module removal.
- timeout policy, nfnetlink_cttimeout might remove it.

The use of templates with zone and event cache filter are safe, since
this just copies values.

Flush these enqueued packets in case the template rule gets removed.

Fixes: 24de58f46516 ("netfilter: xt_CT: allow to attach timeout policy + glue code")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_CT.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/xt_CT.c b/net/netfilter/xt_CT.c
index 3ba94c34297cf..498f5871c84a0 100644
--- a/net/netfilter/xt_CT.c
+++ b/net/netfilter/xt_CT.c
@@ -16,6 +16,7 @@
 #include <net/netfilter/nf_conntrack_ecache.h>
 #include <net/netfilter/nf_conntrack_timeout.h>
 #include <net/netfilter/nf_conntrack_zones.h>
+#include "nf_internals.h"
 
 static inline int xt_ct_target(struct sk_buff *skb, struct nf_conn *ct)
 {
@@ -283,6 +284,9 @@ static void xt_ct_tg_destroy(const struct xt_tgdtor_param *par,
 	struct nf_conn_help *help;
 
 	if (ct) {
+		if (info->helper[0] || info->timeout[0])
+			nf_queue_nf_hook_drop(par->net);
+
 		help = nfct_help(ct);
 		xt_ct_put_helper(help);
 
-- 
2.51.0




