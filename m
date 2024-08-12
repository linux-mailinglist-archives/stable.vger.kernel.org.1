Return-Path: <stable+bounces-67219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BE394F468
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7EB1F210B2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CEF18733E;
	Mon, 12 Aug 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="196UioWt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D4187332;
	Mon, 12 Aug 2024 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480205; cv=none; b=QL0NhLiZL8JVOzgytLal2Qbra6vJqEwz0+fBO/LXpMgYpCJcCtLtwDhKXFUz9YTdI+Ne1H/WQaia7DI40XQbg49GsvCWAsIV5OCzyskZuQcx6g+IKnSjwILSIOQQBiMoWBhjDJ1f8KGnNi3T5uF4br0853dwXcb0nCF7lSY2fC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480205; c=relaxed/simple;
	bh=z8frgA9or8njU76JjyPQHEvYbXIlS8zNfM/cEIv/fq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLbS+Xsen2dPKtc2rqj0B0Y9NgzCELID3fRZql2/eU1DretPeHzm8XXhKwmyQv+KizMrN/cseT8bTzQPbtDSXUiXsk4vwakReYaahbFif431nGr6IlR3jdxBrV8Np9h8JpQNZppifUl8yj6B7JlZANetXFvLGewSjlgyO0lcTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=196UioWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C89C32782;
	Mon, 12 Aug 2024 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480204;
	bh=z8frgA9or8njU76JjyPQHEvYbXIlS8zNfM/cEIv/fq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=196UioWtgRLW82NBypdzqRGLfe061I3+tfkBD2GdJHkMb6DjqoazYbJS6sqTNAjJk
	 plyu5a2lf5Yd/W1XOAHmsgOs7eHdisK6ItGANVNdllvZmWv6f8inlgr3tf+wlXVkd+
	 PX7iCTFaIWc8wdhAy1F+809sa56Mp5ICcgm3SYgI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zheng Zucheng <zhengzucheng@huawei.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.10 127/263] sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime
Date: Mon, 12 Aug 2024 18:02:08 +0200
Message-ID: <20240812160151.412242209@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Zucheng <zhengzucheng@huawei.com>

commit 77baa5bafcbe1b2a15ef9c37232c21279c95481c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/cputime.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -582,6 +582,12 @@ void cputime_adjust(struct task_cputime
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



