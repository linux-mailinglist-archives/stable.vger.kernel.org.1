Return-Path: <stable+bounces-223302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOlYL1BDqmkHOQEAu9opvQ
	(envelope-from <stable+bounces-223302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 04:00:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 427C321AD18
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 04:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E8343021E96
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 03:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7941D5147;
	Fri,  6 Mar 2026 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACRip35A"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF11F8691
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766029; cv=none; b=LJjZRU4QgHexyfv8vjmWMonhTsts1/4JgSkTCv2nHIP3h0WNdeV8U5ToYUeB5YPqQ32hrfYFz3pwaR51AkXVBOOeADdfx5jITPAYAV4+KEvqlckExU6rYhK/0+57FPGK8GVQca/il93DFigZWrWjH1mpTDCfeVCadlM7I5z1fwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766029; c=relaxed/simple;
	bh=WmrwkKBmSjGuRbsBTm45LQSRPfbDfnCqAtyfZjsZ1o4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VELf83jqkfPXKIZNvBHlCrWbLdwfpxlxSjWarLecwZR7NGbTUpP9Y03BdPZVDJ2WIK7S72u1xzfnuCxzeiq5FtqmxxDWI5IXtmAcIHDon+ZzwqeuQD9qlfOJ/SON5xmUB71JuwZZERcdsbzibJq7Qs7gnIwv3UZtL8JWj6eKbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACRip35A; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772766028; x=1804302028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WmrwkKBmSjGuRbsBTm45LQSRPfbDfnCqAtyfZjsZ1o4=;
  b=ACRip35Aia8jEDX7N56vXSVMws5+g+FRKjLeAMy3NGO/eAtaZWHVK+CI
   WO81Go0usmz/DqvqVgFRoHfVTgn5a0h89Xe1S2CTR8hkyCA8h8+6ZLY/l
   J46vljJwa6TcVI/f0LQTvrTbsiNwTqEmHZN9dQjEEQgYGQMP8PntucHC+
   kWFvjlEi//clYneNcctWOi+N6RXcEiYb/KlaJ8EsCnJ27pMIwwMfjkNhK
   a4Tz2gVV55uu/lq2cmvi3U6M0uH/cgwHqwE1waVdNtZ7OATvjbjJPte94
   WmKVytKgtVBkzhooiodWW4an0Uxufm+y99Xte6vPTTQal+Qxd2RwpTTek
   A==;
X-CSE-ConnectionGUID: ilrQ21tARP2FpyyQTLnE5g==
X-CSE-MsgGUID: 1cWsVsAeSfa87BzsyHnw6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73773773"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73773773"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 19:00:27 -0800
X-CSE-ConnectionGUID: SjenDhWZRn6vydBzBiXTTg==
X-CSE-MsgGUID: kn4wSYZCTTKv2J0QG0urMw==
X-ExtLoop1: 1
Received: from dut6079bmgfrd.fm.intel.com ([10.80.55.56])
  by fmviesa003.fm.intel.com with ESMTP; 05 Mar 2026 19:00:27 -0800
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Subject: [PATCH 1/2] drm/xe: Fix missing xe_hw_engine_group_del_exec_queue() in error path
Date: Fri,  6 Mar 2026 03:00:09 +0000
Message-Id: <20260306030010.11041-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306030010.11041-1-shuicheng.lin@intel.com>
References: <20260306030010.11041-1-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 427C321AD18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223302-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When xa_alloc() fails after xe_hw_engine_group_add_exec_queue() has
already succeeded, xe_hw_engine_group_del_exec_queue() is missed to
undo the add.

Add xe_hw_engine_group_del_exec_queue() at the kill_exec_queue label
to fix it.

Fixes: 7970cb36966c ("drm/xe/hw_engine_group: Register hw engine group's exec queues")
Cc: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>
Suggested-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 5c67185d5357..af915ccb4925 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -1408,6 +1408,8 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 	return 0;
 
 kill_exec_queue:
+	if (q->vm && q->hwe->hw_engine_group)
+		xe_hw_engine_group_del_exec_queue(q->hwe->hw_engine_group, q);
 	xe_exec_queue_kill(q);
 delete_queue_group:
 	if (xe_exec_queue_is_multi_queue_secondary(q))
-- 
2.34.1


