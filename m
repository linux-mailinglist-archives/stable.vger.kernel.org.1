Return-Path: <stable+bounces-247082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FTIBfYnBWoYTAIAu9opvQ
	(envelope-from <stable+bounces-247082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:40:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F27C53CC7E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96B37307EAFA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CDC3203A0;
	Thu, 14 May 2026 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="divpf8Sq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181F31F985
	for <stable@vger.kernel.org>; Thu, 14 May 2026 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722668; cv=none; b=WFzfLhvRfe+86ECmmqUBu6Pl0MlkkET+vcpGh9AeqO/qqPZj1DUajf3ykynhD7yReYhUpAZdnWC1+cCgGCGVy8MbMe5c9OZlfCpiGPTvsAN3sCRQcZxhaMJkUTWzT4lkmco7e37X6vkMAWPjLc9kNrgCMGSLPIjN1eIeYAbtPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722668; c=relaxed/simple;
	bh=zdhzlq+hCZGUwKs1WDO4+HiklAD/YGebTHiQm1EUhKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqBBpf69q1JbBw3jbR3+IQvhv6Ihld1LrGAnPrgCl/VxNKZtZhLCcjHeE5RFMPicQe4fIozt0AEyaKFFH4gr3sk17eNwZ+NmHC/77oLdvg0YkU3UkTkFkZEPNHcHgkfXLN/0iBUte7V2dV0ubWM3//CHMCENQsLLmOTnZb1NrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=divpf8Sq; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50faf8ed9c5so39740091cf.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 18:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778722665; x=1779327465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WvnHZLXtklaLX2hJogKEOeSBdsibxvGmpqRAV5GTCjQ=;
        b=divpf8SqnDewP+6fLSuJk81bagaqe21aAIg3zMyFpvUVY+0Z8O21Xr4h9hPx6syLAK
         vKWxKvyBjL25uN60en/S5lnRdi1xWLMlYrUJwD/Jft21SQgpfYxnsG7+aka1KAP81aY7
         YLA1Ji/KhBsZgwZr7kOKcdJ+/6zm4rgKD8SxchNuYjf/dAAK4h6nVC4FyqaqGOqoGeM/
         hPoX2vm6PKVONaqZCYW2hiudEp1uDWvll9xELcvgvia+33Qz2ENVivoDY0M3bdjVmMML
         2LiSW/TMOilSnW/od9mpPFQ/ryS4IWLY8Rm5TxNkNGSEn5di9O100K0BGahETXQP/rj9
         rKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778722665; x=1779327465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvnHZLXtklaLX2hJogKEOeSBdsibxvGmpqRAV5GTCjQ=;
        b=YEmgU00QbpuPkxtIts1hPzds/E+tclrwDqnRdTFjIRJivyYW1DprXXWNzePqukGd3+
         MV9wESZ7T7qDR2620jJboLAxESjp0h/XoW7/qmeclXRrj1ff4H16KReb1vIPv0YP2Bhv
         qgAMcTMHNqIgHkh0vZ2GldoLg7OzXLiQw8LMPjLUBu7y3w/nyzDzhThJeeP9LK+UDM+i
         +7wej1rfQK5VOBHx4JQy58cIIPVqyuJ7mxHy7h2Ug8fHxbTnQIp6vvROg7eVgPl+GrIF
         J/R8DV/msQfvbFdUNyAc61IlmI4lauy9/ZalWWsWfEN8OkqLMYLHchC2y9PEBsLyly7J
         jESQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QgFAOjR1AdPjsSKHAmE9yVmLW08iO2WiUNJqN+YWkziuJgDjRgkh1LyCd0Cpl3+jAxCr8CV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZ5I7xdaDgwC1H5oP1BFbnGzwaStFut5vfYgvccb2DtfUpx6u
	fIU/Qeth546Aj73PDmpudn6+DgBh8H6GrSjKNgXZBCZuS+n+yPjHtLz1hmy8XgFA
X-Gm-Gg: Acq92OGyB1WVTh2ETMY1JvTQ+tqeBjejbPp62vKRkFFm6Gy0/kEXkSH/mnUy4E9Tg38
	Sv7NeHuEl5wxj54tcHv1C1qtTVtLiygubJzoGQdY5YDfXaYwfNO5JsovrclcxD1ip7OhE2eGsxq
	AGpQWQMaXihhBo80h5aKxHkfqO941ljTTJb7CpuBmRhIrg7yHhYvsX67z12DcqRdBJcjuGBCy1y
	Htf51DE/8uhGOovlEL5+CMBK+WjpupZ6TOrl6CCn2rCMSEAfK+CCj4/0PAjuAbZh1mzAYxB3+nB
	/SvgIPJVQ6LEPN//A4KTticfu81Ht7rw05SsDmfJR+ptup40h8xtsCldybLl5KOdJpVMnQWcFvg
	3DFNP+CfxBnh7juo6kAqtt4aHRlDViic0/XKJxRXjm5+9HffaIVyhpGCf6Zn/pE+LHKkRa7fExr
	yZJJmbsnGzrML7V5bXJ2pcISI4JsAxUi+f28TKsVs7Mv0iVoTyQSdZQO5TjczPN70tHXGJ5XeWI
	5AjbvcNXpGLMdYQHApKP51YiAKM9f99rL3Ggc3QjbI=
X-Received: by 2002:a05:622a:54:b0:50e:423e:2870 with SMTP id d75a77b69052e-5162ffc219fmr77402941cf.52.1778722664782;
        Wed, 13 May 2026 18:37:44 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164581f1eesm4468071cf.25.2026.05.13.18.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 18:37:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Tonghao Zhang <xiangxia.m.yue@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: ifb: report ethtool stats over num_tx_queues
Date: Wed, 13 May 2026 21:37:39 -0400
Message-ID: <20260514013739.3549624-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6F27C53CC7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247082-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ifb_dev_init() allocates dp->tx_private to dev->num_tx_queues
entries via kzalloc_objs(*txp, dev->num_tx_queues). Both IFB
per-queue RX and TX stats live in those entries: ifb_xmit() updates
txp->rx_stats using the skb queue mapping, ifb_ri_tasklet() updates
txp->tx_stats, and ifb_stats64() aggregates both over
dev->num_tx_queues.

The ethtool stats callbacks instead size and walk the per-queue
stats with dev->real_num_rx_queues and dev->real_num_tx_queues. With
an asymmetric device where the RX queue count exceeds the TX queue
count, for example:

    ip link add name ifb10 numtxqueues 1 numrxqueues 8 type ifb
    ethtool -S ifb10

ifb_get_ethtool_stats() indexes past the tx_private allocation and
copies adjacent slab data through ETHTOOL_GSTATS.

Use dev->num_tx_queues consistently for the stats strings, the
stats count, and the stats data walks. This reports one RX stats
group and one TX stats group for each backing ifb_q_private entry,
which is the queue set IFB can actually populate.

Reproduced under UML+KASAN at v7.1-rc2:

  BUG: KASAN: slab-out-of-bounds in ifb_fill_stats_data+0x3c/0xae
  Read of size 8 at addr 0000000062dbd228 by task ethtool/36
  ifb_fill_stats_data+0x3c/0xae
  ifb_get_ethtool_stats+0xc0/0x129
  __dev_ethtool+0x1ca5/0x363c
  dev_ethtool+0x123/0x1b3
  dev_ioctl+0x56c/0x744
  sock_do_ioctl+0x15f/0x1b2
  sock_ioctl+0x4d5/0x50a
  sys_ioctl+0xd8b/0xde9

With the patch applied, the same UML+KASAN repro is silent and
ethtool -S ifb10 reports only the stats backed by the single
allocated tx_private entry.

Fixes: a21ee5b2fcb8 ("net: ifb: support ethtools stats")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Follow Jakub's review: IFB has no RX-only queue stats independent
  of tx_private, so dump both RX and TX ethtool stats over
  dev->num_tx_queues.
- Update get_strings() and get_sset_count() to use the same queue
  bound as get_ethtool_stats().
- Drop the v1 zero-padding helper and report only the stats slots that
  have a backing ifb_q_private entry.

v1: https://lore.kernel.org/netdev/20260511122835.441911-1-michael.bommarito@gmail.com/

 drivers/net/ifb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 5407d2ed71b3..43aa1bfd41cf 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -211,12 +211,12 @@ static void ifb_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < dev->real_num_rx_queues; i++)
+		for (i = 0; i < dev->num_tx_queues; i++)
 			for (j = 0; j < IFB_Q_STATS_LEN; j++)
 				ethtool_sprintf(&p, "rx_queue_%u_%.18s",
 						i, ifb_q_stats_desc[j].desc);
 
-		for (i = 0; i < dev->real_num_tx_queues; i++)
+		for (i = 0; i < dev->num_tx_queues; i++)
 			for (j = 0; j < IFB_Q_STATS_LEN; j++)
 				ethtool_sprintf(&p, "tx_queue_%u_%.18s",
 						i, ifb_q_stats_desc[j].desc);
@@ -229,8 +229,7 @@ static int ifb_get_sset_count(struct net_device *dev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
-		return IFB_Q_STATS_LEN * (dev->real_num_rx_queues +
-					  dev->real_num_tx_queues);
+		return IFB_Q_STATS_LEN * dev->num_tx_queues * 2;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -262,12 +261,12 @@ static void ifb_get_ethtool_stats(struct net_device *dev,
 	struct ifb_q_private *txp;
 	int i;
 
-	for (i = 0; i < dev->real_num_rx_queues; i++) {
+	for (i = 0; i < dev->num_tx_queues; i++) {
 		txp = dp->tx_private + i;
 		ifb_fill_stats_data(&data, &txp->rx_stats);
 	}
 
-	for (i = 0; i < dev->real_num_tx_queues; i++) {
+	for (i = 0; i < dev->num_tx_queues; i++) {
 		txp = dp->tx_private + i;
 		ifb_fill_stats_data(&data, &txp->tx_stats);
 	}
-- 
2.53.0

