Return-Path: <stable+bounces-253890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFtIOKo2EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:10:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC895BD3C3
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90F84303D716
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E75332913;
	Sat, 23 May 2026 05:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4zBCE35"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D4330668
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512809; cv=none; b=iPlLc1bknd9OcjvxhvNU91s7IS5/GnDz0zhGbiLGRxmgrbSjWxuLnWMyylFatYwPXaBJAYu37GFDSyr/HvZUx40tFulH4PovgK850fL+o9lsSZSIICAG4jixlzAZ1+65S/1dzsAQK/SJeLmRaFsbp4kPP80GR//TaLPdo3urKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512809; c=relaxed/simple;
	bh=D49s69jzBXejZo67zjSIej+Rl6VSAaM7KMlYezj0434=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJTdhkyVIg7KRZnDUI2wp599nKvw0GDES1sX1xyZ6rRZk68c+J/T/L/maXm2bW3Od2aBZN9TyuxceJyqQQqYVcywVZVOj836qDxrriB0pLyX3H0a23wbq2pt1Z95n4QjmGOYxAQQ14wveaWTleTMZEE/5uO3UaJ21u8wy3QUaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4zBCE35; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f33ae12f97so2499156eec.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512805; x=1780117605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYWslJK6SpSjatzdYnqvuc5HM66+pB8AlGJT3pjZSU0=;
        b=Z4zBCE35xakkjGzhJNH9lSmDKEush9ifnr+m0A6lvQnRWKmTEpORwT59wEDW5afg+/
         20NVOfFjWuaG/a08zJWPTtM90IeFYsgtHqsoRhMrVCpPoPTA1gpxUN+UzJ7j7Oq113vU
         yWuaED4CmFOImIb1tiBtQ0e5yQc5huB84sfxwKdIx88YTZi6qycMZcZf1Njc9liP4W1b
         F2uATUT9yh5Am4MHmkHUWQqsrbsyAz3FTkeitESOCGw0TyRZQl0aDdpY8Ub5D3/VaDzC
         l4iCuR/CVGK4cFypT93CR5wZTTh+CCn3E6ZWBicEHc+qfYfGmgEjAePKo32Ufxm6cYj/
         IwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512805; x=1780117605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xYWslJK6SpSjatzdYnqvuc5HM66+pB8AlGJT3pjZSU0=;
        b=GjElpD7RJCeoQm0sYeiP35x1VZpH34nfwPPRjtSctaR8qfs63evJnc3dNfUATdGtfE
         QQLtN09BuifDync6Kx+/a+hqsRPrsE7Yqyu699GhGbg9alZih65fDNM74tI7VK8BYhCC
         ATmWyAUS/h9zrmwIabJ8Q3SfvxiLjetPMM3ufFCmtbjiQ1fENA5ReSynuQwOZDFhstU/
         fkBjV0jgFhq8YJ/9VzloiJVF9wysEArRg9vZfZXiekpdQapywHNU5K2ln02UK1UTLpVJ
         0CYEqJGrT/t2f2FlgXXDybdQUOcQuIRvz+4abbvC+2Z82zXExz4kPAW8HRjbHtRmgiOg
         qEDA==
X-Forwarded-Encrypted: i=1; AFNElJ/GNJNxFXMPCjwoZHOA5wkZwYzQvw7Ja7HpipskcQVts+sR2ZrdV4Q0F7FaVbS7LDdGdylXkKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWTCvZDMIbz5nQ+me7wwAnRfc2erI9CO63ZJ/Kg7NmHr02UT6
	bdIcPjQm+lyOq9MTzzpOuIRAySlhYEA2gkeR+xfza+MuF4pBI1+bXEARTtpA2g==
X-Gm-Gg: Acq92OHUabR6U8AIrN9rNnVnUdInOzHIlw+Vn5/oWz1Fzu/5TBtLzyGKxkKoVEhNUJL
	84ARxglFvxNFrpkgwAvFbzxMLsqyH8W/uCYWiZGo1hno7M5AN7mOofMvGi+vY1QWoerqJuCK0bF
	SKQpWh6LYsvLn90ZYKnNxqkXmTvwK3ipV3GZgqT/eLQjUK+iH2erTESt3l7904/K5MmiyyyJ/6g
	VUfilGaftzKyKjQTrE7XtAt5jXuvI9+/RvsA1QjcGyyW/cAtoa0Xa0EqTaVaqsjhEwQRjzBZluF
	8p8HAAYDAfc4hLiYquQrJ8JDa0Z0qtISZTVAb0CzVVuuiXuYY8Igz5HNGpuVtd+16gq3EcHIIq4
	oedzCAAhN0IRMPz1K+VAQZt0yCSJVamKT+OO65rjFTgJ2rH+N1S8lIa00qX8biqyiZwCec6dvfN
	VQvVDknwMIH364irPckZ9ZeaFNuBAZywz6A6r+jd72rc95oozqeIpbDs8UwJJ8W6FY8LyuM5XIe
	4JVGozt2RGCSg==
X-Received: by 2002:a05:7300:cd8f:b0:2f5:3641:f10f with SMTP id 5a478bee46e88-304491ebec3mr3466361eec.31.1779512805103;
        Fri, 22 May 2026 22:06:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:42 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 04/11] Input: ims-pcu - fix firmware leak in async update
Date: Fri, 22 May 2026 22:06:22 -0700
Message-ID: <20260523050634.501509-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253890-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5BC895BD3C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The firmware object was not being released if validation failed.
Use __free(firmware) to ensure the firmware is always released.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index a134483e543b..f86f9a5a7564 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -934,9 +934,10 @@ static int ims_pcu_handle_firmware_update(struct ims_pcu *pcu,
 	return retval;
 }
 
-static void ims_pcu_process_async_firmware(const struct firmware *fw,
+static void ims_pcu_process_async_firmware(const struct firmware *_fw,
 					   void *context)
 {
+	const struct firmware *fw __free(firmware) = _fw;
 	struct ims_pcu *pcu = context;
 	int error;
 
@@ -956,8 +957,6 @@ static void ims_pcu_process_async_firmware(const struct firmware *fw,
 	scoped_guard(mutex, &pcu->cmd_mutex)
 		ims_pcu_handle_firmware_update(pcu, fw);
 
-	release_firmware(fw);
-
 out:
 	complete(&pcu->async_firmware_done);
 }
-- 
2.54.0.746.g67dd491aae-goog


