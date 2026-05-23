Return-Path: <stable+bounces-253887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDhoLS42EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:07:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 130E45BD32D
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57486301DAE0
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06D32F8EB0;
	Sat, 23 May 2026 05:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hucmf4cY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B22DC79F
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512800; cv=none; b=es2kZbNQhKjcVYF6R7XNA+kn9Jagt67XYl8oXRJvGDzixndRBd+YXS7+HqhZ5gXPk4MPcr15cJoXu8AQMlJQPUjN+fXYxhtb4ib9IOMW9LrAkEFLoqNBHQ6V2+K/NvOwUtNV4jOiudjhkzaoAEYfGHop8pYgIWjsxialaISwPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512800; c=relaxed/simple;
	bh=0vTKycvbzbjmJvomuj/XgTFepo/EwumOAacRU/0stE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mlh9oYylOo/D4N69YN881R/HWQg3/NMIsmjpgUF+xLxIBCm7C/BOGiROjWv/4j9El5M6qJEyfmgaxNIMjgxDVk0JW0dY15ubh6BjsIj5nm/NH8jyuFDCrU4MHZwgn2stRKNWBttNnMBXw61TuaItAjV7Cmimga0woQmrnshScJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hucmf4cY; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30455f77e0eso1069708eec.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512798; x=1780117598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X19iMzf/kdWvgmUR42/6jiMH+NpAJ73uf08bFK/q95A=;
        b=hucmf4cYYBTlZxqkQUigGRLyOCLyEKdJG3m2To+A29ZgQrEsuBMSCuOgecyNq0a3GK
         8lAecad9hAgKWGrSQFabuO768JXj9W4KWI2QTKVk9qfAx1EUZTgP/t6ZOf18P4vMXtnv
         Oa9UZwkwfpKKlhvRhJiUHWm0fAILIw9HRwWhc3UrEzv0Cyrsffn2wjTBXLRuuYVG1LtP
         WcW4N/mK6h8NcUjaLJ25W0Hg0OMD0XKkZtDvAnDnGeWmdNMfWASe0deTZouwgzQluPIv
         FL110CNJh+6k1U4W7Oqs0OEi6Bl3ws71Hdu96WgHC+4ooqLUdgAxxGSl778EipqyaYMn
         pDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512798; x=1780117598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X19iMzf/kdWvgmUR42/6jiMH+NpAJ73uf08bFK/q95A=;
        b=JMGRcR3VEH8rNGsT0BtjSDPAy+2l+w2225HICIjGduzYxI4Oq0PtvMWG4B8uIz17Tg
         uXdJrcXehInjdSQ4SkazUwGCrRYQ2IqXzmSXdlFi655DLTfD89OYrgjXHOvFvNi3zF8r
         Ety+Pn2K3Ig/fak2WNSuILzB6txKSiSbElA0nP3OsGOXp+toZZ623uLEoMXN4GqXZ80f
         yl7A/UdTE0IOykVTA/fSNc3UvNSXwntuGm3fQR/tHoM/bTdIw1FhNmNdJBKB1uq20bS3
         HizrW7muSBf4cJpqvXo7fx9/ZdHaadWHaSJdu6iZhQ8I2HkNxdatLC2pTdBwhGSHsKfk
         nA3w==
X-Forwarded-Encrypted: i=1; AFNElJ8cVLyYjlzqWeEKtkVUZ/OC1AgsqzKjTgtMIgHQmzyPstAP6e/79JOoEQKd46bFQ5gl4Ef0aKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1t/UCd9dX9tEMXb1NPhgOyV4rKsdbpiZE4IKODnMzvJR5lwP
	Gxgj7lHwkRG2Ptpl5gYZPe4q5juV2joCe3QE7xS4eeMJ39MWdwJoSzP42DlVdA==
X-Gm-Gg: Acq92OEURy1G6hBnquXaF+bRTtDpTZ6dDSV0zWnpuHhywC0BwuT5FzYo1u+NBTkT94c
	AivlfTZVuAU1PXfvkpqLTnMlfFw05SognaT4wKAc7Y3qPmc6d43unRf8+DmYV7C7w2brq3TrjhI
	fr67+PMeYpV1KCcJ3Hp3HHJ1dWdop4RD/WAgERuBPRGwUE3jRsesyYM8Dx9siWkH4HB8J7SH/KP
	3tCQAHV1uY1mDkbYm12NSpYcQpghBHhC9+IMAIFTGjKR2gwJ9RDyjMhm7+XiERyBrih2fFzXCO5
	VyrU86RdjjEkQQghXnsz0PKjWAx4P8a0J1p9zB/4O6SrQijRYLbr2rT+ECs5Cwa4/HT76S4HsqY
	wKVFGKt1Xr6vyb1tiCl303O6KSuOik3NQjahNk7E7+sVd5bLK9lboQXq6ERoYdE9MgaOet1g1oo
	MGizMGaCtC6VB43fV7j2IO5FS00QLshdBSDlsZKGpVr213dCt3upffVDrylvMGhouNB/YhAV4Ut
	W8cZ3QWhW1ltA==
X-Received: by 2002:a05:693c:638d:20b0:304:4f23:68d3 with SMTP id 5a478bee46e88-3044f2446d3mr1548748eec.18.1779512798403;
        Fri, 22 May 2026 22:06:38 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:37 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 01/11] Input: ims-pcu - release data interface on disconnect
Date: Fri, 22 May 2026 22:06:19 -0700
Message-ID: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253887-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 130E45BD32D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During probe the driver claims the data interface, but it never releases
it. Release it in disconnect to avoid leaving it permanently claimed.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 7a1cb9333f53..57d917387544 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -2090,6 +2090,7 @@ static void ims_pcu_disconnect(struct usb_interface *intf)
 		ims_pcu_destroy_application_mode(pcu);
 
 	ims_pcu_buffers_free(pcu);
+	usb_driver_release_interface(&ims_pcu_driver, pcu->data_intf);
 	kfree(pcu);
 }
 
-- 
2.54.0.746.g67dd491aae-goog


