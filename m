Return-Path: <stable+bounces-238325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF3KMu/44GkloAAAu9opvQ
	(envelope-from <stable+bounces-238325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:57:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A46E410011
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E8233013A85
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F049831D372;
	Thu, 16 Apr 2026 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrWnLUU6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31823D2A1
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776351252; cv=none; b=kuN//zcRmuzmYsGvpAjHJUg7Cj6vrnm7LZApMwWMFCYKni55FEAYxggIdOMIv1o3lATnX5uF1Kp3fZxTxympMMsUJ0x4jw4tVnBcfDi3Z6zjOs6gGekVWNrvCapG9r6MpThwAuC6xxIoPWI9cv/WxRQqsS+oRfBdCzp0dcIvpp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776351252; c=relaxed/simple;
	bh=ihvpnRQDYkNIGeEpNTlasFYwfrTj5zbIHvDs9JTg2mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqJ2ikVl0Y8b6/XrHX5D32FK0iWptTYK/zFJhd6cNJYPZLqcjcQeG5fsXeAwgDBJM0KgjhNXfAxMr9SkCeB1S1+2wuO2DxOfjYHiLAf1eDVOFWCBZ6QEIa9W+OvC2IZIBa4GehdpkbPD190zsC0qRRs14n6her/raRJvcJXQmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrWnLUU6; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-470145d7df5so4793110b6e.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776351249; x=1776956049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3PHN/TxGK1NGoHIUx94CNuzwAu5YZl/GiVBvs+APcho=;
        b=jrWnLUU6SioS3QQnVVAKUaKKngvgWY3Cxbf51N+q7IA9PP53meHCrdEz61XlTGbH96
         2YFkel/V972tMhtnQhau6fRCVcxATwmKxWZIXMFYax+HrnesoyL0riHTJv4kMwFETWqK
         mBT1pgEzljWLqmvr1GlZbH6I6Sjw6rjIZ1w3vXCAL1YRIYnMstUJH6stTZ+oltV/0gXp
         OxF34JyjGbDrm1aZNT81uPAhLxLzfwQmfudQAYd6fl58IOUhEABXppCPBzi9dJt3T8V9
         tjFdu0ombf9Bi5GtSEhidz5b3ZLorI5JVGXA/INKEVOAXjLGtCuOTB0bDscfl4JVRBWY
         JcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776351249; x=1776956049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PHN/TxGK1NGoHIUx94CNuzwAu5YZl/GiVBvs+APcho=;
        b=PemPmHbtZXy8YYqDylEsWwY/LUaMZlrA+/6S+BX9sqBHqww4boeYw5vYBBaGq9ecCP
         pW5EtFR1G3jmbTR5KcZ/g+wkztE3jBOa4rs4CbVcZfsce3ZyjtS47lG2LlEYFzYdz7Ek
         WSCtPi1ENfKoThyldXQvM5bBlVhrAmDzh/vkW3qKTrEBdDcrUJiFD95WTE/TuErybxCD
         ERW9xmhTmnA/n/GUrBY10AellAvkRSPLepZtqg/4ftPQuK5QcTIBX7oUToHTkjm7IVCY
         TgLHdy2CyQ9CX3Oekr27b+fnexX5Lu4Dex+XeUcAZT8bBkIEAp42lFWmdwzsvSigVB53
         KwTg==
X-Gm-Message-State: AOJu0YxyEoh8BBrTbVGglYMx4QT4FfgHiE9fjuTOCngwRmVQW25ImqIm
	V3d8mVzoRH1319SvTiknH8+VFlK9vntIbOURYFQqPFWmLWPxg08f+lzGCO6lKc9C
X-Gm-Gg: AeBDiev8b4MllEimQuzJNJr+7PkAd5O6UXYbcOxQevhP/TiD4MCL3xzDDhn8PMP8iL+
	10coQxR8rOHSRP5kTIvAeG3LQYIAfNfwSGCrceeNjQ902kEnAO19SfS0WN9V+J/fR7Fg4C9ZZkS
	vT285Dn75HZhI3+1GULx4W+LsgPot2f03F16X6GsWdG+pp0iOO2jK/I39jvmN8i1eGTUJXvSKEq
	VbUxkAlmLb0KFp7iSpLY6FLUMafsDHWdIwfOZ7kw78DN28zQzoHYRLO5TvI6SRYSqgLz9l5md5h
	FOvxHAvM5TGeZ/9j9JYrXTz1cSNd7BF1Sbblf1hADtq0sGHF6yRW3jw6BQ5hCWZcSn0lvHgKyl3
	BhjesWm+nwPiO/tvOaHLfs+qBjgrIscCb4EXttQPrh0sIcmj4EZEp9MN1nh2PAkEZHPvAfivPQD
	5Q+kGvq/Z7k72nFlKR6IIgcNG9t7CTS7QyVP1TXV7pHdfWnqHfwnVuSOpgYYS98ys=
X-Received: by 2002:a05:6808:5294:b0:468:776:1e9f with SMTP id 5614622812f47-4789d8482c9mr13232708b6e.22.1776351249376;
        Thu, 16 Apr 2026 07:54:09 -0700 (PDT)
Received: from Linux-Ub241.fyre.ibm.com ([170.225.223.17])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4268963d70esm4081906fac.9.2026.04.16.07.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:54:08 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: stable@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH 6.1.y] net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
Date: Thu, 16 Apr 2026 07:53:43 -0700
Message-ID: <20260416145343.904997-1-chelsyratnawat2001@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,kernel.org,davemloft.net,google.com,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238325-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chelsyratnawat2001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f3a497f02c389d86ef16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 4A46E410011
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
index 4cabb32a2ad9..857d9ea60d46 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -526,6 +526,8 @@ static inline unsigned char * tcf_get_base_ptr(struct sk_buff *skb, int layer)
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


