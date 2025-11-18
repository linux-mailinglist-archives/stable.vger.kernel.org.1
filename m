Return-Path: <stable+bounces-195125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E946C6B604
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 20:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 59B1B29146
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E372DF700;
	Tue, 18 Nov 2025 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZA3cOtr2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF72580FB
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492934; cv=none; b=tXyrYACkvDb1MIM/OP+qbpiqU7VaIfkhyt0tZ4HhNsWYnc8dLwLxPtAGqy3G17UAXYzEBeMEwP5Sh4RxN+BYSgn/NP1Iu2YL+aVdVaGhAxH80L7So933LUMSZzYL0Daiv5umBn05Q/6MgPTQEwZUflpuYPQrUMQbKIyCM9/9x9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492934; c=relaxed/simple;
	bh=Cni6jgkDLCAjuZvwZrPhmhE31USxSqAefGCfJO3o7A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g0bc3sd8ke0agkqDmWfASuPf3zxM1zdheYEpnP8O9rkoFMMpIfcCgEpxbNSaBqD5upVfwQqEizb+8fZuaMQa1wDO8EuXSQ1d5sz91nEmyjXzfk9XDQDmN/JANGD/z2iVnJjCQflGlmFYyCLUC1wgIieFvR2/qqorY5smbCrNwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZA3cOtr2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763492933; x=1795028933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cni6jgkDLCAjuZvwZrPhmhE31USxSqAefGCfJO3o7A0=;
  b=ZA3cOtr2nx6wIqmL9t3t/1xV4eZqDlGY583/5TLoT6KFCYBVfaiFmpXL
   hkd+iOFC5DRGFuVpJnE8seKxzsyoQ4u2Pz6uQDQQrlEPNy+07nPWKyOmh
   aS9hP/oU8Z02M20eLFJLNpsUsiH6fleiv+YBBi8wMTke6zaSUZlWTY0Bp
   nCut3TqcpWi18Wc2FNkCdmS4oP76epgNs/8dy7s/Xw85OWGS/GlsQSjGB
   UFpavlExjukgKGSMmh3VUi77pJr6QkF0vJIU0za8trYW7oXYQOU5X0Sz6
   KVKLP4L2ow2NYkBKbwrGm91tPGdsILs742mOUVKAFqQEyXt4sGAaEfFr/
   w==;
X-CSE-ConnectionGUID: 1x6M+CkYRNeH0XgCCmSywg==
X-CSE-MsgGUID: 9Uvg/m8iSI+XgnaXreEZYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="68132371"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="68132371"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:08:52 -0800
X-CSE-ConnectionGUID: rikn4uDrQ0WtVO8rSqZ8mw==
X-CSE-MsgGUID: pbpdNM9ZTCSGvFhJDuXRYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191627276"
Received: from lucas-s2600cw.jf.intel.com ([10.54.55.69])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:08:51 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Sagar Ghuge <sagar.ghuge@intel.com>,
	Stuart Summers <stuart.summers@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 0/2] drm/xe: Fix and refactor CONFIG_DRM_XE_DEBUG_GUC
Date: Tue, 18 Nov 2025 11:08:10 -0800
Message-ID: <20251118-fix-debug-guc-v1-0-9f780c6bedf8@intel.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251117-fix-debug-guc-3d79bbe9dead
X-Mailer: b4 0.15-dev-50d74
Content-Transfer-Encoding: 8bit

There was a missing call to stack_depot_init() that is needed
if CONFIG_DRM_XE_DEBUG_GUC is defined. That is fixed in the simplest
possible way in the first patch. Second patch refactors it to try to
isolate the ifdefs in specific functions related to CONFIG_DRM_XE_DEBUG
and CONFIG_DRM_XE_DEBUG_GUC.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
Lucas De Marchi (2):
      drm/xe/guc: Fix stack_depot usage
      drm/xe/guc_ct: Cleanup ifdef'ry

 drivers/gpu/drm/xe/xe_guc_ct.c | 204 +++++++++++++++++++++--------------------
 1 file changed, 107 insertions(+), 97 deletions(-)

base-commit: b603326a067916accf680fd623f4fc3c22bba487
change-id: 20251117-fix-debug-guc-3d79bbe9dead

Lucas De Marchi


