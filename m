Return-Path: <stable+bounces-111703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35302A230A2
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B121888275
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EF01E9B32;
	Thu, 30 Jan 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLLyOTEz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED01E9B15;
	Thu, 30 Jan 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248763; cv=none; b=b4AqaKS4NYac9vqa3hvTbcMtgfgYwkgdql2K1i9I70sZmCRRQFtHek6cSKip9Rg5iGgPES2s1IBnR5Zsrzc2kIrNLctUKKynfpcpDeEcp7WqaoYCyvdwMUqqxxKyIFxnDKSvWsRWfKJHm7q/qR6Od3JkRZw7MXVXJJIPavPa8VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248763; c=relaxed/simple;
	bh=oGsezih6O7xTVJH1uCh1eNlLQHW4Ik3zdN//KAMpveo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P22gUAjAkvjpdyjkPtj4sQSFqbUjY9hj0PhobHs9PyBncGTPlr7ld6Oms+uBM0rWOBjX2S1Cs4hbRjv0oK/FTsFFTdtgF7T7G8Cd0mbKpbpG1t83wQ+Ttk8zLLx56gRUbFdsq+8qNMKYzZgz/En5PyIVhVT1ZnHYUANtOIuXvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLLyOTEz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so1226686a91.0;
        Thu, 30 Jan 2025 06:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738248761; x=1738853561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4t9+wR1gvYOJNHr9NeSWQRreAbXgDWXpWfnKGB8fneU=;
        b=XLLyOTEzm74p88LjQjZZaVqcGqAMSAlZsWIyt9wIse0w0/hFPno2azMwm+rDH5w+7I
         TuRSHakJTMGgImXXCrCH5ja5KAsgRHEX1byLDjiSlFllblqPeVhZCQQ32KNHphpUCFGk
         tfe0nTFw2ejYYOXWRVi+pcJEqFCZaUN6yH4LsOxSS//gQ3xdJ3hPzTxzZGvGXCkWLQIT
         R4ogkzHoUtYlHDboVVNS47htorukBlhN4dVJU9XUoLyuQiVMBM2dPkDEZXoNWIoTTKvI
         JOwDYvR7+rHx4Hwe/KDp9zZQ7jQXu80OEl87KFEFkWJ9LvVVqjc1l1uQhugbM78TI5m6
         qD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738248761; x=1738853561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4t9+wR1gvYOJNHr9NeSWQRreAbXgDWXpWfnKGB8fneU=;
        b=rp99JMdSwQl3fFIx3IOR9Jh2W9tWSLiLTuBLkocklewBsaSy7QRVvgEd8i+7RAOQWT
         LJzPYUwdIih6eK48Nc+4Vt99Pzf17a1L+MBw8rJpjG/s1HUVwFE0+9VQrRH1GXPSyusZ
         +Vi6Ylkffc4mmSuCrASsWVVyKtXG5H1YkNpS3WE8PRVWwvzQbU4Rs2HkUOq/4y/OqUDQ
         hsZig8S6ogXHTn58tzbIiCMwk4cEgkt58IpcEcwYM2RuCqE3/7WbUOGHuNW3Xz3iXgyj
         l/D4X9hx1cs8I9qZ7j7UQTrW+V2zXHy2L8seoYbtGyLKgBFkv4D9coPt8laf/vID+nA3
         zN8w==
X-Forwarded-Encrypted: i=1; AJvYcCUE8jtzVhz5XffZWiclgBla+A+uQQi4W2ni0Cms94BcbZZbi+RM0spHG5KseW26aiRt7Ha40Yal@vger.kernel.org, AJvYcCUGzIg8Jka4/L1yiMGHu0C6FtRqCICuCEEStjrxlzzvgBGruv/x3MoD1JGgZdj7RumgyCs/Sa/Skv2oSi0z@vger.kernel.org, AJvYcCVYMz197WWSgZ0z+4FSdZ7Qx7Kv6iI4yXlg7OLiH07UzWlbwpEIwxLPGR6vk+eLS+8XJ+L7FBt9g8F8/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YytMGi6RH/lrhQiRRnG6sfHQbMWhEYnMoImEcIqenowzY/Bt8g0
	VOX4GVHs/aVuaZedJv4Je58Hh+/m2q/K1vpPbQv885Wg4qd2OIlc
X-Gm-Gg: ASbGncs8TaWdycOCQJMV0MbYHFWa2lWCLndJWw1m/sW+FXyxZlTpxVBZQqrtUISRTaX
	MDk/p0Te2nHQkTCjj+66gVT6o+/cemnG/yXFSVaNmyWNS/83J5CClAiMx4R5Ux8cwnj2CRhgrxG
	z+XZpS4NZnsnRnRiDODM1PuAXCeRmblT6mc6Lq6oVPAWRXRT3h6FpQsy3/MOsO941yAdG7HZq1j
	BBZ8H53EHXULVDuY6erl4es2fugr8nNXIkUYgLXJB/8MwPj+hpg7ZdYwnJO693BUa6Rmh2w4EPE
	m1PC2Z9g3vgvfzxNdYg=
X-Google-Smtp-Source: AGHT+IEUPs2Yt54Zvf4yqMZHMSJBVT6xqh1XSxZ6X6vGrPA3Otstapo5wNP2YkMrudnP0oxno+CS4A==
X-Received: by 2002:a05:6a00:180b:b0:72f:9f9e:5bc8 with SMTP id d2e1a72fcca58-72fd0c74655mr10807479b3a.22.1738248760800;
        Thu, 30 Jan 2025 06:52:40 -0800 (PST)
Received: from ubuntuxuelab.. ([58.246.183.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1a94csm1550257b3a.173.2025.01.30.06.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:52:40 -0800 (PST)
From: Haoyu Li <lihaoyu499@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
	Rob Herring <robh@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan0y@gmail.com,
	zichenxie0106@gmail.com,
	Haoyu Li <lihaoyu499@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drivers: video: backlight: Fix NULL Pointer Dereference in backlight_device_register()
Date: Thu, 30 Jan 2025 22:52:28 +0800
Message-Id: <20250130145228.96679-1-lihaoyu499@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function "wled_probe", the "wled->name" is dynamically allocated
(wled_probe -> wled_configure -> devm_kasprintf), which is possible
to be null.

In the call trace: wled_probe -> devm_backlight_device_register
-> backlight_device_register, this "name" variable is directly
dereferenced without checking. We add a null-check statement.

Fixes: f86b77583d88 ("backlight: pm8941: Convert to using %pOFn instead of device_node.name")
Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/video/backlight/backlight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index f699e5827ccb..b21670bd86de 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -414,6 +414,8 @@ struct backlight_device *backlight_device_register(const char *name,
 	struct backlight_device *new_bd;
 	int rc;
 
+	if (!name)
+		return ERR_PTR(-EINVAL);
 	pr_debug("backlight_device_register: name=%s\n", name);
 
 	new_bd = kzalloc(sizeof(struct backlight_device), GFP_KERNEL);
-- 
2.34.1


