Return-Path: <stable+bounces-273367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iIAyJyjtUWo5KgMAu9opvQ
	(envelope-from <stable+bounces-273367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 09:13:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3646740B32
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 09:13:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=jzIllUFW;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273367-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273367-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08BA0302D4C4
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 07:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147743749E9;
	Sat, 11 Jul 2026 07:13:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464462DCC1C
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:13:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783754019; cv=none; b=I7oabHHLL0+zgCxY9MoMjyXJs58/5ZTdcN0W1I8FiqqQEOHm+6Sv6kIZNuW/MZU9oXp2HZxndqnrmXS4tyZ4ZCBQdjlrovX6ZaPX5YzIzGZtMFMnUchdSHoTHMZPVBiJ2CBY3fOZ1dYMPHFjPjERnWIdg2wHHLmK0ChCxmAV/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783754019; c=relaxed/simple;
	bh=l1nTEnW4tyVLMirJ9chs6xy2eJk5XwYVLCldUleOk3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQOPbJU12Yl5ZVDs8Buz1EzD8NwsqlxGHu0+ugPEK3Cwyz0foM9PC+jzvftXLUXRZlhxUWbOvJHH52dE0ljJTK1YocBHnNqdsqGqnZwuLz+NIfGc1BDvquSDbSjs64eS0I4JtW+yr0mc0ZnvHLqXeMI0hC46RulTetJEM9jnl2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=jzIllUFW; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so12011465e9.3
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 00:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783754017; x=1784358817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uMdRysv21XDV5wd6Qo9vGpr0v0YkiSkKSKqPPMpdIJo=;
        b=jzIllUFWy6DEXeh9nBq7AxK+Jh2qaQ8+4z0zUEjnyZRWxtne/2BUaj0yEzeo3uLyo0
         x+GKq+asIUC7PXZoFCGAf8OpfTczZ/QYaawStRSyvLq7qGMw32B9w63GeIwgHZtm9zyy
         Kr15x7uBVXhNI+I+cBy9Ysy1qesFXV66k9UYpBngev7/rWXsdNDH6plKfqTKsoq8e1V6
         S2oHjusZmNdfXhx/xH83CVgHNCL92/0YesS9ewLKpUQ1EXx7cxqlXkIWHoJAcLlNQhwf
         I0wRfuQ4bb13C8RVlDIvJiorwRutKcAwOI1G0dw5dHrWtxM3qkap9dtxxKC34Tws2wma
         FFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783754017; x=1784358817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMdRysv21XDV5wd6Qo9vGpr0v0YkiSkKSKqPPMpdIJo=;
        b=Fhc9JztzqpwsxV5EpZZEqmYpyzx5WFzxaTx857FdOreeH/mYHtk64bgV4wn+mbMzmN
         9DlE1TZJC4eCRGaEpij4uEwQJsFLjgIeob8OlbUCRHLW0tX5hiMggcRmqtEyGJYXGX4c
         Z92qfe75aZhKc3SsUmDOTOwI4ZVRd/cgFAr55RYQrIoIyVorxNIm6yswzE+GT1CYCWL0
         hoR+t/vw/CZlf42H+rv2qqP6vbi/kJeXMG4bq7LmTCbxbI/p1dG1ZHfeO3CxA3ocXr6n
         nT3TSvT9ASFWL3iEyEF1sRb7VeW9sneo9b4/wdark8rEw19VuOUO6XHCEvfQ6625aWme
         bVwA==
X-Forwarded-Encrypted: i=1; AHgh+RpMCCxzLyt2C6bgV/OlDLDuDFiBMaZMsh26BZ+lTdRT4H3tj54IgAgmDyO6ecIRk57y3t5jEqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fLT7mq+R/XwZ8uvn084J/H0SYmQRNBi7NLwXIHTZerIUY+vi
	NePhM8tcQ13luHQneKjDD2sEzlABs1Tn6E34Qrj/Ar/MHNXu3fu5k9JnTMzkZHQ3z6oP
X-Gm-Gg: AfdE7cnCe69EjFnoYntezffNOwnFwPjpZ0w1qx/DLyCdhqUiw6r9/YUJym2KqLUh1t0
	eUlIfT9NG8m0zgP/6UwqKI9U0MMnpFNc6kX+XGq3dqY5Y/MkV6H3PLmxFgexz/yEHHVAivOlyS8
	VdqixJWZASzmGIBIOqv27CQp1Ze+dKJp4yTkzwlXG58ewF0vdGvmcYS+zYXk/34SiYuPRplM6Jy
	Sb2dULlMcs2QQnu+Jvg6RuvRsHgCTvkkRofT1oj7MBy3T9fdfgXpAsnsEJlclxfpkXY1SPTpZsv
	zK2M71z38uOJalGj28/KZ9KtTE447Tbectlyp1U2KRSxDQKOzOPi06M8wgQ6a/Z5Mr/MZLrrTMw
	fdgfEtaSGIe9qx6LI8Nj07LIFrLaGoxDhFEs9Fk4JZOfxPCF2P1kRgpnMAChNfBgOVTphAYOVq/
	iC+7O+wtssUy3jucmXpgP00Qtght0L0PVdeQ8pFi3CxktD1dbz/l0rp1SsV5gFjiu8fhkWb850s
	RbmXk4IyCWZwJMMVDzQMmnUQbWrshUwlUs=
X-Received: by 2002:a05:600c:6387:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-493f87d8583mr17156215e9.2.1783754016569;
        Sat, 11 Jul 2026 00:13:36 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f373csm324565475e9.14.2026.07.11.00.13.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:13:36 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: bound the pairwise-cipher OUI walk to the IE length
Date: Sat, 11 Jul 2026 09:13:34 +0200
Message-ID: <20260711071334.58307-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273367-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:briannorris@chromium.org,m:francesco@dolcini.it,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3646740B32

mwifiex_search_oui_in_ie() reads the pairwise-cipher (PTK) count from a
beacon/probe-response RSN or WPA information element:

	count = iebody->ptk_cnt[0];

and then walks "count" 4-byte OUIs from the element, comparing each with
memcmp(). The count byte comes straight from the (attacker-supplied) IE
and is never checked against the element's own length. The callers admit
the element on element_id alone (has_ieee_hdr() / has_vendor_hdr(), no
length check), so a crafted RSN/WPA IE with a large pairwise count makes
the walk read up to 255 * 4 bytes past the element -- an out-of-bounds
read of the kmemdup()'d beacon buffer, reachable from any AP whose
beacon/probe response is processed during scan result parsing.

Pass the number of available IE bytes to the walk and reject a count
whose OUI list would not fit, keeping the loop within the element.

Found by 0sec (https://0sec.ai) using automated source analysis; the
unbounded count-driven walk is evident from source. Compile-tested.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 22 ++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e..3a55fc6f1b54 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -104,12 +104,21 @@ has_vendor_hdr(struct ieee_types_vendor_specific *ie, u8 key)
  * a given oui in PTK.
  */
 static u8
-mwifiex_search_oui_in_ie(struct ie_body *iebody, u8 *oui)
+mwifiex_search_oui_in_ie(struct ie_body *iebody, u8 *oui, int ie_len)
 {
 	u8 count;
 
+	/* Need grp_key_oui[4] + ptk_cnt[2] before reading the OUI count. */
+	if (ie_len < (int)offsetof(struct ie_body, ptk_body))
+		return MWIFIEX_OUI_NOT_PRESENT;
+
 	count = iebody->ptk_cnt[0];
 
+	/* Reject an OUI count whose list would run past the element. */
+	if (offsetof(struct ie_body, ptk_body) +
+	    count * sizeof(iebody->ptk_body) > (size_t)ie_len)
+		return MWIFIEX_OUI_NOT_PRESENT;
+
 	/* There could be multiple OUIs for PTK hence
 	   1) Take the length.
 	   2) Check all the OUIs for AES.
@@ -143,11 +152,14 @@ mwifiex_is_rsn_oui_present(struct mwifiex_bssdescriptor *bss_desc, u32 cipher)
 	u8 ret = MWIFIEX_OUI_NOT_PRESENT;
 
 	if (has_ieee_hdr(bss_desc->bcn_rsn_ie, WLAN_EID_RSN)) {
+		int ie_len = (int)bss_desc->bcn_rsn_ie->ieee_hdr.len -
+			     RSN_GTK_OUI_OFFSET;
+
 		iebody = (struct ie_body *)
 			 (((u8 *) bss_desc->bcn_rsn_ie->data) +
 			  RSN_GTK_OUI_OFFSET);
 		oui = &mwifiex_rsn_oui[cipher][0];
-		ret = mwifiex_search_oui_in_ie(iebody, oui);
+		ret = mwifiex_search_oui_in_ie(iebody, oui, ie_len);
 		if (ret)
 			return ret;
 	}
@@ -169,10 +181,14 @@ mwifiex_is_wpa_oui_present(struct mwifiex_bssdescriptor *bss_desc, u32 cipher)
 	u8 ret = MWIFIEX_OUI_NOT_PRESENT;
 
 	if (has_vendor_hdr(bss_desc->bcn_wpa_ie, WLAN_EID_VENDOR_SPECIFIC)) {
+		int ie_len = (int)bss_desc->bcn_wpa_ie->vend_hdr.len -
+			     (int)sizeof(bss_desc->bcn_wpa_ie->vend_hdr.oui) -
+			     WPA_GTK_OUI_OFFSET;
+
 		iebody = (struct ie_body *)((u8 *)bss_desc->bcn_wpa_ie->data +
 					    WPA_GTK_OUI_OFFSET);
 		oui = &mwifiex_wpa_oui[cipher][0];
-		ret = mwifiex_search_oui_in_ie(iebody, oui);
+		ret = mwifiex_search_oui_in_ie(iebody, oui, ie_len);
 		if (ret)
 			return ret;
 	}
-- 
2.43.0


