Return-Path: <stable+bounces-248105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF+LKu1GB2r6wAIAu9opvQ
	(envelope-from <stable+bounces-248105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:16:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D3552ED0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E99993024139
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4C03B19DE;
	Fri, 15 May 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCnPWFl8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506933B0ADB;
	Fri, 15 May 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860885; cv=none; b=UbZpEhaiKdi2FrEweFa5yeteTPu5gSuAtdMFQ0Db1CEM4Ek3HPaFWnM0FOgSw3ip5L+tDoBCl+9riw8OALTD1YU5kbeWKYC4bFw77+dzpO6rhB7EaL6PQjjIVoQ9BcysaXGr8pBwxjJJgb95TGDqcz38TFb/PVRrKqasrE3zC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860885; c=relaxed/simple;
	bh=JNz4yJu87R0ec8FO6QYJDvCTkSio2K6T6qQfEefbdwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxYo29HNhSEqU8iZ379uR6a1AGJoHzcsCZGnO1xehLzIm3UmennYSJGSLL8mOF7Q+NiWey/eml4HEyMZwpJ7UmFezLUw0Ol7bRg/4Rabs9tMewVdQTGAnBCOxU7p61FUz5LOGPAVpFjYhpcVDXHyKAWdaacJt9MAXQvWCUXD8xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCnPWFl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2CAC2BCB3;
	Fri, 15 May 2026 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860885;
	bh=JNz4yJu87R0ec8FO6QYJDvCTkSio2K6T6qQfEefbdwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCnPWFl8iQFp3t+Eymj9WgPSQ19XJcjpavZHbVA9UOxc1ZxwYCUlbudcNS4GIczpV
	 nITcCz0N9yGvLRArQutj1Pq13ot/w6/w4KKdguHxpm0ZQbgQer09t2oNbEzRZhFiyq
	 UzXOMzz0rS45pz1whwmBw42lvJ6QsLZ4jF0A9jyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marek Vasut <marex@nabladev.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 074/474] net: ks8851: Avoid excess softirq scheduling
Date: Fri, 15 May 2026 17:43:03 +0200
Message-ID: <20260515154716.642044812@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: AC8D3552ED0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248105-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nabladev.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -389,9 +389,12 @@ static irqreturn_t ks8851_irq(int irq, v
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



