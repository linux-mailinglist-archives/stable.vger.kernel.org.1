Return-Path: <stable+bounces-212807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPZFJUSke2lWHgIAu9opvQ
	(envelope-from <stable+bounces-212807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 19:17:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1982B37C5
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 19:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3368D3058088
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45A52F1FDA;
	Thu, 29 Jan 2026 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0LGEX1n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728C2E9748
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710570; cv=none; b=EqxOA6cgviDsEsg21dgzTaeOMMIOEzUS0w1NRUnzwHHIoQAfZmSY4SrhkWtam5jTpdRkBQHd5PDafr1aRymV3dEmqNR9iYur2W3zZypmCsz6wcNtNs4UXTzYyDU9HtiPG2dY3cfs2LdyyotVTeYZMDLMR3dKRWDvTVmRTwDfw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710570; c=relaxed/simple;
	bh=anusSg+ei2G8pY99kSNGBiFGkxTuVaDv4F/ejqaSEKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjCB4fbFtMdjuGywNrhGJ7aopt5fon+IGfm/dH6YJg8hxpVoGQTsmvSVL4kV+HzacpK1abuf8ywxLBZuDvhlwLTYNSv1KoMrES0g+0jDEVPZKwKfjRw7n+TYv7693vbz5aPyT+fFtBztKMDUVxzlw3NwzP7JSxTx78cfPuRezTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0LGEX1n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so12975395e9.2
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769710567; x=1770315367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkmQJfRqTQzrHHgjjnSwxvqZrCWnUDQPc30Wk1HVPk4=;
        b=k0LGEX1na3lo3P732hXVTAUHKW+aQG5Qc/hJZryrvCM87ON/dBBfi6cb2zh41ZYVqR
         ZpDMfom5nQzLIEFSe/YjjOdaabDSFuHCfYdwthStUicuG9hgjeh7IdVcRDIPb7V1zdlF
         spmXIMO8VY1RB39DnpVcdhJkJsT5+KFfDCoid85J+8w7SkRDz0QXR/Q/Ouu/WuUrP82c
         MgmUJycBHK0ZVOzjMv/66CnwoKAZhg3TMqQkdPnxEqaXPjssEnQPLrU5KAvi/uOh1L5y
         aD+qe82/1NdlhYefVsbfWnwT9pjduPpY4YIkuHYUvbxgEpt9YnJY1er/M2+V5DQMeJai
         BE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769710567; x=1770315367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YkmQJfRqTQzrHHgjjnSwxvqZrCWnUDQPc30Wk1HVPk4=;
        b=L6o7L85iYCgIsDmFy8VVSszcmznD5Hl+OwSGB1RmItjuhlsKhtOCdWFELm+yPlAe6d
         iEnmQrDG44EC/tameawoOzt7xPmRsQPp3qksUi9otze0EI35ps0XmOl1paa5lU2kBCAv
         PbzPuHfG7h8yvJyZkHvKFW9WmfGibftKB+xf4iLekC6zBTiq0FiL8jObrEoJ6JVn1shB
         nf7MpJG74A2KRSG2aL1rGczxhBErOFeft/m3wokPwCHWtz7HzI0UeDFSkFYecazygncf
         0JZv0wi9S5EuQZKHB+X7x3c3pqKKDi/+WGTSG0YqqMUIliUgOq0oOxcgjucaTnj0kv0n
         j4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWdXoFA4krK9hWNpy32VqfOfW9v2vmKjE+82EHXfdLTrzKeOcZpVATKgMLoXN+Pj4zMq6BnTbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5necqikP47VbB5Uaitk1Xh2aelj126PtkEzVLOi9ZpMNfgCn2
	Mk2b+N8+XsDvBxEqPN4fe6iIWwbPKdFSO7Tp9mMIu7yNHXpwCmVxol0=
X-Gm-Gg: AZuq6aKDC7GCeGinSeRAf+E0POxuEd6BFJhKf+EcvO+cLgliIUHiCHZvs/XhUTENDKY
	/5SBFe1RGC7BeN0lGO54mm9pJk9zv5TRWsdAZPFlKClMdKu8cAkSofCcOFRZXNL9yjdGgHsin5D
	xwAL9TYzk0CbklTYVAgA7hxpxkPIE4zPtxMALyWx5F2yGZsLmJg2foHkkpcjAoGvPboeDee+ZwN
	ugXnWhgDdzHj0G8h+hUYc2mFpZBX7ManU5IzYji3RgTls9ykHnpJMavTfUSGbYONZUPTAgrKj5B
	Cdny/5NxHhOoLaJ6IKlUfccKjw3f4Q2AQt7nlfDyqPZoYV0adQB18zbb5HpQ6dS7emhfae13xc4
	rTkAwp56sHc63APv/5zi/3H5qg5stVeHCGrlE7hng9c702eljg1Z2NPfIrOb0Otry/l3tDaGDfR
	2D
X-Received: by 2002:a05:600c:4443:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-482db4a1030mr491635e9.32.1769710567195;
        Thu, 29 Jan 2026 10:16:07 -0800 (PST)
Received: from LGPC ([31.223.131.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdebf86sm136578725e9.8.2026.01.29.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 10:16:06 -0800 (PST)
From: Luka Gejak <lukagejak5@gmail.com>
To: gregkh@linuxfoundation.org
Cc: straube.linux@gmail.com,
	dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luka Gejak <lukagejak5@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/5] staging: rtl8723bs: fix potential out-of-bounds read in rtw_restruct_wmm_ie
Date: Thu, 29 Jan 2026 19:15:37 +0100
Message-ID: <20260129181541.72066-2-lukagejak5@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129181541.72066-1-lukagejak5@gmail.com>
References: <20260129181541.72066-1-lukagejak5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linaro.org,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212807-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukagejak5@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1982B37C5
X-Rspamd-Action: no action

The current code checks 'i + 5 < in_len' at the end of
the if statement.
However, it accesses 'in_ie[i + 5]' before that check,
which can lead to an out-of-bounds read.

Move the length check to the beginning of the conditional
to ensure the index is within bounds before accessing the array.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")

Cc: stable@vger.kernel.org

Signed-off-by: Luka Gejak <lukagejak5@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 98704179ad35..7dfc2678924e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2000,7 +2000,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
+		if (i + 5 < in_len &&
+		    in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 &&
+		    in_ie[i + 3] == 0x50 && in_ie[i + 4] == 0xF2 &&
+		    in_ie[i + 5] == 0x02) {
 			for (j = i; j < i + 9; j++) {
 				out_ie[ielength] = in_ie[j];
 				ielength++;
-- 
2.52.0


