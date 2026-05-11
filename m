Return-Path: <stable+bounces-245188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KhDG27NAWrajwEAu9opvQ
	(envelope-from <stable+bounces-245188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:37:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729EB50DFA8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CF08302AF73
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE91D36D500;
	Mon, 11 May 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL9jzRzz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E63BD63C
	for <stable@vger.kernel.org>; Mon, 11 May 2026 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502525; cv=none; b=tMMKLuFhb0Snc22JlKbi50tO+NsWqjXqVaRgt0vyz/sMIP5KCPwUgnkRuJj/xKqG3lnmebGsWYPptI3AajDwJh8c7BBncfLUk2ANsf3hj94fHZk5mULi2H7KJ23XJtpjXVW1trMLmfpQmn70RzcZwotuw3Iz9oSTvcBMH4l/wTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502525; c=relaxed/simple;
	bh=SeeSB1IfEtRAOx0xT2Mct1Puu1+aUoIW42tbiaU3wKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZsex2PVRtYL8S4WS7NvqbPFx1mxwy9UR8w/TaAK0OefIpTCrbwnFJ3MmDBLefM/WwQRjo+2PE1gYyT+wS+1lyXXvFuAukzHf7AbkFfsN9L7femjtCbDYtljRqEgNGrayLSQdOFSPaaj/lpmAacD8oRL9lAivE9Y+kyvk+klP/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TL9jzRzz; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d876329bbso40532691cf.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778502523; x=1779107323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1pv7l+pM5MjKJLGNcnMB8B8RIdHprHv2A1EneO2SZtQ=;
        b=TL9jzRzztr3NauRq82A3HJvS+D17vEo1vupAzMxICi9ZWpPPYjVoAkHt3/6f7nTARz
         ICaEJEosJ5LxE19rjXGq5pTw0hqjDpieOwVmZSPrIOj/5Bs+ZhTrIwgG3rMDzozreONw
         KiZCLZGiG8LBQI2ed0HbQ3WfhviWkSFHp/fiiFyOPJqWP0opDVZw/zrIrTV1r+97J7gY
         27RAHkjMhJN+NQHKrC6tRyt6T/vNZr5bAiUjobDfveAi18Z6U8YWvPzpUDCqem0rjoDg
         2iYFus5w9z2ta8/q2m6tPuDUq4K2Nc1Wozm3ijn9XTNFKKvZgUH9nyrh6rvwhmrf0Fp1
         2JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778502523; x=1779107323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pv7l+pM5MjKJLGNcnMB8B8RIdHprHv2A1EneO2SZtQ=;
        b=jsc9wdo44gXGNZ8LEYVy/ZSRoJHTJAIRlrf9EBLoPMTstx14BDL0KfezItJR0oqNxB
         lGwTbgHegMFFwz6At2ztIjH3TKdgUaNM52a+N+F4D3ctKzXoRGSN3Boa7LHxHC46vNAo
         do6v+5QXOBI/AB2oA6/sZFYoFmW154AUUitdw/c1hWgK5WAvoHoQWPUhooEs+TfMKx05
         asHXMkEj1J92phmwsAYA7D+ZVH7jQx2eINDKp5V5RtFBsjixGkUFXT60uJwGedt59RwX
         iLOkrd4GkJ39HeIVha7EiD/a/hOYmNMn0g2HVZBFyU+LtFGjxIA4d2j5fh1KJ9guJWPV
         22GA==
X-Forwarded-Encrypted: i=1; AFNElJ9BTLV4Xd4MbBK6wXrHGseo+BSsRLOyVQ5xq43nwDSqpU6AVfEo0FpQBxemJMDhs5Dj/4KuFGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zJW9MK3g7+jZcHU8Eif9twmXRipe9dWfCdP7hr5PUynTvi3B
	XQvaE37if9yv7cVpxrt+xZnTdeMh+kngoCbS6B98AfOv+SwjB4NktuUKBviUArjg
X-Gm-Gg: Acq92OHomjfXtQaRrcV9dkkdpgHH55KJyqcs5BlJsCeoN9fooBBWTWhH1dXI6IMzYOM
	cmhlTnfWWn2bB6e0Fi4JW8AhBJCs5EBZ6u+Ku19LzzJCP4RrOJa1ikTtrdzbnWt1sBxL7dQIFUT
	0CoEOuZw2c9REK2J0nZThhYubychZGkudXCoS4KGcmg0qHH8Op5QMwNZiUZwFYtrU5EEm6YIIjW
	NUoKliWPc3UYQ6SiAAlRqU9aI5yL5KKByFi8TgvnrJbBFdpMMYrnxGgFyB5ASSnQGD2QzqzTCAK
	PkAu9T4IazMb2YycV7KfWTEqfJGs1L2s6QLPRmcoaVn+SnKoQx1kWxRUdMyGo5F/me0elZZd7+u
	ridI1Jhe1V4mb7w0am81eTMYSXR2a0y4RRptVx2FFP8BQL8CeSZOL8VTiP0LEqHnS8MCWZP2S5k
	LphxdvBFw/sweLqBUJbasQAPa38aTOmBAUMYXmQ6jVZ9sQ5a/d2Nieba7ODH/LApRmQ0lUOFzZg
	faTP/CB3Qge2eWQQWg1pj/g431qscWA8VOd2vaZCRjz10J/y8oBUw==
X-Received: by 2002:a05:622a:59c6:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-51461c05354mr354580721cf.14.1778502523153;
        Mon, 11 May 2026 05:28:43 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-514cbca4b3dsm1279071cf.31.2026.05.11.05.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:28:42 -0700 (PDT)
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
Subject: [PATCH net] net: ifb: clamp ethtool stats loops to num_tx_queues
Date: Mon, 11 May 2026 08:28:35 -0400
Message-ID: <20260511122835.441911-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 729EB50DFA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245188-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ifb_dev_init() allocates dp->tx_private to dev->num_tx_queues entries
via kzalloc_objs(*txp, dev->num_tx_queues), but ifb_get_ethtool_stats()
walks the array up to dev->real_num_rx_queues and reads each slot's
rx_stats. When userspace creates an ifb device with asymmetric queue
counts where the rx count exceeds the tx count, e.g.

    ip link add name ifb10 numtxqueues 1 numrxqueues 8 type ifb
    ethtool -S ifb10

every iteration past dev->num_tx_queues reads (real_num_rx_queues -
num_tx_queues) * sizeof(struct ifb_q_private) bytes past the end of
the allocation. Because struct ifb_q_private is
____cacheline_aligned_in_smp (about 256 bytes on x86_64), an attacker
can sample 14 u64 values from a roughly 1.5 KB out-of-bounds window
with a 1+8 device. The sampled bytes are copied to userspace through
the ETHTOOL_GSTATS
ioctl, which sits in the privilege-exempt arm of ethtool_ioctl() so
any user with netns visibility to the ifb device can trigger it.

The TX stats loop is currently safe by construction
(netif_set_real_num_tx_queues() rejects txq > num_tx_queues), but
apply the same clamp to both loops so the contract is symmetric and
robust against future churn around real_num_tx_queues semantics.

Zero-pad the per-queue stats slots that no longer have a backing
ifb_q_private so the output buffer length still matches
ifb_get_sset_count() (which uses real_num_{rx,tx}_queues unmodified).

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

  The buggy address belongs to the object at 0000000062dbd000
   which belongs to the cache kmalloc-512 of size 512
  The buggy address is located 232 bytes to the right of
   allocated 320-byte region [0000000062dbd000, 0000000062dbd140)

With the patch applied, the same UML+KASAN repro is silent and the
ethtool -S output reports zero stats for the out-of-range rx slots.

Fixes: a21ee5b2fcb8 ("net: ifb: support ethtools stats")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/net/ifb.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 5407d2ed71b3..66323de24ba9 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -255,21 +255,38 @@ static void ifb_fill_stats_data(u64 **data,
 	*data += IFB_Q_STATS_LEN;
 }
 
+static void ifb_fill_empty_stats_data(u64 **data)
+{
+	memset(*data, 0, IFB_Q_STATS_LEN * sizeof(**data));
+	*data += IFB_Q_STATS_LEN;
+}
+
 static void ifb_get_ethtool_stats(struct net_device *dev,
 				  struct ethtool_stats *stats, u64 *data)
 {
 	struct ifb_dev_private *dp = netdev_priv(dev);
 	struct ifb_q_private *txp;
+	unsigned int n_queues = dev->num_tx_queues;
 	int i;
 
 	for (i = 0; i < dev->real_num_rx_queues; i++) {
-		txp = dp->tx_private + i;
-		ifb_fill_stats_data(&data, &txp->rx_stats);
+		if (i >= n_queues) {
+			ifb_fill_empty_stats_data(&data);
+			continue;
+		}
+
+		txp = dp->tx_private + i;
+		ifb_fill_stats_data(&data, &txp->rx_stats);
 	}
 
 	for (i = 0; i < dev->real_num_tx_queues; i++) {
-		txp = dp->tx_private + i;
-		ifb_fill_stats_data(&data, &txp->tx_stats);
+		if (i >= n_queues) {
+			ifb_fill_empty_stats_data(&data);
+			continue;
+		}
+
+		txp = dp->tx_private + i;
+		ifb_fill_stats_data(&data, &txp->tx_stats);
 	}
 }
 
-- 
2.53.0

