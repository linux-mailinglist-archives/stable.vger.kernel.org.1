Return-Path: <stable+bounces-264835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CG7YLTx9MWq+kgUAu9opvQ
	(envelope-from <stable+bounces-264835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:43:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B170692630
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:43:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=nOjNvY79;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264835-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264835-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92F1630445C6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B947887F;
	Tue, 16 Jun 2026 16:42:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DA46AF3C;
	Tue, 16 Jun 2026 16:42:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628139; cv=none; b=lQVZ9JvA6gC06qG2kbJUYI/6wpvwRvWzPxuSWHn2KNCpfn71UNG+DvL9F3/oVqBDXld6O7WREkYM1g/iStFO6vYTwiPuw337WZp/feuS+eDpxWI345BtVw4Ib3t1fg7pVe1ZiR003nER6Ti9bocxzyOXDKHFPo/X45DYzw75qsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628139; c=relaxed/simple;
	bh=uc/+AQ4Wl0PeusN9lWTL8Ken1OIwq5G/8AxYkbKXqnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9RcIv1huPZ6JEJOXSXuKrQQKYLk4NiLdidGkfhmHeO7vsbjvv0iEMNHXUhPACBoNMvf5E/0VIqaN5q/RGPz61cdb+OXbSCYIZps4L5LFVy1wr5tmoCaWsABB+5d4sV5TlONak2BMnlG9+95tQa+vuyY65xuu0dWe68MXTFxDvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nOjNvY79; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E45D1F000E9;
	Tue, 16 Jun 2026 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628138;
	bh=Xsbu8m5n+OnRlrK7xbVLN1A3+XDppVDVHCWEN0CHJaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nOjNvY79WtQr8+WXIqRllEXxdftcCR4vdwvJng9lWNn0IpCiXUIaOPSVnfeXI3qxR
	 5stgZTcp7vWGzp1z9Q3sxxrtULh6Q30WUH7UvnJPsvr+M9r2Jo+5uC54KeY4rz+PFb
	 JC2xVoNrbXl6ELeJyz2gnfRhegurB9nL2jMYsXpg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 037/452] ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during fallback
Date: Tue, 16 Jun 2026 20:24:24 +0530
Message-ID: <20260616145119.889034276@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264835-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,bootlin.com:email,msgid.link:url,page_data.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B170692630

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 2376586f85f972fefe701f095bb37dcfe7405d21 ]

All ethtool driver op calls should be sandwiched between
ethnl_ops_begin() / ethnl_ops_complete(). In Netlink eeprom code,
if the paged access failed we fall back to old API, but we
first call _complete() and the fallback never does its own
ethnl_ops_begin(). Move the fallback into the _begin() / _complete()
section.

Fixes: 96d971e307cc ("ethtool: Add fallback to get_module_eeprom from netlink command")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260526153533.2779187-10-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/eeprom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index 6209c3a9c8f723..15546f2a5e4583 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -134,12 +134,11 @@ static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
 	return 0;
 
 err_ops:
+	if (ret == -EOPNOTSUPP)
+		ret = eeprom_fallback(request, reply);
 	ethnl_ops_complete(dev);
 err_free:
 	kfree(page_data.data);
-
-	if (ret == -EOPNOTSUPP)
-		return eeprom_fallback(request, reply);
 	return ret;
 }
 
-- 
2.53.0




