Return-Path: <stable+bounces-233493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIcDG8CY1GmkvgcAu9opvQ
	(envelope-from <stable+bounces-233493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:40:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C93443AA040
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86DF33066BC0
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 05:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561C4238C1A;
	Tue,  7 Apr 2026 05:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRT1/Dow"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F3124A05D
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540353; cv=none; b=QyNCokttSEQgAqakGt7ezA+spPtXPDptFSuuiL7pr9h3ZLHOGU127ZsLERu1sbQapcouc16xZGCMSHJ2EAJvRdso/JPe5yUf4JqucR9f2Rz0Ql5KtXMpUqMofzcvHwC+Wu8xHU1BgGZKcTvw4MNbK/f+6IKDrP0CIKd/6d9+g5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540353; c=relaxed/simple;
	bh=lpS2lgLycURCmZI/HtqHD/uyM5+gjDHHrpf13HFq4+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuQ6iI8GpucABOhSnSwLL0cJVRdKNmlq6+oxpOW0EGopQqOQFvgQjHjeNrnrQYix5pX80Voywl3q5PiCD1hT9ctLb7WVXz3KP+Cb5JEM25kLA/q+87W3+FtlVfKZqS1Z/yG0VjuLZ8l/Wv82J39muId13AwRJgGKP7CWghcbrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRT1/Dow; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7991db3dc98so49055257b3.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 22:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540351; x=1776145151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyxNPR9LtOJbsDYiRzlbjZmq0oJ2BdijH6S9Tp9A2kI=;
        b=WRT1/Dowq5rypDOe3uHDJy5T/YZde5DYG+KT15Wbr3sSpvSGYeMP3Q+k4MQ1kvBhya
         ENdkTi6cYa76Cz0nJ3xS+5EmsUtETkLY/4A7+gKoR9aXacfoDCqf0Yb5/0a4Rle7m3Uk
         7zS9akXEb131Zpmwk8/CoUnXKttPXLc5dEFgB9+QZrEteTnkq7AmX1JaIdAlarmPcBId
         R0HHntF94WjOaOTLtb62p5pmIPcG0PsHcv4JbcvckteXkGI7enWkZaZwAdi8+3iwV6OK
         pvHPFR2WBTZIAkUHUsw/6jwDyTnlL4/m13XltooI0LjjRsgujAGVXKXicYEdP7L0KYi7
         Jixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540351; x=1776145151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JyxNPR9LtOJbsDYiRzlbjZmq0oJ2BdijH6S9Tp9A2kI=;
        b=eIWaBVqigo4MZRpA8E31htxJ5h43BHpXIitk+HRnwTodwrLGR2onpO1/ahi1nrWXSF
         JYMRDy0eEJ7l1vw9N60yl2Siyz/ToAYYhV1hoCvNQkhx09InwkZuFmIEUEAOWRHextid
         WsdyFa8UJnw1iWf/6TDoYQ9so8z56HEoJAlOpil1j/PENF0dScDzg5VL9bl8QtRZkzNc
         WA0AGM7uJYlRba+XlmTzlrvAFi3jimyhXLueZEn/U0Xcmyxj7Dtab4wkgRwmAUg3YIMc
         IZMPFU6MjDkg1OU2ck4/DBi0AEX0/v8aRxcZlkeImIzs9RS/k7XtudJDTsOKac0BFQRc
         nGOg==
X-Forwarded-Encrypted: i=1; AJvYcCWVApMaD9kz0CcUG4K1CyzmNyT7MkCpADi5p5fr+r6g/Pme/ot0O25oOAzXjOaHz5pVV2HmfUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysNeJBJ2OHWhJtlVm6Rm4qr29F6ONFnbKLknef0ZZn3WzzTnxT
	DMttFMuRqttYToHsOGsli6m+/kexOgc422IHsnXvZ/Zp0Tu8enoLrRnC
X-Gm-Gg: AeBDiet7qpLFBWlwuV98o1dgNkQEC53NOTZbxmQXyoEre12aiMdrcc8oPAPTCm2tvsh
	B/fKEQfKqjlQfQniAMHD5p6aAWIyqhJwoNp9AcAu26ab01dZiqbvoZfOT1U8Z3W7bhquA2HBf7q
	OHJoyL6gWuXKGMcgBe96SHnuKVq1WO6JTWpCg8dZrwergtzI/VWnVAV3XTFvnRfrjRcz8veuXXb
	TXV2vXNEOwvdBAYfgcjJiX3upQy9l5dR7AIom3IcK+KhPIFgRvDFt/ExQCNXqYh3ckHoZ2tTJkI
	sT5JoScgsmWTWg1SIXdWYD+AFkcDoLncxPsdrE0AgyXxllW/4VScBD/Xhh4HE3645O1GRJUlzTc
	WsrTpIyOIHbdtWWNclfp0WDrwTD0vPkbEIcmSF0aLrOzDDYF/5evaaEGr6Hdzaq/jo5gqHlqOpZ
	vfU4J5SkEfrN+bsQzNomgx0T+kLT1MCVY23YhEFanz+w7ABDUVhwxiJwFqxJpP
X-Received: by 2002:a05:690c:6d81:b0:79f:5ce4:d68a with SMTP id 00721157ae682-7a4d00cf688mr149319447b3.0.1775540350873;
        Mon, 06 Apr 2026 22:39:10 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df16aasm62717857b3.40.2026.04.06.22.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:10 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 2/2] wifi: mt76: mt7996: validate WCID index before WTBL lookup
Date: Tue,  7 Apr 2026 01:39:03 -0400
Message-ID: <20260407053903.75861-3-joshuaklinesmith@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-233493-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C93443AA040
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Same class of bug as mt7915: the mt7996 driver does not validate
WCID indices from TX free events or TX status reports before
WTBL lookups. An out-of-range WCID causes invalid MMIO accesses
leading to a kernel data abort.

Add bounds checks in mt7996_mac_tx_free() and
mt7996_mac_add_txs() to match the pattern used by mt7615,
mt7921, and mt7925 drivers.

Additionally, clear the carried wcid and link_sta state when
a WCID pair lookup fails (either out of range or not a station),
so that subsequent header and MSDU entries in the same TX free
event do not attribute statistics or free tokens against a stale
WCID from a previous pair.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 3d9648fb6773..f962ad398e04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1248,9 +1248,16 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
+			if (idx >= mt7996_wtbl_size(dev)) {
+				wcid = NULL;
+				link_sta = NULL;
+				goto next;
+			}
+
 			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta) {
+				wcid = NULL;
 				link_sta = NULL;
 				goto next;
 			}
@@ -1482,6 +1489,9 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	u8 pid;
 
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	if (wcidx >= mt7996_wtbl_size(dev))
+		return;
+
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
 	if (pid < MT_PACKET_ID_NO_SKB)
-- 
2.43.0


