Return-Path: <stable+bounces-227347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCqnCMEuvGnquAIAu9opvQ
	(envelope-from <stable+bounces-227347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:13:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C02C2CFA31
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B23353314EC3
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF13F7E85;
	Thu, 19 Mar 2026 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lionYxwP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C43F0AB0
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939378; cv=none; b=QE3DnMyj9IIyKPzzb1MEWvoPeNVPgg6GhIZgSxT8vRbZPlqm3NcBtRXV85Xpe9lbxqOc/9A+X91S/IsEoAoXJOp7RbyHmDBz/gvzxg4YwJe7NWnYsu5aij/ehvc8BiwlfF8yaSalKg/thAfih9nLTuNaBIcC72ntqMAxeSoINSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939378; c=relaxed/simple;
	bh=2r0+5DXbu8sIF0jchSm+kwP6wpjWmTVS6JmgtRf+tRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nn5z0e8l6JJRAcBJElE9X/jftGgznHRl7ezVR/vmFteKdlnDBvrB0H5jAIrQ1CHQyQm4/4jnO9ZqWnSwGyyfbA+6p42Xn4HyH+AWNGNen3loiWj1udXHfTAHhbLr+BxKqPVgXfBv9mjNfqRR/lXK3Cf1S/Ygoh6yiUcAMzsc4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lionYxwP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82987437624so713007b3a.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773939372; x=1774544172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuArJneeW2hpsiZBm9th3iSdlRnTT0MF1J3hHI2dmmw=;
        b=lionYxwPpNeRjglMfsvLkwNkJeNXTz9CCXz6Wjt3s4ch+sBg06U4+7N2dIfUl2rfKP
         GwKZ/faA5nT5bjPZXy+nuoS1Df2Dlyxr+iCFQSFdHbpXmlBWPcNOFZlv6PPdgAtwaFpS
         Xoz7mpihbH8P/AEcjWAcbbp1omY07uYp66nJHm96Jh50WPMVB0BjTAbWKuzBisw1IT8d
         AxwPcgy+IYrHNXIpfFR7b8OtlozW8TjF6P/mmBpE5sgsWo9fLNlTbtRjUXVdpvIvA17k
         Wt2E33otPau5dfjKOXFBUSF7fwzQh8U0i3YTSZb8aHwpElz5rEE3BfjruFYYKo4WylPp
         3kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773939372; x=1774544172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuArJneeW2hpsiZBm9th3iSdlRnTT0MF1J3hHI2dmmw=;
        b=D2qnyOkg6Tz/oGXHyymnRCDivjEkTDa1J5ce16t5MbCtPrQ736xDwt/2Pzu5m8djlC
         81N+8kRTRWQ2V7NZsQTgJWr0lTV5gYj59jxPMHk4vqdOGLLQ5kdKG8Yc4pLentdG/kv5
         oURhg1RGgGQOTdef3EFfGmMPfXRg40Snx08rBlKAlVBJlBBsFwSwY1tfKIbVMprZ7waQ
         pURqCoghnNdKi4Nm5y4h5IyckJH3ApHM47PAiQ1eTarTEH7xugv6J6BS/8H321ptNLPT
         XCvCu8aPLkodiT/GmYu9klZdgCeJ1HC3ZHHZjX3k1GupSoQbZ9pn91D5RMCxVeZ/ZCUG
         yA1g==
X-Gm-Message-State: AOJu0Yy/CjqgyqddVrMeQRtqHOLeSryUc4zRGy3WZtrPuB+5puIT+4DV
	rpINhYP9aW3zt1wn0fhHT7Uj+iNPd2WJ5KnTA077FDbBc2UgBEv/gEtjcoj3xKq0
X-Gm-Gg: ATEYQzzPA3hEuEXlUQherbtsRrn04o4N/7vI13dFMadkL5VNjz4a7QK9HsZEgUJvqHV
	x1UFw0g+9RPNe1sLHQ0LtoyDVVWfFZDudeTzN5atGMvfsvOQOk8s8E4NirY2fIBsq609jkSRR0/
	sxSntz1QApocLW93YjxAx1LU/ok43rW/PkGpJJYWGIMuyyb2zJNRmglEut9vEpHh8MfCSAhH8Hy
	H25cUF/S+uneaZogEIH1W+la1rqHknDbMj+h12YXV/76Juz3EaKRKkyZZRJfSPl5+Auia1Ew36A
	gq58ON4qUD19HbPo+Zy6IMblMQw3pJFwdNzRHSzZpQZn6f1iB4/I384huR4rEwj8ap2IUFdsSh/
	SgxegYnF7HleJR83EEnuVeA33S3nG6Jid7rG/FWU88RBert2RHwLjQRfM5m/KTu2HT3lXdJ014+
	beVKiXNKBVSdLP6YcEkihYWA+xIZYZ+4ki80o=
X-Received: by 2002:a05:6a00:9509:b0:824:3d5b:3cd3 with SMTP id d2e1a72fcca58-82a8bfed337mr64262b3a.0.1773939372110;
        Thu, 19 Mar 2026 09:56:12 -0700 (PDT)
Received: from localhost.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb2f34sm6568871b3a.30.2026.03.19.09.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:56:11 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: tpluszz77@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH net] xfrm: hold skb->dev across async IPv6 transport reinject
Date: Fri, 20 Mar 2026 00:56:04 +0800
Message-ID: <20260319165604.9472-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-227347-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C02C2CFA31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfrm_trans_queue() queues transport-mode packets for async reinject via
xfrm_trans_reinject(). The queued skb keeps only a bare skb->dev pointer.
If the originating netns is torn down before the workqueue callback runs,
ip6_rcv_finish() can still dereference skb->dev after the device
has already been released by default_device_exit_batch().

Fix this by taking a netdev reference when queueing the skb and dropping it
after the reinject callback completes.

This was reproduced with KASAN under QEMU:

BUG: KASAN: slab-use-after-free in ip6_rcv_finish+0x17c/0x1b0
Workqueue: events xfrm_trans_reinject
Call Trace:
 ip6_rcv_finish+0x17c/0x1b0
 xfrm_trans_reinject+0x292/0x440
 process_one_work+0x63c/0x1100
 worker_thread+0x62d/0xef0
 kthread+0x368/0x480
 ret_from_fork+0x529/0x750

Allocated by task 112:
 alloc_netdev_mqs+0x82/0x1180
 rtnl_create_link+0xaa4/0xe30
 rtnl_newlink+0xa98/0x1f90

Freed by task 12:
 device_release+0x9b/0x210
 netdev_run_todo+0x497/0xcf0
 default_device_exit_batch+0x735/0xab0
 cleanup_net+0x3c7/0x860

The issue can be reproduced by repeatedly:
 - creating an IPv6 veth pair and network namespace,
 - installing IPv6 transport-mode XFRM state and policy,
 - sending IPv6 traffic to queue async reinject work, and
 - tearing the namespace and device down in parallel.

When unprivileged user namespaces are enabled, this can be triggered by a
non-root user after entering its own user/net namespace with unshare -Urn.

Fixes: acf568ee859f ("xfrm: Reinject transport-mode packets through tasklet")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/xfrm/xfrm_input.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 4ed346e682c7..4b5147cb44b7 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -40,6 +40,7 @@ struct xfrm_trans_cb {
 	} header;
 	int (*finish)(struct net *net, struct sock *sk, struct sk_buff *skb);
 	struct net *net;
+	struct net_device *dev;
 };
 
 #define XFRM_TRANS_SKB_CB(__skb) ((struct xfrm_trans_cb *)&((__skb)->cb[0]))
@@ -784,9 +785,13 @@ static void xfrm_trans_reinject(struct work_struct *work)
 	spin_unlock_bh(&trans->queue_lock);
 
 	local_bh_disable();
-	while ((skb = __skb_dequeue(&queue)))
-		XFRM_TRANS_SKB_CB(skb)->finish(XFRM_TRANS_SKB_CB(skb)->net,
-					       NULL, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		struct xfrm_trans_cb *cb = XFRM_TRANS_SKB_CB(skb);
+		struct net_device *dev = cb->dev;
+
+		cb->finish(cb->net, NULL, skb);
+		dev_put(dev);
+	}
 	local_bh_enable();
 }
 
@@ -805,6 +810,8 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
 	XFRM_TRANS_SKB_CB(skb)->net = net;
+	XFRM_TRANS_SKB_CB(skb)->dev = skb->dev;
+	dev_hold(XFRM_TRANS_SKB_CB(skb)->dev);
 	spin_lock_bh(&trans->queue_lock);
 	__skb_queue_tail(&trans->queue, skb);
 	spin_unlock_bh(&trans->queue_lock);
-- 
2.43.0


