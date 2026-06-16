Return-Path: <stable+bounces-264600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z7e5F3h5MWoXkQUAu9opvQ
	(envelope-from <stable+bounces-264600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:27:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C83692187
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:27:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=m6X0jSQl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264600-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264600-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE75D3109ED6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A16E46AF1B;
	Tue, 16 Jun 2026 16:19:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF337DEBF;
	Tue, 16 Jun 2026 16:19:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626760; cv=none; b=sbjXAEXf1/9aMxk4Z1uEcfUbqGb7arACCjOjWwP6qC8MlPb0MvxHCtES07uPdHwTdyJkK5t1u99GPYpVVNH4aP7fYu9vjn2MVhKNJ9mhEUKU/GuPsmxGgxBOVZF4bagV6d2axeSZ59ugVj2sqJfNRPc2tnWiyaKPYUGTfDzBVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626760; c=relaxed/simple;
	bh=oE4Xis7MnO8TQ4yuLllR4NZ4shnfMOrtt1PPlelwHMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlLarFkTItjdPINrd1DW4N+xioZ77RU+Ek57CUGMc38IaBMASRvCR7nMmEUqP8YH56fEj3KvPRoQro0yNHaerPfsb/eoR6eYGMyO4pCbgynC0LpEmJ93XeNXdmAgWUUHL7Dv9ZZF3CJYBM/tmrE0e6DIrUbc/SB9uQjXdfxpxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m6X0jSQl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540631F000E9;
	Tue, 16 Jun 2026 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626759;
	bh=9dGPpokWgJrPjX+CFbuXrsKyzOvaf41CeRyvfHEeTA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6X0jSQlvtH6lj2yQLpnvMKEJy/i1lPwF1I9DMHCEZ2ZMdhFxS0WuXBjtjMrSGzNg
	 pBdQxmE/fkq3eCj1AGjTknd0GIdGhTWO16OT0HfqGYU3k9DF/NWO9pa5y5MHKaMfeq
	 WIOagWDdiLeq+SRHbNQIEjs8TI1THw6gmZoRp2b0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>,
	Oscar Maes <oscmaes92@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 031/261] pcnet32: stop holding device spin lock during napi_complete_done
Date: Tue, 16 Jun 2026 20:27:49 +0530
Message-ID: <20260616145046.494497613@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,lunn.ch,gmail.com,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-264600-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andrew@lunn.ch,m:oscmaes92@gmail.com,m:aleksander.lobakin@intel.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,lunn.ch:email,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5C83692187

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oscar Maes <oscmaes92@gmail.com>

[ Upstream commit 73bf3cca7de6a73f53b6a52dc3b1c82ae5667a4d ]

napi_complete_done may call gro_flush_normal (though not currently, as GRO
is unsupported at the moment), which may result in packet TX. This will
eventually result in calling pcnet32_start_xmit - resulting in a deadlock
while trying to re-acquire the already locked spin lock.

It is safe to split the spinlock block into two, because the hardware
registers are still protected from concurrent access, and the two blocks
perform unrelated operations that don't need to happen atomically.

Fixes: 5b2ec6f2be51 ("pcnet32: use napi_complete_done()")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://patch.msgid.link/20260528140320.5556-1-oscmaes92@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pcnet32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 72db9f9e7beeae..81cb83caf62a15 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -1403,8 +1403,10 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
 		pcnet32_restart(dev, CSR0_START);
 		netif_wake_queue(dev);
 	}
+	spin_unlock_irqrestore(&lp->lock, flags);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		spin_lock_irqsave(&lp->lock, flags);
 		/* clear interrupt masks */
 		val = lp->a->read_csr(ioaddr, CSR3);
 		val &= 0x00ff;
@@ -1412,9 +1414,9 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
 
 		/* Set interrupt enable. */
 		lp->a->write_csr(ioaddr, CSR0, CSR0_INTEN);
+		spin_unlock_irqrestore(&lp->lock, flags);
 	}
 
-	spin_unlock_irqrestore(&lp->lock, flags);
 	return work_done;
 }
 
-- 
2.53.0




