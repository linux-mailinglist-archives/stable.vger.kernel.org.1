Return-Path: <stable+bounces-194656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE9C5596B
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 04:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C91B14E605E
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 03:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8922BD5AD;
	Thu, 13 Nov 2025 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXXBwuHJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330C274B23
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763005589; cv=none; b=GP/zSXFqOwY28Q+fJ1oLQ9qM7w4v3kRS2BnYTggrEugDgfK4qQwXNWXTz2FIZNGOxfoPmr7OMvz49DtvYJqw0otV2UHog3EXNrL8eSyh58cik2tL+pfEng/zq5p4Ifyq7GgjC6c/OoFBtNGuxQwLF+sKLN7qhfTDMHSmTTOnd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763005589; c=relaxed/simple;
	bh=xNrBJ9JKhl94hsQQloq6sf3vO4Sqwb09Lpz3KK53sXM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=do/6rrqnX5xmZSaWudsvsqhIU5dM5Z2rqjT/je0Cn8CUaUniSfV/W3ByFAFeF/r3atX5IRPRGb0rNvAjEzo9UyxsWJIq/yPRtaiEw91I3RYydG/HkdNs401ApL4uamc+qZBwp69asuyzVFJQnIp8xb2OQdGu+Jb/EuCQN+HemiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXXBwuHJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2956a694b47so4412765ad.1
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 19:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763005587; x=1763610387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=adduDIgHwGkFi5eI+DMenkw4/FG0bTrtUTxhLb5vmxg=;
        b=zXXBwuHJQvupCyS6gAfCQ6Eu6c9yDAsqWzC4/R6QMYNCgBWRHBpk1rc4Mh90oQXtgW
         2iOYPPbyQU/ZcvKxQ0giCb66rAmc3Q9/I5b5WR0i613WYfH+v5YdKuwjNS81crKwxd4V
         2L/weWL6llZWReikJVHir7ng9ETSmRGm0nb8YnXp/Z3lppBIV2ofnVi9lBHH+nyqlOJr
         Ju4xnB7lgqdN+hZZiuqMs+RKkTZ/C+LQJSkl9u7eDzgYu+ZBi+/zdsjMFY0UERg6alUI
         0+0nu9wVRS382fzEC7h67pCZHeCbovtF+iyi7fZt5eEE14AXyBhfMlhmYbSBSAAbrbUe
         v5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763005587; x=1763610387;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adduDIgHwGkFi5eI+DMenkw4/FG0bTrtUTxhLb5vmxg=;
        b=j2zV+bmqIWH6inPx99zR7Ksy1Lz7FfYug770ZVavWKU4TCKm7I3XsnIc+HFuBEhllJ
         c05H6/WMAGhImzDfz9GG+Srwc5rVZH8SZoLGOmA8SPWa0Axzh8pKJTKt/C3HdtKvKlp6
         AhIM3WVvOVljf4cvcKA/Gj+iZqrf1WpKcPfuofSdpy5MejXGLr9NnwB2FMbb+7eKv2Gs
         QOebthHELJHAoIaVtDS7RPZ/2X1p5+PEp54ofJ/pz6ObHKdcmm+yR2misUFpJEjoFXT9
         MaTLZWQ5UJecQUMcPvOJ3SrJQ365I3vicKl5hTQC3VqCtIX2UaLskQYXquVnCXOkxxTr
         YM7w==
X-Forwarded-Encrypted: i=1; AJvYcCXPP9X09c34OCsfaFG76hfzAbHPUm/7Au3W7Xr9ia4/BL4cGLxCUAcnWoB9GwvmIYhIQaBKPzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWAuwjCX5cr8i3J6q0RXfHuFtaomB2F1bnjMVyaNfaQlcS89f
	FilvVFdEZqXTHMdSraFTClWeR6bNxOjlT8H3UqPA7gWCCPT9HIymJnxIqDr1G6N3bDsdcprUfAd
	QY5nJc+MuO15JIg==
X-Google-Smtp-Source: AGHT+IGEXQEv1ck2MMfwU6rgK0ZJutzaTXShQnbjZpIAo+t8a2V6IvSghLh5iFSwIMiZroqb5nh669NLVFj+pQ==
X-Received: from dlbrp1.prod.google.com ([2002:a05:7022:1601:b0:119:49ca:6b84])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2406:b0:298:4f73:d872 with SMTP id d9443c01a7336-2984f73d8d1mr72305215ad.21.1763005587061;
 Wed, 12 Nov 2025 19:46:27 -0800 (PST)
Date: Thu, 13 Nov 2025 03:46:22 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113034623.3127012-1-cmllamas@google.com>
Subject: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Shuah Khan <shuah@kernel.org>, Ujwal Kundur <ujwal.kundur@gmail.com>, 
	Brendan Jackman <jackmanb@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, 
	"open list:MEMORY MANAGEMENT - USERFAULTFD" <linux-mm@kvack.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Commit 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global
vars into struct") moved some of the operations previously implemented
in uffd_setup_environment() earlier in the main test loop.

The calculation of nr_pages, which involves a division by page_size, now
occurs before checking that default_huge_page_size() returns a non-zero
This leads to a division-by-zero error on systems with !CONFIG_HUGETLB.

Fix this by relocating the non-zero page_size check before the nr_pages
calculation, as it was originally implemented.

Cc: stable@vger.kernel.org
Fixes: 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global vars into struct")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 9e3be2ee7f1b..f917b4c4c943 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1758,10 +1758,15 @@ int main(int argc, char *argv[])
 			uffd_test_ops = mem_type->mem_ops;
 			uffd_test_case_ops = test->test_case_ops;
 
-			if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
+			if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB)) {
 				gopts.page_size = default_huge_page_size();
-			else
+				if (gopts.page_size == 0) {
+					uffd_test_skip("huge page size is 0, feature missing?");
+					continue;
+				}
+			} else {
 				gopts.page_size = psize();
+			}
 
 			/* Ensure we have at least 2 pages */
 			gopts.nr_pages = MAX(UFFD_TEST_MEM_SIZE, gopts.page_size * 2)
@@ -1776,12 +1781,6 @@ int main(int argc, char *argv[])
 				continue;
 
 			uffd_test_start("%s on %s", test->name, mem_type->name);
-			if ((mem_type->mem_flag == MEM_HUGETLB ||
-			    mem_type->mem_flag == MEM_HUGETLB_PRIVATE) &&
-			    (default_huge_page_size() == 0)) {
-				uffd_test_skip("huge page size is 0, feature missing?");
-				continue;
-			}
 			if (!uffd_feature_supported(test)) {
 				uffd_test_skip("feature missing");
 				continue;
-- 
2.51.2.1041.gc1ab5b90ca-goog


