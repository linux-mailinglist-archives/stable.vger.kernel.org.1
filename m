Return-Path: <stable+bounces-245103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOUcNLB3AWpGaQEAu9opvQ
	(envelope-from <stable+bounces-245103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:31:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D125088C4
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4DB6300B3D5
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4B2BEC2C;
	Mon, 11 May 2026 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="TkTQsnpk"
X-Original-To: stable@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA504282F29;
	Mon, 11 May 2026 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481068; cv=none; b=iUVLSoz8jFkOlkyR1dGtIonsBXaJU5WOuzyFX431wOl39abBXsnAe1Jnd3Ue/XKPJraaY/dsYu95VzCvZsOi05l92a1YtfwjTODRK3eILGdlyCEYCmknccaSLqVIrjd0G/W/03Ad0DbVMXkbLZ98N3ZlMB+eOiEUSx5yUwXwKWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481068; c=relaxed/simple;
	bh=Pn+MVEvwUdy7CFq+ZSScsQJw4S58LM/Pv6EhCfYrS78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eU5Bw3yYlVggIN0E0SvoAKXOIAkNTDofpikvsW2Rtuv+N5gx8d8Ec+ba/Pm1VodBVKZ7dKqioPKvHkXPnMW1kxulYuKrjDvaeLaPS0nvg4mJGPYTOZL3hT3hLpudVqaH2JQfSWrPgBTUdPoHMhm/fBeu6usjsNuyOzGvk3yIn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=TkTQsnpk; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=MWCK1
	ZVD+6mmVvqYKw5PjK59TsuwZErWPh+RHz+te1k=; b=TkTQsnpkIz3mO1r4jftXc
	JiSxeF6r4ek8VUZI75wLvYWVfhwZ1ffbrFROC+3meAOpjMzkd+Pe4R5aLo3oEVSs
	EM3QsUjlsotf4vzVS0oxy23t4YugUlsRCXXvxg6ej0L9X06mVDFm/OU4R16GPJ+G
	kRbXPaopLKiTAS73RRD+Us=
Received: from localhost.localdomain (unknown [36.112.199.54])
	by web2 (Coremail) with SMTP id yQQGZQB3UJiRdwFq1ThsAQ--.51354S2;
	Mon, 11 May 2026 14:30:42 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] net: core: dev: add reprocess depth limit for another_round in __netif_receive_skb_core
Date: Mon, 11 May 2026 14:30:04 +0800
Message-ID: <20260511063005.38134-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:yQQGZQB3UJiRdwFq1ThsAQ--.51354S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1DGw18Gr4rJr48Zr4ktFb_yoWrKr4rpF
	ZrtFyIyF48Gry2y397Aa1I9ryxJFWkWF43Xa4fKa4xA3Z3GF1rX34SvryYqF1ayrWS9340
	qFWDGrW8Zan8XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
	AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sR_w0eJUU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQYEAWoBBSzD9QAAs2
X-Rspamd-Queue-Id: 07D125088C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245103-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,126.com,tsinghua.edu.cn,vger.kernel.org];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,z.ai:url,tsinghua.edu.cn:email]
X-Rspamd-Action: no action

In __netif_receive_skb_core(), the another_round label can be reached=20
via a TC ingress redirect (bpf_redirect_peer returning -EAGAIN).

Across network namespaces, two BPF programs on peer devices can redirect
packets back and forth indefinitely, creating an unbounded loop that=20
monopolizes a CPU core in softirq context. This leads to RCU stalls,=20
soft lockups, and system-wide denial of service.

We reproduced it by creating a pair of TC BPF programs across two=20
network namespaces that redirect packets to each other, and the RCU=20
subsystem detects a stall:

```
[   24.835219] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:=0D
[   24.835837] rcu: 	(detected by 0, t=3D21002 jiffies, g=3D-627, q=3D2 ncp=
us=3D1)=0D
[   24.835959] rcu: All QSes seen, last rcu_preempt kthread activity 21002 =
(4294691810-4294670808), jiffies_till_next_fqs=3D3, root ->qsmask 0x0=0D
[   24.836239] rcu: rcu_preempt kthread starved for 21002 jiffies! g-627 f0=
x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0=0D
[   24.836362] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, O=
OM is now expected behavior.=0D
[   24.836460] rcu: RCU grace-period kthread stack dump:=0D
[   24.836601] task:rcu_preempt     state:R  running task     stack:15448 p=
id:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00080000=0D
[   24.837139] Call Trace:=0D
[   24.837568]  <TASK>=0D
[   24.838008]  __schedule+0x4ed/0xea0=0D
[   24.838934]  schedule+0x22/0xd0=0D
[   24.839023]  schedule_timeout+0x81/0x100=0D
[   24.839095]  ? __pfx_process_timeout+0x10/0x10=0D
[   24.839165]  rcu_gp_fqs_loop+0x11b/0x650=0D
[   24.839226]  ? __pfx_rcu_gp_kthread+0x10/0x10=0D
[   24.839282]  rcu_gp_kthread+0x17e/0x210=0D
[   24.839333]  ? __pfx_rcu_gp_kthread+0x10/0x10=0D
[   24.839383]  kthread+0xdd/0x110=0D
[   24.839433]  ? __pfx_kthread+0x10/0x10=0D
[   24.839481]  ret_from_fork+0x1aa/0x260=0D
[   24.839538]  ? __pfx_kthread+0x10/0x10=0D
[   24.839585]  ret_from_fork_asm+0x1a/0x30=0D
[   24.839686]  </TASK>=0D
......
```

Fix this by adding a depth counter at the another_round label. When the
counter exceeds XMIT_RECURSION_LIMIT (8), the packet is dropped. This=20
follows the same pattern as dev_xmit_recursion() which protects the TX=20
redirect path with the same limit.

Add SKB_DROP_REASON_RECEIVE_REPROCESS_LOOP for observability.

This issue was found and reproduced with the assistance of GLM 5.1 from
Z.ai, affecting stable versions from v5.10.

Fixes: 9aa1206e8f482 ("bpf: Add redirect_peer helper")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Reported-by: GLM 5.1 from Z.ai
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 include/net/dropreason-core.h | 6 ++++++
 net/core/dev.c                | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a7b7abd66..f0f420f39 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -130,6 +130,7 @@
 	FN(DUALPI2_STEP_DROP)		\
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
+	FN(RECEIVE_REPROCESS_LOOP)	\
 	FNe(MAX)

 /**
@@ -622,6 +623,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_PSP_INPUT,
 	/** @SKB_DROP_REASON_PSP_OUTPUT: PSP output checks failed */
 	SKB_DROP_REASON_PSP_OUTPUT,
+	/**
+	 * @SKB_DROP_REASON_RECEIVE_REPROCESS_LOOP: __netif_receive_skb_core
+	 * exceeded max reprocess loop iterations (another_round).
+	 */
+	SKB_DROP_REASON_RECEIVE_REPROCESS_LOOP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/core/dev.c b/net/core/dev.c
index 831129f2a..376b595b3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5958,6 +5958,7 @@ static int __netif_receive_skb_core(struct sk_buff **=
pskb, bool pfmemalloc,
 	struct net_device *orig_dev;
 	bool deliver_exact =3D false;
 	int ret =3D NET_RX_DROP;
+	int reprocess_depth =3D 0;
 	__be16 type;

 	net_timestamp_check(!READ_ONCE(net_hotdata.tstamp_prequeue), skb);
@@ -5980,6 +5981,13 @@ static int __netif_receive_skb_core(struct sk_buff *=
*pskb, bool pfmemalloc,
 	pt_prev =3D NULL;

 another_round:
+	if (unlikely(++reprocess_depth > XMIT_RECURSION_LIMIT)) {
+		net_warn_ratelimited(
+			"%s: reprocess loop limit reached, dropping (dev=3D%s)\n",
+			__func__, skb->dev->name);
+		drop_reason =3D SKB_DROP_REASON_RECEIVE_REPROCESS_LOOP;
+		goto drop;
+	}
 	skb->skb_iif =3D skb->dev->ifindex;

 	__this_cpu_inc(softnet_data.processed);
--
2.43.0


