Return-Path: <stable+bounces-108244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5312BA09EB3
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 00:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632713A9A2D
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1111C21CFF4;
	Fri, 10 Jan 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="SO1enSYw";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="DZBM4dPf"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DBE214A9E
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736551917; cv=none; b=ADYB44QlQR4AGrnU2SmPgW2hxa+zNwXfeN5tO5AqOMiU268QC/l7qNUt5nWiFRSp0LNkNjgWpoA1vsoK2AvHOypWfKc6E3H7jRdYMC34Z3Q7J4EWxR9VTVvqw/Z6SyD05+dmW61M7ElApmlTAJgfMrL710Fpw2KsrTz7eL8Nmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736551917; c=relaxed/simple;
	bh=RURSYGI9XASBfgKIEyI0b9Kaq4tXDohLi/r41DOBgGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kM4VS7HRtG92xfRxWWPiPncyl00hFkkdlLjA6nZVuQCihu4jSOk65O91IgDuq8h34/MNwOvIImbEp+r6LTlxgC6p4UCEPOiMpo8Tmt4O6XsY3InsWa4vdyrAdjDX3znbHl3021OF/7ffeejQwHXrasrRE3f9PWBenY51VzLhcHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=SO1enSYw; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=DZBM4dPf; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1736551914;
	bh=RURSYGI9XASBfgKIEyI0b9Kaq4tXDohLi/r41DOBgGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SO1enSYwtyN9O3skvnwzCLXSuEZFBoAOnJt/nWXgJ/Gj2L7I7NnabJqG7QkWTNZrW
	 AgXsi0ECAK6MzVzU4I4c4SLZ4v/wioZaTLdx3pXuqdF8uBeGYw0yJV4VxlgIOV8oP5
	 /XqAwuSyOqJE3HqOjBGWafLbJqmPVVxV1Nuej0K/xlN2XNbULLBdGbz88DB1ZBGsqn
	 pD4/wGHJDfORLOnZsYKWrJhendcM85/CP1n1skVOZALTrXKEAFU5citkfF5TdHH9J5
	 J4AT+befMJHGY17CYrnBPCggEhhfAlSbY4XH6rHV+SKSEzEoAkjQT5u7SwlWhWARpc
	 4hQCv4JaOoAIw==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id F2085A0
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 08:31:54 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=DZBM4dPf;
	dkim-atps=neutral
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id D33D7A0
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 08:31:54 +0900 (JST)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5f338c6e11aso1766772eaf.3
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 15:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1736551913; x=1737156713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUjvhArvz4Z9lyGZ4erNAYq0JBaJkrgop4tJc4l0rQE=;
        b=DZBM4dPf+rEpalD/v7Y1gLVDG97yinr9LPrP/+5r2lwpzrxRysIoFm9ukx6ivwK0d1
         goPWHhaj9OQ7zsUifRuFNn/n2hbyTq7nGVvbHv1BDDnUbxR8yDNOo49zXn6+jLRi53Fg
         j84KAaA09uKTSNQg0LbMBsrtH+MG0IxSMf0ygcRxrfpLAsmVOJzlfkKTiBeCeq7zsjL4
         nNqhww4Ud6ERgsGEGM7uYyPKRIiiEPQK8q1dijBVSht/p9jmr6M3MXDZmuUh02FkWoTF
         amHJ6oxtp9Iu0IVzofQ/T6ySwHiw6NNbYA3Kujbjg9gWQmTAhLZrbAmIjq8PAwY+l3Y9
         FGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736551913; x=1737156713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUjvhArvz4Z9lyGZ4erNAYq0JBaJkrgop4tJc4l0rQE=;
        b=upRHyF1QZQnK4H2Ey2o6TfuXd6bNpqsECH3AZKVu3ZyoCJdfn1iDCoIlMEyIpLLCUF
         DPVe01Gb4mKfwt5cZDeboa2sD7M7xEzSKDEIotxmxoYZGnp9Jh/A+xB+pjGL9vddpwAI
         z7Vm/Ylhf48Xerecw3GnQmB9Ui5K9vUti3Vx3Yvq3o9h+VeM5pIUN84PPxZaXAdYPk6h
         Mnqg82Z1TW5RVztVFRaZMlx6IdA3JkuFlR9B2J+BmUUvW01zQBjLoSjHPR9WSHA6rogG
         qBWJ+LS/TN+3rVkUBaIBdo/hUv0zHnJUJM+6jj2lgmRRsJeG3InZj0TOJeILqp2w/SV9
         dJbA==
X-Gm-Message-State: AOJu0YwySraEyHOS0t5z5c83CW9VtlZZUE1tlhmkBKy6l/fOaKLajaQX
	VxKFLv6f1gXOizsM988Sx0QrQTuFzQbKX+31NR49w/Tp6lCug7rsNCelaGoJEN6QlEYzdY/1+I3
	ls7sG41epNawMJeALCb1gGfBi5N+Rv+JMI/hf8xqa93JTufpVLIV2J/w=
X-Gm-Gg: ASbGncuhBfdd7+BcqteEWPfGQ4WtQEYeDki9baQskFk8+dm+IwKHaZOkfHHKzpvxVuI
	WBhOGi7wNc65raiMsObpzConHdpC6Sa9Ei1cu9h+bVg6cKHUi6VPAbfbnRzgHgdX/7D7ZvJ0Cjj
	/IB/EDvBUODwogiYujOFzqcjA/G+WMgVoh12Sx5j4r922/DGFTyY4uPYNdTSJa3pIQT3y5m15/m
	HjXxia4PdJ7zv3voKZNyqTx0ddBRF87ehfTdSgsxN0xJUXpwpTT5hH52rWLYktflFo2RuX573jW
	uxRjIUS2fKnJVSWS3/d2QAmKXUJrtqc1zJJVbIQO
X-Received: by 2002:a05:6a00:a8f:b0:725:4615:a778 with SMTP id d2e1a72fcca58-72d21f32481mr13665590b3a.7.1736495933457;
        Thu, 09 Jan 2025 23:58:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6T6qNg7lpXyjmcNpj2ioKSFYp3v2oidclmQlZ4501snSmtGcTcYi78rLFnNvVeI/UJpY3OQ==
X-Received: by 2002:a05:6a00:a8f:b0:725:4615:a778 with SMTP id d2e1a72fcca58-72d21f32481mr13665567b3a.7.1736495933059;
        Thu, 09 Jan 2025 23:58:53 -0800 (PST)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a61f7sm1029606b3a.175.2025.01.09.23.58.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2025 23:58:52 -0800 (PST)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.15 1/3] drivers/block/zram/zram_drv.c: do not keep dangling zcomp pointer after zram reset
Date: Fri, 10 Jan 2025 16:58:42 +0900
Message-Id: <20250110075844.1173719-2-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110075844.1173719-1-dominique.martinet@atmark-techno.com>
References: <20250110075844.1173719-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 6d2453c3dbc5f70eafc1c866289a90a1fc57ce18 ]

We do all reset operations under write lock, so we don't need to save
->disksize and ->comp to stack variables.  Another thing is that ->comp is
freed during zram reset, but comp pointer is not NULL-ed, so zram keeps
the freed pointer value.

Link: https://lkml.kernel.org/r/20220824035100.971816-1-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
 drivers/block/zram/zram_drv.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a9f71b27d235..9eed579d02f0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1695,9 +1695,6 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
 
 static void zram_reset_device(struct zram *zram)
 {
-	struct zcomp *comp;
-	u64 disksize;
-
 	down_write(&zram->init_lock);
 
 	zram->limit_pages = 0;
@@ -1707,18 +1704,16 @@ static void zram_reset_device(struct zram *zram)
 		return;
 	}
 
-	comp = zram->comp;
-	disksize = zram->disksize;
-	zram->disksize = 0;
-
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 
 	up_write(&zram->init_lock);
 	/* I/O operation under all of CPU are done so let's free */
-	zram_meta_free(zram, disksize);
+	zram_meta_free(zram, zram->disksize);
+	zram->disksize = 0;
 	memset(&zram->stats, 0, sizeof(zram->stats));
-	zcomp_destroy(comp);
+	zcomp_destroy(zram->comp);
+	zram->comp = NULL;
 	reset_bdev(zram);
 }
 
-- 
2.39.5



