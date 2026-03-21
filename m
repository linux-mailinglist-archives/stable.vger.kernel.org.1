Return-Path: <stable+bounces-227770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFtqEoylvmlIVgMAu9opvQ
	(envelope-from <stable+bounces-227770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 15:05:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4E02E5AF1
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 15:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF44300E729
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 14:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A3C376BEB;
	Sat, 21 Mar 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeFLGVSz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9A29B20A
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774101895; cv=none; b=ON0dQzg651PuPS4V5BYyAOJ8frEILe9f2sAUWR4Do4SZREntjbIYYQ8ETlGEtMBYH8r1/pRUb7icB/bYDtDXyz72TiO+7kLcVGAIMZtcrpEQO+DNRLppx96cYjSgvXsAXQcgtx46wvehKHbPq1DjKDkVfWg1qxxiSDLM0rf73wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774101895; c=relaxed/simple;
	bh=mSvT+y8clzTOhPThviOFDBzfRLCBMitx9EaiglvxEKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qD5bc77ZEvYEX406RfmZ5iA4dqmEk7Rm/9HhpTymRS9nJcFZajtc5V+l8euqe2PA87t+YLUajvN2j3yFomf+a+b+FUkztcCuy36K4MY8Do/0bGpPcS7YUCWHGgLjxIgY3rV4/vy3IMkt++fE+nZJugmAqk49ammUqpb/bBLhmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeFLGVSz; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ca01dc7d40so322050685a.1
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774101893; x=1774706693; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HujQbWNKl1dXI3GIUvncn7itQFrKsr/dwYyMxUhgs10=;
        b=MeFLGVSzfAfxGOS3aBNzawLUjd6sGsUqPcOJKmzMbsYADyHtueNMxaTlYKi1AYKeNs
         4qmQ0nnezBfY4udgJ2G777/japUzYNnzHm7l45m7pboglDXT04a0OuhhwU9Km3HgBjnG
         7OekqTX1jMrJ7hq7eucWUj5BtVQNSrtg62GR0yes2zLv1Go6txbaDEpb/rKwTbdl5KzS
         VqsRd0JnmifutqbrD/tIgcJU2bprp6psiLOCR37+nKLohsO3AFZVz6CN+SaUcRx4ORXM
         70xUcTiTTSMDQ2H7od18wuVTUXlfkvyIFqBxiRQp+59r0QH0tdALzYmMe4Zz7KRNz6rP
         OfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774101893; x=1774706693;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HujQbWNKl1dXI3GIUvncn7itQFrKsr/dwYyMxUhgs10=;
        b=llbKBqbcmEbRsCmd3ZTGtTcLt6gs5jF/GHnVUAs+H69/nVqz3T8H4oOfx33wFZssYM
         ft2E8ZJC2YR2LAFV4NKNExH56z2ovcONSkVAzHKfwyDaHAIAwqbNpkgSz/p1MVaLvwb6
         h2Frij4jHlz2DI/7kxtYvZHKiw5wPbFKpZRRKcwCGrG7+SKy+utASv7IJf/1ofo3OGV4
         WGdEhVgkktI8Dbq8uYepaM4mAaSkHk+QNQ+SzUrulABEEXu036LT6TXjBHX/yH/m+V1e
         7rs9zVXyrv4TqB3chrTl4cE8vpu24LYy0026KVBJG9J1i6KXBv5aAFiP9XBdoRYhJw2k
         1ldQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLKwI5E6464164HxRLn9x2sA62LFPpu5+mIyVkGJvJLtnUv8s3+5rr7ggbIiGcvu8pHnbU0jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpqMUylI1MSlSMkGK/dupocqe7Vev1p1VZ6lnPx7ztlAl2ec3q
	zrWkPW5YbpemGQLCs+BkIO4IqJ26AmL9p7uptii3I+nTacV1wza/2F60
X-Gm-Gg: ATEYQzysvi32SLKdZJp9YrfZosfL5DN6avHR8hb8YJOXIa//UQwCC7NWpZSF27ngzSB
	s0cGXn8cm9DJYa5gSdjWpM5cTPjDZpLnWb6mxR5zgxYU7OaKBn7vExbuo75XUG1Cw1zALxZ2con
	paDC/B8qhZl1VfaaWY14UEXdOT/D3BTcbRFgzcLENIydY8AlF6k4sJCTQTZDnWFySgBJrLWOIX8
	A+SCghmj5h0YbCJeZek/s3hRBxCCr+c9BGSDjjXXslQEItkq9cJO4C0PpGrCc5n5lyDUpgg6nTA
	64PUhKkMjNacurqCUdbA+njPw3U3ZwyBl0n7fVaU6U5D9sSYhDa7RsZFSduFzF4/ptXVvL4dNFf
	w585cvELKOTtqx0pdXa2XyT3H2l93bhML6uE/PvHFg1rFA3Q6vqFGxne10Xg3qhsTIXaIwqvagF
	uA+NVewbp4jx14HJGMLAx9u2UU0oZnNKnJ
X-Received: by 2002:a05:620a:4505:b0:8cf:c1c2:908 with SMTP id af79cd13be357-8cfc7e8c3f7mr988062285a.23.1774101892467;
        Sat, 21 Mar 2026 07:04:52 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90e776dsm438145385a.47.2026.03.21.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:04:52 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 21 Mar 2026 22:04:41 +0800
Subject: [PATCH net] net: macb: Use dev_consume_skb_any() to free TX SKBs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260321-macb-tx-v1-1-b383a58dd4e6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHmlvmkC/x3MSwqAIBRG4a3IHSf4iIi2Eg3M/uoOslCJINx70
 vCDw3kpITISDeKliJsTn6FCN4L87sIGyUs1GWU6ZY2Wh/OzzI9svbcdtEWLnmp9Raz8/KeRAjJ
 NpXzFutbZXgAAAA==
X-Change-ID: 20260321-macb-tx-4cc36e13e4e8
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Kevin Hao <haokexin@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227770-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C4E02E5AF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The napi_consume_skb() function is not intended to be called in an IRQ
disabled context. However, after commit 6bc8a5098bf4 ("net: macb: Fix
tx_ptr_lock locking"), the freeing of TX SKBs is performed with IRQs
disabled. To resolve the following call trace, use dev_consume_skb_any()
for freeing TX SKBs:
   WARNING: kernel/softirq.c:430 at __local_bh_enable_ip+0x174/0x188, CPU#0: ksoftirqd/0/15
   Modules linked in:
   CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 7.0.0-rc4-next-20260319-yocto-standard-dirty #37 PREEMPT
   Hardware name: ZynqMP ZCU102 Rev1.1 (DT)
   pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
   pc : __local_bh_enable_ip+0x174/0x188
   lr : local_bh_enable+0x24/0x38
   sp : ffff800082b3bb10
   x29: ffff800082b3bb10 x28: ffff0008031f3c00 x27: 000000000011ede0
   x26: ffff000800a7ff00 x25: ffff800083937ce8 x24: 0000000000017a80
   x23: ffff000803243a78 x22: 0000000000000040 x21: 0000000000000000
   x20: ffff000800394c80 x19: 0000000000000200 x18: 0000000000000001
   x17: 0000000000000001 x16: ffff000803240000 x15: 0000000000000000
   x14: ffffffffffffffff x13: 0000000000000028 x12: ffff000800395650
   x11: ffff8000821d1528 x10: ffff800081c2bc08 x9 : ffff800081c1e258
   x8 : 0000000100000301 x7 : ffff8000810426ec x6 : 0000000000000000
   x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
   x2 : 0000000000000008 x1 : 0000000000000200 x0 : ffff8000810428dc
   Call trace:
    __local_bh_enable_ip+0x174/0x188 (P)
    local_bh_enable+0x24/0x38
    skb_attempt_defer_free+0x190/0x1d8
    napi_consume_skb+0x58/0x108
    macb_tx_poll+0x1a4/0x558
    __napi_poll+0x50/0x198
    net_rx_action+0x1f4/0x3d8
    handle_softirqs+0x16c/0x560
    run_ksoftirqd+0x44/0x80
    smpboot_thread_fn+0x1d8/0x338
    kthread+0x120/0x150
    ret_from_fork+0x10/0x20
   irq event stamp: 29751
   hardirqs last  enabled at (29750): [<ffff8000813be184>] _raw_spin_unlock_irqrestore+0x44/0x88
   hardirqs last disabled at (29751): [<ffff8000813bdf60>] _raw_spin_lock_irqsave+0x38/0x98
   softirqs last  enabled at (29150): [<ffff8000800f1aec>] handle_softirqs+0x504/0x560
   softirqs last disabled at (29153): [<ffff8000800f2fec>] run_ksoftirqd+0x44/0x80

Fixes: 6bc8a5098bf4 ("net: macb: Fix tx_ptr_lock locking")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1cb49252abf5ad553c6213d4f813abade9c20615..46f2847a3731ff3742c9aac09791a71a8eecd9f0 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1210,7 +1210,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budge
 	}
 
 	if (tx_skb->skb) {
-		napi_consume_skb(tx_skb->skb, budget);
+		dev_consume_skb_any(tx_skb->skb);
 		tx_skb->skb = NULL;
 	}
 }

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260321-macb-tx-4cc36e13e4e8

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


