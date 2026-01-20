Return-Path: <stable+bounces-210494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJmVGwe2cGndZAAAu9opvQ
	(envelope-from <stable+bounces-210494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:18:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C804555E1C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6099A623894
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A59423159;
	Tue, 20 Jan 2026 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQ1yvQIT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F38423147
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908835; cv=none; b=AuqNfihEE5QQ6hDtvGekmAv22MHX689VGUpItDH/13xGufYrOpYyJnIWZzZ6AXC5Uyox8mWOcOyaGm09+OCkCfhR51z/1+gRz2Zm9gJBkBQ0gEKhmXliUQEiLn93cMZy/Mqv3zsQrAuuLnK3TiooOqUhsjrMRlSVlr4zA2bzV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908835; c=relaxed/simple;
	bh=obiA0RdxAzzBdnYWKJjLTKVGGmDVgD8345kRpekIAe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jygU6bdPRgw6BDPM0D7gdE1tGWFUgv+MXE5n4J3uFTVl+2NH4TuWYjpVDK4G5VdHKUCzwqzGBpkqnf1sLm2LjicYZoXtT7uVzqOyjrYk9bufrQkX/8ULdxFpH2U96DmAU5ZLqOBTMAK3SNfyIF4xKiS6vXugQ+6McCzdxJNZd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQ1yvQIT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768908832; x=1800444832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obiA0RdxAzzBdnYWKJjLTKVGGmDVgD8345kRpekIAe8=;
  b=BQ1yvQITsgVvMqC6BkEnRw5UaGFgu8E2RzNecBeuY5OdLGokI57xX5Gv
   VVJaVAKQWAzELh6oCovOB8WuD4suPS04jo9BWoLzq0eU0zycssRXNQ5aB
   aBD4Q8lUPP1sdMxtrvYdlxW9Xe1rCD1tcuI9nHQrKBG7DyH6QxZfsJZJp
   mdqvj7t6j+X5mCtk6yPmtBcwjb3OVmcc+2m67vNB8xkkmlkmHaJr44NCU
   AwmyBtlvopla16PSWFItIWEMWm1wIP14oWyuVyAvDhhBHAmkZlIPEwdXt
   5CD6QepChl7LHDtVF7U9pDY4CRV1vojpF8yZbo0vesrQkhjN7ZhfgZRVH
   Q==;
X-CSE-ConnectionGUID: lC16HZMDQWahctaik8ZnPw==
X-CSE-MsgGUID: WOkrs24zTu+paRxl0cMykQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73969541"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73969541"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 03:33:51 -0800
X-CSE-ConnectionGUID: Cg2fbXg7TNiYH0OMXPQozA==
X-CSE-MsgGUID: SEMddDTXTa2O0MmKSX9Dug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206449910"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora) ([10.245.244.250])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 03:33:48 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Dafna Hirschfeld <dafna.hirschfeld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm, drm/xe: Fix xe userptr in the absence of CONFIG_DEVICE_PRIVATE
Date: Tue, 20 Jan 2026 12:33:21 +0100
Message-ID: <20260120113322.97654-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120113322.97654-1-thomas.hellstrom@linux.intel.com>
References: <20260120113322.97654-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-210494-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:email,intel.com:dkim,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: C804555E1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CONFIG_DEVICE_PRIVATE is not selected by default by some distros,
for example Fedora, and that leads to a regression in the xe driver
since userptr support gets compiled out.

It turns out that DRM_GPUSVM, which is needed for xe userptr support
compiles also without CONFIG_DEVICE_PRIVATE, so remove that
dependency from CONFIG_DRM_GPUSVM and the xe driver's selection of
it, re-enabling xe userptr for those configs.

Fixes: 9e9787414882 ("drm/xe/userptr: replace xe_hmm with gpusvm")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Dafna Hirschfeld <dafna.hirschfeld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/Kconfig    | 2 +-
 drivers/gpu/drm/xe/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index a33b90251530..d3d52310c9cc 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -210,7 +210,7 @@ config DRM_GPUVM
 
 config DRM_GPUSVM
 	tristate
-	depends on DRM && DEVICE_PRIVATE
+	depends on DRM
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	help
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4b288eb3f5b0..c34be1be155b 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -39,7 +39,7 @@ config DRM_XE
 	select DRM_TTM
 	select DRM_TTM_HELPER
 	select DRM_EXEC
-	select DRM_GPUSVM if !UML && DEVICE_PRIVATE
+	select DRM_GPUSVM if !UML
 	select DRM_GPUVM
 	select DRM_SCHED
 	select MMU_NOTIFIER
-- 
2.52.0


