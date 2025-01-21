Return-Path: <stable+bounces-110047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1542DA1859E
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C2B3ABE71
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770E1F7087;
	Tue, 21 Jan 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laoHfJTi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBCB1F55ED
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737487518; cv=none; b=cN+X7LEUQDMCE50gGUh+QKoGaxA3Tn6tczHjw36slNrYROk9p1UF+cj8AsBQGTZywxZdLQ/z3pTkfVDITayRTOJpNkO6xYvOS5p0xCcpJ7rF47dGinJ7DKK/N3ARKYgKeGK3GS3ThqdWYo7ufCucYHAyOiTCBQldqNqVKZjppfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737487518; c=relaxed/simple;
	bh=dHV4n/DsK8cs7MIzV8hr4pqFbAX0fyfGvU+4VCWC2A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOE+TnlQIQtIBZoqmi50iAsEOBRgRjK82OsKi31M9oa1Zi63fnMcUXjjeVaU9kU8IF+gYt0eZSNsXxR/1Gc1pD45aCLY6fD2ve2StsAti0scJfhEOlJhO8HEEt3rvwqn0W4xYniyvAYPIyGCRhCrWk0UPsyRuTMtePL+15qmEhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laoHfJTi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862d6d5765so3485635f8f.3
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 11:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737487514; x=1738092314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2N1YlgQNdx7LxlrloC7QMkubugmuO/YtGTHs/05i/8=;
        b=laoHfJTiLjJ5sC5wyOZVbML/NucMxOP34TT1pa3yLinNGyvxHhHFov4jHLY83FovJq
         KQUZDliYTL8NbgaN2CgFQmh7wQMChGYs4gMW5nuwNFISmvqfQcPmYQw0Uj0GUL+al2Ud
         zUrkDTCG4gqr8bicIe9A05ZF2udryes1uI46qW6cq8+a1/mbPzqAEhZqgUiycZ5emDFZ
         gxcTO9rfVMJKalJZ9zE74oBCA4CO+LQdlb7GkEKWbf4zYsNTEHQWX3NZJzZ5TJ9+fxiN
         lY4nlhTeo+mEPBXEB0Aa136LWx3hiJ0HnRvdo6KuSL9Q6mfmfpVQPLK37bFiQtytgO/X
         FrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737487514; x=1738092314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2N1YlgQNdx7LxlrloC7QMkubugmuO/YtGTHs/05i/8=;
        b=Ya/pzRdkqP7P8YjqRaYnrWoLb1GeHm7uXmfrDbv6lFCQLHT9eO3HA+biIUy9++0zGN
         ShjIIvI6uTF27zzG8F8nnnD2j+CvF63sAVMKoexRwXL4SHzo9TiAbXfQJnQk0WvxtiBY
         fm53i2kw/ZY6u/cc/81MMPtr3Uf07kKmljkHr9nAl7c0rW6LQHvmJJaYBVeMzft8Rtad
         IJGVOKtHZpZalkTmi9+SLzSP9JjYraAgCYhtkzEcFUhB6u04Nux08TweoSApNZQWNTqg
         cJmdT3qzw8PFKzOcFoNM5Szt75Hn4pKVUYI1UW8Gh6Bj8GdYAaUZDINgZ8BM7r5saH4E
         se6w==
X-Forwarded-Encrypted: i=1; AJvYcCUXNKL/ttehRIkjmKkS2EPmkkR4QYeTtJWwpidjPowVutYRVr4nLy9BMui6N8EzGpaSiSbHOEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6oF8wyZ+XFuV+PHpQLsWrO+tf5c5h6yeRufLcqAEvXfXhPZv
	fnVJRCWh6PaG9B0xeDcXkC+1XmTyQ6OfdeYHFvxHNjxjMMCA1kxogyewOfye
X-Gm-Gg: ASbGncuYpgj222TbWp6goTFPn3ht3yWI8QpXwuYx6kDH74UrePdo/C+RXz+Z5qbGiuA
	SSWT8b/Ci3lroG2KF7TWZov41pv4J753UfYiwv+VTO/IF4JTjXj/tJizO+aTEYCeW2X8ruFA9Dx
	kO07BjPHtubFIpWJTUKl/kPmsHkDqo8bj6DKkZZzxUHmzI0EzgHqMXYmKAhR7gKbwDyEPf1SaA3
	xqpHFIDwYe8Z2f97uw/vdGnsfYB7yubekYXKTS+hOLimi4rwP5H7jiE/g/kkPRJyFlYAV4235VN
	tKA8SuGyzDiaV1VC2Q==
X-Google-Smtp-Source: AGHT+IGpfahuczTlT+hYn2/3wShXeTLEasNsu6MekHiTYaUMrdlLi98IWaYuSCFhVG7Frt/HRTWerQ==
X-Received: by 2002:a5d:6d06:0:b0:38a:864e:29b1 with SMTP id ffacd0b85a97d-38bf59e22d2mr20284032f8f.41.1737487514037;
        Tue, 21 Jan 2025 11:25:14 -0800 (PST)
Received: from localhost.localdomain ([109.175.243.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327ded8sm14004086f8f.89.2025.01.21.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:25:12 -0800 (PST)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: 
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] HID: corsair-void: Initialise memory for psy_cfg
Date: Tue, 21 Jan 2025 19:24:42 +0000
Message-ID: <20250121192444.31127-4-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121192444.31127-2-stuart.a.hayhurst@gmail.com>
References: <20250121192444.31127-2-stuart.a.hayhurst@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

power_supply_config psy_cfg was missing its initialiser, add it in.

Fixes: 6ea2a6fd3872 ("HID: corsair-void: Add Corsair Void headset family driver")
Cc: stable@vger.kernel.org
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-corsair-void.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-void.c
index bd8f3d849b58..56e858066c3c 100644
--- a/drivers/hid/hid-corsair-void.c
+++ b/drivers/hid/hid-corsair-void.c
@@ -553,7 +553,7 @@ static void corsair_void_battery_remove_work_handler(struct work_struct *work)
 static void corsair_void_battery_add_work_handler(struct work_struct *work)
 {
 	struct corsair_void_drvdata *drvdata;
-	struct power_supply_config psy_cfg;
+	struct power_supply_config psy_cfg = {};
 	struct power_supply *new_supply;
 
 	drvdata = container_of(work, struct corsair_void_drvdata,
-- 
2.47.1


