Return-Path: <stable+bounces-265053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WWtHHBaEMWqOlQUAu9opvQ
	(envelope-from <stable+bounces-265053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:12:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A8692DD8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:12:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VbTE+q9X;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265053-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265053-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FEC531F7E45
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824543E4BC;
	Tue, 16 Jun 2026 17:00:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C45472767;
	Tue, 16 Jun 2026 17:00:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629242; cv=none; b=COIA/8JqpufpkgpT4nHsHzGbGZ9w6fU9OVd5pAE15USKzmFiHSoOlelUZYCouRHA/z0xv+5eYQZcgcf/dsiSr0uair07KI1oZ5ym9VuOOT7jTaPRNMN6PPfWeT863uoSNK4m7YEQ7lzmT5ZPAAlZWb56bMBJhHzRUU66RUv5hps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629242; c=relaxed/simple;
	bh=1udxZ5pPP38qVw6TLgptsS04kUFcMjV9z1AeTFq1YBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdxpRSJ6XThH6Q36Olyl043vxcTJ8xpKob0RuQrWjDt/IzvukvtR2GeBVl9wps1c+wXX7l9snyUPETTlsR2xHeCWY4zR0XTplmdt1GIClA+La7I78UvxLbnytJv0vkOE2GzxKNoM0tXNHTeqb6+5jygYHjZEOnqJTPp/+8w2wYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VbTE+q9X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9362D1F000E9;
	Tue, 16 Jun 2026 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629241;
	bh=AJ+WACzoFCRAulKtfarDa7xx5Lv3MJwJfBUkswzPrG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VbTE+q9X5hnUSRyng0tcqvh3v2mU5deyipueKtMvoPbPbjjg6ST4lKHMRNmFVwwGy
	 jLtls6TGW2IZN8QY67jW0q8QMu5vAfx4rVXHYl/jpVChYmY6f7bG+ifXN4BYg7xS/7
	 ZZNNZUQX+einaHWdDud8fM5v3GzmK3I61fZvTAfg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rui Qi <qirui.001@bytedance.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 247/452] ipmi: Fix rcu_read_unlock to srcu_read_unlock in handle_read_event_rsp
Date: Tue, 16 Jun 2026 20:27:54 +0530
Message-ID: <20260616145130.653920384@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265053-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:qirui.001@bytedance.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bytedance.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D87A8692DD8

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rui Qi <qirui.001@bytedance.com>

Fix a bug where rcu_read_unlock() was used instead of srcu_read_unlock()
in handle_read_event_rsp() when ipmi_alloc_recv_msg() fails.

This mismatch leads to an SRCU read-side critical section imbalance: the
entry uses srcu_read_lock(&intf->users_srcu) but the error path
incorrectly calls rcu_read_unlock(), which is a no-op for SRCU and
leaves the SRCU lock held.

The offending code was restructured in mainline by commit 3be997d5a64a
("ipmi:msghandler: Remove srcu from the ipmi user structure"), which
replaced the SRCU locking with a mutex in this function, effectively
eliminating the mismatch. However, that commit is part of a larger
SRCU removal series that is not suitable for stable backport. This
minimal fix addresses the SRCU imbalance for 6.12 and earlier stable
branches that still carry the original locking scheme.

Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
Cc: stable@vger.kernel.org
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index fc5f9d757b948c..37b84bfa623e99 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4396,7 +4396,7 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 
 		recv_msg = ipmi_alloc_recv_msg(user);
 		if (IS_ERR(recv_msg)) {
-			rcu_read_unlock();
+			srcu_read_unlock(&intf->users_srcu, index);
 			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
 						 link) {
 				list_del(&recv_msg->link);
-- 
2.53.0




