Return-Path: <stable+bounces-161372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31544AFDC8A
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 02:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB3B4859CB
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 00:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CE512E1CD;
	Wed,  9 Jul 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlELURfn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAC5479B;
	Wed,  9 Jul 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022204; cv=none; b=ew32ANbpL3AtUE481DDzz9UhZCRXupJ3Gg1le6mcl4M4R7AQhXU5VY03M1yI9/Z78a9mPbWzFhObOgsrGmhzN9jFE285P3ZEd5VxC8bx9BzgPUO9XqzmElqDEM9NtdLsJOaquVBXC6kiXzIT/UmyXsB69vBSu/YfKzBOJphPxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022204; c=relaxed/simple;
	bh=NgldNzYwTkhlRxpEXq0DM09IquaTz8VFTwNZv++b108=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1LokhPg5gEWMbyuRPep8hQVomawDpSBozYiFEjebHRGIl4A9d8Cygy6H01uIya7/6huUtMrQE0BXBQRV5o6Pfp7ToTmLEmrtDTy2CJeMlujisiTxFZe6y51LyWwKFWohNeYpqw87peAsd4dknB4DKSWXdNSw76XdmFVi+H/5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlELURfn; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7170344c100so31337707b3.0;
        Tue, 08 Jul 2025 17:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022202; x=1752627002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elsYwPw6zDrpvs+3bhsQ9YOjxpF7Z+Q+nAJ2MBwZBNc=;
        b=dlELURfnQEtpPZyjjMThsG0DVOJ4zDadYV/iIKIXzIzsolVBz7Vi31C9XzBp9I1DlV
         Iq8Y1Ym5+WbSqWqIxz9kCVinSraIWsVLXZlJKdPDLIa715yT/Nio04kMZGCLeWB4YS0M
         5JdCDEYheAwlve6FeBW/6lzWc9oO1DVFxIHaFNmlbiKYndsI4HMom40BAoB2q/wHEVqk
         vZFbAUNhkZ7kcRsXh9ZXMQxw6AwCB6aA7y2A31or5spfDR+Q72f9Y0t98Y8y+KFi7eqX
         MSOXqp3jL0Y7xcagl453R7NlEqB+qTobb0nWidpaA7iG8xRAgMspc2va+LumBdBZtErs
         pzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022202; x=1752627002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elsYwPw6zDrpvs+3bhsQ9YOjxpF7Z+Q+nAJ2MBwZBNc=;
        b=xFSE+4eGQFljhInX6zrxDvF+WDBka7QDmdRn4MZpb0qVFgnb6OLcSA7DbNfBYUSuuw
         nIT5RWM7s6+jzwaveKBNoVxdmlL3m9mkD/E2PSuhkwl1ck1NzWJIqilZlyET5v5zXWNz
         jF6tSwf4tUS9E5qhRV3WAxNAnSKsZd/XRIfBumNCPzP8SK7OoAzkh1sG7OMC61+tADEg
         zgZ5fHYHZQ0pT92/KLT7FA/JrdhT5XwtuwEUxW7yf7S6W7PxL5BNTxMoc953/fhHZcbo
         EJTn1EZK7zJjIQNfR71AQOZ5CeVJJhAOSPSeVPcHyDOOjkIlyu7Je1wpVpG8gh6KufnF
         D+8A==
X-Forwarded-Encrypted: i=1; AJvYcCVJZ0hnzHUdvIAKxNKGExvePzMfG/+3FFCgkdiHxhJalcDOP54hPLcjS27Qy2Kv5pTmxjrnz2+J@vger.kernel.org, AJvYcCXtIC4ihvISCDZO4aKGT24cLmYWlSOMo/g3aBOo2J1Vzv65b3ijz+3rJSskz9ZVNtnLCqzRUBnaNLs1ES4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPK5FHHPGBfbl+TuUB8iHNbZCgCgWvWyDasjmbWYB0hVEAnHgq
	ztTQT3f0CXYHnTVBhx+nXCgW/itzzIr3UvAihuXxC1ZaCWoy2/D04Lhy
X-Gm-Gg: ASbGncuwIK41eXozZurOemvDqPvNn797Pn5wj7kE1jh+BeeGIufGshztke7xQQ4LwOG
	5NX4HkhGrJZDPzoR+7W3ewSwpj0JyQUPzoqXV+/2y9mCtdFt3i4enEIrkL5EChPrj0hjG/1Ocw1
	XN3CoPBElwQY95fzmdeX7aQXJ+JnkZs1RH8dA1cjoaRPNuIM6ftKwi04T+ql5c9nQ+HBU+ceBHl
	LiINbhoyA8ZhwCkjyUJSIqowwRtjvmqPu6Ym/cRFriWrynoiCrpsjS56Kgj9EZ982OVE9AkS4Ss
	2/GGa/JAIWdcwrkD3DQ9CbM2bcv+QCQ+I5SCsehIAf62nV1QXkJqAPMS+KwZQmENuYvfwK/SARj
	R17kcUkkF9uXDQ1RGcg==
X-Google-Smtp-Source: AGHT+IFrSrxMMJNXhy4I6nDgKxzf2q+J9ki4um8/p2fAqdLKruaJOFqYiuZujRclanonBZPwLTRzeA==
X-Received: by 2002:a05:690c:3587:b0:70d:f338:8333 with SMTP id 00721157ae682-717b19847b1mr11911327b3.22.1752022201951;
        Tue, 08 Jul 2025 17:50:01 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665b40d99sm23563877b3.112.2025.07.08.17.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 17:50:01 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	Bijan Tabatabai <bijantabatab@micron.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: Commit damos->target_nid
Date: Tue,  8 Jul 2025 19:47:29 -0500
Message-ID: <20250709004729.17252-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

When committing new scheme parameters from the sysfs, the target_nid
field of the damos struct would not be copied. This would result in the
target_nid field to retain its original value, despite being updated in
the sysfs interface.

This patch fixes this issue by copying target_nid in damos_commit().

Cc: stable@vger.kernel.org
Fixes: 83dc7bbaecae ("mm/damon/sysfs: use damon_commit_ctx()")
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5357a18066b0..ab28ab5d08f6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -978,6 +978,7 @@ static int damos_commit(struct damos *dst, struct damos *src)
 		return err;
 
 	dst->wmarks = src->wmarks;
+	dst->target_nid = src->target_nid;
 
 	err = damos_commit_filters(dst, src);
 	return err;
-- 
2.43.0


