Return-Path: <stable+bounces-235663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJaCICJe2Wm9owgAu9opvQ
	(envelope-from <stable+bounces-235663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:31:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB543DC7D9
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA726300C5B1
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850E839B484;
	Fri, 10 Apr 2026 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa9P0Rzo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281F39B493
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775853048; cv=none; b=sNor7s9GPnI/E+5Mm/gI9Jsdr/gP5qwh7o8HmUkygzyosVZBgP/rjkIDwdra03cXen1dFiX0Ll8T3d5CgZ5CE2nwDbze13N5FKFTfcvD0UNw0WQgdzlIsE+UqZbATb/ZIuojkc8y+o/NXWa5zXhgMDmz+XEd2+9fv+vF//l6LrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775853048; c=relaxed/simple;
	bh=5WEjBpB7GBkWglj5+48lXpVH1r3V4fT8wfU8bJUd7sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onQaJtbY4Cc23VjCOO26PuItuVYa/pndvE30LHSBnaQ/54jGXqgXH/BA1H9r7RmjzBt648h4cEqrU7Wm9tKbyfW0XAdhYZTOx5wqXdcjD+jHTSvMK1kZYg1WC0JB4MdC0qcOTykhT73jrf3nFrhAc3+xAmNWx3SYJK3luabWQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sa9P0Rzo; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899a9f445cbso28906916d6.0
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775853044; x=1776457844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg1THXuqlaX4hybh4CmPAceCR0tZGm2LDqqlEfk6Eg0=;
        b=sa9P0Rzo+VFHpj4g0ikvzGKv9ERE71znjZZAJqeofqk7voFXeqSBlAKVo1ocEwHG88
         gJFsplfhnE2Ofg8uxGMHadKsxx3t1/UI3ekb8yYcfg+2sNcHKXSqTQppTpuXQzeGGRZm
         addwMwWX/K7Tv5VXFuQ7Ge7aHgDOZvoaamsD0hYv6vYcK5G//YTfZgWzpP/Mt2CgIq7V
         DTt/VwiGNQ4RQyP5L1W76lRxLuQCZc4YVPwjs5nzkkhwgeFKjqe9m5qwoOug/xjgq2YG
         zX9f7AedzBlxBWhyt4PCiFnxBXCPZQwEndmI6+u6Z5sXj+U4Upaf4XHEtKaD0BGAZfge
         auTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775853044; x=1776457844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg1THXuqlaX4hybh4CmPAceCR0tZGm2LDqqlEfk6Eg0=;
        b=WKZhcw4Hva/aYokyyyp+GxjHqDlg6Ug4QKGQ2TcaPQQW2VzY7tPumk1d9oqJvC4l8a
         YemB7Azx7lR/F23tEbMeB6TIjVJ8P6t5lIJoL+PW/9SGtLzC2oQnd4xj/NrPuVy3gj0u
         Xj2DPfz6qsP6L0KlCUMBG7rjMuhglyuTkmFqiPwzn00LFaNzKtqBx6AUeK7L0T+movgq
         V3zazvUd/1v+CjQ8AVPdAuK1VepSzqO3MnT2zi+se7uL+Urv2K0Bz/9l8u3nZjMP02t2
         ofokE+qn2/DCtr2nYTawIad7CzSrKGJoTcvhkE2Qq6BbZiOIhSomPyN/CN4WaSKC9qCg
         t7ow==
X-Forwarded-Encrypted: i=1; AJvYcCXX5rTRvoAE764CJmjQZjSY07k+no0mFHKW52kWS3pIen2qEPU96EHNVwrI5Jfk7jkehlo0iSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/BLpMvy6N4aLIHtZ8OAIR1Pbj6+sNxP8fgMa7zzHP/ylVbS0
	dweJ6P5E+02mVK4QZ3b+DOfxxafjnSTnVpqFqMMtt/sCWfsvFMlGisbd
X-Gm-Gg: AeBDiet4fA8E/lT/M9KkzDQ7ews4FgHnHQCy2utJmaBxUwSXKwNJFAS9NEPwfX75hTM
	NHEAtMgFFntE0kwPqooNz5AoLoh4B3rOiSNzf0kXMCUsS6gnILkqzzVd8sACx2GbTlGeW7ZMswP
	WhDdtUlKG8JM39vrzo4PvKPa65Wz6SgNKGXccVENKD10z+SATfmC1O6mEcB2d6Nuzo5OvOHuX+f
	UrM26zJjjFCMyYDOPwXSPAYjxb58jV2qxz4kzfV87WQPK/JhYzY4w4a6yWjdbX0cqhOUcTlMgll
	pFaitsPlv04GxAh/4gVo/JvUGRqy4ZQKTY8Qj+hL1XC8TmrAnafNJBYPoWMw/J/uCkPlmR1G9/I
	EpkaEfy+ibi2EaBKSlpEz+MSMSiRNVMl8MdNE3TVIXbD1SWov9C4AZoBb+G+TZU8Qhj0ScusAhu
	gh8bfoJ3Xm7rcIJZPzBHfYSflzPzdjlBveZGjOCpWK2OgaOtNEpQJkjsiQKrwA62QPUqU1XyJXZ
	0jGIOBHFZnZQrPk1K3N8k63nb8dap1B4O3c9A==
X-Received: by 2002:a05:6214:4706:b0:8a0:a3fb:862c with SMTP id 6a1803df08f44-8ac86162c8amr60783576d6.8.1775853044441;
        Fri, 10 Apr 2026 13:30:44 -0700 (PDT)
Received: from workstation1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c9c37csm30845756d6.36.2026.04.10.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:30:43 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH] um: vector: fix NULL pointer derefs in queue-less transports
Date: Fri, 10 Apr 2026 16:30:28 -0400
Message-ID: <20260410203028.3717914-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235663-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cambridgegreys.com:email]
X-Rspamd-Queue-Id: 0EB543DC7D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TAP transport sets neither VECTOR_RX nor VECTOR_TX, so
vector_net_open() never allocates rx_queue or tx_queue.  HYBRID sets
VECTOR_RX but not VECTOR_TX, so tx_queue is NULL there too.

vector_reset_stats(), vector_poll(), vector_get_ethtool_stats(), and
vector_get_ringparam() unconditionally deref these queue pointers,
causing a NULL pointer crash on SMP or with any lock debugging option.

Guard all queue pointer accesses with NULL checks.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Cc: stable@vger.kernel.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Found while enabling KCOV and lockdep on UML for a network-stack
test lab.  Tested boot with SMP=y + PROVE_LOCKING + DEBUG_SPINLOCK +
DEBUG_LOCK_ALLOC + LOCKDEP + KCOV, all with vec0:transport=tap.

Without the fix, the same config panics at addr 0x18 (SMP, no debug),
0x1c (DEBUG_SPINLOCK), or 0x30 (lockdep) -- all offsets into a NULL
vector_queue pointer.

 arch/um/drivers/vector_kern.c | 48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 2cc90055499a5..6134c376e57be 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -105,25 +105,18 @@ static const struct {
 
 static void vector_reset_stats(struct vector_private *vp)
 {
-	/* We reuse the existing queue locks for stats */
-
-	/* RX stats are modified with RX head_lock held
-	 * in vector_poll.
-	 */
-
-	spin_lock(&vp->rx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_lock(&vp->rx_queue->head_lock);
 	vp->estats.rx_queue_max = 0;
 	vp->estats.rx_queue_running_average = 0;
 	vp->estats.rx_encaps_errors = 0;
 	vp->estats.sg_ok = 0;
 	vp->estats.sg_linearized = 0;
-	spin_unlock(&vp->rx_queue->head_lock);
-
-	/* TX stats are modified with TX head_lock held
-	 * in vector_send.
-	 */
+	if (vp->rx_queue)
+		spin_unlock(&vp->rx_queue->head_lock);
 
-	spin_lock(&vp->tx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_lock(&vp->tx_queue->head_lock);
 	vp->estats.tx_timeout_count = 0;
 	vp->estats.tx_restart_queue = 0;
 	vp->estats.tx_kicks = 0;
@@ -131,7 +124,8 @@ static void vector_reset_stats(struct vector_private *vp)
 	vp->estats.tx_flow_control_xoff = 0;
 	vp->estats.tx_queue_max = 0;
 	vp->estats.tx_queue_running_average = 0;
-	spin_unlock(&vp->tx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_unlock(&vp->tx_queue->head_lock);
 }
 
 static int get_mtu(struct arglist *def)
@@ -1163,7 +1157,8 @@ static int vector_poll(struct napi_struct *napi, int budget)
 
 	if ((vp->options & VECTOR_TX) != 0)
 		tx_enqueued = (vector_send(vp->tx_queue) > 0);
-	spin_lock(&vp->rx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_lock(&vp->rx_queue->head_lock);
 	if ((vp->options & VECTOR_RX) > 0)
 		err = vector_mmsg_rx(vp, budget);
 	else {
@@ -1171,7 +1166,8 @@ static int vector_poll(struct napi_struct *napi, int budget)
 		if (err > 0)
 			err = 1;
 	}
-	spin_unlock(&vp->rx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_unlock(&vp->rx_queue->head_lock);
 	if (err > 0)
 		work_done += err;
 
@@ -1421,10 +1417,10 @@ static void vector_get_ringparam(struct net_device *netdev,
 {
 	struct vector_private *vp = netdev_priv(netdev);
 
-	ring->rx_max_pending = vp->rx_queue->max_depth;
-	ring->tx_max_pending = vp->tx_queue->max_depth;
-	ring->rx_pending = vp->rx_queue->max_depth;
-	ring->tx_pending = vp->tx_queue->max_depth;
+	ring->rx_max_pending = vp->rx_queue ? vp->rx_queue->max_depth : 0;
+	ring->tx_max_pending = vp->tx_queue ? vp->tx_queue->max_depth : 0;
+	ring->rx_pending = ring->rx_max_pending;
+	ring->tx_pending = ring->tx_max_pending;
 }
 
 static void vector_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
@@ -1466,11 +1462,15 @@ static void vector_get_ethtool_stats(struct net_device *dev,
 	 * to date.
 	 */
 
-	spin_lock(&vp->tx_queue->head_lock);
-	spin_lock(&vp->rx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_lock(&vp->tx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_lock(&vp->rx_queue->head_lock);
 	memcpy(tmp_stats, &vp->estats, sizeof(struct vector_estats));
-	spin_unlock(&vp->rx_queue->head_lock);
-	spin_unlock(&vp->tx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_unlock(&vp->rx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_unlock(&vp->tx_queue->head_lock);
 }
 
 static int vector_get_coalesce(struct net_device *netdev,
-- 
2.53.0


