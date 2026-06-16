Return-Path: <stable+bounces-263804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ycyEB75mMWoWigUAu9opvQ
	(envelope-from <stable+bounces-263804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:07:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A1C690C46
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:07:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=V6Semp2X;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263804-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263804-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED73F30069B3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023F23AA9F3;
	Tue, 16 Jun 2026 15:07:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5283A9D94;
	Tue, 16 Jun 2026 15:07:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622456; cv=none; b=aP7+Yh2uqJ5LZjnwUl0n7jTFtOES1a7RBu4VlsfV6CbDFJ6gQdlWmkydbsHJZHiCSxVwvW8qo0ES06/b8IrnYEGyT0uUr6NEENNgI1pKO484HY80WsHsfKvdbv6lggFub9bgOgPWpOPpYsPeQnE08BMPCgz7SdR1XlFhNq2lIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622456; c=relaxed/simple;
	bh=FIPzQkczePF0mCNdbc1it+lrz49Lhzx7SjQ3sfcU3No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5Y2VZJ8gj/GBva4bKg4KrFHFf9fnrBs28qo0/mG6i1ZZKCZakRQAc/ljqNEAwrVdWhoSnmOdNVZWkhuHHmKrA2qu+wN7x7Eh3JQIjFdBrCBA27nQ2YFg2kHZ2cMuC3jfgRFXuVMXmnXlU3xYDbEg+kFha93BMS4CIz9S+kK8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V6Semp2X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC3F1F000E9;
	Tue, 16 Jun 2026 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622455;
	bh=v9dBJXqMICvV3NRKcGABMU/qbUEUU7wWT8E1Pb8owvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V6Semp2XlzC254tYD07nkppeA6yLyxOOZFDDWZsYsD+D4Oat/nWzEsd7gnusA+ZvC
	 4HK/er+eUb/1SqMco7e5Wjh/4MCJvUpKTIsNCnoL2p/C/P7d88UqT8zUR8DaHfDty6
	 HeIhA/B8UFF1BpbpUXNejgoHJWvrNQIqGn0OKyn0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Nicol=C3=B2=20Coccia?= <n.coccia96@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 006/378] net/smc: fix sleep-inside-lock in __smc_setsockopt() causing local DoS
Date: Tue, 16 Jun 2026 20:23:57 +0530
Message-ID: <20260616145110.102965656@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263804-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:n.coccia96@gmail.com,m:dust.li@linux.alibaba.com,m:kuba@kernel.org,m:ncoccia96@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.alibaba.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,alibaba.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10A1C690C46

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolò Coccia <n.coccia96@gmail.com>

commit a3fdd924d88c30b9f488636ce0e4696012cf5511 upstream.

A logic flaw in __smc_setsockopt() allows a local unprivileged user to
cause a Denial of Service (DoS) by holding the socket lock indefinitely.

The function __smc_setsockopt() calls copy_from_sockptr() while holding
lock_sock(sk). By passing a userfaultfd-monitored memory page (or
FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
as the optval, an attacker can halt execution during the copy operation,
keeping the lock held.

Combined with asynchronous tear-down operations like shutdown(), this
exhausts the kernel wq (kworkers) and triggers the hung task watchdog.

[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
[  240.123489] Call Trace:
[  240.123501]  smc_shutdown+...
[  240.123512]  lock_sock_nested+...

This patch moves the user-space copy outside the lock_sock() critical
section to prevent the issue.

Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by socket options")
Signed-off-by: Nicolò Coccia <n.coccia96@gmail.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Tested-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3061,18 +3061,17 @@ static int __smc_setsockopt(struct socke
 
 	smc = smc_sk(sk);
 
+	/* pre-fetch user data outside the lock */
+	if (optname == SMC_LIMIT_HS) {
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (copy_from_sockptr(&val, optval, sizeof(int)))
+			return -EFAULT;
+	}
+
 	lock_sock(sk);
 	switch (optname) {
 	case SMC_LIMIT_HS:
-		if (optlen < sizeof(int)) {
-			rc = -EINVAL;
-			break;
-		}
-		if (copy_from_sockptr(&val, optval, sizeof(int))) {
-			rc = -EFAULT;
-			break;
-		}
-
 		smc->limit_smc_hs = !!val;
 		rc = 0;
 		break;



