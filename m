Return-Path: <stable+bounces-180727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A1B8C918
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E1E1BC46ED
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B221ABB9;
	Sat, 20 Sep 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlm+3YlK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D37211290
	for <stable@vger.kernel.org>; Sat, 20 Sep 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374918; cv=none; b=fbY1IG3sDRO8a9cQxnGusA45gMAcoTdmvQVQpKfXg7FLAhNiRLAShKGy8ldBlfxc7r/SiWmcj7IIAROIFJz6HLigubuYvPBktgRTqljf50tFRBrQGfCzkxhy12GIICq/GZuJkiTW3EbSw6Hk9WYZcZGVH/bL3ZzcaAcD4vbaLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374918; c=relaxed/simple;
	bh=c4T5h8Lj+r5QHOJrfTGmZa4X38Mi6teWvFjOqLPEbvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GxoDPpl+/pviNWuo7F+/u5gCgPn75hyinxnUnk3Lo9s8ZwpqgiC4PywVCD6MTfpjknazrtG47ZCBI2phtWpqiUZrSwPJ2fBxQiuq0ML5ltPv0Bh5L7r5Bo4v6K19nOFoxxUBpBkg5shYeSQ3GvPa7obNyb+6DvXy/81wB53s7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlm+3YlK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7761b83fd01so2884100b3a.3
        for <stable@vger.kernel.org>; Sat, 20 Sep 2025 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758374916; x=1758979716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjxouBjT5nmqga++V9b1ze7RKvPFTL21IXfIsCNqNqg=;
        b=jlm+3YlKXzZAHMJRaLkxMD8QwnSOCFBFG1zJi2bJFgaz8PisbC0t7OgSHe4PPfKuIX
         k7s62Kk4X+EZS1KkIMDziHTKnDMxEgX7OgwX4ar21z/8NN/Bi5qdALcpqAEPEcM6NMc+
         Ct+09mocTJYuYPiak5DPbILjXrs1H2hOvJ9zKojLrSbt4/QwCSkPy7dj7vM7zvth3S7D
         v1c6ETMvE6C/BSNV1o/hgT/nPPHHLGjbkP2sEYlySXPJs9mE4kM27nM2jetTtErIOUrg
         9CX9IVjGTTf3paWavSeUKvrgQeC7o085GZKn/C25E8p9MUWg7oUvG4Dw1Mv4+VF9Kwna
         +Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758374916; x=1758979716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjxouBjT5nmqga++V9b1ze7RKvPFTL21IXfIsCNqNqg=;
        b=Kp8I+9YvHHfm2swMsDaXeUB3LseGc4mYCl9qzTmjDjaN7U1c1RV8w+/fpJGna0hHQR
         aTr7RM9oaf8wFBIztr+84x+9z6tSsbauJ+LCEUz8k8l7PUM6INli1npLSMMxE+PUBP8j
         FFH+B+Fl0fIHYuORJ9MwgHWd65fRIPIdmQX+Nxwvatv/mBCp9ofFLfigKMnZ/b21SlVz
         W13CzRoWsa7rwYQVi//pIJHVhWXB9Dhka5fj2EtPsejmaByRYR5kDzjWYenaBB4ZDOsP
         rCkQe2cZsXCjJsAui09nx/zeUdtSunnADJDpi3bvUrsLNM4pAfTYA0tZc5t2m+uozfcr
         XH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWy0naJFQj7lX8uXp1dY9/DDulQ5m9jKUYCXglu7oYk94L8r2iG3egcfORvl0sUmMCeIh+CDxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUW0QWeVD7CGJL241Vevqp8/oY/9qFg4+ujAJWbEfTR+UZKHyK
	YWhS1XoM3qRdanu7Bgwin2BLgmlG+a83LuTq1oD+YAKVk8rK5ivV1zqi
X-Gm-Gg: ASbGncuYayOl/o3s8kWm4gTh9Z7D7GlXXBMxiR6d6bMxLdwKkdE6ZT19jOw7QWrupUb
	xG8A1TfVo4Kqt2gig/9h7r3N73jXa/clGcx9KplvH2xRR04wPHlGEmKrfV62gx7BlDIq5tVm2hU
	aXW+n7JZzLU9FyEm52DVTBzGGt4bH+5biBgLtnsGixvN2sJO9rqc1d7aa3M+79EnbPbBbY6n4cL
	Bk8aiXvzxwEK/yAMUc/eLWRxJobrXCvQACK0zlFQ0bMIwiNDtCHuUaoUAJ0293p6HzlX9vPnu0s
	zIV33v7fZLkXmAtQDl1CGMXiL7bz9xEWWRVfe9Nyi7QCTWSfXPFJvGjiDBGgq78JtE4a+8+isN7
	G6n1NOCui7gyro//5fc54DWW8FeOAhX0Yx6R33A==
X-Google-Smtp-Source: AGHT+IE3IUDImelMA1Pd199Dh7tuKfUZyU+6ZHuOXZm1pmSy0cEqS2FhGPr3AAovcBFC3q8C0kUEuw==
X-Received: by 2002:a05:6a00:3c91:b0:776:1f45:9044 with SMTP id d2e1a72fcca58-77e49f0742fmr7991411b3a.0.1758374915693;
        Sat, 20 Sep 2025 06:28:35 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:881f:6424:2c16:746a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe669a58sm8077093b3a.52.2025.09.20.06.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 06:28:35 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: akpm@linux-foundation.org,
	sj@kernel.org,
	akinobu.mita@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/sysfs: do not ignore callback's return value in damon_sysfs_damon_call()
Date: Sat, 20 Sep 2025 22:25:46 +0900
Message-ID: <20250920132546.5822-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callback return value is ignored in damon_sysfs_damon_call(), which
means that it is not possible to detect invalid user input when writing
commands such as 'commit' to /sys/kernel/mm/damon/admin/kdamonds/<K>/state.
Fix it.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Fixes: f64539dcdb87 ("mm/damon/sysfs: use damon_call() for update_schemes_stats")
Cc: <stable@vger.kernel.org> # v6.14.x
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index fe4e73d0ebbb..3ffe3a77b5db 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1627,12 +1627,14 @@ static int damon_sysfs_damon_call(int (*fn)(void *data),
 		struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_call_control call_control = {};
+	int err;
 
 	if (!kdamond->damon_ctx)
 		return -EINVAL;
 	call_control.fn = fn;
 	call_control.data = kdamond;
-	return damon_call(kdamond->damon_ctx, &call_control);
+	err = damon_call(kdamond->damon_ctx, &call_control);
+	return err ? err : call_control.return_code;
 }
 
 struct damon_sysfs_schemes_walk_data {
-- 
2.43.0


