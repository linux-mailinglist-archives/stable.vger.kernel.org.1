Return-Path: <stable+bounces-192344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 418CBC3046B
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 10:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68A6B4F7642
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 09:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8911C23B61B;
	Tue,  4 Nov 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="b9RhNZVm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2F23EA81
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248545; cv=none; b=FU05QwDoHMHfYzpBjvlmP7xntz7hMo+BZKUA1euXgf9lomPc1yArJrMKpqwBHqy7/bQuG9hln4MfeKIJUb/PWP/8uli/V+KuZmGmwXS/3tEr1oqvUj/JLI54MIPHWNyAJ7VdmAEgfZ2/ea3TBUgEOEA/raNZ8wci7cwjeM8ZqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248545; c=relaxed/simple;
	bh=9NZz8+0HjGiYkq9QMHNT4BbNht0YbASLljRV/7ufeE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rx6k2eNtu9EtTNUR4cx9W0u32gCdfumE9basEXdjrgdYpVbK8HrpiB9IggGSfGH/wrLrZQhmCxsmn0Axa3ik0nk107JPOIAdtxvEiyWqkfGtMQmZ/Z4hqGikEZ+H4iJolA7rTtAyomKDY/kVopMH2rT2pGd8Czp4XZ2Gpa9vtaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=b9RhNZVm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295247a814bso54768025ad.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 01:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762248543; x=1762853343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hk3PYE38Zzgv3m8VQl8wYmuHsU1MqZfGLEy/1nq+zs=;
        b=b9RhNZVmpTFrA5vL/Nmr3PaZ2aHcswxQaeLJqxgNmGUmuJaspv/fofl9LSjBKASwlx
         DOuzg7pVy6R+VT8QfWn5s/KlaGoTD5zI0D4K1YO1oB48xT4JVP3CXIYwM03n2pPff+Ap
         781IeBnfJJ2hB8YVXrB7jKZX1snSVKLHrjbZP0RBED5gnBygBENQWCMCVas68ZNPZtxj
         Wa0sm3vPr5pb+UHlggw8k75h2f7jfqgKx5/AOXj3XUu0gk8xhqHutsSC/9ihNwhjYnE2
         mxsMxveRZX1Lvp4zUTSrbgbJJLk6JFO7b5e6/W26gsVZUuESlGt4cnmXYubdkSuGgszh
         wIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248543; x=1762853343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hk3PYE38Zzgv3m8VQl8wYmuHsU1MqZfGLEy/1nq+zs=;
        b=hbRFnHvuqcoe0vRv95t9j0NYCZvQhpMoyqp0ESag5Y+CJkgE4j1Qiavl3+n/IBEknY
         LSuCi1DYy2r9FmNf7NuqCDkr8jx5xw+5hYFWSzNNN30JLHwoPvi5FO6B8offnDC302OQ
         WfoKMVUJsphiy0LghQe8Y8mlhocTb3DJZhj6z32XYkmoHTKdULhMAwEzcc12a/jG8pt+
         YOU2HZZxQi8pFI/YrXVi1WxwfN+9RAof+N0MC0Y7Gpi3XPtsQ5Ki8YMyYQs7MvySZIs6
         i4/4iFHHIHjB9rLHnhS6sQeVXM7iGPrBwaq+BqIg1dNKwSoQDGbKpdfnLszHpcK+C9Ci
         0O/w==
X-Gm-Message-State: AOJu0YysNmiESSD9drNzeUmASE3f1i6bCWtQEVJzUvYL4hX+xLrjz6mS
	0Nf4FyjFKTkVPREsv+nG6RFobflXpW2oeNEpNrO+vQRAp+JROn3vKl/ky/qxpP1UYpchZnjqpjZ
	bzTtZNgZtS5Qr7N6LNB7Ht51p0PMZHMlq/oNFmUolp2K4sx/ZbDvtucA2bpre7FDSAqAJQTVIVu
	aMX8iWWHBW39UXyw1w64y9Xox3A66dW26+TW7nH3bXlrM9J8tHrw==
X-Gm-Gg: ASbGncuRs8ywrhP+coH0I6lF1uDj8UDr93wIk9UTcIzaXMLrsxObyAXKye4d9GWs4Q1
	8fWDWrOWYW0SnMX84n82fTPXHtLrUWDPCLAl5j23I4NB/lVGBT7GEiUo0j1Q4iKbSsre3ivmgfn
	9n6S6d7rWp3mGFXV5Zhltr2XOFCqIR8+YYsset9e76q0X0hCpLJCjqx3etSbBGgk1fTZdfKJzhw
	pB0wBqC04Ym2ViFT9g/k+XgZVecqfnj/LNZnausGep1bg46sTLoIBatT0zZ6d8tUmXLYP6YX5lL
	Q+kIYPHkCasnPWuRknpE+1kyECiFcpgb4nMX/yEeFhk1uW8OLuFc3JosnC7bOZiDrRuhiPJ7rJg
	4Gms/6tAi+i7DsKPRl3Q+VP6DNUPT97y2G2G0mkMsnu5oy40iqdT5b/wmqmspSVZjN0tTlvSNaq
	/j08C3CA42+D+G8r8=
X-Google-Smtp-Source: AGHT+IG7RTH3tWAxCPZkbkFtzG+dpb0z6mVERYHnwx86lq/fCclFo6zqdFexGNibOW+avSxjFq5S2Q==
X-Received: by 2002:a17:902:e749:b0:295:7f1d:b034 with SMTP id d9443c01a7336-2957f1db313mr114052945ad.4.1762248542808;
        Tue, 04 Nov 2025 01:29:02 -0800 (PST)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b78f8sm3874700a91.20.2025.11.04.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:29:02 -0800 (PST)
From: "jingxian.li" <jingxian.li@shopee.com>
To: stable@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	adrian.hunter@intel.com,
	sashal@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "jingxian.li" <jingxian.li@shopee.com>
Subject: [PATCH 6.6.y] Revert "perf dso: Add missed dso__put to dso__load_kcore"
Date: Tue,  4 Nov 2025 17:27:42 +0800
Message-ID: <20251104092740.108928-3-jingxian.li@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit e5de9ea7796e79f3cd082624f788cc3442bff2a8.

The patch introduced `map__zput(new_node->map)` in the kcore load
path, causing a segmentation fault when running `perf c2c report`.

The issue arises because `maps__merge_in` directly modifies and
inserts the caller's `new_map`, causing it to be freed prematurely
while still referenced by kmaps.

Later branchs (6.12, 6.15, 6.16) are not affected because they use
a different merge approach with a lazily sorted array, which avoids
modifying the original `new_map`.

Fixes: e5de9ea7796e ("perf dso: Add missed dso__put to dso__load_kcore")

Signed-off-by: jingxian.li <jingxian.li@shopee.com>
---
 tools/perf/util/symbol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 4f0bbebcb6d6..ea24f21aafc3 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1366,7 +1366,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 				goto out_err;
 			}
 		}
-		map__zput(new_node->map);
 		free(new_node);
 	}
 
-- 
2.43.0


