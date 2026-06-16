Return-Path: <stable+bounces-266342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id othKNlicMWqroAUAu9opvQ
	(envelope-from <stable+bounces-266342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:56:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33026694966
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:56:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=cocwMOVD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266342-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266342-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28BDC3251154
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74BF47D925;
	Tue, 16 Jun 2026 18:51:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B747AF68;
	Tue, 16 Jun 2026 18:51:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635919; cv=none; b=s1P63yzRget6hZa7rxysj960/EYFFjwjkVxxGaksJx+nGf90aWfU5dEQwWI9e1J26GBCTjfbXoCW+Z/GKOWPvgIOFgPqs8rdzphCv/ffSimF0LjBXb9DtQCvzKCXuQn/JPNs1xmINEQjMGffzeSn6V02G1pshfFLysHk6pKYo3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635919; c=relaxed/simple;
	bh=zbM/peYECVqRW3z9KyWPYXxCl0fZYuzKBEFksSNIODg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIoyAi86858sS9QDDSgldcaOIIRwOzX3U9nhKN5L9XHYG/Ww50zJlEzbsQVXihh7aY/lJlzECQfIA8CI6guyhJIH8qyV8b7iDZC7m0qNlTH/QKUpAsIgHwHIpaNAXcJ8SJ7xwUWvRcmfrs+C7Vzamp2GkqBLxi13GlB0T2X/Hnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cocwMOVD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B831F000E9;
	Tue, 16 Jun 2026 18:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635918;
	bh=+8eBlrKf0j5Zi1r4R01TyoBvcUM0trGaWSfiCUhoQHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cocwMOVDOCRqgttz+cUtYOziNYLbZYzY6Whu68Y60E7KheYsrTknB1xxrF0I54YTZ
	 fPOydrEqsUjS+Ra7ZAQ2dr0LF+1K4hfh1goKeBoxPnh9iZ4lOXtk730lkAEPqpXfk+
	 Ti0U8ag2l88gQ30QR26sbGouuzFfvNYHDbzyPav8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>,
	Oscar Maes <oscmaes92@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 141/342] pcnet32: stop holding device spin lock during napi_complete_done
Date: Tue, 16 Jun 2026 20:27:17 +0530
Message-ID: <20260616145054.753242649@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,lunn.ch,gmail.com,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-266342-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andrew@lunn.ch,m:oscmaes92@gmail.com,m:aleksander.lobakin@intel.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33026694966

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index f78daba60b35c0..ce5b8e6aa976f9 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -1399,8 +1399,10 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
 		pcnet32_restart(dev, CSR0_START);
 		netif_wake_queue(dev);
 	}
+	spin_unlock_irqrestore(&lp->lock, flags);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		spin_lock_irqsave(&lp->lock, flags);
 		/* clear interrupt masks */
 		val = lp->a->read_csr(ioaddr, CSR3);
 		val &= 0x00ff;
@@ -1408,9 +1410,9 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
 
 		/* Set interrupt enable. */
 		lp->a->write_csr(ioaddr, CSR0, CSR0_INTEN);
+		spin_unlock_irqrestore(&lp->lock, flags);
 	}
 
-	spin_unlock_irqrestore(&lp->lock, flags);
 	return work_done;
 }
 
-- 
2.53.0




