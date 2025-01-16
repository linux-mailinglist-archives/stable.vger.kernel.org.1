Return-Path: <stable+bounces-109244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E94A13891
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE17161013
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4F91DE2C1;
	Thu, 16 Jan 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjBGHlXJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A471DC1A7;
	Thu, 16 Jan 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025738; cv=none; b=dKQ4NiFyu6zJVrAipWyC+6TEVJ4znE85fmPL4soUHWTzzT2uBu9yR/gIBeItGW3fqHpsvJTXwJGJsn4BMFE2qpC5/QiMQGISfW4gjdNoAG8x1PzQ7sy/AAcO7NFMMa0UDLso3ikBgZfta+D/4k1gqxOY1iTxwX2KC7EZa9onNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025738; c=relaxed/simple;
	bh=RbrQ5xpOl+Cm3oPZXk0S+RBe+pp4JWY1Lf4Xx0Q20K8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pk2gMXI2GodJaqAVZRbR7njQg3uX0Z6eNuPlnzYeQey8U2gclxJrQrvclibn/vhEfnfr5EZzKsuWcslRkE9zsGZu0FxYA1Etp2jtXixZsetoGmQLNVNZ891EVoa3W1GbQbtQVwauT9Ix4sQKp+zCXwu39aN6ke7uSMrpQmXWlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjBGHlXJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21628b3fe7dso12783285ad.3;
        Thu, 16 Jan 2025 03:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737025736; x=1737630536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HVob6HRTL2nDYxizp1KhGNSTIQaQOBFoaq+iR2x2d5I=;
        b=DjBGHlXJ6H/z9ZPvve/vWxAK8wgDEtfM0f291n0jvpb8tpvkX+5Sw6mq4yUerAHlRi
         zmno5v+9S77B6RY5WcvmsJFVPbD9K3TTCDXqnKDQuUftbtvdMqk6uutfvKIAWSx2Jb6G
         IekIreeBLUPJm3Yp/fBXgmw+rNYgoeDmJHPOvfE0cZjCc2xRapiZe0tKsZsd4ZpW4kqY
         5UEYIUv0MBwXry9EOMRZ59kFkneIxa3awh2MXG+/tgIbqpKri3IfZleVkdmiTRQNTsRl
         2x7sc6gl7Z8lM8yPgJnt5QA5c9E5CyJHx/OaeoN2YpOput0ut5hZEU3QACPA082oBsPD
         2gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737025736; x=1737630536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVob6HRTL2nDYxizp1KhGNSTIQaQOBFoaq+iR2x2d5I=;
        b=HmyzZcloSaj9A1h4v1/HZsw7HvmbznkA/1YTeVBR2x8K0gko0KMeBl47Ph2h5/CPak
         5faEKAzryw4yEDhBGu6TITZ+zGRhdGKYJ4IE5jL280xmfWgZmnT2faQQ+pEUFRVnZV/6
         N+wUaUA4NpayN6wqQxuF4Igx9uWPvMnED59+n6DcxK4UN21pgMKqu8FCz72rCV3DiAZ0
         u8MnFuwYR/xTF1Et5xOgDxSebMnBN30lqkUfl84OIe8sdVEboqBfX58YaEJune9UQF2g
         S0G9QPevKi5tDHRWa2vlzNZbD8r+6LFEN9ftdD0bKfkJh9UG9mVPrDHga02hitJOx9JX
         gKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoDL/nrIRwBUGvaCllcfJ/Xk3GHt/vNSUmBg2aAO+UZgVa/q7nR6SDEeT0/Gl2ysjH2of8UDzWRgmBCoM=@vger.kernel.org, AJvYcCWXGZk4QW48dQYfgWu8t+XGiaHffg2XaQJ7YxClUCCFCZWP/yKziWBUXdjxS38/sdIFBBhjy/1t@vger.kernel.org, AJvYcCXLEqdMoPnCBHcws2xpQMCCD4L/xmUgmL+Pig+lSHyF4o9E17J++sNvrbzizqqiRVLUI8OsJVAXBZOJ+JOAp3p5UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+Y4rq+FQn/icNobZHmv64VUJkBEiX04+5XFLxYbsXajPqVJE
	Sf0hVaso0t7CUBHl2uH1tVjpWHwaMMIjrP5q+W2vsZetrvuRKcQH
X-Gm-Gg: ASbGnctuH9C/j8VJ4ejeW+TyI18xqgF5s4zrZHIr5mKiW5eiC2uMzJ4nAnAXvmUqSB0
	fHC7EyP8zf2SSD7jJbCIcD/0+CM6OAvqXs/6zmKQV8mslj1BhfvuVIJUS1FWCpja+6l/FEMO8dZ
	4XMFza81xYxhS5YE8sbhjS2FkIpfOySbUd/QC1kq6eeipYx+RY51SZQS53oIZ8cFwhn8WYlHJkO
	Q28Dyc1TkU9Q859MwlAvd9+VyU6pkxWs77DmtlpFf7VsXfXDxNdnC2uzgSas14FuAri4nYiAOfP
	Jel4J58lMuU=
X-Google-Smtp-Source: AGHT+IFTjeVq7Kmmuih3Jimx5Xcu7Np5d0JWWOoJOMtDxN3UjM/5dEeVF8QPS9luq3k29xMs/ovvVQ==
X-Received: by 2002:a05:6a00:1489:b0:728:eb32:356c with SMTP id d2e1a72fcca58-72d21f459dbmr43140418b3a.11.1737025736106;
        Thu, 16 Jan 2025 03:08:56 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e682sm10679087b3a.125.2025.01.16.03.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 03:08:55 -0800 (PST)
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
	James Clark <james.clark@linaro.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] perf bench: Fix undefined behavior in cmpworker()
Date: Thu, 16 Jan 2025 19:08:42 +0800
Message-Id: <20250116110842.4087530-1-visitorckw@gmail.com>
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
Changes in v3:
- Perform a full comparison for clarity, as suggested by James.

 tools/perf/bench/epoll-wait.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index ef5c4257844d..20fe4f72b4af 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -420,7 +420,12 @@ static int cmpworker(const void *p1, const void *p2)
 
 	struct worker *w1 = (struct worker *) p1;
 	struct worker *w2 = (struct worker *) p2;
-	return w1->tid > w2->tid;
+
+	if (w1->tid > w2->tid)
+		return 1;
+	if (w1->tid < w2->tid)
+		return -1;
+	return 0;
 }
 
 int bench_epoll_wait(int argc, const char **argv)
-- 
2.34.1


