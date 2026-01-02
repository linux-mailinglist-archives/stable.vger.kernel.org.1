Return-Path: <stable+bounces-204501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF953CEF3D3
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 20:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E423013ED5
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12F26E6E4;
	Fri,  2 Jan 2026 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="C7ZDUWlk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBB61B81CA
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767382511; cv=none; b=sTOAHIIQM320CoExoX1ORp3Ei3pWbwxOiUKmWDLM6pZiX1g7mniLqizErace40fBElE0astSJraryymyEMmDJohmX0hTQBR339JtPgg8HeigNh4E7VcLLWO+OQbnBIWK4o7nsw2fv0kTB9EjcHlIAczaXYjddS4tk7detgbdDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767382511; c=relaxed/simple;
	bh=84tmDu5t6O2eHkrxOc1GZhXc8uRfQp7CZPaf+JTYXsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a1fyg+i84UIVduywdfYjNd8NHmF6A0io/hYCEo9QVPY8lRcVbo3PU+Zr8Lpoj0iExJ0y82N3sKcocnshyEl3bCJj3Cad9q7QwNjbBm+vJ1hRQN0jYAUkjldFntvZA19hiOgaiR4HYux/Ab5OhMLugWa/CIABvYtKP3hsZogDpZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=C7ZDUWlk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so2927987166b.2
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 11:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1767382505; x=1767987305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bk0EXbFQjZBZmsrm1SqH218o8d/q4/A5jo2jPl2wXKU=;
        b=C7ZDUWlkrJk3rzO5x/aOcY5/pU1ksgtrCIIT92kOxVpDC153p0drOVpMaTze86AIme
         bNQw7VtBFI0PTpkCaHgkbUzXT5d5m3DyG9O/AAcuFYm9faQ0EyqJXLELyS//ydSxjlER
         Lk+0KUz/ZGRzcP0Rp+wlAmto6SzAZ/Th4bosOVmXaL6a2K+SPJiEgnbR5zHQHACqt7Fz
         w7QOiLuyvgzt0KH60MK0FRTpyjh8Mt6+XWHhDe99KvhUQEZt3xUtXRM+CpoWm4544zJE
         gJlQN7MoSFTIncwkg5+5yafqIZUNt9qYvySw6Xv/cqO9MfJrf1WKJtjro+ng8M/B8k/l
         Ls7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382505; x=1767987305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk0EXbFQjZBZmsrm1SqH218o8d/q4/A5jo2jPl2wXKU=;
        b=WbpQlqUXCO0dtbH8EXbDiMtY2DQwpiIkWNMpObW9ib5H8YDZJ/r9V1URa34NQ8HEwF
         kr5YYnTaBNM1DCSRmI/d0z8o3nhIpneqICFlaICbnpv8yis0qXPhVNThyq10/20dT13S
         90Mtj0YIVbuQ2HbWlq3mTs8Br6zaIR2I4ZIxJQW7Uqge3lFtHSXxbFESwHMHPWbNuLgw
         V/EGfE/Yk9Qt6DcGP7v8db/mE7rKCO9IwQhPD3T5U+6mmP47yT8r/Fqk5XapaC+zL00E
         3pOFchaqmbLNBwLu0HXmNdJWj+bYRWliUheXb+zDo2+g6xkDJkXblKZqUKP0w12ybciE
         dyJw==
X-Gm-Message-State: AOJu0YxoWMLd1z3wJP7NBEfrGcBKf3PxvSxh1oPxcxVtlLWmUFIe/+MK
	tyulnfsOjuL+iGvWN4n5PEnd/sbqySFmdZsvHAASoh92WoU6PBhbd75a8RVx6VnYhzcYZuoibB1
	V27J+1w==
X-Gm-Gg: AY/fxX77HDl1zJ4BRemn0LqExN6iSplhRy0FFTdaZvcjSiaESKfCp56Ta1kF+nsmHe9
	LPi0evkJrEheOozxWcGuzcWWtUWDhRgL0npE4pgIAE2gVL3R8ttZUdCMit27M8W51CE32e6xTSJ
	Nak2vtqh8KoS5+GYPHC7cS2T//iyZ3vH3wNT/c6YOeORZjmzk3/S1Mq4s3xXfNMMU3arpn88Bon
	0iURfCsLMh2x/zEcGhzlkhPRUJhckOJXQaRRXeEfMfnmbl8Q3CnrqRuHIpQ45NwbXncX62kzwO7
	0MettPBQAAiQKtEArXaErpJLe2UvDe06nZW5NZzlikF4vKUibgh8145Xy601zjwuw4lu5JOD+uF
	a4MMlnozStoDWxyn5YbtkLCDepBRr0AF8tROkt3rBoNt5uTWn8hVzy7mpbhZFrqmVMvJ5NYFRSm
	vHrmhQg4Sc0aY1WQ==
X-Google-Smtp-Source: AGHT+IECZs7rq23tTf+ivhekYIuOP8J6DGCQLkBm0fVCD/EIcsYQTgwnLrbnBWqBZEbC1kZOkLRYzg==
X-Received: by 2002:a17:907:7e91:b0:b7a:2ba7:198c with SMTP id a640c23a62f3a-b80371efe93mr5057849066b.59.1767382504786;
        Fri, 02 Jan 2026 11:35:04 -0800 (PST)
Received: from localhost.localdomain ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8037a6050dsm4715462266b.9.2026.01.02.11.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:35:04 -0800 (PST)
From: Petr Malat <oss@malat.biz>
To: stable@vger.kernel.org
Cc: pierre.gondois@arm.com,
	wen.yang@linux.dev,
	sudeep.holla@arm.com,
	Petr Malat <oss@malat.biz>
Subject: [PATCH] cacheinfo: Remove of_node_put() for fw_token
Date: Fri,  2 Jan 2026 20:34:57 +0100
Message-Id: <20260102193457.270660-1-oss@malat.biz>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fw_token is used for DT/ACPI systems to identify CPUs sharing caches.
For DT based systems, fw_token is set to a pointer to a DT node.

Commit 22def0b492e6 ("arch_topology: Build cacheinfo from primary CPU")
removed clearing of per_cpu_cacheinfo(cpu), which leads to reference
underrun in cache_shared_cpu_map_remove() during repeated cpu
offline/online as the reference is no longer incremented, because
allocate_cache_info() is now skipped in the online path.

The same problem existed on upstream but had a different root cause,
see 2613cc29c572 ("cacheinfo: Remove of_node_put() for fw_token").

Fixes the following splat:
  OF: ERROR: Bad of_node_put() on /cpus/l2-cache0
  CPU: 3 PID: 29 Comm: cpuhp/3 Tainted: G           O       6.1.159-arm64 #1
  Hardware name: AXM56xx Victoria (DT)
  Call trace:
   dump_backtrace+0xd8/0x12c
   show_stack+0x1c/0x34
   dump_stack_lvl+0x70/0x88
   dump_stack+0x14/0x2c
   of_node_release+0x134/0x138
   kobject_put+0xa8/0x21c
   of_node_put+0x1c/0x28
   cache_shared_cpu_map_remove+0x19c/0x220
   cacheinfo_cpu_pre_down+0x60/0xa0
   cpuhp_invoke_callback+0x140/0x570
   cpuhp_thread_fun+0xc8/0x19c
   smpboot_thread_fn+0x218/0x23c
   kthread+0x108/0x118
   ret_from_fork+0x10/0x20

Fixes: 22def0b492e6 ("arch_topology: Build cacheinfo from primary CPU")
Signed-off-by: Petr Malat <oss@malat.biz>
---
 drivers/base/cacheinfo.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 9e11d42b0d64..b57f64725f25 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -404,8 +404,6 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 				}
 			}
 		}
-		if (of_have_populated_dt())
-			of_node_put(this_leaf->fw_token);
 	}
 
 	/* cpu is no longer populated in the shared map */
-- 
2.39.5


