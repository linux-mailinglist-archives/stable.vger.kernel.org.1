Return-Path: <stable+bounces-232907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPYoHu3vzWkzjQYAu9opvQ
	(envelope-from <stable+bounces-232907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:26:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73E383914
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDFD2303CF87
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 04:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B11361DBE;
	Thu,  2 Apr 2026 04:22:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428635F193;
	Thu,  2 Apr 2026 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103721; cv=none; b=kxJOVjbyHUl0sx7NH1+FB7r+rh4wNezGq2q2dAqR890euktMjMa7/t9xCx4EuhjN1XHuc4TckpZoGNYgMqd5P+7JxbLEZoEd98OGlncLM4rZbxA4PP3sA1gQETus4PHHsGF3LIS36odPGlw8VznVYmSFzyR3tUhAbTQbUmjkpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103721; c=relaxed/simple;
	bh=Ll+mejS5nwkcS0c9qW1Zj2uBUg2oi79+k8wAAp6wGS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8iR+tr7y3gl/JLToGaObVDJpfU2J3Yf/pV8pe5kDTb17n25cHJGPuZ+5B0bVYCuIMjsPtLP+RccvKfr5W62AyptnRKfmQeMiM0cD/BKrKalsHPZo0mmqGSnxmh+MjuTmTOplcSGmeuP385tup2CdOjGSn8Ur6qUcBWzfCx1CQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAAXvWjc7s1pfkzwCw--.800S2;
	Thu, 02 Apr 2026 12:21:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: netdev@vger.kernel.org
Cc: Lars Poeschel <poeschel@lemonage.de>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn,
	stable@vger.kernel.org
Subject: [PATCH] nfc: pn533: allocate rx skb before consuming bytes
Date: Thu,  2 Apr 2026 12:21:48 +0800
Message-ID: <20260402042148.65251-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXvWjc7s1pfkzwCw--.800S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryUuFWruFyxKFy5Jw43ZFb_yoW8Ar17pF
	Z3GF1rtryUXr47JwsrCw1rWFy5Ca4kAFWrGrWvka47urn3JFW3GFWaga42vFZ5XFWkXF4a
	vFWDXF48CFyrua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-0eJUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232907-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lemonage.de,zju.edu.cn,gmail.com,vger.kernel.org,iscas.ac.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 7F73E383914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pn532_receive_buf() reports the number of accepted bytes to the serdev
core. The current code consumes bytes into recv_skb and may already
hand a complete frame to pn533_recv_frame() before allocating a fresh
receive buffer.

If that alloc_skb() fails, the callback returns 0 even though it has
already consumed bytes, and it leaves recv_skb as NULL for the next
receive callback. That breaks the receive_buf() accounting contract and
can also lead to a NULL dereference on the next skb_put_u8().

Allocate the receive skb lazily before consuming the next byte instead.
If allocation fails, return the number of bytes already accepted.

Fixes: c656aa4c27b1 ("nfc: pn533: add UART phy driver")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/nfc/pn533/uart.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
index 6d2f520a5bc8..412d341602aa 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -211,14 +211,19 @@ static size_t pn532_receive_buf(struct serdev_device *serdev,
 
 	timer_delete(&dev->cmd_timeout);
 	for (i = 0; i < count; i++) {
+		if (!dev->recv_skb) {
+			dev->recv_skb = alloc_skb(PN532_UART_SKB_BUFF_LEN,
+						  GFP_KERNEL);
+			if (!dev->recv_skb)
+				return i;
+		}
+
 		skb_put_u8(dev->recv_skb, *data++);
 		if (!pn532_uart_rx_is_frame(dev->recv_skb))
 			continue;
 
 		pn533_recv_frame(dev->priv, dev->recv_skb, 0);
-		dev->recv_skb = alloc_skb(PN532_UART_SKB_BUFF_LEN, GFP_KERNEL);
-		if (!dev->recv_skb)
-			return 0;
+		dev->recv_skb = NULL;
 	}
 
 	return i;
-- 
2.50.1 (Apple Git-155)


