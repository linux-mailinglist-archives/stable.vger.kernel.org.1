Return-Path: <stable+bounces-265067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ZzqHTiEMWqclQUAu9opvQ
	(envelope-from <stable+bounces-265067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:13:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA62692E0B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:13:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sB8bpsCr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265067-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265067-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42BE1304C415
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C84779B1;
	Tue, 16 Jun 2026 17:01:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E335675A;
	Tue, 16 Jun 2026 17:01:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629310; cv=none; b=BwqU2ZgxHyh1z0fpoPDQ8p1uNOopKDiqK26FJssivv/azfFF5HTAkcSYDAsV0q+4mNHq7NwNoj0Q65r6OjPFrDtekpJlkJ4GE1qV+2TBqKboENO7T5hvV8RUW9Araxu/T4ASyJrCQCtgEmPwUlmcaesYkx169GjNEDCWfigz+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629310; c=relaxed/simple;
	bh=6bBgO2TwxbBCqUfyT3xiJMZisaDrht65Fl00f5jobCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCbNJPZYshwqWaPKtrlt2/1VAtSOqVwxapp/+PDOpSnb76LVmhq2ZVk2uSiB6eLhvMIjRaWLyCZU36v4/+zE0rdhGzEmZu57trBXoDHwKslXwXrOvbRRa0vcX4fVtYy9jVgIsapJBRoEa6FMsysx/Gnayg+Xo6HD3DEcRJ8kMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sB8bpsCr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8A51F000E9;
	Tue, 16 Jun 2026 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629308;
	bh=G8/8eZHM63Mc4z/0qlGkEU8nytMh7vRp/HpR4VcHbiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sB8bpsCrQncvK1yl6y0cpx2c2zA98SCKBQgaYrf8523MNWMN27TP2IJF3Hi/SLDP2
	 g/Js95P4rloAg0EIQkufYzO0wYV6Qfnda7AXxoWrQciD32V8SlkflBdSmh4mHp3bd8
	 AeA/RuL6WpqQDKvEefuq9FNIvXOubbvOL3DhSUp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 261/452] netlabel: validate unlabeled address and mask attribute lengths
Date: Tue, 16 Jun 2026 20:28:08 +0530
Message-ID: <20260616145131.326335663@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265067-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zhaochenguang@kylinos.cn,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CA62692E0B

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

[ Upstream commit 9772589b57e44aedc240211c5c3f7a684a034d3a ]

netlbl_unlabel_addrinfo_get() used the address attribute length to
determine whether the attribute data could be read as an IPv4 or IPv6
address, but did not independently validate the corresponding mask
attribute length.  A crafted Generic Netlink request could therefore
provide a valid IPv4/IPv6 address attribute with a shorter mask
attribute, which would later be read as a full struct in_addr or
struct in6_addr.

NLA_BINARY policy lengths are maximum lengths by default, so use
NLA_POLICY_EXACT_LEN() for the unlabeled IPv4/IPv6 address and mask
attributes.  This rejects short attributes during policy validation and
also exposes the exact length requirements through policy introspection.

Fixes: 8cc44579d1bd ("NetLabel: Introduce static network labels for unlabeled connections")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlabel/netlabel_unlabeled.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 9996883bf2b78d..6007cb000da678 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -114,14 +114,14 @@ static struct genl_family netlbl_unlabel_gnl_family;
 /* NetLabel Netlink attribute policy */
 static const struct nla_policy netlbl_unlabel_genl_policy[NLBL_UNLABEL_A_MAX + 1] = {
 	[NLBL_UNLABEL_A_ACPTFLG] = { .type = NLA_U8 },
-	[NLBL_UNLABEL_A_IPV6ADDR] = { .type = NLA_BINARY,
-				      .len = sizeof(struct in6_addr) },
-	[NLBL_UNLABEL_A_IPV6MASK] = { .type = NLA_BINARY,
-				      .len = sizeof(struct in6_addr) },
-	[NLBL_UNLABEL_A_IPV4ADDR] = { .type = NLA_BINARY,
-				      .len = sizeof(struct in_addr) },
-	[NLBL_UNLABEL_A_IPV4MASK] = { .type = NLA_BINARY,
-				      .len = sizeof(struct in_addr) },
+	[NLBL_UNLABEL_A_IPV6ADDR] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[NLBL_UNLABEL_A_IPV6MASK] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[NLBL_UNLABEL_A_IPV4ADDR] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct in_addr)),
+	[NLBL_UNLABEL_A_IPV4MASK] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct in_addr)),
 	[NLBL_UNLABEL_A_IFACE] = { .type = NLA_NUL_STRING,
 				   .len = IFNAMSIZ - 1 },
 	[NLBL_UNLABEL_A_SECCTX] = { .type = NLA_BINARY }
@@ -764,24 +764,14 @@ static int netlbl_unlabel_addrinfo_get(struct genl_info *info,
 				       void **mask,
 				       u32 *len)
 {
-	u32 addr_len;
-
 	if (info->attrs[NLBL_UNLABEL_A_IPV4ADDR] &&
 	    info->attrs[NLBL_UNLABEL_A_IPV4MASK]) {
-		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
-		if (addr_len != sizeof(struct in_addr) &&
-		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV4MASK]))
-			return -EINVAL;
-		*len = addr_len;
+		*len = sizeof(struct in_addr);
 		*addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
 		*mask = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4MASK]);
 		return 0;
 	} else if (info->attrs[NLBL_UNLABEL_A_IPV6ADDR]) {
-		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
-		if (addr_len != sizeof(struct in6_addr) &&
-		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV6MASK]))
-			return -EINVAL;
-		*len = addr_len;
+		*len = sizeof(struct in6_addr);
 		*addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
 		*mask = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6MASK]);
 		return 0;
-- 
2.53.0




