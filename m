Return-Path: <stable+bounces-53659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2969190DAE1
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B946282DB0
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F51313F00A;
	Tue, 18 Jun 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpm87LKt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973213EFEF
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732686; cv=none; b=gyUHQfxA3dtLM7XSG7b/rd40zDhIp0rW4edIKbzsaH9dK3obTYiCYYBnuaOulHheTbWTQ/X8C1sPjPchJZcbl8dS5ZCb9WmuXN5CFkWtKQReimVkDJgy655rLbLt1fbHzBFiC9SCwrImQInNHL9ODPpEuTPh+diaUaJBOut9XTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732686; c=relaxed/simple;
	bh=NOlQGgsX+qgKJgLuMuaki8pr4CSrIKpa8EbrpMzQ7aM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZM3VRED3eadAydhoQO97KkOs4sLH5vGDo/JZmUtHHfuFje01xDUcdtF+3dgkvV8mtabZ1IB1p1/0QV0HzMCEt4cXaJ4TPc5wDW7hCxir7jMFBpDrdRNa0K0VYvGNkruhWz7CmqHlCt7HDvXafNj38gC1/2T0VhsxMq55xMIIOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpm87LKt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-705947ccac7so5087071b3a.2
        for <stable@vger.kernel.org>; Tue, 18 Jun 2024 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718732685; x=1719337485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rrTRWLB8p+9gLQCiLgyfbl/07dnqepCgaAj7Klv9GvA=;
        b=cpm87LKtAqjnLdZAciJGMl5TGrVq/kLLd3ioSAnuw+p4zfpPxC3DHvAhsP7vZt3wQv
         t+1EHmLZO9PevOmJGUIauYCofrdiKqpW7UhxllJ1610lpLz0RmmLN7U4ZpJQDrTuH6N1
         7Axx6Rn5mQBsEjTF/HKZPDbM091jUVdfW+yc2PKAUMIu3WACgJjodRp5oSXw7x0FNMaZ
         A9D9ENNMkaM6FH4rxyMixEXy9CzCfZyqoyCcsShNEvRVHi5j0C95/f8GUbpRZe/IIo6m
         UH8ytu02e7mCDQ1EcO9KkbfMrMmfrNp4azHFELHlPvKXKAxKAKDOMxsKXJyvnhKRGnPq
         TN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718732685; x=1719337485;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrTRWLB8p+9gLQCiLgyfbl/07dnqepCgaAj7Klv9GvA=;
        b=MrBQ3NP9PhR//DjqePzeJVRFDldDQInJz0gflPN/JSnlOXvV5mw+6aFA++0MhY/OSV
         /sFJTZcVysQeT8QLdkdt9jJK6oGEXIbmtF+RjpA6X2rLLvw63VdIske2ogdQq5u2MLAX
         zHICM8NZifrb3Y5OrPLU23jv+DWGY1Ib9mR5pcCjwisYxYvEhao0r9PuGH416TThVYXD
         h6lEC4rvxyHIs/lSy5ERv+6d+E2dKIFvPO5N5ubUh2eV5CInpE0JndOTzrX+FxfiMQp2
         svAL9y6OLJ1MZBFu9J6EpNnvc3qV+sAYcajlfh0qObJGLpRa3ELKO8UR4FQRUNUWnv5q
         DXEw==
X-Gm-Message-State: AOJu0Yx/aXn8jkUE9a9vRyjYcEuymlWiJgeELvyAYBlrdQbTr4iiBgDD
	FjTer9rjx9sFRyJ3dHjb3snHtoUeiYf0QBBV0XnXy/LfxGzgLMVoJXgyRiBkwXPNAbAYia7uxjI
	uuxbBvs1uUXIP25JH+7Xp6Wblnc8umyk96fYITtZEdlkEgwfNS1/PlZY7AjYfdN8nQiBx/cBduD
	gexjM5Jcv/3qv7bqrEygOgoQ/C9TIvutNwefBz3RsFSmQ=
X-Google-Smtp-Source: AGHT+IGoi6xl/50f9uB5MaWw6Ktg9zYUzebdA/VNWzQbiXxBXCiFKAMNJE2QJCfekVQakQ1EHUOPxZpjwtviPg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:2914:b0:704:6ea0:2bcb with SMTP
 id d2e1a72fcca58-70629c2a78fmr4807b3a.2.1718732684416; Tue, 18 Jun 2024
 10:44:44 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:44:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240618174440.1120038-1-cmllamas@google.com>
Subject: [PATCH 5.10.y] hugetlb_encode.h: fix undefined behaviour (34 << 26)
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Matthias Goergens <matthias.goergens@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Matthias Goergens <matthias.goergens@gmail.com>

commit 710bb68c2e3a24512e2d2bae470960d7488e97b1 upstream.

Left-shifting past the size of your datatype is undefined behaviour in C.
The literal 34 gets the type `int`, and that one is not big enough to be
left shifted by 26 bits.

An `unsigned` is long enough (on any machine that has at least 32 bits for
their ints.)

For uniformity, we mark all the literals as unsigned.  But it's only
really needed for HUGETLB_FLAG_ENCODE_16GB.

Thanks to Randy Dunlap for an initial review and suggestion.

Link: https://lkml.kernel.org/r/20220905031904.150925-1-matthias.goergens@gmail.com
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[cmllamas: fix trivial conflict due to missing page encondigs]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/uapi/asm-generic/hugetlb_encode.h  | 26 +++++++++++-----------
 tools/include/asm-generic/hugetlb_encode.h | 20 ++++++++---------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/uapi/asm-generic/hugetlb_encode.h b/include/uapi/asm-generic/hugetlb_encode.h
index 4f3d5aaa11f5..de687009bfe5 100644
--- a/include/uapi/asm-generic/hugetlb_encode.h
+++ b/include/uapi/asm-generic/hugetlb_encode.h
@@ -20,18 +20,18 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
-#define HUGETLB_FLAG_ENCODE_16KB	(14 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16KB	(14U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_64KB	(16U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512KB	(19U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1MB		(20U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2MB		(21U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_8MB		(23U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16MB	(24U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_32MB	(25U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_256MB	(28U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512MB	(29U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1GB		(30U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2GB		(31U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(34U << HUGETLB_FLAG_ENCODE_SHIFT)
 
 #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
diff --git a/tools/include/asm-generic/hugetlb_encode.h b/tools/include/asm-generic/hugetlb_encode.h
index e4732d3c2998..9d279fa4c36f 100644
--- a/tools/include/asm-generic/hugetlb_encode.h
+++ b/tools/include/asm-generic/hugetlb_encode.h
@@ -20,15 +20,15 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
-#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_64KB	(16U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512KB	(19U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1MB		(20U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2MB		(21U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_8MB		(23U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16MB	(24U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_256MB	(28U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1GB		(30U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2GB		(31U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(34U << HUGETLB_FLAG_ENCODE_SHIFT)
 
 #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
-- 
2.45.2.741.gdbec12cfda-goog


