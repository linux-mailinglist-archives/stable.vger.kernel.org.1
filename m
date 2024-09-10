Return-Path: <stable+bounces-75643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A89973854
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32D01C2431D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D3192B76;
	Tue, 10 Sep 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1UGlEVT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19019259F
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973922; cv=none; b=UUbOKD5jr7OvvUzPFTq7nEZTH9b6ea3yqZSFb86GisZNHZn0AiNLa0Uk4LzaAhbVE2UwLT+eQPvbG1DDOvkOuGe2yzNyblzFhL3X78LDHbvVI2jeb/rOeUcUryMcmE5vUMZejAV43sn6Gdv5ADFkpPsMnI//aDt60L+psMD/kzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973922; c=relaxed/simple;
	bh=XF5quP1SDVR3xGZ7RGQMQNCzMKIuZCT3KhpMHKMXEkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FJlyp7iq6OL9y+1poDOOetgz98f1jccoJg/4PuPkAKE8CMPpveeKD+6jywnpK642Q1rBmb5CasMCkMQ8/VkicolHTwTLauRY8KLqRyKncERHSXs/hEW6MqzmPXlJrWw1KoyUN8v1+fjJ5FUpslFWSLWO4bH9Bv42y3582h4yX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1UGlEVT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725973921; x=1757509921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XF5quP1SDVR3xGZ7RGQMQNCzMKIuZCT3KhpMHKMXEkc=;
  b=T1UGlEVTEbR0Ewqe8hCE0iurXQ22viIcvUhHZoXmVcF13jR/7TuuecP7
   MBVcmCMQYDfg77dgruHDH/T1ddS/AN6LWrar5yGqb8+U0Ep1a//oyK4qf
   Hylbo4zxoQAXhXzLuWtNxE2RavsGhmMy1498/6ZhVfUuvd+mSzamARNbU
   8aPKtIP/efeyBOG+js2w4w5l8Re9QMLs8BuyZ7cBvsOU7OT1sbdaBiJGA
   ZDaDY6IcGWkjr0LNweSw/Wk2xvBkcNjLWKkFPcDaAAI46xuWVWOVuMwWC
   6k6uF9Ita2SPNSltclBqCPKpOQhH/UnH8JVqDjqMUSeddbK1HkBJlO93N
   Q==;
X-CSE-ConnectionGUID: 0FO2WZMWRWSHqWD/hSFGoA==
X-CSE-MsgGUID: 9aRaj2WzTOunWbV9Q6VYEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24861230"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24861230"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:12:00 -0700
X-CSE-ConnectionGUID: I8cL+SBSSLinUt/GnmKy0w==
X-CSE-MsgGUID: R/yUKCGtQruiPmoKgNznJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67037906"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.215])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:11:58 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] drm/xe/client: fix deadlock in show_meminfo()
Date: Tue, 10 Sep 2024 14:11:46 +0100
Message-ID: <20240910131145.136984-5-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is a real deadlock as well as sleeping in atomic() bug in here, if
the bo put happens to be the last ref, since bo destruction wants to
grab the same spinlock and sleeping locks.  Fix that by dropping the ref
using xe_bo_put_deferred(), and moving the final commit outside of the
lock. Dropping the lock around the put is tricky since the bo can go
out of scope and delete itself from the list, making it difficult to
navigate to the next list entry.

Fixes: 0845233388f8 ("drm/xe: Implement fdinfo memory stats printing")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2727
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_drm_client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index e64f4b645e2e..badfa045ead8 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -196,6 +196,7 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 	struct xe_drm_client *client;
 	struct drm_gem_object *obj;
 	struct xe_bo *bo;
+	LLIST_HEAD(deferred);
 	unsigned int id;
 	u32 mem_type;
 
@@ -215,11 +216,14 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 	list_for_each_entry(bo, &client->bos_list, client_link) {
 		if (!kref_get_unless_zero(&bo->ttm.base.refcount))
 			continue;
+
 		bo_meminfo(bo, stats);
-		xe_bo_put(bo);
+		xe_bo_put_deferred(bo, &deferred);
 	}
 	spin_unlock(&client->bos_lock);
 
+	xe_bo_put_commit(&deferred);
+
 	for (mem_type = XE_PL_SYSTEM; mem_type < TTM_NUM_MEM_TYPES; ++mem_type) {
 		if (!xe_mem_type_to_name[mem_type])
 			continue;
-- 
2.46.0


