Return-Path: <stable+bounces-237898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AINoLYVV3mmsqgkAu9opvQ
	(envelope-from <stable+bounces-237898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:56:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C13FB83D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F2A83019056
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5F33D9DCD;
	Tue, 14 Apr 2026 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlDEIMaY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6ED34253B
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178523; cv=none; b=PE+96GwlTM5GOkrOkUYrkqOAufuMWV1vJjO3preAwKBImiJOub8MdpmtL1mSOLcqnN/JRKnEIIZmmYc9nVyqhSkCH72H8qWUm2xLUc+ValLpYmgi81X5Wq1nbIvUg12sv0cPS0wD8DSuu74l3IbZ0aZAIDcyghivGb270zB+O8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178523; c=relaxed/simple;
	bh=/MwhrxoIu5RZNhD80qK+rDFnDRJTEReJvh+FoxmXEK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmTcHmck07JdaktFZoHH/FGFoHGOlU/9YX6ENrTKG6ejwdF+1cmSJY/ObXoasTrVA8s2t6I56wa6HaMXTuibeInU07utwFZjpnZXXYn7Y0gvpA0npaSEc5B6X5IAk6IApeJM1Krdq8GcMqvmAflJqzGRaAPRPELICmIwlrRb5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlDEIMaY; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9bfcbaa81eso864336766b.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776178520; x=1776783320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AI6lzRoh3NUnk5S17bU5XB84Xw0u3q8VYePy9hi7D8=;
        b=YlDEIMaYrA8vSW3Z+49mCbvE0+vhGKJZ5H/h9w+MB0Kfy+UYSfpzrXtBZFESC4TeZ6
         AIId99f1fBogj8bLvDeSG0xCkGB/GTWQLm8sJDOSptpvC9RTZRRGlXCAJBHLsLQClvOR
         RcQ0Yr8qnxuYzMkAxSU0B+rMi/Rsr8ZHoxbpLvtpehSUMiIa7XcU3fo1UhwBkQtGWum6
         K5G/TOwOIkMBe0/7jg8gLEu7W3yE7g6l9m5qTKIBlS/XWefnkjkQdRjXAH0haMWZndrf
         JAoRCDYuit/iJZq4QJeNCF+5BM/LcSD9uKgbkOkHQ0jU6EK0Ah9qSdiEugkjvB0ekg/s
         /v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776178520; x=1776783320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/AI6lzRoh3NUnk5S17bU5XB84Xw0u3q8VYePy9hi7D8=;
        b=W9eyPCo+M5RMEpkqKxzTS2OIIOm/K0dTuyg30tPlgFwnV8MehLPsgQelZmMB/Ub02q
         87X/rULr8iYpPLTmk8/OwJRedmBVXzDCniRgh8CVOuzXRE/lO67lvQbKOZRiThZ5Hmo9
         Y3pHRaf+Lk/UkeHJxEpKkYyK3NdwqoTlM4na2pYpZr+OYCovZc4NbNSU4ESJy3YiO5He
         qzq4BlLg6fPf5zLOdA09jvg52t2SLhQKHvk+wQEw3f0S4elikFTMITFHvYLMoEBemn5t
         wEzEn424vhdNjE/G7K7MturD7vH3/KXTYzSu7zEa5ssGIjFLI5Q3eQIpnsmvnsDC/Da8
         3K+w==
X-Forwarded-Encrypted: i=1; AFNElJ8M9cnWQWsfVdX7DUvu0t2QL5AF/hcG5b8qVgtZeeRALlhoimWpLd1T8wQBgviqeWNJyZiYens=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9MHvhBbdlQJNnWwEnTa+FgzCzRH/xw0Kv5e5oeZU5gwiTm5XR
	eRiEn6+Mbg/TvwNrtHwG60HBYKn+8kQUzMJfjgjuBPmaViO7+/dq/WRV
X-Gm-Gg: AeBDieuTZ1327ix6oUHURVsT+laReNRyYNTII2yGefBKQABNkaXV7p2HQXhR/FG/g3e
	bKPSB/+2hfTWuqL4PJwu8Om+VWw8LLd5RMK2pd07ckvpj8qQsTifFOtlb1SUYKgqdXQzm0tK0w4
	upqjgPWOj/LRB34QE/VdOyw40viJ36wTOyOqsTpgu0hvLEyKKWOyq2tpHM3QvkB/ffALLZTKdrz
	TKRx5wn7j2Sb2z7pmJhC6DiQyj4pYXsRW4HuOGmP8UHVdP+T8SGxxix2na1gazScoP7/NS9A3s7
	Dpvb1NAR0PlQZFbN3yJAnN8xT86skgd01Z/L71mg2rARux5OhxE1rh4XcoX9fIzbQCXJ9AKkB9H
	OKj8CMWMrMA469Teof55G9FX3658oy71Ot2ojZRVo+gLzmtqTxqy63E7gHcDibPsqzj2aJUn7Up
	0FXEXw7Jim2YzrPtcrDoefCf53t7D6BTbb/ewifPIAx2UHwkbqI0gtl6wAHj7GWHDP+yiL0Ylj6
	GEBLlfAxVpMLiGWiNcjFNWtXZIqbQdxG/+HwqdZ2Dub6QxupZI1w7IgKMsBdQng+gWL
X-Received: by 2002:a17:907:c312:b0:b94:1224:c61e with SMTP id a640c23a62f3a-b9d72792e67mr951642366b.14.1776178520284;
        Tue, 14 Apr 2026 07:55:20 -0700 (PDT)
Received: from ahossu.byod.tudelft.net ([145.94.221.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba0574b41aesm10101166b.24.2026.04.14.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:55:19 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	hansg@kernel.org,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: fix missing frame length checks in OnAuthClient
Date: Tue, 14 Apr 2026 16:53:50 +0200
Message-ID: <20260414145350.903996-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413202824.740653-1-hossu.alexandru@gmail.com>
References: <20260413202824.740653-1-hossu.alexandru@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-237898-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linaro.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 828C13FB83D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

OnAuthClient() accesses pframe without first verifying that pkt_len is
large enough to contain a valid 802.11 management frame header:

- get_da(pframe) reads bytes 4-9, requiring pkt_len >= 10
- GetPrivacy(pframe) reads the FC field at bytes 0-1

Additionally, when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ the
unsigned subtraction passed to rtw_get_ie() wraps around, causing it
to scan well past the end of the buffer.

Add an early check against WLAN_HDR_A3_LEN before any pframe access,
and a second check against WLAN_HDR_A3_LEN + offset + 6 after computing
offset to guard the seq/status reads and the rtw_get_ie() call.

Reported-by: Dan Carpenter <error27@gmail.com>
Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 90f27665667a..884cd39ec756 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -860,6 +860,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	uint pkt_len = precv_frame->u.hdr.len;
 
+	if (pkt_len < WLAN_HDR_A3_LEN)
+		goto authclnt_fail;
+
 	/* check A1 matches or not */
 	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -869,6 +872,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 
 	offset = (GetPrivacy(pframe)) ? 4 : 0;
 
+	if (pkt_len < WLAN_HDR_A3_LEN + offset + 6)
+		goto authclnt_fail;
+
 	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
 	status	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
-- 
2.53.0


