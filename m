Return-Path: <stable+bounces-143108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E915DAB2CAE
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 02:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F19E175497
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 00:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B913AA2E;
	Mon, 12 May 2025 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VLRfSCa2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC91E489;
	Mon, 12 May 2025 00:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747010975; cv=none; b=m4pk1cSHcPx47y8k2TmAkREHSVPws6hiPUHZV4o56+JJyKEIa9QG5Ha/B8/g2syevLs4zrs62fdkS7FBLveoXg+VGQ8ogr/X3L2VYpcJaa9YzQHHr283K49pj//q1UwMP7h4Ik0LZArRV6I4WJZqbDotCwqlUsnNNRTcUrSCt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747010975; c=relaxed/simple;
	bh=H2An/ke4PtMN9t+AA7meIsIrjMdznX7wx4ZkjJKbWSA=;
	h=Date:To:From:Subject:Message-Id; b=Rmqzogsp2cvjFKN8ziw1GnWC2EaGxV0AHd2CPUd2fQZenpf+12WSuVGxaE/dIrBdd+41YB1SMPqX5fCbslm9hACB9e9B7VD6Es013DE7PrIJxb+eWYptmsTuUFMBsCAXilczI9i+gmHa+qS3tID7LHdALtr3Iol1i3Nn0QAUKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VLRfSCa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F143C4CEE4;
	Mon, 12 May 2025 00:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747010974;
	bh=H2An/ke4PtMN9t+AA7meIsIrjMdznX7wx4ZkjJKbWSA=;
	h=Date:To:From:Subject:From;
	b=VLRfSCa2nUMWLkn4waBh4VA9S37Yo6t++yUISCEOZHwLP8XYZitjtTDN9ujhKx6TF
	 aYpNZD4nyluUFv45tUxLDFCfftsT+YDiaXUR3GuvxQB226Z4VprGntd9D1s+A7bpxe
	 LOB/jeHf83Rcsh8iBbR4LhJqocLclLfL7p1UJpcc=
Date: Sun, 11 May 2025 17:49:33 -0700
To: mm-commits@vger.kernel.org,willy@infradead.org,stable@vger.kernel.org,mengensun@tencent.com,fengguang.wu@intel.com,andrea@betterlinux.com,alexjlzheng@tencent.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] mm-fix-ratelimit_pages-update-error-in-dirty_ratio_handler.patch removed from -mm tree
Message-Id: <20250512004934.0F143C4CEE4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: fix ratelimit_pages update error in dirty_ratio_handler()
has been removed from the -mm tree.  Its filename was
     mm-fix-ratelimit_pages-update-error-in-dirty_ratio_handler.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Jinliang Zheng <alexjlzheng@tencent.com>
Subject: mm: fix ratelimit_pages update error in dirty_ratio_handler()
Date: Tue, 15 Apr 2025 17:02:32 +0800

In dirty_ratio_handler(), vm_dirty_bytes must be set to zero before
calling writeback_set_ratelimit(), as global_dirty_limits() always
prioritizes the value of vm_dirty_bytes.

It's domain_dirty_limits() that's relevant here, not node_dirty_ok:

  dirty_ratio_handler
    writeback_set_ratelimit
      global_dirty_limits(&dirty_thresh)           <- ratelimit_pages based on dirty_thresh
        domain_dirty_limits
          if (bytes)                               <- bytes = vm_dirty_bytes <--------+
            thresh = f1(bytes)                     <- prioritizes vm_dirty_bytes      |
          else                                                                        |
            thresh = f2(ratio)                                                        |
      ratelimit_pages = f3(dirty_thresh)                                              |
    vm_dirty_bytes = 0                             <- it's late! ---------------------+

This causes ratelimit_pages to still use the value calculated based on
vm_dirty_bytes, which is wrong now.


The impact visible to userspace is difficult to capture directly because
there is no procfs/sysfs interface exported to user space.  However, it
will have a real impact on the balance of dirty pages.

For example:

1. On default, we have vm_dirty_ratio=40, vm_dirty_bytes=0

2. echo 8192 > dirty_bytes, then vm_dirty_bytes=8192,
   vm_dirty_ratio=0, and ratelimit_pages is calculated based on
   vm_dirty_bytes now.

3. echo 20 > dirty_ratio, then since vm_dirty_bytes is not reset to
   zero when writeback_set_ratelimit() -> global_dirty_limits() ->
   domain_dirty_limits() is called, reallimit_pages is still calculated
   based on vm_dirty_bytes instead of vm_dirty_ratio.  This does not
   conform to the actual intent of the user.

Link: https://lkml.kernel.org/r/20250415090232.7544-1-alexjlzheng@tencent.com
Fixes: 9d823e8f6b1b ("writeback: per task dirty rate limit")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Reviewed-by: MengEn Sun <mengensun@tencent.com>
Cc: Andrea Righi <andrea@betterlinux.com>
Cc: Fenggaung Wu <fengguang.wu@intel.com>
Cc: Jinliang Zheng <alexjlzheng@tencent.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page-writeback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/page-writeback.c~mm-fix-ratelimit_pages-update-error-in-dirty_ratio_handler
+++ a/mm/page-writeback.c
@@ -520,8 +520,8 @@ static int dirty_ratio_handler(const str
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write && vm_dirty_ratio != old_ratio) {
-		writeback_set_ratelimit();
 		vm_dirty_bytes = 0;
+		writeback_set_ratelimit();
 	}
 	return ret;
 }
_

Patches currently in -mm which might be from alexjlzheng@tencent.com are



