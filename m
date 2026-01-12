Return-Path: <stable+bounces-208042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E85D10B96
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 07:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079C03050CD3
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 06:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671715E8B;
	Mon, 12 Jan 2026 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CkhVPb19"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338FB311955
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199939; cv=none; b=Bz9jl+SPqbsU6n/8Ob9lVtcwiNLGlCo+XWTMU7YCzZx3YKhSYOx9u9Z0aTLTOb+CQF2MsCO8HrDQfenXQscLnFjhCGi9uR3RvTGSQ+88r8Cl42OnkYjRTY56T82nSQ8Ja3kSH0WWZpOqASU9s1wegEUddW4b8xeFWXb7cR9DnhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199939; c=relaxed/simple;
	bh=7s21PiKqoDI2UWcnusRjQAy1HY+xab4PIu+TPyMO0+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN3S1iOzZTnG/qrtVm9iixLqZ6MVq2zs5vIJvZfo9BC29cVZhxNjA4y7qUDPbbTRB/5S8E6qZcmwR9WZThB+oyp2Pb4BNtSThzKrdDNgWlYK/UQ0z+SMYWEN3thHNRZCFVITWShDIybey1GvCDlN5HLFy73eOLTxnPlzG3OMyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CkhVPb19; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7c72c3547e8so913766a34.0
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199937; x=1768804737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7MKZiatBshCjLhK/wnOMzSh/LSYhDXgYWq/2BVz61M=;
        b=mLXyhjNTQIH30AMchUFD1Rns1vkX65gPP+AtNxKwSxxj0hZNlvEWRa0p5AouvEk0qR
         vNoPWKZqQjQQbcUWWkDcqOZZTqAF+btvTuQEBW53AfwWttPpowRg4XgpkFN5Zif2jejS
         2+/AtaTIDmLN7+wvO0bgDydQqvExkWmOmnBjhpo7NCTESZ0qIp+LxiFwVoKb4PhLTbjR
         Lrzr/1sy7ZNueiAk86veTgcwaZVfZ7BzZdcjnaKct/pgm6UGluqwmloiDYXUs/tOlgzU
         W4OLK1C4XiRKe0Rd5ydZzMOBvwL1nQpawMrg7Kkrln21iOoDVwoOZCAAU335MUjq7LDX
         Z89g==
X-Gm-Message-State: AOJu0Yy8NMorr1sbWcZvM8sGm7BTNXLR6Bmd5fxI1z9DzVQaCYlfDxPX
	VdTs0cM6Du8Pq0svu/wRYc0p4nBdtXYwU74VWU+xXc7P+9CtGgXxQRLAHs6s3MRhwSH5/d2ACSC
	7eYh1Otihno2oCLhftaspouXURO/TvVIvDBuYYYkqbibncPcuk6GGKdRYXcEWr7DImE7KHmFg5O
	uTWFnwthirW+V2zMYk7E3mH/AX9ryscmOiB8HBbIuyOnz198JRlqk5EGvT5+uLPj5c7xMJ4P4uP
	hZAI0ZD+J+7jDFAIo+Ld3+lAmbXQCk=
X-Gm-Gg: AY/fxX5oDyrcZAk+LTME+0cuAPRBkGfD5DkyTy5UgWeaomcP1o/7WKc0mJHVIJc4O51
	xrYMV81noRbAuzwQbom3wiND0U81K/GctRHg/xBQnN1kP3srEVhre5ehYpkfF+2op02QuJ/IzBj
	N9jtuzrnMIT2zwC8QOUMTrjLmKSyqenHokOGrOcvbpB2up9jzelV48MobHqxCBVF5Tf6WEfgy3g
	RkpLOhKb5sw4oCjYo2yze+W7J9OznBQVMlqJYqwDBmryfLAgQ37P2TURhr1pncP2kpvbGoLXV/P
	ofYyO92L46pIU8A3DN7Cqrw68iGlktnOyMQoQP3Z2le/1rdVTpK34K9I3CVVftOvfc2izkOQ/Ic
	/NjXWdLNihiB8IiA1GG5Rw8Wlr5I5/Y+anl8+FKCrJvyIeGy3hNsC8FRI5xcDIL6pV4LmBMr9N0
	CZAMExXv3XohfpSRq6UMV9k+suh8luAF1rYZFu95PHQ/y9+mgY0S6lQagW1yc=
X-Google-Smtp-Source: AGHT+IGS4rPCXjELcKUflDKgHW67Mp99vE/TQ2fsgaRa4qC4BA5WBAWwLDc3+wZpCHzyof/fd81IBnDnqU/n
X-Received: by 2002:a05:6871:888:b0:3e8:4825:718 with SMTP id 586e51a60fabf-3ffc0b3f459mr7469080fac.5.1768199936955;
        Sun, 11 Jan 2026 22:38:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa4dee33bsm2007823fac.1.2026.01.11.22.38.55
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:38:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c1625bbc20so144375485a.2
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199935; x=1768804735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7MKZiatBshCjLhK/wnOMzSh/LSYhDXgYWq/2BVz61M=;
        b=CkhVPb19X3h3U8m4BDqgK40PaG3GJtIYAqJvYw2f+cM4etGFH88ctKix80xdncfhyV
         9+hHPtukhFwEpi+IR2lbKrOBSrhAdChC7GYKbPQ+Dl6mULS74PbCm1N43YpCG35WJYwm
         Yl7Bf6xkscvqML9op7qF5jnh6qpGuIRRbJKbM=
X-Received: by 2002:a05:620a:298c:b0:8a1:a5c5:ef18 with SMTP id af79cd13be357-8c389416d63mr1635580785a.7.1768199934630;
        Sun, 11 Jan 2026 22:38:54 -0800 (PST)
X-Received: by 2002:a05:620a:298c:b0:8a1:a5c5:ef18 with SMTP id af79cd13be357-8c389416d63mr1635577985a.7.1768199934054;
        Sun, 11 Jan 2026 22:38:54 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm126594216d6.18.2026.01.11.22.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:38:53 -0800 (PST)
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
Date: Mon, 12 Jan 2026 06:35:45 +0000
Message-ID: <20260112063546.2969089-2-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112063546.2969089-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112063546.2969089-1-keerthana.kalyanasundaram@broadcom.com>
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


