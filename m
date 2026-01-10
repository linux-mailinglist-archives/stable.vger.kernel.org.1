Return-Path: <stable+bounces-207970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 842DBD0D937
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 17:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D011D3015953
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACF3283FEF;
	Sat, 10 Jan 2026 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyuVXd1J"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA7221F12
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768063694; cv=none; b=BpVoQNKICfbOqVfPJh1I555d8evu2hqbPqdt3htukI9jEwNxn2Il3xeZzzA1DDFic/90UBJ47Q2+0YRfBhnTVNVyLiLwoc1VNxGJnstxfKA1zq3ojaG9EVWJ8MPknaV9rrrz0tzheHRIn5zHI2oUcNr06yjylKPtzBA46IobQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768063694; c=relaxed/simple;
	bh=zRf4ptrB8lCQgyKpQaJHbCL+1F4bYKhMKz3/VRn1UtA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CMBB1FBArMdkanhjxJseaaFie5tTL2XuA6yzfKvu9ZgHxr4TwJUVeZ2BueESweKiS4v7RIQ30Nv9DnTDp24YZNLqkDRFLu2iO21OiuIaFxqsFUqE2WTR4k6YTuRKGrPzrfHE+mb079gnhm3Yw3RiMHjVodPG8JS1FNHLslLWSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyuVXd1J; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b04fb5c7a7so4692723eec.1
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 08:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768063692; x=1768668492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pymo/XHo3xN1Q0UiU9ynvWIgTsVpB73mCjCSizmghhM=;
        b=AyuVXd1JnBZr8sV/a9RL6qCjSUnqoMpk8oso/ZfqyDJl2fhtFQk1Rwhq1tm96GBCCu
         RND97MrTmSA1hthQ8zKsF2qEu4OoiAJY+X9IaJhWsBbPy5UoLZVWi5wmooTw4TvUfO5L
         jlyaZ/wgh2qsicZtIfntnWBd+a6vDhUEVdtUPwww0hIDhhtexSyhUHVMtrls7H12qwix
         nfnTf2kk9g4guKP1lySEWKnJj0rVHdz0wrRPKVr/yrv+q2YrfNk3gfrwhBhaXHZQRIal
         X4NKXGewANu0kjELRpIb8mKWdbNqDXBE5trHOvJLJzeAfqgn+Hk0B1qNusllsstr6vvD
         9N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768063692; x=1768668492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pymo/XHo3xN1Q0UiU9ynvWIgTsVpB73mCjCSizmghhM=;
        b=mwJjNEV5/Em4jkMsrNBQOeY/curv6H694yHwzw/AlnaCc59P5sQzAXccqodel8AIt7
         asX0esOCTJO4cjGUmZCOnz27/DLwStNk2bCp+DtLddY77FUl6gzpJV0O9XdFA/U+pJeM
         R422EhDJQKyjm1Wu3hJcUXOk/Q6pan/3LqkZQpeoscZSx+VWA0KAyo+/CwII0o3mfzS6
         kunPA3/qnUMv3sUq+iT5iUvIZLFi7iHsPlNKP86x7ssY6aYSXhbRKDo2z5hK4tdo2V5+
         gZEjzX85WHP5A2i45+ncyW7Qv0QYW5j6Lq+IQfTVhpqZIraUZj1kQaIbFKAdzBYh5rIA
         fYAA==
X-Forwarded-Encrypted: i=1; AJvYcCXjvWT80FTqpnvRCElzuOnMEqTqNnZE0npUz0KaB7y7A3MUzA/FUVUGpLq9ZYv8qPldVhSnzjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysaIgwIsipdCpBmUJe+RLie03hxs48V7sKgXYNEBZJ+k7pyi1X
	h4V6kkZqZTpwtlQxEaubZH2q4okDBU3AMiT6GoZLBG1QHwguz03UJEmP
X-Gm-Gg: AY/fxX5EpDIfaWLAh6UMIYCoLZRYm7bvYgexG8OJ7DeM3y6vNWKPVq7pUzYmUtlzLCY
	wfiJwbdDJuSSDSswZuGgrCiqTFzNFUU/B/yjb1pQHWHJjTMJ2r35t0q7wug+zPSPUKXVlihY1HH
	p+KQqxUE+e+A8ExTe7KKR2NNwLoFlmm9tiiqgTOImzUujOLzRTAcXg/UekziWwatmv8WGeGwC8G
	ZNSpwiNBj+McclhBdQ6bvHQuPvM7eDn+/weceF+n9bsLo4kedQS9DhptE4jCTG2gBY/MJsWF+Ps
	bXSs2eQgjWvEBFnNim6CLWaQF1t9juyKoEAV4Sfvq/hrgQ8DZJZBgloml5ZiPjQwX3lTf99QB7z
	dYsPxNN8xQ0XiVrrxIjxObKlA//0RCNwUpY0tAF8SF0arMYx1IC7GGGxjfO4WiN24msOZ0Nky+/
	hYEEQJbTQRFnPEqsVeS3j29FM=
X-Google-Smtp-Source: AGHT+IEkR+HFL1Nq5SpvTf3AgMFECL3jz/y0NxbGAy5WuzwF5WmF+0vXkeRJ3kFSqnA+wrIjSWB1Lg==
X-Received: by 2002:a05:7022:ef07:b0:119:e56c:18a7 with SMTP id a92af1059eb24-121f8b14920mr9924771c88.15.1768063691770;
        Sat, 10 Jan 2026 08:48:11 -0800 (PST)
Received: from localhost.localdomain ([202.120.237.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm19509083c88.12.2026.01.10.08.48.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 08:48:11 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	YiPeng Chai <YiPeng.Chai@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/ras: use proper error checking for kthread_run return
Date: Sun, 11 Jan 2026 00:47:55 +0800
Message-Id: <20260110164800.39203-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kthread_run() returns an error pointer on failure, not NULL.
Replace NULL check with IS_ERR and use PTR_ERR to
propagate the real error from kthread_run.

Fixes: ea61341b9014 ("drm/amd/ras: Add thread to handle ras events")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
index 3267dcdb169c..c001074c8c56 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
@@ -248,9 +248,10 @@ int ras_process_init(struct ras_core_context *ras_core)
 
 	ras_proc->ras_process_thread = kthread_run(ras_process_thread,
 							(void *)ras_core, "ras_process_thread");
-	if (!ras_proc->ras_process_thread) {
+	if (IS_ERR(ras_proc->ras_process_thread)) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to create ras_process_thread.\n");
-		ret =  -ENOMEM;
+		ret = PTR_ERR(ras_proc->ras_process_thread);
+		ras_proc->ras_process_thread = NULL;
 		goto err;
 	}
 
-- 
2.39.5 (Apple Git-154)


