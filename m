Return-Path: <stable+bounces-179817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0BB7DD12
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBB1189CF78
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76452343D92;
	Wed, 17 Sep 2025 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ5DJzue"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDC309EE4
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103661; cv=none; b=u8NZn84L/ybqEI8euz6LAA/81fzwBbRQxPo0YVQOsXAwpwuX2L0xk34VK+QUJxWqnRIDhR0RrAIE/8LesvVhTh5zqUKNT8b08R3hx8SIGXMUj60LEe/G9DPJDuFfpUnlX1ZLLtIRm/LCiY2y8HxzXUR4PItYOTQFELvMz5pVn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103661; c=relaxed/simple;
	bh=79XxpwCu3fVL4v7JYlGHjCi3NPeqcX6mf5J7x6f3YwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MquOKAgBJs+y9fwA/3K9DT4yqgjjzQAh4MaToMEAAX2o6L7mkb/rdjygVC6zCZ4U0ahbk3o+Alk1wlpgo/Z5FvfsjVYphIp/spNugGAHIbIOCxSzUsbxuT4Ysl7Okm1tpEpxGAmPNPVWu1cOylXXwJfuPK2V/PFX8Nuxz4YkQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ5DJzue; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7723f0924a3so7885450b3a.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758103659; x=1758708459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWKk+L+NgCa/CznAlFierH4EX24Xz9GhhvirFRfuiOk=;
        b=gJ5DJzue+GpiW6zYJkTRyOIFd8VFq4TL1fJDtQVv+D8L1pTBk8J0WAbZW8PfHwuMsY
         TMQ6ExinwYOzNjw13XKeM81GCNxSHGe1JTMz3ObPjJIg6H+qH43FjBCT7O3gdYF/HKUS
         6qciQAWqKMKp9kEu0Gqi5N4Z6WFn91u0VlD9wBB+vRgtlzgGuc60cK1Ce97LLO0Vhdqy
         vNJUhRe5XczyMEFj7JBNtA3ovTd1BIjGRhabZjY9O0i2h4yG7DS6V0mSSJSAwtodBrla
         jhnoqgVc6BBduahNVctkgJkmri/5+lHO+ZWM9EUynjuZapdrfac2W0OIUYsEZ415v/HH
         GtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103659; x=1758708459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWKk+L+NgCa/CznAlFierH4EX24Xz9GhhvirFRfuiOk=;
        b=bORzOFAO45huSBYea/cfO1VfrOWX9WEalD5gt/patQA5lRDyY/MVRwynhyIqUziUoc
         XIsY5YFElkfMmjsQOdm9H9zWH/DnvKQXn3E0jlO0029kdERRznbYpTKNnQbMeRYKOHp3
         3VbBr8em35OW3bdlbQJPPARYmhK5o0bC30js4jn6q1H/H9bwqF3vvrbsY5Ule3efTns2
         PN9jByBrn8R3mVh6GX8iWUkPcv9ehlXxk5H7K/NMgzR7BMK8gT+sGKsAyjWHGf602SQR
         58ix1c+5LDw4QyX+nn8yXOw+RPUO2wL1Shb3MSWRIbrw8gZ5F3tE5BVzrFN5dM2uJ/YI
         altw==
X-Forwarded-Encrypted: i=1; AJvYcCVVhzam3QQ4DmUuBIH1ukthyIaNS/3gX2J4vHyQyhDyeS7RPxr6OP48pEHxt61DTy8rnqY4xGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4P6QYkYgGHzU4Bq0uohsLK+sOm5NM0CgXFTG9peJGKbLE8tR2
	Jm9aSt07iZJliO+6xUhefPGi3i0LlOPxRyrTmt1zLxqz0EP+gN+hNTCd
X-Gm-Gg: ASbGnctiJLXMKpT1eYp1mtuohyppMwMrEfHZMEcewhWyJ7Yl8/3YYwxe6Zm1B7tNzcW
	sQYFiRD2+szam1Op5z5GYsHTG2C75y+BsoSTYjsXtE0yGBfZIuJIFfzx331n7Ur7dADqzdON8ru
	HhoW0/FNDesV3N9iZlPJpCve/IyqZpjHWGWAHEBusHCBsJWch0ADJZiwmWfeM2SdR+6Zfs1qquB
	r+F2nac21FCImKJnGMXxJaboKTKJ4abAcUQv/aBGuJVNNmNxCGjvjTy1o43/ixP7T9aTUcKDt4O
	ujIdL7OHT8K7KYv8nNRPYLZH/DSBJITcedpi4tPKF7du+O3ua9MtXpXKJN3rvEVtZ+AHNq+/IvN
	QXZwLlvGMDpIU9DkM3MkqQZ3U1ussAE7y7RdHxySJRaR3FA==
X-Google-Smtp-Source: AGHT+IF9K3dVlb8ccRBiSP5pGnBRvctukZ7RbjT4DoZUseVEPPY5yGUGZzfk2a28zPdCsJkcLZP4uQ==
X-Received: by 2002:a05:6a20:431c:b0:250:9175:96e8 with SMTP id adf61e73a8af0-27ab36d0dc4mr2205624637.45.1758103659082;
        Wed, 17 Sep 2025 03:07:39 -0700 (PDT)
Received: from localhost.localdomain ([115.42.62.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a398d26asm16652750a12.45.2025.09.17.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:07:38 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Fix race in do_task() when draining
Date: Wed, 17 Sep 2025 10:06:57 +0000
Message-Id: <20250917100657.1535424-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When do_task() exhausts its RXE_MAX_ITERATIONS budget, it unconditionally
sets the task state to TASK_STATE_IDLE to reschedule. This overwrites
the TASK_STATE_DRAINING state that may have been concurrently set by
rxe_cleanup_task() or rxe_disable_task().

This race condition breaks the cleanup and disable logic, which expects
the task to stop processing new work. The cleanup code may proceed while
do_task() reschedules itself, leading to a potential use-after-free.

This bug was introduced during the migration from tasklets to workqueues,
where the special handling for the draining case was lost.

Fix this by restoring the original behavior. If the state is
TASK_STATE_DRAINING when iterations are exhausted, continue the loop by
setting cont to 1. This allows new iterations to finish the remaining
work and reach the switch statement, which properly transitions the
state to TASK_STATE_DRAINED and stops the task as intended.

Fixes: 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 6f8f353e9583..f522820b950c 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -132,8 +132,12 @@ static void do_task(struct rxe_task *task)
 		 * yield the cpu and reschedule the task
 		 */
 		if (!ret) {
-			task->state = TASK_STATE_IDLE;
-			resched = 1;
+			if (task->state != TASK_STATE_DRAINING) {
+				task->state = TASK_STATE_IDLE;
+				resched = 1;
+			} else {
+				cont = 1;
+			}
 			goto exit;
 		}
 
-- 
2.25.1


