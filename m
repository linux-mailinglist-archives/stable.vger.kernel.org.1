Return-Path: <stable+bounces-98167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 460529E2CF4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 21:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D481B284812
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA4205AB4;
	Tue,  3 Dec 2024 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnfwY67F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A92036E9;
	Tue,  3 Dec 2024 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257357; cv=none; b=Qm+Faabd/UvU7Phc97Adsh+18leLwgPM3MSa6PfKjQFo74j7V0GDf5BsMZH7rwu+ihQZQxBXbcRBuvTg2VKXqKMjGyKm4KV0Jz8ms7fl32qJQQ/bOpAO7H43l0dpO3TBsfWZg0A5PNrEPYWsGfYPInxvUSYWEVbGakhkg+ZCZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257357; c=relaxed/simple;
	bh=QiWkntmOJIvlsVWh59ai+NTGuXRE2SklCh/xIy+OmcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K6Dp84jpeBw6g/L/6FbZmWrNjyDzAEN9NfGbJohdpsOoy32sgtwLhLnzlTSO4ZM2nIHwag6vFR3c6p/6sUmf0MlqHx2CaSoHd+oeQlMYjpXxt279NVNrcnB35ZStviumIvmDRaCCnos2Qa7L/YsSXJl3MGuVgiwr3x7Mj997m8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnfwY67F; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fcfac22a30so34235a12.3;
        Tue, 03 Dec 2024 12:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733257355; x=1733862155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx+K5ZIsPFwXOV/2/aw93G/c9jTtlI69qmbVhfNKVyw=;
        b=CnfwY67F/JtF9/c45DcpCuKLOmq2mcbny6L5kuvd429swwFCyGe6jFLY3pmYcYiur2
         /AeW3Ir1/YBD7YSmtNSq86q1nLLHH7/O/JWTxXFfEk0FI+4+FKEGzOYz5LyU+769/DJ/
         SUju6LUa2xKQxsJGXvdSUigpwLlq195bnBwiCwT1UU46S8dQJ74T07k833tfR8ro4av2
         rrVTPJwsY36jqbKbIQfPoEEApa4UpQ10/m4nDxkBP0wRMswTLDrQK4462JAiEWv3nWaS
         k1jvCu2ZKxUHGkDpQwcLHGNSPjBYKN0tM00GkGg2Be3msnGC//NfCj/1SrUyMFveckiY
         TdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733257355; x=1733862155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sx+K5ZIsPFwXOV/2/aw93G/c9jTtlI69qmbVhfNKVyw=;
        b=T/ZCYTZ+iQy4idxEIBITgH+KrZRO+XnSdZwmC+YEnLQi9U8rC85adNJ2lm6FuSM9Pk
         ki7UFmzGCubAKALjSyPJWwwVaJmc76lcPSeWvk9zpXKF/nxWlOJW7jEwuq5bqAXrd6YT
         lIFBwPO7tru/nhtvpLCKYI6gMKB+ecnANIVPoK0YuIuqU4LTCqkfCIM34lCM7ylfTrYN
         z+B+mBEugFptlPuJFnGnpD2624O4kdYqa43QsqPY+z2VfrIofgUhwT8yfN5vBGKyGLLc
         ojTbFrzqEks9rv7iDxL2KXG/RzWUa2LUoPMOtC6d2lYcuTca9fpl3jfhc8batGYH5h1B
         rz8A==
X-Forwarded-Encrypted: i=1; AJvYcCUf0FPciAWEL+VY6ygJROh6k/DEILv9Z5Au3bCu4K4Jtg7cBw4yXU0NvoXKxr0UNNEmraOl9rCQvx6sqXiFlbWCqYcL@vger.kernel.org, AJvYcCW8jVdISuPdAMrk7YN+00pmrRe9msXzUQqjLI/EKPT7JoJgmlMHofG0UXzSBBGqy47g8IMOcVVhX14OlKo=@vger.kernel.org, AJvYcCXc+dUIs3SoaR36932AxIPLwSCoxn/mPA2R0/HQbpES/77B7iGr9wfoKtNkAGgnUB7r1JS4cZLK@vger.kernel.org
X-Gm-Message-State: AOJu0YxprcXCRWjFv9HypsT8lLOSFtBwJC4yftrTlUvJJFizQ6hd95Er
	PLVH4fMHY1/PwuAEXpyZk8Zda+ZLKKyKyTQoaQiDLeVvknXUQYbg
X-Gm-Gg: ASbGncvhOUr1KPa+Zvvs59ue000Jx5zT8P7h1js97rRRet2iTU4BCMJjXAVXO2g6paB
	mElOOXrTWyaSZ/9986boYArh55O9mVN4RkGDx1hDOaK1HwSNsrvea6sb26CQVOqmoRvdjfcS5P0
	m2FMAduPNFRidfKsjOtZLR8TZ0VtDNWdb8rkL8yBlarohAFa5kgZLB93vDUnUZNS4N+CPjkEtU/
	cLmY1MdqyeCQ5yvLzcCOZVTjFr7etBQBDNLhRm4iv7htnbiHnT5I9TJszDD0Y6NTY+aJ8LEonO1
	QjnZ
X-Google-Smtp-Source: AGHT+IEhucJIXU6X6nxM9tWt+IyPP2iefp9deL7jOUsCQer7ucEciAnibvV+t/ktJrMsruq2H0m9pQ==
X-Received: by 2002:a05:6a21:789a:b0:1db:e40d:5f89 with SMTP id adf61e73a8af0-1e1653f6b9amr6450875637.28.1733257355253;
        Tue, 03 Dec 2024 12:22:35 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254182bd1esm10907799b3a.165.2024.12.03.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:22:34 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	namhyung@kernel.org,
	tom.zanussi@linux.intel.com,
	jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Fix cmp_entries_dup() to respect sort() comparison rules
Date: Wed,  4 Dec 2024 04:22:28 +0800
Message-Id: <20241203202228.1274403-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cmp_entries_dup() function used as the comparator for sort()
violated the symmetry and transitivity properties required by the
sorting algorithm. Specifically, it returned 1 whenever memcmp() was
non-zero, which broke the following expectations:

* Symmetry: If x < y, then y > x.
* Transitivity: If x < y and y < z, then x < z.

These violations could lead to incorrect sorting and failure to
correctly identify duplicate elements.

Fix the issue by directly returning the result of memcmp(), which
adheres to the required comparison properties.

Fixes: 08d43a5fa063 ("tracing: Add lock-free tracing_map")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 kernel/trace/tracing_map.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 3a56e7c8aa4f..1921ade45be3 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -845,15 +845,11 @@ int tracing_map_init(struct tracing_map *map)
 static int cmp_entries_dup(const void *A, const void *B)
 {
 	const struct tracing_map_sort_entry *a, *b;
-	int ret = 0;
 
 	a = *(const struct tracing_map_sort_entry **)A;
 	b = *(const struct tracing_map_sort_entry **)B;
 
-	if (memcmp(a->key, b->key, a->elt->map->key_size))
-		ret = 1;
-
-	return ret;
+	return memcmp(a->key, b->key, a->elt->map->key_size);
 }
 
 static int cmp_entries_sum(const void *A, const void *B)
-- 
2.34.1


