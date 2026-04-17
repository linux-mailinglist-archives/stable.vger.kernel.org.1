Return-Path: <stable+bounces-238421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGSNMkLQ4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:16:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB03417546
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2C5E305F1BE
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B650D36F43E;
	Fri, 17 Apr 2026 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPoEolU6"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266436DA1B
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406360; cv=none; b=gAC+t1vsN5n5ORAfzWQk1yOuNZgC7ZnS/lIN/cbgfQowydWrFR0yYv8fkZzKEZRZAyP+PTx4Xov50UKwo+kk4sR1PN1/I2EcjnrQhHEJJ7Rg9Mi/ziRIEJ0s0dgxFLNyIdXzEEnzHRxZ6Dghk5JpJtp/MZmOOko7wF+cZzVV7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406360; c=relaxed/simple;
	bh=Mkn9VdUMU/TvZ8JqVerjm7KuO8HxezoafwaUYXwJEtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmmBlzGtCK0xf9a/cmBxLOEOA86wdQed9TJ2VaCWZD4oSMMtDB6qcJ5p3qv8RupZpJZJJ4H6VRtQK4CwiWog3hGCtHTE0+hiOevhIhLdwNol5c9Mm0BjgEqJ9f9OkZQbTb1MEZn2qjlFfSjufcQES+lAyS+JXla2UAfcYBf22II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPoEolU6; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-60580b17793so79108137.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776406358; x=1777011158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chi0rjV8j6xNxAz/qcwmHJNYbKqeX24uRogPLx+nbHQ=;
        b=sPoEolU6BuGWGmhU+V04B2Ir8TG6k1/TqAYP4ENAflbuDjym/NM8KspYD2ZkrPBXeJ
         kGujltRbmj/gSaFaTN3wh63FwLr0ZfvCKRujLR5X71O1nmVWfc+nV7cRPtAp395xNdFp
         YSVcYokYyFlzDH7izxvO+4S2twu0lIglTrOZcKkN3g2KwCR7vANRK4Dqqm6cJxzjTSzD
         ne78wSKFK9SHNPOaneTU/VYevEVtGPWPqp3a7PbCnmeSPxMQMWx8ItxpVjE5X+E1LWOh
         yw74YEEPK9eY2qq3GW4N10Yez6vl9zwe4z8rW/9vj2UXdIFhzDsegp9WZF44qM9fO/iL
         frRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776406358; x=1777011158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chi0rjV8j6xNxAz/qcwmHJNYbKqeX24uRogPLx+nbHQ=;
        b=oUna/e7OgDPrHucHoNQYcsxFUmwcj4279gxu02zy/q2osnjRcv8lP9NPK6kaHyLqSY
         Tz1VjuboXDxrloLQyxJjTbekUYpZqHRMuW4NE6S1Y/rF/Gk++28y81QH5l0tCUQ6Bt4t
         6fL46p4Hm8JER9epKasm614CO9sYnF34WHs9AcOnMbjh31sZ0hb6JhvLGaYEcaSIYJzq
         KnXoMrjoJ5U1dNSicRKQpzojefLBdPkE5Hvre90XEZcXm9XlyxZuhWMnxyMaUHG2sRZZ
         ELMCs0QkzBBr+hRZNRs+YfJC03l7RGJTat9Aklv/M1d7EtZbfQ70+36GsDaJWLgTNp0P
         AZtg==
X-Forwarded-Encrypted: i=1; AFNElJ9YgovjL1lJrgsikGz0uWes0T3kQv3al1qydKjxIEYlCEnS8fGbvc4gzyyVttDIs+e5D2rw5eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxekX5kCo838a7ORz70WLx858hD5Gk7jyJ0HluBzqxwDygnVed2
	g/gCVEphxAurWI1H0MHHJf96pI4h+8k4KJoUHJmeHGtzO624yiWf8QKE
X-Gm-Gg: AeBDiev4FBi0P/ybK/tpSSA0ADo25/xKfZgdnKUVAMOHj2Pszr6ZO6XWhhQi1ZeJ9xP
	CBMVviTkEm2kfL/7485I/ElcDpdB9JKDvMoqTRngekvb0JqwkxsKiFuQCWhxqQcNazB1QRMgOLO
	U/fgx2Ye81uvqQVu16ryRBPP9QCYQnur3HNpCthAuReLosFom0P/1nU/jmyPqUArtEab1+fQ1PV
	Xp1zSb66nhLLavGbksVG1ixWBJMf/CHiaowPTL+qZ8Fv801uyH/ZyueMusZpDOIBpIS6RiSBK+t
	oohrAu7Ip+cVfSiZw/b0CIDP+A7ucMIsYwBmltUvVS2KP6GDx3rz2rRtxAW4Iqqi7YXr/yLpJcG
	e3VqmlANMPPUFYvD/ZGzYpyvut5uqmjuurbIrsaOZQ3KcGuZVf3uFnRQoyFPXINouv7cN3Ug9mL
	m3dN5cyst0yi8okzm9YQDddTutRzq8+vnBYXQhTkS6qyFGlE9+zvvcsqAlNQwJZIk=
X-Received: by 2002:a05:6102:5122:b0:608:759a:53bc with SMTP id ada2fe7eead31-616f1c595b4mr526551137.0.1776406358162;
        Thu, 16 Apr 2026 23:12:38 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589093a8bbsm297947241.3.2026.04.16.23.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:12:37 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v6 5/5] staging: rtl8723bs: fix negative length in WEP decryption
Date: Fri, 17 Apr 2026 07:10:48 +0100
Message-ID: <20260417061048.62484-6-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417061048.62484-1-delenetchior1@gmail.com>
References: <20260417061048.62484-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238421-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainer.pl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFB03417546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In rtw_wep_decrypt(), the payload length is computed as:

    length = frame->len - prxattrib->hdrlen - prxattrib->iv_len;

All operands are unsigned. If the frame is shorter than the sum of
the header length, IV length and the 4-byte ICV, this subtraction
wraps around or produces a value smaller than 4; the subsequent
crc32_le(~0, payload, length - 4) call then wraps length - 4 to a
huge value and reads past the end of the receive buffer.

An attacker within WiFi radio range can exploit this by sending a
crafted short WEP-encrypted frame. No authentication is required.

Validate that the frame is large enough to contain at least the
4-byte ICV on top of the header and IV before computing length.

Found by reviewing length arithmetic in the WEP decrypt path.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v6: unchanged.
v5: tighten the length check to also cover the 4-byte ICV
    so that the subsequent crc32_le(payload, length - 4)
    call cannot underflow length - 4.
v4: add Fixes: tag and Cc: stable (Dan Carpenter).
v3: rebased on staging-next; sent as numbered series with
    proper Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and
    did not apply).

 drivers/staging/rtl8723bs/core/rtw_security.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a00504ff29109..ddd6ed2245035 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -113,6 +113,12 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		memcpy(&wepkey[0], iv, 3);
 		/* memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength); */
 		memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
+
+		/* Ensure the frame is long enough for WEP payload and ICV */
+		if (((union recv_frame *)precvframe)->u.hdr.len <
+		    prxattrib->hdrlen + prxattrib->iv_len + 4)
+			return;
+
 		length = ((union recv_frame *)precvframe)->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len;
 
 		payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
-- 
2.43.0


