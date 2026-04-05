Return-Path: <stable+bounces-233309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBosFkCm0WmtMAcAu9opvQ
	(envelope-from <stable+bounces-233309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 02:01:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D239CE57
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 02:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EC5C300EF66
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A95217662;
	Sun,  5 Apr 2026 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWtr/nwx"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49913FEE
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775347247; cv=none; b=pJAYm5aZjUvUDiwARU5pnlX1nTZk+kGqlruMleaQHxITYhWoAkrJV1v5vPtaWEHWGe2VpbXkyIH7LZby5y4InS6Rfh0ewf8bZ6IasaoIOFI08ZHqrsIMonvtYbsrsb9IIb+tm1v6AJ+CsP0ANiWHbDAKHRHune6Omhn3XblftaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775347247; c=relaxed/simple;
	bh=MFYXzeV+MYNpZTCQHYFr09VgVSxe+OjOWjIuHtJ6XNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxiFbZ2JaaFfoUbsil0Ud44A70gK8LxUD0I5h6U9cOFLPKjEG1NHDeAyydsWQgyE5FWv8w6IZgz4ruBTl2udiZdf1UDGoMNGnjFHdlFXFf8pBptRZc1Ygfeh4veqJpWb+SJ2KiFYyyNxLVb0lI/jMJET43RPXTASHbZu7tFUmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWtr/nwx; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6058b3ec384so777340137.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 17:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775347244; x=1775952044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbKn6m9xcag5finRPB+a0t10FFieWhhuTYJnUAMc/5Y=;
        b=jWtr/nwx/8x0dlUmH7qnCP9B81f4+x+FiChrUAS+yQPB+xoEsTECO5PjtDN/J9b/ry
         0/976IymLbFImIemHBIZExRvXYMLFGYuo3ANmomUKMzSt80MaSppo53Ml7chCARxGAee
         4oOdV5tsvRZCOSZ/aBAtx3WWnsVEf6tRPnYu/M0BJYQXenxbGcWj7AAyiJognRsaJhPd
         9SW79SLQOY247RRGg4YGah5YCeAcDymI+uyVRYkp0X7P7lO6NLUxJBXAVBk82WDlA5zI
         yQECslWrbaaqmVk81OFC1eynOiSY2HFNaUHSRRm8teVY3YubkdLvluLx2iqaDdaY9Hx7
         lX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775347244; x=1775952044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbKn6m9xcag5finRPB+a0t10FFieWhhuTYJnUAMc/5Y=;
        b=O3paw+lHExj3KbYlYr1HGV0cxowcovLbtZXvKlzZp/Xkv+Lnk1Hpae6E1IRziQBoZe
         oTGV/hT1oA5zoZwmiO34SkKnFaCyD0Rnx5EllVyFsNsjxR/ai1A7YqujDzAfFcMpagci
         Mt0hBd0krzM+kQfGCcPofBHPHxnj7zUsI3Tm72iwt5kO9J0efdjYjsUs8pTDBoZKxh0Q
         W5lR2L41oo0PXFnep0u1MzdGsaAgKfCT7IPUSGs11Iqa/3sNNPZMZia9jPTD+UPpxDXz
         pMpzdWNCIkEGSltn01PILeplv188k/dzHHnq0orD+H7pbUlWDOzwvW1iZR18iMuUdF04
         lPTg==
X-Forwarded-Encrypted: i=1; AJvYcCVum9cONhGQ3EWnm2znKvSYYbyddgB+QVINmi1oSWzpCW2R6N9TaccFphEdZCR6yY2Dd5wT5qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjBApPnsXpCcwG1U1OmRlHaYoYAPzOid0pGYdUiwhAVnlSD7NQ
	d37igFQgJSOqWYkrU1zkAf9kP9ebxAjjH2m3MamEKJOF0qp+qaqGX42QRuJWHa21
X-Gm-Gg: AeBDiev4Fu1VHifN5B0vv7YmOWwqjeWr5Ok6jzEVmKS8d2UqxWn+Bqxy9+zusL9x0Jz
	Y0hl6PMQzb9lQcvxwt0VNzdhKhbhyP7QeGybdTY15CVSCXPp5543rpRaC44Eh7HNgwe50JQuwx6
	0FTtV7SiFaFDG5+nDm4am/y1OFw4EAuZElECbM8T6Gt26kr7iV5ZDtjkyg9xGrNQ9BRZmnoV493
	NY/4E4zG8v6Z5rqpIqM+8ZObFi/H3LNAdSPUhRXHHaU9DUbCi3rFpnOKT7ZvvAd2h/xzJjTVsfn
	w2qWjwV2EOsVUoCbMpfJAS8nWpPp3HeDqFNgEgoQxZVsyS5y2TeVQ5t4Pa7NgAj54/Apdqgum56
	oIHxRVqCJ3XnaBhqgW1GlOGPDBFcYLURAXTBiWcnGjPxbVWCp1tbo9YWmjnaOxE5bwD18PCe96f
	GBqZo9RvPTYqEFugmwUFwGRA1TGsJuuMexsjf1CInS
X-Received: by 2002:a05:6102:689a:b0:5f9:39e9:3562 with SMTP id ada2fe7eead31-605a4dd9a49mr2482596137.2.1775347243859;
        Sat, 04 Apr 2026 17:00:43 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e1214esm11671585137.3.2026.04.04.17.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 17:00:43 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: fix out-of-bounds reads in IE parsing functions
Date: Sun,  5 Apr 2026 01:00:24 +0100
Message-ID: <20260405000024.73568-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404222100.57946-1-delenetchior1@gmail.com>
References: <20260404222100.57946-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233309-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF6D239CE57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The IE parsing loops in rtw_get_wapi_ie(), rtw_get_sec_ie(), and
rtw_get_wps_ie() check only that the element ID byte is within bounds
(cnt < in_len), but then immediately access the length byte at
in_ie[cnt+1] and data bytes at in_ie[cnt+2] and beyond without
verifying that these offsets are within the buffer.

A malicious access point can send beacon or probe response frames with
truncated Information Elements, triggering out-of-bounds reads on
kernel heap memory. No authentication is required.

Add two bounds checks to each function:
 - Ensure at least 2 bytes remain for the IE header (cnt + 1 < in_len)
 - Validate the full IE fits in the buffer before accessing its data
   (cnt + 2 + ie_len <= in_len)

Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 72b7f731d..e0fed3f42 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -582,9 +582,12 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		authmode = in_ie[cnt];
 
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
 		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY &&
 		    (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) ||
 		     !memcmp(&in_ie[cnt + 6], wapi_oui2, 4))) {
@@ -615,9 +618,12 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		authmode = in_ie[cnt];
 
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
 		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) &&
 		    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 			if (wpa_ie)
@@ -658,9 +664,12 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 
 	cnt = 0;
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		eid = in_ie[cnt];
 
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
 		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
 			wpsie_ptr = &in_ie[cnt];
 
-- 
2.43.0


