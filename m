Return-Path: <stable+bounces-89691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 566099BB3AC
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5160AB2AFF5
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71B1BFE05;
	Mon,  4 Nov 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M0nVl3Pg"
X-Original-To: stable@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548D1B21AF;
	Mon,  4 Nov 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719676; cv=none; b=ohoUcifMJl79DN7MPrQx5nBNQxxIeJ8Tz2t26MR1GJlendi2TcytdC0TojG602661MIFXnup4gDI2kzysx1crzQqaXPiDQG7zjqNDeXnQhe5rJtdD8YD5De/ctItkDaz42WB9r6NFiyTA8jsVY3+K5wBXRGB5+nH6W6px/I2TAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719676; c=relaxed/simple;
	bh=Zo/TEKUmbI+dIitrIB6iU/CQI4lk3REMpqfmeviLV9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apT+7PjBCr2xwekGW3LUGxTqLuX+iBwZRd97ZcyMyGefjdzVw/Yhd8Qo6BZ67QYZ5DGkoNiml7vhaLlITaKh51VhJKniF87GdRGb0LJIHF+kp2TfEtWi7xBXfez83QNv4Z81070iMHHiwjOEwDYISXKr5b6DzD3qH6SqIOpBKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M0nVl3Pg; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730719671; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JompvDFQSatM0tzaqdC5WCj1xSELUnEzpDgCAXUivBg=;
	b=M0nVl3PgaDG1OwoyW4xcdaH4QdZDKwBYiHUYyIGXfsStq9sfXZvZvwkmxah0VCGlTAixJIs9Z/TLb9lMG+Bv6fINdD59erSgED63NmSewKtgYg7OEv0raBOX3YjWdAD0Eausn5eMJ31+0UgKMALW0aypcpMTLmwWhSTqsOwj5/4=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIgekVB_1730719667 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 19:27:49 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	gregkh@linuxfoundation.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	acme@redhat.com,
	kprateek.nayak@amd.com,
	ravi.bangoria@amd.com,
	sandipan.das@amd.com,
	anshuman.khandual@arm.com,
	german.gomez@arm.com,
	james.clark@arm.com,
	terrelln@fb.com,
	seanjc@google.com,
	changbin.du@huawei.com,
	liuwenyu7@huawei.com,
	yangjihong1@huawei.com,
	mhiramat@kernel.org,
	ojeda@kernel.org,
	song@kernel.org,
	leo.yan@linaro.org,
	kjain@linux.ibm.com,
	ak@linux.intel.com,
	kan.liang@linux.intel.com,
	atrajeev@linux.vnet.ibm.com,
	siyanteng@loongson.cn,
	liam.howlett@oracle.com,
	pbonzini@redhat.com,
	jolsa@kernel.org
Subject: [PATCH 5.10.y 0/2] Fixed perf abort when taken branch stack sampling enabled
Date: Mon,  4 Nov 2024 19:27:34 +0800
Message-ID: <20241104112736.28554-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86 platform, kernel v5.10.228, perf-report command aborts due to "free():
invalid pointer" when perf-record command is run with taken branch stack
sampling enabled. This regression can be reproduced with the following steps:

	- sudo perf record -b
	- sudo perf report

The root cause is that bi[i].to.ms.maps does not always point to thread->maps,
which is a buffer dynamically allocated by maps_new(). Instead, it may point to
&machine->kmaps, while kmaps is not a pointer but a variable. The original
upstream commit c1149037f65b ("perf hist: Add missing puts to
hist__account_cycles") worked well because machine->kmaps had been refactored to
a pointer by the previous commit 1a97cee604dc ("perf maps: Use a pointer for
kmaps").

The memory leak issue, which the reverted patch intended to fix, has been solved
by commit cf96b8e45a9b ("perf session: Add missing evlist__delete when deleting
a session"). The root cause is that the evlist is not being deleted on exit in
perf-report, perf-script, and perf-data. Consequently, the reference count of
the thread increased by thread__get() in hist_entry__init() is not decremented
in hist_entry__delete(). As a result, thread->maps is not properly freed.

To this end,

- PATCH 1/2 reverts commit a83fc293acd5c5050a4828eced4a71d2b2fffdd3 to fix the
  abort regression.
- PATCH 2/2 backports cf96b8e45a9b ("perf session: Add missing evlist__delete
  when deleting a session") to fix memory leak issue.

Riccardo Mancini (1):
  perf session: Add missing evlist__delete when deleting a session

Shuai Xue (1):
  Revert "perf hist: Add missing puts to hist__account_cycles"

 tools/perf/util/hist.c    | 10 +++-------
 tools/perf/util/session.c |  5 ++++-
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.39.3


