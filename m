Return-Path: <stable+bounces-176593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C3B39AA4
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F17716EB46
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2491C30C61B;
	Thu, 28 Aug 2025 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1LKAPb9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521A266581;
	Thu, 28 Aug 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378261; cv=none; b=VFeDbPOpg3fB4y7o+XWGgCjhFSmDJpSsZ6hGXk3ItZ0PR1+w2sc1GQ6kpK2eHlD9v0g6+jHODiCh9yPiqlbwFLfuya+RZ+ujOXoCRzddYjpyOcJ4fxAo9q1kInYLZVW80i9RvhtgtPKPwmYTT3DgjESrpU4hmzfwrQCl3bQ2Dig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378261; c=relaxed/simple;
	bh=UdSOjZUXhhlOMFn1U/XcQFWXcHL7oFM7Rsx0Cl5z8n4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MEXRmxfiU9NFWyLs+vqwdmHvL4/ef5iz5xmqQuBxG1fxwZEB1yCE/H2OGlqiBjRJLJOjgzQE6PkFnQT03dO0ApX4bzGDbdMPWMSONXOn2u0O48QNgvNOfeDXX5l/+uyr+dhP7LCZViyhuxvCheyP1C3vY/JThXHztlDbj3HJMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1LKAPb9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e202e0so726132a91.2;
        Thu, 28 Aug 2025 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756378260; x=1756983060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6haENDeLWLazBhNRGKTGR+4XLRcUjQzDkBqnhzx0iY=;
        b=b1LKAPb9uSDuwm1eiC7Ct7TWvR5zTKVlvn5SpEZONCfvDQhC0Pg4Ix91mZpcYyfkLl
         IscYSHnP2+knqf8ovCZ9h7IfaxP9h3CDBvbN05eb230J7O+L4NjMtyTYjGmqMo6L6iDC
         vOqWDcdUykNKKLaKGaQpnoiyJVUByhnLZGUG4GgT4doDvixTZcn3TqbGzhfoL8i8SmLE
         A1YFZqsa3rpFYB59AD2N3BwFUE5ZfKDFv9AvWcD3ZateYn8wJiZxj7bI4EZJdf03p8So
         HWKCDkWnYwOvd7FqDEhbu8XfSd3WEV8Qpos+E2zWr9Zmbs/ItzWKcrVp/Njj0w1BqWsO
         Ap/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378260; x=1756983060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6haENDeLWLazBhNRGKTGR+4XLRcUjQzDkBqnhzx0iY=;
        b=BM0uwikEPt+ZKJJBKU5GnpOJYx43bxOlHfbMljtROW+zn+P8HmyW24dITMXqzXJcX7
         LpzFKTZtPXmA3UUMjJsX53NLdfFGDJSZEvpDovw1B27TRAF8lWDDOKjdgJFGnhvnkhGT
         krh4b6ldJLqM/PBjlh1qvsKnuINRpEwylQYogTa2lFT5+30kawT4bYVrRD9b9yL42EHe
         pM6dphov2oW9fYT1xQPOxVMGqp7j6f4muK6KqAze/QG+DjCiyHjCS/cs9EklVkg+DrLY
         uFPUQuCidXZIvjFKswfWLLVyVPVs87UTJQkiWyTs+HPcfkM+VmK/FqA0Sv+McrFy/u4f
         grGw==
X-Forwarded-Encrypted: i=1; AJvYcCUYHb1XOdKtnKbu/BGzqe/vbKrbWDbyw2wBOm2Rugwvcyxm9r6w0YxOLljBvL+2YOdQ+hkJKRzHtkEm8t8=@vger.kernel.org, AJvYcCWBJ+SPkfb3Pe3EGraV8ivYEtedJGxv+hPjBl8f2D06oulVrdXd3mJWzM4nlzzWrj+oZSrKYINX@vger.kernel.org, AJvYcCWQqsEA/uFJqoM8T+PPjzkeL/hyE46IT7vsiWApLRexmJwBSyH0eMLtC0NdJ90k2mRbv6pK3QXY0+XXbyN/QJ+v9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfn+AbbdKiU9r/I7X0ziitTMYjoCn1uQD3lIBYRlW3+GIHi+7R
	l4j402rGtXZqkiNYk4rQQ7juyNwos3+D1/gy/2FDL8uyk0X+DffWrkZt
X-Gm-Gg: ASbGncu3CS021i9JAUx+Fa/ne3biNHEyah+I8bYVX6cYjLHirWgX+MP8HnqsEC8XjbT
	WHM7VGnIxGSoXNoFxe690pKqWVypDoTwnppiVRe1jBPaIuGf77vA6qZatF8sj0Btq7BQUExigU2
	sLiHGdUy+8PVmSmXa8c4QwSS3jZftgPOwRmbv6hGbrhUZpl2qqONz9sQx/fCrqSyXgH5luN/i1W
	Ykx4xXW2iVpF/6jt8PnDEM6c4Pg4HsaaAS4WGZdPzxtCRtfILaNz92rHdIGneJ9wt5B95oHKTEH
	+YAWCs+tx2iFrcQ4oA9TGUprZs/zhBg0odkmJH/YfT6wdlwiS0h8GdwaVF3IUCYxo2VgqAhoVXb
	738i8TqlbRaZPzEE4t7uUUM92Qn9WG5EhhOgFmjT0znre2wmGhHfg06B9gpOMuCcL5TjucW5u48
	Haoa/wg99ZMd4=
X-Google-Smtp-Source: AGHT+IFAkdvyBfr+8T6WxOlv9hNUG0+xm+ad2NnPu+INkow/PHPDQj1xrnPh5d/zvMidZUBirt8blg==
X-Received: by 2002:a17:90b:3d89:b0:31e:f397:b5b4 with SMTP id 98e67ed59e1d1-3251744bd7amr27729748a91.22.1756378259805;
        Thu, 28 Aug 2025 03:50:59 -0700 (PDT)
Received: from localhost.localdomain ([112.97.61.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3276f592587sm4843177a91.9.2025.08.28.03.50.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 03:50:59 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] perf lzma: Fix return value in lzma_is_compressed()
Date: Thu, 28 Aug 2025 18:50:47 +0800
Message-Id: <20250828105048.55247-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lzma_is_compressed() returns -1 on error but is declared as bool.
And -1 gets converted to true, which could be misleading.
Return false instead to match the declared type.

Fixes: 4b57fd44b61b ("perf tools: Add lzma_is_compressed function")
Cc: <stable@vger.kernel.org>
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/perf/util/lzma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index bbcd2ffcf4bd..c355757ed391 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -120,7 +120,7 @@ bool lzma_is_compressed(const char *input)
 	ssize_t rc;
 
 	if (fd < 0)
-		return -1;
+		return false;
 
 	rc = read(fd, buf, sizeof(buf));
 	close(fd);
-- 
2.39.5 (Apple Git-154)


