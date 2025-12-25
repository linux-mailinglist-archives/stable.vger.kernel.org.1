Return-Path: <stable+bounces-203401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBCBCDDB90
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 12:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03E6E3002075
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 11:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C8F31AF25;
	Thu, 25 Dec 2025 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYrSDPsI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E0238C3B
	for <stable@vger.kernel.org>; Thu, 25 Dec 2025 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766663703; cv=none; b=M11MTHeoSKXDckvr0URgpwCHpdKYdIW2vwL17vGD+IFSRrTn6WwCGaSZsdCqlzD/HgNZuKC+K+s7GNU1COdtoKhAWeYOgvUG21YDJ5JEaig9wyx7EXft5Jg+/qXNMQ4sH4XqwvdNJueaZdQzHasCRcmnSaga5wTWMpRA9KcHx+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766663703; c=relaxed/simple;
	bh=26jbtWO1gui1Tg4M2KXsYQt7Cc6dhgtAwRsKPEv+q0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daLQpebBz0lUnwXgybmB2SWWERn1wTDtsMjUSesWQAg2hxdo6iu3J2jehrYUHUXDJJvUxll9TIX6ztu9J3Mi7qvLRPMHyxqWZYVrsRVoWSJcviqyMmhiwhzQgfths2R/n3AaiMEl7hveR/k+s4lDwud+sQKilDoEhYaImAw3iE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYrSDPsI; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477632b0621so41471475e9.2
        for <stable@vger.kernel.org>; Thu, 25 Dec 2025 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766663700; x=1767268500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1F0wCtq3gcx/BwLH3t1r9Kcjr/HuK/9IXAdL1YRX6k=;
        b=UYrSDPsIOk2yH5GzSgPjaP0uWSExvmdA0BWj2gh4Ec06KVeGFvIwymW4GGRFKswncl
         9/EbpMhn98fDPigNYKW8FDZYRuy2EIOpYYdtmhZFFvGgRRF1hyesMdfMquwlcslrNSZ4
         Qan+knk8xzIeeXcXGtFzMcY4tmWjbc33spgn4h5ydzGrSgC+dwSgVMutqZitOlraSlio
         7Faoi3XLXT+wPShtr2V84KGwE9RQglBAoJOWYkE4RIa8YzKj5+B4BH4x6tJ5IIj1ojk7
         gl7vrx0jY5CnGJlyFypczi47dVdHioXWGFuTOdqmbvJy369mVRwOwMOyb1U+Jr9NUfHk
         MydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766663700; x=1767268500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1F0wCtq3gcx/BwLH3t1r9Kcjr/HuK/9IXAdL1YRX6k=;
        b=bcMeOK5mpnQeVLNobLKzgdYtvIHMmIsSAusxfKQPl6JESPChhzrQPpM2vi2amvzoQi
         qUMtBJRRPrzJnGw1InnWc6mY/f7yab4kgf3KKorSulatZKYI+yDn3gru60R4XW9mYXnb
         8VvnFoIkqKtrLLy/G52WM9LwT20SV9+U/dOtjD6P0DthC1zxruofwJnlBIR2x/04eITd
         vo8cUEDUvasyFvkhsHYWBNkja97AJZlZl5r31FpnUWX+MuzzUKrWQBX7vkoe516z2rWZ
         3ImJsG5qXVOzd5Gekn+N82EwunM5bBL7/nv746JVXsrtI1F4BSYsJ0KaWWgPkmWyyfrP
         IdvA==
X-Forwarded-Encrypted: i=1; AJvYcCWnTsg6O6CV9PvCo3qIbAd+WJozUxpQSwX9DyAORC28CBfXeaps0FRopjr8V8KtN7FaXVvcgYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5V6XvjKdHFIA3DkuuL+QC+p3IxNNG54xqSQqYGcu4kM+c40fA
	GZnCYvk6TT4iYiv5yCDleMw1Zd/fM+9fK8+dY9piL4+eo8YwfGqWOgcn
X-Gm-Gg: AY/fxX5t7KNlnBV5KQ6ntROtUdRBUgw5RxIYABc34ShSyvMJNej0WdmNuIZhz+i8v9g
	HCr4G1cwri5QeKKcmxde0Z21LWixSKfuF7FhrXJs5hP8PfolNHEc8VLxjPsV4b8FVz+5HRCwOr8
	vcr8zJcwy0GDDKMrx+C9MvSsb+9DKlLh34H7pASpOZmDmUANe5HQYnV2e+9AKxjNM4SAOui1cWT
	sjbEpO6mKhR/KKQ0UtqHKsTggCLWGi89aM/nQL0B3K6kdSkUU2wK0FJNlhV3vBusfDRDqYfb+f4
	gzYYN6/ZdUgKDwT9SGFxQ0IrxVyFMVKbpTtYT0dc/PYRhx5uq1UwCOpZTFq8FhaBBRM/+GE342M
	abyg3fD2nJfJUYTN+5Vl5caqc8A8deORwaja+gJmH/NkoBcFTCEZgzhwAy3WqNiK2CUh8kFA=
X-Google-Smtp-Source: AGHT+IHugqS8KlGEruk1RYHem/ONDjxOPQtNAOoiwifvCDUQycnoRBKbn+/i8CRTpf+IcmvGYK5Qyg==
X-Received: by 2002:a5d:588c:0:b0:42b:2a09:2e55 with SMTP id ffacd0b85a97d-4324e45d3famr19833686f8f.0.1766663699468;
        Thu, 25 Dec 2025 03:54:59 -0800 (PST)
Received: from ubuntu.. ([2400:adc5:19e:d700::3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa0908sm39022593f8f.31.2025.12.25.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 03:54:59 -0800 (PST)
From: Ali Tariq <alitariq45892@gmail.com>
To: Jes.Sorensen@gmail.com
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ali Tariq <alitariq45892@gmail.com>
Subject: [PATCH] rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add
Date: Thu, 25 Dec 2025 11:54:29 +0000
Message-ID: <20251225115430.13011-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver does not set hw->sta_data_size, which causes mac80211 to
allocate insufficient space for driver private station data in
__sta_info_alloc(). When rtl8xxxu_sta_add() accesses members of
struct rtl8xxxu_sta_info through sta->drv_priv, this results in a
slab-out-of-bounds write.

KASAN report on RISC-V (VisionFive 2) with RTL8192EU adapter:

  BUG: KASAN: slab-out-of-bounds in rtl8xxxu_sta_add+0x31c/0x346
  Write of size 8 at addr ffffffd6d3e9ae88 by task kworker/u16:0/12

Set hw->sta_data_size to sizeof(struct rtl8xxxu_sta_info) during
probe, similar to how hw->vif_data_size is configured. This ensures
mac80211 allocates sufficient space for the driver's per-station
private data.

Tested on StarFive VisionFive 2 v1.2A board.

Fixes: eef55f1545c9 ("wifi: rtl8xxxu: support multiple interfaces in {add,remove}_interface()")

Cc: stable@vger.kernel.org

Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index c06ad064f37c..f9a527f6a175 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7826,6 +7826,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		goto err_set_intfdata;
 
 	hw->vif_data_size = sizeof(struct rtl8xxxu_vif);
+	hw->sta_data_size = sizeof(struct rtl8xxxu_sta_info);
 
 	hw->wiphy->max_scan_ssids = 1;
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
-- 
2.43.0


