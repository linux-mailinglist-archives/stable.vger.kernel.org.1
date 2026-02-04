Return-Path: <stable+bounces-213859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C1QC1lkg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:23:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8167FE8671
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D33F430A6E19
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53F426ED1;
	Wed,  4 Feb 2026 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WiLwVMtT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123D410D16;
	Wed,  4 Feb 2026 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217753; cv=none; b=g+MvmPYo1uQcvmGZjtVfJdqT1W6pIWCwWpv3pjVVGb1+B+aZ1HdQItKm6LXDEcxPCowQg3l+01TJLXGNybwkMoArFoLnyrzl3KRGRg/jSZAcx9a7+bjvCF+u5MwXhwAvx5cDs1eGDnG+3mxssKDDod5fhvjDrCmJ7zA7adPd6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217753; c=relaxed/simple;
	bh=sU974zhQPlRQtKjVnAuEySW7yDArV7oYlAxCfgSY6LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFJqlyUFDg3iAi/yC4advAPH42Pxyjuyq1kT8TJ8JiBkwLNUosmiljKSox8qsrZNMWNIjKwyZKgUUuXFqkdC3qdSiL+igpsRgJZkujXjVv+Yc0SoAaDwciq92I9lBaDU4lT5tqgwIH2JE2hUH94Q/3AMVE8+tkEMh2+LqgQn/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WiLwVMtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12C1C4CEF7;
	Wed,  4 Feb 2026 15:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217753;
	bh=sU974zhQPlRQtKjVnAuEySW7yDArV7oYlAxCfgSY6LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WiLwVMtT5PqQxHjAnNUIC6HD9cfzYCF3+G3yM2OMy/eSqAwF7d/hR+lmGfx/D7+WV
	 GTwLy119BxPc70yxXsIh1d1KaisevaK8puG/zNe2/8hEok6C9GHoa8Qop4e3njgMn2
	 I/QxHiz/TPCgz4XFVpE4tha6jKbgCmyUigANs7Zc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 108/280] fou: Dont allow 0 for FOU_ATTR_IPPROTO.
Date: Wed,  4 Feb 2026 15:38:02 +0100
Message-ID: <20260204143913.533518977@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213859-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8167FE8671
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 7a9bc9e3f42391e4c187e099263cf7a1c4b69ff5 ]

fou_udp_recv() has the same problem mentioned in the previous
patch.

If FOU_ATTR_IPPROTO is set to 0, skb is not freed by
fou_udp_recv() nor "resubmit"-ted in ip_protocol_deliver_rcu().

Let's forbid 0 for FOU_ATTR_IPPROTO.

Fixes: 23461551c0062 ("fou: Support for foo-over-udp RX path")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260115172533.693652-4-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/fou.yaml | 2 ++
 net/ipv4/fou_nl.c                    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 266c386eedf3a..e5753a30a29a2 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -36,6 +36,8 @@ attribute-sets:
       -
         name: ipproto
         type: u8
+        checks:
+          min: 1
       -
         name: type
         type: u8
diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
index 6c3820f41dd5d..5bb8133ed7a89 100644
--- a/net/ipv4/fou_nl.c
+++ b/net/ipv4/fou_nl.c
@@ -14,7 +14,7 @@
 const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
 	[FOU_ATTR_PORT] = { .type = NLA_U16, },
 	[FOU_ATTR_AF] = { .type = NLA_U8, },
-	[FOU_ATTR_IPPROTO] = { .type = NLA_U8, },
+	[FOU_ATTR_IPPROTO] = NLA_POLICY_MIN(NLA_U8, 1),
 	[FOU_ATTR_TYPE] = { .type = NLA_U8, },
 	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .type = NLA_FLAG, },
 	[FOU_ATTR_LOCAL_V4] = { .type = NLA_U32, },
-- 
2.51.0




