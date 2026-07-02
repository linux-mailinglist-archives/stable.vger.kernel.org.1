Return-Path: <stable+bounces-271389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jaauKgKbRmrDZwsAu9opvQ
	(envelope-from <stable+bounces-271389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:08:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 247CD6FB05E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:08:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="k/VG21m1";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271389-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271389-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F495304AB69
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A02D0602;
	Thu,  2 Jul 2026 16:56:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE130C141;
	Thu,  2 Jul 2026 16:56:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011416; cv=none; b=Ek64Vn6gZ/rKuKHpRzjeKjmDxn6P3lpiQNyCmKBYlezmXGl0By1EJDuHF/iwQ2j8ZTdPga9nsd1xqpdg+EAIid7Fi3tzofvHHtXCfOVdveE1ybdaN20b0FJci73Dfk83jGHwfdrPiSrEVMHySu42w+am9RWPS3HWxQRbuGF0jOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011416; c=relaxed/simple;
	bh=HnNX8Bw7x9jiUSMOPYH9BwMCbMeCrGBfHyYwYaP3zqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0sl2wWFDUmsE7/V1ewIFxb/KWI09uWssVI19+wUcoA70xQ2NAcr8LvpfzvFvZKZPq7gh/wt5dNGJ/ok8ze/cSbUOxCPQRR85Uu5oK7x0psUTwvNoy+5Ga0uH2BCnsl/GvmEwkRoaDd0l6zfBaqPhoEj/r0E/+vuvk4ecZsojM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k/VG21m1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B271F000E9;
	Thu,  2 Jul 2026 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011414;
	bh=TIkhj9iuwrJOYibdsdvLgm5beydfrL8UHyewWDahcs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k/VG21m1P9dN8Z7ffBYVCrhgvg7BDJYNaFspEM/3DVuFvV/8HWyOsNNll+zxjBdvJ
	 VhwZjNCo4tNOxWuey76XtSbOrLU8W/88ZsbjBL35oGyYbHIOtBzqS7SqWSJrhBou3z
	 pmJvSgBJjE5EzKu4z4C2mQFoSTE0F9QKmg5ItsMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH 6.18 056/108] wifi: rtw88: usb: fix memory leaks on USB write failures
Date: Thu,  2 Jul 2026 18:20:53 +0200
Message-ID: <20260702155113.269716571@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271389-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pkshih@realtek.com,m:luka.gejak@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,realtek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 247CD6FB05E

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luka Gejak <luka.gejak@linux.dev>

commit 6b964941bbfe6e0f18b1a5e008486dbb62df440a upstream.

When rtw_usb_write_port() fails to submit a USB Request Block (URB)
(e.g., due to device disconnect or ENOMEM), the completion callback is
never executed.

Currently, the driver ignores the return value of rtw_usb_write_port()
in rtw_usb_write_data() and rtw_usb_tx_agg_skb(). Because these
functions rely on the completion callback to free the socket buffers
(skbs) and the transaction control block (txcb), a submission failure
results in:
1. A memory leak of the allocated skb in rtw_usb_write_data().
2. A memory leak of the txcb structure and all aggregated skbs in
   rtw_usb_tx_agg_skb().

Fix this by checking the return value of rtw_usb_write_port(). If it
fails, explicitly free the skb in rtw_usb_write_data(), and properly
purge the tx_ack_queue and free the txcb in rtw_usb_tx_agg_skb().

The issue was discovered in practice during device disconnect/reconnect
scenarios and memory pressure conditions. Tested by verifying normal TX
operation continues after the fix without regressions.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Cc: stable@vger.kernel.org
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260518142311.10328-2-luka.gejak@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -399,6 +399,7 @@ static bool rtw_usb_tx_agg_skb(struct rt
 	int agg_num = 0;
 	unsigned int align_next = 0;
 	u8 qsel;
+	int ret;
 
 	if (skb_queue_empty(list))
 		return false;
@@ -456,7 +457,13 @@ queue:
 	tx_desc = (struct rtw_tx_desc *)skb_head->data;
 	qsel = le32_get_bits(tx_desc->w1, RTW_TX_DESC_W1_QSEL);
 
-	rtw_usb_write_port(rtwdev, qsel, skb_head, rtw_usb_write_port_tx_complete, txcb);
+	ret = rtw_usb_write_port(rtwdev, qsel, skb_head,
+				 rtw_usb_write_port_tx_complete, txcb);
+	if (ret) {
+		ieee80211_purge_tx_queue(rtwdev->hw, &txcb->tx_ack_queue);
+		kfree(txcb);
+		return false;
+	}
 
 	return true;
 }
@@ -518,8 +525,10 @@ static int rtw_usb_write_data(struct rtw
 
 	ret = rtw_usb_write_port(rtwdev, qsel, skb,
 				 rtw_usb_write_port_complete, skb);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
 		rtw_err(rtwdev, "failed to do USB write, ret=%d\n", ret);
+		dev_kfree_skb_any(skb);
+	}
 
 	return ret;
 }



