Return-Path: <stable+bounces-261124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hgi+DmxGJWrpFgIAu9opvQ
	(envelope-from <stable+bounces-261124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:22:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC6C64F96D
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:22:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=2o3VJOuT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261124-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261124-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDC80307462D
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611FB2AD00;
	Sun,  7 Jun 2026 10:15:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419EF4071DA;
	Sun,  7 Jun 2026 10:15:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827341; cv=none; b=IkPivBJ6cypTAXycpwERtbOLYRudds5YBKxg4n6NnwmCpujPtu6S8oFixhqizu98FFJahyztGgOeFFyJfNdh/4memuLDqmP7lFvudbwWX8f+KaPubMEjyDmZCaNtjnT6Ki7ZxKsIop6KZhv2GguGcFqLzI5m04wbWJz6lZl4ZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827341; c=relaxed/simple;
	bh=vwhQg/8Ws9eKLY8EadxW/Qe8PbO323DiL4omMdcH5Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tY90jT+vbZQksogR4gzu9V2XoBI/SdINLqTrZwe0WurENQqlhwR+eq9Dsx+ywFZCEeymFQOaG7X8Na/Hz4s2Gmr5URmbw+P5MIeSYeP35vwHLHBsFub7YmuIhK4/eySCmygmcdYGZ1eytInf7U0KXGxvJmwB0uDZT6t6tWleWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2o3VJOuT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842BB1F00893;
	Sun,  7 Jun 2026 10:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827340;
	bh=oKD7766u/iJlY+w7GaUMbL7SqkKs/6OfrBdjuA30Tws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2o3VJOuTxSCxO2Jk7eVl76hpnefn/y0IvoprRsmEgJSNo4lWqosUO0vjZgIpBH9h1
	 DhwlbIdiG2ofcdbzaNzx+iwDE9W9yQN3wIXeHWmmFIgKm+dqUquCrUE88VNyu3LtHF
	 iWDGui4kwZXK6IVl5lDE5oQvZTKRVBUWkA2qudNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 065/315] ethtool: tsconfig: fix reply error handling
Date: Sun,  7 Jun 2026 11:57:32 +0200
Message-ID: <20260607095729.999068356@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261124-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vadim.fedorenko@linux.dev,m:kory.maincent@bootlin.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,bootlin.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FC6C64F96D

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit a888bbd43940cada72f7686337741ce86d1cf869 ]

A couple of trivial bugs in error handling in tsconfig_send_reply().
If we failed to allocate rskb we need to set the error.
If we did allocate it but failed to send it - we need to remember
to free it.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Link: https://patch.msgid.link/20260526153533.2779187-3-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/tsconfig.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 169b413b31fc5f..041de8687472bd 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -224,16 +224,21 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
 	reply_len = ret + ethnl_reply_header_size();
 	rskb = ethnl_reply_init(reply_len, dev, ETHTOOL_MSG_TSCONFIG_SET_REPLY,
 				ETHTOOL_A_TSCONFIG_HEADER, info, &reply_payload);
-	if (!rskb)
+	if (!rskb) {
+		ret = -ENOMEM;
 		goto err_cleanup;
+	}
 
 	ret = tsconfig_fill_reply(rskb, &req_info->base, &reply_data->base);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_free_msg;
 
 	genlmsg_end(rskb, reply_payload);
 	ret = genlmsg_reply(rskb, info);
+	rskb = NULL;
 
+err_free_msg:
+	nlmsg_free(rskb);
 err_cleanup:
 	kfree(reply_data);
 	kfree(req_info);
-- 
2.53.0




