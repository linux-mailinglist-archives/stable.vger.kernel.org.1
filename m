Return-Path: <stable+bounces-109536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B9AA16DEA
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AED163B6B
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B0E1E2859;
	Mon, 20 Jan 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/6e96aV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE31E2838
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381486; cv=none; b=KBkB4lexgBXuxJHYACV/yjDcCEX1PMK7NKTgoTIL5myGDr043EpLN7pvni03hVFfOnp1WkOdpI4kMXdAKmMytW/nrLAlPjs/nL0qgdoTK1/v44uuHeK7wNtmcpGZZ5bgOY41FkU1z2fbhSZ8o4P0X0pg6+dEEzPa+gjp7d4O6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381486; c=relaxed/simple;
	bh=0uKeKF6ePQ2Kalqn7CXkdRYQky+35vsKebstdAgWRv4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gzCVSssD3WDE0fLCeHSLLxPSlcY61SUgz67yF5i80poEXGhVmT4nkk1F1h3UbUQHkM4O+dVI6B9L6STaADH7VFti467mRzfH6UqVMOzu0Ad0Fr6Ow6RoQNdUO+2qSGZDonFqJlNZNFzzK4fvk2Wg4AHuX3P7fGFtvz5Hu38kllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/6e96aV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B402DC4CEDD;
	Mon, 20 Jan 2025 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737381486;
	bh=0uKeKF6ePQ2Kalqn7CXkdRYQky+35vsKebstdAgWRv4=;
	h=Subject:To:Cc:From:Date:From;
	b=T/6e96aVkM+bEsZVAkZBxnLolfwhqEEpxjnQdp5O8v8cRaqvV3JTg4gkAgXqFlZyA
	 1fTNFUPO/c8eWjmc2N/994jNJA4e/c5q0cPA53Np9hN6/PEnG86net4UzIkgOggjQu
	 Z/Mo9I8bqOLosgwWs4uhwL1pV+wPjWkEuZJPMuyc=
Subject: FAILED: patch "[PATCH] alloc_tag: skip pgalloc_tag_swap if profiling is disabled" failed to apply to 6.12-stable tree
To: surenb@google.com,00107082@163.com,akpm@linux-foundation.org,kent.overstreet@linux.dev,quic_zhenhuah@quicinc.com,stable@vger.kernel.org,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:57:56 +0100
Message-ID: <2025012056-marina-lagging-26cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 05c82ee363f64c64b87a0cfd744298e9333475f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012056-marina-lagging-26cc@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05c82ee363f64c64b87a0cfd744298e9333475f5 Mon Sep 17 00:00:00 2001
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Dec 2024 13:16:39 -0800
Subject: [PATCH] alloc_tag: skip pgalloc_tag_swap if profiling is disabled

When memory allocation profiling is disabled, there is no need to swap
allocation tags during migration.  Skip it to avoid unnecessary overhead.

Once I added these checks, the overhead of the mode when memory profiling
is enabled but turned off went down by about 50%.

Link: https://lkml.kernel.org/r/20241226211639.1357704-2-surenb@google.com
Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: David Wang <00107082@163.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 7dcebf118a3e..65e706e1bc19 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -195,6 +195,9 @@ void pgalloc_tag_swap(struct folio *new, struct folio *old)
 	union codetag_ref ref_old, ref_new;
 	struct alloc_tag *tag_old, *tag_new;
 
+	if (!mem_alloc_profiling_enabled())
+		return;
+
 	tag_old = pgalloc_tag_get(&old->page);
 	if (!tag_old)
 		return;


