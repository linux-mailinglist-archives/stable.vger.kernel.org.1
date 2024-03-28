Return-Path: <stable+bounces-33109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 139E2890940
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 20:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A0CB24BD9
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 19:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C94130E50;
	Thu, 28 Mar 2024 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzaXj6ei"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B413C08E
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654128; cv=none; b=WV8C56YZEuUc7gKxCsI018b1K/nJG+q6A18zntHrYK7cw6tlzMgKYGZOcvGq5d4OmNF1GO+Va8HNQRamnWBXfA8faf6vJ0lkMNU4kz4NcWH4AYa6AheWErv9KknppMRCZUDheldiyQIZsz2kCLYIR4AsIFeCh4eGXRwv+n/hf+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654128; c=relaxed/simple;
	bh=9faXT7l+qaSBO4mqtB3cD/DqxEjrBwI3jUcLmMit5jw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ONnXpZGnyeVe2wzBs34d9M8FxqpNCQZR2MUOBNbo/Vv+gGTozNlbTU5lyWwF4K4chpUVYkFT68RytIz9PrDAv0buJDUtnQ523KpU0sQd5xsVazw7IsaRZZktWu0CxzuhbH46VaGWn++PFb+GtfEd68cENfo61n63+iC5kGC3z3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzaXj6ei; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5157af37806so1542846e87.0
        for <stable@vger.kernel.org>; Thu, 28 Mar 2024 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711654124; x=1712258924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9P7hWbY9C6Nla2YUvTJAf/gcqA+AhFrg60X/e8vcXc=;
        b=LzaXj6ei3uyXV2aeZF9ZdOpyjqTjQZZRy5uOu7sHxyEiTZbRjryNVDEk3NJYAA23w8
         Tots9YvOeveECLHB9AxA2ep0d5G9yGU0LQFk05et2+Y4rAbVV5a/mhBGClfyv0GbxVYy
         6hhvKFNFW+Zdv5nOwP2C3UoZFK81tiSqXCVQHZ1IbolsOqfyC7faywK4lMt43U4DDZ4T
         0ItmPEAkxTHV8p3BW1wzZRGlp2bNAeqREXRpbkYLq2gqVjBS4AGknPKFseTVteqKFr/m
         v5CjDKl4wWGDo3ba+XLqgydirgCA9gVHLiQQ6UCgHeXvB6072vxWu0wuvNJlOWrokwYd
         +osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654124; x=1712258924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9P7hWbY9C6Nla2YUvTJAf/gcqA+AhFrg60X/e8vcXc=;
        b=lKSxOgJg9QMYuvpBYlheicJwB7vqKnm0l9bppV51E6tRfg5d8OrkY0NKb2Yu+jgmQ1
         +2n3Npc7MrPiKL9LIe+7eFY1d7EEnmg/6IobLgzrb2TjFXzmMPyAwn5VqfTlHjzll7BE
         2slYMde3ONLh9ieDUH8vx1pkYDJzeTtIoA0DLyhzAc1bt7u9Y9qqErKE9RbwcO13IHEp
         MJzeYki9ds+ndh9zGZ/4uoukakTbmSTLLZQGZ5JroDb+Pwemx31QMnaarxOCgb/o39Lj
         gS2P8y2uzvNTQzlIaReR3tP7LSqX87qZSMOe8ekVDfeqRnECMZMFoCkkUVc5UfNGVwSk
         fBPw==
X-Forwarded-Encrypted: i=1; AJvYcCUyRdlXTUXrlI/AFAjtXfTqRVIjkLRPBZlqyYkqTCxGl20VqO5cdzEt8eP9FE8cuzS2YnZQWW3MMfjjgaoTVxP+bPyhfSpI
X-Gm-Message-State: AOJu0YwdHapGcWjAeB2VsgPi52NY/x9xxqqE4dBpRUtVeNe1ANUte4gW
	NFg6l6iXA31QJckhQWDoIqzXOavMI9s6E0b1LZYEzHvoy2zygLITl4YigEmv
X-Google-Smtp-Source: AGHT+IH0oUctJFzIaitvUxhux+LherP1Q93ahLEOBzF/6A/0BR5tyHe1AHzyiDU7tkAl6ibKB1RSXg==
X-Received: by 2002:a05:6512:310d:b0:515:9568:fb14 with SMTP id n13-20020a056512310d00b005159568fb14mr247402lfb.46.1711654123699;
        Thu, 28 Mar 2024 12:28:43 -0700 (PDT)
Received: from localhost.localdomain (109-252-163-179.dynamic.spd-mgts.ru. [109.252.163.179])
        by smtp.gmail.com with ESMTPSA id u2-20020ac258c2000000b005134b126f0asm321369lfo.110.2024.03.28.12.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:28:43 -0700 (PDT)
From: Salomatkina Elena <elena.salomatkina.cmc@gmail.com>
To: Sobaka <nuclear12explosion@gmail.com>
Cc: Salomatkina Elena <elena.salomatkina.cmc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vkms: fix memory leak when drm_gem_handle_create() fails
Date: Thu, 28 Mar 2024 22:24:41 +0300
Message-Id: <20240328192441.136115-1-elena.salomatkina.cmc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If drm_gem_handle_create() fails in vkms_gem_create(), then the
vkms_gem_object is not freed.

Fix it by adding a call to vkms_gem_free_object().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 0ea2ea42b31a ("drm/vkms: Hold gem object while still in-use")
Cc: stable@vger.kernel.org#v5.10.212
#Co-developed-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Salomatkina Elena <elena.salomatkina.cmc@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_gem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
index a017fc59905e..cc6584767a1b 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -113,9 +113,10 @@ static struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
 		return ERR_CAST(obj);
 
 	ret = drm_gem_handle_create(file, &obj->gem, handle);
-	if (ret)
+	if (ret) {
+		vkms_gem_free_object(&obj->gem);
 		return ERR_PTR(ret);
-
+	}
 	return &obj->gem;
 }
 
-- 
2.34.1


