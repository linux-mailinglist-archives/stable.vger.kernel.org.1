Return-Path: <stable+bounces-267422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BGBcNxhfNWpIuQYAu9opvQ
	(envelope-from <stable+bounces-267422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:24:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E16A6A86
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=T2wn8D2g;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267422-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267422-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C812301CFA5
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF993B19A5;
	Fri, 19 Jun 2026 15:23:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865B33C518;
	Fri, 19 Jun 2026 15:23:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882639; cv=none; b=jdObzSfrKjs9ZHMr3seWBedK5DvgPJm1Jlw2diPCB+cJ2hzsWMwG7XD/mVOA6jYj/L36KB7S+0zfjOq51yxyEDfcv/geoKV/ZCixXCaFtOYxhZaeZnCsubGH7ey/GhFG8aUP1aUc3kiBQ+V938S5kWUeCig9RlWMGL/uSq4lCoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882639; c=relaxed/simple;
	bh=peGZE3PuKnqRHBy8CXTzwezvFfcr8tJwRrJ6q9xuXmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F48Q+rTIeFwXhGXJ16n9ke3rl9VM5bgLzVfSCGojaC6dxqKQGngGv1ni+jOTTiWsiTrQrsSuTGtNEjm/MZ6nbh0ImeaCYu+lN5X2ITsZ0MCrAMCZZ4idMYIPGGGvQ+sMvdu0MkEmMD5jdBdckafKJgmj8oqfguaV8Kugcvty1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=T2wn8D2g; arc=none smtp.client-ip=45.254.49.198
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 430a44d94;
	Fri, 19 Jun 2026 23:18:41 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] net: au1000: move free_irq out of the close-time spinlocked section
Date: Fri, 19 Jun 2026 23:18:16 +0800
Message-Id: <20260619151816.1144289-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ee076785b03a1kunm9fa1595fd2818
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0lDVkJNT0JKTB4dS0lDS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=T2wn8D2gAluUXTN58X0w5OtdaxpdV+d7QIimKl0YjJT03HKftaP72GUGlRL062I3KLURfqjknVkNLu6Vpb0EPmYq5TvWZAZHdRVYb55gVanudUn/c2zZJNs/Yq7cQcQRta6nnc54sH0tX0F5WVNhJrERToc3DgaGbk7QFtlPeJc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=62o5g4qRAGW1OjARkwmxZC7fw7+eQzWXZquNuPXJYuY=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267422-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B2E16A6A86

au1000_close() calls free_irq() while aup->lock is still held with
spin_lock_irqsave(). free_irq() can sleep because it takes the IRQ
descriptor request mutex, so it does not belong inside the close-time
spinlocked section.

This was found by our static analysis tool and then confirmed by manual
review of the in-tree au1000_close() .ndo_stop path. The reviewed path
keeps aup->lock held across the MAC reset, queue stop and
free_irq(dev->irq, dev).

A directed runtime validation kept that ndo_stop carrier and the same
free_irq(dev->irq, dev) operation under the driver lock. Lockdep reported
"BUG: sleeping function called from invalid context" and "Invalid wait
context" while free_irq() was taking desc->request_mutex, with
au1000_close() and free_irq() on the stack.

Drop aup->lock before freeing the IRQ. The protected close-time work still
stops the device and queue before IRQ teardown, but the sleepable IRQ core
path now runs outside the spinlocked section.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/amd/au1000_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 9d35ac348ebe..5a04056e38fa 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -943,9 +943,10 @@ static int au1000_close(struct net_device *dev)
 	/* stop the device */
 	netif_stop_queue(dev);
 
+	spin_unlock_irqrestore(&aup->lock, flags);
+
 	/* disable the interrupt */
 	free_irq(dev->irq, dev);
-	spin_unlock_irqrestore(&aup->lock, flags);
 
 	return 0;
 }
-- 
2.34.1


