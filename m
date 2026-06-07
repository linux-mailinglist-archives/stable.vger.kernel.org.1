Return-Path: <stable+bounces-261213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S4qlNWFGJWrjFgIAu9opvQ
	(envelope-from <stable+bounces-261213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:22:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B73464F95E
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:22:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="AwhpNo//";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261213-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261213-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 563F03013ED9
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02072FB97B;
	Sun,  7 Jun 2026 10:21:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D71A9F96;
	Sun,  7 Jun 2026 10:21:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827685; cv=none; b=VyxVc6lk7sktU0H4HJJ3hPjrT/Y+GdUKahXuI2Wrivo9TtZkIXnW+pnqPZIhRjD/JCNYDe+N0HEYq4IjFPB7XD2prZw13BTtModsG9dvZdNP0TQZ09DC6IYHD0GF2I2m8dho1UodXvFu96L+BB6TNdlOrcBqHoPVYXD36wW7e1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827685; c=relaxed/simple;
	bh=2TmfONdnWpHzccPvlKUvr4ANV8sXCwT7htpLMB/mlhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/EnyqQ0JtYbL7kqBzcr4yuFPMIab3fz0Uvfh67J+IdDrxDlApLUM8/BKkAXKbhmvbRFeZkSRSySdw4AtzhqTm0naJwiBa4/CmkPYrGfd3O3r7zHyoNeGUDjmTRcKbZ8qIwHO5LK4je1YNxd60UOpQe3Mrd6O+mDlZJntrBpWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AwhpNo//; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008C71F00893;
	Sun,  7 Jun 2026 10:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827684;
	bh=YetOzqFpGR1ZJjRZGliBu0aQNQV1c/bdXWqL5Ruc+UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AwhpNo//BjqGcocallI42DOw39zNtfbvY3+gZjw1d+L7D92LEe90GKvux8/zReTL4
	 cMM2wrAtPG2wtcQXF7VOZtxis89j+rIUoKpxmFfTUeLfUKsoVH2ZlgykwjQmsEfSzZ
	 kuNh3wYo5veOqHsPdt+4TX9q2VFxjDamzu1PQk/I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 066/307] ethtool: coalesce: cap profile updates at NET_DIM_PARAMS_NUM_PROFILES
Date: Sun,  7 Jun 2026 11:57:43 +0200
Message-ID: <20260607095730.180596106@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261213-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B73464F95E

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 7281b096b072f6c6e30420e3467d738f2e4c4b57 ]

ethnl_update_profile() walks the ETHTOOL_A_PROFILE_IRQ_MODERATION
nest list with an index 'i' and writes new_profile[i++] without
bounding i. The destination is kmemdup()'d at NET_DIM_PARAMS_NUM_PROFILES
entries (5), but the Netlink nest count is entirely user-controlled.
Netlink policies do not have support for constraining the number
of nested entries (or number of multi-attr entries).

Fixes: f750dfe825b9 ("ethtool: provide customized dim profile management")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260526153533.2779187-2-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/coalesce.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 3e18ca1ccc5ef6..cace02d964cb21 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -463,6 +463,12 @@ static int ethnl_update_profile(struct net_device *dev,
 
 	nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION,
 				 nests, rem) {
+		if (i >= NET_DIM_PARAMS_NUM_PROFILES) {
+			NL_SET_BAD_ATTR(extack, nest);
+			ret = -E2BIG;
+			goto err_out;
+		}
+
 		ret = nla_parse_nested(tb, len_irq_moder - 1, nest,
 				       coalesce_irq_moderation_policy,
 				       extack);
-- 
2.53.0




