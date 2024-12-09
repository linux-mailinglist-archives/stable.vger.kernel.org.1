Return-Path: <stable+bounces-100182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBC49E9764
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFA52824E7
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DBF233156;
	Mon,  9 Dec 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMAbmhaM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B86233137;
	Mon,  9 Dec 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751757; cv=none; b=ttWb18ezTqbcc4jY+aH04vHXL3zQpJjqalSijiRtYidR6AURBJ52VIilkSaGcdiMaS5oEu0q2t03PU+C2ULzBa/KpjmkDHnHbbdb9pPyQukVffn6JVhm5ncAsH0kFaGPxMs+5SaCtyEIuI5VbNFzGk8CuqGW27Ig2gZ/LohKgyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751757; c=relaxed/simple;
	bh=03QJGK4Z1yvJAl/3TNKhw/EVpYlKKfAUlrw6poXpiK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D9sexwR8Zzy+WhBkbGdofs/YsNd/K52LoANcH9g+DBnJsE5gz9YomhL0g5h7pWYL8T2gOYgJ7XGJsXzrzTOT6VRgEQXH4r5JrO5YdL9angL/RoSM6NVVFFcH1uuTzHFW2xIxzFDoMncPDOGftWsmCHIkgFNkF5LtVqrv2ciKvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMAbmhaM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21628b3fe7dso19938835ad.3;
        Mon, 09 Dec 2024 05:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733751755; x=1734356555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRJ9EgO00gvd/eE2hkZ5c1MkBkZAMOXjJaY80cKYo5E=;
        b=IMAbmhaMOIOPf6Agi//IkKX5zL8GcA/jv54I43kQdo28d0qpX1j/bhGY8u0sN8/x+7
         ahl91+i+UI24z2HYFDR9nRfvnwoFnk3zYflS3bur7RIni8Hdo8rBdhdOCZvMEmxlQV5j
         OEAos0pGWaCCGSd7+iDRelQYgWfp9UrAzLpzMdWOm0ICb/xqiCrcbNQ4ccArVqDX91q9
         yBtIuRM3Rp72+O+7YsgpuRalvTJQ65lG/k18/rg7bksbqpGceWUx/BKWMHYmFn6SYY3M
         f9tZj5VkzSo6ZbCcc3IaJyqCYsj1ks3YVBKWmDVNbfG/tXD+LCkCyhofCJtgT1mZqqKR
         UjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751755; x=1734356555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRJ9EgO00gvd/eE2hkZ5c1MkBkZAMOXjJaY80cKYo5E=;
        b=s+euU89S5kVk/O0VlPZ96w6FNsCxY4ZULd7TsdNJyqrHHmxuH9Bzte87iDhIXqdZND
         awA5J9RRgH6XMZqcVECPEbLarJ+afXZdmcL3ClW659rCh3moveZSX5Kg2DXmVoJNXyNX
         DQbMUI09JJ9SG24PKZpaDfFem09jTaxNRw86FSvM3uOWalnG/hr6EoNbycP4FfywS22q
         koVEncXNsvIpZbHneoPXha/eup3+W2uP/vES5MgLhuwrTlqB4obzJYIiGoBqoVFZsJ84
         dlVJ4c32FGFyUSVhVwYRThgLz1O0UyxmLnc0ZS4BPR70YNhWIo3xXEwGVzRdGJzmNU0J
         WlRw==
X-Forwarded-Encrypted: i=1; AJvYcCUBzDmGijje276a691+RYILEa5MciQAAd0GIO3fwqp3kSOC3Zz4ELw93CLcFA5JnulkiYO7cHzQzh/E4eaOhEa57Q==@vger.kernel.org, AJvYcCVDGzO/TgDP/gXjgRdNbdBRXL6VLEwQwQ8EbbtpTmk9ONIls/DX5R0asUnbFGuITpsN8odJs8WHTmaIsXQ=@vger.kernel.org, AJvYcCVqN/SD+AcRnRigRJ85KzXvJpPaKnq0OWVA6h/5w+5kDFjVblnaho5b/ZtzHCOwLtyHWxVzf//y@vger.kernel.org
X-Gm-Message-State: AOJu0YxEMqM5zKzoJslUyTHpwTc0Un6w8Ud1f5eTEVh0s0lIUO7d83k3
	A15su7tuo0cUN/EOGG4/XLrCT2sDBgOAsgJ5bUlyKntF+m+Ql0kh
X-Gm-Gg: ASbGncuaY0h62XLoab5L0QcP8lCVXAoWQwswozXsDabNePBQ/XMLYYoiZ+YSxE4Wp0W
	5Y5Nh7YDCXtSQVU9Y82xWsQqW5+Rwe0Vs0fPftT0kTfXtQzj04tDuvQDWZDgFwu/j3hEd1ycNqH
	3PsAEtb8XNLx8VheLsSytRqjz0I1JwOQaM1+zd3cFnGnzoA04ukEKcGfyax6e7uGW/zSw0k0Jvt
	7xLmv0Gsz5GHC+52NMY4vH6Pd6qxR4vB3LAvxlfIq/si6Xg+/ys48rkq8PpB0aDr9nmcCYWLJQV
	Mo9O
X-Google-Smtp-Source: AGHT+IHizzILtGkGZld4afmwIQGr0ZCEhjHEDFw/DW/9vITEgpcIGs3KbA21Eq13Yw77XhMITKs3Hw==
X-Received: by 2002:a17:902:e807:b0:215:6995:1ef3 with SMTP id d9443c01a7336-21614d1d441mr153586085ad.3.1733751754538;
        Mon, 09 Dec 2024 05:42:34 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21644dcf724sm23863525ad.257.2024.12.09.05.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:42:33 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	kan.liang@linux.intel.com,
	adrian.hunter@intel.com,
	jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf ftrace: Fix undefined behavior in cmp_profile_data()
Date: Mon,  9 Dec 2024 21:42:26 +0800
Message-Id: <20241209134226.1939163-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparison function cmp_profile_data() violates the C standard's
requirements for qsort() comparison functions, which mandate symmetry
and transitivity:

* Symmetry: If x < y, then y > x.
* Transitivity: If x < y and y < z, then x < z.

When v1 and v2 are equal, the function incorrectly returns 1, breaking
symmetry and transitivity. This causes undefined behavior, which can
lead to memory corruption in certain versions of glibc [1].

Fix the issue by returning 0 when v1 and v2 are equal, ensuring
compliance with the C standard and preventing undefined behavior.

Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
Fixes: 0f223813edd0 ("perf ftrace: Add 'profile' command")
Fixes: 74ae366c37b7 ("perf ftrace profile: Add -s/--sort option")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/perf/builtin-ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 272d3c70810e..a56cf8b0a7d4 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1151,8 +1151,9 @@ static int cmp_profile_data(const void *a, const void *b)
 
 	if (v1 > v2)
 		return -1;
-	else
+	if (v1 < v2)
 		return 1;
+	return 0;
 }
 
 static void print_profile_result(struct perf_ftrace *ftrace)
-- 
2.34.1


