Return-Path: <stable+bounces-177660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8868B4295E
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 21:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9467C68846E
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C76285C8D;
	Wed,  3 Sep 2025 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgzVoA7+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9929BD96
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926087; cv=none; b=kMR/ShXJpp4xC6+WizBII5KxJESDfMMixJFKWLqhhq0d3u3hXqWrjKpl9AtQ1mevfUpPCI1lhDdjFaxMiT8uABUymDW5RJZIN+KQ6+8tKcEMqHJeXi1fPE4XYg0vTYe1SgzuE5RGy4ROwBrgXke6k8vstpb46AImEDoIzutnkvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926087; c=relaxed/simple;
	bh=oiBP09MzivTYuMP9xSjheywMRGc0iJ5ONAkLW0tSqKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUksCp7DQvIyncgdZb/98rHZfQULkd+ctZ3pPOUK+UuFDfymKSA9NsquDEWXjs5Rb6q4DNEPlhR6aQxjmB9woXipM8dIbOOAz3YpIpfphwxsayBC+X2pVAtZsf7ljPMTQbaPa3XvdTiawUXR9gguYVQlsl1cBj5zGAdfglTosLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgzVoA7+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756926087; x=1788462087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oiBP09MzivTYuMP9xSjheywMRGc0iJ5ONAkLW0tSqKw=;
  b=LgzVoA7+0l1D08AVfin7tkz/ZyDqNwyaqpU2O7hYKaelwdXNR/6rzATx
   84pipXJXlLQOy8StTDHhwq41y8djq/0jg+rvnAokNr2FPx3Qn5yQJnajj
   dMzELiGaCZYuTbz9UvSK2nL2hTdkTGhVLYORGpxFXQK2Ka+tTtm4nUEf+
   FBCu9xe2w6QtfqPOJGU3ZH8spXs/H9l6z0+tPFNYYWMMGOSi1JM5+7XBb
   UFf517qbwyFNI+eVoT9UQw7XAxbPenjN5m2OXoY6cLu2hesZC8AMX8x9f
   AZOudtu/h0ATi8J90PDCJyXk15Vvkkz9AGdmPPVvJCToKN8plX9jjfHgs
   w==;
X-CSE-ConnectionGUID: b89H3EqLQCWZvUTfwULtvg==
X-CSE-MsgGUID: KfkDg0nrSomVPHP0xHbpzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="76699147"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="76699147"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 12:01:26 -0700
X-CSE-ConnectionGUID: mdgzj/LMRhGGDL0Xx7F+bQ==
X-CSE-MsgGUID: l773jjMHQASX763IxktqEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="208869056"
Received: from bfilipch-desk.jf.intel.com ([10.165.21.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 12:01:25 -0700
From: Julia Filipchuk <julia.filipchuk@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Julia Filipchuk <julia.filipchuk@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Stuart Summers <stuart.summers@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/xe: Extend Wa_13011645652 to PTL-H, WCL
Date: Wed,  3 Sep 2025 12:00:38 -0700
Message-ID: <20250903190122.1028373-2-julia.filipchuk@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903181552.1021977-2-julia.filipchuk@intel.com>
References: <20250903181552.1021977-2-julia.filipchuk@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Expand workaround to additional graphics architectures.

Fixes: dddc53806dd2 ("drm/xe/ptl: Apply Wa_13011645652")
Cc: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Cc: Stuart Summers <stuart.summers@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Julia Filipchuk <julia.filipchuk@intel.com>
---
 drivers/gpu/drm/xe/xe_wa_oob.rules | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index e990f20eccfe..710f4423726c 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -30,7 +30,8 @@
 16022287689	GRAPHICS_VERSION(2001)
 		GRAPHICS_VERSION(2004)
 13011645652	GRAPHICS_VERSION(2004)
-		GRAPHICS_VERSION(3001)
+		GRAPHICS_VERSION_RANGE(3000, 3001)
+		GRAPHICS_VERSION(3003)
 14022293748	GRAPHICS_VERSION_RANGE(2001, 2002)
 		GRAPHICS_VERSION(2004)
 		GRAPHICS_VERSION_RANGE(3000, 3001)
-- 
2.50.1


