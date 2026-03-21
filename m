Return-Path: <stable+bounces-227745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEUGKkNrvmnGPAMAu9opvQ
	(envelope-from <stable+bounces-227745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:56:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0CC2E4883
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92B78302DF5F
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEBE2ED84C;
	Sat, 21 Mar 2026 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSW8UZHU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63B14A60F
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774086968; cv=none; b=l0dDuYu9E//PzWExrEGsVxLeSTe7mUaawIPlqDmKthm63clQUf/aLG2kWYJZPbqby3iw41b3QNzCySYMO8ho2raDvcUq8pjbG+POx6LDN7U2qUKlylB8UUpTNzX4l1pVZLSInqdDG/GN8knunHz76AFAiYSl6sC6WsNw+BlWfT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774086968; c=relaxed/simple;
	bh=BRMcPG3WkII1jZkvKPnB2ca+qKpkuj00RNIV/TEnL0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ctrc7r0g98U/nA9QbAiCFN4H88kUGKuWdAGup13WOP1u7aOpZseA3+uhQwIxSudD7j543+09PVHSLU5vomneCr4W0a08TruNoc10loXJGh1ZFprBzSgYJepoYe/o9lAbQ8O+ftEWQLtHpsOl+Llav7wYkejfNbJF7Dt+ZpnLI/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSW8UZHU; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d556c1a79eso2792587a34.3
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774086966; x=1774691766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caEnVxc0GbRkH5ZoicQ0BGlIOG297AP/WSk2gGlKu68=;
        b=bSW8UZHUQ1t76Xkuy8oq2EAMUBm/BUkjoXCyYjH1WnrGDuqqDfgfDm2638Vnw++kta
         OH+DMKF3+TfPNK2TTkv+Miy3A9Ir3lyMsrQwYSKnL9veXCzfEZ3RoZ5UkU2n12bE/50m
         ZLZlzk4NakdlgE7E4TB+3uzK+INC7VbPZbsgEBCdfzZMHcYG7UooN9chwVLKfcCF27Ik
         gd3Bx+TKxiVA5NUDWuJro7iGll2cjjvCDnjUajTrJCka2VWEUMcg0E89bTfeUqkBgZmX
         XdgtwoQvJldMVG+/EZePWfy8fJDeAP/Odixpk9djux3X5ymHfyCK5Dk/nIyYSnzl3//6
         +HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774086966; x=1774691766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caEnVxc0GbRkH5ZoicQ0BGlIOG297AP/WSk2gGlKu68=;
        b=rbIgw3fdrYWO+Ur/IPkRDkzke2lV/6+AHOWQOI7JniIuPZzyAixSt+YDhEYlWFfDRq
         w4KudsTL8VoB/TmaQQlyVU1S9BrDil+d+47b1spAui2XPOXFrZ2F2XI/sJi+1ahZCQ4p
         d/Ztl9tLlaVZto0FpS2XEP3oKWBnrGxJPZZNDSVXj3uxu7bhNPvS4x1+f1xf/maKzlX1
         XMZySRoZMInS3JCB7Z2umS5jDErXC97GbSx4soGJkIhqkRbhmDwanzgw+p/DnW8OrssV
         b7UGNDqbY/B8tjakpuGDrpyrKyI8LfNTq1YpTifAVUsb8j1wT0tnGEkeV4HFtYuIba+2
         XMUg==
X-Gm-Message-State: AOJu0YzE7BLCdx+HjV7qd/9zsaA9ZjOjlRVFPssksRdQgsSzJlTWrGGt
	XvO0RYk1knDHmp10NLDWFt3QG1OWx4ZkQvghiAQbM2XPjq/XIyITUJTCEbXKTF4V
X-Gm-Gg: ATEYQzzI24kyupNxhH00EHnfTiEAz6vdw82EYR0IM+1CIG98z8BEPf6IjWRhBs0s2Fy
	WhPqDcGy1A8H7d9vfDrPWfGB9uzhs5Lpdf8/32zO1O43HccXv+yjPubNE4XFzn/AJ7kS9985iiF
	pQfgNPwQ32LVO09uoGSr/vTO0GGp1J8fsT0/3MsfYV6seCs7OnQa3FbibU0TFVacK2Ay9WOQQoo
	PJRA5Ij6cWlNXLDKYE4cAQBaTeAugLEN2MW1aDgsZvrFzBPWcImDiSt7VLylvNq0/0H6L8KYUdk
	5wdtDlhTgptv9tNc40BPmEom3ffwj8TGKmN903BwNeCkTqsl7AycevdnLq55msZ5hM6pyV2mBsL
	nGbVJLmlfKh8/5AYmxrvZTwz2xNcBYkrpUF3RFg/2TRltHzZdiBBDcV0FNPOZ+8sVNeUhFU5IRS
	CaXGTsoR/N7rAdsnPq/cZua+32Ok9nb8VKNdMXrcThndjoAG01EOUDGkjWqSV4aw==
X-Received: by 2002:a05:6830:448f:b0:7d7:d50d:b088 with SMTP id 46e09a7af769-7d7eafd8a80mr4025483a34.28.1774086965723;
        Sat, 21 Mar 2026 02:56:05 -0700 (PDT)
Received: from Linux-Ub241.fyre.ibm.com ([170.225.223.17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eae10537sm4507609a34.22.2026.03.21.02.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 02:56:04 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: stable@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH 6.6.y] net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
Date: Sat, 21 Mar 2026 02:55:39 -0700
Message-ID: <20260321095539.239506-1-chelsyratnawat2001@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,kernel.org,google.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227745-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chelsyratnawat2001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f3a497f02c389d86ef16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email]
X-Rspamd-Queue-Id: 2A0CC2E4883
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Dumazet <edumazet@google.com>

[Upstream commit 4fe5a00ec70717a7f1002d8913ec6143582b3c8e]

syzbot reported that tcf_get_base_ptr() can be called while transport
header is not set [1].

Instead of returning a dangling pointer, return NULL.

Fix tcf_get_base_ptr() callers to handle this NULL value.

[1]
 WARNING: CPU: 1 PID: 6019 at ./include/linux/skbuff.h:3071 skb_transport_header include/linux/skbuff.h:3071 [inline]
 WARNING: CPU: 1 PID: 6019 at ./include/linux/skbuff.h:3071 tcf_get_base_ptr include/net/pkt_cls.h:539 [inline]
 WARNING: CPU: 1 PID: 6019 at ./include/linux/skbuff.h:3071 em_nbyte_match+0x2d8/0x3f0 net/sched/em_nbyte.c:43
Modules linked in:
CPU: 1 UID: 0 PID: 6019 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Call Trace:
 <TASK>
  tcf_em_match net/sched/ematch.c:494 [inline]
  __tcf_em_tree_match+0x1ac/0x770 net/sched/ematch.c:520
  tcf_em_tree_match include/net/pkt_cls.h:512 [inline]
  basic_classify+0x115/0x2d0 net/sched/cls_basic.c:50
  tc_classify include/net/tc_wrapper.h:197 [inline]
  __tcf_classify net/sched/cls_api.c:1764 [inline]
  tcf_classify+0x4cf/0x1140 net/sched/cls_api.c:1860
  multiq_classify net/sched/sch_multiq.c:39 [inline]
  multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
  dev_qdisc_enqueue+0x4e/0x260 net/core/dev.c:4118
  __dev_xmit_skb net/core/dev.c:4214 [inline]
  __dev_queue_xmit+0xe83/0x3b50 net/core/dev.c:4729
  packet_snd net/packet/af_packet.c:3076 [inline]
  packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108
  sock_sendmsg_nosec net/socket.c:727 [inline]
  __sock_sendmsg+0x21c/0x270 net/socket.c:742
  ____sys_sendmsg+0x505/0x830 net/socket.c:2630

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6920855a.a70a0220.2ea503.0058.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20251121154100.1616228-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 4fe5a00ec70717a7f1002d8913ec6143582b3c8e)
Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 include/net/pkt_cls.h |  2 ++
 net/sched/em_cmp.c    |  5 ++++-
 net/sched/em_nbyte.c  |  2 ++
 net/sched/em_text.c   | 11 +++++++++--
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index f308e8268651..ccc1c698ed00 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -525,6 +525,8 @@ static inline unsigned char * tcf_get_base_ptr(struct sk_buff *skb, int layer)
 		case TCF_LAYER_NETWORK:
 			return skb_network_header(skb);
 		case TCF_LAYER_TRANSPORT:
+			if (!skb_transport_header_was_set(skb))
+				break;
 			return skb_transport_header(skb);
 	}
 
diff --git a/net/sched/em_cmp.c b/net/sched/em_cmp.c
index f17b049ea530..71ce113f2d08 100644
--- a/net/sched/em_cmp.c
+++ b/net/sched/em_cmp.c
@@ -22,9 +22,12 @@ static int em_cmp_match(struct sk_buff *skb, struct tcf_ematch *em,
 			struct tcf_pkt_info *info)
 {
 	struct tcf_em_cmp *cmp = (struct tcf_em_cmp *) em->data;
-	unsigned char *ptr = tcf_get_base_ptr(skb, cmp->layer) + cmp->off;
+	unsigned char *ptr = tcf_get_base_ptr(skb, cmp->layer);
 	u32 val = 0;
 
+	if (!ptr)
+		return 0;
+	ptr += cmp->off;
 	if (!tcf_valid_offset(skb, ptr, cmp->align))
 		return 0;
 
diff --git a/net/sched/em_nbyte.c b/net/sched/em_nbyte.c
index a83b237cbeb0..2e3c1d58d456 100644
--- a/net/sched/em_nbyte.c
+++ b/net/sched/em_nbyte.c
@@ -42,6 +42,8 @@ static int em_nbyte_match(struct sk_buff *skb, struct tcf_ematch *em,
 	struct nbyte_data *nbyte = (struct nbyte_data *) em->data;
 	unsigned char *ptr = tcf_get_base_ptr(skb, nbyte->hdr.layer);
 
+	if (!ptr)
+		return 0;
 	ptr += nbyte->hdr.off;
 
 	if (!tcf_valid_offset(skb, ptr, nbyte->hdr.len))
diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index f176afb70559..32aae8a9deda 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -29,12 +29,19 @@ static int em_text_match(struct sk_buff *skb, struct tcf_ematch *m,
 			 struct tcf_pkt_info *info)
 {
 	struct text_match *tm = EM_TEXT_PRIV(m);
+	unsigned char *ptr;
 	int from, to;
 
-	from = tcf_get_base_ptr(skb, tm->from_layer) - skb->data;
+	ptr = tcf_get_base_ptr(skb, tm->from_layer);
+	if (!ptr)
+		return 0;
+	from = ptr - skb->data;
 	from += tm->from_offset;
 
-	to = tcf_get_base_ptr(skb, tm->to_layer) - skb->data;
+	ptr = tcf_get_base_ptr(skb, tm->to_layer);
+	if (!ptr)
+		return 0;
+	to = ptr - skb->data;
 	to += tm->to_offset;
 
 	return skb_find_text(skb, from, to, tm->config) != UINT_MAX;
-- 
2.43.0


