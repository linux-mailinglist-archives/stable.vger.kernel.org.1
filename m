Return-Path: <stable+bounces-219794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBapH1E0oGnyggQAu9opvQ
	(envelope-from <stable+bounces-219794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:53:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD1E1A561D
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D69AA3074D06
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A28237A483;
	Thu, 26 Feb 2026 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="kvcAudrX"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62737BE61
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106509; cv=none; b=Ouq7XleC94G7xB9uaQSWQkM2TlugoyputBXaxmD+ZNQajkdV8S5CUsQhm8lD5bEpz/GGFYoMc0rAjN/JMGkCjz9xPHjGQ96Ec4MAhP9tRLUEcEwZRw/0aXkLKVYVI/qrWoCFZxYmDlYzWFEWrLGGDkIxO2EAnMrLVO9hdr5duZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106509; c=relaxed/simple;
	bh=WYtlVM205K3QU9DIjhiwkxIqYc0xfMMqqjDtoW/PYa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BA6tWei5uDFs1FFpiBToAnvA9toP4lf0c+BgVtVBSiOKrjISJ/QuiAn2NoTfD6cs24FCaeeIkXYwILDxRGZ69OTBp8zScscouoM6130kyYXaEkagXOtVSDBCyVQrdlpaq/gCID1gp8JkZZA5sw4fEYrJgMCBb+XLZMJQpU5x+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=kvcAudrX; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=kvcAudrXfMzIRESlV2TZf0Du3SQPmfCD/n/EWm1OpFYfeaPP9B1TviUU17j1qi+pO6m1IjImqQKlZ
	 BstQ96wryCWiW7a42a0XlSyKa3aBd7Vcm7VK9y561m/D6YByFbekbIxO6l3qtFwtpBGp6IoZwuepML
	 LIKoKdCDh3M4kvGs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[120.244.194.215])
	by rmsmtp-lg-appmail-04-12082 (RichMail) with SMTP id 2f3269a032ff8ac-1801f;
	Thu, 26 Feb 2026 19:48:23 +0800 (CST)
X-RM-TRANSID:2f3269a032ff8ac-1801f
From: Bin Lan <lanbincn@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	GangMin Kim <km.kim1503@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 5.15.y 2/2] net/sched: cls_u32: use skb_header_pointer_careful()
Date: Thu, 26 Feb 2026 19:48:10 +0800
Message-ID: <20260226114810.4142-2-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226114810.4142-1-lanbincn@139.com>
References: <20260226114810.4142-1-lanbincn@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[139.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[google.com,gmail.com,kernel.org,139.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-219794-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[139.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.831];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CD1E1A561D
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cabd1a976375780dabab888784e356f574bbaed8 ]

skb_header_pointer() does not fully validate negative @offset values.

Use skb_header_pointer_careful() instead.

GangMin Kim provided a report and a repro fooling u32_classify():

BUG: KASAN: slab-out-of-bounds in u32_classify+0x1180/0x11b0
net/sched/cls_u32.c:221

Fixes: fbc2e7d9cf49 ("cls_u32: use skb_header_pointer() to dereference data safely")
Reported-by: GangMin Kim <km.kim1503@gmail.com>
Closes: https://lore.kernel.org/netdev/CANn89iJkyUZ=mAzLzC4GdcAgLuPnUoivdLaOs6B9rq5_erj76w@mail.gmail.com/T/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260128141539.3404400-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 net/sched/cls_u32.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 440c29dc058e..23f9e2b5f3b6 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -149,10 +149,8 @@ static int u32_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 			int toff = off + key->off + (off2 & key->offmask);
 			__be32 *data, hdata;
 
-			if (skb_headroom(skb) + toff > INT_MAX)
-				goto out;
-
-			data = skb_header_pointer(skb, toff, 4, &hdata);
+			data = skb_header_pointer_careful(skb, toff, 4,
+							  &hdata);
 			if (!data)
 				goto out;
 			if ((*data ^ key->val) & key->mask) {
@@ -202,8 +200,9 @@ static int u32_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 		if (ht->divisor) {
 			__be32 *data, hdata;
 
-			data = skb_header_pointer(skb, off + n->sel.hoff, 4,
-						  &hdata);
+			data = skb_header_pointer_careful(skb,
+							  off + n->sel.hoff,
+							  4, &hdata);
 			if (!data)
 				goto out;
 			sel = ht->divisor & u32_hash_fold(*data, &n->sel,
@@ -217,7 +216,7 @@ static int u32_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 			if (n->sel.flags & TC_U32_VAROFFSET) {
 				__be16 *data, hdata;
 
-				data = skb_header_pointer(skb,
+				data = skb_header_pointer_careful(skb,
 							  off + n->sel.offoff,
 							  2, &hdata);
 				if (!data)
-- 
2.43.0



