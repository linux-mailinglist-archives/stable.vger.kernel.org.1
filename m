Return-Path: <stable+bounces-264278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0VHLHVRxMWq3jQUAu9opvQ
	(envelope-from <stable+bounces-264278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:52:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B776E69175E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:52:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="rBG/SILH";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264278-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264278-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 677003003EFD
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C534E44CAE6;
	Tue, 16 Jun 2026 15:52:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2144B66E;
	Tue, 16 Jun 2026 15:52:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625121; cv=none; b=mnR97wjMjkFb1J9+GHb6qSyA3ah0mSfkC+eeH6CbTpTBTPU/1pE1cIsLd9il70kLEcbW21seSRhZQ4sv01lEXluVklo2n68sj9nvZI1DORZB7h3bWexvvjtvcdOJoz9U/ZbVHp89vCoZTflGd1jHY9vqkIpF19tO5Nfn30gKgTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625121; c=relaxed/simple;
	bh=gGcDcNi4luGCYIxrGlPOr2veccsTswScerXdIq3jzPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n80SFeoGjR4xKEKCo09qY3lFspjHgCvDaf4M26iAAaRpu31oTv2hxPkOtdykzzq2UZomR2EZWfsSsxoOl6HOQJ/twiC3/TU/zwB4XaLy8OqWVvJrs6Nx4SWgW5FI+YZGQPlFc1LlIkjAp1VcbzGwUm7o04KRXrKJcQ1g3c4gLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rBG/SILH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA841F00A3A;
	Tue, 16 Jun 2026 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625120;
	bh=A4ojEDawW0smEQo9FLSat+Ug8KYM6TvbW8YkudewSx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rBG/SILHPruN+i1S5EAQlOG1rOcAOlkL9xCfV/bf067kTtwx5uKSk0nI1mx8ULzCw
	 /jMbXQ4idNIlxv6ZJbsfZEnxfIit3Ai0wIqli6BOKwE5JzCBOpBlYb+yGqijIzDkDc
	 1PDOvo9nv057edqDVsZlvQlABG8aMs76d55RpuEQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 048/325] Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
Date: Tue, 16 Jun 2026 20:27:24 +0530
Message-ID: <20260616145100.120422345@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-264278-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sashiko-bot@kernel.org,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B776E69175E

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 5cbf290b79351971f20c7a533247e8d58a3f970c ]

hci_get_route() returns a reference-counted hci_dev pointer via
hci_dev_hold(). The function exits normally or with an error without ever
releasing it.

Fixes: 07a9342b94a9 ("Bluetooth: ISO: Send BIG Create Sync via hci_sync")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 9b421e4a2466f7..355487613c82a0 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1521,6 +1521,7 @@ static void iso_conn_big_sync(struct sock *sk)
 
 	release_sock(sk);
 	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 }
 
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.53.0




