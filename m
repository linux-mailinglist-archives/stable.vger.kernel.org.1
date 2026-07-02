Return-Path: <stable+bounces-271055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8gU+DImYRmprZgsAu9opvQ
	(envelope-from <stable+bounces-271055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:57:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAE36FACBB
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:57:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=KuP9QH9u;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271055-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271055-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 721233329E7E
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364593546D2;
	Thu,  2 Jul 2026 16:42:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4E346A10;
	Thu,  2 Jul 2026 16:42:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010552; cv=none; b=AV3FexcZdUtlogpKvGN9B8m4fUbyWKe1pU3Wu7zcAuhtp17mvyl2tD4elkdlEAModBhsi66huJIB8YLloX/WlZLnTyD+7S/Bm+VXRKHwNzyUJ4JOO8DqnhdzpulbtrzgC1zPW2beYsfXPMoyKf0QYldI2PdZlNHDK7fRC4QS4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010552; c=relaxed/simple;
	bh=WRA717yVKYf4OM1BDkKTPWN2WTLxgzw+qauitHi9MFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jhi/jqrfIMlEz1CZwca31RkiOS9CK6Zm5GXtX2BBtbGfY/oC5pJo8SOB5evODRG4FBTqXR2XclOfz4HZQviCNozPtqlBEtNombDnug45qPa4HZLsj6XA4gOI2rr8BErWPNt+aO8PsKXrGkaW9sYneghIabuyXUIQsX5mnpbkqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KuP9QH9u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314BA1F000E9;
	Thu,  2 Jul 2026 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010550;
	bh=WCuChUTme0t2IXZF8TjKrDsVuME3RDN8wy8/lZV4aiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KuP9QH9uRMjViZP5ZF+6sMM0pNi/eFNaHFvOgesvXMz0DxXK1uhxeuOgFy/DE03TM
	 nXi8sYGWRKcm2RhbvrLIgLEHuEZP9xDSZ4Y329CM6KtDfb1LbPxn2Nxr9EfLxcQU8u
	 eljR+Xc3GBvuyb5YYIoUwy8B+NsvVkbfghKosgQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 6.12 150/204] wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor
Date: Thu,  2 Jul 2026 18:20:07 +0200
Message-ID: <20260702155121.801830752@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271055-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rtl8821cerfe2@gmail.com,m:pkshih@realtek.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,realtek.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DAE36FACBB

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

commit 83d38df6929118c3f996b9e3351c2d5014073d87 upstream.

Bit 28 of double word 2 in the RX descriptor indicates if the packet is
a normal 802.11 frame, or a message from the wifi firmware to the
driver (Card 2 Host).

Commit f5678bfe1cdc ("rtlwifi: rtl8821ae: Replace local bit manipulation
macros") mistakenly made the driver look for this bit in double word 1,
causing packet loss and Bluetooth coexistence problems.

Fixes: f5678bfe1cdc ("rtlwifi: rtl8821ae: Replace local bit manipulation macros")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/04da7398-cedb-425a-a810-5772ab10139d@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
@@ -291,7 +291,7 @@ static inline int get_rx_desc_paggr(__le
 
 static inline int get_rx_status_desc_rpt_sel(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__pdesc + 1), BIT(28));
+	return le32_get_bits(*(__pdesc + 2), BIT(28));
 }
 
 static inline int get_rx_desc_rxmcs(__le32 *__pdesc)



