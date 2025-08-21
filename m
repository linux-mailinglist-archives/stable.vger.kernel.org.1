Return-Path: <stable+bounces-172108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B2B2FAF4
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7383DAE24AB
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BFC2DF6E1;
	Thu, 21 Aug 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e00cHh4O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97551E7C05
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783198; cv=none; b=UWllrRuIRGhn2gGb9JdBwFWAXiY9vihld+mUL+bj5Odb2peKaJcar5YqgST/oRQJeSu3IEGeHnTl76GboH9qvwtxX2625en09zwudk4ss4FM7HlBFhmzvKgSsNSr7Xck6b9O7eW8XfPMYub2NP8P9K/FQBzuJncYOkMFXdWyuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783198; c=relaxed/simple;
	bh=wpbHv92SmYjE7aAL3BjRGK677Woh0gKYkaatF4RMw/g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LkjYkV3s/aER4q3pTgcphMozxLUSyEVBzELR3BvtrVY8DZukKVlutrC4u9aGqAEEgz6BLWGISngJnzE+C1bxwYGbf5yPsHuzfi1eBAA7CuQmF9rKcsFvmpzaCYu3P++6F8psqJ6irG1wyVGhsB28VP1Bcm4KTf8eW6HvXbwsVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e00cHh4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23FAC4CEEB;
	Thu, 21 Aug 2025 13:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783198;
	bh=wpbHv92SmYjE7aAL3BjRGK677Woh0gKYkaatF4RMw/g=;
	h=Subject:To:Cc:From:Date:From;
	b=e00cHh4OIzCnaPdbM9GRIf38sykxvWcMzvkQVBgR93Uh5fJO7WRF4w51Pc36iAQ77
	 3RkautAuEhH946qwG7I63RBdD0oyJdB7K8zNul3Zf4MXr0wGQSHHd8jfraNZbsXlsQ
	 rhXC6DZBoCZLjjbkmC+Mz1LfXYzH2X095pLpLz/o=
Subject: FAILED: patch "[PATCH] parisc: Drop WARN_ON_ONCE() from flush_cache_vmap" failed to apply to 5.15-stable tree
To: dave.anglin@bell.net,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:33:07 +0200
Message-ID: <2025082107-limeade-bolt-c120@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4eab1c27ce1f0e89ab67b01bf1e4e4c75215708a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082107-limeade-bolt-c120@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4eab1c27ce1f0e89ab67b01bf1e4e4c75215708a Mon Sep 17 00:00:00 2001
From: John David Anglin <dave.anglin@bell.net>
Date: Mon, 21 Jul 2025 16:18:41 -0400
Subject: [PATCH] parisc: Drop WARN_ON_ONCE() from flush_cache_vmap

I have observed warning to occassionally trigger.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 3b37a7e7abe4..37ca484cc495 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -841,7 +841,7 @@ void flush_cache_vmap(unsigned long start, unsigned long end)
 	}
 
 	vm = find_vm_area((void *)start);
-	if (WARN_ON_ONCE(!vm)) {
+	if (!vm) {
 		flush_cache_all();
 		return;
 	}


