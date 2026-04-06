Return-Path: <stable+bounces-233430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF13GTb/02lypAcAu9opvQ
	(envelope-from <stable+bounces-233430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:45:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4682B3A652B
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBE49300D1CF
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24515396B84;
	Mon,  6 Apr 2026 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvyjnwoZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900F393DE3
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501093; cv=none; b=BF9Y/Eh/JJ04fU4dVL4zVg3rPrR4uYd8qRDMxcB4V6BiNfqXShydSRLyubizf5hfWph/2gato96B8oBJNnydAgehUXRDeMCHcMhd5TA2jUjJcfH76biX2R4SwGsSNPJB4s/7Yf6S4KRsYP641JDHNwNkviggW95yuz9PdikwPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501093; c=relaxed/simple;
	bh=pEvU+QYTdAtxGpbqErFvleuuq2RzHaUh40Ae5euTQOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAkgwxQvpGVfuNbaJTcvbZYlR1jthtx8TpQe0gJZ8hzRrWkQIO6FgqAYl1MqoCRdsdfjH2ezytEIUShq2xn5I9csv2DVLaWpS+0TsUC1JJFU/TbIcbpXsluk2r6kNS779VIUcW1QgQR/IAMPp+TF2aSGJ9gofrkpfETjQAMi0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvyjnwoZ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ea87af213so75958267b3.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775501092; x=1776105892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQoz1d8ovhjDJHF4BWKEq+W4S1EYJTMp42UIwuuSZLQ=;
        b=kvyjnwoZGoxAq1ocHumgip16t+Em4S7Agp2d7+5B8P9LqhL4jagYmjwb8jK2JMvHoj
         illfD5+48JW4aT+SIs0tEnmRp/OWSR0EuWs/CfewCAZVO0/AMBpDO6rdX8I+gBrMTMWS
         Xw0h4xBKLxdTu55QEqrj9u79kt1ovT0JC+fytT6RKxIsqL+gVj8lx0Q87CP7FF0FJk7I
         P8cTvRKwoTE6g2392uA+S55X7pBPrf0pyVQYyctjKTZ5UjcBQCOonYUlCF2Nb2dF/vDM
         SOEUWYPaEVH62SucDNdB6lfgYJChDvwAa9qgTVlt03jKJmm9jotqwmqZjCr9Xm03MEpD
         lyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501092; x=1776105892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQoz1d8ovhjDJHF4BWKEq+W4S1EYJTMp42UIwuuSZLQ=;
        b=FkzLLp3owbF/nS1gLuAx3xW5T1c7rQ7AR5AMJNnaOF3mFQF5PQDLtmWbJJ9bPdiBe9
         ovdDIkme1J/ReZDHuPN+6dbpx0QnFIy/c+/JzkH2FyKF1Ybu6j4BMtqC306neZRAEazs
         sW09OatVZBnlm/49U4pFKYKb5rQIolZAY5f5jHttTu78s3G0M93v+itfYs+oxBTMfXeD
         sFn48wn7N2vKFpg2j2/XiIG4rcfIx8HYwgaF8o4lmsJu5qSoIV47YJQ2pr2YE6Cwe78m
         V+lvJhjMYe1g76qy/GVOVeRY5GAPq2i87L5C+xhzFJ/+JGXtKi05oHukxWh7Zx4vVXhJ
         XnhA==
X-Forwarded-Encrypted: i=1; AJvYcCVWBd8mSC88UnZFaR57Pycs+B1iarnI6KcWu1THFuhWWJrVJYgY0GHML42REkaVK7I5dx/h1ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YweEoElLtGflWnWk8qkI1pVMW+Pw0MDHlP0tL4bNthAj+2H7Ert
	bxG9xa7/LtoWqPgJImooR8hb26XYf1jfDXbNtaEVMS5P+9jsvcJuS96n
X-Gm-Gg: AeBDieueAjLi4vVs6Rws1LVR3x/3eV9mhTMj+C10kIWunwyBNtnLOtjbvbvDG1S6npL
	E4r0JvCRX9YcbOENRZ0VwDaks1k7wn51HunZXbiJUXaW/hDG5piV+XtwjvX3P1LgXUp5Uxw+Sui
	aI8q9NG7sWVYKi49KR5smJuii4zpK5CZf7g/KXb4VSyI/PDqd+2NMBYqOHBafamnJ8E26vdDZvo
	X+U9uPP9sJq6XjwKnMJwUJfARwvY51or2rCngsWV97Iwdrak+guzWpcv+w1dpq//78UabTtCyrC
	PROKhYy1s3nDmwunekoD2OExpRBLdfVJdQQh5diYZGgKKetdPnvy8OLYXc9gEwoSmZFT9DTr13+
	Ufl2uUk8VDYYIEQYyi+mu6nGnV08aLGK1zlwC4rd0SVzQ+Jw7s2MCznlg8/JHQO78ZylQzWRc3p
	iAoqUopIFyv+qXEywDWAP9Ge5E5rWNsiQstxqU1COIBdQmkk3j9423ZWVA8djM
X-Received: by 2002:a05:690e:440c:b0:650:3363:ff81 with SMTP id 956f58d0204a3-65047fc62edmr5918011d50.4.1775501091704;
        Mon, 06 Apr 2026 11:44:51 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9a9271sm6342830d50.15.2026.04.06.11.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:44:51 -0700 (PDT)
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
Subject: [PATCH 2/2] wifi: mt76: mt7996: validate WCID index before WTBL lookup
Date: Mon,  6 Apr 2026 14:44:06 -0400
Message-ID: <20260406184406.8152-3-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233430-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 4682B3A652B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Same class of bug as mt7915: the mt7996 driver does not validate
WCID indices from TX free events or TX status reports before
WTBL lookups. An out-of-range WCID causes invalid MMIO accesses
leading to a kernel data abort.

Add bounds checks in mt7996_mac_tx_free() and
mt7996_mac_add_txs() to match the pattern used by mt7615,
mt7921, and mt7925 drivers.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index e2a83da3a09c..ea775029125d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1327,6 +1327,9 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
+			if (idx >= mt7996_wtbl_size(dev))
+				goto next;
+
 			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta) {
@@ -1563,6 +1566,9 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	u8 pid;
 
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	if (wcidx >= mt7996_wtbl_size(dev))
+		return;
+
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
 	if (pid < MT_PACKET_ID_NO_SKB)
-- 
2.43.0


