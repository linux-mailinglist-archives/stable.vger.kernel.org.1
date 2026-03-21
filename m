Return-Path: <stable+bounces-227652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fK2lApMWvmnoGAMAu9opvQ
	(envelope-from <stable+bounces-227652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 04:54:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4462E32A1
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 04:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9673012248
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 03:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D633E347;
	Sat, 21 Mar 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzp8YSAx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC1028002B
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774065293; cv=none; b=p0sOf20/NRTF9Yttma7/UyVuPvC+6+E7biqxHC7fANJwamkN3Dp3OKtiq1prkax5l067VsaUX9qkNeBJ1IYEVfDw23q5P9L0b9BJs6mWNHbzqARYxqFK6CDhzTVcxX4c1eux5sQPSv+Saaocyla/TyB6deLvFqXeLaIpLibP/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774065293; c=relaxed/simple;
	bh=rUoQuWIfaJgdbpwwynVupr5Nrul9i/+vWIwXroY4tpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ji3h6eSlJVhFEV4Iob8Hx0B9gJGg34SFENKjmn/1dmBf2D6K9EoI7OyjbXnAYE0qq1OwE8p1fnRjqpU5Y6ObexwHQSIs0BvaxbAbh1W8fcVrfH92snsvIBI6WBIHYvTqYfk6/6uvCjHsPmilngwkH4ondPHYWlKLIKp+K19yOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzp8YSAx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899a5db525cso22775026d6.3
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 20:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774065292; x=1774670092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mkiqb+Vj/SHwdR4VTTJ+J9wlyftU60EVDvQB+SCNHc=;
        b=Jzp8YSAxq/6cTtk+YgXxZ+iuhrYE1iZF09eipsvfOmnhujofC9bUJyjPQnqyRz/2aq
         me57jF2+V/u875DmxZ1AnoSYzSmsZY1rQp4LG/A7x8Xgs/JiBFYru1J63I3ymCsnwI7B
         /3s4ZCY/b13TCWE8RAtqmq5RnKa+LgAny7x5PEN97OgLKFBq7kFVVGHW5HIgImwnXr2C
         oE13YmVntkLHKqs/T0giCClNwru5M8gC1uvYuCivMmPCzleOLt9C0dGMTUaByeiB9LIb
         hBR8pnmZb7j4sVaYWOBHgz7kyzGWyXdMAIDXAjRGMhaYMW7fEHePb/H8xHkQDp1Km+qI
         ub7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774065292; x=1774670092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Mkiqb+Vj/SHwdR4VTTJ+J9wlyftU60EVDvQB+SCNHc=;
        b=Z5c4LLBjMnaPaaoTmFuPJTIJ6ad2bJi2X/2HBJNrrwGzWraGWmZC6RwAROc1Zdal0t
         qbGeCv8PPb9/7Ctp3hEL/srbf1fUt/gcEGj3cnAYqjrxtO9R9R8YC8HJ3zGdwoLKcF9N
         Xm0ZZbxmX0RRT6XlZ4ClpNwAurO65mJLNqMe7HjYhtSzL1N43A6GXp6CZg1BK45S4aYF
         Ilojip/poBl51JxlMHw0nuvICi8WJSfQKBSaP45qnj1iFruJc9i74dzJQqd/mDUxxqvZ
         XPY8gUpLNdOBzSYXjNRTrTfEhALj/8CUeAspUFREwFOAW/4uc/0579JdnxmlexhVhBk/
         qdFw==
X-Forwarded-Encrypted: i=1; AJvYcCXTH9vXQTPRQaH+Nu0GCusg+x+BmmfNi5s/CKcjQF5gpNQG+scoppzFOLccN78+KNplO14WnRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UGCs1mgO1UGos/F3iFz6rlG3YBJw+hlfTvu3OuADITkfewnQ
	PdT+wEIjvXqchxcLsMJcfW16E+QJlMk+4N7ZlQMHHHAj+nt+LOQCJjph
X-Gm-Gg: ATEYQzztpHLzw7a5901g7xqbHH2dhMWmwevQ8efvVW0HIrulsxpc2B+ynrw6m8R8wrh
	JrD2IEHaUMYfXAuFR1YSMrk6qf7PG1gn+Yu4nqEJWtfuzy1Xndx7FvUifaNNseJUK+k+7vvP666
	TnYG/zgmnG9eViN4pwbsN0vvbAX4bW0PavbYXJJa1+dwSSRjCSJ20guYBoEIi3sZ5ypV+QAnVdR
	LtskVa7FCvxsEHKxUtyzvI9lU8pbuPJRl9QePtDng7rYRCnwjCoLNVys+bN00DndI5A2odwE+VD
	hwgx94i2ukQoGBljFc5DYRUyfFbJth+kL+CNBivTH0s4j6sewSjtxI9DulWQWnCQXsAH7mRjm+A
	qQqIJyK2hyo6gigy+/gaQ6diGTCtVP0BqY/izq6oXKUG/0fnygUk9DjciCACBd1OvzsKW/1/v9k
	8V7vUdkyCafSDdKXjsui0FsFkSOAe2RrxbHsrzZw72H221IIZ/aaRBkoadMuYkm6NVmnbeZTi7Z
	ixU
X-Received: by 2002:a05:6214:f28:b0:899:f4bd:66e9 with SMTP id 6a1803df08f44-89c85b0e49bmr86905896d6.63.1774065291566;
        Fri, 20 Mar 2026 20:54:51 -0700 (PDT)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c96cb614dsm2999406d6.22.2026.03.20.20.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:54:51 -0700 (PDT)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	nnac123@linux.ibm.com,
	sukadev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	danisjiang@gmail.com,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH] ibmvnic: fix OOB array access in ibmvnic_xmit on queue count reduction
Date: Fri, 20 Mar 2026 22:54:39 -0500
Message-ID: <20260321035439.900644-1-LivelyCarpet87@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com,northwestern.edu];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-227652-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A4462E32A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the number of TX queues is reduced (e.g., via ethtool -L), the
Qdisc layer retains previously enqueued skbs with queue mappings from
before the reduction. After the reset completes and tx_queues_active is
set to true, netif_tx_start_all_queues() drains these stale skbs through
ibmvnic_xmit(). The queue index from skb_get_queue_mapping() may exceed
the newly allocated array bounds, causing out-of-bounds reads on
tx_scrq[] and tx_pool[]/tso_pool[], and out-of-bounds writes on
tx_stats_buffers[] in the function's exit path.

The existing tx_queues_active guard does not help here: it is set to
true by __ibmvnic_open() before netif_tx_start_all_queues() restarts
queue draining, so stale skbs pass the check with an invalid queue index.

Add a bounds check against num_active_tx_scrqs immediately after the
tx_queues_active guard. Use a dedicated out_unlock label to skip the
per-queue stats updates (which also index tx_stats_buffers[queue_num])
when the queue index is invalid.

Fixes: 4219196d1f66 ("ibmvnic: fix race between xmit and reset")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..c939391474cb 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2453,6 +2453,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		goto out;
 	}
 
+	if (unlikely(queue_num >= adapter->num_active_tx_scrqs)) {
+		dev_kfree_skb_any(skb);
+		goto out_unlock;
+	}
+
 	tx_scrq = adapter->tx_scrq[queue_num];
 	txq = netdev_get_tx_queue(netdev, queue_num);
 	ind_bufp = &tx_scrq->ind_buf;
@@ -2672,6 +2677,9 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
 	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
 
+	return ret;
+out_unlock:
+	rcu_read_unlock();
 	return ret;
 }
 
-- 
2.43.0


