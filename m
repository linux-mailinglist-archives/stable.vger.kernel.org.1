Return-Path: <stable+bounces-261186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HhSuKL1FJWp6FgIAu9opvQ
	(envelope-from <stable+bounces-261186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:19:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2123364F873
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:19:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=RInjNg4+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261186-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261186-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC62A30158BB
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5556A2DB7A3;
	Sun,  7 Jun 2026 10:19:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A024CB5B;
	Sun,  7 Jun 2026 10:19:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827578; cv=none; b=dtAe5IAxOLS39rJ0spK1Gu7zxPodP/sgBwCdRv1kNcMnsPVcaMJYnrQg2L7PbKeRmcaoQ3UQJkRk6bu4MJstzHv4kQRdRXQbJ00N+Tqly4QCpHXZV5KHzDIyH189TrgluZmDQZQP7WaQTx+8I5R1cVk8+7vjvf5ddpgMZ2kGNNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827578; c=relaxed/simple;
	bh=dM7dMIU/91w+ZgBOyDlFe3NTBnotuQki4z/tZcuhhhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pN1DnQqWVzUx4qfqOVmGc5Ibw7ugRf6uaaFsHi6NmS+GnCfy6PXRrnM5N5fr+oR2n3KXWMYCyu0/GqxSd8Zs46UCNLGrh09M9nAJk33mCro4mmqy8X70oMF/bynhGRNj6tE69dA6IEUdQOFfpINAzEiaLhxf7r5VGyqSb0/0OsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RInjNg4+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439F41F00893;
	Sun,  7 Jun 2026 10:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827577;
	bh=rZ1wsSHzvdbp7xM4v+OXyghsCxOQh1mSfyRPCpAZBsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RInjNg4+O2RiqLuE2GX+de3EJtebIN356eA49ZyscTTM83DtJWWEGWVrQlbf0wmBX
	 4n2hD0518nE4unolmg45J8pfphUsZXxqu6NYLCzbOadhMkKC95C7NS9L8fTQOpBjVd
	 BsUbcHy7FvhruGmD0+DKJESoY36KW6aLIu72vFTk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 070/307] ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during fallback
Date: Sun,  7 Jun 2026 11:57:47 +0200
Message-ID: <20260607095730.329867243@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261186-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,page_data.data:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2123364F873

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 3b8209e930fd3a..03cb418a15823b 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -140,12 +140,11 @@ static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
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




