Return-Path: <stable+bounces-217516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB84EgmDl2nozQIAu9opvQ
	(envelope-from <stable+bounces-217516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:39:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBF9162E58
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF7043005332
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAC432AAAF;
	Thu, 19 Feb 2026 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhKZbd6T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD932C1589
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537155; cv=none; b=Zla/LsX43eiC0C8NaX6kHQEdUYwDXclIW7eXK+aYcHi9Sm3V7xxC0aYgwUZa18nzMoASMVJ6XKvv60sMccUmK9ttteeZnPRanfFCG7Jxy8mvs3/lJbO8k894EPmo85grHCskL5ulxnwGw1TdLAGwBiAhhWJIohK5lC2U7ub8k9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537155; c=relaxed/simple;
	bh=wK+Scgt8j3rIrrQZOnPqpfwtY7Bs7Ykzl2GsolcF4pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YD6xSCGJQTlgurFvkAsNtUoPBy6uEDk3+4QU8Nv3KGJY6/9jMC6CFUrNyV3UtLWo4cfnvfh2C/19CgFZj/q8dx07XIxmmfXASPynGGo28DdM1GSR48qrhN1n5AgOBcJwENjt2a0OL0pguX562fMzlPRQVo0eBtex+rBOAQ+PH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhKZbd6T; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771537154; x=1803073154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wK+Scgt8j3rIrrQZOnPqpfwtY7Bs7Ykzl2GsolcF4pE=;
  b=KhKZbd6T28p/prsJK4ngzzKBqco0cctdlqS2q3tiv8wW/63PkYciow2b
   xsJChUam98zjU9VD0SbzeLPLlxY6i/heILthQ6aXR8TQzBsi18TC2OC2E
   n4+sWDWscQ43G1BCL2JagU6vYO0oGcJF+UbNYMqF1qxDW5FsBIp+iQ4uC
   10685QsS8iRj3RtDHE5IqAgiHtf6kHgzYRV4x8SJAtDWGz3/if4ZE6agy
   4XbufDG7gmBwPdewX/Q547lrOa6cJy/cdpvVgqmSB9+FrGjKqzOVVnPL4
   xmzF7Z6rpl4vlvrfiOCYbG8ZHvbywaSslKYzkcSjWg6Kdx224ETT0pbb+
   Q==;
X-CSE-ConnectionGUID: e6FIot1yRR+TIwC0+UeeuQ==
X-CSE-MsgGUID: NJX2x4zlQ9+tBfetZGlyzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="90044686"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="90044686"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:39:13 -0800
X-CSE-ConnectionGUID: gtHPjQtoSJa3b1uR+5so7A==
X-CSE-MsgGUID: 61cknzkbQLKQNQi5iZHX6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="212526345"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kkoning-desktop.intel.com) ([10.245.244.197])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:39:10 -0800
From: Koen Koning <koen.koning@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Koen Koning <koen.koning@linux.intel.com>,
	Dave Airlie <airlied@redhat.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] gpu/buddy: fix module_init() usage
Date: Thu, 19 Feb 2026 22:38:56 +0100
Message-ID: <20260219213858.370675-2-koen.koning@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260219213858.370675-1-koen.koning@linux.intel.com>
References: <20260216111902.110286-1-koen.koning@linux.intel.com>
 <20260219213858.370675-1-koen.koning@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217516-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[koen.koning@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,nvidia.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 5EBF9162E58
X-Rspamd-Action: no action

Use subsys_initcall() instead of module_init() (which compiles to
device_initcall() for built-ins) for buddy, so its initialization code
always runs before any (built-in) drivers.
This happened to work correctly so far due to the order of linking in
the Makefiles, but this should not be relied upon.

An incorrect initialization order could lead to built-in drivers that
use the buddy allocator to run into NULL pointer dereferences due to
slab_blocks being uninitialized.

Fixes: 6387a3c4b0c4 ("drm: move the buddy allocator from i915 into common drm")
Fixes: ba110db8e1bc ("gpu: Move DRM buddy allocator one level up (part two)")
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Peter Senna Tschudin <peter.senna@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Koen Koning <koen.koning@linux.intel.com>
---
 drivers/gpu/buddy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 603c59a2013a..81f57fdf913b 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1315,7 +1315,7 @@ static int __init gpu_buddy_module_init(void)
 	return 0;
 }

-module_init(gpu_buddy_module_init);
+subsys_initcall(gpu_buddy_module_init);
 module_exit(gpu_buddy_module_exit);

 MODULE_DESCRIPTION("GPU Buddy Allocator");
--
2.48.1


