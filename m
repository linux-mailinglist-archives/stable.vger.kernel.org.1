Return-Path: <stable+bounces-253550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG37I6gFD2pzEQYAu9opvQ
	(envelope-from <stable+bounces-253550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:16:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EAE5A5858
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FAE7305D95B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090BD3D6CA3;
	Thu, 21 May 2026 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdeACu2c"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB093D6462
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368649; cv=none; b=OGdKC9qOFHy6obqJ66H+dYctOCZkNa6XLYwh9kET8+gt4cN4wRa8T/jljA3wQb3XxImTR2MNKoZlngZAELp6J0eqFR4Wfo4NuIaj5yowCjOzbXK7KNy+d+mPEY6U/M43RRE1s8arijxo28EIeY3+r3YexYVSvtW3RT9MsRXo7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368649; c=relaxed/simple;
	bh=Y/az4SiItbIAigjIqxrH/7l1AsFAjEqLedDBBPQ3Rrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtO7hkE/aPASIC1Wk/QjynOSQvVB32TQXzx6UG+SxxdgbftREDQ3XzD9/eqJ7GbTVqfNvqetvi6MxuZl4k68lsvPKUMBR5JQkPpNnUX80BXE0DJcQwqEDeA43krLyFDdKSytioj2krEajIbtVvrHpX74O4zhG9AyMkzXgbUB6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdeACu2c; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso10055313a12.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368647; x=1779973447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7XmRtRI1sy+uE3kBDpqO1yIxY6jN1aO/VOWIPFqnmA=;
        b=fdeACu2czjFyqg1Za963ng6EnXNDB7sXj/EVlH/IjWXYvrEJuwYfcikwnhzHC8A1IJ
         cqgYaACsxlDDGhH5VcSHfmuDtB4H6ymoqYgXBnN5zQ8OiEpm/wb/0M+HxwTUlYLoqBcA
         IP2ieUFa/SD+OVnoUnL31uw6ex21C44nMFBHB9N77W0Yro6bpnVU4Cg8cNplUrktQLvZ
         GDY77+P0OgONQ9aX2k/rfVG/LtfCUWD7hFwsabofYqctqgGVu9vU3qE5l/YAZuEso0GU
         O2jMgTEAQXyxyvC0EEl5R/FXdIbeHo625Iz4XXrU1VAyn+cQsuy1oaFd1tis4YxrL2m0
         u8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368647; x=1779973447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7XmRtRI1sy+uE3kBDpqO1yIxY6jN1aO/VOWIPFqnmA=;
        b=XcJkzlt/EjHww8xHCUuQ4/QMJfekco5pw0OIIisEZWHfaN5KEsj8c68MdiH67Q1JbZ
         uTolpwuXPyFgrHV+6VjWELxaIelUakan8jlh8aP3LDtlgcZKt5picYbk+yykxHrnA5K8
         ygi6NpDILSh9FLeQlIIJB6M1X+Ilf8JCda4pi7+RWDMdDyiinvia2/TIUP8kbJrLpTP2
         5dFMtP9O01Vfja1sYbNMSJ4hV7xIrUEsABbSls4lqkFvfypqUXLvwBhnQ1F4eQFDqTtn
         aM8HaMpZvTER6rrTqVOR4laujK68BeV95vt8RGorzzPxtDhcazdSEpSLjb2QN/E0U4wc
         30Eg==
X-Forwarded-Encrypted: i=1; AFNElJ/ObgLNYY5aFOCYIjvG0y8/R6ZBWcP78WiDlc3yNSIxc0DH60ouvUk4KJL0eXeQNN/KrxqYi0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyff6sAzEVF9SVG4EJHzyss1tCFDuOf4+KOsKxTTggVFqQsAUXl
	IfqK1RD40HMaG6XMinwYXkGjSwpG7oLz/mHC9xb1IzHdGO4h76XjepTW
X-Gm-Gg: Acq92OGeCD43isps4XsskZ2RNzw/Sie8AaQ0Mnn61KT8ZxkHbU2DCNKTZMd+GdfunPi
	yxG8EF+UL1EGPkqH0NnG+VPHgFtKmv0o/iOb3vqBpr3wgeBzGVqzGYYjoyI/gW+FwXHajP+R17G
	OpVYRnNAaw7DkdygfUniBeTgUZCMIbVECAsso2UcFMHQNnCtfSMlU84CFbOe00tHg743/cp4vlN
	KW+5qzJCBMIMI9+nvxyVnu4PO7efQhACawkKFLv/w8FE5BpbQfb8A9ntBChA7gepLwpBg8Aotvi
	FJrW6BzAs7ozmu1rDH12zOfWUzTBdRm3VKST1e0++v9epjP43za8I55/NOqHF2Mev7NnIry17we
	BSefssshh0sBUMnl3X0FmsZu591DlstApK14X3Yoi6YwY05j78Xe0jcKzIGStD3WCUCUCOoC6o1
	mkwsFTI5tvpekfABRZFjLpf0M7gQSYgjlD5WGn8ADs+omHHjTm0+5fuQlcOv2gLF81R6ujnzaJJ
	t8lrMouHwJPUEb3l3CbD1gfiko8ye3WrtG2NZqUQfWNkh2IYl8MfJRfBKw0s1W/GFPoo1I4+kdZ
	Sa6b3c0UcOs5oHB0+8VmaOszJVmd95dTJgyV6BY=
X-Received: by 2002:a17:907:b19:b0:bae:456f:fbb2 with SMTP id a640c23a62f3a-bdc14b5e8a3mr106428166b.23.1779368646487;
        Thu, 21 May 2026 06:04:06 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a505905sm43766266b.37.2026.05.21.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:04:06 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com
Subject: [PATCH v6 7/7] staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()
Date: Thu, 21 May 2026 15:03:30 +0200
Message-ID: <20260521130330.754181-8-hossu.alexandru@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253550-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 34EAE5A5858
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Three IE/attribute parsing functions have missing bounds checks.

rtw_get_sec_ie() and rtw_get_wapi_ie() iterate over a raw IE buffer
without verifying that the header bytes (tag + length) are within the
remaining buffer before reading them.  Additionally, rtw_get_sec_ie()
compares the 4-byte WPA OUI at cnt+2 without checking that at least
6 bytes remain, and rtw_get_wapi_ie() compares a 4-byte WAPI OUI at
cnt+6 without checking that at least 10 bytes remain.

rtw_get_wps_attr() reads wps_ie[0] and wps_ie+2 unconditionally at
entry, before verifying that wps_ielen is large enough to contain
the 6-byte WPS IE header (element_id + length + 4-byte OUI).  Inside
the attribute loop, get_unaligned_be16() is called on attr_ptr and
attr_ptr+2 without checking that 4 bytes remain in the buffer.

Add a cnt+2 bounds check before each loop body in rtw_get_sec_ie()
and rtw_get_wapi_ie(), guard each multi-byte comparison with a minimum
IE length requirement, add a wps_ielen < 6 early return in
rtw_get_wps_attr(), and add a 4-byte bounds check in its inner loop.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 72b7f731dd47..3c1f0068cd92 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -583,9 +583,14 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
 	while (cnt < in_len) {
+		if (cnt + 2 > in_len)
+			break;
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
 		authmode = in_ie[cnt];
 
 		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY &&
+		    in_ie[cnt + 1] >= 8 &&
 		    (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) ||
 		     !memcmp(&in_ie[cnt + 6], wapi_oui2, 4))) {
 			if (wapi_ie)
@@ -616,9 +621,14 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
 	while (cnt < in_len) {
+		if (cnt + 2 > in_len)
+			break;
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
 		authmode = in_ie[cnt];
 
 		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) &&
+		    in_ie[cnt + 1] >= 4 &&
 		    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 			if (wpa_ie)
 				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
@@ -699,6 +709,9 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 	if (len_attr)
 		*len_attr = 0;
 
+	if (wps_ielen < 6)
+		return attr_ptr;
+
 	if ((wps_ie[0] != WLAN_EID_VENDOR_SPECIFIC) ||
 		(memcmp(wps_ie + 2, wps_oui, 4))) {
 		return attr_ptr;
@@ -709,6 +722,8 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 
 	while (attr_ptr - wps_ie < wps_ielen) {
 		/*  4 = 2(Attribute ID) + 2(Length) */
+		if (attr_ptr + 4 > wps_ie + wps_ielen)
+			break;
 		u16 attr_id = get_unaligned_be16(attr_ptr);
 		u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
 		u16 attr_len = attr_data_len + 4;
-- 
2.54.0


