Return-Path: <stable+bounces-104377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3509F35CF
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365AC188CDB0
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0E205E17;
	Mon, 16 Dec 2024 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn9w42Sy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D973205AA2
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365939; cv=none; b=NZbPeqG5drA5J6t1MGxqs+rY80rJs3QiCHBg8iiQ8o1vuU1ji1BoYK1GGuOR5CoSXIHJStQFMmslXw8lNW/OckZcs3NnVucWoyNERI7CvsTum5bYojyX7NGDseThDB1ZNammvq3Ayf3A1sOfQsDmJt0w3hjkQUDAFXYiHR7Cxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365939; c=relaxed/simple;
	bh=ZaGdQQjj3Qdfk6Wvrhwsu0DCUxkT0Ke3Ra3klsQTQDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hSApFByamLAo0fwZcaA8haPovbvaNs+SxdVkaIbmNfpzYGRG0t9vzx3pzEPs20pOzymoCtbA3eyAuH8bTMDBtRWnUCtNTU0Th/Hw1qXoX3f1g4CMiYWqqNCObQX6KC4Nzo+zPAg1ij1OdvTqsLIq0hNfm8Qx80ltyke95TlClI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn9w42Sy; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46788c32a69so53260901cf.2
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 08:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734365937; x=1734970737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9Z2G9GDtXBiZHxhzHK/5vLeEwq2Ibx5vMHb35f0cng=;
        b=fn9w42SyEqfVZo+zdNqyyeItXinQRaLv0YWzOhnczvCCs+kgpEVNQk23akbbvAwyuX
         dKTKbrN+TRJyGZcOkKHgq09YwS8Y5w3CVN6zrzLG5MaanQsm81+U+d/LCRNGtWuc3C0D
         ErgX0LLa77XanwfgRcdVzxmjOizWz5WzOrRUx/UgKdZxVjpWbLWsVVtWjkjsI6/LLRwY
         p86IE3D2iTtubqrLDFZ9kHCBhplJCnDkA1kSwW6qDC5/go2d09nMKlhHAgfvsoAIBkzz
         fMTMqPSPBJTJaGrM0fTfUPp0tCkEH6gOt7ES9/BlPy7/NTw69X8vfvpk/xsgJcgVvNPt
         69xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734365937; x=1734970737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9Z2G9GDtXBiZHxhzHK/5vLeEwq2Ibx5vMHb35f0cng=;
        b=ZLlhPVQngUoen13Q48MNohjyMj1hnVbJloGeSDnTxm5aFW6g0nXEhG0DynM7k9HArj
         22Hlf9NHHzRRdi+k/kgj/SeC7dwm112OHm4VZXq5LC5QBzFR5uEWcGgK0UWR41oVCxs0
         AZ8OtEpZnmeQPEN4Oi8evhAnpq5BoAQ6TogeL1t9L3LZ2snir6PqFaqnU0mbXFEIjF0u
         Ogi6eyEu+LdR6xNGWUXejXpjcJcMAMkiB2OY814ijJyfcQeXfwVv/GyMIDyyo6BNRUQl
         l1gNFRobgA7hAFmcMzStI70KziCrs51/EQbPk96+B40pdfHTKKw7lHaJ5SDpfTT1nO3m
         zoUA==
X-Gm-Message-State: AOJu0YxMfMXxtQ5eO4/geSgfOlkQgiN4tt95Ol96Rf1C6E1jDPInhm2e
	WLCLWjbPheHaYkW72ePHWM6k6+NYown4Qz1m57aHiSwnQVR/n9gzXY9Ddg==
X-Gm-Gg: ASbGncstBrmAzMJvLE6XeV0BYGzMTKJfjSwHVCAGPb4H7qIny1/BjENdArpqdOBo9dY
	Au5Hz1TMiIXUP6u+QdwHVnGmc6dGq9H1fX3f9xg76/eE7bnvFU3PoqUuJRSi9jKrTGXY2jeKTV1
	gW3EcYPApu7+gK54jRRhofh7pnf5uUXwHipIl4VdjgsnMptpoWelh2nhs4K999squcSkdEo9iBc
	E29P4NF8l5hztinb12z31prch7o2s+Opc2c7xU6xrr9vE0DAhfn5zYrNue2hNyygs9zEcIzjCa3
	SuY=
X-Google-Smtp-Source: AGHT+IHL2IVwz2+oOb/TCRISmYH1HA831b7NqGDjyg+yb561oJE9+lW2dL4fsd1+SKXvK9qACWER1Q==
X-Received: by 2002:a05:622a:216:b0:467:85b1:402b with SMTP id d75a77b69052e-467a582d320mr204940201cf.47.1734365937171;
        Mon, 16 Dec 2024 08:18:57 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048d04f0sm237117085a.120.2024.12.16.08.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:18:56 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH 5.10.y] drm/i915: Fix memory leak by correcting cache object name in error handler
Date: Mon, 16 Dec 2024 16:18:40 +0000
Message-Id: <20241216161840.4815-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024121517-deserve-wharf-c2d0@gregkh>
References: <2024121517-deserve-wharf-c2d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace "slab_priorities" with "slab_dependencies" in the error handler
to avoid memory leak.

Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/gpu/drm/i915/i915_scheduler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i915_scheduler.c
index cbb880b10c65..a58b70444abd 100644
--- a/drivers/gpu/drm/i915/i915_scheduler.c
+++ b/drivers/gpu/drm/i915/i915_scheduler.c
@@ -538,6 +538,6 @@ int __init i915_global_scheduler_init(void)
 	return 0;
 
 err_priorities:
-	kmem_cache_destroy(global.slab_priorities);
+	kmem_cache_destroy(global.slab_dependencies);
 	return -ENOMEM;
 }
-- 
2.25.1


