Return-Path: <stable+bounces-152771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA8DADC947
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919CD3ACE2F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB792980AF;
	Tue, 17 Jun 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ACbIMTF2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4D5C96
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750159565; cv=none; b=OPhEBgxB5ogIQyev15I9NiFb/Qn3618/NNvjsyz5Sar2s8MhzWRHGtNPFF3I+CanNfk+7kB9xPZ0KCH0UJgLxxLAxu2SH9mFSXLZCkuo2SyOT7yunxFbD8wirt3/N21QcaquULc5NJp15tZ5/xpAyB1lTFbHep/HcVaajbdaNZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750159565; c=relaxed/simple;
	bh=mpzCbf13C6z6tG4hYKcrgcWuPIHJuVA6C+lVqERe3K0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RK82UkyISNHIMCE1ye2zp9/zBwxMW/NncJ6jEc77XtJoGsfZo6mJCy3GjtPcpulhRHiKqLyVnjKZH5GkX14+uprL4Y5VLXi7XKE2LBYcqnOxCbQdZ4AfGXXAA7nGWmLGcIa1DkaaA4T9MHtftCW/E5rvgMlQ9gKZUcunq+lFJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ACbIMTF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18E1C4CEE3;
	Tue, 17 Jun 2025 11:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750159565;
	bh=mpzCbf13C6z6tG4hYKcrgcWuPIHJuVA6C+lVqERe3K0=;
	h=Subject:To:Cc:From:Date:From;
	b=ACbIMTF2i9p04rxlb1qsETts9GdT4SdR4kdf91IUKmwUODvp6cXCpIfJE8JVfcM1/
	 j5N9+YdCQDMu5u8fh8lczfJZnt5LcQJsAKcbdm40ipPt+KEuZ02L69BbzfJry+IACl
	 n3SN8+TdfFgSM1Hh+t27oxFHpMq7DoUjYvdVKpaM=
Subject: FAILED: patch "[PATCH] Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable" failed to apply to 6.6-stable tree
To: joonas.lahtinen@linux.intel.com,andi.shyti@linux.intel.com,matthew.auld@intel.com,thomas.hellstrom@linux.intel.com,tursulin@ursulin.net,tvrtko.ursulin@igalia.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 13:25:54 +0200
Message-ID: <2025061754-sensitive-pointed-5663@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ed5915cfce2abb9a553c3737badebd4a11d6c9c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061754-sensitive-pointed-5663@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed5915cfce2abb9a553c3737badebd4a11d6c9c7 Mon Sep 17 00:00:00 2001
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Date: Thu, 22 May 2025 09:41:27 +0300
Subject: [PATCH] Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable
 contexts on DG1"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit d6e020819612a4a06207af858e0978be4d3e3140.

The IS_DGFX check was put in place because error capture of buffer
objects is expected to be broken on devices with VRAM.

Userspace fix[1] to the impacted media driver has been submitted, merged
and a new driver release is out as 25.2.3 where the capture flag is
dropped on DG1 thus unblocking the usage of media driver on DG1.

[1] https://github.com/intel/media-driver/commit/93c07d9b4b96a78bab21f6acd4eb863f4313ea4a

Cc: stable@vger.kernel.org # v6.0+
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/20250522064127.24293-1-joonas.lahtinen@linux.intel.com
[Joonas: Update message to point out the merged userspace fix]
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
(cherry picked from commit d2dc30e0aa252830f908c8e793d3139d51321370)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index ea9d5063ce78..ca7e9216934a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -2013,7 +2013,7 @@ static int eb_capture_stage(struct i915_execbuffer *eb)
 			continue;
 
 		if (i915_gem_context_is_recoverable(eb->gem_context) &&
-		    GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
+		    (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 0)))
 			return -EINVAL;
 
 		for_each_batch_create_order(eb, j) {


