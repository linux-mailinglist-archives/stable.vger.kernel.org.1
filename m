Return-Path: <stable+bounces-233467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKH3FIxG1GnvsQcAu9opvQ
	(envelope-from <stable+bounces-233467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:49:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D8F3A852A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8FF2307E347
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 23:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF463A3802;
	Mon,  6 Apr 2026 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUp2rByL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848338E5FB
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519274; cv=none; b=AaywxspqZAucbNLWGCwRbqB2u9rcc4+YtdUFzvGWh7gtvVM/AtlYDDEBQJMI38/Lqd8fxTd8KUSh4+j8SnGymdbtmi3VbCMlha6MEftSHgIQ8UO1sKKMHQNbwXLisW54AqEWpoA+S+blvAZMC3U2iYM6k7OKIjYx3munxsGi6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519274; c=relaxed/simple;
	bh=jcpF1sZHHWf1OwVn8dXWeZm3vgEO/wJOncyayRAHT1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9ZCG8zfthy/LpaXaKezHRRrq7WtcPjw9jBZz+CCCGt9dq6rk4QC1iqp9y6hByb83eGWYJIcUdtEuksFZnOw3TJr4AxI3jarzS91PEB3ogLdON/WAU0WogK/9FSfTRrXuSiMoenhRZsVEXrHzyXpA2faoCn1VK0YmSVN44D7pDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUp2rByL; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79ab5fd969aso43430417b3.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775519272; x=1776124072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxwuaqOVriBYwsFBn6+xbKIu8945UDO3QfFnEekL/38=;
        b=RUp2rByL4R8G3w/V5XAQ0swoRqwik/amTIZppvp1RKdPgIO6tf1OnaKByMLKvgK7Zj
         h8vOmmv0ewhDiu1LDe3Nn4uMuhdYEcT+Ob++vkHqlpRCi0oHGTj31YpgxcWxFXqsSYn5
         3rZ16Z4FCUX2tHsEQvx888r5yrHwTTO1pIuqkjXHAZdplhhHtHv6WgmhDLEIRH42yyM4
         ROzesdenmvnCPCHXIt6R+dpPR+atugmizWz2E/D6+JEjwJT6A1PyDCMt8SLNoPI4GmM3
         6eRCR/6ytYkqeijYDUcEx+7FP1fsaPDmhMbASd3gJ0WYiiAldam+AOnDu+87F0aXEFnG
         n1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519272; x=1776124072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YxwuaqOVriBYwsFBn6+xbKIu8945UDO3QfFnEekL/38=;
        b=XGpXRP4IQnJmf0S+WN0KD0+4jPMPXLaSunRNC8GqVnBBC0GU88HJoAZfyzzLy/Ymdd
         5M4T4r2LLYIuuVa/OwsMWyQ6/4yUWigXkT5y9IVTVhiOZaRcPKLvahnmg6KTs9EQbpWj
         j1k+gqXDqrKz76ZFZBJOacnHF8ceno4UoEjevCcS/Japioax8pN3jKwK5UBtGDHlGZlq
         UocE578I5GlOXHm+cuj+atlqVLK2RTRiR11hqEJTfkBZBMt9SQtoap7eNXqJRFifPb0b
         aPn88N2amH46Ht1F2PI/A8VEJyJzt9OZGz1bTXJZpB1ThmMw1l+SoYExfL/QZqYzJE4a
         ExjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7KZ9100vI337Jjz+/gNRVqvjeeWeSbwn5y1C6ExznllK8gGRVaMOI3HIltFdxhXzqFi7OMdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOd+prsLoA03SY8z3WvtaoegyxXRzSLOkVzggAnjprJWMqzSbz
	WRizLrQXdC/Z03ss+Xrj/AfmJOo9j+QBmea0NX1+CsWjcDatgE6oE1RW
X-Gm-Gg: AeBDietMC3AsoklN0vdGAefehnurnaOcARKzofOd1xcPcwPNU/4Ch11RvKAOuU2BE9L
	jQUH768TgPRTHIpho7SdsD+XUafcgGoeEJiTdoKDrnl2QIBPqYsZOP8UZAiCk2Pf6tho3JWzfag
	5D/vhUahgzQkg861a2u8La6oOMTasE/1T6DHuL2zBy6Kik3I4COWq2G5ywIDXZPZMbtGCntst9/
	3p+7Le5u8abhXrjcglninYQm5yqLm1gzefjUjDKdQVPAIb3ag9L/dsS4WGsresjVcSgENrIOvq1
	Ixc0h+F8SxbVbKGNBxD5l0LKZz2ixQ9bVj80bzQ/vQLLb9nn9JFF1tgm+JXCRd28RSeh2NgeNwT
	HZS+yiYOywOwnTI76ga/5nKJT8OK62IbIu9n618LOTDI54xXP7lrvuMWIWQ4rziZixgvr/KQ4/n
	31HYwXReN8pIT7jq2YPwETuvcdIf8SjHYtuVzwWXZKef5U1bOAHQ4WV4MLK6aa
X-Received: by 2002:a05:690c:e3e8:b0:79a:ac83:ac84 with SMTP id 00721157ae682-7a4d5d5aeb7mr151996137b3.41.1775519272091;
        Mon, 06 Apr 2026 16:47:52 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff31sm59350177b3.6.2026.04.06.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:47:51 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless 3/4] wifi: mt76: mt7921: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 19:47:38 -0400
Message-ID: <20260406234739.29926-4-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233467-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E3D8F3A852A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fourth receive chain RCPI uses GENMASK(31, 14), an 18-bit mask
spanning bits 14-31. It should be GENMASK(31, 24), an 8-bit mask
for the fourth byte, consistent with the other three chains and
with the RCPI3 definitions used elsewhere in the driver
(MT_PRXV_RCPI3 and MT_TXS7_F0_RCPI_3 both use GENMASK(31, 24)).

On devices with fewer than 4 antenna chains, the corrupted value
is masked out by antenna_mask in mt76_rx_signal(). On 4-chain
devices, this produces incorrect ACK signal strength readings.

Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index bce26389ab..7a46b50171 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -155,7 +155,7 @@ static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		mlink->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
-- 
2.43.0


