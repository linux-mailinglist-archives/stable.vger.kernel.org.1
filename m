Return-Path: <stable+bounces-194648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC5C54CEC
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 00:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A4E034677A
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3742B9A8;
	Wed, 12 Nov 2025 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnUCZsma"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE435CBC1
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762990242; cv=none; b=rvqvaziiv1n/QKD9QzmMRGCuyJTAUjDQkaEsr1kKJYEOWvZpWVfbRKfYBurDTG9xT+QjbR/iPzb2fM5TgLSoZbC5a8WzYfWEd3qdhebQ/0lIq89le5+ukMHh1kbP5bDi3J8vrpUK/PLgrviHjWMA1ML8iDnZdl3mFUT7XoWA0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762990242; c=relaxed/simple;
	bh=HO7JzJrnrDHgSh3Yk1HpIsh58uszbgjpgvQtMGOlzwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIk/MtMpqVM0xpW/BvQqCYpDMylgy3BtoQJ+l17V2mJ+F8c7eXh5NoefkFLbPfyGzP7e6an/gy6htP/cHqN+0XgZDG3Fksr1dC3M8rLYW6Hd2Y7kX6ckfVjzy5CDRBI/0/afIfkgwHe3wW8MvFZvBZEiQU60lZJ0ICsNotgkCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnUCZsma; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762990240; x=1794526240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HO7JzJrnrDHgSh3Yk1HpIsh58uszbgjpgvQtMGOlzwU=;
  b=NnUCZsmafQvxnsuLzi+AF+Dq2UE3IQEIl15b9rUIGhLcscv/WnDAn3n/
   mBeZiGPO6UnPT8yeJd37DU+b5ZSoE06leLq2gLH/JzgaCG9PXwmygJvrB
   N/9+G8UXgpeZxYODvcoTwmZyN9qbjbKx310zU0xnntG319EKLj6A2JF/v
   ohp2j12BpK6yCF4DyDIO/tr+ExNJ2K7OmqL3s9+ARqNTcB2dVPojvrHXu
   EsV9TLXZKvlzAcVVQ309RYw36D6xjXvkuKOMdlkJ5qRMD08qgaO93NQQ9
   39mAPr/nqc3HDikLni2rVNOyyW+fSGqOFpAqSYal6h+BaRaOmqSEhoMmu
   A==;
X-CSE-ConnectionGUID: H9N5GuzuTyCv4EcrpzqtvA==
X-CSE-MsgGUID: lRY+S1JpQX2BSCzSo5yycg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="75373174"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="75373174"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 15:30:39 -0800
X-CSE-ConnectionGUID: +TUXNKraTM+n9FXGEN8/tA==
X-CSE-MsgGUID: 8WYBhMOWQG+Txld2BwuKgQ==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 15:30:38 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Arun R Murthy <arun.r.murthy@intel.com>
Subject: [PATCH 1/3] drm/plane: Fix create_in_format_blob() return value
Date: Thu, 13 Nov 2025 01:30:28 +0200
Message-ID: <20251112233030.24117-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251112233030.24117-1-ville.syrjala@linux.intel.com>
References: <20251112233030.24117-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

create_in_format_blob() is either supposed to return a valid
pointer or an error, but never NULL. The caller will dereference
the blob when it is not an error, and thus will oops if NULL
returned. Return proper error values in the failure cases.

Cc: stable@vger.kernel.org
Cc: Arun R Murthy <arun.r.murthy@intel.com>
Fixes: 0d6dcd741c26 ("drm/plane: modify create_in_formats to acommodate async")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 38f82391bfda..a30493ed9715 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -210,7 +210,7 @@ static struct drm_property_blob *create_in_format_blob(struct drm_device *dev,
 	formats_size = sizeof(__u32) * plane->format_count;
 	if (WARN_ON(!formats_size)) {
 		/* 0 formats are never expected */
-		return 0;
+		return ERR_PTR(-EINVAL);
 	}
 
 	modifiers_size =
@@ -226,7 +226,7 @@ static struct drm_property_blob *create_in_format_blob(struct drm_device *dev,
 
 	blob = drm_property_create_blob(dev, blob_size, NULL);
 	if (IS_ERR(blob))
-		return NULL;
+		return blob;
 
 	blob_data = blob->data;
 	blob_data->version = FORMAT_BLOB_CURRENT;
-- 
2.49.1


