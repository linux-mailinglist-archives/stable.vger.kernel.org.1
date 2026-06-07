Return-Path: <stable+bounces-261009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R48gEAhEJWqWFQIAu9opvQ
	(envelope-from <stable+bounces-261009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:12:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87864F66D
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:12:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=jYqoH2Rz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261009-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261009-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 677483015892
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065BF2E7F0A;
	Sun,  7 Jun 2026 10:09:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7081E98E3;
	Sun,  7 Jun 2026 10:09:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826953; cv=none; b=sFID5XAjoXpenEoYRK6Wxy4AmwKPSosQP5WjKRCIuF+KmOAyWVyvAn1EyMfL0TAbkcTzUQC7Aw8hxDsuWcHUgEeyCSpQBanNexOVDwddPZPc3qRL+WFm/wmp0hJClJesJbRaSPo0eomvQ3EXO3ZXuIWYekLHP3522q0HMQ1G6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826953; c=relaxed/simple;
	bh=yyCOTOjEQEmcKrtRBs5LOetrG43RhGwkAnu/vUNtlZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnGEOpP1Srj+Oo67SlBTsWra+k8bBqeqjZSGNuJLKiTXUHpH7ZwwEmQ74QIoCND4QxM2SKg8sZ5sqD4C24gIqMD0/1e9Yz0Px56gZYL4s2nRpATkQ7HfeuArrxZ0vVxquBfs/AuKn6DDiWwHggFrVijNPPZxQjilLYnSh2z6P4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jYqoH2Rz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFA31F00893;
	Sun,  7 Jun 2026 10:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826952;
	bh=r0RbwX4QP9QQkMfIlkaF3B19w7PUJkndIAzOWpwIhb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jYqoH2Rzw7tHvfko2ZE3wOdDMkjlHwxYhlvN7SEOYFPa5EvVFxZaPVKfo9hx7lGz9
	 7C5aSxIm2pLqXlhvoZoWbcMLanmRbSno9XgaVeI9Y72MuFIsKDQQmZEL7C7lXYXrLL
	 XMDMpzdFsdzh1xXGO5uiguEyUI0vxWi1psyf/YDk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 046/332] ethtool: rss: avoid device context leak on reply-build failure
Date: Sun,  7 Jun 2026 11:56:55 +0200
Message-ID: <20260607095729.809666421@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261009-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A87864F66D

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 32a9ecde62731c9f7412507709192c84dafc38d1 ]

We wait with filling the reply for new RSS context creation
until after the driver ->create_rxfh_context call. The driver
needs to fill some of the defaults in the context. The failure
of rss_fill_reply() is somewhat theoretical, but doesn't take
much effort to handle it properly. Call ->remove_rxfh_context().

If the driver's remove callback fails (some implementations like sfc
can return real command errors from firmware RPCs) - skip the xa_erase
and kfree, leaving the context in the xarray. This matches how
ethnl_rss_delete_doit() behaves.

Fixes: a166ab7816c5 ("ethtool: rss: support creating contexts via Netlink")
Link: https://patch.msgid.link/20260522230647.1705600-7-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/rss.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index f745ddec6fbab8..b122f67dbde1d6 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -1096,7 +1096,7 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	ntf_fail |= rss_fill_reply(rsp, &req.base, &data.base);
 	if (WARN_ON(!hdr || ntf_fail)) {
 		ret = -EMSGSIZE;
-		goto exit_unlock;
+		goto err_remove_ctx;
 	}
 
 	genlmsg_end(rsp, hdr);
@@ -1124,6 +1124,10 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	nlmsg_free(rsp);
 	return ret;
 
+err_remove_ctx:
+	if (ops->remove_rxfh_context(dev, ctx, req.rss_context, NULL))
+		/* leave the context on failure, like ethnl_rss_delete_doit() */
+		goto exit_unlock;
 err_ctx_id_free:
 	xa_erase(&dev->ethtool->rss_ctx, req.rss_context);
 err_unlock_free_ctx:
-- 
2.53.0




