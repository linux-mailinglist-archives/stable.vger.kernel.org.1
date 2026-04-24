Return-Path: <stable+bounces-240659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id seYMGdhs62lwMwAAu9opvQ
	(envelope-from <stable+bounces-240659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:15:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C7645EE14
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F7F830028D1
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C52E3D5251;
	Fri, 24 Apr 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoZ1RMko"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52EA29D267
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036486; cv=none; b=NPtA534oN+8r7InA+tHx1fIf2YI6gKQ0zgk3wHW8XYrZqNBW0rv9trE2Z9CQC+8PRfOxDdEZBH7U+kh8UGrzSjzRiS/ohByIntOsTeg8xKDzaM4G42E9lSeLxuLLXdTcPlvrk6g8PDYE4Wrd1MtddRbErxpdpdJTtkJNkuIkY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036486; c=relaxed/simple;
	bh=dyavU3qXI2tJ3+ju0VcHYmrHuUmrqrQ9qdsQmT3swxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NN4v1OHxAzj3kndxlsK3u5TtgzpIUJfj5eHOXJOWn07sn4fvT5L/931vekYeM0rgcekT4SbajMvfOCjxdPRIsb0y6wzD2yv8FpJkudxsaOZbzoRTOOa9HxgfIn4PCOpIY2dFIdFF4pZKWp/vXiH+V45Xa4B3ZENKxD58ZjXyua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoZ1RMko; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c795f096fa5so3133209a12.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777036485; x=1777641285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFdJIR9/b2UzOLN3bbr2cSRO1rNz516MTroGF1ZNF3I=;
        b=eoZ1RMko1lJucL7RZYAaGNBP8i9OsfJ2HULrGLjuN3A/M2ybRjw6av3+pbKJKaJM1M
         rx5n98PRhR3X9vcarXO00YmB0gfqAFdrob7YECoQLem2zsnn/m9d4Yu4zNprjvAWpUl1
         2G8uc8LLDJoTbx9+t9/SPoysav1Y0U4KEWG2OvP2e+qqTJxifpufe4UWvOB9IaISA7tk
         L3+bXqcxSjnP0TFYT+iKnTdr6aWRJmAdRGSzffbSkVNC2LX+P2wtUBryVJE9fIWV06DW
         O2kNoN6bnw1neDJFo4tXw2CUj32Ngua8ntaSY4YOvTrRaWaXeGdcL1kj2ai93Rc+mWup
         y8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777036485; x=1777641285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFdJIR9/b2UzOLN3bbr2cSRO1rNz516MTroGF1ZNF3I=;
        b=nNMYJJUMA+ovJitGqqjmFP4bdzKvhZ3D3l4pqzVleqgDCN17hf87A5VgA1pxbR1zrD
         j1F6+6XtkZoLovERcgwdHuHWd3mQxGJ3ShRFLNt69VIAqwc0vy+Mb6OU3ZdwCO7TqY/y
         6xWfB0RaeESe96vHp7hvfnEc+j5AJ2Vk7w9oeGuf1+3Aie5Lu5RGvYz7oBoe3Q8t7O+o
         zhvVV3qxdqOK8iomaEEW1//UVFKS9FKOyAiCz4gMp/xwJ5ZxshEhy6HLQMAOKcCQ9ZK2
         Lq8c6WjXgnFA1Jqb9BFIBhq+2xJBCBxKFy9YNPc01wvRsxW5duXs9FJ/uAnJfeYCkSQy
         opQw==
X-Forwarded-Encrypted: i=1; AFNElJ8US5e0oVKKitCilvNNB1EkSJIw0Pe24YV1OrkysW71XC66W7DNf6BevaJETJu/1LVBAuY2j/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMYiU0MzQBIID2djF72A4aO+NzuT6HrM4xjoOgbKa8/krMpOo
	ImDZbLjzh3Lm6Gep8HO9YukWK37k/TvTF+mBZwUjZQq4edv/p7GdLjq7
X-Gm-Gg: AeBDietWNoDUxoHQrtvQ3PpUww/Meo0tJfHtiQ/de9M8+W4W9FJh6wDe0fLbhhxYgnk
	UkhypC28EPBpI9CLgw+BVcUZhK4GW1zqzbTt2q4fIp2fMLLXGmH1UwlYsQ2XNg75x506TC768iY
	yWSKMhU/gzVccRckEgowwKlNmG7VtMnC1rfxnzZdUtuEfQZcf2/7eUQlBAqVvjcCo6XTDGYw9yh
	4Q+f7W9DBxIVkunGa+DuoWso1VcnOu5qWXcmj45OSYnHtOfYbkHJtTjFFTvXGFfppHNC+qL3SWP
	Lmc008evjG7SS9h5b83LZDzmCwe5cCKXmiY1nzhQMdaA46G4Bmyrkl9MAXLwWdle7h9ydh3EA8Z
	ro58zk3r4BHhiz1h+GTnaczJZh3HLPU8pK6NmZrIHyLO2Tq3FnPFg7iqX12NiA76eCZExfkXfjH
	DcN2cmN/UtK1JF25EB/eIKrE3GpDHtXJTzqhKmnHKq4y/BPuwLvyMjDyrplBYTdSsM0vOlFfq2r
	d4SH78BPg==
X-Received: by 2002:a05:6a20:2583:b0:39b:98e3:6a11 with SMTP id adf61e73a8af0-3a08d8faa9amr37311860637.50.1777036485068;
        Fri, 24 Apr 2026 06:14:45 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9cacasm20324116a12.8.2026.04.24.06.14.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 06:14:44 -0700 (PDT)
From: Catherine <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Catherine <enderaoelyther@gmail.com>
Subject: [PATCH] wifi: mac80211: drop stray 'static' from fast-RX rx_result
Date: Fri, 24 Apr 2026 21:14:36 +0800
Message-ID: <20260424131435.83212-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76C7645EE14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-240659-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

ieee80211_invoke_fast_rx() is documented as safe for parallel RX, but
its per-invocation rx_result is declared static. Concurrent callers then
share one instance and can overwrite each other's result between
ieee80211_rx_mesh_data() and the switch on res.

That can make a packet that was queued or consumed by
ieee80211_rx_mesh_data() fall through into ieee80211_rx_8023(), or make
a packet that should continue return as queued.

Make res an automatic variable so each invocation keeps its own result.

Fixes: 3468e1e0c639 ("wifi: mac80211: add mesh fast-rx support")
Cc: stable@vger.kernel.org
Signed-off-by: Catherine <enderaoelyther@gmail.com>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3e5d1c47a..8719db8f3 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4971,7 +4971,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-	static ieee80211_rx_result res;
+	ieee80211_rx_result res;
 	int orig_len = skb->len;
 	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
 	int snap_offs = hdrlen;
-- 
2.50.1 (Apple Git-155)


