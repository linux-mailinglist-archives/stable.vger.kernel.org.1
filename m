Return-Path: <stable+bounces-98541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DAD9E430C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 19:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CBB288353
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F99423918B;
	Wed,  4 Dec 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4hkvq/o"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A97F3D561
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335901; cv=none; b=oFvFg4yybAWLrk0dGd5m/QH9cDVCQmmy3SFjCZ2O1QQ6i9PIW9DIqJ0/e8GsDtnaYR+azSON2Z+mwecSngaEqEMq+gthD+vKj2Ym5cv0oj/RWFRAC5vTwkEMJrIzXPZX2dA7hLfattYaSTMQiI/vRTm0mQSXBRgCP3xlKaGMInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335901; c=relaxed/simple;
	bh=vjmcSgcWnBKzXMjigUXcBMqoJFMjy5ELFrCRu15LNI4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrJ5mkDfzrwu9VpkDDdX9R96iPUFI3bIm3wsyyldZ8sQYDlrX1+6CIE0PZqdX3TVufD4cqSMp4HTluHnd20oAhwX/+oMNqNfupiboMzFvSMVauXsx2bsmatVfho2Sb5beKYN22fjrpCr6n0D8Y1OqDu3YekMs9Wj1acK4pAYok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4hkvq/o; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733335899; x=1764871899;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=vjmcSgcWnBKzXMjigUXcBMqoJFMjy5ELFrCRu15LNI4=;
  b=A4hkvq/o7+AHY8EOSyYMnksVJlgTmO7tR6SWP0MvKmRbCgP1olxsM9N2
   Rqq+hv3F6ao8O1H3hel9EVfcmCrAwyTzRdkd/PThzOaUKjvHJYBDO3eCz
   qER0eINtdnp3coX0iVZAjIGo8mJkwKf+Z+ztLdyPhi5KO5ySfOcYN7r66
   Bltg0KIUm3LZJWmYmPUWDu3G14NFbqvnUgHyu7kEXep1QAh59FzlsI3c+
   AwxnQRx7gB4SDb0eWxOzFtFPWzdGnODNfcoddvZIMQbtQon8yi6AkMnLE
   uBlHp4363fbt/Fwt5fsYs0ZsfFPh5WIIDQe9cHD9MqEp6YDyss8OXneLZ
   Q==;
X-CSE-ConnectionGUID: LHDQkX2cTxaM4ZSoUGMQgw==
X-CSE-MsgGUID: VtHZgADhQa+mFhlnRvVpuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37281331"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="37281331"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 10:11:39 -0800
X-CSE-ConnectionGUID: kDD4la/zTQuzeDONeS36Tw==
X-CSE-MsgGUID: FUWwNT5dS7iODibIrBm5iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93717427"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.89.141])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 10:11:37 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: stable@vger.kernel.org
Subject: [PATCH 4.19] perf/x86/intel/pt: Fix buffer full but size is 0 case
Date: Wed,  4 Dec 2024 20:11:26 +0200
Message-ID: <20241204181126.61934-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024120221-raft-bully-e091@gregkh>
References: <2024120221-raft-bully-e091@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

commit 5b590160d2cf776b304eb054afafea2bd55e3620 upstream.

If the trace data buffer becomes full, a truncated flag [T] is reported
in PERF_RECORD_AUX.  In some cases, the size reported is 0, even though
data must have been added to make the buffer full.

That happens when the buffer fills up from empty to full before the
Intel PT driver has updated the buffer position.  Then the driver
calculates the new buffer position before calculating the data size.
If the old and new positions are the same, the data size is reported
as 0, even though it is really the whole buffer size.

Fix by detecting when the buffer position is wrapped, and adjust the
data size calculation accordingly.

Example

  Use a very small buffer size (8K) and observe the size of truncated [T]
  data. Before the fix, it is possible to see records of 0 size.

  Before:

    $ perf record -m,8K -e intel_pt// uname
    Linux
    [ perf record: Woken up 2 times to write data ]
    [ perf record: Captured and wrote 0.105 MB perf.data ]
    $ perf script -D --no-itrace | grep AUX | grep -F '[T]'
    Warning:
    AUX data lost 2 times out of 3!

    5 19462712368111 0x19710 [0x40]: PERF_RECORD_AUX offset: 0 size: 0 flags: 0x1 [T]
    5 19462712700046 0x19ba8 [0x40]: PERF_RECORD_AUX offset: 0x170 size: 0xe90 flags: 0x1 [T]

 After:

    $ perf record -m,8K -e intel_pt// uname
    Linux
    [ perf record: Woken up 3 times to write data ]
    [ perf record: Captured and wrote 0.040 MB perf.data ]
    $ perf script -D --no-itrace | grep AUX | grep -F '[T]'
    Warning:
    AUX data lost 2 times out of 3!

    1 113720802995 0x4948 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x2000 flags: 0x1 [T]
    1 113720979812 0x6b10 [0x40]: PERF_RECORD_AUX offset: 0x2000 size: 0x2000 flags: 0x1 [T]

Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20241022155920.17511-2-adrian.hunter@intel.com
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c | 11 ++++++++---
 arch/x86/events/intel/pt.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 87cca5622885..d37ea43df220 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -771,11 +771,13 @@ static void pt_buffer_advance(struct pt_buffer *buf)
 	buf->cur_idx++;
 
 	if (buf->cur_idx == buf->cur->last) {
-		if (buf->cur == buf->last)
+		if (buf->cur == buf->last) {
 			buf->cur = buf->first;
-		else
+			buf->wrapped = true;
+		} else {
 			buf->cur = list_entry(buf->cur->list.next, struct topa,
 					      list);
+		}
 		buf->cur_idx = 0;
 	}
 }
@@ -789,8 +791,11 @@ static void pt_buffer_advance(struct pt_buffer *buf)
 static void pt_update_head(struct pt *pt)
 {
 	struct pt_buffer *buf = perf_get_aux(&pt->handle);
+	bool wrapped = buf->wrapped;
 	u64 topa_idx, base, old;
 
+	buf->wrapped = false;
+
 	/* offset of the first region in this table from the beginning of buf */
 	base = buf->cur->offset + buf->output_off;
 
@@ -803,7 +808,7 @@ static void pt_update_head(struct pt *pt)
 	} else {
 		old = (local64_xchg(&buf->head, base) &
 		       ((buf->nr_pages << PAGE_SHIFT) - 1));
-		if (base < old)
+		if (base < old || (base == old && wrapped))
 			base += buf->nr_pages << PAGE_SHIFT;
 
 		local_add(base - old, &buf->data_size);
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index ad4ac27f0468..7c3fc191f789 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -110,6 +110,7 @@ struct pt_pmu {
  * @lost:	if data was lost/truncated
  * @head:	logical write offset inside the buffer
  * @snapshot:	if this is for a snapshot/overwrite counter
+ * @wrapped:	buffer advance wrapped back to the first topa table
  * @stop_pos:	STOP topa entry in the buffer
  * @intr_pos:	INT topa entry in the buffer
  * @data_pages:	array of pages from perf
@@ -125,6 +126,7 @@ struct pt_buffer {
 	local_t			data_size;
 	local64_t		head;
 	bool			snapshot;
+	bool			wrapped;
 	unsigned long		stop_pos, intr_pos;
 	void			**data_pages;
 	struct topa_entry	*topa_index[0];
-- 
2.43.0


