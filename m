Return-Path: <stable+bounces-98515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C519E4247
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C64C168715
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EB9207E16;
	Wed,  4 Dec 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLiUgTlr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE836233698
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332386; cv=none; b=og0tvomLil9xAOnyZGT9kI8TSNTBltqcTqOjwkaz9pV8ENNEdx4KsaJr+piBINvBRsxFbHLgxPRxuwWrJbSdc26gsSe8SUpQ58bIDRO9D5JvPRtJxTSvXV0m5trRpLPHotj1RgzTCduoOhxNYbrLVoGLrSrqP27KLPHGhrclsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332386; c=relaxed/simple;
	bh=Y3XZXBpF35vV99oi4KIDKGZpMLNQJAiul0q3/bdQoK4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iCgDWPBF4Oyp5ATr0vvCXqnt4C5H3WYCWQSEldhxQiBxd1QFR/dgfXLH3jMMkeE2V6JwRI4TgSO7YWgPluCG07kcSIFm2tPpDUDKKotqAziVnsa6/SyR4EZ18MzAstRJ5zADbXsdupEVH4BPysTkNJaaeJ6opciDzTm2EXwCf2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLiUgTlr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733332384; x=1764868384;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y3XZXBpF35vV99oi4KIDKGZpMLNQJAiul0q3/bdQoK4=;
  b=NLiUgTlrHDiIBbunaOiRlMay8jzph2bfTEeoX5a/4k3nnTfsu1lWjcYX
   mntpKL/fr73bY7lsOLwg1J53pLcM80IoT+m2v1ofBdxDKaC79bU4vya8p
   9JEmhCeiERXDrJ4Jo8EiqiHnjzI2JB/6Ii3E6I45ZTCLRacBvBg3ifM3N
   JS5Ti0FTQSZlUc1QHjNSXe1h3EUXXKaZjkFC0SbaIevhGmXT6R+VWrcwd
   GqZCCI97gNJ/kBNsUZvWJF8Kl3lk+4xAMh3Dlj28F3gIy3Yg+2NsJ4KPP
   8/JvEBdUSmTkXhWFw9bmvH+HoCLI6GijviJfugcu1P6WS7ZBc7gUDrnQX
   A==;
X-CSE-ConnectionGUID: Q6XX0QBjQSGNeKwqVDaJtw==
X-CSE-MsgGUID: SguCR07wTZ+sMD9Wdv8yzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32970102"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="32970102"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 09:13:03 -0800
X-CSE-ConnectionGUID: 9uJ1v/7OQPeVs9xT6f8FGQ==
X-CSE-MsgGUID: /xfOQBu+Rd6qy8czkxXRdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98847938"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.89.141])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 09:13:02 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.4] perf/x86/intel/pt: Fix buffer full but size is 0 case
Date: Wed,  4 Dec 2024 19:12:49 +0200
Message-ID: <20241204171249.59950-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
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
index 99b286b6c200..622bfb9a2fe7 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -782,11 +782,13 @@ static void pt_buffer_advance(struct pt_buffer *buf)
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
@@ -800,8 +802,11 @@ static void pt_buffer_advance(struct pt_buffer *buf)
 static void pt_update_head(struct pt *pt)
 {
 	struct pt_buffer *buf = perf_get_aux(&pt->handle);
+	bool wrapped = buf->wrapped;
 	u64 topa_idx, base, old;
 
+	buf->wrapped = false;
+
 	/* offset of the first region in this table from the beginning of buf */
 	base = buf->cur->offset + buf->output_off;
 
@@ -814,7 +819,7 @@ static void pt_update_head(struct pt *pt)
 	} else {
 		old = (local64_xchg(&buf->head, base) &
 		       ((buf->nr_pages << PAGE_SHIFT) - 1));
-		if (base < old)
+		if (base < old || (base == old && wrapped))
 			base += buf->nr_pages << PAGE_SHIFT;
 
 		local_add(base - old, &buf->data_size);
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index c2d00a072952..51674454c69d 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -64,6 +64,7 @@ struct pt_pmu {
  * @lost:	if data was lost/truncated
  * @head:	logical write offset inside the buffer
  * @snapshot:	if this is for a snapshot/overwrite counter
+ * @wrapped:	buffer advance wrapped back to the first topa table
  * @stop_pos:	STOP topa entry index
  * @intr_pos:	INT topa entry index
  * @stop_te:	STOP topa entry pointer
@@ -80,6 +81,7 @@ struct pt_buffer {
 	local_t			data_size;
 	local64_t		head;
 	bool			snapshot;
+	bool			wrapped;
 	long			stop_pos, intr_pos;
 	struct topa_entry	*stop_te, *intr_te;
 	void			**data_pages;
-- 
2.43.0


