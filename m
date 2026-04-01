Return-Path: <stable+bounces-232692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIaDOXeozGl3VAYAu9opvQ
	(envelope-from <stable+bounces-232692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 07:09:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E45AB374D22
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 07:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD17D302C56C
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 05:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE80734DCD9;
	Wed,  1 Apr 2026 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLlwu4hx"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98A2C237C
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020143; cv=none; b=WtXFhxOCAeQxIFrCr6uStP95YinXuPGvPH4XhtKIso65OAu68g9812VYeV08LFHdcogaosSc/L3njIyHbVK6qxuRz20kKeN3ynucVCDreoinJ3E3V0iD7Q0JkZ3LNE9ypgE6BslEO8dyjL7KDOeS9WOHKdLW9uJoKunJ6eG1UmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020143; c=relaxed/simple;
	bh=0iOuv2Jk9x6VT70uTCLFtSjtEKSW2vWQw9+L9R9XNyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBY+5kyPkPn1FlKJBYTvtSoo4XYKnI8ptIrrbdrZyJvs7kRGrfJQrjyJAlk8RuzJVuTaqXSPKaIwpRNlYp1RFY8qr80nEzaJcEQoKFEq71Jlb+pNU69PLDksCygl+Q6vFfGKa6acZrhwK/40lSVz0mEKL36Ss4W1lGMCXTjAKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLlwu4hx; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-467161c4a1cso2161431b6e.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 22:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775020141; x=1775624941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4ImYOWTG5LWu2AjZ0ViLWPRevzakMzCKB1uXh/hzS0=;
        b=bLlwu4hxGnKqbqM3eyubQnFER89IlaGgRcUnqrI3u7d3Oi4KXavH5J9s3gjmjAZYWw
         Kf8xNdcikqXnhqBediZGmSWMrUbYorEwtm/JGWHVLFLTukMxNVPldH6gMSX8LMtFTS6d
         iXEt9znnUcx8rPaq4Q4RpbUuoFcYpzcnGWg9YJ0u4zF9PC+3xxj03/itaohjENy3Xr7I
         8Z7SfvzSGH8MOWRge2gl0USsMduw3o+CseJvqqnuP7UMAN4LSFmRKyWhyWblME7cMULV
         hqsOSfhCvpO5hntuuH3aLT1CJ4CA9kYU0F3iraJbBsFiquSfZMmjQFZyfVXUcms2MBQ2
         oFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775020141; x=1775624941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x4ImYOWTG5LWu2AjZ0ViLWPRevzakMzCKB1uXh/hzS0=;
        b=Px/R5D6XZkGdp8XoSNoeYpDhqm/2RH2ncQj/tVFGHjOaZu7m50e3Kox/vIsog7AMHb
         /x1WBUeeh8+r2wrEw3zuq22Bj5Y39D+6MYUSdViFE0agw2Y9xn18HcVjuknyejtjCJLf
         Hqk1eyntZaiehVlnbt+tfZ8MYBOo8+u9/tvGqi4E170kGQGVK3V64M9uRb73QoZ+P2F4
         j2aauPHSELCTZIrjClQZhNQ8huvcs72j//gLCStagWVAKS5SCYAXiN16QJ2fPdr8XdoQ
         7QOdAZ/tTokmE7KK+z+7VgwKtDHYfcoAFLlaDAYwfTZUysxNyAQvivPGYzj9cRuWzpi7
         qZSA==
X-Forwarded-Encrypted: i=1; AJvYcCUVtNwu+K2QSinPC0IS/m2LYxtcpW6MunJ140lgGqhinugfBkDt1hZOCZ2lReuplRsCgUW96Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2TA97CwezuOkDh3Lvn0M0kyvj0KihlR4mbavOdIWeeZ6c+iJ
	++c4uCIeizsqjdpCPUiw9OJmejfggHrYwW718yoiO1I4lXndLSQjU93E
X-Gm-Gg: ATEYQzyXX2Rujr8tO7JkWSg2sOnrCvO4ZD3zoNp135lbuDnx9TUJoGq3kkFlmnoFlNa
	/4P1u4fLVvV957qz4NhiCRrV8uY+rxZPi8STEJutiphUAn6rqRRoYe2OoNVmu7mpFHOH1Oz1ake
	HJOQtoVLym9fhiYKV5sqSX7N0/0ZFt+QQDr5kCRAKF+KdLDpdydVkSi0W1XxdYsWIfSKol+Tl9U
	9jd4Ypoi/X71YnMwDzDVSnjERhDmsuZCXH9cjCC+IQmKtCuqnn8OyxSRTsRQeFT9UozUtoJOuJC
	Bpj/JzpYZ5wjliZYNsXX1+lNfj+md2MRhs4vkAEkxR7y5LllCjd4vJAJWp8wmikYgHWNtbIQd65
	f0tLWnbY9SSSNwJywFJkiEIm+AVwmE+nAto1R7iIi6BWMGzW/4NHA5ED2LRKD7VxIZURa+PDtlT
	Rzax4xkeFZkcPTTUU7B8a9MkW6K3R5G5NZxsu0JY49osOsLEEN59QdpYxJ5I0ERKrFbHYyx0cz+
	MFN
X-Received: by 2002:a05:6808:670a:b0:468:12a9:d54e with SMTP id 5614622812f47-46ae01a4d6bmr1037751b6e.44.1775020141070;
        Tue, 31 Mar 2026 22:09:01 -0700 (PDT)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa0efdb75sm8015785b6e.13.2026.03.31.22.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 22:08:59 -0700 (PDT)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: haren@linux.ibm.com,
	ricklind@linux.ibm.com
Cc: nnac123@linux.ibm.com,
	sukadev@linux.ibm.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH v2] ibmvnic: fix OOB array access in ibmvnic_xmit on queue count reduction
Date: Wed,  1 Apr 2026 00:08:45 -0500
Message-ID: <20260401050845.1388145-1-LivelyCarpet87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJsYhQJm4mW1FHu2d=Pf8PfFyBWZA43QHpQ2esc0Cfuqqehh4w@mail.gmail.com>
References: <CAJsYhQJm4mW1FHu2d=Pf8PfFyBWZA43QHpQ2esc0Cfuqqehh4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,northwestern.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-232692-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E45AB374D22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the number of TX queues is reduced (e.g., via ethtool -L), the
Qdisc layer retains previously enqueued skbs with queue mappings from
before the reduction. After the reset completes and tx_queues_active is
set to true, netif_tx_start_all_queues() drains these stale skbs through
ibmvnic_xmit(). The queue index from skb_get_queue_mapping() may exceed
the newly allocated array bounds, causing out-of-bounds reads on
tx_scrq[] and tx_pool[]/tso_pool[].

The existing tx_queues_active guard does not help here: it is set to
true by __ibmvnic_open() before netif_tx_start_all_queues() restarts
queue draining, so stale skbs pass the check with an invalid queue index.

Fold a bounds check against num_active_tx_scrqs into the tx_queues_active
guard, reusing the same drop-packet handling. Since tx_stats_buffers[] is
allocated for IBMVNIC_MAX_QUEUES entries (not just num_active_tx_scrqs),
all drop paths can safely fall through to the out: label's stats update.

Also move rcu_read_unlock() to after the per-queue stats updates, as the
RCU critical section is already large and releasing it a few instructions
earlier provides no practical benefit.

Fixes: 4219196d1f66 ("ibmvnic: fix race between xmit and reset")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
v2: Fold the bounds check into the existing !tx_queues_active guard rather
    than adding a separate if block with unlikely(), reusing the same
    drop-packet handling (dev_kfree_skb_any + tx_send_failed/tx_dropped
    increments + goto out). Remove the dedicated out_unlock: label;
    tx_stats_buffers[] is allocated for IBMVNIC_MAX_QUEUES entries so all
    drop paths can safely fall through to the out: stats update. Move
    rcu_read_unlock() to after the stats updates per maintainer suggestion.
    (Rick Lindsley)

 drivers/net/ethernet/ibm/ibmvnic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..d5c611c3d9ec 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2444,14 +2444,15 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	 * rcu to ensure reset waits for us to complete.
 	 */
 	rcu_read_lock();
-	if (!adapter->tx_queues_active) {
+	if (!adapter->tx_queues_active ||
+	    queue_num >= adapter->num_active_tx_scrqs) {
 		dev_kfree_skb_any(skb);

 		tx_send_failed++;
 		tx_dropped++;
 		ret = NETDEV_TX_OK;
 		goto out;
 	}

 	tx_scrq = adapter->tx_scrq[queue_num];
 	txq = netdev_get_tx_queue(netdev, queue_num);
@@ -2663,14 +2664,13 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		netif_tx_stop_all_queues(netdev);
 		netif_carrier_off(netdev);
 	}
 out:
-	rcu_read_unlock();
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
 	adapter->tx_stats_buffers[queue_num].batched_packets += tx_bpackets;
 	adapter->tx_stats_buffers[queue_num].direct_packets += tx_dpackets;
 	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
 	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
-
+	rcu_read_unlock();
 	return ret;
 }

--
2.43.0


