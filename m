Return-Path: <stable+bounces-179184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A39BB5133B
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883EA3AC73D
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9625FA0F;
	Wed, 10 Sep 2025 09:52:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D0265609;
	Wed, 10 Sep 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497957; cv=none; b=NKJ18wo7Bk7UOqzocG65Kh81xJhMrQ/z6NLIjuNapMxesxzQeBmTMdDBZ5t8s0qqI8Y9nLo3JpUkV+HG23koLCUsXcXQ2oNmuheJ9YpGHStJLKFVX7NCQUbn/EWpxJ1oBmpl/LCxdSAVh1av/8GhDiYdQpU/7Bka57pDH//McxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497957; c=relaxed/simple;
	bh=gSQlvxsR6uNM6GEheU7y6b4i42meAgCJ79Zi6uyxkhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5stYZh/+JAg5cwzRgPZd6owuO2vonES0RDnEtsDHG+XcIVgbqn2ohMHR7YdOk5PL0T8W3qgy/J50jjijCzadc20YokIwttD9iFxx3LuG+a1NvVKnGIK1cNLgT7L9k25DvWrzG5S6ZHE2WmlPYXdP/RezN+cqomb8QPeWTsbNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lee Jones <lee@kernel.org>,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Brett A C Sheffield <bacs@librecast.net>
Subject: [PATCH 1/1] Revert "fbdev: Disable sysfb device registration when removing conflicting FBs"
Date: Wed, 10 Sep 2025 09:38:03 +0000
Message-ID: <20250910095124.6213-5-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250910095124.6213-3-bacs@librecast.net>
References: <20250910095124.6213-3-bacs@librecast.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 13d28e0c79cbf69fc6f145767af66905586c1249.

Commit ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
removing conflicting FBs") was backported to 5.15.y LTS. This causes a
regression where all virtual consoles stop responding during boot at:

"Populating /dev with existing devices through uevents ..."

Reverting the commit fixes the regression.

Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
---
 drivers/video/fbdev/core/fbmem.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d938c31e8f90..3b52ddfe0350 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/slab.h>
-#include <linux/sysfb.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/vt.h>
@@ -1795,17 +1794,6 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 		do_free = true;
 	}
 
-	/*
-	 * If a driver asked to unregister a platform device registered by
-	 * sysfb, then can be assumed that this is a driver for a display
-	 * that is set up by the system firmware and has a generic driver.
-	 *
-	 * Drivers for devices that don't have a generic driver will never
-	 * ask for this, so let's assume that a real driver for the display
-	 * was already probed and prevent sysfb to register devices later.
-	 */
-	sysfb_disable();
-
 	mutex_lock(&registration_lock);
 	do_remove_conflicting_framebuffers(a, name, primary);
 	mutex_unlock(&registration_lock);
-- 
2.49.1


