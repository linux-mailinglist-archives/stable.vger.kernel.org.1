Return-Path: <stable+bounces-233303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L1ZEdCY0Wm1LgcAu9opvQ
	(envelope-from <stable+bounces-233303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE5A39CD18
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 502713006790
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 23:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41035CB6F;
	Sat,  4 Apr 2026 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/ujG4VB"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60F347BD4
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775343798; cv=none; b=uGN8UpNMn1j1XDx/24Ra6FzYAEVKBeULtHaxESv++NfGkTGFocV/x6/ULeI1ou/AAiMcVcEtdj9B8sbzbBq/S7bpcENKiai0WrZDPvrpP5Y0htLZZ437cxjn9grTKfseBGZkEH0nUAMJFW5cINP+5I99IRp31dqwcVP6FtE/l3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775343798; c=relaxed/simple;
	bh=HL1mwJBzaIwo1zGTYraOLa0fIAhVfWpdcbVPs6RmyZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFRIH4enPVHnAprk/BahUuAzubZDNzY2KiEkA/Uhn3GmzsC4FJfB46bT/+h79tyPNH6h6ASD0oNPcZlgDXGD0V1AGMFWhl1g20FARCGWXk6BLkOCs7HBAmAV8e1TRpNu6IywGGBohv0xjS+xITWlqfvz4hcwP4pUDRZKZm4g7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/ujG4VB; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56d89f35940so985445e0c.2
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 16:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775343795; x=1775948595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VT54FeMbxqX21ddtIQHdTpaD4nSQybFIj5pVbkZZyL0=;
        b=T/ujG4VBFv35IlIXHi6wjnHgBY2HB0KGUtcYw1biu8St9yjzlaCU2KAA3dYk/tHIdS
         R1/XSzgGynqekuvS7RM1KMotwBjvzx5nazzxGhSDRAKQ1zj9ygC4qulmwg/IYRDi4Q3B
         Nq/K/5lYU5HFLZpZ87aqoPf7hgYCJcSVEiJvi+/EkOqdRRS88I3XyQAVFGyt2X2TZ3BC
         T1pCobnt0lnXMDDmKtTafHU7NTAV+/yU3fBxR/6XWDA9eZo5xU5lsM8BP6xdqDx7Xri3
         JmtKaM+S3PNYs3W+3OA2Sqjv3WkuyFC/Xv9VnTG7iV3p+nkfUWvKnVW7DJ+sztNymDbF
         mH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775343795; x=1775948595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT54FeMbxqX21ddtIQHdTpaD4nSQybFIj5pVbkZZyL0=;
        b=lgbFS6AgFoxh5uY2SV+b1dLjtzxFiINvRh9KdsEzm8w/2HDla3/s69QyA/B45DLprG
         seaHJywHYWqkAVAujMhG8zy3wmmHRjmPrOXLBldQ/+wqcbmYAwng8UPj6x+HP4XumkNo
         oqfwUqgn+zzOtngE8/1sBP+uG6fD7Kg/BKeZUARcmB7CQK6hY2BYnfLQHDpPybNwV7eG
         XWRiEgYq11naoIeztBv942gRbzqm4TTycoxwjFpiumvUTVQEk7rYhhEbw5+9ZLiqFvic
         ambwVNnAkUtOZQqQRZujqB+nJcswFSs+1DGi3KaTLQDVnuZUeKNTbB3uY7+mtjdX0kex
         O/lg==
X-Forwarded-Encrypted: i=1; AJvYcCWWd3v8ObWAMp+JZb5Zk/cOCAh8+NFjzCA0n17NeuvpE1BFyHQya+4PXqVvQoIWvRBXJwJL8QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUuq3KWn27KPgm6nKsFk2GZrthCrxDRubv1PtMy26mX35etnqb
	dTzn7L4gfjzwIe4Ag4286VbI9jRcAQREkLbPUd1UM9F9k7dygWyjosIz
X-Gm-Gg: AeBDieu9DhzgyqgFLm/RMxOgtxhJmATKjoVHmEUASi/REvyLb5zWFaH8Z7XN17ZWCvD
	dzcGS/YkLb6FfUT+Yguo545QOKfJ2+Mtxuds59yQtIZQevbhWodCgSWpuEQ4L1tIPtc9wi/SzYh
	iL0pBE5MYJ5PTRjZLUF1a0mbq/uNA5PdVCpDto6M7Y0BYpfZK1YiBL7R7jKeVenhP4dZNS0PgMg
	iRM97vonL6Q/uB2zk3RpNf6nxfRdAc4gHNysoajiOvAhdrugLE2pG1l4+jMiEFgzptOMSi741RW
	nxkTDQVn/7zmd1ySnkGmuUfd2Ihq7Wjr7O1+bENH/S1c48A+zMWBuZWlktaR7IxyXHuZ3c0208T
	Dy7RmJuJWVI50On0L4oTHv0YjOZcW+OtC0RCLbhkXFXoACy8GN+gefgtACRjaoy3IFMzF+/ncbu
	7eV/CuUuSeJ33baKMwrmDydfyB+an075NPdVYooOiR
X-Received: by 2002:a05:6122:e1b2:b0:56c:ce0b:fecd with SMTP id 71dfb90a1353d-56dab9d6df7mr2638405e0c.12.1775343795382;
        Sat, 04 Apr 2026 16:03:15 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9ba80290sm11317699e0c.3.2026.04.04.16.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 16:03:14 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix negative length in WEP decryption
Date: Sun,  5 Apr 2026 00:02:48 +0100
Message-ID: <20260404230248.62203-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233303-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: AAE5A39CD18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In rtw_wep_decrypt(), length is declared as signed int and computed as:

  length = len - hdrlen - iv_len;

If the received frame is shorter than the combined header and IV
lengths, length becomes negative. It is then passed to arc4_crypt()
which takes a u32 parameter, causing the negative value to be
implicitly cast to a very large unsigned value (e.g., -8 becomes
4294967288). This results in a massive out-of-bounds read and write
on the heap via arc4_crypt(), and a similar overflow at the
subsequent crc32_le() call using length - 4.

Add a minimum frame length check before the subtraction to ensure
length is always positive.

Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index b489babe7..807f4f3c7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -113,6 +113,12 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		memcpy(&wepkey[0], iv, 3);
 		/* memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength); */
 		memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
+
+		/* Ensure the frame is long enough for WEP decryption */
+		if (((union recv_frame *)precvframe)->u.hdr.len <=
+		    prxattrib->hdrlen + prxattrib->iv_len)
+			return;
+
 		length = ((union recv_frame *)precvframe)->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len;
 
 		payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
-- 
2.43.0


