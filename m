Return-Path: <stable+bounces-244225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFtnNU8q+mkhKgMAu9opvQ
	(envelope-from <stable+bounces-244225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:35:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A54D21F4
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D579302C369
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F1F4A33E1;
	Tue,  5 May 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGqabq67"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5D49251F
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002502; cv=none; b=qNql0Qpjj06PJOWIXi/Q2t5iH/6/mcMHEFu1CzeXdeL4FPndaOWslgZmLCftJYSNVRHJG8rH7Keg5AwIozaHTrGcVpY9icCeiLupNUEr4MKfjkXugefgJ96AdcYEgk8/BDuEjC5ZorLBJil+tmGhMwhpMcSJ3sd92Q2/9ePDpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002502; c=relaxed/simple;
	bh=edBtExnt/8Z64dbOcPerVqZrRBJ+N7vMF3UZXd8IC2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlFAXsnyUQEQ/azBxN/niogY0U3PoZm5VutNzrcrBoquhFeOW3BmesPnIskW5QzY2JlJjT14U3o3WbITyaoGbdOl3BAKltO9IgowCHOgaFc1qoEBNHp3TgWetZAYq0b2OYvijXyRLlHVB+zyAgcYjvmBB0qjVphSbWH7B/6kDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGqabq67; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4446960f8f.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002499; x=1778607299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pL+cn2XdiJz7sJ1VmFg0Jy0AOXBj9195E1nbspZlGtU=;
        b=BGqabq67SmRMnVfGcnQ0ibH6ceUY4riiUHkGzgMG5/Jqc9HZHDaqLMqhuNxayxYq0r
         9H1GzfBcTZlqOg0NQjM6vdfnDbCaEs16UExFlJQyFrj4IIgdeUFSY6IdugNIDMe1gRc1
         /+Fo//g3glp/xJ65gKVOmusun6yGxICQgQIAawD5GcS4dVXOQS8a2cLzkDKZ9KUQEx0R
         WRTtbbjWmUTZ982yH4kkSLRblcVKnDYYBkUZ8nzPyPwJUAW56FHbqlFwC+YDFWa0aAZX
         EIxFICKRdT2iMNiBmTmha8Ec2HEq+i0SpXsiMdb+1tBxeGW9uKXP8DBGls/4W1BnGxvT
         Z7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002499; x=1778607299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL+cn2XdiJz7sJ1VmFg0Jy0AOXBj9195E1nbspZlGtU=;
        b=FP0iEAqfC/JWUbvSKfZ1JKxzCz2EJe0l0ARw/2rvj6gkQWFUtUwJkz+L4Qsc/aQnRY
         lY48lABS9+7fCXLArAObW1TuO3sE0PZueo/y2clQZSpbJWh78f6CzXcPRY/wkQjoY2Ce
         TF1cjo/ixdix7jl0TWA+Md1f9nj2Kn4xhZANS1JXKaZtzGREBmKtiVfZtNlnVDgOCXIL
         M/r1S/d6orbx2IOtFLMEcfgAZHGdUOuarLSAJP0U9LFYUp+KzLasOwLQmaGtGWqcBgEV
         0cuW4asdXX85fRaaDvpZ+q3GCsOVrOkgUYvjx5MM33QBCm0/xzulofLJx4ePqruz5ea7
         lXTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gfTgG98s1rfxm9htArtPukVJI/npX5Ah+R9KbSIKe40XvGdOOKBIZ4+iwQ3LgzUr8L1qCBw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DzEir6SjOrXXy3d5yWlAsy9Bu9gXbd4LJ9tVk/8wxoGNlnND
	ceVmCx6SXbCBy/AYiUfRxG6L9WkWeZNvt9e/8ripVscPb7wnz05ScbRF
X-Gm-Gg: AeBDietCxRfSoSDFR9dquW8LtnH9508/VlJNExmC5qoDc5/MCB4btjt8ZUviyY7Ijtj
	akW67yC/ccIo0pEk2KxwPKguhapE6CXIXyW+6JsvRHAYNlWgH+P3VOm+Eomm3TMvP45obF2yVdL
	xDPMGu+3APj4LZPf34ciKNt/Z4o7seCZq6t4nc6GtNJIxtpd0+b0DgagtDj8GN6VxN6bYgsZKY4
	CLQljxrZEjizmzPFJxFsVVYJ7HC23aL14K05Lfcvs+FLKRNG248uxObiIItlukouzK627ekXjCK
	IFIyqtSid09xFF/+Tzbmq1tvUg3mqd9UNp6muL8cPbOPXmI8TGaaJwhzLcOtYN4rq3FvUJNM624
	E5HzlWUkwZQlCvtpSh/S2wt6hGKltVg1s2QYxxLmDjzk8mut3FTP1XYEGwRhZtarI8/+UR+2YXF
	4w0Qwz4sua68bl+Fy1b36t5FWGetSXG4Y+4jDL0A+NHzVpFgrZxcRuaXUMfBlxuFBMp+pcEjMdW
	BoAxPogHy5Nw+orGz2BgIvj0JKjdT/D
X-Received: by 2002:a05:6000:3110:b0:44a:8880:ffd2 with SMTP id ffacd0b85a97d-4515b056b8fmr119815f8f.4.1778002499107;
        Tue, 05 May 2026 10:34:59 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a4878fsm5856560f8f.9.2026.05.05.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:34:58 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] iio: pressure: bmp280: zero-init bmp580 trigger handler buffer
Date: Tue,  5 May 2026 18:34:55 +0100
Message-ID: <20260505173455.181358-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F4A54D21F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244225-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

bmp580_trigger_handler() builds an on-stack scan buffer containing
two __le32 fields and an aligned_s64 timestamp, and pushes it to
userspace via iio_push_to_buffers_with_ts(). However, only the low
3 bytes of each __le32 field are populated by the device data:

	memcpy(&buffer.comp_press, &data->buf[3], 3);
	memcpy(&buffer.comp_temp,  &data->buf[0], 3);

The high byte of each field is left uninitialised on the stack.
The bmp580 channels declare storagebits = 32, so the IIO core
transports all four bytes per sample to userspace as part of the
scan element, leaking two bytes of kernel stack per scan.

Zero-initialise the buffer before populating it, mirroring the fix
applied to bme280_trigger_handler() in commit 018f50909e66 ("iio:
bmp280: zero-init buffer").

Fixes: 872c8014e05e ("iio: pressure: bmp280: drop sensor_data array")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f37f20776c89..431476cff883 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -2623,6 +2623,8 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 	} buffer;
 	int ret;
 
+	memset(&buffer, 0, sizeof(buffer));
+
 	guard(mutex)(&data->lock);
 
 	/* Burst read data registers */
-- 
2.53.0


