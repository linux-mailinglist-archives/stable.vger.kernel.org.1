Return-Path: <stable+bounces-231289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DEPGHT1ymmlBwYAu9opvQ
	(envelope-from <stable+bounces-231289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:13:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF672361C66
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB9FE3010B9E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7223A75B9;
	Mon, 30 Mar 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMN/ajqG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E7C37FF55
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774908619; cv=none; b=b0MQve3P6zXQZlhujtHKs6snGsAP0Vqzd9UFqOUJEmFGlfTEodhBQUWSWtJLJynfm/wcKPNl6foTORpfFmDmH1K7RJ0LpVh6lImwsydZfFFEeJaKI+z685IHbK7w+S9PpwwOEfPGyaQ+xusmK/+5HkhtJRLOkCVCzZS2AdJklLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774908619; c=relaxed/simple;
	bh=FDBfk2gTLu1bF0rsxtRP8sgWzUpvU/oWz/qYiDUySTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEDj+ATeBiSQaIt8SxsuoX6H9RuLttgeg1/zLH3BYqDXXAlwJavVJVta2ntHjYNgpyyPV/9QPlDOcCWVicRhps7K1fRRJ8QJksPMWH2s5Lyw2mLI8XJCtuLcM2awE66Y8LpqXpHzwE8BS/Ljue6WRC8RghDJlVJeSbbOpRm0bTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMN/ajqG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfbbf35354so706757485a.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774908617; x=1775513417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvvCrpWMzIENV2FZlq4KX5Fhj0gALiIkbUI42JoqXcU=;
        b=dMN/ajqGZgDB0BeeTodBZ3BYWpk0wyvyv5Bms5HCIIhrJGl9Lt622sRaTO0UwgBu2X
         x8XtnbqCnehgFY+hOxzbBHdx9UJETg/ocYpvKZwFC98D4fsSSeotzKqgB4v9Xaki3tmP
         BUqHweologJtWuWwl6B9y/9iWNiY8H1qtuZFI/Dsw5EPfS3L6yS5rFWgkUkaoQjomGYk
         WiftKPRIxxT5d+tMzv9CBBTcJ5HQHPnElIpLGlGMOtD+phaI6SjZ0CNT7l5AijGGIsw6
         AhJg3EUX66IWybd4dAKOI/7rSfEqCWygk2hbgmj+veshKiwzOtGn7vwlrVw9h8r/nZ+I
         B7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774908617; x=1775513417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvvCrpWMzIENV2FZlq4KX5Fhj0gALiIkbUI42JoqXcU=;
        b=QOZERDfremL/Q6o8U8Ugc/WjjMZon70+e4ELxL7GZn4dJ2WoVGW+6+yop8mfPwyasz
         ayk8jDIj8VxCeZzb06FoNWUWiwvKs+LpBA50EwoZHFkh8Se7XVzXiIeu9i88pYdSBVbs
         1ip5VCc63e8fCvqrNfmC5tUzYUed62e6lDII7ZeLX/Pj3Ed+R7+YeVh115Q1B4hi/32z
         gGNNoa4loTMMw8Z3x81xH9dMVcKS6WKlxwucVBoC1HGMRc5mNpMn2LHyOU+23Za8ewki
         0VDJBQxhLVxmq/FQ5ZT/6HOhAAlNbqC80PvVdA+kJsEOqkRxQiMf7DIwbR0DzmU7zSuO
         LReA==
X-Forwarded-Encrypted: i=1; AJvYcCW1gwRdq1wUjy3GNCzTluZnT5XCtDvfCi/A7TAXaknRlCNqYVpbsR/+NENBWk4cdfFrgmzteKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6FhqrojBxtCEVYtulxRw5JyAgDVTwPbYZ96rzJIpdkUOZ33m
	Y+9dF0Zn47OOf77Y9iCtxJjaZz4/bgxAOseUIEqYqTdct3bW/sNAT7Kr
X-Gm-Gg: ATEYQzyfkLejOkY6ptMFZeQUnggczdowC02CF88/eToVChZYIOi7duvfWWblnKeChtZ
	b6sPwMRWTvsSISOCUcgYvsdFwzNDBWoQBWAxG4WjVfFFwc7/rgJsb7K1v5v+/QyoKfCMhAx0iWi
	OSVdhb+DTkpkBQ6xpl1SieX60k4fUO2xJYUBgmr2ewuuLCFMqsZTMophXg85g1G9GGZJqrkga9s
	PuRigrSeblTPJk93n+OIg3VfNgFx9Hyx38tvUwZHN4sokKfmkoIjq6qjyS5XvnHti7xc9JsVz0X
	0UlxMnX1FYLTUFAVePb6uZnnR1MGHehPAzV5/6snQf885FkHj3sue7kpOKo2P4xn/0Xv8fvSNaR
	H7hIgRPoyTIQL5BaqssW5SjsJ+wZ0uzZYEki0zw3HmLKRrhADvSGAjR4/+K15RYyM2G+IXGn8Yi
	1kkXaCPdlAPNpaYgNVDt7sWlIakda6+Q809q+7AtALDxSuLIbnP1qOprzrLBHKo1X23YJ2n3AVZ
	/lDQitsIMPUDr4lWcuvdA==
X-Received: by 2002:a05:620a:4547:b0:8c6:a8a6:e164 with SMTP id af79cd13be357-8d01c796d8emr1904826285a.45.1774908617261;
        Mon, 30 Mar 2026 15:10:17 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028095f1csm819343585a.47.2026.03.30.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:10:16 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	kyungtae.kim@dartmouth.edu,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH v3] Bluetooth: ISO: fix NULL deref in iso_recv() ISO_END handling
Date: Mon, 30 Mar 2026 18:10:15 -0400
Message-ID: <20260330221015.322337-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
References: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,vger.kernel.org,dartmouth.edu];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231289-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF672361C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ISO_CONT case in iso_recv() properly checks for unexpected
continuation frames and oversized fragments before accessing
conn->rx_skb. The ISO_END case lacks both checks.

When an ISO_END packet arrives without a preceding ISO_START:
  - conn->rx_skb is NULL (never allocated)
  - skb_put(conn->rx_skb, ...) dereferences NULL -> kernel crash

When an ISO_END fragment length does not exactly match the
remaining expected length:
  - the reassembly is malformed and must be rejected

KASAN confirmed the NULL-deref on kernel 7.0.0-rc5 via VHCI:

  general protection fault, probably for non-canonical address 0xdffffc0000000018
  KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
  CPU: 0 UID: 0 PID: 72 Comm: kworker/u9:0 Not tainted 7.0.0-rc5
  Workqueue: hci0 hci_rx_work
  RIP: 0010:skb_put+0x27/0x1a0
  Call Trace:
   <TASK>
   iso_recv+0x5e0/0xee0
   hci_rx_work+0x226/0x730
   process_one_work+0x633/0x1060
   worker_thread+0x45b/0xd10
   kthread+0x2c6/0x3b0
   ret_from_fork+0x38d/0x5c0
   </TASK>
  Kernel panic - not syncing: Fatal exception

Fix by adding validation to the ISO_END case: reject end frames
when no rx_skb reassembly buffer exists, and reject end fragments
whose length does not exactly complete the expected reassembly.

Fixes: ccf74f2390d6 ("Bluetooth: Add ISO Socket")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
Changes in v3:
  - Check !conn->rx_skb instead of !conn->rx_len to correctly
    handle the case where an ISO_CONT fragment completes rx_len
    but a valid zero-length ISO_END still follows.

Changes in v2:
  - Tighten end fragment check from (skb->len > conn->rx_len) to
    (skb->len != conn->rx_len): the end fragment must exactly
    complete the reassembly.

 net/bluetooth/iso.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e273..7c57b1d22 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2587,6 +2587,20 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		if (!conn->rx_skb) {
+			BT_ERR("Unexpected end frame (len %d)", skb->len);
+			goto drop;
+		}
+
+		if (skb->len != conn->rx_len) {
+			BT_ERR("End fragment length mismatch (len %d, expected %d)",
+			       skb->len, conn->rx_len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.43.0


