Return-Path: <stable+bounces-243498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF/HF3yq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:17:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A81B4BEFDA
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97959304241B
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A33DE42E;
	Mon,  4 May 2026 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sgMachsc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D73D300A;
	Mon,  4 May 2026 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904039; cv=none; b=Y/7BgojogpIKKLfr8WvxSmYk2MWmzVvNP1hWxNivhTkc8SYuu/hPr3aAcaaS9lcQzxc3sopaIogNJaXo0R5SpSNGhD4k5KAmELfhYOVeKCwS7+JeA7l8hhIepgdbP0qgGDTGj3YIHFgn0gtcy/BJnoo5Flwv+IxtRmGd3lccSwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904039; c=relaxed/simple;
	bh=0ALTWFAwfwxj9XnztntS1/J4qvVfAd1+hQ0jwP/KfCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuAa/M9Hq0qfkIpC28icN6WJO+TdJv8nnaYsxIi6c5gPd+tuToGJzHiavlNZYqKcOwMAUgBB8dXsLkL3dOc2R1js866eFalrqpO6tt+VqQKmc52tPWgEJPwo6vAulNd7tmEn2kL6YAx3ReLaeqoq5Ql0+HBT49cwwBd+b0sgXn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sgMachsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766A5C2BCC4;
	Mon,  4 May 2026 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904038;
	bh=0ALTWFAwfwxj9XnztntS1/J4qvVfAd1+hQ0jwP/KfCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgMachscgVlCo5Jii8eKULP3lkiByLZ0Ytz+TYvWgZ71edZHCkkCjvQPRQCfMxN38
	 g6Gw/yXzu5GYUdGXu75bKpTqI2qfkCi/Vzg9jBkBdwUI1iELaY4iFgaDKz84GGv5b1
	 0NOagYQzlNuJgJ/tKdUvxluHpOdHxpz4ToU33RdA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marek Vasut <marex@nabladev.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 127/275] net: ks8851: Avoid excess softirq scheduling
Date: Mon,  4 May 2026 15:51:07 +0200
Message-ID: <20260504135147.621237231@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 2A81B4BEFDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243498-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nabladev.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@nabladev.com>

commit 22230e68b2cf1ab6b027be8cf1198164a949c4fa upstream.

The code injects a packet into netif_rx() repeatedly, which will add
it to its internal NAPI and schedule a softirq, and process it. It is
more efficient to queue multiple packets and process them all at the
local_bh_enable() time.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: e0863634bf9f ("net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marex@nabladev.com>
Link: https://patch.msgid.link/20260415231020.455298-2-marex@nabladev.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/micrel/ks8851_common.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -373,9 +373,12 @@ static irqreturn_t ks8851_irq(int irq, v
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
-	if (status & IRQ_RXI)
+	if (status & IRQ_RXI) {
+		local_bh_disable();
 		while ((skb = __skb_dequeue(&rxq)))
 			netif_rx(skb);
+		local_bh_enable();
+	}
 
 	return IRQ_HANDLED;
 }



