Return-Path: <stable+bounces-255058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IML4C2BtGGoSkAgAu9opvQ
	(envelope-from <stable+bounces-255058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:29:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 389DA5F4FFD
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36B3131264E3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01013FB7C1;
	Thu, 28 May 2026 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyEYliIr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA43F44EC
	for <stable@vger.kernel.org>; Thu, 28 May 2026 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984203; cv=none; b=OzvFIn31NY464A+8DqHVV/YH9BOuOxitMvfzFSuilAm685PVBvCQrCcgqSMGJRUet6e47skta8AQRLGO3HU7yXo89fsboaBhQoqgTm9+nRnLPr3yh3u6KAALZZbpRZ+WZjpYQJHX+2KvvbDXq0lSDG/VCK3Aul94uyJvvC52zM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984203; c=relaxed/simple;
	bh=yCSOHKbwhBjgp5Eie4MpdqNDhpIdZlR1/oBvIklWoBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EymOwouB8CFlLdqqKu1eeOio7L/L2r10yTyVPWnGEgsDdIub1ke5JsyByjqnr0OD3+Zr8DBVhQEOsEwe1cUD3CZDA2+Dz1i/05FqkOOuLrYzPy1iCKSRpq4bVwe5IBG4ghOs4dKPsrdKIuNhfLrxMGaHKstRUBEXddms+h/bm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyEYliIr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so8121354f8f.2
        for <stable@vger.kernel.org>; Thu, 28 May 2026 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779984201; x=1780589001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGAJl71mxdY5fzmkNELb/2UlcEcGhUpJvQPIR8eDu/I=;
        b=kyEYliIruWPP449zRETAHnQa60KjVIzByRMRjmRY+MjWEkTcPA3pvbkogW4dNCvYLd
         8HPxeQoMc22q8AT+hagLkm3lW2DfdYNnkRauRverMVHRnJblyhmx9WMkhgVhM7+gLkfA
         oAHzujiNo2m/aJMlNE5DxeW7F3xK6dVYcnOoY+42GXRbvhLBBYm63qNbV/4DZVf6THTj
         7PmANuHKiqGzfyIOIoTz4R+Czg9rbhgu6HuUXxexzKL0+78v8NUXRbDqY8OlNSUPN7Vx
         ShW3PDERh3ULFDK+hovpY832lvxnLT5DIk9/Nd11vFyILWGREtkUNH7qEj+keRGvv/tB
         tSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984201; x=1780589001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGAJl71mxdY5fzmkNELb/2UlcEcGhUpJvQPIR8eDu/I=;
        b=hLqkMLKgaZyxnZIzAc0N8XwqbxIbWwZVOUcttWcK3Qa5AAjmHB78mDMfDfUhk1RAhL
         aBOZ12G0yBboboi/7wPgbJvskO+dYXAL8yZVpbbduPlWH7/xCmh2XecVFjelSmCflsIg
         NFlmtqBlrafbHtpzBipTnW0fMmFZ5iHNcBtw6C/CHjKuXRSax3KMbPQ6FSfFiARqVThG
         0ln0qxGvbNFgJF6Zz323rGFDqRbxGsDNjAYYt+1C6kzz1nP5MrUie8fK4xvZYCMN306P
         x4ttGuRFo8i8DATDHMt5dO+pITGr7sSBCFclkMHJYZuhEfOTVQs/IUxiXcIctH+zWNL1
         2yCA==
X-Forwarded-Encrypted: i=1; AFNElJ8snAcg6MNdaQ2Hyul3s21DqVq2d5FpMm5LRja+vYW/bY5TCsLT12kiTwOreqz0yZqgl9dsnUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2OVmlaueIVAlNBG3WrTKqGZKk9byc6u4FpVnY4H8V143uvta2
	va2Gyd11GNQv0LQ4JWat3eVk1E+38t41UuFDUjzJEc3pB/U03GBaFm4=
X-Gm-Gg: Acq92OFGnXlwJgVg5BezJQ7mPnGecJIJn4prOPCIELoNNMrUOM4coV1d5YHDzJ6AkZd
	zM0C+h+O4I+czCdfKTptCNbDRA0yYdxgdEcFTppEt01A006UmJ+QVDWrnfp+hSEOyffRpSrQU4M
	wW+/gsWCEAdju8xWHnwVuLvtsxRpNMZx7dSQqorYgoyxeL4sr6V1//NcMWxV7Dym+xFH/b75MZ6
	mx/DrITqGSxdK+/MTOkvjS5rf20k6WTiF4QWn0gc2t5XpLSMiRmfFpSkTfB5llI1DMqgEqvzZ7B
	yNKHu9HYAj93Jkc+fFX7c8S+JF3T6ynjOaE2M3YoEergArqp/i5VpohQz2wNVwPHQzcbMa5dCT1
	WImizpQnE3BfVjm1qLdfLgv00MBoVO/u79cgYpKHtxv5MRTtPGhO7Vk22orN993e99QivOpkHMu
	YYWAGHOzzFZ/HPpouZ
X-Received: by 2002:a05:6000:144c:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-45eb3692577mr45679938f8f.9.1779984200272;
        Thu, 28 May 2026 09:03:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eeb36c40asm3739691f8f.13.2026.05.28.09.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:03:19 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Christian Hopps <chopps@labn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()
Date: Thu, 28 May 2026 16:03:18 +0000
Message-ID: <20260528160318.2631699-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255058-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,labn.net:email,talencesecurity.com:mid,talencesecurity.com:email]
X-Rspamd-Queue-Id: 389DA5F4FFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptfs_destroy_state() calls hrtimer_cancel() while holding a spinlock
that the timer callback also acquires, leading to an ABBA deadlock on
SMP systems.

For the output timer (iptfs_timer):
  - iptfs_destroy_state() holds x->lock, calls hrtimer_cancel()
  - iptfs_delay_timer() callback takes x->lock

For the drop timer (drop_timer):
  - iptfs_destroy_state() holds drop_lock, calls hrtimer_cancel()
  - iptfs_drop_timer() callback takes drop_lock

Both timers use HRTIMER_MODE_REL_SOFT, so their callbacks run in softirq
context.  When hrtimer_cancel() is called for a soft timer that is
currently executing on another CPU, hrtimer_cancel_wait_running() spins
on softirq_expiry_lock -- the same lock held by the softirq running the
callback.  If the callback is blocked waiting for the spinlock held by
the caller of hrtimer_cancel(), a circular dependency forms:

  CPU 0: holds lock_A -> waits for softirq_expiry_lock
  CPU 1: holds softirq_expiry_lock -> waits for lock_A

Fix this by cancelling both timers before acquiring their respective
locks.  hrtimer_cancel() is safe to call without holding any lock and
will wait for any in-progress callback to complete.  The locks are still
acquired afterwards to synchronize with any in-flight packet processing
before tearing down the state.

Found by source code audit.

Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
Cc: Christian Hopps <chopps@labn.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/xfrm/xfrm_iptfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e55baf..fd25b2b230793 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2708,8 +2708,9 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 	if (!xtfs)
 		return;
 
-	spin_lock_bh(&xtfs->x->lock);
 	hrtimer_cancel(&xtfs->iptfs_timer);
+
+	spin_lock_bh(&xtfs->x->lock);
 	__skb_queue_head_init(&list);
 	skb_queue_splice_init(&xtfs->queue, &list);
 	spin_unlock_bh(&xtfs->x->lock);
@@ -2717,8 +2718,9 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 	while ((skb = __skb_dequeue(&list)))
 		kfree_skb(skb);
 
-	spin_lock_bh(&xtfs->drop_lock);
 	hrtimer_cancel(&xtfs->drop_timer);
+
+	spin_lock_bh(&xtfs->drop_lock);
 	spin_unlock_bh(&xtfs->drop_lock);
 
 	if (xtfs->ra_newskb)
-- 
2.47.3


