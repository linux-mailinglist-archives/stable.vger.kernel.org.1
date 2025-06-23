Return-Path: <stable+bounces-156914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44608AE51AC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80356189AC49
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476962222A9;
	Mon, 23 Jun 2025 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="deRz9cBv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051761EE7C6;
	Mon, 23 Jun 2025 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714578; cv=none; b=qM5dqyC6pnsaE+W/uZ2OUJpRFIDjCoK28rr+8CpcKge2MNzii8YgqDS/LKNqnbKVS9I+jGkxcZchoF5LHW61O+v9KMxdwGZ4n/taNX1F4EZKPeDD+y+RnPurTf1f7YLYDBz3qqUxU8k/n8mEMCTXHNsJk246rGncmJk9VzC7QNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714578; c=relaxed/simple;
	bh=IMjSbDzumGe4Ni7UIXskWbJX2Rh2pZigYpZw3qd4pcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rllxy37NG0V/P1OvEfr76vSc3yphY99ieurlQkB1h0ove0E13FSNFQ0D3wNhRwTpA4Aq3FC4hNXzaF2+sYwbp8+INzGbnfiICiUFVTIkBoZ/s/sihd1efGvJw/RcP5d6yaBK8sMpGMTM+MKbcAg3w7M9S0MLl3XBgZiEcRyCB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=deRz9cBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914B2C4CEEA;
	Mon, 23 Jun 2025 21:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714577;
	bh=IMjSbDzumGe4Ni7UIXskWbJX2Rh2pZigYpZw3qd4pcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deRz9cBvnG/boUl6EWL4TweI5fuT9DlVtRs4b3nOlpqGX5/25PnzUlvDwFVQeqDFr
	 vGa/l9xWqklkl7zcqeAOlVoMW1GqfPm6K3W4zN09smODApsXhxs9Px6NQYCRTpxt5p
	 ja6S8tsd2xvI589TEPnAMwojlAIc1BLpZfRXYjcM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	MengEn Sun <mengensun@tencent.com>,
	Andrea Righi <andrea@betterlinux.com>,
	Fenggaung Wu <fengguang.wu@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 117/414] mm: fix ratelimit_pages update error in dirty_ratio_handler()
Date: Mon, 23 Jun 2025 15:04:14 +0200
Message-ID: <20250623130645.003726774@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinliang Zheng <alexjlzheng@tencent.com>

commit f83f362d40ccceb647f7d80eb92206733d76a36b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/page-writeback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -543,8 +543,8 @@ static int dirty_ratio_handler(const str
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write && vm_dirty_ratio != old_ratio) {
-		writeback_set_ratelimit();
 		vm_dirty_bytes = 0;
+		writeback_set_ratelimit();
 	}
 	return ret;
 }



