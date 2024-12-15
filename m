Return-Path: <stable+bounces-104236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D9C9F229C
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29DCC7A0F68
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409177483;
	Sun, 15 Dec 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tRMNbklP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6418AE2
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734251610; cv=none; b=TvqA3bBWnlC7MkYXGzP9q/pvJL1MhHySlv9z1ogcGDqi+OxLeq1bYL3rAv2zkZgLcKbRBEhbpNUbAZZICCK7HfNTpGK4yT1GEDjBSYqPNbHtRa/ck6bmBW42MpLy/93yBMVG3lcXvxzAsnzm6xcmcj2bQjFoHVdk1cNeYpE/z4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734251610; c=relaxed/simple;
	bh=oqkZxDgi067SKo63E/YMttHjSqm03PJY/wO1Lihp7d4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UlBuS7lnnaazJqBGYtzw2BzlTYxqzUXSXlrl2LPjidzuSWxCd4gZzqbj982mNrZHF/v4CkL7uHHjeqjEBk3oA0yszjwpZfT3v2AdCHnRbdYrAnGgCkzjdEwa5MeO0uoCJn6+FQYaTolJeiqO34FaCPKP0PAKuaINtyYt/0wfdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tRMNbklP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A4CC4CECE;
	Sun, 15 Dec 2024 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734251609;
	bh=oqkZxDgi067SKo63E/YMttHjSqm03PJY/wO1Lihp7d4=;
	h=Subject:To:Cc:From:Date:From;
	b=tRMNbklPM/xakGY+EsPPOFHw2fU90ZJIp++fSb9kLmG+YxaA0PNxVqXk/hr5duEO7
	 TiDS5pRIWe1yWcjQBvZCWsWA/b6tTa675z0urZHmzAs6OsuxqXCg1miSsbTs/1MT+u
	 fSHQXTORK62EtrVl3lZTFTW5Nv0X0/s6AyPyyh3A=
Subject: FAILED: patch "[PATCH] drm/i915: Fix memory leak by correcting cache object name in" failed to apply to 5.4-stable tree
To: jiashengjiangcool@outlook.com,andi.shyti@linux.intel.com,nirmoy.das@intel.com,stable@vger.kernel.org,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:33:18 +0100
Message-ID: <2024121518-unspoken-ladle-1d6a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2828e5808bcd5aae7fdcd169cac1efa2701fa2dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121518-unspoken-ladle-1d6a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2828e5808bcd5aae7fdcd169cac1efa2701fa2dd Mon Sep 17 00:00:00 2001
From: Jiasheng Jiang <jiashengjiangcool@outlook.com>
Date: Wed, 27 Nov 2024 20:10:42 +0000
Subject: [PATCH] drm/i915: Fix memory leak by correcting cache object name in
 error handler

Replace "slab_priorities" with "slab_dependencies" in the error handler
to avoid memory leak.

Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241127201042.29620-1-jiashengjiangcool@gmail.com
(cherry picked from commit 9bc5e7dc694d3112bbf0fa4c46ef0fa0f114937a)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i915_scheduler.c
index 762127dd56c5..70a854557e6e 100644
--- a/drivers/gpu/drm/i915/i915_scheduler.c
+++ b/drivers/gpu/drm/i915/i915_scheduler.c
@@ -506,6 +506,6 @@ int __init i915_scheduler_module_init(void)
 	return 0;
 
 err_priorities:
-	kmem_cache_destroy(slab_priorities);
+	kmem_cache_destroy(slab_dependencies);
 	return -ENOMEM;
 }


