Return-Path: <stable+bounces-272243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t3K7DFe6S2onZQEAu9opvQ
	(envelope-from <stable+bounces-272243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 16:23:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 059EA711E79
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 16:23:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=bVrbbLoQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272243-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272243-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0C7C31A0BD2
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC623793AD;
	Mon,  6 Jul 2026 14:02:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9293749F5;
	Mon,  6 Jul 2026 14:02:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346551; cv=none; b=IgVTg0M7R/rZqOEe/ZRhIdMpnupbzEWgwcDX0aBzt2zEG6ji3MQ2uqYkTkb+3Yb52NYY0R1YMdUsZ1O/qzRCDFRFXJFxw1Tf79CvFZ2H5w0bippTNNNPGJvcmCmplSRhsJok9r2oaW62uHZ+T9LS1R9H/sD92ANb+XJbi+oUe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346551; c=relaxed/simple;
	bh=8Rpe+J7dIpaIyBcpK0349gl9Z47YAALum6ZWmue+hjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FigNabXx2tTfma5ccjY18bORAavRc7WU3vH2ybweTnOE69kH2y3zpsJ1A9lH9DgHOGT5iIGa8TAzgD14hWs+NtXJnTO/Dq5D27WUigM0kod3M1n7c7+nsPEfewi2ie77itmrUP5BXaRlC2rpdTEIwQxZgG67EEiSALRn1LvPyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVrbbLoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AECBC2BCF6;
	Mon,  6 Jul 2026 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783346551;
	bh=8Rpe+J7dIpaIyBcpK0349gl9Z47YAALum6ZWmue+hjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bVrbbLoQv4GabRkZKBSxTLYpKdpnCZVJTqmdDainGMTYaA7FV9Jl0PRnyBzRCh0RE
	 IqR3LgXCIdsMViVa3/QFbSmn5uZoPWufVTROeyInrn9m88RQiShl9AHhULCwiAwtUx
	 p5L54uvfJs4JwNM6PLB619DmF+tbLIr5KIQ+3Z0wVhqKxPXDFGYtmZsRNta5DrL2/m
	 KI7QnhgPr0QRYcWSkhzYmxwZ/+QtJmCwygx9GC9zMDBapxA4M9bObWMB4neFJilK4e
	 W2DAWDIBpvyaiB2C7L3Jr5lwnHFiSDhzj2nJP2yq8wW5t4sSyumoc3p0t4OmicEMMv
	 UvBmfI9JalxhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCFBC44502;
	Mon,  6 Jul 2026 14:02:31 +0000 (UTC)
From: Christian Taedcke via B4 Relay <devnull+christian.taedcke.weidmueller.com@kernel.org>
Date: Mon, 06 Jul 2026 16:02:15 +0200
Subject: [PATCH net 2/2] net: macb: mask TXUBR during TX NAPI poll to
 prevent IRQ storms
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-upstreaming-macb-irq-storm-v1-2-ab3115b5a13a@weidmueller.com>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
To: christian.taedcke-oss@weidmueller.com, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kevin Hao <haokexin@gmail.com>, Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Robert Hancock <robert.hancock@calian.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783346550; l=3260;
 i=christian.taedcke@weidmueller.com; s=20260702;
 h=from:subject:message-id;
 bh=qBAhD1fzYGVIv2HSHAY5AonQugiJMQCwmywRThD7Rc4=;
 b=lcab6wkUlVeW0bvlaxZSpaBZqBvr6Zx9OuvIStOIGAmSoiW9ZJf6A8IlFCP42Kzx4ozF9l8b3
 OSRsiux4tV7AmDByrJMRhxrRmeXmwTNs9x4S9R9JnCKcYZc351QLXnW
X-Developer-Key: i=christian.taedcke@weidmueller.com; a=ed25519;
 pk=fVCoBhFV3uMogA2nxIOU/rynNY+O2TDJgWvWjR06TrQ=
X-Endpoint-Received: by B4 Relay for
 christian.taedcke@weidmueller.com/20260702 with auth_id=847
X-Original-From: Christian Taedcke <christian.taedcke@weidmueller.com>
Reply-To: christian.taedcke@weidmueller.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke-oss@weidmueller.com,m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:haokexin@gmail.com,m:horms@kernel.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:robert.hancock@calian.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:christian.taedcke@weidmueller.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[weidmueller.com,bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,goodmis.org,calian.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272243-lists,stable=lfdr.de,christian.taedcke.weidmueller.com];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[christian.taedcke@weidmueller.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,weidmueller.com:replyto,weidmueller.com:mid,weidmueller.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 059EA711E79

From: Christian Taedcke <christian.taedcke@weidmueller.com>

macb_interrupt() defers TX completion handling to NAPI, but when it
schedules the poll it only masks TCOMP, even though TXUBR is enabled
alongside it (both are part of MACB_TX_INT_FLAGS). macb_tx_poll() is
asymmetric in the same way and only re-enables TCOMP. TXUBR is thus
left unmasked while responsibility for handling it has been deferred
to NAPI.

Unlike an edge event, TXUBR is a persistent condition: the controller
keeps it asserted for as long as the transmitter reads a buffer
descriptor whose used bit is set. Leaving a level-triggered source
enabled while NAPI owns its processing means the interrupt refires
immediately after the handler returns, before the poll has had a
chance to clear the underlying condition. This turns into a hard
interrupt storm that pegs a CPU in the (threaded) MAC IRQ handler and,
on PREEMPT_RT, triggers RT throttling ("sched: RT throttling
activated"), taking the network interface down.

Several situations can keep the used-bit read asserted across a poll -
for example unreaped completed descriptors still sitting at tx_tail,
or a transmit restart racing with macb_start_xmit(). The specific
trigger does not matter: as long as the source stays unmasked, any
persistent assertion is enough to storm, so the interrupt handling
itself must be made self-limiting.

Mask TXUBR together with TCOMP in the IDR write when scheduling the TX
NAPI, and re-enable both from the napi_complete path in
macb_tx_poll(), making the TX interrupt mask/unmask symmetric and
consistent with how the driver already treats every other
NAPI-serviced source. The pending TXUBR is still recorded in
queue->txubr_pending before masking and acted on by macb_tx_restart(),
so no event is lost. A persistent TXUBR now degrades to NAPI-paced
polling instead of a CPU-pegging hard interrupt storm.

Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b11cb8f068b7..f75cf2ffdf6f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1971,7 +1971,7 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 		    (unsigned int)(queue - bp->queues), work_done, budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
-		queue_writel(queue, IER, MACB_BIT(TCOMP));
+		queue_writel(queue, IER, MACB_BIT(TCOMP) | MACB_BIT(TXUBR));
 
 		/* Packet completions only seem to propagate to raise
 		 * interrupts when interrupts are enabled at the time, so if
@@ -2161,7 +2161,8 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 
 		if (status & (MACB_BIT(TCOMP) |
 			      MACB_BIT(TXUBR))) {
-			queue_writel(queue, IDR, MACB_BIT(TCOMP));
+			queue_writel(queue, IDR, MACB_BIT(TCOMP) |
+						 MACB_BIT(TXUBR));
 			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP) |
 							MACB_BIT(TXUBR));
 			if (status & MACB_BIT(TXUBR)) {

-- 
2.54.0



