Return-Path: <stable+bounces-238230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPCQJmEP4GmzcAAAu9opvQ
	(envelope-from <stable+bounces-238230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:21:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2149A4088C4
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AAE43009F38
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1B439183C;
	Wed, 15 Apr 2026 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvpp6JNZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4313845CE
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291584; cv=none; b=Kzg/gZKAc1fVW0UARENPb7ZtnPscREkuChZNHo49yfHqxzSTRf0jPJ0iNDx03AtuEPZLQUF+x/njDWAsriRKfYwWHAvn6iPOgreDOEqkpLIT78c8vSh4YE3BA8sIdSO1KGOILDQCu5XCF82ddi8km6Q7C6KFLmhyOLqXjHnDcsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291584; c=relaxed/simple;
	bh=IAuy9u94sAq5WV4QOVQa/OCnoTWI/Y52P5nyuTKVal8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kl9j7FVHtb8yAPmtw+pJOvUq/Zbs+YgvW6gOS5aDJbK66w5ZLCqGYNGNvYmTI45xLo+rzZGbGVnJJ+kwr+5DKwYapwEHM8Z7uLDVRiyV+zxPboN3iX4juI7SdmUtG0APS9IG5c5vM4Mjw7c5ObR8Fbr9317Aqih4zrKfQDTRWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pvpp6JNZ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbcb467f2bso6590642a34.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291581; x=1776896381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl5umjMJ1TtVXshrkkF71w9mEtGrPqQRPbrkTogix3g=;
        b=Pvpp6JNZJtvqbth2KyTSsw2wakg6QO2chY/MzTN0ipJZAlMkALGV41EdTqSDopLo9H
         msu0DN7t0dogot8udaXk3+ZHOLpxDlXQIPOys/DKhxRB0gXW1QZ3mODRRWq0tLS/AZ2e
         tg3JXThNzJPShMRROhbnPMuuCkFEDynkgkRBHRJVL//IOZvuJYsBAzdhT8bNMJNpmgDH
         uIqArYfdluE38cSvexc3yVXS0F1/c0EnFxnsvmwJUe3czPreUOOEJrNvmXiocn3eVxPr
         uJ39V3nKZKuoS2Y5jPJiIAvWdD5L8/I0M1660ZGaUJEhAbwQuKGibgyEpg1nhXqtzx+w
         YdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291581; x=1776896381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl5umjMJ1TtVXshrkkF71w9mEtGrPqQRPbrkTogix3g=;
        b=VeDjdQYw6uMIm6r4/1/xt+dGAuowlBfGfPtJZEKYRjxEGOIkhzTh/4ncEJmsuIjx6+
         WvuHv9QaRDGHJvoh/aXPieNTxJpIQO0u2P8ZrwM8iY6McfB+0xIorJOKKoxvp9HzJKEH
         P16kBazVPYErJeSAQnU1yfld/t0ptVD9mr2uMldqq6nIrXwKkAbcmoWPCYLUMLi4CP/I
         tPl8+Lnxn1bIEdgTLVBJ++aLnYMdynBdxjnE5nLYQFIKaR+DSQ9A6yv5P9DAYsi2r26M
         l0I+2h3ALnjnEWr9m2e56gbvlhbvVsVAYaiRJXfpaNo3UxTEyPopXGgoHu9Bae3syVJ+
         DDvw==
X-Gm-Message-State: AOJu0YyANsra/izX/HE7QuFauWK0vjL74VYPU9266LPW8mOtgOJMNAhU
	voNUTbPDwnrdS8WidKQki/l1ht3G1ai57ggMxT3EoGYbowdUyPE3bZf16Xp4G0qZ
X-Gm-Gg: AeBDietC//zjVl77mb6160z+czrD8UU1Pk8zFc7W1zn9uOsBLFcrD2lVqEKflJYbr0q
	I42UC1haDujCIlhlWYw4Pn5lrJUc97zU4kij/Xl0I15P4rwHdfDjXrfOZnmAFL1vk5Zkhq1ixSQ
	2+v5Kok77zgg3OZKzuFU7O1F0XxlbNoJsHPETDrMk0SAFImbG9Lhb56ARCpnp5AaNABWr3P3I+8
	i3m7QrNttpwpP0w2OcL7Zy35kIVAF5WdzurniJtck7Rezv6CTK5+7EbdrIaTab7NXVLRktZW9dG
	6cbW8kEpOfyRIGQj3ZfwMt0ydMZS3HMkSFqewAoJCd9plMHeQLjXDozgkq3qUy3RaRAplAaGVAF
	QJPIMGBSsP27I02aT9p351MdoAa1lNdppJH+wbfHL6ojBC+FcxSzVmJ0eaH25r68kjtC/ZPlwbE
	mMPZneoquvko7QwzTKUFowWX/IMgNCo3supSJt9j/00ioNsTPHHeJRRvF228j7f6I=
X-Received: by 2002:a05:6830:449f:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7dc27f116ffmr14481562a34.17.1776291581352;
        Wed, 15 Apr 2026 15:19:41 -0700 (PDT)
Received: from Linux-Ub241.fyre.ibm.com ([170.225.223.17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc76a1284fsm2343430a34.5.2026.04.15.15.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:19:40 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: stable@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH 6.6.y] net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
Date: Wed, 15 Apr 2026 15:19:21 -0700
Message-ID: <20260415221921.852361-1-chelsyratnawat2001@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238230-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chelsyratnawat2001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f3a497f02c389d86ef16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 2149A4088C4
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


