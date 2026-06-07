Return-Path: <stable+bounces-261007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E3aPL/9DJWqRFQIAu9opvQ
	(envelope-from <stable+bounces-261007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:12:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EA864F665
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:12:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=U3isWmm4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261007-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261007-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B353012E83
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B57E2E7F0A;
	Sun,  7 Jun 2026 10:09:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225871DE8AE;
	Sun,  7 Jun 2026 10:09:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826946; cv=none; b=H+kzLG5J0nOueBFroTl57djYBB2sWoWCpKt5Ehid7NwhQgpieVGuxAnduw0UMilEoHzKJdcFPaa0sKeKVIUrz+I5aiTED+nm4m7h6Z7br2sZMHZypckpdYcPNcnfSxK9utqs8nm200KldL8FUNt3KBPqmDB3WFlnPpe+NFRMTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826946; c=relaxed/simple;
	bh=1lq8xOdqdOWMyxqf7Y4b4UHok+pz6FFB27chkr6kQU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2hGOKfr9aRjbstw3ipog6c6WZy8aBN4aTm/WOUYz86mFfViKZFnni1ndlDN63nvkChC/YyF1kCfPixz4raw4kWmSEnG0uYxvMgbkfvXcQ6jb5W0sGcUQ5Yd3ScG0BVtHuFqULAgYbKqSsl5xyGWzfP59OOLQQiYd/9z4SFMbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U3isWmm4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327821F00893;
	Sun,  7 Jun 2026 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826945;
	bh=wY3RZJP3EhM8KPzvb0TQg4HIZzvDEggJ2YbFCsFkpJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3isWmm4ar906pUKjj6FGt4Z8CE19FTWT+cm3Z2Zp87ZFGC8FSM4oYLjCJC1GDbSU
	 66uiQiE+HbFvNt0YPWvJIyg1cNILEZuF4j4g/p/1ayETonhJGRgj0rW7gSTuRUabux
	 mdIMO8kSlLZCBBkhb1VGda/NmKeQvfiH4n8BZ4fU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Halil Pasic <pasic@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 025/315] net/smc: Do not re-initialize smc hashtables
Date: Sun,  7 Jun 2026 11:56:52 +0200
Message-ID: <20260607095728.417705921@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-261007-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pasic@linux.ibm.com,m:wintera@linux.ibm.com,m:mjambigi@linux.ibm.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18EA864F665

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit 9e4389b0038781f19f97895186ed941ff8ac1678 ]

INIT_HLIST_HEAD(&smc_v*_hashinfo.ht) are called after smc_nl_init(),
proto_register() and sock_register(). This can lead to smc_v*_hashinfo.ht
being reset even though hash entries already exist and are being used,
possibly resulting in a corrupted list.

Remove unnecessary and dangerous re-initialisation of smc_v*_hashinfo.ht in
smc_init(); it is implicitly initialised to zero anyhow. Add
HLIST_HEAD_INIT to the definitions for clarity.

Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
Suggested-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Link: https://patch.msgid.link/20260521145639.10317-1-wintera@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/af_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5915fcdef743d2..21d0c62bcf4644 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -188,10 +188,12 @@ static bool smc_hs_congested(const struct sock *sk)
 
 struct smc_hashinfo smc_v4_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v4_hashinfo.lock),
+	.ht = HLIST_HEAD_INIT,
 };
 
 struct smc_hashinfo smc_v6_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
+	.ht = HLIST_HEAD_INIT,
 };
 
 int smc_hash_sk(struct sock *sk)
@@ -3595,8 +3597,6 @@ static int __init smc_init(void)
 		pr_err("%s: sock_register fails with %d\n", __func__, rc);
 		goto out_proto6;
 	}
-	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
-	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
 
 	rc = smc_ib_register_client();
 	if (rc) {
-- 
2.53.0




