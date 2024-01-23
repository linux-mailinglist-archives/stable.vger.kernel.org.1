Return-Path: <stable+bounces-15488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B4783898B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 09:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38E228C0EA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 08:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D4B57303;
	Tue, 23 Jan 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O09u+IjU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D756754
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999792; cv=none; b=M+ApCINSyU9CAdA3ZYlGuVz7V213cDG6VMX0oyVdJQufQpD9ouibjo8oARhPLg78o3x241G9i0Ju63cwv4AmgiDEOlCDM/9njZw7Tc6zZhMjgej0TwBxZXnK7KRwMzKUVaskgvTwZyF84yWhqTzB26F+GKVhEb0zBzmGUIFOeWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999792; c=relaxed/simple;
	bh=DGKrtDGdQPRgKJyhYhrxsoa1aDtlSRmC0I45VLz7qFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iud6H5RrAA2rHfUYOVh6dYiS+gWhQwEekdoV9WF0oVZfMYAdhvFF2l9UBZD8icfeJz4oIBFa/uQ+o5JquCGrOqHcGf+3+Jw+2bOXiIh16OhX0/YL7l98ULJ98LcyMKe/fVVn6hiiQc0um1oMKM6y05ZD9bPe72LBOTjAReHnQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O09u+IjU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so4635535a12.2
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 00:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705999789; x=1706604589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rYVD6pv2AkTe+bgU1Vf149fg5BMC7DKEF46un8wVt0=;
        b=O09u+IjUdL9vt6Z9/Hw98ylOkEUxxROs2Xm9mUsyjVIIj2gCpm4yaS7muwBOOeRgCl
         vsb3oKZ68Op3TrTGOwISxseW0tyQtY6Gdv8EbP8X/ADa1leRY097aXRYCSvMjS4h3MKo
         3+8qDS7EAjZ2g8Gnw8kvtWDRJ+9NdPzHHsnQ8Vwly66iSruACqsL7xmfRQpWfAZsVhV/
         rqDFyfMjFQq1OcU7B7LFyqaA7pP9YcBhiIJbtJH14hUCtHC3n/vKbBBlWUoQRCzzGEAK
         LV8CzroFKviwiLTZiHI40EKTDSY5MAArk0GQWYDS+VOI21IMCxNYct0jpJB7/vSMQ/wR
         6tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705999789; x=1706604589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rYVD6pv2AkTe+bgU1Vf149fg5BMC7DKEF46un8wVt0=;
        b=FNy8tKT0y22rIC2F5+VNZ9fRhJPovRJmfI7xSW8Qh34QouF8W3DkxUaj4DeYcdEJOh
         L27pxOzEyJUmzxgG6xl2Y588xeXwrvbPjex+SlTSgiD+6WRLBtpyy6uM3GzUsHnfIQiN
         rUgONUcZrcfBZU3sQ9k5kElFdVsc8IXjp6C6ggaxqeCTSbQhBLjPMzL4bJtwDZRnc41N
         nb+sfoe517vDk/176IRE8TFVicIYJco6PyYYME/mSsE7Mj9wI7P5HwcdDC+gf8doZwKc
         AN/oWAOR0YqssNCeJ+GLt/JJZzwkn4kmFK9FftKaqHHOHI6ZKiBM6oG60X8I3T7cT78X
         f7Zw==
X-Gm-Message-State: AOJu0YxwGnwjvVKQuLTOWI1PjG0a6PLCXD5wPUNEy3KQ//KNxo5VDGrx
	14k6VxoE68bYOC+5TiRHYvJ98w98AmDHASwH42m+wTfs8VMYfnmRlgrVlbBW1HTfWw==
X-Google-Smtp-Source: AGHT+IHoBnyWDvNxlNKl1ueKqwM1InwHrnZ0ixBcVeLASmOh8UhNtEuVfnTx5YLYHJwzZXUzTbHEyQ==
X-Received: by 2002:a50:ee19:0:b0:55a:4718:554d with SMTP id g25-20020a50ee19000000b0055a4718554dmr521365eds.80.1705999788734;
        Tue, 23 Jan 2024 00:49:48 -0800 (PST)
Received: from napoleon2.. ([2a02:908:1980:b9c0::d463])
        by smtp.gmail.com with ESMTPSA id b23-20020a056402139700b0055920196ddesm12061890edv.54.2024.01.23.00.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:49:48 -0800 (PST)
From: Julian Sikorski <belegdol@gmail.com>
X-Google-Original-From: Julian Sikorski <belegdol+github@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org,
	stable@vger.kernel.org,
	Julian Sikorski <belegdol+github@gmail.com>
Subject: [PATCH] Add a quirk for Yamaha YIT-W12TX transmitter
Date: Tue, 23 Jan 2024 09:49:35 +0100
Message-ID: <20240123084935.2745-1-belegdol+github@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device fails to initialize otherwise, giving the following error:
[ 3676.671641] usb 2-1.1: 1:1: cannot get freq at ep 0x1

Signed-off-by: Julian Sikorski <belegdol+github@gmail.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ab2b938502eb..bf0a7cca90d0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2031,6 +2031,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x0499, 0x1509, /* Steinberg UR22 */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x0499, 0x3108, /* Yamaha YIT-W12TX */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04d8, 0xfeea, /* Benchmark DAC1 Pre */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04e8, 0xa051, /* Samsung USBC Headset (AKG) */
-- 
2.43.0


