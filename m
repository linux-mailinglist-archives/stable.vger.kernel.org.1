Return-Path: <stable+bounces-253657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Lz7E2CnD2rCOQYAu9opvQ
	(envelope-from <stable+bounces-253657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:46:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AFA5AD886
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BBF2301067F
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F09F286D57;
	Fri, 22 May 2026 00:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZUIghX7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA644282F3F
	for <stable@vger.kernel.org>; Fri, 22 May 2026 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410771; cv=none; b=DBLqafe8G10cZmjBy7XughYl2g4Pm93VpcV9hI/qOeyB0XIF2oEUBh08Cqi5dgr1E1NpQupOz7YY3hH3lxwam2wJfmRI7sGga3wKlbj5GmgrOpN7WjHTyMAyhSoKu6JZRTWxCrgwxx81VH1kL59UiBYDcSeK2fsofbPzNLCfV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410771; c=relaxed/simple;
	bh=SZ6iIQiWartgOTaRV20kjPJz0KhW6LdfmYVl452V6ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHTslXhTD4V3HGQ8rvjfRcJ9V2wgo8Bxu7kFwenAHD6BeuWrH6ZBKrtE2qLF4QWh3DF5R61OfIVdHYpVtI6HZwYaOmjHnjuG3iRO/DxU/iAPZ1FDOp+VDG244l9mFpTZaeU6uKyY9abN0fvrbNRVBLM1aDD1zkkuxSX5iLBIpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZUIghX7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so2007417a12.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410768; x=1780015568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gR4iXkLc+1Doc0CtFipdBHFsWa2YpiIn7RpSK8c9C0=;
        b=PZUIghX7omzyxwyV7kKDnvMaOTyPLh1iKEPP8JI4LxAEjueG9PXefFU1d47ZYjtWvK
         YMEv6XOBpeUT/JU+Vshd4g1Y+SWw4eSY1r6XJwdAWw2GgioZcQbSew1ktqH0iNB1S+NB
         q6/vqwvbfNnxhAAhk61pCO58aCXEjdiFUMMk8VCNg3NnF8mbmlmkTb0C7G0V3FSyChYV
         Nysdx2/yYUl0bfqmTqODlILkagcPiDBCiEGle6gHGMOTUCORTrre8Nju3+7ACVevIu0v
         cNSjFuURcMhu6rJkLDgkTmiUdTPslYJC+1Vc8SdBD9uIGlhw+wnN2mrhkrjoFA9mjgFY
         dvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410768; x=1780015568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5gR4iXkLc+1Doc0CtFipdBHFsWa2YpiIn7RpSK8c9C0=;
        b=ChUW4OBIWzXp76MtgDhENDMXbu/V1LBiQ1yVvwmJT33EzXAgKmWDdhms1dNA+GSm6Y
         b5Aw2pDGgRGPqSoiLFb6PIVK3aTV7PUNLjLgGTyzRQYQLHjeiVAh+Z4LVHf7l5sw4D9d
         t7nZD6mSlLs3VWFsZqZmXXfHfKcQDVKl0im7Cjk8GI5S8IHTEy2aKP628iejD9oa85BF
         haquSohjAe90xnHp/ySRWHNbzQ4uGWz4RWbIjrVf1QOvL9b4zWG+BHNieuyl8xvAj5RP
         enaZQiOW5KSGttV0cKgcEJVQ5LvVdXf5kVDwGZJDIVCoyMZiFI5B7HGJb5c9nDKQFQzZ
         iy0g==
X-Forwarded-Encrypted: i=1; AFNElJ+sp3+gpC8aldHCZzRSN2UsIJWfXTbf+CPh6IFc7rlEwPLzY1PUdW2M0raNQH7vkRc8ckbR7V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNG77H7eBwv5a3G9Fe5ZrBDzphjDO2G5MPcJ4vY6G5BZxsKeSO
	DJihBZ7eU8H1z4bp1KiCmSF9DALM8Wbpgy/9qvpTVAgpBR+jC+y0D9FW
X-Gm-Gg: Acq92OEtF4ujbzTVWk5qj7a9Nk1ZGe4jkHJTDdj86AHHlAhrDKyKUACj/s/JWvKn0Dc
	4MU3ewqWY8CZgfT6C8udc/ZimwTP8EcbX4tfCSWHm0xSAQhEFj7Jl2VTR7U/Sc6eXaP5ZmWrx6K
	dKWR3OdtWSfThq7qZknfW93Xfnht+Yr4GGtWIl287lvxX/GpZOUxu1IwIeD8UJAqaxh5X2To714
	xxdY8avI3l3oBJeVNNupvcQ29xK4xFjPVwOLEdQ0Xqh4uJBFQjCrNVrwnTd00BncHzfz+sCaCWc
	56/ie5+1hItSv7qhC8Miomt86ftIrE/K314g1Cnlkm6ZLjFGmrJ6IHsl47pxhMU3o6r2iwZb9Kq
	LvJ9txN+NTf6iO23sWeHHw9bq3pKuUmG2XRqkhGhr7MLCXJJV1NaCDho5939oxzoCLPkrMB4+Qb
	+tj9BRg5KAzfdYouhkoIy8DN2zjqBHvfNYGsecBEr3NzMzGynhkP0/X+sMXzdaqziUz9hkRUfuk
	8BkiZgV9DHpZ8jvuetlbpx3uDKKr/33mrKKoyYDIUCyygfok1aCQzYKanidbU5iMRAdGzq46EWW
	Lxzb4nh+zKgfiACnZQJWN690DZCi8bc6/oDamps=
X-Received: by 2002:a05:6402:5256:b0:683:be46:c20c with SMTP id 4fb4d7f45d1cf-6889c475078mr499077a12.16.1779410768134;
        Thu, 21 May 2026 17:46:08 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b72cbbf3sm3535a12.0.2026.05.21.17.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:46:06 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 1/7] staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop
Date: Fri, 22 May 2026 02:45:25 +0200
Message-ID: <20260522004531.1038924-2-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522004531.1038924-1-hossu.alexandru@gmail.com>
References: <20260521130330.754181-1-hossu.alexandru@gmail.com>
 <20260522004531.1038924-1-hossu.alexandru@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253657-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email]
X-Rspamd-Queue-Id: E4AFA5AD886
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


