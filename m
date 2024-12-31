Return-Path: <stable+bounces-106619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 520169FF169
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 20:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199027A04DB
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1D2189BBB;
	Tue, 31 Dec 2024 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBVFPsx5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D07FD
	for <stable@vger.kernel.org>; Tue, 31 Dec 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735671824; cv=none; b=Sdvetkiqq9AvDs06AIKdOWWta3avhHiAHiDGuk6kDUR7jDrLSpouJh1Zy3qHLIh45gzjubX8njquzWVpzTMPXLQSRN0JoDgFNK5A4nN12C9CaGgw+ieyOQ/AY2eYBJxVvDBDgqYljAg8nXp3y9McNn46TLGJkwqOJ1I68Km7wPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735671824; c=relaxed/simple;
	bh=hGtZBU3Z3whGzmH/7CDGTmQQIyKDEqSx3P97I06QxQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=speVp9vyCHc3/6XWsSZszE48yFdP29ehrTEqf1hs+8tjqSztBUeWP0pcwHBTXzvgWH7zyS5GBMQXb+YDbVB1THrO8zK794uR4SPZpKk3C0W2oL8SFF6FgheTwbHZ4qXFjalYw2kOBi2eRdz3/qCJpNpJKJ2Fgd7Bu3FFoAkJKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBVFPsx5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735671821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+5xWAUF+fycztH/1bkPrUC8z4WpEalfNEkRojaFt17A=;
	b=GBVFPsx5dV8bjb16jWu8+0pEizg3KwVQPUyqGsqDYPOEa/SoeqPiZZHwFIfdhkx0qMoLcn
	vgP+hAe8GhiuWwOhtoeEg62S0lLfPMfvtJM0W9JnJJGnal1jUSXCcFFKQdKxO65pPulraj
	HZayL1W7ClYFn0PflTefolI0woel8Sk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-9tGsowoqOwqVfFpjtXypJA-1; Tue, 31 Dec 2024 14:03:40 -0500
X-MC-Unique: 9tGsowoqOwqVfFpjtXypJA-1
X-Mimecast-MFC-AGG-ID: 9tGsowoqOwqVfFpjtXypJA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362552ce62so55242865e9.0
        for <stable@vger.kernel.org>; Tue, 31 Dec 2024 11:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735671819; x=1736276619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5xWAUF+fycztH/1bkPrUC8z4WpEalfNEkRojaFt17A=;
        b=u1U1ffgtKZp9SsjzxcCoFLNpYfTSJ4g9c4IzVooew+GLIrDP9Mmy2ZS4/saGZkJ15y
         p2ffWYtoos1XOcJRTqs/Z1Zfomaw9K83q29A8kYAzGqspDY4BztCRtb+6jtebIjg2C70
         qLxC2zTr61pVL3AwrhGvfjjV2XhmlM/MLDNLOqoZ3PWLtP+iLsihAOCI8iiFeYlgLwVT
         gby514aqC0tmCEuRgrtfHVYNHQzpvjO6reM4qoGMP0bUgEhfx1z1J6WG4TRXuNudgcZk
         YgNTcbUcd+VyVgNaQxHoMxg4GT9hEvsMGvmtYFwXoq4ZlIL3Pla9ykyfiQ0gUILUzRgR
         mTlw==
X-Forwarded-Encrypted: i=1; AJvYcCVK0UuLxJ3TlkPMaXKq17ixI4eTHs0SWgc9vz2SzrP78nUsrXKdNrBgizJmQAdGC5CgaolHxrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqi1QE+9sE+wGtwu+izqiGAKiVEv2Nb09uofgV+/n7l0qUYbHJ
	L0KF3/56ZTETKOugpaK30OdSR0e4MGxqCSOnmAnmboPqTpoaPEG59nUukJhWypswUfgA9lm7aPn
	vr6Lc6YTRfJsIvkyVui66Gk57Z4n14pUt8XBO98ocblRKakT4m2sngg==
X-Gm-Gg: ASbGncuRL+dArB2RJD3HkX/Xm1uuuq9t4GI1t4i2qW50INwAMB+XIJxBneXZou1vq2N
	vgoiJfw9h/nMPe+ZvXJ41PF8a7ZS3KsZ0uUhgKEeLPrn0uCNRwc48hAuq93KJ7j46MLPKwqKLSo
	qOnvMYvgVGwnNTqHcud9yZV3wqt9lFFbO/CWrHfRzHXqPxEsNUVvx4XHKL2APALs+w5GvG3FAQy
	MLOyF60g5HvkxG9TtIRr2tOOKB5vvEmqw/+kbLNz0BB9lhGRUz0XXpcuQa9Ei619cdoeLUj/2i2
X-Received: by 2002:a05:600c:1d1d:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-43668b5e172mr323373195e9.22.1735671818861;
        Tue, 31 Dec 2024 11:03:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwu7VHUjCze1BiN8/L4Xx9WF41kXaJ0+tvzbxOl+oLjN2qBl4D9Qlq0vZZh56pugMVJl3/Mg==
X-Received: by 2002:a05:600c:1d1d:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-43668b5e172mr323372965e9.22.1735671818462;
        Tue, 31 Dec 2024 11:03:38 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea487sm394711105e9.8.2024.12.31.11.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 11:03:38 -0800 (PST)
From: Lubomir Rintel <lrintel@redhat.com>
X-Google-Original-From: Lubomir Rintel <lkundrak@v3.sk>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>,
	stable@vger.kernel.org
Subject: [PATCH] clk: mmp2: call pm_genpd_init() only after genpd.name is set
Date: Tue, 31 Dec 2024 20:03:35 +0100
Message-ID: <20241231190336.423172-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting the genpd's struct device's name with dev_set_name() is
happening within pm_genpd_init(). If it remains NULL, things can blow up
later, such as when crafting the devfs hierarchy for the power domain:

  8<--- cut here --- [please do not actually cut, you'll ruin your display]
  Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
  ...
  Call trace:
   strlen from start_creating+0x90/0x138
   start_creating from debugfs_create_dir+0x20/0x178
   debugfs_create_dir from genpd_debug_add.part.0+0x4c/0x144
   genpd_debug_add.part.0 from genpd_debug_init+0x74/0x90
   genpd_debug_init from do_one_initcall+0x5c/0x244
   do_one_initcall from kernel_init_freeable+0x19c/0x1f4
   kernel_init_freeable from kernel_init+0x1c/0x12c
   kernel_init from ret_from_fork+0x14/0x28

Bisecting tracks this crash back to commit 899f44531fe6 ("pmdomain: core:
Add GENPD_FLAG_DEV_NAME_FW flag"), which exchanges use of genpd->name
with dev_name(&genpd->dev) in genpd_debug_add.part().

Fixes: 899f44531fe6 ("pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: stable@vger.kernel.org # v6.12+
---
 drivers/clk/mmp/pwr-island.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mmp/pwr-island.c b/drivers/clk/mmp/pwr-island.c
index edaa2433a472..eaf5d2c5e593 100644
--- a/drivers/clk/mmp/pwr-island.c
+++ b/drivers/clk/mmp/pwr-island.c
@@ -106,10 +106,10 @@ struct generic_pm_domain *mmp_pm_domain_register(const char *name,
 	pm_domain->flags = flags;
 	pm_domain->lock = lock;
 
-	pm_genpd_init(&pm_domain->genpd, NULL, true);
 	pm_domain->genpd.name = name;
 	pm_domain->genpd.power_on = mmp_pm_domain_power_on;
 	pm_domain->genpd.power_off = mmp_pm_domain_power_off;
+	pm_genpd_init(&pm_domain->genpd, NULL, true);
 
 	return &pm_domain->genpd;
 }
-- 
2.47.1


