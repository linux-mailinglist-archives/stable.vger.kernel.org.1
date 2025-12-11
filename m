Return-Path: <stable+bounces-200763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF52CCB49CC
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 04:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9C7C301AD31
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 03:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AEC2C0298;
	Thu, 11 Dec 2025 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJRzOHK1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7412E25C821
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765422701; cv=none; b=gFxxWTH3bXTp9rbDA/YeSgfRbLagqQR/+PWglPJ5iC37hsv6gbgntXeddmDbgreSdn11e0/D/i2B82qz6ZRLW3vIxbdVTM0Vmhw7hz0dZvptB4FC+tF5QnbPWExDqfikkEC7VnD4nw+cvK29l3G+dbyv1v5sCWeiB9vp7GlwGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765422701; c=relaxed/simple;
	bh=FBUewJzNttvBj6dhO4FEss/Md1jJMTZhw+mgqA17V14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k1ab4PvSvSwjtG+hL4dsyOYtZnN45LEW7HUaTAaPYY3LNj2wBMup0nOnWpQXbFtAawWCZJpx6dPaohljkip61tSDE+ZBuDtlWO7aNELS6UnJmN98GEpEjkUSm4HrMzhbBvdIYZMGG04+EMML4sUg4lj9Ag3rFYTNUpw8+m1BjbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJRzOHK1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so413640a91.2
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 19:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765422698; x=1766027498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGCWABPnAEr262wrNDG5Ce38cd3v/xWYcwemzU2UFZE=;
        b=AJRzOHK1eBaII2lpqOu1Sy8rYh6O7WAeu7l7Dmtrns/dCxjV2hFZS07Dh347HFbahC
         erybmc/gwALK0qXLSbRW9c2gZdqGUx48cJdC/lxQDBUpZ0hnnQ0F3xV76ZFkQz9UsGAi
         wuhxcNuJoVjxbqmqmCr1e8HjIjjYlmWE8qHAjnlenDGlRXb1J9WvN+d86KLz4Fuxiwsl
         E/By+O0jGGcniM6XWCXk0/d5a5BOScOfl4oYwxwXZBPoGRJvRZK2JFSm5MFTTs9wNAAe
         S2b18c9WZnK7RfGcaJTVc1dSPtuvmXE6N6MwFUP4SHE7cuAs8ZyMc6MQwK4f9MuGA478
         QVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765422698; x=1766027498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGCWABPnAEr262wrNDG5Ce38cd3v/xWYcwemzU2UFZE=;
        b=inUaEvcoC5vbzlhlxrwZ7Txm4Y67ElnHHnNNKh8XU+gI4YtuWNRtGOaMm/d3pYqH9U
         RG78WPn7UUIxRAJya9+kpzHBPIEDXD0fYhsNZNExg2NZZM6NZqy8/Yk7u9Yb1XYddG2p
         Y4Oi7bg3mN+dyOqbxHyPjBzpDRu0SwcW3H8VbZkcRcc+3G29DqKLczlg7pHFiLJozqIe
         1GW8L+WHV5AbTJRkWPnrAPrD20z9xlTcvk1CpmuZpwRS4ZJsovAcNjT5fxO8A8io0u91
         iy0kiJT8cET8Ptj38oZF7zPyJMbEVgmvr/jCX7zr26wPN3G88oKkKhfOmtj6NAK+u3DT
         SQIw==
X-Forwarded-Encrypted: i=1; AJvYcCUeUt+Xotv2xq4eKnD9putg1YWHP/t0UgZEWmoAgjoqnZbDTwVxr6469noM2oE3U0Pq2m28V30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0p7Ouaxhncp15pdr8GowhXvVLg3vV491SrJg6MU2kJd7omlZ
	CwNoU0eBdUvIVoj0fM8eIOY857zd9XvHumlTMPOEPwgKDHf8iLBq4emizygVQw==
X-Gm-Gg: AY/fxX7bjph2x1dPB4j71KcivsS+IZaRjK0bI0MAOz0DzNUbSA3SiJRelDJz5+hirlA
	XM/1617uU+1+kjsxVS2Tsa1VqRE90AIDsr8P39DHdD29Gzm+6RuuFQLjQIKJ/bboBDcJ/1V7sqy
	S+2VlNBAhZlkgrqb3Zka5JmrRAt6WupWFGkXJsrH3C0JC55w4osMCBu36N4pP3xoD1qYf141uni
	Pgn79H01wtg0P7KLzf+QXdu2hAg798F2XX3XG9REo5Z/RAj5SoLmeEVrzzxK7ErNvbHhe3vZtfR
	kVxRBr/U/N5kd8fFlpSXFe3CWLPYXEK6MvJKBqydVT3N73kiBnZ7RIdQFJFvabWSXeTxC8ecgJ6
	55cpaKRNe9XkZ5Nfdtx5Wq30rKpFR5+iacdlNXiSTT3TXfjOz/RzD6oF78D6LAGbdU2xnXbCarL
	rmqqLnug6JsEbRIcnElJy4rDw5Hc5nCg==
X-Google-Smtp-Source: AGHT+IHWcmTOZsaghTibxhIuW0UStAShWvIpbZoqG6v/jKdNCs6tlxwCwwle4nhzr+QPOqrUn6J2HA==
X-Received: by 2002:a17:90b:3847:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-34a7284d09fmr4788926a91.11.1765422697736;
        Wed, 10 Dec 2025 19:11:37 -0800 (PST)
Received: from localhost.localdomain ([121.190.139.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ad5961asm774231a12.18.2025.12.10.19.11.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Dec 2025 19:11:37 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Minseong Kim <ii4gsp@gmail.com>
Subject: [PATCH] input: lkkbd: cancel pending work before freeing device
Date: Thu, 11 Dec 2025 12:11:31 +0900
Message-Id: <20251211031131.27141-1-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lkkbd_interrupt() schedules lk->tq with schedule_work(), and the work
handler lkkbd_reinit() dereferences the lkkbd structure and its
serio/input_dev fields.

lkkbd_disconnect() frees the lkkbd structure without cancelling this
work, so the work can run after the structure has been freed, leading
to a potential use-after-free.

Cancel the pending work in lkkbd_disconnect() before unregistering and
freeing the device, following the same pattern as sunkbd.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Minseong Kim <ii4gsp@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
---
 drivers/input/keyboard/lkkbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
index c035216dd27c..72c477aab1fc 100644
--- a/drivers/input/keyboard/lkkbd.c
+++ b/drivers/input/keyboard/lkkbd.c
@@ -684,6 +684,8 @@ static void lkkbd_disconnect(struct serio *serio)
 {
 	struct lkkbd *lk = serio_get_drvdata(serio);
 
+	cancel_work_sync(&lk->tq);
+
 	input_get_device(lk->dev);
 	input_unregister_device(lk->dev);
 	serio_close(serio);
-- 
2.39.5


