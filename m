Return-Path: <stable+bounces-233468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMVDOq9G1GnVsQcAu9opvQ
	(envelope-from <stable+bounces-233468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:50:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF83A8546
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFF3C309A0F5
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 23:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F503A254A;
	Mon,  6 Apr 2026 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIhHXCIk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5439FCC1
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519275; cv=none; b=ZqCTX2UQfKr7h0J6sZjBbVCl+R+d8vng3GEIeK0QKknawTErqwhAh81+6OvAeGfrRz7GNZgKw74J6vMDZQqmpmNNOBVVcKAXJLHyNdlhDXIUIQ36Y99dJKbT1rgsmHZ5D5rGTm8Qa2c3iCnrM8ga2Jv188swzU/pL5ZXUNbzGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519275; c=relaxed/simple;
	bh=ypYe838aBMkoRP5LrhnDA0C7q+59eJdK7nUE9OS0I+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwL+rZuJ9TPTPFlTwrNQaQTznH0Tf9PBz2gU6GwMALEajK/1/JLANqvaxQbPDExQ4korHrxPGbAR3i49psUgVZfb3umwfMBxuEsZh/8m9ZyZD1yX84rJJ6aBcmMjqAsn4myov+9YgMDIF+YiD7aCY/YSVlrCpisySsL+/ZsTlAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIhHXCIk; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6501d242e3fso4267311d50.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775519273; x=1776124073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KdrZYGFBLENkuuWfE8lxm9EDeQduu0FD0OZSAlkc/o=;
        b=WIhHXCIk2e7SGemfPLwSnwlbK46OFp561NMIx8VZunNfeHMvk7YzVnfXMQtfzkom1F
         c6DsqrNHVH0/w4wW9YdJauZNw7dMnu0LqgAxjVIr2yyji5t+xdrkjBg9dxdO2oLnWTMD
         vt+EAxE+VOCrCTLj8BAAG50e+8WMvZSY6o8+z2sudFs+PCPY517Wn88hUZ/mD3eA34xR
         VW55YMEv5msNz8LUP4dw6afKq7eHKpNb759AdOzwDMTxXsROzPDDLnGYlCxtA1vtHOgf
         uI+4nflQUbso8Xnrk2bHNPM0816a0US5gi3lOh3m444EWM6ohgGsvgmk75eTXXMiLe1e
         vY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519273; x=1776124073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8KdrZYGFBLENkuuWfE8lxm9EDeQduu0FD0OZSAlkc/o=;
        b=LCwVUxtJE23rYvI+8M+v7ODIL+0I3H3PKuPHPIbHy2izZtPEdju+Fk6cYkysN1efQN
         UXw9KOeaRoMWHDSLcPgQ1Nmt7kM1AmvAeGNXQLNXf6sPq5OtU/4cFl6WP0FHtPVimTWx
         Sz08+KRcABQXQG2eRQYIu5VjwFFmtdmWM3FnuJbzWHw4kINhDJDnPqObjrNs/sfn5hFm
         NBA37K3QyD9SrUIljDlhmG0nqiEUSo5BZnBU8u0zcwkoIKbiMy0wr5RrGciLcHW10+of
         w0hYAWZG89U9Ykuo99+eDssZ8AmknproRtRARFqVPWve3NLuCXOYeJJgt3eSklSrz1WO
         +pTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOGmb0AwUULj30EQ6/PIEFu801Nbw4oSQcJTl1cmrWUEGizPxvzgROKQeXj/kSgj2MdhIsy1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDiEy2quXsWxByMHg46mXJGUOhXffpTTuPIncAU5HMjgMPDFa
	tmhl8wJ74x5i0HZeudZHaYjSyOfUzVALau32nM95ozHRf4G2Txziz+Wa
X-Gm-Gg: AeBDieuu7lAzJdusOfJ9lVxQMrMZx17zkV62yTQ9YuKIUCO+jPKyWug8hynAGJM7It1
	+aY899Ee571hkRnwbXhkMpN6aNtu8IEpEv026ZDDDP2z13ysbB9oC9MYwZzzwSAjXe+W/NJR0Kj
	0g2IUx7jrQoKuwijCto8mHJBMFcZwDrBt2nsTwvc2CSKWMTPtc32bzBVOtnc92FVrqvxROch46Z
	doY76Da5iyuUKoXqLyfzi9N1LPrglJ8p30XQxRErcikguxT1w0JnWtGhtJm3ZLtca3zREvloDbe
	q34RefFuQCCe3YKtCLiKdGJK7SO7fJmJWx0szl69U64o0rhTwq0A1W7w44op5nhlZwAa3YJwfG3
	GLdi6tXoJVMMHNULKBY/sGJWEfSjVkvlVpxg/nfZpBwZRcdEsX2/btE/XQ5QyEM2+5moxFqzOhF
	Zx8CVfyPr35fWqquGm/kIuWqHSYMFG4HZ2vfF/iCeY27avr1Esh35p7Jyoau8U
X-Received: by 2002:a05:690c:e04f:b0:79a:c93f:4acb with SMTP id 00721157ae682-7a4d6449755mr121970347b3.54.1775519273502;
        Mon, 06 Apr 2026 16:47:53 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff31sm59350177b3.6.2026.04.06.16.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:47:53 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless 4/4] wifi: mt76: mt7925: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 19:47:39 -0400
Message-ID: <20260406234739.29926-5-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233468-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 91AF83A8546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fourth receive chain RCPI uses GENMASK(31, 14), an 18-bit mask
spanning bits 14-31. It should be GENMASK(31, 24), an 8-bit mask
for the fourth byte, consistent with the other three chains and
with the RCPI3 definitions used elsewhere in the driver
(MT_PRXV_RCPI3 and MT_TXS7_F0_RCPI_3 both use GENMASK(31, 24)).

On devices with fewer than 4 antenna chains, the corrupted value
is masked out by antenna_mask in mt76_rx_signal(). On 4-chain
devices, this produces incorrect ACK signal strength readings.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 6334019249..85e91ca84f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -144,7 +144,7 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		mlink->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
-- 
2.43.0


