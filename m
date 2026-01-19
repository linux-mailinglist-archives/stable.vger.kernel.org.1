Return-Path: <stable+bounces-210335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C06DD3A776
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B74A30A10DB
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56280318EE0;
	Mon, 19 Jan 2026 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LjTmYwcV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6DA319855
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823567; cv=none; b=bvGR+Hi/x9KpmRA7wm1Wr7NL/l6bBCy7nnoodX+eyg/bHp0swDlLtQRGChE46om9c6Ec2tZ0GS1bBL6J6E9a1I/Kk/poUSHkiYcCUk4VlXIPdpj56JrPSqkWH9tJuT4nFUBZMq881fsYjDJJUE4KuPdn1XbwZeGnc8o8Z4YeW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823567; c=relaxed/simple;
	bh=7s21PiKqoDI2UWcnusRjQAy1HY+xab4PIu+TPyMO0+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8GMuyebcySp1MA0E0asSEDnkxj7klJyk+NZzLUyPmake3u/hSPaaLch0IDnVI5YWikKdLGHDUezi2LLIi/qCrTW8gRYoGyuJJLciMROMGXaJj5ejUf3KJnqhgK1p3iY6IFDk577VXCq2DHNp82/+udIWRNSUDdESr5KLCpg1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LjTmYwcV; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-34c567db0a9so259192a91.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823560; x=1769428360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7MKZiatBshCjLhK/wnOMzSh/LSYhDXgYWq/2BVz61M=;
        b=NMs0yf2NxqNhMFkV9aDYenOsSP/IeerRM6H2uKAReIzgGZE8je3sWGnlZJXftNKRE+
         VzaR1CkczG3pRs7b+L0robQhuBisb5eNLS4rhGo6uU6YczCEqP/EeiYKrEBuKV3RCy21
         F7s0Jdqf8n83MMrGH8IAQlymnVORRcLni/JUko4WSPnr5iV4wpDckhbuyTK0SAh2qmsX
         +p8hpNR0j0/X0oCu/NIYoT67y9OfFecVRAMzHEX0SqukbXDJWQGJNP6w3RPOrPLetUqk
         H33BrWReKnhfk2EBrD/rzgxh8GJ5ac9R2jNqLNimFoGFj3Q5JKWPhomWE+BKZeRG8+9M
         Lq2w==
X-Gm-Message-State: AOJu0YyGllEOrfhB+kxNRe3KuZxShiB6SGW+Sbo5ILpxgawx3YEvjrL2
	fG2hiTqkffsNpAEyUY6kTrC5oMyYkecJ1QY8dMyslbhLjKrVKE0/yvVwn0NDZFUjJVCWyvTI1VF
	qdjaSop+90GTg8c7d6l1vg+tWo9H5dyDbXM/eeuNpUHbbLWuVVkIkfShRMHfnr0Q2UTr5wW9uxf
	YcpCDX+grwukZidHCCJMKEP2pEwF8KjHyZacUfla1e8Wrk1zCkKoFdFdxa17URiZb684Liq9HVq
	B0wAy/e6Zmw+FT9F9ehPK1LOf3rLGY=
X-Gm-Gg: AZuq6aJulY/lD8Y8xkxj+aPhW470mYvN91Eg1POn+egn2p2NdL31PrKPjpNzLTEBskY
	17V0NJ+gSkAgg+XYOiERY03OYS0OJvJ8YlRd0oSTBV7fWvLH5MDM2S+ZCgVuHKEekvZYDZG6iWO
	C6fujmfkgdFk5PQ+bxGpyucvI9/7ZYUp5oiBCgSMRmL6NvBtdsINnHYHrp/7mp+1T7kN8H3zV/7
	f6WO/9xc4yTwhkwvwx+/dP3qdZQuAahowSDmHrtzZnvnq0rLVzZkTi0uxTYFxGwMv4tjvlFu0f/
	MEb58PUnGu513xAlkVySutpSAydRXecbRcYZZ3bQYL1wgMDMA8WHz0Umoq/0RcgxJLhlYY+MEB9
	bhb13FUf/B9Z18oeENwJ5JblQPPxs4RdOfHo41GIyEJulAMvzG7h0TovOqyfTAybugff+eI1SoZ
	uocndsgaT8YTrpGV3ItmC1wWjqUQsBpMbbRhIlzOrrMnmNr1PpmBCoj6Li4FqUMOJy
X-Received: by 2002:a17:90b:4c4f:b0:341:88c1:6a89 with SMTP id 98e67ed59e1d1-35272ec86e1mr7277727a91.2.1768823560223;
        Mon, 19 Jan 2026 03:52:40 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-352678c6aa0sm1911437a91.7.2026.01.19.03.52.39
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:52:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c533f07450so100722385a.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768823558; x=1769428358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7MKZiatBshCjLhK/wnOMzSh/LSYhDXgYWq/2BVz61M=;
        b=LjTmYwcVbiy5z1tti4wjFBqzYMNIgH9rd65mvU/PqU4oRqOM8NG3jBUXKOzwxC///b
         YdNiJLiskSaJ5dug4jCA4Tuvsvi4kGSfRjlwfcZYAWMFx3LbR1i+WbXgnuxxNOuYR1Z9
         q/QZNfyUdNcjYPjISYpFqf3JQ60rqfgxW7MVk=
X-Received: by 2002:a05:620a:cd0:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c6a707dafdmr885240385a.1.1768823557003;
        Mon, 19 Jan 2026 03:52:37 -0800 (PST)
X-Received: by 2002:a05:620a:cd0:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c6a707dafdmr885236885a.1.1768823556365;
        Mon, 19 Jan 2026 03:52:36 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71bf2b0sm772878885a.12.2026.01.19.03.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:52:35 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 1/2] net: Add locking to protect skb->dev access in ip_output
Date: Mon, 19 Jan 2026 11:49:09 +0000
Message-ID: <20260119114910.1414976-2-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
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
[ Keerthana: Backported the patch to v5.15-v6.1 ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 3a1a6f94a..20a76e532 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -555,6 +555,18 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
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
index 543d02910..79cf1385e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -420,17 +420,23 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
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


