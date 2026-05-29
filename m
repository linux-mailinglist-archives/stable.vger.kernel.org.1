Return-Path: <stable+bounces-256748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Zl2NNXnrGWrDzwgAu9opvQ
	(envelope-from <stable+bounces-256748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:39:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FA607F12
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37157300EF4F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD323AB26E;
	Fri, 29 May 2026 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4whHkhd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680E342146
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083381; cv=none; b=GCq8gUnSxg6evc6zJJ6ct8392eT9o3yIkBEX+G34D+Or4WAVrzOpSm5U54Sy8/R5bRe/Gx4YprqUvLSnrnXfniFk5rexWsd16BFCFy/w/n+8t1Z73sw46eB2gJaR9MMtmjjz1kDYfZwAPtyzGAl7XPw8V6uZvRwgnXlx0ivbl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083381; c=relaxed/simple;
	bh=e3kOtgzYw2xQxmpZ91WjyUnOzp7OCHFpDyOxrPwi3pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ybq9M//PlzuOO9xg1n+u7ZeRMxLLqrJeROtrzd3ANvMGUDM4chTDdnQGv2adI8zzqJY4o9IQ6B0+FpIO7vUYFs5hAO34XWWOw/+4Ox9+TDwF6EhGaf1B+9Sc5ArxrSISI8Phhy0U9PtxKbt5SPf3QVDHJ7ZxYzlityNamwkFGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4whHkhd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780083380; x=1811619380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3kOtgzYw2xQxmpZ91WjyUnOzp7OCHFpDyOxrPwi3pQ=;
  b=c4whHkhdesyOC7QwX+99DBXiaKsXh66HhnBmrP+RQeTE/mRH5/pRZ87h
   2yyAbqi/khlbYFBTu0YRNKTflYxjFoEww++VmndRYB/uebPL4viMMmYUB
   lAmWk54uh+r6GcTXydy6yT8WrSCqeT7F33qxrggFNg77QBT3T9S++dcb8
   fJuc0UaDl5ePi7V+fWnz5xbSRTPdnPYO83iobGDWR52dJLrMsCn6zeOHi
   2kQRNB8mpmMQcE+HJovYgQJ5201y1sN11f7HtNzaX/hB6l6Ydf9s0q71y
   uL8aBa8fsU6l6DD4QsG7nS7GsHA5hEG3RVbO7AnX4tdJOq4ACi42XsJHj
   w==;
X-CSE-ConnectionGUID: WK9BqOBbTZqj74a8u9qWiA==
X-CSE-MsgGUID: QPsf/d0hSjO8RewP9Sc+GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80969687"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="80969687"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 12:36:20 -0700
X-CSE-ConnectionGUID: 6KB4RK6hRaWxFXH8SkwyAg==
X-CSE-MsgGUID: Y+WfoSaSTb+ViONW24SoHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="246943916"
Received: from valcore-skull-1.fm.intel.com ([10.1.39.17])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 12:36:20 -0700
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/6] Revert "drm/xe/nvls: Define GuC firmware for NVL-S"
Date: Fri, 29 May 2026 12:36:02 -0700
Message-ID: <20260529193558.185436-11-daniele.ceraolospurio@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529193558.185436-8-daniele.ceraolospurio@intel.com>
References: <20260529193558.185436-8-daniele.ceraolospurio@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256748-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[daniele.ceraolospurio@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 320FA607F12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit 4e88de313ff4d1c67b644b1f39f9fb4089711b71.

The early GuC FW definition meant for our CI branch was accidentally
merged to the drm-xe-next branch instead. This GuC FW will never be
released to linux-firmware, so we do not want the definition to be
available in the mainline Linux codebase.

Fixes: 4e88de313ff4 ("drm/xe/nvls: Define GuC firmware for NVL-S")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Julia Filipchuk <julia.filipchuk@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v7.0+
---
 drivers/gpu/drm/xe/xe_uc_fw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_uc_fw.c b/drivers/gpu/drm/xe/xe_uc_fw.c
index 70bccbc1af82..498c89452779 100644
--- a/drivers/gpu/drm/xe/xe_uc_fw.c
+++ b/drivers/gpu/drm/xe/xe_uc_fw.c
@@ -115,7 +115,6 @@ struct fw_blobs_by_type {
 #define XE_GT_TYPE_ANY XE_GT_TYPE_UNINITIALIZED
 
 #define XE_GUC_FIRMWARE_DEFS(fw_def, mmp_ver, major_ver)					\
-	fw_def(NOVALAKE_S,	GT_TYPE_ANY,	mmp_ver(xe,	guc,	nvl,	70, 55, 4))	\
 	fw_def(PANTHERLAKE,	GT_TYPE_ANY,	major_ver(xe,	guc,	ptl,	70, 54, 0))	\
 	fw_def(BATTLEMAGE,	GT_TYPE_ANY,	major_ver(xe,	guc,	bmg,	70, 54, 0))	\
 	fw_def(LUNARLAKE,	GT_TYPE_ANY,	major_ver(xe,	guc,	lnl,	70, 53, 0))	\
-- 
2.43.0


