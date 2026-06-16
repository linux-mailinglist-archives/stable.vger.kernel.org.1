Return-Path: <stable+bounces-264320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tK6oORJzMWqYjgUAu9opvQ
	(envelope-from <stable+bounces-264320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:00:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 870A46919CB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:00:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sHMY7vas;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264320-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264320-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EA5B304E637
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712CE44D6AB;
	Tue, 16 Jun 2026 15:54:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25444CF4E;
	Tue, 16 Jun 2026 15:54:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625295; cv=none; b=N1JgKLSNenFidVZjQrMH3/YTvAmdjVNyMm7iySEef9FkhUr35XgPp0nv/pYZ86uaUflxCpdkoEmI0uVy+MuSdDcBOdQIRsFD3SM9WeBSzPCrD3wWrD1d/crLNWGE+Sv9zf/XPJvlZHt97KzXpaNfQvjOcDwiFlwu99NWIjVmK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625295; c=relaxed/simple;
	bh=F4tr9gRmwFO4zTvpWPP+HUsYXto1XA9AAE7KHInQqWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osDEbwWdGsoX2Xx7aR0PkcDsMNuuSB4axQ4hOGE38uB/ruuwaQHrMqA4kPF5QWGjx1SJJrL3OkT55HLBaAo2FGXtkVRURPUKt0lJ/PQJTTRL+pd2zNumm05RA6KIbTZINh+yqNQK7hQeLRywpym2DfqYhblt/z2UpVNIS79w4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sHMY7vas; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D4D1F000E9;
	Tue, 16 Jun 2026 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625294;
	bh=cD3WRKoJ2+ogYR+eEhUZk02Mjoo718x2HXATnyvXi+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sHMY7vasFmcGeo6FPxdpQJbFbAKf1taF4beN66jpewg+w/ASAWzCmqvBON1g7jBZ9
	 ePu2WZPDNJTV2auWboFwCr2FHFcKpkitaBI22TF8rXNvP7wGSoJFHkkRNj1qZtk2lc
	 DFIag/18JB/iU57Q1Avy/h2rj/eq9SEOyTjHlJIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 113/325] net: mctp: usb: dont fail mctp_usb_rx_queue on a deferred submission
Date: Tue, 16 Jun 2026 20:28:29 +0530
Message-ID: <20260616145103.331554696@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264320-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jk@codeconstruct.com.au,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,codeconstruct.com.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 870A46919CB

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Kerr <jk@codeconstruct.com.au>

[ Upstream commit 881a3113b74964918cdd72747e3bc119c02b0c0c ]

In the ndo_open path, a deferred queue open will report a failure, and
so the netdev will not be ndo_stop()ed, leaving us with the rx_retry
work potentially pending.

Don't report a deferred queue as an error, as we are still operational.
This means we use the ndo_stop() path for future cleanup, which handles
rx_retry_work cancellation.

Fixes: 0791c0327a6e ("net: mctp: Add MCTP USB transport driver")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Link: https://patch.msgid.link/20260608-dev-mctp-usb-rx-requeue-v2-2-29a3aa507609@codeconstruct.com.au
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mctp/mctp-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index cf6f6a93a45112..fade65f2f26995 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -154,7 +154,7 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 	if (!mctp_usb->rx_stopped)
 		schedule_delayed_work(&mctp_usb->rx_retry_work, RX_RETRY_DELAY);
 	spin_unlock_irqrestore(&mctp_usb->rx_lock, flags);
-	return rc;
+	return 0;
 }
 
 static void mctp_usb_in_complete(struct urb *urb)
-- 
2.53.0




