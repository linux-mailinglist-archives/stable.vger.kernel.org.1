Return-Path: <stable+bounces-245142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONpLLtaIAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:44:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE4509754
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD42E301CC4F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA20391846;
	Mon, 11 May 2026 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="JO6Tu/BB"
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A8438F240;
	Mon, 11 May 2026 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485115; cv=none; b=QzAPzkS/SBzCDly91TSyDWl6HHP8u6BiFizCFXp7pKXmcA7J/4D7iLPn70SOUrHuiDDka8LKD05tMUuznBlVVy2nFszTw1wD1p0zDQwHcE1gIOuZ308DseNTaaRf7/ExzIlYZUqNkhVbZ1BkT8n1pty0qdD/8TwArqLL9uviMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485115; c=relaxed/simple;
	bh=AdfTFqO9wPDz9dgkxhxKtmKh6c8/2M88QdIrqLOMCRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaYwv+cdN76Cu9536rcK+GDgy+lcgiVrItTuhoth6ZzvUCZQ957M1FXg1OcA9EZ6mvkGjFJJUaQWdXuGbyMD+fLz2euxQe1sTe+j+Yy1S32OaiicR6rKRvn1SANLqcociGpCG7K09VZBpQuRBxxxJG9etMYRkx2tJ6XE6FuYOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=JO6Tu/BB; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=SjLTA21nDS6blnuNzN7xH1FZ1HYmnxFk6b
	jhiNyeEbg=; b=JO6Tu/BBjVP+6RWMz7SfoU7pbo7dnYVN+8iVtA+l1Qrunfw+Mj
	Ab1wRdgIALBLub1CSGCwAET0lb12PjaegL1Cf11jRwPv7Ky/RgYgd7NGD7HnX0/g
	9MtCb16Q6c0sSbnLJldCXYm1IaGrd0rlPlTLccJtuxCpY2QGAMI1bZui0=
Received: from localhost.localdomain (unknown [36.110.46.68])
	by web5 (Coremail) with SMTP id zAQGZQBX4LpjhwFqvop8AQ--.60144S2;
	Mon, 11 May 2026 15:38:12 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: edumazet@google.com
Cc: davem@davemloft.net,
	fengxw06@126.com,
	horms@kernel.org,
	krikku@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	liuhangbin@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	qli01@tsinghua.edu.cn,
	sdf.kernel@gmail.com,
	skhawaja@google.com,
	stable@vger.kernel.org,
	xuke@tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	zhaoyz24@mails.tsinghua.edu.cn
Subject: Re: [PATCH net] net: core: dev: add reprocess depth limit for another_round in __netif_receive_skb_core
Date: Mon, 11 May 2026 15:38:06 +0800
Message-ID: <20260511073806.4763-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <CANn89i+wKfikSrBJ+eatERFx+kC+vQV4WDTe9aCERiv9HtncDA@mail.gmail.com>
References: <CANn89i+wKfikSrBJ+eatERFx+kC+vQV4WDTe9aCERiv9HtncDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQBX4LpjhwFqvop8AQ--.60144S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4xZr4DXw4UuFykWr4xtFb_yoW8XFW3pF
	45KFW2yFWDCr4xurZ7C3Wqvr1ftr48KFWSkayrKa4UArnxtF10gr4fCryaqF45JrWfCFy3
	KF45tryUuan5X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
	AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREZjjPUU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgEEAWoBBhjWcwABsX
X-Rspamd-Queue-Id: 3BCE4509754
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,126.com,kernel.org,gmail.com,google.com,vger.kernel.org,redhat.com,tsinghua.edu.cn,mails.tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245142-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tsinghua.edu.cn:email]
X-Rspamd-Action: no action

Thank you for your suggestions.

> I do not think we need a specific drop reason.

Maybe we can reuse SKB_DROP_REASON_TC_RECLASSIFY_LOOP?

> Can we please try to fix this issue without adding yet another cost in
> the fast path.

> Presumably this could be done before one specific "goto another_round"

Is moving the check just before the TC redirect handling seems more reasonable?

Here's a sample patch.

Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/core/dev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 831129f2a..bb9ae92f0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5958,6 +5958,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	struct net_device *orig_dev;
 	bool deliver_exact = false;
 	int ret = NET_RX_DROP;
+	int redirect_depth = 0;
 	__be16 type;

 	net_timestamp_check(!READ_ONCE(net_hotdata.tstamp_prequeue), skb);
@@ -6031,8 +6032,16 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		nf_skip_egress(skb, true);
 		skb = sch_handle_ingress(skb, &pt_prev, &ret, orig_dev,
 					 &another);
-		if (another)
+		if (another) {
+			if (unlikely(++redirect_depth > XMIT_RECURSION_LIMIT)) {
+				net_warn_ratelimited(
+					"%s: redirect loop limit reached, dropping (dev=%s)\n",
+					__func__, skb->dev->name);
+				drop_reason = SKB_DROP_REASON_TC_RECLASSIFY_LOOP;
+				goto drop;
+			}
 			goto another_round;
+		}
 		if (!skb)
 			goto out;

--
2.43.0


