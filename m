Return-Path: <stable+bounces-253663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNgnEaynD2rCOQYAu9opvQ
	(envelope-from <stable+bounces-253663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:47:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F045C5AD8C8
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2729B3023E69
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BBC2D8385;
	Fri, 22 May 2026 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9/BrFbW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC712C0F91
	for <stable@vger.kernel.org>; Fri, 22 May 2026 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410790; cv=none; b=j2JtZ4dh1+LI8poWGLVmY84FeuujrIAC1xvaRGmIS0uJmL8rbOTS896gE6U/wgFKOQvcWgkO5miSXWdISRIRnQLR9tKgbPi3+MQuVhelqxgLNZt5OaWBRV4Xo290HvN61E6eMEiX9oAUgjiBEmZ2Pxn/AAhcWHBZ/pYzNW8AILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410790; c=relaxed/simple;
	bh=Y/az4SiItbIAigjIqxrH/7l1AsFAjEqLedDBBPQ3Rrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1A6BRmLtkfMrEXYr/1FHdqY4LPkwooYyw9XjWiZSBeF81QQE9wgH0+2jnCCCrlI2/nJncljaPifQmvsenUYhxXxeYOe98gHUdso1z2y2FwLg8oPEkPQiGxzAwdxbYgErYVz89mc0CkQC5d05bWnISohQv5K5LyAefvBR2UrrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9/BrFbW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso10956694a12.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410787; x=1780015587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7XmRtRI1sy+uE3kBDpqO1yIxY6jN1aO/VOWIPFqnmA=;
        b=G9/BrFbWlT2rrT2eS4Ovx/ApaMT3Mby42lgWKb3Z5CcqU2eaG1QV8EonhX7Tz7dyzg
         EHMCJdMdyWFCB424uJZ2/RBPJSfr5hS5cu5yOPWyhFWepRkSPALSLfBzvymNX4BbWAOx
         MBde14Sv0AcAzzBWASSf6CmpcPxzJmJ5uRVanQ/eEAkyp1fD9k4rghR4AXcA8oxNs/3H
         WprFOXqfPXzYJRBIdPMFUEFMXuZZFAYXr7TR0Yn+/Vv3KNMEfG+8fSy4x1cR5s7wAHGs
         lMATe6pv/4ELlZCzcfERzyQJOqcfUp9TcygGFWGuA/3RDxdIeVCASl0w0JCxjJX+iuOd
         b5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410787; x=1780015587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7XmRtRI1sy+uE3kBDpqO1yIxY6jN1aO/VOWIPFqnmA=;
        b=CHZQpNZo+2BRr1EQGOkIdMjLtge6Td5Dz3LOMhaLWXzrSUBpJQ1h8KHrl3zn59+oTO
         ce7YRLOQH6nQneJNZorxsBZFVgS1cpu5JaQGUoBF6eSUIZtYwE9xIhk+H/epwb1jDVHv
         XMZGpkljqtreAY08xOKCVEJMBNEnwtUR/gmsY5gnXNoqnvW/XfOS4TeNX7luK69CAwBA
         lvnaTmxRBmwSheDO6pelrB7bd663njQoTjJepPije/JGKeFO9szgV+drTs6agl4XFqr8
         kkDrrl/DXolHo3VcHjmi2sajWNfCQGSKsf2ix3YfX6Kvpbr/7zRGCPQBt46i1SXudVU8
         hklw==
X-Forwarded-Encrypted: i=1; AFNElJ9I5Fwkv/+lxCxva5b9WCQpb6J7Jx6cdV6SdVNB2g3z36nH9v+uaZWzMVgKxNm2FhWEam3Vku8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCSCSwaYie+yVmzrrgSobzn+fMSRRHscNS9n429EXNmlZO7db
	9lbSVR5Thby5faICwO2RmJZ6MURIIUF+ZBHDnW74uHYEWqaJi1uY2mUj
X-Gm-Gg: Acq92OEKVayvO+eL8jr7PTqHX8ZWxjsNpGdTkpWztMlGZVuUnKPlmygYFhzdMy8up/1
	5n9D/wWf2gSrMAslubUoRtI0a25F59ctNtbKbSrrtdzw3ZSS8b37l+Lsteks7Dzx0aiuEYAjSHE
	z6BwKt44Hc20r9j3E8lbsEacBFy0ebHo4crTQCH7SkecOS6uBXb0S5GqiYVw7kyizetP7v0sf86
	gyflWqMRseD1Xd9cOeuZLacQm9ct52l0/zoE07CYAEcms0El0jSHCrg6f327iPoXRfTSqJ8t9Dj
	JCp98oyz16H5UotIoGBNl3oLe316/+MGrk/M87UjXBCc73bhi4a6WtuD/wuVFkQPszyn5p8YZXM
	oopd3tw0YGRTtJ2PO4Futuk6BqgMJyldakFUqy6NclNDOdEKyF5aPRCF9D+cBEP+YNImeliY1rX
	uZz4dj/3c4GbQ44MyMtAc2Hv/wYU+pBRNl6Lqg2xO+Hta9pDLH8vAkD8Mo+edrkEiyXBmJEeXIX
	ezhQvpayOaXDhQXToJeAAud8aXAmqsJarUqAHTOurkb0NUuP/riw6VTtYPKdGMbL1+xNnxlQngF
	uE4gbp3oxVGnRe32NO8ZgbmEHDw00Gok4xIotN4=
X-Received: by 2002:a05:6402:d08:b0:678:a507:e837 with SMTP id 4fb4d7f45d1cf-6889c4080a8mr560571a12.1.1779410787257;
        Thu, 21 May 2026 17:46:27 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b72cbbf3sm3535a12.0.2026.05.21.17.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:46:26 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 7/7] staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()
Date: Fri, 22 May 2026 02:45:31 +0200
Message-ID: <20260522004531.1038924-8-hossu.alexandru@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-253663-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F045C5AD8C8
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


