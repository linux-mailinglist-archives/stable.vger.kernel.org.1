Return-Path: <stable+bounces-237631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAnvFWU53Wk3awkAu9opvQ
	(envelope-from <stable+bounces-237631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:43:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E763F2326
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50DDE3010221
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4AE38F64E;
	Mon, 13 Apr 2026 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEvIjQ95"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333D388E71
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776105823; cv=none; b=Lh8wHV2W0tafobDJ1+XZu1tlKlB5ETqIgMGR0x/DBl6rTCniHu353Pve/3pFhLMGeL4k4ajYi28QC5TQJhiZ9RYqExQ2Zi2k/4qOHaWA8Y3JJIRpCjU2c7ZlJP+u2WttlVGncuadJIbOUWKUyvaBRpu7g+zeAqr2Nf+3KLUwS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776105823; c=relaxed/simple;
	bh=jwdcUNA2d70FnEkNepHRPW+EhyXibyW56hR2BjVE1O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQtqQqpvM5D34n8z1ZOWSnnTnzjtGzb1icHl2ZM9abFNqYkHVQL4XuIjxe1xnRignT3T62Idr72y/bna73YnD2PERWs9lPOvUaN3bhB7OrIW4F4Ra3AJ8z+4z509sd3naT/EwmpIYrAbjxy6E5dTTQ84YjdQNAoeglZc+7bq9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEvIjQ95; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dbc5ba0661so508140a34.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776105821; x=1776710621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UIVbLPcvPCrf1/gTRE4+B7+RumJKZrg4gpt1ORMIP1g=;
        b=EEvIjQ950M9Fvv3mkiBXgBnurGYNeImQdR7g2TgIhKDyKZG+6ysazttR8/IQ41dOjn
         VQo93SpQEErivCXQsTRc8vYh585vnTmwI2xI6t/Av/q9/ZWpF8OT+xzXysWRrbQ0V3hp
         e4VepS1/5GCUW/cKpJj0nsroTGtMgv6dYqNqTtL0PCNcQw/F+YqtXva0IwmCFnMi6yhS
         gTo4vPpJ96m4RHwvvzHFYbkZt+deAe8EYljTLamYqos9YQ76Qy0fb4qAlxhH6Nd68PXr
         c2OWn4M7F0r2NGIJKSVxbNq9LGN2rNzW1qdPy2MVEwmF1WrXs7h47sNjRPLnTPaD2CBr
         ybUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776105821; x=1776710621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIVbLPcvPCrf1/gTRE4+B7+RumJKZrg4gpt1ORMIP1g=;
        b=QoZACzppxeis2POMUEEIMBYu151sVepo4pjrdPwYnU1ILIiSYiaY06FmUd+YrptRSv
         BJOnrWJrdv4RO4/BkFCtwcYg8UIWwlnZTdBcPjENkW9la7nH3cs/7PvCq00yrzSZAVyX
         aeQmYMo3MFy3Sl0JCLlcBnSER2b0e35LUlCaGUjzIqWIkDQi4MR4+R6BPK0+CBhsGGE/
         QEtSU5/MWvUEGCL+Eoyx/rXkYfSID38q0DO8n4huOgZ4wcl488xHjnIcjSOwy7AiSNlp
         WCV31jeotgj325A+pCsU1Oz44ocpx71tLw2Nfx+kS83cMekDuc59impd5WyQrU5ODy+I
         8s0w==
X-Forwarded-Encrypted: i=1; AFNElJ9e87rotYlpV+yFN1L0/piazRPAcsYnq9MS1M4cLDJykppySYyDpF5yUsnwbF3rX+XUzFNQAgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1W58W9IVG81iCUZwlSjoAwF0lH9pVoPIfTUwRuvoKCOzvVqEy
	Vx4a3juHgLzz486IACUic3ABOcsvCyaGx/rNZYe7pQesLc/C2o+PV7qW
X-Gm-Gg: AeBDievWfuEWBzDNkAi983/xTdVHH405u8iG67Yjw41xXYcD+vWI8AVBc+WVDsONt6P
	CKueYayx1D4JltKD9gDSKRiTBZyjAr31TMcl8BnIsdfQ5+wZiy+yg524U12Y8O+EFRkI7Henrb1
	M5PDwDciviBtEHX/SVmieri+JTOQETK/P5K6nrafM2/OOmTYJXH6upr8xKz1EkgojgNgskfPhNU
	Irn5e8QQfpKQqppoREgszEepAkmTkTokDr3Q25O2uuTIHkOgm8wubMv7umJkYuG5BbpGW4MJAeh
	TYwapAyxsB7XQj18gk5iNmeBsuCJJGeb8SiE6PEhb7PLTR3n+eEvXB073f1icYIkBnVt9EJaOx1
	ZBv+am2wjfbEdJO1CAOBeWhaiD3GFD4jrMjR8LWMqmI3EY8uofeLH3nW0fzO1dUXuPwT+LscK6t
	vuPe8Hwy+zu5BRaRG/8OJ1FMGdxrTnoOAYoy0OGHvU+gYVkw/vWxQ0g9A6Nqdt5YLQ58QcFHIOE
	GoKqslBLeIAbXHCGoaX0hdj
X-Received: by 2002:a05:6830:3109:b0:7d7:ce07:5118 with SMTP id 46e09a7af769-7dc2800d06cmr6516696a34.7.1776105821313;
        Mon, 13 Apr 2026 11:43:41 -0700 (PDT)
Received: from localhost ([136.49.184.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc269fd1b3sm8958176a34.27.2026.04.13.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:43:40 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH] wifi: iwlwifi: mld: bail out from TX when firmware is dead
Date: Mon, 13 Apr 2026 13:43:37 -0500
Message-ID: <20260413184337.413259-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237631-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 57E763F2326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The drain loop in iwl_mld_tx_from_txq() keeps dequeuing and processing
packets while stop_full is not set and mac80211 has buffered frames.
When firmware crashes, STATUS_FW_ERROR may not be set before softirq TX
paths enter this loop. Each iteration performs expensive GSO segmentation
via iwl_tx_tso_segment() -> skb_gso_segment() while holding the netdev
TX queue spinlock (HARD_TX_LOCK from __dev_queue_xmit), blocking all
other CPUs attempting to transmit.

The existing backpressure mechanism (stop_full, set via iwl_txq_stop()
when the hardware ring crosses its high water mark) is insufficient:
iwl_trans_pcie_tx() silently absorbs frames into its overflow_q and
returns success even when the ring is full and firmware is not consuming
descriptors. This delays the stop_full signal long enough for the loop
to hold the TX lock for tens of seconds, triggering soft lockups across
multiple CPUs that cascade into SLUB freelist corruption during the
subsequent driver reprobe.

Add a test_bit(STATUS_FW_ERROR) check to the drain loop so that it
exits promptly when firmware is no longer alive.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---

Found while investigating a complete system freeze on a Lenovo ThinkPad
(Intel Core Ultra 7 155H, Intel Wi-Fi 7 BE200) running kernel 6.19.11.
The firmware LMAC crashed (NMI_INTERRUPT_UNKNOWN, both LMACs halted at
0xd0), the drain loop held HARD_TX_LOCK for 26+ seconds, 7 CPUs soft
locked, and the subsequent reprobe corrupted SLUB freelist pointers
(non-canonical address 0x54c991d5bf7e0cce in __kmalloc), killing Xorg,
systemd --user, and requiring a hard power off.

CachyOS/linux-cachyos#673 reports the same crash signature on BE200
with kernel 6.18+, confirming the pattern. The documented workaround
(ethtool -K <iface> tso off gso off) works because it eliminates the
per-packet skb_gso_segment() cost, allowing the ring to fill and
stop_full to trip before the watchdog fires.

 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index e3fb4fc4f..5e8a63e24 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -989,6 +989,8 @@ void iwl_mld_tx_from_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	rcu_read_lock();
 	do {
 		while (likely(!mld_txq->status.stop_full) &&
+		       !test_bit(STATUS_FW_ERROR,
+				 &mld->trans->status) &&
 		       (skb = ieee80211_tx_dequeue(mld->hw, txq)))
 			iwl_mld_tx_skb(mld, skb, txq);
 	} while (atomic_dec_return(&mld_txq->tx_request));
-- 
2.49.0

