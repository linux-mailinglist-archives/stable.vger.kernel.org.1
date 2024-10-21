Return-Path: <stable+bounces-87047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33369A6159
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC901C24D82
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446561E1C11;
	Mon, 21 Oct 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X3XfLI/C"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7851E3DF0
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505073; cv=none; b=nlWuT6vOe0rvd2aRRSkFMjnQrWaBl6rF+311+pUJDPZwBBzRa/LSmlr/BZbJjXXMbHTiBcmjYWK7FsXmF8yX+PVWY/lrUofwlw2DyGYdhaUzhrZSIFZ4DESpKugAXs//Z2BETf52oXNpbwtIrebdtQTk7vBKQscXQAVuEevGJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505073; c=relaxed/simple;
	bh=zBwwiICl41FAygMh+FLshXJ/tGa7gogHxJLxu7b+uJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUzgcUwZgosugPm5h5OU2RrydWp+rhWZ2ROOHnGwdoLz04wYpsTpKfiTfMiGfelQIZF/YEb3gw/Id/RIHEaHQCkdjFt0+UUFOpxV6AKSnygzqdJ58tQBk3eMsedcmISodGnQN+tmWtFNwzhMT2Z2MKd/ZYByfqd8exyKxKtUFSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X3XfLI/C; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so48279305e9.2
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729505068; x=1730109868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXr9D+QiqUrfHWA03bUKiVKqnoPxUJl2IUDHzBbrn2o=;
        b=X3XfLI/CMGx/8NgdO7PgLwUXleN4BzbYhvXFgZdq1vCbDfufG4Qlue4pwftP+AMcAx
         foEmNjdYjoHMUEzdu568GpMCcjINJtL/G4R59Vn0dj/Eypqb/lmO9t5wLoI+kE2/Za2s
         /tr82SPvJPHEbw/+68ckEa/WtPsle1NSHvnyQwBoXdIUrxUAn8mOygcDiMMp7E9wKoxG
         kmPnd62WfrFVTa/IQ+SWgo+TEZELWDIaHOKSNUEs2sO7MoEadkzc4dH7z1C608GNWPVq
         8gdW21GZC1EcrRbTGT03qux6NTXlqh1JTFXpgzs1P2LRAeXbimtixQQowvChQ6IGNLTu
         6oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729505068; x=1730109868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXr9D+QiqUrfHWA03bUKiVKqnoPxUJl2IUDHzBbrn2o=;
        b=i4PzPCeckIJ7TCw25Syoxrl9RbFbMCfyobMYGyT8OFnrFoC4i1nUu/h2NpZCB8Afxu
         EHm7NQ0umLt8xjXdxrH5tcwEzrKEtRmVcSM5Qi0Kqyihu4BMtw+WgTK0BakOPZGn+FSK
         Z/PSEUv/AMRZQQbbbaA4utmd3rU7Y8QnnZJavcWMvUcy8iTsogm67BTRFym94pZPkQZa
         JVS5x7F9UUueSneUBpwoT1VEs0rTo4K97CKj48HROKYNtlMKCzMoX5ixJ203vNlFJeZJ
         En5YBnX1fMR28UMMyNn/GzNYMXHF9xl9UFuzliyFoSPfZ2ZJupyGtTamIb47h2k7LkOt
         kMMA==
X-Forwarded-Encrypted: i=1; AJvYcCX+PlxkCGUSK1uZFLVGPgXA18SOv9U8JjQWO2QPj/cek7enZ4Tmb3K/ae5CFFkvrXfoE5IikwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4fIi+oQrDdNVKHlzph4DQRsSO0/ejSRU8o+zsTfSyHSehJVw
	cWNOfgHgxZJ3B7dLT283OPqLZ1RjkQeDGMeqWTLvkAQRtvNoGvDoI9z7I0D+7uc=
X-Google-Smtp-Source: AGHT+IGW4z70tBtJjYVEC25NjW4Zh4Gpf7rFYYWBzMKvqYBqjTj3bmz732iSxhNJelTfx86Iie8/xQ==
X-Received: by 2002:a05:6000:124a:b0:37d:9508:1947 with SMTP id ffacd0b85a97d-37eb476876amr8204119f8f.51.1729505068250;
        Mon, 21 Oct 2024 03:04:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a64dc1sm3918652f8f.65.2024.10.21.03.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:04:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
Date: Mon, 21 Oct 2024 12:04:21 +0200
Message-ID: <20241021100421.41734-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The output of ".%03u" with the unsigned int in range [0, 4294966295] may
get truncated if the target buffer is not 12 bytes.

Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rounded to the correct SI range")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 lib/string_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 4f887aa62fa0..91fa37b5c510 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -57,7 +57,7 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	static const unsigned int rounding[] = { 500, 50, 5 };
 	int i = 0, j;
 	u32 remainder = 0, sf_cap;
-	char tmp[8];
+	char tmp[12];
 	const char *unit;
 
 	tmp[0] = '\0';
-- 
2.43.0


