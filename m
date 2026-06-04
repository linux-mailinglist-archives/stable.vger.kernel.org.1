Return-Path: <stable+bounces-260362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hnEFLCdMIWoWCwEAu9opvQ
	(envelope-from <stable+bounces-260362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 11:57:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F963EBDB
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 11:57:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=a53XU4z1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260362-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260362-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD0C930053D6
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626FD37756F;
	Thu,  4 Jun 2026 09:50:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5CA36BCDD
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 09:50:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566652; cv=none; b=qtZx/6Ng4W58zm1mAdugcP8RiH7ME+RSxOiYetX9T7mxubtu+pEW1lAtu7ucWSqKZm7SsiPHCoI+l3BODWANyhL3Zem1v0n7xE4XY3f69+LLDe2fe9+tYifTc59hUpGbboWyl/63fPBKMKfMPwkYNnBBTFRV5g8GhpjsRdHGk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566652; c=relaxed/simple;
	bh=Jza6mxy5CFobueQBU5MXCjifhlqHrSL/hJl4KW3I3GE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPMz8WR5TrNWE89Q1OIOwgkbPQ15Ddzzx1NMlDvf+4J8j6WErDecKbCRz8d/nV69cBlnJjy4di9NCF0O57U5iSvqM0AWDXsWvZ43RBtcHt9SivmJWSPGAoLwH2waXXTZuH04qDihhZFxRJ7HWajUsHRpbwJvR6os7WFscEkfCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a53XU4z1; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780566651; x=1812102651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jza6mxy5CFobueQBU5MXCjifhlqHrSL/hJl4KW3I3GE=;
  b=a53XU4z1jyPiSGFgfWVVJLDbqxWP65x0gS4RjEJPx1RhViBXSQUT/7Xl
   LrKqogeuCi5vb58jwV8WvSUr3ObPFBZ5msu+58A4+r0OE52zM5UU1+Sy/
   bhI6zDQSrUVfPkBxEOQ931wA7yvYGEfqGRCjy256sjj4uI+ne6zvRuPHj
   FQG5nZ2d7a1kl2uwjkpTOosFADdRQmjY7SyFy8eJQ1/T3TG06jO8aIMOw
   jcW50PEACUf4CSaczJtkRbC8GTuT6aIrcruCykxzTQw0yMddAIAQ5Ez9+
   X+LqTrPdYvwfULv8hoGo8y6t1n7lJvOi8p6oqNn4gg18yIDYqWS1ExkX0
   g==;
X-CSE-ConnectionGUID: VWZmcW3bRce7ix+iDjuHzA==
X-CSE-MsgGUID: MRgDzycXT8ev6jpxEI1QLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92876470"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92876470"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:50:51 -0700
X-CSE-ConnectionGUID: nbYgU2gvQtKiXV+nwwsq0A==
X-CSE-MsgGUID: EzyxdFuAR4CpVCD/9AcPXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="249423464"
Received: from nitin-super-server.iind.intel.com ([10.190.238.72])
  by orviesa005.jf.intel.com with ESMTP; 04 Jun 2026 02:50:49 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
	Nitin Gote <nitin.r.gote@intel.com>,
	stable@vger.kernel.org,
	Christian Konig <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH] drm/amdgpu: Fix UAF in amdgpu_gem_prime_import() on attach failure
Date: Thu,  4 Jun 2026 15:56:37 +0530
Message-ID: <20260604102636.1816829-2-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260362-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:nitin.r.gote@intel.com,m:stable@vger.kernel.org,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:matthew.auld@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nitin.r.gote@intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[nitin.r.gote@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 020F963EBDB

amdgpu_dma_buf_create_obj() creates the importer BO with obj->resv
pointing at the exporter's dma_buf->resv. If dma_buf_dynamic_attach()
fails, no dma_buf reference is held and the exporter can be freed
before ttm_bo_delayed_delete() runs, causing a UAF on dma_resv_lock().

Switch obj->resv to the BO's private _resv under lru_lock before
dropping the last reference, mirroring ttm_bo_individualize_resv().
The BO carries no fences and is not yet visible to other users, so
the switch is safe.

This is the amdgpu counterpart to the xe fix:
  ("drm/xe: Fix UAF in xe_gem_prime_import() on attach failure")

Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
Cc: stable@vger.kernel.org # v6.8+
Cc: Christian Konig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
---
Hi,
This is the amdgpu counterpart to the xe fix:
  ("drm/xe: Fix UAF in xe_gem_prime_import() on attach failure")
  https://patchwork.freedesktop.org/series/167647/
- Nitin

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..6a24cf2e3666 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -568,6 +568,16 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 	attach = dma_buf_dynamic_attach(dma_buf, dev->dev,
 					&amdgpu_dma_buf_attach_ops, obj);
 	if (IS_ERR(attach)) {
+		/*
+		 * Attach failed with no dma_buf ref held; switch resv to the BO's
+		 * private _resv under lru_lock before the last put, so
+		 * ttm_bo_delayed_delete() doesn't dereference the stale exporter
+		 * resv.
+		 */
+		spin_lock(&gem_to_amdgpu_bo(obj)->tbo.bdev->lru_lock);
+		obj->resv = &obj->_resv;
+		spin_unlock(&gem_to_amdgpu_bo(obj)->tbo.bdev->lru_lock);
+
 		drm_gem_object_put(obj);
 		return ERR_CAST(attach);
 	}
-- 
2.50.1


