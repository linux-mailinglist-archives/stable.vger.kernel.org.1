Return-Path: <stable+bounces-261000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /CU7NONDJWqDFQIAu9opvQ
	(envelope-from <stable+bounces-261000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F1264F645
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fCTX0K+H;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261000-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261000-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FBDC3047243
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A12E3709;
	Sun,  7 Jun 2026 10:08:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8BE1DE8AE;
	Sun,  7 Jun 2026 10:08:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826921; cv=none; b=kiisx88dQd5t/MY4p5KyB1r0cPDpQI/LLrHBE9wU2wzd2b9goNMk1XLIFgOO+PsDSZpYH3Py2fWOlkDojkYMcQYtrjwCVgCKnLBp8Ng/zH28jGi0/Rxu3SiOga30q8wEtSSwacNWSSyaCjor5D2b3SF+oWca5/128c6YHiZ6KHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826921; c=relaxed/simple;
	bh=6h3WX728kUUbmex5HA2outUGuNIv61xUWy/KwyZFRgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJuBQlcaDHIyzAMi2mVJAM31kY98mp/1J9gmyBVRTZT47kYZyFm3npYu9Rpx3kGn0u3w+oPoNz3bDuYgxll0G2aiWH+QTY28t5rwsLJYLHZ0gq6Qxfo11yzbjeNsbvJlrGU/kGsyFo41lnngoxpxw8Y/s3SxfZdEGeqkFcpTxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCTX0K+H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0065C1F00893;
	Sun,  7 Jun 2026 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826920;
	bh=ukTDgJK7e3z10nFRiHtRT4EpHdpSA8ulfAyeikQFoek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCTX0K+HAI0oeEGOzzx2K1wrxZhSNqXEyjqpHXIH/iRHvUTKpX7kchNT9iLAM/33D
	 NsoeKpuSYDDzGxszYnGhEzZsaDgGU1kAASR08lmmkG7xoBnlkdQviZUgJmAtltSJgc
	 2vc1c2149SlXSDGfm44kY9Byh+Efy6AspwXvHqL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Halil Pasic <pasic@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 027/332] net/smc: Do not re-initialize smc hashtables
Date: Sun,  7 Jun 2026 11:56:36 +0200
Message-ID: <20260607095729.083162424@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261000-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 45F1264F645

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index f744f791121776..de034a3e5d801f 100644
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
@@ -3522,8 +3524,6 @@ static int __init smc_init(void)
 		pr_err("%s: sock_register fails with %d\n", __func__, rc);
 		goto out_proto6;
 	}
-	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
-	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
 
 	rc = smc_ib_register_client();
 	if (rc) {
-- 
2.53.0




