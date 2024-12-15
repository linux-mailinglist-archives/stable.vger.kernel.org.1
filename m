Return-Path: <stable+bounces-104235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBB49F229B
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C12A165B34
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F042AB3;
	Sun, 15 Dec 2024 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pEiOchet"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BC7483
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734251601; cv=none; b=a1xSjwiyoiEPGtmB5Bnkf5DvfmR0oVbJH7J0Vvsl7Vm1LzxkBl4ixvnm2ktkuNIc/9OcSOqiO7rlCe0/MNWdM4oLdtX0exRp3Yd8+3DNtljD8jq6uaUf/V/lAuCADuFW/gMpwop7ZazQbv6gEdu7CmP62+pnbZ7EkydxMLSTIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734251601; c=relaxed/simple;
	bh=z1o38hwWfPmjf+NQwdaPhUIG7KuL5QBtwQaMNOCpMvo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RaeioRKFhZ+FpOieltuXIe6Pjse1srbeu8YHERqiJ+RlHvKkC92P5tuIPGGzBOR3TK5E28RalkfzhXBTMTvklDAmsUfhm5bShN+Tx2ufF68MLQZXYGKl53L92ELwOpcd2pj8naHqrfTFzG7N2avk9IGp3Y+Rsw2ILmiIgzH8IO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pEiOchet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F8CC4CECE;
	Sun, 15 Dec 2024 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734251600;
	bh=z1o38hwWfPmjf+NQwdaPhUIG7KuL5QBtwQaMNOCpMvo=;
	h=Subject:To:Cc:From:Date:From;
	b=pEiOchet3VLABImx9akAYnfIczCKo85viZLjzYSNvTG3AOrXyJT292FIaxopXCGUf
	 k3+bOGRwktClBkczfxj1k/yomXYQjcayZvw5OgBl1AVDffLxP21OiiAVdeGbAg5bMC
	 pTL/iZ6WoPrD8zu6h1hJanKDGw6xk2SUaLy4hxRI=
Subject: FAILED: patch "[PATCH] drm/i915: Fix memory leak by correcting cache object name in" failed to apply to 5.10-stable tree
To: jiashengjiangcool@outlook.com,andi.shyti@linux.intel.com,nirmoy.das@intel.com,stable@vger.kernel.org,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:33:17 +0100
Message-ID: <2024121517-deserve-wharf-c2d0@gregkh>
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
git cherry-pick -x 2828e5808bcd5aae7fdcd169cac1efa2701fa2dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121517-deserve-wharf-c2d0@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


