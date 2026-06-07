Return-Path: <stable+bounces-261183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PJe2B7NFJWpyFgIAu9opvQ
	(envelope-from <stable+bounces-261183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:19:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE364F85A
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:19:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=staQIeaN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261183-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261183-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35F9F3003611
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F112DB7A3;
	Sun,  7 Jun 2026 10:19:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC14071DA;
	Sun,  7 Jun 2026 10:19:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827566; cv=none; b=QcGpNlabwGKSngbEjnXVo9nTulIkhvogvwSj923K25n3GiYEAbVZZpTmJORU0AkOP/i1mOUXKQpBycrPXiDCgjumZqHXuAzwDKJCPSCQBOkU0dEptQ/NfxUy3YNFSwFNjek4F2F2gE/jVt8ESvkiCo7mLRV+dU2MVn93GhRZlQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827566; c=relaxed/simple;
	bh=iMjOz+GmkwgBzsCJlRVViPbcRcjdALsbNKNlpKzBEKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caLK4YgM/CaEqXuVDwFUBIq1NX7848YiBAQB/cCVRQngGMjYNf1ahIiaro7Q2jePwxn/hbrByEOYGfNR6Gg0m9awb6O/5PBpP7wtqjlk4WJFOw5oXZ1j9WbkUtT0Ccwi2E0cSRkvkmQCmuP+/9hi03BDJBlaG46Yymbh3HkVgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=staQIeaN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEB41F00893;
	Sun,  7 Jun 2026 10:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827565;
	bh=l3mJu6mggmUBxE5Ww72NbFt2g/qiSfgYVkc/gmejvGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=staQIeaN9ZBEFtbyulj9Nf5sfX8eLV0GPxptNpP/aFn/Xb7vi8rw0mJGe3e+/Ddcy
	 Uh7Pv4jOLGItkLW6ufNDvsYsueISWizslard6F1kQzBq+tcmH5tkdRZp+JVBb+LUV0
	 WYsbHSGdk4hwy65LDHThGBdEqYAY1TwQNyo5f+kI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 069/307] ethtool: strset: fix header attribute index in ethnl_req_get_phydev()
Date: Sun,  7 Jun 2026 11:57:46 +0200
Message-ID: <20260607095730.294048724@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261183-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBAE364F85A

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit a8d8bef6b45bf7cc0b1f6110c5cd8d0160a9bad7 ]

strset_prepare_data() passes ETHTOOL_A_HEADER_FLAGS (3) as the header
attribute to ethnl_req_get_phydev(). This is incorrect, in the main
attr space 3 is ETHTOOL_A_STRSET_COUNTS_ONLY, not the request
header attr. The correct constant is ETHTOOL_A_STRSET_HEADER (1).

ethnl_req_get_phydev() only uses this value for the extack,
so this is not a "functionally visible"(?) bug.

Fixes: e96c93aa4be9 ("net: ethtool: strset: Allow querying phy stats by index")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260526153533.2779187-9-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/strset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index b9400d18f01d58..73597f0bc923a3 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -299,7 +299,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		return 0;
 	}
 
-	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_HEADER_FLAGS,
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_STRSET_HEADER,
 				      info->extack);
 
 	/* phydev can be NULL, check for errors only */
-- 
2.53.0




