Return-Path: <stable+bounces-253544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPPhIUgFD2qDEQYAu9opvQ
	(envelope-from <stable+bounces-253544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:14:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C05A57EC
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 753A130A660C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333C3D171A;
	Thu, 21 May 2026 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRs+Ywzq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376B3C76AF
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368645; cv=none; b=DsLKkaobXLmD2v/gxuABUfIBX3LDOVKFVrqUMw0vk0+VsZ6gEGH5FZ1G6GfY8kmUBcxNey0ri83ELQ052ohuX0yLrWcMWMv5UlNO/ugeJVsgCNDVuf95iP0sN9r/ZzUlo8F9kD55dpcokS5hh9avGtgJeqVAm/cQVxFqqlbPfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368645; c=relaxed/simple;
	bh=SZ6iIQiWartgOTaRV20kjPJz0KhW6LdfmYVl452V6ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7A+vxGw5YZPpt/J/dsNaXGHCamBweKcaHrzbRnN7I60Ns6rmKzPFooP1UMUHvNp8GJYIftUWGiS7q398y/8mdxj8lIXnNPEjc8DRSyAtrZIYEKRKDNPYDTiK3K2hkMK/zXxPCRjCCtrn5LDrKQ7F6O/WuNt9JiyVZuPp1Se/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRs+Ywzq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd8f6ef4ba6so877463966b.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368642; x=1779973442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gR4iXkLc+1Doc0CtFipdBHFsWa2YpiIn7RpSK8c9C0=;
        b=bRs+Ywzqqws5XBR3RnZkOAoVwkiJTlsSLGjUK3lstgBXj3HryVQiOoqxdn7pwLeeXo
         NKt47TOYLBc4ji3/1jCy5ZRo3SB4hn29o7ZDdRcxbA8qT0oClzetwXl0HDG2Jucw8bCJ
         vgyZKDWHB1+VTOjyzDP8O4E4b1JpwS6Myd8nJ3HQzZmTT2yqJXbODIsD96FLNLshB7ee
         zSK3WGpK++D7NdcPn1jcttiv7uSzkBKqRvZ6shTEcM8VPkYIiBN9uXIF9jvnIBdt4W7L
         EEU4hPrlQjv+BP4pSoTqoAjmBomdQifB2dNmMGVUhnv2GtZXfe3/DULu98xe39eryWSr
         l0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368642; x=1779973442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5gR4iXkLc+1Doc0CtFipdBHFsWa2YpiIn7RpSK8c9C0=;
        b=ME2Ol+/GcBmjpVzVMNnP12jO4MJOF5RlUc8PM7LblrUMSV9kYqcQ9lgMb11anWvnfZ
         OY7Xgwcfw6xKSaOS+SoGHjLheG7ejCMib40LCeUrqKLGkgaS0u48ildtFYMq1mVwZem3
         bKbNhuIvmup/9ABWreF4uSMI1AZ206Yi8P64vIQW9Wxsx26zHwyxnPEcYbpjmCy6Mj7u
         FIGITaZC5siHxQYE7FpGOXaZKXJebRcjXfG1DyGNkapF0TnisPZoyMzTqO/ZnLaZllJJ
         m7XqUcBmri7dhgIv4w1FjoRxiRaNiprxeYJdQ2UeQkdHN5ovVeNOONnR2zNvWy2lBc3i
         TRaw==
X-Forwarded-Encrypted: i=1; AFNElJ9cX4fhYxeF2SRG09uK2iXdUiNJ5NdfR5cWvBH+wH+Syz5cdw0I1h07PeuFtXCTL4wJl1IrY6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRevnb7y/9cs3s7SkqoNLhBO1pW03/UKMRWz+yJuJMz0xDklnX
	HBoPVxrAWqnrngf+6WsZ2HjtgRWwVyyZMiwVHE1DuQTXL47Sx64fG9JF
X-Gm-Gg: Acq92OG6ARM4+0wt9lvP7R4wu6bhRquWoe0ngZKaV1fFBvqaXML1rzOMo3m4VHWkqDs
	i7htqX16BSe99P2YVuxH2HArjGKjHhbHMAmqR9S8zdFl6diY61ozVPmreVsND/97cLcN9o7Hu6M
	mPg5YcA2R08x+QPuzNqhFgBpUN4nH1agBA9R7JnDq0vBWc50DuTYaV6EwS/jx+HMLwLqMkc2IB8
	sGplfETqwuch1n8DGb/RtsMXMEoMIR6+69MQVnENCC7Um0+lixUGdPgyPhQGHoJxaluGQEGRj8u
	3ILIMsi+KJDzrc+vMtsdqG+we+CJ33QwmeO8XAvRanPQJM6e0DKfm9ouR8I6/ZTBJUecUnKuz54
	78nTrS7Pe71oS6D6By2SXiXdp5R0KrDP+0LUfDQcIUAtzYf1CEWyEgKw4EQ8dAbJ8WSEJTnFm7P
	f34CcV2npQ9TQouUWOZgHVdigVtp0j3d2fHyn7DFLKvrTw5gyVtWYn4q7Z8JIIcroslWVDIYpQu
	4d6x0mdZK3+e2it6G+g9VDCmpDQjqM8G273fRMzEjsAafaVLx29+t6olvNZhNKFrGEaXbq3qaez
	WyDLt5ML0VrTjB9ikDPu368C/SQRM6WXpuMoW/MUECkrWtBMFA==
X-Received: by 2002:a17:906:eec4:b0:bd2:8386:2a39 with SMTP id a640c23a62f3a-bdc16a2fbd4mr165156166b.36.1779368641947;
        Thu, 21 May 2026 06:04:01 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a505905sm43766266b.37.2026.05.21.06.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:04:01 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH v6 1/7] staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop
Date: Thu, 21 May 2026 15:03:24 +0200
Message-ID: <20260521130330.754181-2-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521130330.754181-1-hossu.alexandru@gmail.com>
References: <20260521130330.754181-1-hossu.alexandru@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253544-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 2D6C05A57EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The IE parsing loop in update_beacon_info() advances by
(pIE->length + 2) each iteration but only guards on i < len.
When a malicious AP sends a Beacon whose last IE has only one byte
remaining in the frame (the element_id byte lands at len-1), the loop
reads pIE->length from one byte past the allocated receive buffer.

Additionally, even when the header bytes are in bounds, pIE->length
itself can extend the data window beyond len, passing a truncated IE
to the handler functions.

Add two guards at the top of the loop body:
  1. Break if fewer than sizeof(*pIE) bytes remain (can't read header).
  2. Break if the IE's declared data extends past len.

Also replace i += (pIE->length + 2) with i += sizeof(*pIE) + pIE->length
for consistency with the sizeof(*pIE) guards added above.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 6a7c09db4cd9..e0d73c267786 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1289,7 +1289,11 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 	len = pkt_len - (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN);
 
 	for (i = 0; i < len;) {
+		if (i + sizeof(*pIE) > len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN) + i);
+		if (i + sizeof(*pIE) + pIE->length > len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
@@ -1314,7 +1318,7 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 			break;
 		}
 
-		i += (pIE->length + 2);
+		i += sizeof(*pIE) + pIE->length;
 	}
 }
 
-- 
2.54.0


