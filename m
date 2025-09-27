Return-Path: <stable+bounces-181804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7FBA58FF
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 06:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F983327BEB
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 04:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B94225413;
	Sat, 27 Sep 2025 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdVWnDfT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE6212552
	for <stable@vger.kernel.org>; Sat, 27 Sep 2025 04:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758948213; cv=none; b=kOT488EIEiZkzT4KifoGsoxhFqzDov+MxMj1Eyga0Akgh31vHvdTx3EEGqmCvGx+ur2Iq9Hbi+X7d7ELlEg069QQ5TUkN3bOug6xe2j2pBWrU/Ttxpp7nzD5yKcMAK+TyiZoW0Q87gM21VJ9bacNAuuUxNE08hkTSq2v/oPruj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758948213; c=relaxed/simple;
	bh=e/qEH9tlcTF6ZGczycty+bDdjQIpv409fmI2gPtm0Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZiQ0I+4CSqVQZif6q4R+etDF4gZgtvQIKKM28qGO9GaDJheWDDcloHXlQIVU1JaFvTtkDBO3RjV+743Gf64IafAaFkziJF4eWsHQ138oPnkX1eYW2Z0nsVqfPhWVhSTw5KGS/f4p3OygaiL79QqidJYoTrCzgNel1EdEgS7DpHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdVWnDfT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26a0a694ea8so25609555ad.3
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 21:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758948211; x=1759553011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKJeS2CDtsADQhZCOXcT1ATZiZ5XIcTlE4PH32ZdpZQ=;
        b=bdVWnDfTKkwfA3PIY4XJcMdK6xIWH50sbaDzbSlMWc8i2WUfj3GpYC+/KTAV2oKWOE
         32Jmlkxhf2araQqdwzYsIZJHmEPsHucKp88rT04Nfathu9AtyiPSOWmWpIat6U1FTegO
         YWpXuvGbry5Nmf9zJ8KaB13e/eflb5EdVZdbOY2HMP+VpzawwLkB/K5nNy7/56gGd4m0
         M+Nkj7fDHyWhxOTZ5ThqS8Sf9TnZNDBkVu/qOme/s3qao/h/eBHmHRpI0JxiMeik8a13
         OFJRGxAwn5Qm1nIJqiFC3/8sy90iHbpvMpufu+7Oy+2MnbGG+FTJWCeQUzbZYwF/tdsU
         HbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758948211; x=1759553011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKJeS2CDtsADQhZCOXcT1ATZiZ5XIcTlE4PH32ZdpZQ=;
        b=Rwo2CiSsJ+j3fnjXoKLso497h/FdGb234n2+2AX1wnKjIaAqOudjLheh3S8sPWCt67
         u9WqTIgM0pFFHv1WhAo3Q+7rtYRpd6g2CUgx8CwDQq1e2cv+ideVwy9clz3/AqmXejMI
         dfvtaRIJ8HPXRiU5cg4b4APNay9fKD64/g62kZGG7bYnwVpvCBC55pVzjxseiBK36CuX
         LImV4KUJpkVUyymOLHMlKqSE3MWlRjhcgvV9glKnFPZkmjT9vdeW0Fn5cPwP7WSWWp0I
         IkOHJLxqT2d5CKWw4SRsacVVQysxytO+unlRuYM23bQqbokVkhUlhp4+mKZyVFKk+KH5
         /5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZAcNtzk1Gh7BYU2qWVVbmrU1+FVZjGHv+IJx6JofJiyhpFE/ezXZHIc5isUUf7n/brZcvmyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57wWDV9aOgX2o/whBMbIx+I+vEKsX+Lqor16ZRKMehZZiYfKy
	lbC9rsnrhbKSR6p+kQ6b5eSVYI6Ve1b8+nCxFK5o5EIzplVUb8mC/IQgu64c90Pt
X-Gm-Gg: ASbGnctmvbvlqAIjy2OXOzvHhRCLwB+EP/RHtdyJ0r3b0QrrLMmVJqeaqLglCgwsV1h
	2q03LTHq34r3EOYW6L5se4w9idOaaSI2FSGbP7TejQFmic+MnsfIh6dBj+fyLdRM6dC5YaT9sdR
	wDYBwDqIw+NAEJio4i1qLQ6sG0rXaCY8K1GfSKF0BNXeND1KnPjT6uWXPj1Td3DAeahv4l3lvIF
	1Vd6FcKtoyHxljNs/ck6HUyddxyb71X+eD4oAMPMnxqDfLprUdsFSBpDMauVoFLyQysOHzVmcy0
	9kUe2sQZMBwD7yfBKmRA9xLJnfYXWKJpAeWJT0z60mVTrEatpFmKAvri/OgD1YuOcaDm0m8w8cX
	4RCsmu7vqzPC6L+awKD6P8UftU5e6WXrD6EjQ4dzN0bkgJBP/loikt+RkBwjcsteFONymC+Y=
X-Google-Smtp-Source: AGHT+IEY3eTrZUiwTbercFWJQUAUjNTQOGASGgG4KnUUAungvsFhTUVY/HHdH4iilZbaAJZYw6rUQQ==
X-Received: by 2002:a17:903:41cf:b0:266:3098:666 with SMTP id d9443c01a7336-27ed4a2d5bamr96103885ad.32.1758948211465;
        Fri, 26 Sep 2025 21:43:31 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66f9257sm68318205ad.35.2025.09.26.21.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 21:43:31 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
Date: Sat, 27 Sep 2025 13:41:06 +0900
Message-Id: <20250927044106.849247-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at
removal") patched a UAF issue caused by the error timer.

However, because the error timer kill added in this patch occurs after the
endpoint delete, a race condition to UAF still occurs, albeit rarely.

Therefore, to prevent this, the error timer must be killed before freeing
the heap memory.

Cc: <stable@vger.kernel.org>
Fixes: 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at removal")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 sound/usb/midi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index acb3bf92857c..8d15f1caa92b 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1522,6 +1522,8 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 {
 	int i;
 
+	timer_shutdown_sync(&umidi->error_timer);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
 		if (ep->out)
@@ -1530,7 +1532,6 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 			snd_usbmidi_in_endpoint_delete(ep->in);
 	}
 	mutex_destroy(&umidi->mutex);
-	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 
--

