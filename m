Return-Path: <stable+bounces-62678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8480940D51
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F11A1F2457F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5317194C6E;
	Tue, 30 Jul 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r4q9dyRP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87989194AF2
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331479; cv=none; b=oWunvNvpMDn+3kHKvcCNgUtX7WocFYlsp9tZfsIWH4Zn1v/BeKvVnfoQOThwAnf4iz0EP0i57Lgz9YmfVBkmT7vv6/qEH4qx8gdsEpx/2nj2BQbc4bVa/ml/CK0VkB1K6YYWrnQFwwLYOvT4V7bwb/6N9IXJ0JA+gHObO0qf0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331479; c=relaxed/simple;
	bh=KGxAGMyq+ePvoLXWzTidtpKwKJWKw7vCSFJYxSdgnE4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NO3DIR32rQA8vS3lCflU7SGucBmu2NTxsQbco+crGOUNkbyXH+CYXcX1LQbQ8EfNU72bGhTrjdy3Juhu+zw89MQFUp2WlPwFj0GsaD3UZCCzpqYwMIxiUvabuGekl4gTvLHu4/WfTCtb7UewfXSrf5zy1iM48OkjIxfG0EeJvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r4q9dyRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA97C32782;
	Tue, 30 Jul 2024 09:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331479;
	bh=KGxAGMyq+ePvoLXWzTidtpKwKJWKw7vCSFJYxSdgnE4=;
	h=Subject:To:Cc:From:Date:From;
	b=r4q9dyRPF7a+q/b/aUbxtmptbv0hy3WnBKlA4ZkNv7k3+fdGXM7vRWjN7Uj622PkC
	 5VlqsZXs3n5PnxMouHKkagwJ6csEEjUk5RYmQhE4oqNmli+4kATybQoptboB0z6AqI
	 e6B+m4Hsls7osziwGVm4cfbLCzVSqb8zyVHDVgDU=
Subject: FAILED: patch "[PATCH] Revert "mm/writeback: fix possible divide-by-zero in" failed to apply to 6.6-stable tree
To: jack@suse.cz,akpm@linux-foundation.org,stable@vger.kernel.org,zokeefe@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:24:30 +0200
Message-ID: <2024073030-affront-vigorous-240c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8dfcffa37094fef2c8cf8b602316766a86956d07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073030-affront-vigorous-240c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

8dfcffa37094 ("Revert "mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again"")
9319b647902c ("mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8dfcffa37094fef2c8cf8b602316766a86956d07 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Fri, 21 Jun 2024 16:42:37 +0200
Subject: [PATCH] Revert "mm/writeback: fix possible divide-by-zero in
 wb_dirty_limits(), again"

Patch series "mm: Avoid possible overflows in dirty throttling".

Dirty throttling logic assumes dirty limits in page units fit into
32-bits.  This patch series makes sure this is true (see patch 2/2 for
more details).


This patch (of 2):

This reverts commit 9319b647902cbd5cc884ac08a8a6d54ce111fc78.

The commit is broken in several ways.  Firstly, the removed (u64) cast
from the multiplication will introduce a multiplication overflow on 32-bit
archs if wb_thresh * bg_thresh >= 1<<32 (which is actually common - the
default settings with 4GB of RAM will trigger this).  Secondly, the
div64_u64() is unnecessarily expensive on 32-bit archs.  We have
div64_ul() in case we want to be safe & cheap.  Thirdly, if dirty
thresholds are larger than 1<<32 pages, then dirty balancing is going to
blow up in many other spectacular ways anyway so trying to fix one
possible overflow is just moot.

Link: https://lkml.kernel.org/r/20240621144017.30993-1-jack@suse.cz
Link: https://lkml.kernel.org/r/20240621144246.11148-1-jack@suse.cz
Fixes: 9319b647902c ("mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again")
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-By: Zach O'Keefe <zokeefe@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7168e25f88e5..c4aa6e84c20a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1683,7 +1683,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	 */
 	dtc->wb_thresh = __wb_calc_thresh(dtc, dtc->thresh);
 	dtc->wb_bg_thresh = dtc->thresh ?
-		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
+		div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
 
 	/*
 	 * In order to avoid the stacked BDI deadlock we need


