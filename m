Return-Path: <stable+bounces-232908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A9fDnDwzWkzjQYAu9opvQ
	(envelope-from <stable+bounces-232908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:28:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1C38394D
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66BA93067418
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 04:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72B93624D9;
	Thu,  2 Apr 2026 04:22:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A230C371;
	Thu,  2 Apr 2026 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103721; cv=none; b=HTPuPejwLPcNWM6sZ309AgHKxdo+/3fFsdQw3gjQEPg1WtfmhTVAR2Zc8NkGvJxkTLR0WQP9My9dVzpZIVIKmURbJeHd7p5QQf7nMuQc+ZQcps5ydfPAO2aeBklvs/Hj9nTNqCQ/mxKEfYM1CIqxY7JVn4jLWHCUSp4xeJdTKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103721; c=relaxed/simple;
	bh=PqEcBA2A5b9cJkiPpiRNEoBquqciKCg2vR5h3FlNsug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M8/v+WTL56i8VzSK8D3DwPhIbJ1jHT0jB5PkUFlRl0IekFa0OnQSCMejRfFm5+V5d5sjdRd10a32JcrI+SFi7MXxgkOm5ir8HsCH+Kj1JbMsaHQkj2jbG34RP5V891kmmItyP4KaDbmunYPkn97Zd8fNVC0TLefkiDSn12ytHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowADXfWnc7s1pfEzwCw--.40389S2;
	Thu, 02 Apr 2026 12:21:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bongsu Jeon <bongsu.jeon@samsung.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn,
	stable@vger.kernel.org
Subject: [PATCH] nfc: s3fwrn5: allocate rx skb before consuming bytes
Date: Thu,  2 Apr 2026 12:21:48 +0800
Message-ID: <20260402042148.65236-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXfWnc7s1pfEzwCw--.40389S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1rJrW3Aw1fJr13Ar4fKrg_yoW8AF4UpF
	45J3Wjqry8tr43J3WDCw18WFy5Ca4fJFW5Gry5Kw48ZrWfJrZ5JayI9Fyj9r4rXr4kWFW3
	AF4xJa1rC3W0vrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-232908-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AB1C38394D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

s3fwrn82_uart_read() reports the number of accepted bytes to the serdev
core. The current code consumes bytes into recv_skb and may already
deliver a complete frame before allocating a fresh receive buffer.

If that alloc_skb() fails, the callback returns 0 even though it has
already consumed bytes, and it leaves recv_skb as NULL for the next
receive callback. That breaks the receive_buf() accounting contract and
can also lead to a NULL dereference on the next skb_put_u8().

Allocate the receive skb lazily before consuming the next byte instead.
If allocation fails, return the number of bytes already accepted.

Fixes: 3f52c2cb7e3a ("nfc: s3fwrn5: Support a UART interface")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/nfc/s3fwrn5/uart.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
index 9c09c10c2a46..4ee481bd7e96 100644
--- a/drivers/nfc/s3fwrn5/uart.c
+++ b/drivers/nfc/s3fwrn5/uart.c
@@ -58,6 +58,12 @@ static size_t s3fwrn82_uart_read(struct serdev_device *serdev,
 	size_t i;
 
 	for (i = 0; i < count; i++) {
+		if (!phy->recv_skb) {
+			phy->recv_skb = alloc_skb(NCI_SKB_BUFF_LEN, GFP_KERNEL);
+			if (!phy->recv_skb)
+				return i;
+		}
+
 		skb_put_u8(phy->recv_skb, *data++);
 
 		if (phy->recv_skb->len < S3FWRN82_NCI_HEADER)
@@ -69,9 +75,7 @@ static size_t s3fwrn82_uart_read(struct serdev_device *serdev,
 
 		s3fwrn5_recv_frame(phy->common.ndev, phy->recv_skb,
 				   phy->common.mode);
-		phy->recv_skb = alloc_skb(NCI_SKB_BUFF_LEN, GFP_KERNEL);
-		if (!phy->recv_skb)
-			return 0;
+		phy->recv_skb = NULL;
 	}
 
 	return i;
-- 
2.50.1 (Apple Git-155)


