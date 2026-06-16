Return-Path: <stable+bounces-265842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fwFdGRKRMWqamwUAu9opvQ
	(envelope-from <stable+bounces-265842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:08:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3ED693D3C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:08:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=YQyKtXW4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265842-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265842-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAB8F3073A08
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDF3D525E;
	Tue, 16 Jun 2026 18:08:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226523D45D0;
	Tue, 16 Jun 2026 18:08:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633296; cv=none; b=EMTvnEUWteJJ1t2tPI7WJ+Zt19JtLhxRVx6EjMqYRuMlUgA+T/MUtp0yUASkfeJJS5QeVk5D26QfkaSb7XItrbBQkf7rjiSldkQaqkw8dug29jCoABkQRynKXpxsxTgaCL753+FQ/ZUquJ5QTlqLdO+X5p/+3PV20O/RaEImW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633296; c=relaxed/simple;
	bh=hDH0mfDA1JcLkBjL5fCCAe0FQCt33o6bXN2O+8NX3xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RR1ZwxIzegI6dhMMYjpfcgaogyQ3n5O4IlPmaIq6g5Lt6mZ15WVMAjFWrW9zkxKW9dHJRSV3LKq8TR0qI4EdKc1aJvdqVY0v2sfQCDSXZt6wz7Xf2BFvJ7MRUibH5ow3uU9fsFp92LuGnlLte0pov8Ge3m7nSBJaasfSagqaHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQyKtXW4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EED1F000E9;
	Tue, 16 Jun 2026 18:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633295;
	bh=DzsiD6DjgAHegXiZWIUWuX4sSVRhgRqb53Hz0sD1MQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQyKtXW48dVAB5McDW7VJJmk+PqEKQBcc+7sIJEr+F40LgvakgX/xpacgxbIOkAB+
	 OLcI9B1EOD1gVDtZ4Y5e4ZsVPOLsDEfX9fAYGIZHagK5T3dcAUxZbXNCxvED5x7DqE
	 7tXoVMUoxTGNRzily406qGeAu7Jb2v5+tp/whafU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Halil Pasic <pasic@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 018/411] net/smc: Do not re-initialize smc hashtables
Date: Tue, 16 Jun 2026 20:24:16 +0530
Message-ID: <20260616145101.357038661@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265842-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pasic@linux.ibm.com,m:wintera@linux.ibm.com,m:mjambigi@linux.ibm.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC3ED693D3C

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 5425c46a2e7c71..6b60a5dd240dd1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -123,10 +123,12 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 
 static struct smc_hashinfo smc_v4_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v4_hashinfo.lock),
+	.ht = HLIST_HEAD_INIT,
 };
 
 static struct smc_hashinfo smc_v6_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
+	.ht = HLIST_HEAD_INIT,
 };
 
 int smc_hash_sk(struct sock *sk)
@@ -2938,8 +2940,6 @@ static int __init smc_init(void)
 		pr_err("%s: sock_register fails with %d\n", __func__, rc);
 		goto out_proto6;
 	}
-	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
-	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
 
 	rc = smc_ib_register_client();
 	if (rc) {
-- 
2.53.0




