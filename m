Return-Path: <stable+bounces-233492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK0bJrSY1GmkvgcAu9opvQ
	(envelope-from <stable+bounces-233492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:40:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 052353AA037
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5283C305E9DC
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E04C246BBA;
	Tue,  7 Apr 2026 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDDfLNVt"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F63123D2A1
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540351; cv=none; b=kSmMrZp5k/GNUXoJ4UH/zVk+kWKmqN+iFxuJrpiY7fwaaQNiRvN+3zogF76l186z/BY1Gw5X9ENmWDMCYW1ipXCw6hZWRSXGjc8DDTGf/gw2UbaL1fw1wQR19kC+E+uDC0pcF5yXwfNvYMzGPdn7fDzHGPui6jsASOF1Myrwz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540351; c=relaxed/simple;
	bh=uoCTypa9PxCD3+/Y3yVtl2HrvV2hrgDNN8Do9TgBeyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poPImD3dBeKBgpF1gp9Fv84NtX60Ip3w91eBh2WBbX5NTHJ5MfsNgDqhzRN7aTIxqplg3Nie8NakHYs7Vt82f30soE9TXjF0nlXZ8L48N3PZosKFq6BjvfywfpyiMA/Ke+AG+Ehk/aTR+dOJ0Ioa7badBXl00Y31C/OE3QvheQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDDfLNVt; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79c20063a32so48030837b3.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540349; x=1776145149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgqqoYUdUqAVnlXiVxrrYZRPdWxQLwzdIl5g7t/74/8=;
        b=YDDfLNVtTfgICJpEeDbqFymZZDpto+2HINYbugP8zZTknDNUMn0lNCBzOva3m05Faw
         DtuaJaDtJyjbicgd/T3ZXVDTPqMwboL9CeR0XKIfpVyyrJCdMi/E5hd4BZS51Q9DTL66
         uR6A7ikNv20jJ1mA5FN9liTH5nksyXaX6g+qM87S/UgJd0INJpV9mxdmrGVcckTEt9gc
         uv9l2VLR/cEITgblhXU3+xecXBiV1mez9HHwWo2bLo1OTW4BqELl8C9K5voz128wlxUl
         JVxdHnVgcw9cN0kTSY6ODF+z5gMKoYTTqyHqzNVVzAxAt0/R57kqXOtQIXCLYWr5dbjw
         /EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540349; x=1776145149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KgqqoYUdUqAVnlXiVxrrYZRPdWxQLwzdIl5g7t/74/8=;
        b=bHaJlv7SCFenxBBLXRdftL8MwotOMHUTa3qTm0hVgIZ64vzdodCk70oihhmY4aox3N
         bRF0maaB33/peNRA3LJUHRcSe7YR9SpmSlJFZgn/ej8lmLzKtHF5eF9Vp4ug5kh6l8xr
         VGqMn+ldsuUiQuAOyw07NcZk1AGRBrz23zPR0c1e2phlqbuUmMIUzTP9M5e50aaPIzxw
         kzjxmUI16ItLzw6g5ZZzVCZYuNwoGU2Ma0FgHqLMlUn7aZrqqF0KqDxVRN9A0XdBHG3X
         47LRIn73uXT3hIOk+PFz4r0sEe+MUBuYRPQslPnJRhM66O6aoWLMYgceAha3lQGXaMAo
         HkMw==
X-Forwarded-Encrypted: i=1; AJvYcCWqcsYX4ImH/qlZrQqtd9dlRqxnTro4n3DEcqxmAIC5F8Ewj8NpVdzYm+JJipFBG+vXCzVM8Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFWA7BV8irpSq3tNJ9+AzEog3gnUJ975HrP0yY9hHRrY3hWJo
	SBsfM9Nq5DTpSoGKkUl6cysAlbJ74IneNVtYytty9rgvl4nRB2M9Cbvy
X-Gm-Gg: AeBDieunn3gfiviRunq56odAdgXpP+HFUEZz7zG2cIvP8OtpMMuz/YoLNjjp3cFBg6D
	8Kk+PwrbJZJCx/zh4DEDu2Mv53wB2qjp3sNtq6QIqNqq+wNUkgyxY5zAYe/++x8EKG+zMH6EzFd
	FUBMrJ9HbRFsbsTgCMBT0r0381PoJ4wCziHRjbturpABq3lKPaD7cI+xAVmmYSHMboqcTq8WuQZ
	MT2BBHYgUNjcgy6wUTEA2uIjF1XNn8196E/s+rHnXTmGS7f3FXXx9UWdDCNR16bgsNEHWeoYFwT
	+OpQIK68zifZ9ortsTWPuoNFMsRvVjNeE7rBYxMQzCwYow6YIie/7xgnkOry+evejmTNFH0hZ4i
	7721GZj39/rwYDcKGnEvmRzcY7X550z2KZqhK1pUTD7NkgVNo72pI2IzQO+GsjDMRSdGG3YH3qM
	5BvAkdB4cJANU9WwqH7sa0H4gULju/2F4daT7yEaEvfBPY4X7RUBna/zIWtqS3
X-Received: by 2002:a05:690c:4903:b0:7a2:46b8:3858 with SMTP id 00721157ae682-7a3be360aaamr142535067b3.24.1775540349026;
        Mon, 06 Apr 2026 22:39:09 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df16aasm62717857b3.40.2026.04.06.22.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:08 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 1/2] wifi: mt76: mt7915: validate WCID index before WTBL lookup
Date: Tue,  7 Apr 2026 01:39:02 -0400
Message-ID: <20260407053903.75861-2-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407053903.75861-1-joshuaklinesmith@gmail.com>
References: <20260407053903.75861-1-joshuaklinesmith@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233492-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 052353AA037
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mt7915 driver does not validate WCID indices extracted from
hardware TX free events and TX status reports before using them
for WTBL MMIO register accesses. The hardware WCID field is 10
bits wide (max 1023) but actual WTBL capacity is only 288
(MT7915) or 544 (MT7916). An out-of-range index causes
mt7915_mac_wtbl_lmac_addr() to compute an invalid MMIO address,
leading to a kernel data abort:

  Unable to handle kernel paging request at virtual address
  ffffff88d5ab0010

The mt7615, mt7921, and mt7925 drivers already validate WCID
indices against their WTBL size before use. Add the same bounds
checks in mt7915_mac_tx_free() and mt7915_mac_add_txs().

Additionally, when a WCID pair lookup in the TX free path
resolves to a valid WCID that is not a station (wcid_to_sta()
returns NULL), or the WCID index is out of range, clear both
wcid and sta so that subsequent non-pair MSDU entries do not
attribute TX statistics or pass a stale station pointer to
mt76_connac2_txwi_free().

Fixes: c17780e7b21e ("mt76: mt7915: add txfree event v3")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2f307c4caff1..19435f3c6fa5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -913,10 +913,19 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
+			if (idx >= mt7915_wtbl_size(dev)) {
+				wcid = NULL;
+				sta = NULL;
+				continue;
+			}
+
 			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
-			if (!sta)
+			if (!sta) {
+				wcid = NULL;
+				sta = NULL;
 				continue;
+			}
 
 			msta = container_of(wcid, struct mt7915_sta, wcid);
 			mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
@@ -1004,6 +1013,9 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	u8 pid;
 
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	if (wcidx >= mt7915_wtbl_size(dev))
+		return;
+
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
 	if (pid < MT_PACKET_ID_WED)
-- 
2.43.0


