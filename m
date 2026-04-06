Return-Path: <stable+bounces-233429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPlKGTj/02lypAcAu9opvQ
	(envelope-from <stable+bounces-233429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:45:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 675B13A6532
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2939300B2A9
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62F396565;
	Mon,  6 Apr 2026 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7dzpaTi"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B81391515
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501093; cv=none; b=bdXE9u20iKG8oJF5sjIsUzFmHontQzlEEQOH9yfoSrEvWAVZCi+x3L8xw0b+yFy0JuCZ+3fDWf7BdR3oCmOjJ+cFtRb75FZJA4Foc+rZryl5EBIpfSfTRxrv38nZ5U4xbUoOFwNVnW8bbrjeK65PeCeIgUmvoo6uUC8vElPV3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501093; c=relaxed/simple;
	bh=WMU7EGs3jMkd5faIWQETGMP/EOvdf8l1T/tZgvHILm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3K1fcbNyybazlEk+ik1nyEY7Y69CXOC/4OojwZuUvVrWm1gHUV1cOesUtzO873KcAcRds5VmVhqb1xlfLCVL5RwrlSM8NA0qvJD6bT10TazXN2XzX5sIKKbXAs0iuN0oofLYb6WWObZRWtURq18BxCnZBqh296h2TDocUcDSEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7dzpaTi; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64e87a81639so3992466d50.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775501091; x=1776105891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIDqed17Bi0ataxw+Ke35vc4r3g4dT4TF34U2d2sNnE=;
        b=I7dzpaTixqO2jj4Tb8YF/hW0L+tZTgQB5JG3Oq+aYkjsP6NByCHqdjl0+yR7LlzZy3
         srkwNT8nT30IXw6d73FdQzKxBLBqB8vgpXqBk9mMEXVyzwLNMpb/ByucZdU8g0zOp837
         VaR6VNl0xkDGYjfPaXbVgeK39NzBIiG32g1anBvGGWkmwoIs5c5sFFhMkwXi+I6XGIfh
         hzxk24jm4kyxMhOdxLWmX6GF3wiEnJLq0cK57TOrQjFyK18Fr/zymHH99A9VlEniF0zM
         pXtggvoNt7o12vwBa1OKoQODFOTtD/pVPjgcVroNzh1+aZNQ9audVr/DIH4Zy+EWGX+G
         ZB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501091; x=1776105891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iIDqed17Bi0ataxw+Ke35vc4r3g4dT4TF34U2d2sNnE=;
        b=Qr7qOiRd58sHNyNaHL80oCwzHpTUfLF6vlVIC09wGdf2eN1lfjszQMfmPmQJVzswIl
         hc5h9vNbITdfqpEJW8RPBXGuEA+31hbxM7rGgtDkF1Dwp2LD0MIx8dfjBgWOuTsbTfql
         Doo965iRc4CD3zvY4LLf54jcKGsY9kk5bIjd2mKFMQ5uOf4FPCYeZfWT89hF1RWqG+7g
         yIve5QCEC3MrHRCTQFdi7OpKHgewRYvduJSR1mebSobSdXcdDLUP8gD3+/ogOOcRvSPs
         awHsEzYEsHl3JwBuKHYlYcNGZM00ZrUAbBh9cNkG9r6o6d3wLmWfFvdcDxUhkos6urkl
         rPOg==
X-Forwarded-Encrypted: i=1; AJvYcCVMZuWuNNULAJK/cGrW6QNDOvjx5uLycL0rqZRzDka1jQQ70cIbE2yxE1bvsgBo02xEFmWqwvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGRw7ABGa4lEUkLSnCa8KKsOeAU/Xn5hFzyf36mlX3t8Y6UwJg
	y0wH1KbMPBxDNrKNTnTMEP9spZxMo64/Ukofx4WXUAHNgsCTs9lvUGTx
X-Gm-Gg: AeBDietpoAgr8MmpXuB2BRTQgMSxeEn+XH4n6IfL1TRqAbN6zCZhKcTZ7X3J9mMKoLD
	7Kpdf1spYvJnfW4pQN/ujfqrhtK91fkeEGTD+o+5zPsn83DkjCopSGUp4zcoQFHGSHQsF3cRI66
	YodP9TlhKzJh4ZRmWhBi79hxMpk3IDiYnZBxwNHhNVSd62kFYQR5dLHf1xTAQhMY+W/W29GERVN
	BFRI6pZhqXYkj7SVhjCJ8qWs3YTXyxvm2bluhFA9ke8FAiFFo2m+WQ9QoHjBRBp0t/hQfGjELZ9
	rpKjltUJYSmJqPaUz/K0wsa1pZgF6Lvko2HX/5z7CMdALFqRwTNvgTmqh6ZEjndATaNB4b9MQcd
	LrNs7Mw0/SUojD7wQexuw8PR2L/LKh0qDo/yyQ44LXlIB61/iO6uztGILzGaSLZTvO4C3gEHYKj
	CSSmG81DwZruzTFUOJPAkgmdg/Wd04HkWRs9fPR/q8VCEU+sZX1wkhsu0S8JoX
X-Received: by 2002:a05:690e:1282:b0:650:516:5ea6 with SMTP id 956f58d0204a3-650488acc93mr13212718d50.65.1775501090808;
        Mon, 06 Apr 2026 11:44:50 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9a9271sm6342830d50.15.2026.04.06.11.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:44:50 -0700 (PDT)
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
Subject: [PATCH 1/2] wifi: mt76: mt7915: validate WCID index before WTBL lookup
Date: Mon,  6 Apr 2026 14:44:05 -0400
Message-ID: <20260406184406.8152-2-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406184406.8152-1-joshuaklinesmith@gmail.com>
References: <20260406184406.8152-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233429-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 675B13A6532
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

Fixes: c17780e7b21e ("mt76: mt7915: add txfree event v3")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cec2c4208255..0acada48824f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -901,6 +901,9 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
+			if (idx >= mt7915_wtbl_size(dev))
+				continue;
+
 			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
@@ -992,6 +995,9 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	u8 pid;
 
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	if (wcidx >= mt7915_wtbl_size(dev))
+		return;
+
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
 	if (pid < MT_PACKET_ID_WED)
-- 
2.43.0


