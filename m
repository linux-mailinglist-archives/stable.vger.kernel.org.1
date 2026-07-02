Return-Path: <stable+bounces-271388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /n2NNmOdRmrLaAsAu9opvQ
	(envelope-from <stable+bounces-271388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:18:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C96FB354
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:18:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=m6s+hVK+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271388-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271388-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6ABB6318F73F
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3EC26F46F;
	Thu,  2 Jul 2026 16:56:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91E3346BE;
	Thu,  2 Jul 2026 16:56:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011413; cv=none; b=g2KKxAcTtIP0iBmLgOJ4d820Q9SK38umsEpuj/eh1wCSWSmyZ/+YpGeO6OnV8xkItdOwLR6gtgEs714GCOgrt0IWAj8y/Us0dTDv/7rimzndjC7mf98XUGHk8gd8aJpAJQatLce3ppD2IQT0YiJ0mCyYhAdd6w2KSnQ+MrpXHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011413; c=relaxed/simple;
	bh=vMkG/SyZdbYEKscfr81DqBAEhctEFrlpcB54BgikU3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIe0RrLXsvIV5xVEfWJbMNdiDs7fsLcheM+pMRC2WJOV4yb6cre3C/0/coPjtt/nAryCkuwUnyrD0NrO7ULBl/t2ZzbLwVeoEWId4lv59Dz4aOF2U8lu1oru0WPNavnXQqgoVhNd5FlWYW3N3OA1uKCPPJHqskyeWXQLa2twW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m6s+hVK+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C345D1F000E9;
	Thu,  2 Jul 2026 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011412;
	bh=0C4CYObpwjBUc+clpWlZkvbtYHgYOnCA/Ux4b4ZU6hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6s+hVK+V1aNNiEiyzfhoqEG04Y+GrakhPka6XOw6LVkyvcBgbl4/kFdck55Q8/ys
	 0jAKGiOeJDvJ4+ArxLEImG6eRUH0e76jwpJVkbkgoPao1hPL/YTnayhyWXwkYmDv2Z
	 +xhLsQCtuEE0IpYJ7pbsZ9pzFf+5HJmFWnjFGhfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH 6.18 055/108] wifi: rtw88: increase TX report timeout to fix race condition
Date: Thu,  2 Jul 2026 18:20:52 +0200
Message-ID: <20260702155113.248936349@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
References: <20260702155112.110058792@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271388-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[realtek.com:server fail,msgid.link:server fail,linux.dev:server fail,sin.lore.kernel.org:server fail,vger.kernel.org:server fail,linuxfoundation.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pkshih@realtek.com,m:luka.gejak@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linux.dev:email,realtek.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E80C96FB354

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luka Gejak <luka.gejak@linux.dev>

commit c80788f7c5aed8d420366b821f867a8a353d83a5 upstream.

The driver expects the firmware to report TX status within 500ms.
However, a timeout can be triggered when the hardware performs
background scans while under TX load. During these scans, the firmware
stays off-channel for periods exceeding 500ms, delaying the delivery of
TX reports back to the driver.

When this occurs, the purge timer fires prematurely and drops the
tracking skbs from the queue. This results in the host stack
interpreting the missing status as packet loss, leading to TCP window
collapse. In testing with iperf3, this causes throughput to drop from
~90 Mbps to near-zero for approximately 2 seconds until the connection
recovers.

Increase RTW_TX_PROBE_TIMEOUT to 2500ms for RTL8723DU. This duration is
sufficient to accommodate off-channel dwell time during full background
scans, ensuring the purge timer only trips during genuine firmware
lockups and preventing unnecessary TCP retransmission cycles.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Cc: stable@vger.kernel.org
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260518142311.10328-1-luka.gejak@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw88/tx.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -196,6 +196,7 @@ void rtw_tx_report_purge_timer(struct ti
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
+	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -207,7 +208,11 @@ void rtw_tx_report_enqueue(struct rtw_de
 	__skb_queue_tail(&tx_report->queue, skb);
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 
-	mod_timer(&tx_report->purge_timer, jiffies + RTW_TX_PROBE_TIMEOUT);
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8723D &&
+	    rtwdev->hci.type == RTW_HCI_TYPE_USB)
+		timeout = msecs_to_jiffies(2500);
+
+	mod_timer(&tx_report->purge_timer, jiffies + timeout);
 }
 EXPORT_SYMBOL(rtw_tx_report_enqueue);
 



