Return-Path: <stable+bounces-62681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A96940D54
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77321C23F82
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CC8194C75;
	Tue, 30 Jul 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aEsIhxcx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327A194AF2
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331489; cv=none; b=Ko/fJDUYpBhD9VHnJXhDz7TVRc3D06xGEntqCleO+OaoX6p7R5lQ0ABnuKMXsR09ovZLO6ArgTVtLarQAG/6TvZApx98MSK9iAgAThCa+8/hYZJNScHS9VlCZZG0CLlWijLQhIcfcPdQyj4F+cz3MxCkRk0j5laDdxBNC2ftuus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331489; c=relaxed/simple;
	bh=KAT9p+TFzDGLQgpDW++53x+15sdyJ6PVJpg/GOIKH+A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y/SiPP1aIKItKbtPB+LYcd++Q3vDvLBIBopSz86pdd71NgwIGk+vqDdFVyRk46pm5VqDOHhicUKKdlRoPN2iNW1qdf/5XG+E0oOfz2LDMkwKopoSd0FNtPr9GYYE0+tx3cNhfaBhTAQM0/w1ndUN1LWYutYb0hBkZsUtGmFTCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aEsIhxcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC670C32782;
	Tue, 30 Jul 2024 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331489;
	bh=KAT9p+TFzDGLQgpDW++53x+15sdyJ6PVJpg/GOIKH+A=;
	h=Subject:To:Cc:From:Date:From;
	b=aEsIhxcx6p6CHLolk4b1czzkBsYJy2gmwahzLPNzTJZmqqoEudTKN3PiDHsQs34+0
	 ltSz0/pgUcl/QsUO+VtQVG8K2DSXMfPUF5ZZj/6+ZpT6ta+4Vvnynl27WA/uOf927n
	 +GPvS9BhKiit2hABtGH5U46H6m1ea2/xzwHvzb9g=
Subject: FAILED: patch "[PATCH] Revert "mm/writeback: fix possible divide-by-zero in" failed to apply to 5.10-stable tree
To: jack@suse.cz,akpm@linux-foundation.org,stable@vger.kernel.org,zokeefe@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:24:34 +0200
Message-ID: <2024073033-riverbed-nutcase-30ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8dfcffa37094fef2c8cf8b602316766a86956d07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073033-riverbed-nutcase-30ab@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


