Return-Path: <stable+bounces-268671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qa14LMqPPWpi4AgAu9opvQ
	(envelope-from <stable+bounces-268671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 22:30:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 043E06C8823
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 22:30:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Iaf/1CJZ";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268671-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268671-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE58304F20E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822E317144;
	Thu, 25 Jun 2026 20:29:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52352FB969
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 20:29:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419398; cv=none; b=rngQw+OuBPyJVRfxdcmPTUchUrzYwGHmd5ZjRmIKX97+bHYonne64haHq0G5SZltAuwOIyRaGfkd8W/j9lh7fOKDOuPnYwtImNJs/qjzBZkI78toMoG5IRJBHvNv3uhWCUKCF6a13qOdm8g26++QRPxXSf2Z+FMVSzWySzNyifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419398; c=relaxed/simple;
	bh=5+nKdvkG+WmsXwu5G3vmgjHovCBbUwkkl1WPmTxRkEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ihxp6M9Rsmj9o3XaR94d8636177ZsyOsUjZzSpRENXGYGAhGj9LWEP29sL0shdXSaTrsZ4V33trIHN1FUPY7dia5iNvS6M44++BTCHhNIi6DKuxX9+4so/wgXd0Ku1Wzu1w5FhDheGwLic54XEyrMaV2gugEXp/Ah/Qc0BbZ6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iaf/1CJZ; arc=none smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1384eb94d20so685921c88.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782419396; x=1783024196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UjaiIZ+XjuswCFzZsqBDs1nnY06nMhFFVLNeQuNdOdA=;
        b=Iaf/1CJZOL6AqKvdANhOfkYuxsA2FQAf+UsRQ3t4/V0qEebprlQyIvZhhM0scQeyl7
         iXRI5QOX/LiWuUHEhAQGYaBSXYNQ8PCDB/GRREinKSxKutGrxtDHS5DHZy2UHB2VoYqc
         6xP+s9FZN6ORRKviQp/7W9ZImVyr4ShSadXT3NzNfwBBhM5nEkQZw8J7w4xKwI6ew9P3
         ojXU9+ngHZrsD1d+S93vI4I5oX0LvtspievisqAe6oHsrDQpAk2aG3nHB0RbNk5u0YNo
         7AgUlM0ah0+aKmbAOOEU/XT6RDqKmyODNnHUyjxIePdpii+o2Sr3z+5UcS24F7kMTqug
         uv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782419396; x=1783024196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjaiIZ+XjuswCFzZsqBDs1nnY06nMhFFVLNeQuNdOdA=;
        b=jdOGhQb3UWIxU0+FTQlEcUw4B/OPRm8Ag7PLWE6EqNLoq/v4g6MpHk/8YjQ/WKP2yz
         wCzScyzKxMoR5gBP1mZ8rP9toOpBin07VjhYr15NnsH9rrrwqeVwFAEn93alCY5tAiqX
         Hh8KJrPKqrAW/XdsjJydSuVDZhNFOAXRupoxmtugqmFoWWVnLXF6pP/TR3n/u/IfqyTI
         XupCHV9QLv4WC0JfTfDeHuQEjyqmOF6ZsrqorQH3zo4NDE7sJbkE3mu5+E7vGgbzDcc2
         XsGy46rhK9TK1QjYAMhWTNKW1BmHaN8nfyGQtfspyYjd903jaRi//vXH6t+EQ54j4MoY
         ICZA==
X-Forwarded-Encrypted: i=1; AFNElJ8DlKup99+h1H7jljv+VNTRvDrWd82Y8+2oSl3HWHCYW420fjxpeLd2M1FOG1wofF+mVQhumSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5FW3k+cSG3OPwkOw89PV6fn/4OQvHFrAjyr6GXWMoJs6xU2E
	P3yn4Ecpqh8K79bYHukE5YQUXhs2JC0R3tCVmdiKfWN4+Bg254vuf0PS
X-Gm-Gg: AfdE7ckFBRVR72b1jlEjxaDyUKlSDeleo1ZYhGeJAeo4fxsSa9lHPHXRWf2hy1txlX2
	D5rQJWQfo0G3AA0X/z7OY06xRays4y7B6X3RIfh1xCNZ30jR/e0jX3SZZPsPy9zq/O7vxB1T3n2
	0SmpwlbWI29dVOvosH4zeO6IS0xhy+XBMdJFk/+l4SJKXJOeUKkW32oNZMXLdzvvIBQNri4luE5
	gBw/pky2KBuC+RkTyH+lL5wA8vdgsNEXeYbLDcVJ8bIN/ywAgmb/eHxparcU0GV+hpe11+Uw7MI
	KwGfUZb56K/NZNRd2ycfwUZWsuzw55P4FkWUN+9N2adNerNO9Bjv4L3kFK+crpim2zfpxC9Ai7I
	YZ5NiN2m+V5AbZlooah8KCXRR2QiWClT/ykKX9OPphD2v0STa1Gzqg/NjcR1ncFf35VdwNCvrq5
	ehk9D0bsRCGxLzk0EXqFX/mwuSWy5+hymmYJXioiPsyS3ESL0ErqeLrEeJsU7Hcmk=
X-Received: by 2002:a05:701b:2404:b0:139:beb9:fcd0 with SMTP id a92af1059eb24-139dbb4955bmr2198183c88.27.1782419395889;
        Thu, 25 Jun 2026 13:29:55 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([36.255.89.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f5fc82sm10528991c88.5.2026.06.25.13.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 13:29:55 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()
Date: Thu, 25 Jun 2026 20:29:11 +0000
Message-Id: <20260625202911.26782-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268671-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:linux-staging@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:skhan@linuxfoundation.org,m:mokshpanicker.7@gmail.com,m:mokshpanicker7@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mokshpanicker7@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linuxfoundation.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mokshpanicker7@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 043E06C8823

rtw_get_wps_ie() iterates over IE data from network frames without
validating that the IE header and payload fit within the remaining
buffer before reading them. Specifically:

- in_ie[cnt + 1] is read without checking cnt + 1 < in_len
- memcmp(&in_ie[cnt + 2], ...) accesses cnt + 2 without bounds check
- in_ie[cnt + 1] is used as length without verifying payload fits

Add bounds checks at the top of the loop body to break early if fewer
than 2 bytes remain for the IE header, or if the declared payload
extends past the end of the buffer. Also require at least 4 bytes of
payload before comparing the WPS OUI.

Fixes: 554c0a3abf21 ("staging: rtl8723bs: add r8723bs driver")
Cc: stable@vger.kernel.org
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index d0bbe1bb979c..82dc0ad27e79 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -660,7 +660,14 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 	while (cnt < in_len) {
 		eid = in_ie[cnt];
 
-		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
+		if (cnt + 2 > in_len)
+			break;
+
+		if (in_ie[cnt + 1] + 2 > in_len - cnt)
+			break;
+
+		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (in_ie[cnt + 1] >= 4) &&
+		    (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
 			wpsie_ptr = &in_ie[cnt];
 
 			if (wps_ie)
-- 
2.34.1


