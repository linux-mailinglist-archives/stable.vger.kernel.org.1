Return-Path: <stable+bounces-77068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A8985128
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 05:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D02C1F22ABB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 03:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766321474BF;
	Wed, 25 Sep 2024 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QRn86Nj/"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9F322A
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233315; cv=none; b=KxBEl3DGYRhrpHpjVdeXaqCu0q11N+cPwQ6BiCm31GJtbAeY3y2wLZEHIYzKdZg46kdqVpZ6lIInHBmWREQ/dm8LkrL1ekOIpQEMnb8IyXvB73/1IMa0pizd49sneV9EYkU7LYXIhfgU0uYZ449rivW6znJGxQLWPU5FgxvzKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233315; c=relaxed/simple;
	bh=TaxafVKqNVMtJyjCp6zLNLPSEJZPGzbd/+NQJMRn2GA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=VSjL7a18yOupG2CHtON8ojf3j3dbQfcI1n98FhBz8BCBqJhXGlYoEeFRIrVxKMkfcS4lzabWjhDxA6Z//m7OJbpSBbmTmfJq9tFVLE7rt4oYiu5XCVB4gAEKlPdnoK+mvMvSu3rAtyNiADjoq28MLylU6eWuwz4sI41SrZxhjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QRn86Nj/; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727233304; bh=qjKjxy/gJ2ZiVt/GpmNuDQyv2gWmhH8UMfK6JvXvkOU=;
	h=From:To:Cc:Subject:Date;
	b=QRn86Nj/uUKv8JCVJAgdfBf6XN1YlzQpDZaPDr/uidkb+SJo6Perue5iKWtn2MOig
	 3lf4K0HtZRQxrSu+0T45hOTFQLVYQoAuwbejPjD7PNMcU6ewi+1I26rtOuszmHpmen
	 V4TukF8eh2UOvWzHvvpHcKRwvAW+IbFYvhIQidlM=
Received: from localhost.localdomain ([218.2.157.131])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id D5DAEA34; Wed, 25 Sep 2024 10:53:29 +0800
X-QQ-mid: xmsmtpt1727232809tzf173wq5
Message-ID: <tencent_0538AD68DF644D5939940C5DD42E6CBE3E06@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTDzN+nWafxN5aXiOND39jO3J4dV4e6k/+PWDlTJQDr3nSWHoV1z
	 r/gEkW29LXosA57aKl32ESB5QHfo1lKmeFOzrzkyWt1DlGVA5fhirEjdlGZrZnr8wQ0Sy8pbWOHz
	 BA5mAG9hZVltNC8huRqZPWqqRoS5L0rdCzHo/NvjpWiZ23pVtdr7p6M7lJLK6oOo+tIeYWRe4bTp
	 mtUrlfx5BWF6x29I8/9wRjTbiFivHYYQyHUUi/ulbS+vT7K699b4L1o0D7l+sgeTX9Dj0qOnTJGL
	 563RDe1gaTzkhf/bPYvfjkLW2As7SxMskFYvi7N55VyHu4eVX9Hf5BdUq/xrEcpkWU1Tm8EA5DHb
	 YNu0gh6swjUhUTnWBNwbuSjw5J6dhTPyNWnoVXdzxRCo0hmTfLtZNCD4dUKWUsnVLT6K633W/9Qn
	 Vi9NGGjY+qp8q4qboPwn+y3ASm19Odx0kT/rVMnwejdkRbYEYFirEv7MwnKJa3ho6hZhouQZ6rtG
	 JFtB7qIF2UqXVwWDGMaN0IB5lXxmIDM8iEXcCmjAxosXgkdqwsELWFZeDQWguuItOFbCyAB2utrw
	 wOnO6svqZUWDgE5lChV3igbKgB/DbnaK+xaL0rtFMMBv1K6SvdzJnhqdWAhG1YgLN7jbNyZSJkmg
	 V7eDZF8ktwse5FUkGDvXkYesJHxSbndnN/XfmpJNdzE9FvZbjCgZq851f6s3LxuT4vfucKjANrcX
	 EAaXZcaXxwQpsSBujeYQSdG6eRrkNETsB0WvazvWRAE9Mb/yGuSOZmX51lz4zlGwUGnqfsxd9RVW
	 lsnuIIHI1aBxhc2mpTDkok2LdQ/4G/yB1144ehqcUqg8fEgX1WtxF9Yau+5GiWrZ1vdKThYDtsyy
	 l5OT3EQUoAT13KSRASW4ZALM6YxzbfZuw2p+7DTy50+goG5rTssMTTgzlnDyROieH29Lh8z5W4Cm
	 tB+V96XENhqEO0TDbLtMpeNw4tlKFHLO2R+WGflAaLhVNFBw1I6ZPJyONW9tdTkwSA89Ap6Ui7v8
	 c2yeMajQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Bao Chenglong <994270571@qq.com>
To: 994270571@qq.com
Cc: Zheng Zucheng <zhengzucheng@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH] sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime
Date: Wed, 25 Sep 2024 10:53:12 +0800
X-OQ-MSGID: <20240925025312.45346-1-994270571@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zheng Zucheng <zhengzucheng@huawei.com>

mainline inclusion
from mainline-v6.11-rc2
commit 77baa5bafcbe1b2a15ef9c37232c21279c95481c
category: bugfix
bugzilla: https://gitee.com/openeuler/kernel/issues/IAIN7J

Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77baa5bafcbe1b2a15ef9c37232c21279c95481c

--------------------------------

In extreme test scenarios:
the 14th field utime in /proc/xx/stat is greater than sum_exec_runtime,
utime = 18446744073709518790 ns, rtime = 135989749728000 ns

In cputime_adjust() process, stime is greater than rtime due to
mul_u64_u64_div_u64() precision problem.
before call mul_u64_u64_div_u64(),
stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.
after call mul_u64_u64_div_u64(),
stime = 135989949653530

unsigned reversion occurs because rtime is less than stime.
utime = rtime - stime = 135989749728000 - 135989949653530
		      = -199925530
		      = (u64)18446744073709518790

Trigger condition:
  1). User task run in kernel mode most of time
  2). ARM64 architecture
  3). TICK_CPU_ACCOUNTING=y
      CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set

Fix mul_u64_u64_div_u64() conversion precision by reset stime to rtime

Fixes: 3dc167ba5729 ("sched/cputime: Improve cputime_adjust()")
Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20240726023235.217771-1-zhengzucheng@huawei.com
Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
---
 kernel/sched/cputime.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..b453f8a6a7c7 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -595,6 +595,12 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	}
 
 	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
+	/*
+	 * Because mul_u64_u64_div_u64() can approximate on some
+	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
+	 */
+	if (unlikely(stime > rtime))
+		stime = rtime;
 
 update:
 	/*
-- 
2.34.1


