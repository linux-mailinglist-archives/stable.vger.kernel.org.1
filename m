Return-Path: <stable+bounces-709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65EF7F7C37
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A0E1C21123
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522433A8C6;
	Fri, 24 Nov 2023 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ogjUYH1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5039FD9;
	Fri, 24 Nov 2023 18:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DFAC433C7;
	Fri, 24 Nov 2023 18:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849578;
	bh=PPxmiGde53q7KpD3JjjHbta8U+5CjOQ68eYervnT4Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0ogjUYH1iTteHKtHueXwDP78R7bgVqyC2mMqP5pkzv3tBSYuDfh5ePnd669MY5LCA
	 Y3oLlxHfFRCzYG0W8zyBH1M6YgrkuvOt0UyapwiI9YIL753BRvjm1rlRf/kOJDMt9z
	 Ys7c2EXDgR+fvbj2wezmvsRZ6XsGKXAXyXtoPzfA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 6.6 237/530] i915/perf: Fix NULL deref bugs with drm_dbg() calls
Date: Fri, 24 Nov 2023 17:46:43 +0000
Message-ID: <20231124172035.266264998@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

commit 471aa951bf1206d3c10d0daa67005b8e4db4ff83 upstream.

When i915 perf interface is not available dereferencing it will lead to
NULL dereferences.

As returning -ENOTSUPP is pretty clear return when perf interface is not
available.

Fixes: 2fec539112e8 ("i915/perf: Replace DRM_DEBUG with driver specific drm_dbg call")
Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231027172822.2753059-1-harshit.m.mogalapalli@oracle.com
[tursulin: added stable tag]
(cherry picked from commit 36f27350ff745bd228ab04d7845dfbffc177a889)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_perf.c |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4286,11 +4286,8 @@ int i915_perf_open_ioctl(struct drm_devi
 	u32 known_open_flags;
 	int ret;
 
-	if (!perf->i915) {
-		drm_dbg(&perf->i915->drm,
-			"i915 perf interface not available for this system\n");
+	if (!perf->i915)
 		return -ENOTSUPP;
-	}
 
 	known_open_flags = I915_PERF_FLAG_FD_CLOEXEC |
 			   I915_PERF_FLAG_FD_NONBLOCK |
@@ -4666,11 +4663,8 @@ int i915_perf_add_config_ioctl(struct dr
 	struct i915_oa_reg *regs;
 	int err, id;
 
-	if (!perf->i915) {
-		drm_dbg(&perf->i915->drm,
-			"i915 perf interface not available for this system\n");
+	if (!perf->i915)
 		return -ENOTSUPP;
-	}
 
 	if (!perf->metrics_kobj) {
 		drm_dbg(&perf->i915->drm,
@@ -4832,11 +4826,8 @@ int i915_perf_remove_config_ioctl(struct
 	struct i915_oa_config *oa_config;
 	int ret;
 
-	if (!perf->i915) {
-		drm_dbg(&perf->i915->drm,
-			"i915 perf interface not available for this system\n");
+	if (!perf->i915)
 		return -ENOTSUPP;
-	}
 
 	if (i915_perf_stream_paranoid && !perfmon_capable()) {
 		drm_dbg(&perf->i915->drm,



