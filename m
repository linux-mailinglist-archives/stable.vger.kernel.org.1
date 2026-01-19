Return-Path: <stable+bounces-210288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37514D3A302
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 270DD3004E37
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C3D3559C3;
	Mon, 19 Jan 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LfK8HQIf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFD03557E7
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814974; cv=none; b=AfRe7CSHDY8MXmtyzDXuai8nX100aHypKiHJkToYrXrphMIKhjexrNMQ+CXn43sNRVcNck61sVv7AEnus3zGhUO5YR5N6qR5zXvt99hpzE1MdBvN9q8H1wQ8STrDRZMS83uviqVQsJ68X4yI6ETW5mItjlvThMgk/iLYhdqO51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814974; c=relaxed/simple;
	bh=k9ee2EKB4tUDptolbhgjzpwxMShTN6LfTKyBbETaVxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJJf9aKt4wPKG8popxogeYAyITi64++EbKdtMvXrrF/mSD1UHy/3hNfVQl9NyoPE267wji8rwrCRkkAxWCuxSScObGLTMUDM15ZmO1a0XhR0N4X/zpUZC4MPBSYXffbVUjuuR9pD/WzeeBcpFh7xz9G2qgZkFlVWPnIsnpFdGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LfK8HQIf; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-89007e99d12so4629056d6.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814972; x=1769419772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVi5uHDjVopShqD0MnuBnlMmLMJhBdagK4kolEfksCA=;
        b=GHGHwshVNzhADRwqpw1otI2Z/s/5tkiXtEDVgzPWcDul0HbuVHVA7rkh0vDxfi5LoJ
         FXUiC7/m/IfWUSWzh4itq8yOxbHsypTLQEOrDA74N5yo6WlOld2YCzQbjjbpmB9ZWF7y
         IZ4vup7J/z9WjsVuGbbG5iGaOH/88W7hb/zboluAIpEAGq5JFcU+PBpqAooZxH4yVRXD
         BEHn4SLdLe0pQ2he7LKZVjvCaXfALIZ61H9O2EihjaGWUwdRsdW2ojWOlr8esoPxxrmQ
         l089YURBHeJQt0XCJgsGvTOuZweO8Zz6LW8KAAd8lw25kfbooxU7JJhucMeXnVxuwEc6
         0FQw==
X-Gm-Message-State: AOJu0Yzu1L2rsSjD90rTYNLDHQ2WRI1IulAxeuha1zWrI66Z61U0JgH6
	j750UWwvV1FvoicE/Q0g57bP8GlnikgMYoQDDgw6kD8SCGFuQ5i8eo+nja2yXJV6O9lO0Yj2UWW
	TGYgItq4Rg4cyPRWMtrEtbQ6eQzyePbrQGIpnJXaZzmOrVJN0jXk8CHWNdZ8Ab7IHdCJ+guU9il
	snJcxtjO3AlV+eXfvB3R4AnK9ITISENJEeznRadqAvgEV6niouPr1aXd9h19LC1jwuTyQl8Cf0J
	LEsa75ldL9mP+0iLynU4qSKKEhrS/Q=
X-Gm-Gg: AY/fxX4Yj9qZkr2X2kKaUl1LXoMKyBgicnpNEBTexqNQ7zwCjGaRMF35+Omx73BfW9H
	6jDrDQDFv7hHhRVncqgWc6CAlDmOBxXJxX/PZkjTmEJPDWKBVuiqenn0yVW+meLY4LKr3zfNM7u
	Y+O6sbqXCzIEuhNwPlkveNKtbMNmrBvG4cxKz+KLB1EO6IZ4n0ZJDeyBaDrJd1i01VmYmq0ajen
	gOByUzQEqURFWxGB3sXyVEx58CzTaq1lh6HriAqrk5P9yv/oENYausgxPhKWoY/TTPooOp+Ja+s
	YmhJs5saJ8YLCRLWBMBFOQ2T3w4IP7A677kiqMNOqUKZP5sYn3FqrU2AkZtnbHmZ4auw37ZAWbZ
	Xw9JEQwMtEQUWAOwWjRAxaidHcJNmDWI/1kXXymOXT+pKJXgt01Di04DJARhPI++PEs+rSnWvVr
	hF53PUy+0c0gDRtZHGqsSrN0yXC2sPGXONemN5o4XtRkuM6y2LWERzrbHEDXM=
X-Received: by 2002:a05:6214:55c4:b0:88f:ca7d:348f with SMTP id 6a1803df08f44-8942ddbd1abmr106407756d6.7.1768814972200;
        Mon, 19 Jan 2026 01:29:32 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8942e5f2b40sm6720096d6.11.2026.01.19.01.29.31
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8887c61412bso8267746d6.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814971; x=1769419771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVi5uHDjVopShqD0MnuBnlMmLMJhBdagK4kolEfksCA=;
        b=LfK8HQIfOklOEPm159xYI2qZyWDMqlbuj/IuEjhxszm5Yd8Dm10zP4cA5o0aAFUbjT
         +M7fBI7G4vSTzV2gk8QYSHmrZI+rdcx3RrfQv6P6WfMaH/aDebUojp4n/EDyZ7n319I/
         Qc34mGKSF904WHaMaMy54cNUzWh6fAVp4ZDJI=
X-Received: by 2002:a05:6214:6118:b0:889:e38c:d13a with SMTP id 6a1803df08f44-8942dd9eeabmr85587506d6.5.1768814970681;
        Mon, 19 Jan 2026 01:29:30 -0800 (PST)
X-Received: by 2002:a05:6214:6118:b0:889:e38c:d13a with SMTP id 6a1803df08f44-8942dd9eeabmr85587146d6.5.1768814970119;
        Mon, 19 Jan 2026 01:29:30 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:29 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>,
	Eric Dumazet <edumazet@google.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 1/5] net: Add locking to protect skb->dev access in ip_output
Date: Mon, 19 Jan 2026 09:25:58 +0000
Message-ID: <20260119092602.1414468-2-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>

[ Upstream commit 1dbf1d590d10a6d1978e8184f8dfe20af22d680a]

In ip_output() skb->dev is updated from the skb_dst(skb)->dev
this can become invalid when the interface is unregistered and freed,

Introduced new skb_dst_dev_rcu() function to be used instead of
skb_dst_dev() within rcu_locks in ip_output.This will ensure that
all the skb's associated with the dev being deregistered will
be transnmitted out first, before freeing the dev.

Given that ip_output() is called within an rcu_read_lock()
critical section or from a bottom-half context, it is safe to introduce
an RCU read-side critical section within it.

Multiple panic call stacks were observed when UL traffic was run
in concurrency with device deregistration from different functions,
pasting one sample for reference.

[496733.627565][T13385] Call trace:
[496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x24c/0x7f0
[496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
[496733.627595][T13385] ip_finish_output+0xa4/0xf4
[496733.627605][T13385] ip_output+0x100/0x1a0
[496733.627613][T13385] ip_send_skb+0x68/0x100
[496733.627618][T13385] udp_send_skb+0x1c4/0x384
[496733.627625][T13385] udp_sendmsg+0x7b0/0x898
[496733.627631][T13385] inet_sendmsg+0x5c/0x7c
[496733.627639][T13385] __sys_sendto+0x174/0x1e4
[496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
[496733.627653][T13385] invoke_syscall+0x58/0x11c
[496733.627662][T13385] el0_svc_common+0x88/0xf4
[496733.627669][T13385] do_el0_svc+0x2c/0xb0
[496733.627676][T13385] el0_svc+0x2c/0xa4
[496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
[496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8

Changes in v3:
- Replaced WARN_ON() with  WARN_ON_ONCE(), as suggested by Willem de Bruijn.
- Dropped legacy lines mistakenly pulled in from an outdated branch.

Changes in v2:
- Addressed review comments from Eric Dumazet
- Used READ_ONCE() to prevent potential load/store tearing
- Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_output

Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250730105118.GA26100@hu-sharathv-hyd.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 9114272f8100..b3522d3de8c8 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -547,6 +547,18 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 		dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 }
 
+static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
+{
+	/* In the future, use rcu_dereference(dst->dev) */
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	return READ_ONCE(dst->dev);
+}
+
+static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
+{
+	return dst_dev_rcu(skb_dst(skb));
+}
+
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
 void dst_blackhole_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			       struct sk_buff *skb, u32 mtu, bool confirm_neigh);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1e430e135aa6..3369d5ab1eff 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -429,17 +429,23 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev, *indev = skb->dev;
+	struct net_device *dev, *indev = skb->dev;
+	int ret_val;
+
+	rcu_read_lock();
+	dev = skb_dst_dev_rcu(skb);
 
 	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
 
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
 
-	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, indev, dev,
-			    ip_finish_output,
-			    !(IPCB(skb)->flags & IPSKB_REROUTED));
+	ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+				net, sk, skb, indev, dev,
+				ip_finish_output,
+				!(IPCB(skb)->flags & IPSKB_REROUTED));
+	rcu_read_unlock();
+	return ret_val;
 }
 EXPORT_SYMBOL(ip_output);
 
-- 
2.43.7


