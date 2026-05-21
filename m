Return-Path: <stable+bounces-253549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAW7J+oFD2qFEQYAu9opvQ
	(envelope-from <stable+bounces-253549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:17:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5514B5A58D6
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DBDA32A578E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533DA3D5C26;
	Thu, 21 May 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdOpJgFJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE13D567B
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368649; cv=none; b=WV+qo3fBPAcPN7sFi1pWHS094InIGdh49hW3ifYzzSut7GoXF6msXE2d9AMiY3KUV0Sk3HrmBRKdvClvueUdfmZiIl+pwBkpjdkOS0NBxIapewJidZfxmDhydp3Pa9Sh1+bpaHVyqBqtbWzDZ1cdwuhZK00tPwwsf6ShN+AhZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368649; c=relaxed/simple;
	bh=7SsrYMKDh9rt+9N6EF+fS9nQeI4YX7vkrI18oJQsNRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGHf86Czsh+67XYqNSUz80c2GwvDGBmEp2SJFhORAICk7ZNwGA+A4+xKrl8DKodeHQ+Dr1IuzGa8BVv4JIYe7rIhVvjHIVqJ+ftS4BzXugPbndQrAZobbul4wDu5eVWGvGzljYA1V/NyWWsNtTp/opq+LFWfZ54MT9MYnflpp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdOpJgFJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68707d88626so4806903a12.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368646; x=1779973446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMABQ2lm+8Apo5qMdLPjApIQTOzncW9oYRbW/a64Ly8=;
        b=JdOpJgFJMinAGANFUcibtUZsCHD8XjLxEd7/xBTedsI06fPvdvqYebzGJXXVb5Sh+3
         JsDu1Gwi0PYPtCmPZyNvbJNbe1gixemUVuTKjOdmZNNL/vPIv05QWG5Nwz+cv2W3+gbJ
         8I/xKtwxeDrzf0Pq+Np1KOq9KsKdHoRUTALR2p2hKPZWYIMGp+DMKNPUTrb/MNnSmXnE
         X2BaGvGiRb1HJfZxBfuUaLaOGXp5TTIL4ncFJHNDfgceIh1DQC/REDvwN3nPiM4uHDYR
         goO0INIsrxuib7mbpuqm6WKIPS07Cw1RCMzct4dvuc/5szNFtEZEsO9iBFjqMUaBPQnZ
         utHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368646; x=1779973446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMABQ2lm+8Apo5qMdLPjApIQTOzncW9oYRbW/a64Ly8=;
        b=sygNgAb8PB6QZg/+I0U9E8F9trKkux4/OWCde6qSiUG32UXstkt2zv/n7aETQcIIAc
         xTSWUmLOUcUFxMMuz0LTF5GYhTAh+nmRdu7eBFfEPwa+NQfoWFBL/2b2HjPSVKSua1Dh
         VqCtI6BpRNM71Gxwp7H44/1GwTqVzSHgmEC2BWmKlmTM8mHILI+8MI9F7C9I8ohWAL8G
         Ud7ZaWPhhYf8/FqVz8EU0O3ehYRxtHbCkK2N45/NtFDJxa8AUMqevJ/C2A8GLEydIy6f
         Y7WjSUICHkL1mzcxs55RnoxB1y8dX7wDjSBgZxSEWSLbGx/ykwVnuzI0yGPPb9N7Mv72
         B4MA==
X-Forwarded-Encrypted: i=1; AFNElJ/VSJztLYjEnttYD7ko1r1Iqrc4NFXRW4aEAXD8jZ53lEPqxhCJKy/ZoiYQxnML+UgWsSCdfsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgHevNbZg/M5LfABXCCDQPcqALCyMVL0/BBSE6M2n61VlZnKT
	pudMn4vkeN/IOWC603AsDR3i+30FxaUB0ioEg6JroPNIyVTVS7CFWKWp
X-Gm-Gg: Acq92OE/rFF3KB6g7+3Io5nkcb+7H5PgnOTBoPQGIckuRJ4NyIz21s1XfmD3JX8q+8p
	Pyv8d4uAL/Vwij2dIS960RprkLzbSN2a61o69w4umj0qmyeuizt8zC31IGdGv+eiPtAVlKzqgDT
	2CVTSjsDdrO6k+FH3N4Pz18aQVDQN6HR5yYekzCxw/Upq+QvxpWNOuo+ABx4GKzbQhvNopKhQP3
	XAglf0l2ZH0+LOs6U2VPNhiFZLtnR+cQhOsjBqo6bpm9NW+eGddjQcP1XkjClNNvtzK914Ycz3G
	9pZ+BRqNMKdeYFlk5lO2itVeoR4pp2a/UP8Kg8HbHWWnJCb195R7Xreu1zXnAdRrfjMp/JLrv6A
	kho2CAvb8FgEv6mjhxfK+SyiCtlByk8drpQwO9GSUuc7ErAK583J/p8ZbGzpKookHXE276Qqjq5
	JBAq6D3+tZb322NoSaWh/aTyrcjPrii0rBs6uyHLVQSJftr02CVLLqbEBEcKSCns5QD9zasSHJ0
	mWV5wjewJfMOqVkgl9SN1FrX3PaFQzlZq5eEClvFbsSNEUGUPpGHFn5HfmBhJVLwNksv5MHWWUE
	Hvfy1fWzRwt8vbjFt6zVL9jlRhKLiufeAIzoA/g=
X-Received: by 2002:a17:907:86a8:b0:ba6:8f34:b419 with SMTP id a640c23a62f3a-bdc12f85f54mr164286466b.13.1779368645816;
        Thu, 21 May 2026 06:04:05 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a505905sm43766266b.37.2026.05.21.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:04:05 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com
Subject: [PATCH v6 6/7] staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop
Date: Thu, 21 May 2026 15:03:29 +0200
Message-ID: <20260521130330.754181-7-hossu.alexandru@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253549-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5514B5A58D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The loop in is_ap_in_tkip() iterates over IEs without verifying that
enough bytes remain before dereferencing the IE header or its payload:

- pIE->element_id and pIE->length are read without checking that
  i + sizeof(*pIE) <= ie_length, so a truncated IE at the end of the
  buffer causes an OOB read.

- For WLAN_EID_VENDOR_SPECIFIC the code compares pIE->data + 12,
  which requires pIE->length >= 16.  For WLAN_EID_RSN it compares
  pIE->data + 8, requiring pIE->length >= 12.  Neither requirement
  is checked.

Add the missing IE header and payload bounds checks and guard each
data access with an explicit pIE->length minimum, matching the
pattern established in update_beacon_info().

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index dd34f229df12..94bbe7ac13ac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1335,15 +1335,23 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 		for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
 			pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
 
+			if (i + sizeof(*pIE) > pmlmeinfo->network.ie_length)
+				break;
+			if (i + sizeof(*pIE) + pIE->length > pmlmeinfo->network.ie_length)
+				break;
+
 			switch (pIE->element_id) {
 			case WLAN_EID_VENDOR_SPECIFIC:
-				if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
+				if (pIE->length >= 16 &&
+				    !memcmp(pIE->data, RTW_WPA_OUI, 4) &&
+				    !memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4))
 					return true;
 
 				break;
 
 			case WLAN_EID_RSN:
-				if (!memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
+				if (pIE->length >= 12 &&
+				    !memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
 					return true;
 				break;
 
@@ -1351,7 +1359,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 				break;
 			}
 
-			i += (pIE->length + 2);
+			i += sizeof(*pIE) + pIE->length;
 		}
 
 		return false;
-- 
2.54.0


