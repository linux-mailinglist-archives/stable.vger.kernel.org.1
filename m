Return-Path: <stable+bounces-233432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMzbHZb/02lypAcAu9opvQ
	(envelope-from <stable+bounces-233432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:46:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 135AA3A65AA
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFB9C301E991
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA4B396D0C;
	Mon,  6 Apr 2026 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf/dkx2Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D04393DF9
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501179; cv=none; b=T9Z2OIkcusYH3uXFbXkhNbCzxl8PQ4qm0lDh041wCbuG08aeeHLjeBC5tJ+/4DQKAQ7Is3wDIb9LwjB4xyCTkmGGrsIakKZtvhIv9klIsbcl0eMbEeTZYhYRDMLx3CRrsrzDiyKi1BefRwpYqPeWqiW2d5xQPuQdIqAiOHawLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501179; c=relaxed/simple;
	bh=1BlXWlRN49rlr8956LLGxTQhvicZChrmUTMEfYKLNeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfypNrDW09n/46oSN6TOmvRe71wQBHxgRHqCpQqLDqKxhP+8MLnSLBZoNSirrIazmIVj8/UF3Ckizm2VDA7D5wk0qge2Ev+0CR7ybRHy+/23M5rui+AMZXRdML1AI9HSryyVgn0OMwIErNp56OlyMyCsG0m9ICTvgQWBMZY8Z3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf/dkx2Y; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a535e7c00so41976687b3.3
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775501176; x=1776105976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loX0Qy4NihlN+KUtrLsqZhhdHawhctjv5xYILfNriy4=;
        b=Zf/dkx2Y+KQ1gfePjRUkmcjLJ+d1NvW5qY6GbnVkvqmap3pufd5URfS8nyrLc4JSE0
         6Ndce0qTr08zaob6D3Bsj5LfqYGayT6HkUYlG5kYPtCQmJymlxFYvfs28igdmzIXWyFV
         7tZaIbfRkh9S37sBnIR5LuyKvqeACDSoObHCPOIaeC0XxQ97HMykl2Fwo0JJRyL+2j7t
         vgjPRvlBQ5qBfw6pGcayzWs47zxksADpu9AkXcSp22W56bZVuf6SR4491S88CoOFqL1s
         h4QF5bBkWLWvN5pve0N7LcwGggQZqUeUXx7JgnXi3bsqnGGPXvOWRud2onu+E2coNdyn
         CmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501176; x=1776105976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=loX0Qy4NihlN+KUtrLsqZhhdHawhctjv5xYILfNriy4=;
        b=akL+t6d7y/++mASXFuo0Bu9DO5XbITMLPQrpz8mP7smEUJl5bZUhzFVAmGQtwY5TOs
         C79RsFmxCXkBrkMSK1gsH1y6r/VH+Dhv02aQRmiWlBmopY6Mfe/kJwr+U/1dIX8DKrdU
         hfDhfyfQwzV2WfV88JFVPispZJ6LFasvoFXAwO5aqEbgYHnqHKDFHNzlCXXZSgGi4KLu
         HVQs2wv87izUq5Efny4pRbRXSPbVZrJOBCijcfOaA/jy3ElHBhK330h0cZSa1LHlPG8M
         8tZGU9a+VTVoe+H5Gem9RxT718FDe15NLcypi+HzMJL5zDjrsXvtXw5TfljNDO9xl+QX
         hAaw==
X-Forwarded-Encrypted: i=1; AJvYcCUcpF4cqxxJhJHlhFV+Kb4XGQ1z/Gf1LLIjjA2LNVS8Q2FnXc7d++Tuks+m6CCJCqToWWxWy7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWuSJZ8Gu6u7p4idsv7sXtEvQVyOReFsOs69xF/C13TE4OLB0p
	NRfnw0RXV4qrvA227zjyTUs6Zn2ZIcqoQeMbL8AQWACcCRzJTrdyW60T
X-Gm-Gg: AeBDieuqrxLJGWrO/e+ZSV9QSA0sLBJmqDcD+LB/CPVVy1kZd6jhdudjnv3HFtRrTlr
	H04l/QbrTpRbSv+HhrAXookkMQy+6fgoFxTpTLK6tNCUEQIoCNzVAZC9tDLixJ6ot/LM8CHbd40
	hq9kZmh9sYQLD8m4nBAlK3gV/vZVW4XVuLjrYXQuTtFSTYakcsy8MPNnS8uo7hMQ6474YUA7SVd
	WvHq2wL3hhPSwk10m1kf5a2CNyaNsZfctNV7ifFx1K4Tg7KDIY5VBDoUWEgigPRPo/LJmcCZVu3
	ntzOM2jcLAB3b5GM7MJRj+9zWT4clrMvmmJbsbP9HaaDNZ53nHmwBL4soxzjES4Tpj6F6k5sLdg
	xaeS6hrGMrdsjccPw+PsnRBw5Ndj0IGUbsoQGAvwR7RcckT2O+EZhk2p867aVdR5+6lLv/qcmPh
	swFWmcFN2UAzR/FKBg5QL69ULUrYfDoFL8l0GJ4Z3Dccp15vrGlatjb6+IyGgI1sYbw2vJ4WA=
X-Received: by 2002:a05:690c:6891:b0:79b:82a1:645d with SMTP id 00721157ae682-7a4d84c2b0cmr136330457b3.29.1775501176499;
        Mon, 06 Apr 2026 11:46:16 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e8343d3sm56288377b3.16.2026.04.06.11.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:46:16 -0700 (PDT)
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
Subject: [PATCH 2/3] wifi: mt76: mt7915: fix DMA read beyond mapped length
Date: Mon,  6 Apr 2026 14:45:55 -0400
Message-ID: <20260406184556.8245-3-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233432-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 135AA3A65AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Same bug as mt7615: buf[1].len is overridden to
MT_CT_PARSE_LEN (72) but the DMA mapping may cover fewer
bytes, causing SMMU faults when hardware reads past the
mapped region.

Cap the firmware parse length to the actual DMA-mapped
length.

Fixes: c17780e7b21e ("mt76: mt7915: add txfree event v3")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cec2c4208255..b66c440dbef3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -799,7 +799,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	tx_info->skb = NULL;
 
 	/* pass partial skb header to fw */
-	tx_info->buf[1].len = MT_CT_PARSE_LEN;
+	tx_info->buf[1].len = min_t(u32, MT_CT_PARSE_LEN, tx_info->buf[1].len);
 	tx_info->buf[1].skip_unmap = true;
 	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
 
-- 
2.43.0


