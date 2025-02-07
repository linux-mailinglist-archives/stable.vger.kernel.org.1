Return-Path: <stable+bounces-114309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B1A2CE2F
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 21:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08C81698D2
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157E1A5BA0;
	Fri,  7 Feb 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWoJ5sxD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313212A1D8;
	Fri,  7 Feb 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960526; cv=none; b=d1RkwLpjnmrLhF6alho2Zs8uF+6AsklF6kZo/A0WPX95LBe46RkwYh3Jp3Mm1xEblrpjKsKwj4uVzUF+hY+OXKK37GsYKQsozVlUTvCQcvOWv2YsseFzF5rIDbUdvfCvaZzUbqSzG4lZO3xUoIYY+qko+DiRgWraZBhyLZX/rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960526; c=relaxed/simple;
	bh=G9KcKAxKFAC/b4YNcwkGrNqA43tbOQbPcTdCcV86QgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SDSNSKUdz+iOXAioMhOZFtbSED93k9SIJy6J15hL2IEfDXMiniW6Dgbvo4mbm7MAbN7Rv30EdLyv3QC1W7VTpcTwWQ4wjSkrWNjhqZlOx6ZNr9Rp+/T2tbq9vEOsEuL8U8b2dWbG7libf+X2DNgfEibmEcpMUD+VzWsN73RH46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWoJ5sxD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f0444b478so38055405ad.0;
        Fri, 07 Feb 2025 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738960524; x=1739565324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAZ9nrSjSJku2v5zFd1KkRZ7GwKXoZZd93FIVjbym7I=;
        b=XWoJ5sxDTwl5iY/ag6L3RPdumJlPxvFAwBClVkhYxMELNpyeIW/X113teris03wlBo
         fimxjhW4xpWl6i0/WpOdURGN3toajrOq2EbpaLMupW2SstfjxQRUnKa7zbnJWwVC6DKp
         p3ABI4gHbKesXrTye3fLYces5dQ5Yhjd6FWg+QygZND3GPvv/WwTaC86i/wMhKIH/Z+n
         FH5l4qlTwOd9seyT8PbFtmudH1zdEBJrmNMoL6yS/DvEcZt2eKx3xf62xS8T27EiHzEO
         wvAPgoKmDOhkV8wQI9ZT6kO0L/Ncq5hI2eMcX6jmKmv9NHCPVg1ZsTb4KxVYNtyFxRYe
         3CDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738960524; x=1739565324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAZ9nrSjSJku2v5zFd1KkRZ7GwKXoZZd93FIVjbym7I=;
        b=Cw4ZQE5elNtomqT6CKFengo/2xh33SNfIoFpjj5MUKmUEqmAQ/9c5V9QZWPRk9Y8EX
         9r8ZpoqbRuJIdfmEhPYTGiNYNhS54n0dagf/eTWEyyE+nd3K6PPML0Uu6fKZ3yo/yHUp
         R60PJeT20NkJRPGiHc75tWHG4AGAUG+RwrPfdM+bLVAzkKTHuu546x9ZK7+0X5pyig57
         RcJhfM2ryN1Ls7UjoP7MLiE4JlbQV7Eukg0cVj1BYkiYrQPi26jbhD+XGkUdo0tuoxyr
         QobmJxHU87jrxWjd+b52ms+KSv47T9XHyAW7n3cPlXSqf4HvBa/dlCeXKHEIfyU7FQJb
         7DcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW72VfaXMY6alUaM5E2AlCUnxAAcSsFcFlauUPK029fRGEBob21t4qc8R6lRpdbNVcOiY6CiyXI1ffA@vger.kernel.org, AJvYcCWVhYPCh/gUbWeMRQKwTm1EMFAorlKW7CZk/HoSTDZXRYmx9XOs8srFJyKyzD0dYTgdEkjrkRZPkXXp7ss=@vger.kernel.org, AJvYcCWp4UFLpiKgtPLcZf8xnj/QZjtdlO1C5+OoletD6azV+UNHEavWXwbgHVDgJJAgJDf037ZOZ/sF@vger.kernel.org
X-Gm-Message-State: AOJu0YwFvlsACCGZ/zomltqMDr7mVshyjJ2q+MvNnzNcZ6NrUx5k/lpd
	GzmDZCUP7kcPZme5eVG2GmYnhrjpxUgWcCM5GuYYcHrGAlVH4htc
X-Gm-Gg: ASbGncv3khqF/1/aWQjC7xWiT2W7SPOPF5URIRa6rS3mBqHJgvwMlZRV8Rz67u6QVZ/
	/nyBbo4k9DNAgcH4ygKGM4RqEGx9eazWu+PBNrR1TeAPJX7Jc0F2RgzwjUmlEeFWOidYtf7MzB8
	yUuVCMDAe6Sn/HBh4UEmTZu5fvJ6NwXdJoUZvytbZGW0XmYVFJtVpr1XhuoGGI8v8N9k54x5GoP
	6cAdXxPKWqNrmxDUQeWJFQWqXQu7f3ZBlha7XTUrqG729ia5R+eP8sN2uamegou2FrEr8gmIGuI
	AeJNsQsmFX/SBkSe30e52JduWGHeGCwbNhkDFO3NCFs20wY2+I7DSTKA5xGI3oucAu6CpjSCtEe
	BwV6OR8h+dQ==
X-Google-Smtp-Source: AGHT+IE7rvYPX9KnzEau4iZ3QpadSEO3bvNsKSNP15c3qlj6VhH2iHV6Mpp5kNdpD8wQVhwdqcVUqg==
X-Received: by 2002:a17:902:d2cc:b0:216:725c:a122 with SMTP id d9443c01a7336-21f4e6da67fmr79478085ad.19.1738960524340;
        Fri, 07 Feb 2025 12:35:24 -0800 (PST)
Received: from localhost.localdomain (c-73-98-126-133.hsd1.nm.comcast.net. [73.98.126.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368d2dc7sm35074555ad.251.2025.02.07.12.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:35:23 -0800 (PST)
From: Jill Donahue <jilliandonahue58@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jill Donahue <jilliandonahue58@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] f_midi_complete to call tasklet_hi_schedule
Date: Fri,  7 Feb 2025 13:34:41 -0700
Message-Id: <20250207203441.945196-1-jilliandonahue58@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using USB MIDI, a lock is attempted to be acquired twice through a
re-entrant call to f_midi_transmit, causing a deadlock.

Fix it by using tasklet_hi_schedule() to schedule the inner
f_midi_transmit() via a tasklet from the completion handler.

Link: https://lore.kernel.org/all/CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com/
Fixes: d5daf49b58661 ("USB: gadget: midi: add midi function driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jill Donahue <jilliandonahue58@gmail.com>
---
 drivers/usb/gadget/function/f_midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 837fcdfa3840..37d438e5d451 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -283,7 +283,7 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
 			/* Our transmit completed. See if there's more to go.
 			 * f_midi_transmit eats req, don't queue it again. */
 			req->length = 0;
-			f_midi_transmit(midi);
+			tasklet_hi_schedule(&midi->tasklet);
 			return;
 		}
 		break;
-- 
2.25.1


