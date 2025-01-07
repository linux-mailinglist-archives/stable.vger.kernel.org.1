Return-Path: <stable+bounces-107808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49953A038E9
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 08:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9097188652F
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 07:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6581DF964;
	Tue,  7 Jan 2025 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR4X1ExU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525D1DF74B;
	Tue,  7 Jan 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235559; cv=none; b=cZVhwUcRW76qmIv5DSid0HaFNng1JE01FLQmgznSP9jYZkPSo98L8zUimoCs6JzJmmR5VsklLlLXlt0e387FnMMwFwLwWcHJ6/fLQW/WxWo/EtGYhSu0gwXU1+AIFXTbVtk0FttuqekWLv2wHn9Vd/UXYvdl+IomW17UPo4btE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235559; c=relaxed/simple;
	bh=LU0WbVQz2CxbGW2N1O6kmuaX5dfkZ0N6PZp0D5MggIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dNkkfeU8xLi7pfJlgzwElJQairvQecJH3Vsf3jwyqxi7pquQmdxEB2VtN9Vh6DMltC7xYnHnc1j93o/iKgaWVMmMVSkQ/gFZskNvFeIPRwHqfPvlD4MrCo80/yVFxaRImZo6zUt5Rb2cZyH34u6ISsT/MctYeDvWUUfbbBaVDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR4X1ExU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2efded08c79so17509149a91.0;
        Mon, 06 Jan 2025 23:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736235556; x=1736840356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULQq5TWZfMw9s6DzRDdbgNJ1Nc4fQXG8u2j3H7zO1uA=;
        b=bR4X1ExUg8/H1KO/BRyf04nIjkUE7kzrOJQJ1fTmWq8EULhO9qx4lbgLjo5UAYVqln
         6yQA1xmPRf1YDtBUmHlOMzxlEyxxGZhHzxejyWUfq4mxqOl0oepwNGZTkwPlDOs4zJ7s
         nnhIRU68/Vz4YQbHl0keN0lii0T1hcQC9H5aJwmbCI/gRw0k6Ft/BoxXIHm6bnK7PGi5
         RkPLDEfc7SSrwGbJ8aI0wUHoT3dI8dhs7BzmkI7NJfyAtLDVyC1LUgRffk6cKOnJWTLr
         MJZlfoajL2hkJBARDHtLwv7Q9lNNMgsbzN5UcDvy3Y9Wn5qR7eyYuo7XCQwcLoHgmX5C
         UaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736235556; x=1736840356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULQq5TWZfMw9s6DzRDdbgNJ1Nc4fQXG8u2j3H7zO1uA=;
        b=haEBxWw+mdBTObNo25/lV9dsjewIVBQ0z8qKTxTucbWVAJwIyy3rcNwQCtZQKRJUU5
         ULA6zukbeJ120LmlVWlpLxuk94XuEB4M7GoYMjpbbdp+y/hf/JJAkO2FOWw7PCM1+ROg
         yU23stsP/grB9lWQ/5aGiNOlZzOMuEAE8R6vgxT5SyLoo+NNX/p4OoTLBxiA8V8pyvuT
         tenYdr10tluJhYo4Ycf6ZTP7Ls2Tlb51VmQJAWtCjsd99Wb25TWYdZH2+F2NVn4T2a5B
         MOrLNI295gEek7WqCTPTHCmVrySH45/cr74xiFMtl1zI/ZrXl2GmTmD/q5oea3QQHEhA
         CvWA==
X-Forwarded-Encrypted: i=1; AJvYcCVGgwSMwyE4zV3Pm+r6O9t+uNktfmuqpYZCEm6+a5oASP2lHp8iwOwJoL6RkawpVHLHEwnXsyBUS8tS4lc2CDc/lQ==@vger.kernel.org, AJvYcCX0OGQMLxc0IqBMlfHSkNRQX6xUdJL4p/7BGaLLdKxmK/0H+LMrKhBQVhGZIlVFvOunD+e9Y7cYBuUr/s8=@vger.kernel.org, AJvYcCXvYyAhRDLY8GlXwgvN4Vt1FKLyccUeiiMeNk9xKczE5y7Bgk67Nn8Y0j2C0s2wbYboMfQg4JVo@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmWRRUluIsPqCHUEYsq7+bXst6HbO7gHt1sb7iepCNDgQ9Swu
	WQbOe7F5adxixxn6lh3kDJfI1tgLOm+d6ZhgN0/OrjciTsSlTfKY
X-Gm-Gg: ASbGncuB9+WbKZ6+rsCnv4RrEqvce5YOeZ9E1kmzA/Hkx+RjdvCnl327nP6pN7cUzwG
	dd1fUEUQrGNNtSfT4I2qzgrCng5lO1xTLKKUzAhulNuS5v8SpmuJ9OA0mLP3h1mghXqotEtqWcD
	ddMlsVSmXL7BIvkUD3sURup9zOzFJHC9qCXj9/cg3OxGD7OCGFfYy6fbJqL6KOxUU9h6k6uOAcD
	5jE2iN9RLTYmufFa6umjZ6tjVSWf/zGOoWhTQqaQkRdZeO2wiyq57BK+3ogfoR/sNsMF4zpFiDC
	TVPuRpP/FkQ=
X-Google-Smtp-Source: AGHT+IHRRlr/ytX/dJtmDLFtZebds7kTac0LXYNbmkv5WnAOVIgEot/OfejrsJVkZJbjXbpkJfdWSA==
X-Received: by 2002:a05:6a00:4ac5:b0:725:b12e:604c with SMTP id d2e1a72fcca58-72abdd3c467mr84333969b3a.4.1736235555927;
        Mon, 06 Jan 2025 23:39:15 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb851sm32782387b3a.132.2025.01.06.23.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 23:39:15 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chun-Ying Huang <chuang@cs.nycu.edu.tw>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] perf bench: Fix undefined behavior in cmpworker()
Date: Tue,  7 Jan 2025 15:39:06 +0800
Message-Id: <20250107073906.3323640-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparison function cmpworker() violates the C standard's
requirements for qsort() comparison functions, which mandate symmetry
and transitivity:

Symmetry: If x < y, then y > x.
Transitivity: If x < y and y < z, then x < z.

In its current implementation, cmpworker() incorrectly returns 0 when
w1->tid < w2->tid, which breaks both symmetry and transitivity. This
violation causes undefined behavior, potentially leading to issues such
as memory corruption in glibc [1].

Fix the issue by returning -1 when w1->tid < w2->tid, ensuring
compliance with the C standard and preventing undefined behavior.

Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
Fixes: 121dd9ea0116 ("perf bench: Add epoll parallel epoll_wait benchmark")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Rewrite commit message

 tools/perf/bench/epoll-wait.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index ef5c4257844d..4868d610e9bf 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -420,7 +420,7 @@ static int cmpworker(const void *p1, const void *p2)
 
 	struct worker *w1 = (struct worker *) p1;
 	struct worker *w2 = (struct worker *) p2;
-	return w1->tid > w2->tid;
+	return w1->tid > w2->tid ? 1 : -1;
 }
 
 int bench_epoll_wait(int argc, const char **argv)
-- 
2.34.1


