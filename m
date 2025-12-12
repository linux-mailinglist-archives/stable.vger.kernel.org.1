Return-Path: <stable+bounces-200853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB77CB7EFD
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 06:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22572304FFC3
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 05:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F902777F9;
	Fri, 12 Dec 2025 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5UekH2I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23E240604
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 05:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516761; cv=none; b=TZIPO0sByOK7sTbW1Q/4zrz/oh1+sh9vaEeQ3Uv5ta5aBk5G+jWs4xsDxZC0tK5bIBuVzgWr0RHkrk2sAGw0KXB46oNQzQbkdQMTTthNWzypymXCDMwpddb4aw+bsdRshwRwhmpEqrAvayRmxThWI+mY1WTb68p353huKwDUmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516761; c=relaxed/simple;
	bh=ncSfG+DQWHiHJ5P/tpjPaAOggTR0P8F+F2Kj1x+1+9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrX6LHyNJzQsR5hREfC1yGqRSYOYoNI71p9nDjqcSSflpNFFJS8+MXxNYrLtWgw+zVBMCywB4yAjqHUp8zkwpuFsicAKIFgJ2FtzMc3TDRb4+ydQWQJLVJAKvbvUe99Ivh+1LtauS2XvsGrf8eBL8/1pZGS92kA/+SesroWxVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5UekH2I; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295548467c7so9999165ad.2
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 21:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765516759; x=1766121559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KabGZGJyQG+etjOxlMGCNny58DR5Q6sGGHquVVHLJAc=;
        b=W5UekH2IjRVWY0eNTb7/YrsvfIkhH+e7pJKWd0/WwIhGa79Zz/TDe8t668jyi+tseo
         HcC8dKfWnUaFtpHEJSyqv9SsbuX7Kz1b2Z5aZtUbGZE0bAWbR+FVFIu9AQpy0Jc4hoRK
         2cOrCoOhGIpmI7FgZhSpvj3DEcnc9UfQpIK2zmdmNB9apb6LbiTDThLi9B4Wtf1kp54F
         VvY+fpIsiFwrwPDrsMjT0uFG0fVHEAzJWJU6Wr7Ib8ChLxHJtvnNLNTscsDZt04ArpLO
         +gxN/8yXyLu0uocaAsfrchanweXtWyWWN2rZVF39QdDs0fMCLYKFHWyiNlY6W9hlGDEA
         rY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516759; x=1766121559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KabGZGJyQG+etjOxlMGCNny58DR5Q6sGGHquVVHLJAc=;
        b=IzSlb7Bp62bIHpOqEPMMwY8kn1lEUzJale1BMeD6stD6j6ZkQFEL+uqhslBVBne4M5
         IM+gIZupiy7ZGcdP24W7H5ggXfIBrHJmELnVPO4lYSqzyumOMugxCya0hswl8FCugZNd
         iF8c1MvFiNc3lhFEawAKGiTuGmGzDGv1YuLYhRgAbZ0yf9CkcuxrOpt5fzimtJfkjeHV
         ir5gJdhASoAoNbGed4Re5nEgZ30RZYAZWc8922W8mLLaZS4jYzfGuQ8+khXBDEBoFuUH
         6Aw3to/1p40yjhqfiQb9sTnWQE7DTvrTUw3oS7NSVMXLlPXPFObNkc85wRLPLK4sOmQv
         K38Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSdIHmQ7+Zvc3iG+2D1HCHEHBt3IcLFDhMCdQ9p02U8ygtKhUMTLX2DsbMl4fP47DJnlrTZwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkdSl6hKIJWcJd+E9784VkYXDHBjsUqhLprBnd+i47RuPmRA+H
	sp7oJK88/hh1a2ikdX3Lqw4+0oq5J4XF+daK6vKtPLIMS574bg2dQoHC
X-Gm-Gg: AY/fxX4FaOTleQ40ojTD3YTDNCaBDQRpTuTGAPW6YaDAma5nAX3bXDoYY5GQ+thCsmB
	OdLnI2AZdc/eXdSSyuTGvxWSzNpC3U6JVH/NP2tYTfvoJVKx4wPmEdh2A9PDr2zS5g8d+Pns4sV
	U/YVIodPsQtlVecAhe20QWBuTcy1sRgOyd9qM2B/g0of7CM9dh7nOBYw1tlFHoefYfhNXoBiVPA
	/ezjAL7d0CUQ7JWuoMqXTysfX70MWhWrbJe5NeEk5H6hB1UfuokbaSWUI0TQ/MDxidkxxJPiVwq
	717Vu6grEPugrc1TxvtglQstoBwXp1dE5ZkN7DF/0sp5lY9lYQlfFmf8t5i+PS9uMQ0CHukFcUC
	43dodMGICF11mtASnO9RCL6meGHEg8JwaiH6RLyIhUza2cHOnJ3lSphUWOF7S/W3+Ifj59gXIgB
	Mc+jOlHKI8fJCJ2Vauy43ScAxDheQ+VJLEty4vYAA=
X-Google-Smtp-Source: AGHT+IEJC8tmcIeQ8/msRNMMooDb03utB3QP9Gwo6FIkUfmIXMdMYfikSPWRyRhseRGOb5HVS8P0FA==
X-Received: by 2002:a17:903:1b45:b0:27e:dc53:d239 with SMTP id d9443c01a7336-29f26eb2a1cmr6908275ad.35.1765516758906;
        Thu, 11 Dec 2025 21:19:18 -0800 (PST)
Received: from DESKTOP-6DS2CAQ.localdomain ([211.115.227.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f07d139c6sm18148085ad.89.2025.12.11.21.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:19:18 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] input: lkkbd: disable pending work before freeing device
Date: Fri, 12 Dec 2025 14:14:32 +0900
Message-Id: <20251212051432.13271-1-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211031131.27141-1-ii4gsp@gmail.com>
References: <20251211031131.27141-1-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lkkbd_interrupt() schedules lk->tq via schedule_work(), and the work
handler lkkbd_reinit() dereferences the lkkbd structure and its
serio/input_dev fields.

lkkbd_disconnect() and error paths in lkkbd_connect() free the lkkbd
structure without preventing the reinit work from being queued again
until serio_close() returns. This can allow the work handler to run
after the structure has been freed, leading to a potential use-after-free.

Use disable_work_sync() instead of cancel_work_sync() to ensure the
reinit work cannot be re-queued, and call it both in lkkbd_disconnect()
and in lkkbd_connect() error paths after serio_open().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
---
 drivers/input/keyboard/lkkbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
index c035216dd27c..12a467ce00b5 100644
--- a/drivers/input/keyboard/lkkbd.c
+++ b/drivers/input/keyboard/lkkbd.c
@@ -670,7 +670,8 @@ static int lkkbd_connect(struct serio *serio, struct serio_driver *drv)
 
 	return 0;
 
- fail3:	serio_close(serio);
+ fail3: disable_work_sync(&lk->tq);
+	serio_close(serio);
  fail2:	serio_set_drvdata(serio, NULL);
  fail1:	input_free_device(input_dev);
 	kfree(lk);
@@ -684,6 +685,8 @@ static void lkkbd_disconnect(struct serio *serio)
 {
 	struct lkkbd *lk = serio_get_drvdata(serio);
 
+	disable_work_sync(&lk->tq);
+
 	input_get_device(lk->dev);
 	input_unregister_device(lk->dev);
 	serio_close(serio);
-- 
2.34.1


