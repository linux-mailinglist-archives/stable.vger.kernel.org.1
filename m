Return-Path: <stable+bounces-253662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD+SNeinD2rCOQYAu9opvQ
	(envelope-from <stable+bounces-253662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:48:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9B5AD8F7
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E3293061951
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6B28850D;
	Fri, 22 May 2026 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWA1M/V4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E729AAEA
	for <stable@vger.kernel.org>; Fri, 22 May 2026 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410788; cv=none; b=H2F4g9qS677TP9WvjxG17FGPZVezbIGTfoHNJEsS7fGn8v3AIvUcRBFnfNNluypCwBjIXu1vn6/CdQRPTP9VINNyVfcGJz+94rVH5xDnSb/+Wy7pUunLYFDktBz9FCZ/DjY5QIhBSbTRSjq54sZMpDfTUxO/+czVm3SG+sU9Bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410788; c=relaxed/simple;
	bh=7SsrYMKDh9rt+9N6EF+fS9nQeI4YX7vkrI18oJQsNRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiBWREDQrpwl+S+GtjcNgxDb4mVDfX7UvtvGiHRlu3E2CD2dkomOhrAj27xp5jmfs8RRN6zX6RAdpVb+g6ubdskQlfjyvozlVfwWrmFZxRk6dzETuWlPhgevEYIZTt8VyPHkPzq+arc/bNC8kTsF/Gc3YJAYYiRS3mbwZXU0s1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWA1M/V4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso14212286a12.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410785; x=1780015585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMABQ2lm+8Apo5qMdLPjApIQTOzncW9oYRbW/a64Ly8=;
        b=CWA1M/V4FWKvEgfWoXFOZISgXOXd2+c6/MWU54tCTmcQVHmtSHaccPbbEctl6o53pZ
         3Nf6yQKBahY0dW9Pbwm0mYF5GEyGQNxrSL77KCp30dNStJcv1oyTo39iMT2dSbP0MhEv
         sVrU1aYhZ4AS4pEWmVViUmeIEZI63pcIz+A6Dcl4b9RtYrO1kK3wODIHXqVY5tf06HPT
         38ygonnZUR0+RnAzurgbI0QdCZrc8NLBnHWS9mXCaDMh76d3i+E5aOWbrEHecOqBndbw
         VBoOkTnRykfWVU9Jnuj0yCv3+4lD5EwoxtFVhPotY7SyOxGit5bWc3FrzFcDrnxh8V0l
         +uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410785; x=1780015585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMABQ2lm+8Apo5qMdLPjApIQTOzncW9oYRbW/a64Ly8=;
        b=qIHIpj6AbmLyLoai56HcCsPcaqbmT/G2TupsOMf6r4WUROPTwH5XyPyx/lILiJRPB2
         bHOQecLFxC/GMn3dYOXj7bU3P51CQCr0bilabZKOyLjWmRSQpXqkVixAgfUZfD9jAKHy
         2rj6pfY3uzUpwVKq0ygcPxlsSKQSwqzZtqADFJP9R+eI9Ww1kA+vvV0fwVzF87CUT1tI
         +uk9mW4AO50Am3tEspM3K5x+R9ktLPoAhWP91mAQAJ8Fmy/WSkwyzSBVyvkMV9CsejRb
         gS7B00wRdoxwrfPD7rW7ISyBPstwxhb/UKOJ42Tu38/jjo/c5Gb+6nVrPtkQ7F6PfEGD
         uZMg==
X-Forwarded-Encrypted: i=1; AFNElJ8g6LDc1PnxfPZ9IW+vAPiou6nr3CC239+AXEGgQIQVL/xvU2Twu0OadlKWdW3A1MTHp5DPoso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSA3s9vNdcPC7/pNOYMono+mfETytqFc6xqapEOwYCTI92ZH2
	pWwYponfqEp+yGOlcLolsManhizC7LKsG5k0SGH/MP4h/O63xUO8AZwI
X-Gm-Gg: Acq92OF1dnO1X3MUur+sKyshTGh3irB3/lNWhHCE5oKeCksfsQwjKNWHpznR+wFKse0
	fXINYvQxjStDOpE3X8E//rdvCRr1baVx7JwuuUq3OYMfP8yCdmjr7xpt5v89doV5Rec6ePICyKi
	354Ia7bKDtWLnxDZDqXla8gYntaSkyUHgCFoSoslMIDg8iO+j11F2x6BnnoxZ4sxKXcXy/yM8NE
	QhzRx4a2CTAq13K9NQQLUXqwAOJFvKTRtw3HOCmSaQiP960hREkRs8N6T2EbUY1dgLTJ8rgxQdA
	fxaa8mb8VppShNcsZcdF06Xe+0jBK8mc8ptP2Q0dIbVipnxRulBsgD/GWJq8+1OeyvPedOsfL5h
	68vagfb7a1ikjJrAo/ueI50MQews5GdERvi9rA0FMLLnP4DOOdDdCAYRiI+8mwoZXKw5Uv80xX4
	e0judTiSNYFMT6ZuQ7TsNy/9l0RlsyLBRCHPvAitZhP1OWLosWtFGdwwbp+iS8R58uvpZdW7hJh
	b+HsJpmXGIeF+qxdKrEABGOJP5JbXYrD1mB6xfsjJo0k+15Rs6nZnovXEXmmJpIOhwD5hnx+dvm
	QC5IR1YwZlQ+UnJBbu9yCVHe3v3w
X-Received: by 2002:a05:6402:43ce:b0:686:d801:96c9 with SMTP id 4fb4d7f45d1cf-6889cc374d8mr599441a12.14.1779410784990;
        Thu, 21 May 2026 17:46:24 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b72cbbf3sm3535a12.0.2026.05.21.17.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:46:23 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 6/7] staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop
Date: Fri, 22 May 2026 02:45:30 +0200
Message-ID: <20260522004531.1038924-7-hossu.alexandru@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253662-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4DB9B5AD8F7
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


