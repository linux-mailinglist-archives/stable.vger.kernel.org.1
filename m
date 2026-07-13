Return-Path: <stable+bounces-273831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dgo3A+btVGqehQAAu9opvQ
	(envelope-from <stable+bounces-273831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:53:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD8974BEBD
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:53:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=vktUfcRm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273831-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273831-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40AC13006169
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B1340E8F3;
	Mon, 13 Jul 2026 13:53:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AE435A91
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:53:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950819; cv=none; b=Dta2SjoFP2HP0GndZIHaq2BJj7Rkt5+SFiRqWrS7TmpsOchdEUepArWqjkbgSHnZ62K0o818mjgaM0xRV3QSVmfFNCutMVFgsB1W2Ae/xceZ4E8Ho3Bjz3V97g3uIHB91xm1jkg0iU9YXNOv+sglGxzpC9AOOABYKO+nz130NuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950819; c=relaxed/simple;
	bh=77HIjm7gNMUii+T4MERjcKkyJ5IxNm9sZtpD7r0XpMA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BNwkduRt6Q5sjJefX3xZgI8nEYxJbo1573k9sc8ZjSxpnFgZpYiEhM+ROHwVyX/gQe1vpSqGsjzYBHNFFLbhs7mw94/B2ko44zNIyn78vIVboCULP9uF3OThXYGNyTBkdfDjizOHC8PvZOcOU1j75oIiDhJi3PwITHCufGRPbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vktUfcRm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4BF1F000E9;
	Mon, 13 Jul 2026 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950818;
	bh=2c5ynGOQZGWhyg9O4RRotcMpr/H3TNZAcyoL3tYntvQ=;
	h=Subject:To:Cc:From:Date;
	b=vktUfcRmo9H11378fqTmu3luCNOn0VgD69sfXvKpjPED4yNXTHVn2eSrHAvzEUueZ
	 jEgwwr2nRnybhqmHeFFu/XST88J3Oa5weBbRymwe+vU9r//JweoBirHSeHwXlI39Fs
	 OkOSlnvnAis8Q9h1YcIte5qYewGN7Q1d74MXuZ4E=
Subject: FAILED: patch "[PATCH] netpoll: fix a use-after-free on shutdown path" failed to apply to 5.10-stable tree
To: leitao@debian.org,kuba@kernel.org,pavan.chebbi@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:45:51 +0200
Message-ID: <2026071351-purist-upcountry-3088@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273831-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:kuba@kernel.org,m:pavan.chebbi@broadcom.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FD8974BEBD


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 45f1458a85017a023f138b22ac5c76abd477db42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071351-purist-upcountry-3088@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45f1458a85017a023f138b22ac5c76abd477db42 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Thu, 25 Jun 2026 05:03:18 -0700
Subject: [PATCH] netpoll: fix a use-after-free on shutdown path

There is a use-after-free error on netpoll, which is clearly detected by
KASAN.

      BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x3b/0x80
      Read of size 1 at addr ... by task kworker/9:1
      Workqueue: events queue_process
      Call Trace:
       skb_dequeue+0x1e/0xb0
       queue_process+0x2c/0x600
       process_scheduled_works+0x4b6/0x850
       worker_thread+0x414/0x5a0
      Allocated by task 242:
       __netpoll_setup+0x201/0x4a0
       netpoll_setup+0x249/0x550
       enabled_store+0x32f/0x380
      Freed by task 0:
       kfree+0x1b7/0x540
       rcu_core+0x3f8/0x7a0

The problem happens when there is a pending TX worker running in
parallel with the cleanup path.

This is what happens on netpoll shutdown path:

1) __netpoll_cleanup() is called
2) set dev->npinfo to NULL
3) call_rcu() with rcu_cleanup_netpoll_info()
  3.1) rcu_cleanup_netpoll_info() tries to cancel all workers with
       cancel_delayed_work(), but doesn't wait for the worker to finish
4) and kfree(npinfo);

Because 3.1) doesn't really cancel the work, as the comment says "we
can't call cancel_delayed_work_sync here, as we are in softirq", the TX
worker can run after 4).

Tl;DR: queue_process() is not an RCU reader, it reaches npinfo through
the work item via container_of().

Use disable_delayed_work_sync() to ensure the worker is completely
stopped and prevent any future re-arming attempts. Once npinfo is set
to NULL, senders will bail out and not queue new work. The disable flag
ensures any in-flight re-arming attempts also fail silently.

In the future, we can do the cleanup inline here without needing the
npinfo->rcu rcu_head, but that is net-next material.

Cc: stable@vger.kernel.org
Fixes: 38e6bc185d95 ("netpoll: make __netpoll_cleanup non-block")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20260625-netpoll_rcu_fix-v2-1-0748ffac1e98@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 229dde818ab3..96d5945e6a30 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -633,14 +633,6 @@ static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 			container_of(rcu_head, struct netpoll_info, rcu);
 
 	skb_queue_purge(&npinfo->txq);
-
-	/* we can't call cancel_delayed_work_sync here, as we are in softirq */
-	cancel_delayed_work(&npinfo->tx_work);
-
-	/* clean after last, unfinished work */
-	__skb_queue_purge(&npinfo->txq);
-	/* now cancel it again */
-	cancel_delayed_work(&npinfo->tx_work);
 	kfree(npinfo);
 }
 
@@ -664,6 +656,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 			ops->ndo_netpoll_cleanup(np->dev);
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+		disable_delayed_work_sync(&npinfo->tx_work);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	}
 


