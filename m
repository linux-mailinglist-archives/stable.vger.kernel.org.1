Return-Path: <stable+bounces-191746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D499DC20D8C
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 16:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 779EB4ECD3C
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0532721E;
	Thu, 30 Oct 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhylVDr2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F91DF736
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837078; cv=none; b=kVDy5NKp/QZizEge/a6q4SpIfpLhzkrrgz4yvdAQ9JXKQA/cqCEciIrCSW1s22j4wkSHYGcHreV4Ct6XKtOZVNebmNuRRboEH274lL25nKtPKGPU6vKaQflsmIJpaahC8RwaNGhJF5/Hs+CPQ8EIdFe+aydcK5i6Jp0C9gBAVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837078; c=relaxed/simple;
	bh=lT8pY7VpXHxZOVd1czQCJxzZlYwnEuyse06oIeRV+Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MIiWcMTl/KuA9qeY9fk0rDI6JnCesKYoTX/7ELQGtKLOvQZEbYdzxRthK9DA4YTMcUy1jFWiaVJggyBoDiiNomuUPce16JmS+PpoYXUNosNKIXSbzU+wA5TUjLGk5Xb2/LS6wufjEoe3crEqq1X1TKmntQ/stONsix8aVGn5UGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhylVDr2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso855515a12.2
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761837075; x=1762441875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhBRftSrNtDpB9m0SoTTwtcWSN6u49zEAs37m1LLadc=;
        b=OhylVDr2lwNJr0kjTzhhsQQEjjKt8xckJ2rVQqtmNgUQfP++jde+j2tAtJ27N9Sbkw
         WzMJWNw5L3nQNHFYN0Ml6ZRjXH42GZ5ygJfB5DRTIORpzNPyguZvP/9/Kf7Ja3BVDfcY
         i5Zownknklp59ls2NpEVrMc1bFetyVGmau90AKKtGAm2wCHgrnJs5Ss0JEfT5S/UFltq
         W5IjRh5gJjs7KuEKJvKgZyPSmIVPRw9BlrJxBI6qv0XLF9dpcxO44x5KPxJqTEeoibGa
         8F3c0IsZ2fX9J5rETkdVXtCX0ps6eLiIasGwKi1gbSK+yQzJmgITGMtHlNydKGd18Z0d
         guWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837075; x=1762441875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhBRftSrNtDpB9m0SoTTwtcWSN6u49zEAs37m1LLadc=;
        b=ARXj5irY6KcvD06B4rDfGOZACRoOPj21X3GJOuJ4l8dXTuLs5CDD1aadHNKgZZvegq
         lZV2gEB8F7D3QOG1nf6Kvn4n9wR6s5nOsfl34hAPQ+km8WFVe4Jx5uvHxp7wkmTuLW1f
         Ousq9OWEKfi/C70A0hvN4nOrleLBxI2VnCnd3wA18bs/zUCqfBP3ZQ5qvQYCu0jxQu9+
         IdbaSlEX11icH43xseJhkJ51DO6Zys7cGn/wwN1LR1xXpsGqTph9JBc7WCZnfjXqHfAQ
         dAKFUFRoh9TdisQOIZQA1Xi/6aB4TyT1TfTn/1cZZPOEdQt5lZByZZoFUn2j+Gn7r22+
         1+xA==
X-Forwarded-Encrypted: i=1; AJvYcCVgGNuFIF8KUZ5cZhbtQs2vbC9wd2ZidRxRb10govS92D2Z1b8ISdO+aXt597ikL4480CxFC8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpipIqqayACsHrUGigbTEzj4+da+KSbNRjOuyXEKnyT+AJrTov
	aKZuMotunsbNRnKJ7JUCxO4rM+2Q/6eZKpPEpDBOoHH1bNtxleX8wEZT
X-Gm-Gg: ASbGnctjZpHep010174BM4ZiN0enJi5YZ7yWqChydu3woxDoxp5LCgcD02bapsusjBy
	hVwEKPgXDLdIFaZaYkDeb3/OVd9PZ8yKfhkUrEtxfWC5TPSaHJwtGo7g4SfBbmxmnCG5N/4M7bw
	iS9FksTrNlDmobWC2vG45dlBI3dyWQg8Puvjmu6tWAdJ2J1yM0/7+ROuAZjnJ8hYmBb1lwcf5Cj
	yTuZQpNJebQk8ZgI7mF/RLDONwd4loGHDmh97eQJUqgDv9DTd0Qfjafhb4dmXAh0bK+3S6k4+bo
	ZARUKzZBMQk/p25DeQitPhnnVhEVJMIuYzy7U2y6TS/Z6cwaZJNVzBaKCIONFj3A/xHprcFy6gx
	hRp8Xu8qRZOHMqBorm1Xn6gYdchkHBMZGQL74PvNOzY5gJQKQVLguHi4+wMt3GzDF4/rfZWt2lE
	MdShUOClvpiSrGUiOuAL3NeeM8tLSdBjKH
X-Google-Smtp-Source: AGHT+IEmDJsPUeNmdNto41ham/oBAJP1/xDXePFvCThGXIL5Hte3EwYty2Wqj2o+ytJ+3UW61AGbwA==
X-Received: by 2002:a17:903:234d:b0:290:c388:e6dd with SMTP id d9443c01a7336-2951a34ca43mr1215835ad.7.1761837062978;
        Thu, 30 Oct 2025 08:11:02 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-294eeb94d63sm32840245ad.5.2025.10.30.08.11.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 08:11:02 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Scott Wood <scottwood@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/fsl_uli1575: fix device_node reference leak in uli_init()
Date: Thu, 30 Oct 2025 23:10:40 +0800
Message-Id: <20251030151043.63402-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_get_parent() function increments the reference count of the
returned parent node, and of_node_put() is required to
release the reference when it is no longer needed.

The uli_init() function has a device_node reference leak.
The issue occurs in two scenarios:
1. When the function finds a matching device, it breaks out of the loop,
   the reference held by 'node' is not released.
2. When the loop terminates normally (of_get_parent returns NULL),
   the final parent node reference is not released.

Fix this by adding of_node_put(node).

Fixes: 91a6f347921e ("powerpc/mpc85xx_ds: convert to unified PCI init")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/fsl_uli1575.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index b8d37a9932f1..36624c88d5f3 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -376,4 +376,5 @@ void __init uli_init(void)
 			break;
 		}
 	}
+	of_node_put(node);
 }
-- 
2.39.5 (Apple Git-154)


