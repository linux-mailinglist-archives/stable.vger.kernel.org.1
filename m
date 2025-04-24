Return-Path: <stable+bounces-136497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC9A99EE1
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 04:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73ED14610EE
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0D146D6A;
	Thu, 24 Apr 2025 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i0GJ++jd"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D802701BA;
	Thu, 24 Apr 2025 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462441; cv=none; b=sN0C8kXIAGfDhixB9aWgk4oYD5ffuNLQzr7CGiTprLoBYCbTtKEsPhdmU1RjOZorWrARBu7JKoahCTcHPZgeMgyQM6Q4L6DfAjGJuhiHWcP0PQDWGo6tifzD2LAE6wkX1J8seJEIzG5MyKGAdS+zHt6TOLDX/nQE2PSw5ebYJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462441; c=relaxed/simple;
	bh=An4kxq86Cef3c89KtnvdLmkNF7zg9V5jf3RldmqtYzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ybj+iPYhRwrubbRvM4pxOCsbO1FDtRTmFhV7O1appoK9vjo8yelc78+8i8wiPQW642LRAdEC05T8C2RpWMzp9/Q9GETU7K4jzfa4lMDi0ExDUcACFSYc/+Y9CbeGTtoZBkq5b7K8rS2dfsPEeYwIe1vVfMsekad28zVVS9gRDmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i0GJ++jd; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3qiDl
	T+rNYYIueM4osSVU8znOOazc0IsHSbCKSt2gPY=; b=i0GJ++jdfBqJB0rOGQB01
	9Hysr9shb3Qe88l2Zn1P4XzRD0Qi9Zs7Df2ipUmdwj3Azl2sv1NZGIacoa1nJ30L
	gerbmrh42nACfLXdjesA5Z8wiRC0PtYtAz4lx6SwExfn+0qJlIL15mwJ1FhCewxK
	CWTRlsy27Leoby/8j25Psw=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCXvEWRpAloXUhmAw--.34232S4;
	Thu, 24 Apr 2025 10:40:18 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] drm/xe/display: Add check for alloc_ordered_workqueue()
Date: Thu, 24 Apr 2025 10:40:15 +0800
Message-Id: <20250424024015.3499778-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCXvEWRpAloXUhmAw--.34232S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr18CFWfCryxtFWxZw18Xwb_yoWDJrgEkr
	17ZrnxWry0k3Wvqw4UZr4furySvr1Yvan7X3yS9asxtry7Wa1ftryvy345Xr4UZFy2yFW7
	u3W8W3WDZws7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNtxhDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkBk5bmgJo48xgwAAsh

Add check for the return value of alloc_ordered_workqueue()
in xe_display_create() to catch potential exception.

Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 0b0aca7a25af..18062cfb265f 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -104,6 +104,8 @@ int xe_display_create(struct xe_device *xe)
 	spin_lock_init(&xe->display.fb_tracking.lock);
 
 	xe->display.hotplug.dp_wq = alloc_ordered_workqueue("xe-dp", 0);
+	if (!xe->display.hotplug.dp_wq)
+		return -ENOMEM;
 
 	return drmm_add_action_or_reset(&xe->drm, display_destroy, NULL);
 }
-- 
2.25.1


