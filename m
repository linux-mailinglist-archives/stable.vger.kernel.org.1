Return-Path: <stable+bounces-118940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E837EA422CA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4271A424F53
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9EC151985;
	Mon, 24 Feb 2025 14:11:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5B14A627;
	Mon, 24 Feb 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406311; cv=none; b=R5q5mTnKojyYNFWkgrEgsZZ1FDM1AMy8o/gc70nSBNxH7DW6XDb44rLA4E69KLbvnZEzglnIf4Z9b39Vn4KDvvTCaYMFMseacQQ3x1wNmxkHpapZLqoC9Nhvpif4zxeZJIb6CSzuyswJE50ySgek5P49fhqUOxkp7X4EPwELis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406311; c=relaxed/simple;
	bh=honEVnfE4V0zsMviYhLubu2ELztDXqvTPG+FhJ7VOjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MiyHgy5V7ashjPDmfEOdxVCcc8GFjmH1ZBiXpMm/ZkXm9TLi/D4uIk1QSa0EPl//5ur8VYYQhvlNAmurSR58NC4mDqTODDN3YO0oCJ92EykMYvqMyOh6WjgRhhFMNyEFJ6rLP0GdVYs8ehz2Edvp0h01WpjeNDjFYj01A1LtpSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so6559176a12.0;
        Mon, 24 Feb 2025 06:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406308; x=1741011108;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IryNxkKlBcc9D0krfwIyGbizOCjjxeePhgWwSTN0Pco=;
        b=pDvQU0ScAw7fg/Uo6xabkPAIKKlrACETqofqUSNX1svlwVsrpO+HNpjhCQImvAv/TI
         Xlj6Qf+06VmYZsErN7oQTYRe4/+3kFQH5y/5InYVkqTwjqP2H8hiotrVNc98UGeNbx66
         yv6y2n7ZDAandCLIZHf2quYh6IHuqvzUmU03Z2lbrD0LywPiM+VMy4erdV+Qr9kxD85A
         DZ+JNstpYPZMBfLPE0CEfrWTB17Pof7JzwgvveC9TCtfYqZ/hBRfcA/bvTaCiiFGRtQK
         ZhNB+s6YQga5xI1LmsjJdAXw6FrTOR7MyLtmVqd5sRYbcA/+kZEIHYsOITnPlEVegdrS
         FtNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUto27U76ELjxqe48kg0CBlTZbGEUzOmv3Iknb3bGhZAFc1Kbct0S/6VDa/48FkVGKO9SL7A29I@vger.kernel.org, AJvYcCVCpb34qP+zpqCCDCoRvlf1yG4/MW85SgnOmaIJWTwCloX3bMQmwCjSL9w6kEoRiPFKqHkIwYzGBt+/2Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAcdrlUsIHB0HRFRROM/Hix8VRgF/vB0vkhWcoVH85w6QbIZoW
	l5u1ZEReqcUnlnna/An9BjrFKVp2qK6Xk6UMMNECtXiCiz4Yd2BO
X-Gm-Gg: ASbGncsAq6/FF7Ai+csFA5/c958Pt8m48Qvn6120/SGtR+Hf06DlCSqQPjgLiv1UioD
	7u3WdVqBrs62A9ZF694AseDpFWb44MRwLRLPgjyG4dDGBVSpfulp6htxiat5jGtXDmI7u/D8vhw
	J6+Gc99jvO7UQ7yapFzFxT4BVaeQR43NTSqr75D359eXzccZTXFULUDDRqNw0yMXTomFA1hH/0N
	CLNjH0r5ijgObkItk0HoYpz9sgAElBfb0ZRNNWsMqWKFIwwiz72hajc51iF9oFWloHM/aow0ZX5
	GQESRtwANCCAgZlyCQ==
X-Google-Smtp-Source: AGHT+IFJpKKTHNRBe9nWPzyfqPKFOkrLThbFnGPbXWdFQK/HTVe5NOVch1hoveoxNvgsKgKvjeXnbg==
X-Received: by 2002:a17:907:3ea8:b0:abb:6f30:32c3 with SMTP id a640c23a62f3a-abc0d9dbdd5mr1294707366b.24.1740406307623;
        Mon, 24 Feb 2025 06:11:47 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abecd9b9a33sm2884366b.80.2025.02.24.06.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:11:46 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Feb 2025 06:11:34 -0800
Subject: [PATCH v2] perf: Add RCU read lock protection to
 perf_iterate_ctx()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-fix_perf_rcu-v2-1-9e11ec2f0e69@debian.org>
X-B4-Tracking: v=1; b=H4sIABZ+vGcC/3XMsQqDMBAA0F8JN5uSi9gSp/5HEYnxorckcrFiE
 f+91L3rG94BhYSpQKsOENq4cE7QKlspCLNPE2keoVVgjW0M4kNH3vuFJPYS3trG6Gp0xjXGQ6V
 gEYq8X92rqxTMXNYsn2vf8Kd/og01aqzD4CyaGO7+OdLAPt2yTNCd5/kFBjBf5akAAAA=
X-Change-ID: 20250117-fix_perf_rcu-2ff93190950a
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=leitao@debian.org;
 h=from:subject:message-id; bh=honEVnfE4V0zsMviYhLubu2ELztDXqvTPG+FhJ7VOjk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnvH4h3QrzQ2sBlSHI21Fcx4F7xfKaMIypsIb9t
 pzsYk55MduJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7x+IQAKCRA1o5Of/Hh3
 bWcRD/9zHVZRAqiY/kdYGJ4J/yZOC0CW42pp3p2njID5sjXN/tXmOqi1AchXSxoVuVtX7pvKm9q
 ilH+/Hk5iDpY4jhbNIvYA013g2MRUP4rScxeqQCmV/gCcX/9C6pRrxTGBSnZ2Xz5qg/sYZrtG90
 mY2A1o9kIn20zftEJWAuRMsLtLmjZ19lgTZKMp/t9mPW0cVmWqKb5Ybgny+EfB0bXh832hLlrtr
 FRV5xUH9+F1dTlYWA5wLxe/5OScmbRnMHjMrTeyyjHSeNS8mz6cnfeHZBPQ//ftal9pznunb/3v
 l7n7goEaxio+8PPL213nqqB1xaY11olcjbcBW9BOVL2fraSFWbFMFDd0AOFQSpFvkxx0e/njQL3
 Ar93a6v/CmqJbl/e6CGUNq1T0D38/vhFV7rQjOcPZuA9y75I6pWylNeR+HKkXM3FFckogU319sX
 5H6po/rv6UmVSg5nFKnIk28UvbLwhctuHgOWrVlvoR1c5BOANPz5lPf8QLlBC75tU9rBThTNk0O
 FN/uxneiCXKaKFq8iADHlp1y5wMW/LdwooAHhj6PefAdCWJei8HtkcbMzYUgtG0Xcuug6I0uzcc
 AT/zaKhBkbyoXVi0mGEZfdVl22P3RIgRIcwe7ccSUjX6IEBzCKos5Kq/xPtrvNk1syb69NcLiDr
 RFAVzEfhJsIyUUw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The perf_iterate_ctx() function performs RCU list traversal but
currently lacks RCU read lock protection. This causes lockdep warnings
when running perf probe with unshare(1) under CONFIG_PROVE_RCU_LIST=y:

	WARNING: suspicious RCU usage
	kernel/events/core.c:8168 RCU-list traversed in non-reader section!!

	 Call Trace:
	  lockdep_rcu_suspicious
	  ? perf_event_addr_filters_apply
	  perf_iterate_ctx
	  perf_event_exec
	  begin_new_exec
	  ? load_elf_phdrs
	  load_elf_binary
	  ? lock_acquire
	  ? find_held_lock
	  ? bprm_execve
	  bprm_execve
	  do_execveat_common.isra.0
	  __x64_sys_execve
	  do_syscall_64
	  entry_SYSCALL_64_after_hwframe

This protection was previously present but was removed in commit
bd2756811766 ("perf: Rewrite core context handling"). Add back the
necessary RCU read locks around perf_iterate_ctx() call in
perf_event_exec().

CC: stable@vger.kernel.org
Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Use scoped_guard() instead of rcu_read_lock() as suggested by Peter Zijlstra.
- Link to v1: https://lore.kernel.org/r/20250117-fix_perf_rcu-v1-1-13cb9210fc6a@debian.org
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e011e9e1..7dabbcaf825a0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8321,7 +8321,8 @@ void perf_event_exec(void)
 
 	perf_event_enable_on_exec(ctx);
 	perf_event_remove_on_exec(ctx);
-	perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
+	scoped_guard(rcu)
+		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
 
 	perf_unpin_context(ctx);
 	put_ctx(ctx);

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250117-fix_perf_rcu-2ff93190950a

Best regards,
-- 
Breno Leitao <leitao@debian.org>


