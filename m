Return-Path: <stable+bounces-214855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ/PD1xNiGk/ngQAu9opvQ
	(envelope-from <stable+bounces-214855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 09:46:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6994E1081E9
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 09:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD0E73002B58
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE32287257;
	Sun,  8 Feb 2026 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5oQSdn+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552F3EBF0E
	for <stable@vger.kernel.org>; Sun,  8 Feb 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770540373; cv=none; b=LgXqL5hspX1U7e4B6iGL1DbvzQUZ/GeEXTFPihLDUpEo+K1sDTU2oM7Eb9aCq2/jY1fU5BRVB5nntWamSrPtLIkHL+YT8XKEfMeuYMRAwQg5csBcNMfXt5Chk6m6s7spgRzQWZrCIcO2v++Cyv1k7gr9YUyFn7msu3+6UnJvFHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770540373; c=relaxed/simple;
	bh=2e0EXJLezC+U7RDad0XYBISKvEANwX/bP3nNd9YZC+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YaT9W75jXw73OcdfOM31v4wSWaJxDs+7InaoayhCEs09MsfLZMTLukQ/ceorXWQVHO1Qar+CkRM6vomXqUysfZa1OeQJ79vm7JWyhCVMQWnF7Cjp8BfFuAeNj7MngiI89N6B82xdCS7RRoqhp9Fj/J46cU4wts3fDVYEGzTrdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5oQSdn+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c532d8be8cso325520785a.2
        for <stable@vger.kernel.org>; Sun, 08 Feb 2026 00:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770540372; x=1771145172; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9uFXTWTe3FQE9PMCItY8FugMOI06BmDAK5p1HqHWHc=;
        b=l5oQSdn+n9W43I+d13LYSEmQbowR/bRIxrOtCcIECIGh5fKFLWkU9mmoZcyfjgroaU
         FSvNQ6tQyMqMmP0EeaN2EDjCrdNpZq+t0axYx2JVbKOjm7tIXbgXm3wUfXiHCRjQpX03
         xuKp4ejU+7Wk6oxWI+91Kap6IjlZAFvfOlLcF++dF9cUQW8Ym6j4rghqHMjuEJ1HELjb
         Mp2vZti0u9w2MYdb0tLP/bQxCNS3XG6kSZ6A7qGkvHPeU+tMY1d2hTzfETuOnG7bEcKb
         C5gvHmrteK7Ec9y6oyxjyvcLhdqEh6k0VmhfgEwmKkeQQvddyTOrCyxiVasyQBiqU1rc
         idWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770540372; x=1771145172;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9uFXTWTe3FQE9PMCItY8FugMOI06BmDAK5p1HqHWHc=;
        b=mMCbOrslK67iy1eAGnHdHOm4i11CO39bcDnfMgG+LyrhtAnj5g5lCo4imlQ8Fo16NS
         uky/uvXPFZ+6UzdRBbELxaJ7VIyu8gn6HLecjlAKdw/mmTpxLCiu2zk2yPhnz5RWVapr
         aArPqwUaWVD4Kzl51ZdNFogJx1oVTrNJbXfsLsB44Oy1eH7Yk6mY0orBQZleMVympU6R
         7wPYVdAvDHzPMmwA7pYeyuddX7+96QMiGrhyDTtvDwsUbUBUiMOmZvuT3g62a5esGgDq
         2Y8r4SdpQJaW6SihM/k9BS5WLirRc4e8mX6kyMkpggVuw0eHQGjtTMoQTrt9M0rrNgez
         GK5g==
X-Forwarded-Encrypted: i=1; AJvYcCUj/E+N3bxD/DVvhZwaDWD8ZWNO0FX9ZZ2CgXgMDBo87Bj3k6IMaRihKRe0KZirdoX7FH1blvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDB+1QmmhEPbkuuSaL9eTNtQZfvmjcSQrtQjSxXk/R43fUQr2
	lkE7p6JxDKBNaQYFojFF1pk26lDpyDivRp+37tdOOo3dXDeS0FPVKBMo
X-Gm-Gg: AZuq6aKi7yePfQF44a7tcYxOJrcbrktCGFzXtolZIXAn1exxbYSp458Umavns+nMWlS
	TeJa3cCpAfLm97OHQdGS9VFcxMTreZBKDut2sMBpkVOoKEswK4nQTdvp1NKhoHU9IB794/tzNbU
	HggnI7b88Z8Pa34bslSDFqdQqWQiWUskDvE65QemmVQoJh49cMs9L2oOXmZaU+vqjTJOvaSdQSu
	E3SXSGwaHbov+4u9txeYjVaBMrjbMdVZa9wWAqZI3E2V8hemN5YMsP813S1VzLgoY1Xtru64qng
	xqLk8nSKAdFqa3aDBw+KmL6zb0KQe14q+Ds4w2vF+1FllcHTisZazMTmPpqD7CO1sSuKXNtyfx/
	yRHqvAWH5QS3ifh3qCEhWc2Ix+R6fItLe1iFcbUNPEeZY7ebZ+b7owpZ4iYT8x65MD3R6oLiPs6
	eGz6GjzShMhsGb8TZG+epXT9g6t/vJsDBY
X-Received: by 2002:a05:620a:a50e:b0:8cb:104b:bef with SMTP id af79cd13be357-8cb104b0fd2mr135040885a.88.1770540371624;
        Sun, 08 Feb 2026 00:46:11 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a157f8sm556103985a.30.2026.02.08.00.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 00:46:11 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 08 Feb 2026 16:45:52 +0800
Subject: [PATCH net] net: macb: Fix tx/rx malfunction after phy link down
 and up
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-macb-init-ring-v1-1-939a32c14635@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD9NiGkC/x3MQQqAIBBA0avErBswpYSuEi3UpppFU2hEIN49a
 fkW/2dIFJkSjE2GSA8nPqWiaxsIu5ONkJdq0EoPSiuLhwseWfjGyLKhV2SsN87YvocaXZFWfv/
 hBEI3zKV8+VUdW2UAAAA=
X-Change-ID: 20260207-macb-init-ring-b0e37b3a3755
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Xiaolei Wang <xiaolei.wang@windriver.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,windriver.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-214855-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 6994E1081E9
X-Rspamd-Action: no action

In commit 99537d5c476c ("net: macb: Relocate mog_init_rings() callback
from macb_mac_link_up() to macb_open()"), the mog_init_rings() callback
was moved from macb_mac_link_up() to macb_open() to resolve a deadlock
issue. However, this change introduced a tx/rx malfunction following
phy link down and up events. The issue arises from a mismatch between
the software queue->tx_head, queue->tx_tail, queue->rx_prepared_head,
and queue->rx_tail values and the hardware's internal tx/rx queue
pointers.

According to the Zynq UltraScale TRM [1], when tx/rx is disabled, the
internal tx queue pointer resets to the value in the tx queue base
address register, while the internal rx queue pointer remains unchanged.
The following is quoted from the Zynq UltraScale TRM:
  When transmit is disabled, with bit [3] of the network control register
  set low, the transmit-buffer queue pointer resets to point to the address
  indicated by the transmit-buffer queue base address register. Disabling
  receive does not have the same effect on the receive-buffer queue
  pointer.

Additionally, there is no need to reset the RBQP and TBQP registers in a
phy event callback. Therefore, move macb_init_buffers() to macb_open().
In a phy link up event, the only required action is to reset the tx
software head and tail pointers to align with the hardware's behavior.

[1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm

Fixes: 99537d5c476c ("net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index effef67d80731e5cc795fcef5adc280ad931eda9..43cd013bb70e6bd08a31a0826364e4f34c0e0b89 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -705,14 +705,12 @@ static void macb_mac_link_up(struct phylink_config *config,
 		if (rx_pause)
 			ctrl |= MACB_BIT(PAE);
 
-		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
-		 * cleared the pipeline and control registers.
-		 */
-		macb_init_buffers(bp);
-
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+			queue->tx_head = 0;
+			queue->tx_tail = 0;
 			queue_writel(queue, IER,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
+		}
 	}
 
 	macb_or_gem_writel(bp, NCFGR, ctrl);
@@ -2954,6 +2952,7 @@ static int macb_open(struct net_device *dev)
 	}
 
 	bp->macbgem_ops.mog_init_rings(bp);
+	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);

---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260207-macb-init-ring-b0e37b3a3755

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


