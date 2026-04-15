Return-Path: <stable+bounces-238220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJBJCdYG4Gn4bgAAu9opvQ
	(envelope-from <stable+bounces-238220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:44:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A640843E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91785302417E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB638F65D;
	Wed, 15 Apr 2026 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqgQ4Re5"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17586381B0E
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289469; cv=none; b=Mw05hICBm6dmf7J1CR+bX4JAZycSEACWiieMi+7YNJ0nDnRPazVSRBF9simexGNAOqUanCUeW56vyZvKpi34Eh/tYEoBeNURY0EzakysmQaYveJUMeG/XqJfqXoS9mM0R1W+3+P2NS5s1vmAx6tca3W8QL5nvZedK0gxe3nWYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289469; c=relaxed/simple;
	bh=CkpT6MlRMvxkRq6peoyE0lutf1olv0PSQLuyxVknvRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeCBPrw87a1xXaR+gMqdrPrG8jzw2X/ao2N38XlIoXMUMxyIftG/HtMiUi8gW/2QObdokvZ2Z/b4KOMuVXRABcq7Tq3a5vMz4RfQ1R3CG9zgv987GfwZVneClz8MgRTS8U4q8DPnWQ3HQe3XxzbPX7jMPAFjNFu29z3YEAVeQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqgQ4Re5; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-463f00cda04so3817267b6e.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776289466; x=1776894266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fjdvs6iZyA6gYFEH+VaIPQ6QPCaEX9lwSbOfQ9rMQY=;
        b=AqgQ4Re5Wo5Hk89C5Rbrg7VrXrP+GIT9afQuv68MuM+E2c8VCTIFDJeLKsm07Hnq2P
         Za8R/WCE2CN1ea4LI0le0psWTex8txwSyv+SimEB/pSwXUW0GG9hsDBHsKICv0CLP4RR
         BqsCFv2wnq1vafltz0KycQUbsuFfj1jfbmRxhyINPLDcmAKrAem3vJotS2i6G1pkNMSB
         kZkNALq/TOkyriV7vaeHEmxyUTll7MfPxtCxP6153eWQ88VChlQpwmU6b4npSqOdGxa9
         h89tNkWVrlkyBRfxWJlJugbbchPCb5mXnLDHogMTf4y2DG2IIdBlwv3jd+/HbL1p/D/q
         vpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776289466; x=1776894266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fjdvs6iZyA6gYFEH+VaIPQ6QPCaEX9lwSbOfQ9rMQY=;
        b=O+Qa8FU0QwfsxF6e/CfkOl+XRH8/tzjmW26Ge0HQaQB2ynZvkoKQj6S23DJyrAPjGt
         CIUMG8ccl/T6J/8HZ4d9cws7jwg+/kDO4M2FZC5exkbbWDGtka6xtZDObmAlM4PBo8TV
         devLJ2sSw2I6XxUPuFPnrByuc+dqBviLpM21p+ypRbrrddQgb0T8Mj0yOeEi5sKEr2Fv
         A7wZt0sABqPKV3HY0eHSrOaGUW+hZJzwWPY1+AsvRPn0D+qoX79AQ0MAKZb199u8pABp
         s540pED06Rfrc/nK7L9iQVNYNDaLHsK88a5n5/iK+/tNYccLzgkYGiPQWHajLXmPcmDp
         98qQ==
X-Gm-Message-State: AOJu0YxX/s7N1uhgXU0npodcuarE7YvSZhQZ1rX+DJnU/5Nzl/1HzQ0k
	nXSawwmdf/e6ttLktDCZWt7Xtr8mU+1FHTJrLpdlOW+nip5ZffcDoBKHSl6Y+g==
X-Gm-Gg: AeBDieusII77UDppY4+yJx8sMkadxq9i7zYSm3wJde0GRx9ZlYWC1+vvIW/nZeQ3EL8
	gyAP1xumcKVM/h94eExPY2MnKRZF95v39FHdoCaDTqaOwVs5preGrgiY2sKhj+loKS0TirTFtqX
	WT4ZMWpstXHsM9KZ4cW1g4hb1Msf92ZI4af0sbkUiNX2Fd7/IzddHOUjWWkTIhiJIvrN/2fSIB/
	QFGytT9xyMCpzE94jZ/4ZUo3skGWAZLgZqiiQaAvWjOBxoqm6NaOZ8OzhDefth22/0Oz1Lvp1iX
	Zme93NdSjxS5L12TXGfEitxZ13Iiydlw8VTHFEQjrBCEZ2hc/qXq7MuehFFpe72O95Dw++MWMcy
	v95vAnYqg98abYdzb93Wqk1qF8KCVr77D6a9g3zIYjS7EMcJ7Oys81ZV0cjH0t+p2rpPkHRI4gj
	6Pp/Ko8Ig5UwsATRWB46CfuzKNv7Doq+l4hBm2g2Ka7hsFB+jMJeJXnrbxM3+Y6GE=
X-Received: by 2002:a05:6808:2394:b0:472:878f:347d with SMTP id 5614622812f47-4789e722842mr12909094b6e.26.1776289466511;
        Wed, 15 Apr 2026 14:44:26 -0700 (PDT)
Received: from Linux-Ub241.fyre.ibm.com ([170.225.223.17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc76a32cbfsm2067030a34.9.2026.04.15.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 14:44:25 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: stable@vger.kernel.org
Cc: jhs@mojatatu.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH 6.12.y] net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
Date: Wed, 15 Apr 2026 14:43:48 -0700
Message-ID: <20260415214348.850171-1-chelsyratnawat2001@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,google.com,kernel.org,redhat.com,resnulli.us,davemloft.net,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238220-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chelsyratnawat2001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f3a497f02c389d86ef16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 974A640843E
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
Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 include/net/pkt_cls.h |  2 ++
 net/sched/em_cmp.c    |  5 ++++-
 net/sched/em_nbyte.c  |  2 ++
 net/sched/em_text.c   | 11 +++++++++--
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 4229e4fcd2a9..ea2c69fdc839 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -536,6 +536,8 @@ static inline unsigned char * tcf_get_base_ptr(struct sk_buff *skb, int layer)
 		case TCF_LAYER_NETWORK:
 			return skb_network_header(skb);
 		case TCF_LAYER_TRANSPORT:
+			if (!skb_transport_header_was_set(skb))
+				break;
 			return skb_transport_header(skb);
 	}
 
diff --git a/net/sched/em_cmp.c b/net/sched/em_cmp.c
index 64b637f18bc7..48c1bce74f49 100644
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
index 4f9f21a05d5e..c65ffa5fff94 100644
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
index 420c66203b17..8331f38eadc6 100644
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


