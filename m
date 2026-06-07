Return-Path: <stable+bounces-261060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kf58M0ZFJWouFgIAu9opvQ
	(envelope-from <stable+bounces-261060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:17:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE0864F7B1
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:17:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=WXgQa2F4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261060-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261060-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C5DA3059A65
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC59330CD80;
	Sun,  7 Jun 2026 10:12:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC181303CAE;
	Sun,  7 Jun 2026 10:12:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827127; cv=none; b=Dcym/x9Fg5Ci9ybimFLVhAj+BHpl/DKDyFU39Jov6ZKmEo262qRqYrC87c7bmQ80uum9DtUZKBuLjsQaaBIzTfgmKO82FSvyXLdSPkfBmFquGXxt23UZPqC4JbBWx9M/sz6bqO0O7ZfbtO2Cvd/+BagwvlPfNxN4tqpQqgVjEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827127; c=relaxed/simple;
	bh=4qVVScQMlBHclMKvxdeVjxvr/SuTK4wtJbf/ll4EoLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIOMPOlZtstqIBEVS5cZcKh9VdcBCdqAQd5DiBKo4Y83IfxrUAXNMuZ3jUDih0okl9zljrqFXzUDxSkVmhzbGu6uTnLmtlEhxaPnCRlzfJ4wuwjNzBqv3CX8So4eqmBCb7B0gHAJj5/v7d64JMiJGveQiavh2jV18n7jymS574w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WXgQa2F4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAC91F00893;
	Sun,  7 Jun 2026 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827126;
	bh=eS9+2mBHusBQwx1ZlRm7kP1IX8b1OvC6O5DkbQrpxSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WXgQa2F4UZMGgnLxm0gI/+qSwRiu9a67B1b2BuT1gk2Qp5s26F7/qbf05SV+P0Hg4
	 IaJBOBv0OsvlAeadZqZDCXyGv8MibIwXBhwBw6B3RypmbEGj5vwGS7cALWJ2IKJFGw
	 ANoxm99txLd8u+UBO8SaYeU0tSqyJ4C3V3+ud93o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 042/315] ethtool: rss: fix hkey leak when indir_size is 0
Date: Sun,  7 Jun 2026 11:57:09 +0200
Message-ID: <20260607095729.106435913@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261060-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AE0864F7B1

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 78ccf1a70c6378e1f5073a8c2209b5129067b925 ]

rss_get_data_alloc() allocates a single buffer that backs both the
indirection table and the hash key, but only assigned data->indir_table
when indir_size was nonzero. The expectation was that no driver
implements RSS without supporting indirection table but apparently
enic does just that (it's the only such in-tree driver).
enic has get_rxfh_key_size but no get_rxfh_indir_size.
data->indir_table stays as NULL, hkey gets set but rss_get_data_free()
kfree(data->indir_table) is a nop and the allocation leaks.

Always store the allocation base in data->indir_table so the free path
is unambiguous. No caller treats indir_table as a sentinel; everything
keys off indir_size.

Fixes: 7112a04664bf ("ethtool: add netlink based get rss support")
Link: https://patch.msgid.link/20260522230647.1705600-6-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/rss.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 5416aec13b7fe7..f745ddec6fbab8 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -132,8 +132,7 @@ rss_get_data_alloc(struct net_device *dev, struct rss_reply_data *data)
 	if (!rss_config)
 		return -ENOMEM;
 
-	if (data->indir_size)
-		data->indir_table = (u32 *)rss_config;
+	data->indir_table = (u32 *)rss_config;
 	if (data->hkey_size)
 		data->hkey = rss_config + indir_bytes;
 
-- 
2.53.0




