Return-Path: <stable+bounces-95715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6BE9DB867
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED910B220A1
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB819E99F;
	Thu, 28 Nov 2024 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLdO+qDt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5C1E511;
	Thu, 28 Nov 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799814; cv=none; b=fLslQ6HQhdPKRyb8LUAOM2wjjbtjF1EqSkjvSR9GeVs+O7YisC91on/zTwB3VIj3cZAamYxJqCmVfDywOJQcrP+jQLtFlZOLufk7PKjPi2ecBbBVNnH9ljUb5WBKe9O//8f7XTVDzyAucIXmLse+Rlx6MkE1og1Re7pZ/Lx70Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799814; c=relaxed/simple;
	bh=UZX5u4fwD+xpcDrxlMP8vRYCAGGhe7D0cW70VSaEFNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXG9ab0TcbgBXG/wY0O2naVLpZ6SPhJPehpEqPUJ9Zxy1HXwo1MlFY+oD9LlRmQRQpCV3RrtwPbniTmlyqw/1DCRTH/u75d8SKcAbMtEMLaL0Zr0358/0Bb+MLQQ8AnOTJov+7dVJY07kN8TaUqsOQdMAWQJgFkP9mH9scUaqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLdO+qDt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38231e9d518so578502f8f.0;
        Thu, 28 Nov 2024 05:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732799811; x=1733404611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hy0wdfdN1jd5UNqlJbWVX/r8spHPQ5eT41DKOXK/aqQ=;
        b=cLdO+qDtbbIrtjm9ATDv3ZKuKsGzqyE1cMP3//W6fV9Tv6rooTSL1vj17xuczOgN5n
         M0KncF9ximRgFf8LKkCvi3mDXctWfCu9eQJ66OPi8FpltwE5YMBm2vqX4GsIWrOoViM6
         9kP7ZAWKh4/6mUcSutzj5iXgNZTiOO0/9R+a9x+lGVf4a8GM8GYNho8EDnRmchTjTF5A
         738JchqlloZnfsUS/WOV9bBoUnR2VMr11TXuHzjOJnsbFN3gs+pvRYBNc/bqqhXGz5gE
         mASV4e5/EcqUM90EE7av70ey/UxlxCc/Q0GWoxvj8kFAqu6Pa+iM2iNqP2duC7jZ9SN8
         MO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799811; x=1733404611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hy0wdfdN1jd5UNqlJbWVX/r8spHPQ5eT41DKOXK/aqQ=;
        b=E6BRZTSPT4Iri6PsXAMWLHM1p1dNnuBmby/ofHdDDzO3cA1NK0Hfyz3AEzk8WyKioD
         uOqWhYPMlad606WIxUbIZodZOdLrVy85Nmgj/BnyfrY691ThMUAIwDYIM5ZgD4pVg2Lm
         QJnCnThwwaIDevLdRcJzQdWbu5Qwjg6du/0JzHYeyPOh1EyL5lwslGKZJMgHcKATpjwB
         q8q8MvD18giCbUOhvUtM48gN0HMhsRiFtxfUfhxF26PzYpl4uABiqvMJqZgNStiqYmSi
         uaVtxW0zdJhRe8Kw46IpM2YCQEoj6x5aCrkJ4nzYzqlxs/el5nLJ3h7IMYVG1+A3PHq3
         M/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3fqK03bpTYLWEXrmpNH2mPYQOum9skXzFjf3OiM0vD2tq2FVHzQov0Z6g8zfdTw69ZwYK6DnwS8Q6V0=@vger.kernel.org, AJvYcCVbn0EUwsSSVm6z+gcQSMYXW8wkKXos8NvZ2xnp0PcJOoX6Fkou46AtPLH5py80/e0Dcv8sX+yB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbg3OlKUtQ70zTu8JO7sxlVkiKCgvaXp/icRYVSic+9xKCkShJ
	LaM1YxB7AEYwVrcZzmwpqBOG6KhMRgGGCxwCQXkz0KZ15+GGFFDy0iKmHA==
X-Gm-Gg: ASbGnctKIX9nrHiOStcTNnzCTgxGSn6s9IMbs04qlCatKf8PaXZfL1IMO0QeA/hV5Wa
	f3HzVz7GpYVQV3MoZPJEnal2hxd974g/PW28l5Jb3milFWwZWLaZEgelMRfqMJq1PYmv9+9MGv+
	6uq75/YYPuZo7rEhgI28q9FPype99kb5UOlCx58UW8hm03tXWsl6AVd1Oeuas+gXt1QKtbtHZHZ
	Vch050vtioumsY/FeFH/DvwKGzFYBs4PWG/X5GnC+lYzmjyvX+KLNJosWNPV80=
X-Google-Smtp-Source: AGHT+IFoJTgX6ndR1ryln1cP9C0fnM5/j9ec7yYwBmYmGcPFZnn4Ep0SwA7OaKIBoE/NCTSR8wjoEQ==
X-Received: by 2002:a5d:5f85:0:b0:382:49b3:17b2 with SMTP id ffacd0b85a97d-385c6ebf0a4mr5465928f8f.33.1732799810730;
        Thu, 28 Nov 2024 05:16:50 -0800 (PST)
Received: from demon-pc.localdomain ([188.27.128.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a482sm1643720f8f.47.2024.11.28.05.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:16:50 -0800 (PST)
From: Cosmin Tanislav <demonsingur@gmail.com>
To: 
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] regmap: detach regmap from dev on regmap_exit
Date: Thu, 28 Nov 2024 15:16:23 +0200
Message-ID: <20241128131625.363835-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the end of __regmap_init(), if dev is not NULL, regmap_attach_dev()
is called, which adds a devres reference to the regmap, to be able to
retrieve a dev's regmap by name using dev_get_regmap().

When calling regmap_exit, the opposite does not happen, and the
reference is kept until the dev is detached.

Add a regmap_detach_dev() function and call it in regmap_exit() to make
sure that the devres reference is not kept.

Cc: stable@vger.kernel.org
Fixes: 72b39f6f2b5a ("regmap: Implement dev_get_regmap()")
Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---

V2:
 * switch to static function

V3:
 * move inter-version changelog after ---

V4:
 * remove mention of exporting the regmap_detach_dev() function

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 53131a7ede0a6..e3e2afc2c83c6 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -598,6 +598,17 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 }
 EXPORT_SYMBOL_GPL(regmap_attach_dev);
 
+static int dev_get_regmap_match(struct device *dev, void *res, void *data);
+
+static int regmap_detach_dev(struct device *dev, struct regmap *map)
+{
+	if (!dev)
+		return 0;
+
+	return devres_release(dev, dev_get_regmap_release,
+			      dev_get_regmap_match, (void *)map->name);
+}
+
 static enum regmap_endian regmap_get_reg_endian(const struct regmap_bus *bus,
 					const struct regmap_config *config)
 {
@@ -1445,6 +1456,7 @@ void regmap_exit(struct regmap *map)
 {
 	struct regmap_async *async;
 
+	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 
 	regmap_debugfs_exit(map);
-- 
2.47.0


