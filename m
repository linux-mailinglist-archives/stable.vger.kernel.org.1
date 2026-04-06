Return-Path: <stable+bounces-233433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHwJK5P/02lypAcAu9opvQ
	(envelope-from <stable+bounces-233433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:46:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 722AC3A65A2
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D569300E008
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54A38F247;
	Mon,  6 Apr 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+D3/Ka3"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2538BF91
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501180; cv=none; b=ocX45ztc7U6HyHEAr7DwF3qK+pWC6l2vFN/QROFcGKpTEbKWfHXa/Dngcp6L0w0cuSEKyKEhX4RdU5g0jOHTST0ajKFB6Wg9EOzkET2PkHfBU0pVpSX2VOTDjZ2VIkNp6QbvfMfN6A2y4ZavmV4p/VhdoxyyjJSKevUWVQvp3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501180; c=relaxed/simple;
	bh=TodaMl53UO3CirNfBGxleA7KOIefYV/SEGEFmuQG35s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y93REVM2KUiQWYh/9QbsjN8POh83cuhw5T6ppc2pQoxrpTRlWXGo3fPFhKtR91v9/QLeBtU2FWz+N1BduOJbU9yKciGjeWinLBaWZsJQGO0NH+v7QiR7RNwZYQ5bJWVM0UKPm2ExF4O/vHWdXdORkjn29+2ORZhfAiVkIh8vnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+D3/Ka3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a2ee65171so60783787b3.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775501177; x=1776105977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZPzCplQeYw4HrNPe0mY3COLB2w8pgJ3gstqK4owbOE=;
        b=I+D3/Ka31lJe14KNDtXtxVBdyUZGN3IngJkpE/lGeZpLAoeecfnwGHyDunixTtSk6c
         Xir48p2sPXV+8HKU5W5pvGvy1+BlyBBvmVYpBnZdaS6q1/Y4QMGub2VHN1zC4C3a/vPu
         vP4C3drzg3tkRisCwiFtkSfoHv5+VCAAr1u0wO8YdVtBuaQcL2YNw0hp7DaskXZ6/zwK
         uZUb9UWjFJYF4u3+7eeHCX6nD8zcxelz1j3/04XYfz3czPe+MMjPk/8b75Qe51MUHdAL
         l6orLGKoEk9rP7QOthvd/ZV7ZDF/CLWDVRofgiov8h/cTQYVnAS1jxEWoARbVn59DlSR
         El9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501177; x=1776105977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZPzCplQeYw4HrNPe0mY3COLB2w8pgJ3gstqK4owbOE=;
        b=LnAeSTfU2VFMXeF3tgIyyta9gdm36F6IOF5Fux8QyrZtBW9DWZ57x3hnhjHh9chQzF
         6x+J5h0wc2fezvV39PRMcMo47Qd/aj4tY+Z+zLZctT6Q11zjQo0jBcApe2l3G6CCk22O
         p9c3XqOcIlt1K21yI5RcRQArhxNXt2xpdRdhcWudSDG18Be+ffWi279GqCNvhzkFrmqg
         Y22vxKVZAFVMjwztsNTukYvCWVe31L1v0Q8z8kD74e+MpaidZwWTEwPrVpm8HRDj4r30
         0e7zL4pA2jRfJQC46ckRjsYqm9lsR7dL1MwZ4Byt3IeKv4GBL5TuYBwCxXsS7GoEZM4v
         QYNA==
X-Forwarded-Encrypted: i=1; AJvYcCVAN78OGbokEK+l52OiYYcJyrdkrrhFi5bFPqEXxHEzn2z/RPeJZMPNAX27xYkSMFVsqUDjIrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+N1OCOvi9hu6BLKuqT2U6ePlBMiO2sSS3nqD0U33M2KG8xyd
	/ALuKB/VtxQ7e4vKUtdgIF47Fkk5caqogdp5VICnsG3r6yAXb7KNEdP9
X-Gm-Gg: AeBDiesnMt+LzsUZO/PS2yQICcGt/vsg8OcvkAHKpFHKiLhPrk8ninkMwWy0wVeQqzu
	AsFrFKe6DO5Dt7jdWP0vAmlmm27yn2obOlAKNH0039sspIZId+0yvDwnefsrLt++NcitQXhECR6
	3Vzqf+oqOPYypJHIqla6fVO3YYe07U7qnHWx4NfRc2YSqi07Okz4p/lQo9iZlxbzDhuS7T1G35b
	BoXKlcvzwyg00BuZ22JYo3ojIupcRGYbMuiRnp5jNYgMCUHV8IMArLHGB5RjinW4chDoIsaDD8k
	P/6Zp1b5f/UZvNaBb+IUwwo70X1T5MZUevpUHEyBT9P6PMP3tdsETtTn8kpjJLEqROSGD2MphSS
	OqeVtHLB7DRfyp1OpRlhCHePl/COg2KmqcdyBWfsK5MHRK4oZLvFBXmmVVkpf9botwO5oZg3HGH
	wC2Trw9GvE0tHCaytPAcd4X8v+MN331Mh25d9iayNLyBXlAWudKEsWhUNwS+Dj
X-Received: by 2002:a05:690c:dc9:b0:79a:6751:1489 with SMTP id 00721157ae682-7a4d5c5bbf6mr138049557b3.38.1775501177568;
        Mon, 06 Apr 2026 11:46:17 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e8343d3sm56288377b3.16.2026.04.06.11.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:46:17 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] wifi: mt76: mt7996: fix DMA read beyond mapped length
Date: Mon,  6 Apr 2026 14:45:56 -0400
Message-ID: <20260406184556.8245-4-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406184556.8245-1-joshuaklinesmith@gmail.com>
References: <20260406184556.8245-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233433-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 722AC3A65A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Same bug as mt7615/mt7915: buf[1].len is overridden to
MT_CT_PARSE_LEN (72) but the DMA mapping may cover fewer
bytes, causing SMMU faults when hardware reads past the
mapped region.

Cap the firmware parse length to the actual DMA-mapped
length.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index e2a83da3a09c..5c03dc163547 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1171,7 +1171,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	tx_info->skb = NULL;
 
 	/* pass partial skb header to fw */
-	tx_info->buf[1].len = MT_CT_PARSE_LEN;
+	tx_info->buf[1].len = min_t(u32, MT_CT_PARSE_LEN, tx_info->buf[1].len);
 	tx_info->buf[1].skip_unmap = true;
 	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
 
-- 
2.43.0


