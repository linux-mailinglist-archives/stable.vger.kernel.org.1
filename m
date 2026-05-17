Return-Path: <stable+bounces-249096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJXdBpHICWropQQAu9opvQ
	(envelope-from <stable+bounces-249096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:54:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E2561547
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E03A43032806
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839D91A9F9F;
	Sun, 17 May 2026 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVxsAaNX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78F248F57
	for <stable@vger.kernel.org>; Sun, 17 May 2026 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025950; cv=none; b=j5Q4Juwuz7T92Rsi+PvSnIMA7jZE6mPffLWiGsVWSJKatWSa64d5LuaWSDDiLvU69q8pqNVKvynjrivfStgCVJSwtu69LSahmf2IQ4FjbxY5iRGGa6Fsz51Qd7t0tF/B6ykU6s9Qm+fB299pcfTeWglMwNDsfIkd9gGCsM5PtrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025950; c=relaxed/simple;
	bh=7RVrmuiuxF/rWreRjusc9N9OoV45FUmambe+/N5PACw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNTs/bNZVC8IKlDXkGEdzLaPFQOY4asvRZUP1Id1Gg97TQqBcqW4Dl/xgDyLpBOatBZqyUjKQE04dyIeIaqE+MYtiT56f1nkCYE922B1RcTTkAkSjOqE2c/WlhCkItusfH8YBpF3+7pIvu1RvHRJdSLaKqre+1EkxxbYtSc04MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVxsAaNX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bc7b311e77so4922595ad.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779025946; x=1779630746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QO75HleHGDZqT7J517EBpplpM7jMyRvzAuKel4/gPzs=;
        b=KVxsAaNXKVd8NIY5+lfvKHLi7uvQYiPmIE3KUaqiWZ21yIgRKIf7lAigo+j030sQDJ
         ufFWkoEYvHiCKan7aRCxV2xm66wrYvrdLtSAQQp8z9C1rjYg4PkTrr6S8/8gZt65/E4A
         56v0hZ143Qsh8gGbrXz0qHiB68MKbBVHKCuvtk/zO/VazOe5rRfG8hIyehvaE/0noFGB
         4w6Rz4HskipOY4q+N/VzKBJ0n31yIWQtS+hohmRCe0F182Vn+ey4AQfpYxeUnB5d9bww
         m49X1LHP0mprsPSLDRLmGwZyl4ReINQVVNRdEOkk5qndzzZ/q1WjchUTQxWQddG4Daoa
         Fu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025946; x=1779630746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QO75HleHGDZqT7J517EBpplpM7jMyRvzAuKel4/gPzs=;
        b=ErGV8HVSwqsEq/A0DsxWS5FO6l6qF+VF7tgPNK0+uBiue44ayxqbIx/fo3Hzmxu0uz
         ORzdOP7ybxiMAALCWUrioIZKM494ZtEk5IdMcpqvCk3VuDd5NzeLhMUEYJBQ8Xg9g+wi
         G18qfsjY58yJxvR1NpmJyENMIKhvP9i31eQjm14GuaJRKCy7IcilBIV6ilmHW3p5/eTU
         ZOYsfJEI0hKKPAGsVYvCXedBbGZZA+fm5Lg6Ii+rMOtwFYmDrRrk71Q19aJPrL2UKCnP
         WfV6Joup9lQdUyrkIVNqsfGyVgs0eL+1GksQbCb6tga8ey9+ds0RaIQvRHEiczwxeTFL
         qA0A==
X-Forwarded-Encrypted: i=1; AFNElJ8Vv5nS2qNCnsroa7ZPWvSjL55Nmh5sI+fjhLWJ1I42U+4JzTG+YuxPfgnmXloDrmgtYiJ7Aa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1v+u+Al6IGhLvpkU8gis40DyZyqpgmNWj02ybahtWSlrmZq9X
	DEV4fAssSvvB5EH1HRlyXQcy7sTWQYYgLn8y2N+fV2FIB36xb0s1Y2WJ
X-Gm-Gg: Acq92OFM/vkNltTMaivk/gD2RLyoyBCLXnnk0NgMoqBFkv+KTe5B2fRWvgXH+M5c1qp
	SYm61VIw5lwdEdiEdkxa3P3Qd1lF3sNHacXGjI7QWgbXK6cpqCH74IlzfuWC+DXXueAmuy7BOh1
	0iUdzWdi0BNRT4fka8deOgM6FX4Q8W/cA/pF/di40Ln3Z+Iwwkkc0DKCMKMfAatTtzhGvTXIAPS
	nO23n9QsN1xa1CnQLA+ry5r6SPaSm3sQOcl23wuD1bsfsdT53/i7uzdpc4c9Ez/C0rUFXkMYT+3
	DSBHzmaIvs6UxAp6GOxfJuhvnCNTW0qVqlSw88DezuldbtfqTBrVaerGW3BA796m0o4VMCQiYO4
	W9VuY1znIsDpuQ25PqV5F8i5mFtoRaJHEWtTVrmaeXezvnsmCFsNdL/NDVVStZ4+n48MUHd6NUd
	lQIbgk6pPtFDAXppiOGcV2x3TLOmwnIXtrcVVtSF3NDZt1u2Ts
X-Received: by 2002:a17:903:1210:b0:2bd:c60d:2968 with SMTP id d9443c01a7336-2bdc60d2bdcmr28937195ad.12.1779025946291;
        Sun, 17 May 2026 06:52:26 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm113873385ad.10.2026.05.17.06.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:52:26 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 4/4] HID: wacom: validate report length for 24HDT and 27QHDT handlers
Date: Sun, 17 May 2026 22:52:15 +0900
Message-ID: <20260517135215.2220117-5-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A6E2561547
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249096-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

wacom_24hdt_irq() accesses data[61] for WACOM_24HDT and data[63] for
WACOM_27QHDT in the raw HID report buffer without validating the buffer
length. This sub-function is called from wacom_wac_irq() which receives
the length parameter but does not pass it to the handler.

A malicious USB device can declare a small HID report in its descriptor
and send a matching short report that passes the HID core size check
(csize >= rsize), but the driver assumes a full-size hardware report
layout, leading to slab-out-of-bounds reads.

Add minimum length checks in wacom_wac_irq() before dispatching to
wacom_24hdt_irq() for both device types.

Fixes: b1e4279e4ef5 ("Input: wacom - add touch sensor support for Cintiq 24HD touch")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 269e8318f..2fd1c4e80 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3509,7 +3509,14 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case WACOM_24HDT:
+		if (len < 62)
+			return;
+		sync = wacom_24hdt_irq(wacom_wac);
+		break;
+
 	case WACOM_27QHDT:
+		if (len < 64)
+			return;
 		sync = wacom_24hdt_irq(wacom_wac);
 		break;
 
-- 
2.53.0


