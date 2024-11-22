Return-Path: <stable+bounces-94662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4059D652F
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1232282AB2
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACF71DFDBB;
	Fri, 22 Nov 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTJCKVWp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D401DF72C
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309674; cv=none; b=NAER1QlI8uua+Ba/gRq2u45YYy8xx2y9jwVuo41fecZ7ngxRysnV5LGeU5V9qM65f0O8c4zUiCyrrB+TLVC85R6/w43DT4dlH0kEZkvyj06w3SAQ/6MdJRlsUG2ejqV5+lszeer6pLIK+8Kz1NksTMA2gVWIqCCBfrifUPBxDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309674; c=relaxed/simple;
	bh=tXTmSp8atrxXCImrr9m0ac7rIOr9uSvRno6c7mMssd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKTHBVwOsdSdTMiKqSfhdBkjP0g9gYdZkjwxNfScvBapgE14Sc7MjwJYcp9eGL7uCi3PQ3nUFFIKvRt2zWEbOWH0i9zrKQlm7H17UpuWlhxptnhUq18Jc1sV9iQ59QZg+MKC5hDICd/5KkK3uVzuVrfjaq+kHz6WMGaTI1xpbVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTJCKVWp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309673; x=1763845673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tXTmSp8atrxXCImrr9m0ac7rIOr9uSvRno6c7mMssd4=;
  b=aTJCKVWpGS8HVx/t+niF+kjGzC7SPeUU4UQcgwKDQJn7UZ121Kr6yZsh
   f880VzUutJNlmJFAjaW24pL3FDIyfXekWfAlT2RT+oJfy38J8jKIkOm9P
   IxIU4kDYKPHP1+0U6CArQupBfGMsN2OnO7dGxJNJLnOuX2wpS1yU/RnLr
   Zw1SZVkUeXrCArPKg2zMqAziK4NIRs0Gzyml5CWrCeZ5f9NBrE2xgLXk1
   Tp29rllteo5rWjZvtTA0VD/jWX5kvnAuG0wroUz44hMHqGS0/qfyJdjaJ
   otdI/leQnlvVZMBRocqOoNsHaa8vCjuaCeFJy1vQ7/JQI+XHL3Qzq2PoN
   Q==;
X-CSE-ConnectionGUID: kio52VjDTtyLTW8ZEfCq5A==
X-CSE-MsgGUID: dsdayEUbSJyJXCRoCCt7FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878281"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878281"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:43 -0800
X-CSE-ConnectionGUID: kdtbzhmHRxGs12IYtuY5JA==
X-CSE-MsgGUID: UxaIOfxFTG2EkiZCOXlzFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457285"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:43 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 25/31] drm/xe/queue: move xa_alloc to prevent UAF
Date: Fri, 22 Nov 2024 13:07:13 -0800
Message-ID: <20241122210719.213373-26-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Auld <matthew.auld@intel.com>

commit 67801fa67b94ebd0e4da7a77ac2d9f321b75fbe0 upstream.

Evil user can guess the next id of the queue before the ioctl completes
and then call queue destroy ioctl to trigger UAF since create ioctl is
still referencing the same queue. Move the xa_alloc all the way to the end
to prevent this.

v2:
 - Rebase

Fixes: 2149ded63079 ("drm/xe: Fix use after free when client stats are captured")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240925071426.144015-4-matthew.auld@intel.com
(cherry picked from commit 16536582ddbebdbdf9e1d7af321bbba2bf955a87)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 2179c65dc60ab..c031334a6d2a2 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -627,12 +627,14 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	q->xef = xe_file_get(xef);
+
+	/* user id alloc must always be last in ioctl to prevent UAF */
 	err = xa_alloc(&xef->exec_queue.xa, &id, q, xa_limit_32b, GFP_KERNEL);
 	if (err)
 		goto kill_exec_queue;
 
 	args->exec_queue_id = id;
-	q->xef = xe_file_get(xef);
 
 	return 0;
 
-- 
2.47.0


