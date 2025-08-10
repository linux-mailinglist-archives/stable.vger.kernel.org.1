Return-Path: <stable+bounces-166951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D9B1F9F8
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 14:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC6179387
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0089D238C29;
	Sun, 10 Aug 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbQF7Dqi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7323F27B
	for <stable@vger.kernel.org>; Sun, 10 Aug 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754829735; cv=none; b=pMmDBsF8B/IPozjHvLOGztx9ooCIFMsF/nOxdfO8UIJr5yiNKzVt8m0Ys3Cj4VmUsfc8XQaXNx/kiqeJ1wUz+w/dlcsfKMFfbMLbnlC5gTKJUbN3hzqQeg8+d3nuEqJtvhmZcyMFTAvyzEj31CmCIpNF7snDscbwL5eRTHLiQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754829735; c=relaxed/simple;
	bh=gE96lVOtXgq/ZhlPKHnIRtmTKHb5Ug1DoPpSL4rKlHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qd2Ug7YnmzYUMw4bCUMqEKzJMnZb7Fs585V72DT19hSLYRhXaSDWkSY9yltjn8LdM3phStdOday7dSm7Aa/HTnQSrfy8asvqqso4RwHyjus+Mys9JaXSFO+wumHqHktCvERRJqir+CmqAOLzbxj3b5wtkrxS/7Xh8sdl8VzSx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbQF7Dqi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2429d9d3755so33531515ad.3
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754829734; x=1755434534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcQGvKOIDHORnKmX24vXxaChAnLPw5HFeXu1GYRj8bk=;
        b=VbQF7Dqi/KY3Ab/2l5efIyqNHYSjHRrLoX9LNhmKes7/5xjqDoo/mT9/CrE6XDkMEv
         vBpXcanX8PdMvwITH9hIiqTLL0dlR3tc574Dt78emZ2+hIc3eW41cf2rPf3zUsXZaHOb
         ytsChfJjwr66YHeGPqBw9NSsVkm1omQPjtxt1cZfk64M+mNLiIgsgbqERJz+Qe86vTTA
         N4mILREJi2IiApnF4eX4zwVz12Nf4U15zY19rSXnZn0JVdn6KXPb3a917kQ7G1RdSroU
         l8LwG7pleu+RXAQqhCtmgb2r/h+COES1B5yEv1Btw6scjCEzCz8IBmoZZK4Q4ya0HTQw
         1IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754829734; x=1755434534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcQGvKOIDHORnKmX24vXxaChAnLPw5HFeXu1GYRj8bk=;
        b=PWj1T+sr231wHLm6YxExUFw/ia7X4JvlMIzOrZw7PEr363iwx0Oxk5tXO+4kb5AE16
         zQful5dUFwnrB7VaIHhqnU1sZxxLVllUrXOTwUj9qDdb/yk8c4PsvcIHLmRGIECPG83E
         veJoUuaT0LNZKYx+qGBR8vNQVLNuJWUu6RvFjFxAIbdg7tsTLX7pjwV4gD7WURPQjI53
         1/tWy+w69F3eIjfzbWeqD+5TC/qdVcBUuro9iJlJBottlemabzdw0AZal8ou4vmwPm4w
         S+u5AkG5RLhN9qmZTd6gRe3oAqOUs0pa3//6H6SUUT8lMxQ4BWmtfMO5e75yytHsrkRi
         Kpmg==
X-Forwarded-Encrypted: i=1; AJvYcCVZdzNHk3LXwaQ6J3bpPzzYoQJeodYpNlvZo4ppMrSNIAWMoX1ZOsr4O3KsuOTDQsyTMzzLa7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7d6QziXld0vKKmCfPpVR2eqB3e8uBHAS7vmenUHJsy4NzEsu
	PnjGu+tn5mbjbi+I4KL2VCMISHT8H229ZOC/4Yivff6HP2ZPf5mrLg2O
X-Gm-Gg: ASbGncuc+29ctazDtgN6+pGsKw9bYM1cDR+ZHKJXk5e5ufDYl75qcWSsFGMG6fnH2BK
	XkC2/WO4n4FoR5Qg9DbRHQFAlqrZndrHsk8a+CBNGZYZFeqzZMaVHkY1Yj0DFh9CNbFjpKtiVxh
	wBULRD8t9AODapmbniRYn9hbw8B4q14Wp+RsD1ZtBAS/OzbIclb7a6u7CSYB0keBozaDoOwEoOk
	cfVU8CtoXShvqpMrnODYCZtez54yuZ+6uPXuWRqFvxo0kJl21+0VKmX8uROfmg3QOJOibeDJ/ii
	15bfKh4EPh1RcjsYrS+Ws4wD5iZlQP+eWgH/Qej9KGcFtsAnWVCRnNkdiVsa8DRlrwksUzCOXb+
	w7cMkpjDRhfD7ArUbawL7k8JKcdw=
X-Google-Smtp-Source: AGHT+IHyMhJfJJH1ELv2+P9EgJdV62MYhw2oG6J17PQqZcdm5A9jDNNNKFQVpJpCFbBu8/2aysNFkg==
X-Received: by 2002:a17:903:3b8c:b0:234:986c:66bf with SMTP id d9443c01a7336-242c20037f0mr118041635ad.11.1754829733612;
        Sun, 10 Aug 2025 05:42:13 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e897690csm250583105ad.99.2025.08.10.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:42:13 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/damon/core: fix commit_ops_filters by using correct nth function
Date: Sun, 10 Aug 2025 21:42:01 +0900
Message-ID: <20250810124201.15743-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
iterates core_filters. As a result, performing a commit unintentionally
corrupts ops_filters.

Add damos_nth_ops_filter() which iterates ops_filters. Use this function
to fix issues caused by wrong iteration.

Fixes: 3607cc590f18 ("mm/damon/core: support committing ops_filters") # 6.15.x
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 mm/damon/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 883d791a10e5..19c8f01fc81a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -862,6 +862,18 @@ static struct damos_filter *damos_nth_filter(int n, struct damos *s)
 	return NULL;
 }
 
+static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
+{
+	struct damos_filter *filter;
+	int i = 0;
+
+	damos_for_each_ops_filter(filter, s) {
+		if (i++ == n)
+			return filter;
+	}
+	return NULL;
+}
+
 static void damos_commit_filter_arg(
 		struct damos_filter *dst, struct damos_filter *src)
 {
@@ -925,7 +937,7 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 	int i = 0, j = 0;
 
 	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
-		src_filter = damos_nth_filter(i++, src);
+		src_filter = damos_nth_ops_filter(i++, src);
 		if (src_filter)
 			damos_commit_filter(dst_filter, src_filter);
 		else
-- 
2.43.0


