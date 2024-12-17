Return-Path: <stable+bounces-105069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013249F584F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 22:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C063018927A3
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EED1F2395;
	Tue, 17 Dec 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9CIGdUV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9F1FA16B
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469256; cv=none; b=WUkwTF7h2b822ExytiX/7L1niY15KRORQo4Jjix72IpMJraDyMCsk9i11WFMq7WynSLBQyD5U6o1SHysQo8JVglMBWD1Omt4SOrXkAJ2Z+w6Z4PNroszCI2Urm9AGM9056SSUghmC1QjfaqYhNCxgnszBK38P/kY96A+2v8cdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469256; c=relaxed/simple;
	bh=cSWNN9VrTD09qCfOY4bp3i+YZjJu+E56L5vWaiaypNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZcbFwdr4QlJynRXBodks0JLrJFWjuv0+coofJGVg0ZuVnEYmVQzfpfcu2s0oRsmth/q6Pb/OiqXEKGnyBIUb6Lo4Nt5FAfsQN9hZKmf6GTI/Jpe0PcLTTV1yJWoBIYSpkaR+HXLTpzsABVen0qMCE87pZC+eOCIh9J7IZmKg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9CIGdUV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6f75f61f9so786764385a.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 13:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734469254; x=1735074054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kirC6G46K69lwuH2+97a6770PtGhwjmor7gYJX1+8c=;
        b=N9CIGdUVgav/JTMk/K2C1To9weAnodaeF7+2KV6h+OpnfenxTPEOTKXs7EoOdA7wkb
         K7XgkkB8q683D6TlKVdmqjqiMrfXF5oHZjEa/Gc2iPY8eK2EJh5ZRynZPowQ9h5gfeMQ
         JXnAbjqDnQc86qAMwg0/qc9itCpLEVAWtRWTSd93Yp31fLnMEJJmpsAm7geWs64+U6Xv
         UJZOODUSfvhyJzhjRCBQykb2jxT11BJEHEiuS9We9Nw0etPHAc6pVD8o0kBGrMo4ckjo
         t1izXtW56PC1Yb1+D/CKVp3Jif/Hy410jq7Atd/Qqnz9yPakNVhOCtQhtvj5S06AxVdz
         8D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734469254; x=1735074054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kirC6G46K69lwuH2+97a6770PtGhwjmor7gYJX1+8c=;
        b=dmEtVUhVhjYjtT7g60gfNvu904nmHNW9eExImI+2HhYa7/9QRCaSiyDDb7VuSF49PJ
         F1TCt7oz7QOJpnrA+eiGwAgoqEVIXfBwJ9R62ofRRWhlarA2jbCet8wC1wU+nvVy7n5k
         TCO0qAn5occP0mIs8xG7G5RFgR4U+McnBAGw4NkE4os10V5AljdOow0zVZfxCG+RliWa
         qSPk+0fMTNqHbunV6bcW9/+2G74DmncrFvmP24Osu+UO4FcGQSoMozSN4dTyXjfxeIgO
         L6cEdqeJ7JjB9pbIsAAiRznBprRU5SZYl4O4+ATUuqqTolir2Twr8RwuH0cHaRKEwH06
         PcUg==
X-Gm-Message-State: AOJu0Yx6DjdeEc9DSLwMiiTFPtXYStKKfs/AFaVC9f7GuaKx8q2heem4
	4d1wXw60kFafLtglN4KBsHydBfGZ/HKA69I0buhr6rii8JHSQWMCWzohNA==
X-Gm-Gg: ASbGncs8esb/uFincHJ0dEmSxSVTA+h1nVXiNENeZ1fqnneoBbKZM3viIXhgPKxSTRd
	rWmBrx2fuJri3QUEVJHzpWYdnwnPkPgplD7HsML+KAguMa/jk2WnNLZ0ORN9Y4luheaE+3ZAk+1
	iiY//tcuYuRsEpL8Q6nfzXqKvMkQVnh2qQYcN6YC7O9cOF5mPru8IfBu0WNvFDAuwftfR6KQdCS
	ne8tfmLf2OmNqH9eatsz9rOXfuxQsTUbDUxV92YqxraJp/atZyvd+W1V76U74BWDfBXQlMpglA0
	5QQ=
X-Google-Smtp-Source: AGHT+IG4bCWTpi2478suyibcMBl5i/jmQO5vUYcLskQ1WhPI9SJPEZiu25lu5OWjewF3zm5xMjl+kw==
X-Received: by 2002:a05:620a:1727:b0:7b6:773f:4bd9 with SMTP id af79cd13be357-7b8637b5933mr38828885a.42.1734469253932;
        Tue, 17 Dec 2024 13:00:53 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047ad1e2sm353314885a.26.2024.12.17.13.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 13:00:53 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@outlook.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 5.4.y] drm/i915: Fix memory leak by correcting cache object name in error handler
Date: Tue, 17 Dec 2024 21:00:51 +0000
Message-Id: <20241217210051.36137-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024121518-unspoken-ladle-1d6a@gregkh>
References: <2024121518-unspoken-ladle-1d6a@gregkh>
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
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241127201042.29620-1-jiashengjiangcool@gmail.com
(cherry picked from commit 9bc5e7dc694d3112bbf0fa4c46ef0fa0f114937a)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
---
 drivers/gpu/drm/i915/i915_scheduler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i915_scheduler.c
index 0ef205fe5e29..7ef068dcc48b 100644
--- a/drivers/gpu/drm/i915/i915_scheduler.c
+++ b/drivers/gpu/drm/i915/i915_scheduler.c
@@ -533,6 +533,6 @@ int __init i915_global_scheduler_init(void)
 	return 0;
 
 err_priorities:
-	kmem_cache_destroy(global.slab_priorities);
+	kmem_cache_destroy(global.slab_dependencies);
 	return -ENOMEM;
 }
-- 
2.25.1


