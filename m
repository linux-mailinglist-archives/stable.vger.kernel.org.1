Return-Path: <stable+bounces-109132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB6EA12476
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 14:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C0A188A146
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B6D2416AF;
	Wed, 15 Jan 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bio6JrVC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147982459A0;
	Wed, 15 Jan 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946651; cv=none; b=puiC3ccuM8H3U9RIyMmipNFzhEHA/JczwIVPYd3QbkuKpCDthXN14AORZCcfG7M2w96hFdr6pFFHaeasK8nfCqLHOWBVTSniXtO3m9D5JVp2hDW8hZdcZeSCURN8wcEniH6iK+BkVyQdmmu15fuqq4ZGnru+9JyQYJyTRG4Yn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946651; c=relaxed/simple;
	bh=UEc5yLBXuBeYvxSw1si8V2wt5oyjKizUIPkah6yqmLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5/lnDphcI5sKQbchy2uf6H2wv/45r2P7XeZw1QIkPxGvFXSNzHn+BnjH8JzqIn2r+19i4VGihkfZVoJgB9/ft2XzWFMp+IaHrZNRKM/2ecS7HFDpNRubWPOwUsXMDldN5bEOOs14J9T23bB2q1y+BEuzVISUPwkYCDFHad0kgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bio6JrVC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b662090so116842255ad.1;
        Wed, 15 Jan 2025 05:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736946649; x=1737551449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TCDMt69gV/RVlnL9GMTBlumJ/KvFBRBtbeV56hYCYnE=;
        b=bio6JrVCB115afswXFHBVZSpE0ICJGDB3wt8wQMANzy6687kZnqsB8Z8RNIecPBZ1d
         xEN5dt1vGgT1Sq2838YW7m5rloFoxgqWIwE8SEIVo80+p3BA7pqKhF7+/toexgXnczMi
         pElAOO3mlUMqjWXOJWrfejBQDjO1bbTl/p3FOWcg1lnTvxZytR6AP2CUCz2WAM9SBLiS
         49gNFq4+7wRPi49k/Wv9mwl+H5/W78xFIt6ej/oOuSraTKLiVJcMRZWdEzwTB1/asqTb
         OobY6O35ZcCjjbl1t+jw+UK9A5mzsBlqod6QJwzYNOZ7A4KpgEhETOhA2xBa+KbHwipO
         BxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736946649; x=1737551449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCDMt69gV/RVlnL9GMTBlumJ/KvFBRBtbeV56hYCYnE=;
        b=BaHdlfu/04bJCHbY67OT4wX/pI2PN+OkwOemSczCXWHIEax2yBxjptCZNY0hVOZGzm
         gNHYZhdd7RS3b472zIdjdCb4QuVgESbJnUZ0epNluGkOrHM+soiOYpTnXjJlC77wzMBX
         t1pDkw50FdR3M5wXxvIqE0bg6ItINGsIVB/9ZPaFNLILwrU653TnNSGypp1Ahh4GeiHJ
         74Ce7FLSsHgRS+6jSWxMFF59swKb1Ap91/xwr+oP2DqTxNgj2kicx56SM/prsGZRTPQi
         8h1aS7vOAT6gCgBpZLMdz0yONLP6Eteen0q0k4BtmxkIm8sC2lwB+4RWlFPCP3vozm8L
         AbKA==
X-Forwarded-Encrypted: i=1; AJvYcCV236r5R0i5GV216JUPeAUIfH3abWA/d4KTay1DKcE7XIjMAwaRQQIX3htpiNa704cxIpu60bHNdkr/j1c=@vger.kernel.org, AJvYcCWPG+5oT9TPVexMwXFVg678kGwgEpPKWcjEO3HVyYgNp8gSV8vZqKl3hJpKCLBeicYyfNfww6Xt@vger.kernel.org, AJvYcCWPfdGa5XrPdQsfnI7d//4JGIefaDEKEnbGHLgptSZqIWsyYq1Ix39Rmg1P3AQxsGrvTLA69rNI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1YfQNhZB1pow1Kn6lZ3F+ANoByxlknD+N6W81rYTjK5mz+mMF
	HLxQdKSRfO48VeKxrjkplrg94OWkebu108hZG4x7FVl3TAruximl
X-Gm-Gg: ASbGncsITO4XTJNet+YGx7aMduhEYCVgq/Pg9Qkp1yztwkSevdN09cxTw3uWHQa6iwY
	sGnfz3lTw7aoQlmTFA+9MD9QAhSV6FTurXYqbjBIuS4JUYQPND8a2aONcNKsBfJ1EJ7PLFRrK5h
	w0ClbvE+YTVMuIPpOi6TKY/cHJA02Czvk8zselznm6KZZwBiLuUYFM3CjJ43kkMg0GVnBmLJ/dK
	7EhvHrjD83UFnkkhhOrQIrf6ZiRL0mo7XiMqWJ6m65/oa08Y2Z+mDZSKxQE91Hxl/NLZA==
X-Google-Smtp-Source: AGHT+IHdIu6QK5qwWI4+QiGsGKyR7oWb+dGK5ujmT/1KWO3Eu+5Q5xOffSmsTG04OzXUdGVYWG1iyg==
X-Received: by 2002:a17:90b:5245:b0:2ea:5e0c:2847 with SMTP id 98e67ed59e1d1-2f548edf16amr35020666a91.22.1736946649327;
        Wed, 15 Jan 2025 05:10:49 -0800 (PST)
Received: from localhost.localdomain ([124.127.236.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10ddbesm82863175ad.2.2025.01.15.05.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:10:48 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: 3chas3@gmail.com
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] atm/fore200e: Fix possible data race in fore200e_open()
Date: Wed, 15 Jan 2025 13:10:06 +0000
Message-Id: <20250115131006.364530-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect access to fore200e->available_cell_rate with rate_mtx lock to
prevent potential data race.

The field fore200e.available_cell_rate is generally protected by the lock
fore200e.rate_mtx when accessed. In all other read and write cases, this
field is consistently protected by the lock, except for this case and
during initialization.

This potential bug was detected by our experimental static analysis tool,
which analyzes locking APIs and paired functions to identify data races
and atomicity violations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
 drivers/atm/fore200e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 4fea1149e003..f62e38571440 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -1374,7 +1374,9 @@ fore200e_open(struct atm_vcc *vcc)
 
 	vcc->dev_data = NULL;
 
+	mutex_lock(&fore200e->rate_mtx);
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
+	mutex_unlock(&fore200e->rate_mtx);
 
 	kfree(fore200e_vcc);
 	return -EINVAL;
-- 
2.25.1


