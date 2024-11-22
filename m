Return-Path: <stable+bounces-94655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6E09D6529
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BAD161420
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381C1DFD9E;
	Fri, 22 Nov 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFqbIQhu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EE156F3A
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309671; cv=none; b=IURFJgYlXxk9sO/h+97NtbBCutozXMSQMqstxpF4KF7mGESPTnO1S+XkEkraGhTy6CZUEBymdnAMymT0L2Hs++csADgtJjTJhr0JjS7u3aAHdHlh0ELXnVQMof0mfaWeud0ha1mjPWF+53leoBigHmRCpADcdN8zoHjoMNG1LlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309671; c=relaxed/simple;
	bh=wlsUxzA2Zxd7AGEHXlOn7mk5+9aZvv8oDHw2KYYsWVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ics/vHBPKQ3R5RolMX2ptfxvZNnMbOogIac9TyKPl3WzgAS/ZVR/IeQomLKhxpOEumrGRsV8Ix2eh1/pjTQLO5guJK1xAVLarBL9JEzaNNFKz/fct/bZM2kkCBEfzKs+fuj4CP83WN8e3xCk/qF8DJGsWHiXDmYZmiJZV7d5ZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFqbIQhu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309670; x=1763845670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wlsUxzA2Zxd7AGEHXlOn7mk5+9aZvv8oDHw2KYYsWVs=;
  b=mFqbIQhuObNgrc48qVzj++f3mH9pal45By/adPqGT4Z7QgDqxsxMrP7i
   ypasLPb1mFokLNs+WGwz38z9Srjv0O+wHBIzeoBV0vhbUVpmH7of6NKG6
   +gdoiRRVRi63t7oibsqAkEvpeEqoBm9AHlpgb0eBBVgXybRfiYSs+fZ5N
   TX94RS0/q/JXIKh3OJLBWTkFBCZ8L1ZANqi/mSO1Uwc0/GAfB8TSYM69F
   ZICHPjbv3dX8vWPMQJShK30VvcUZnSMkq24B6j94adWVJQh6HmrzsT+kv
   Pv0DdnwyryBTGm4QmUdzZ+9JyoIYWSknXTJSDV4Z6wzVF6dyooQ3uu60l
   A==;
X-CSE-ConnectionGUID: wfbwfFKXSeSTAotu2MaCug==
X-CSE-MsgGUID: iTSYKMj4SleSU/xokxgeHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878274"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878274"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
X-CSE-ConnectionGUID: t1Fz8AZrT427fWHaQ9igPg==
X-CSE-MsgGUID: hOerAtfGQrGLRHVUiZaCdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457256"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 18/31] drm/xe/display: Add missing HPD interrupt enabling during non-d3cold RPM resume
Date: Fri, 22 Nov 2024 13:07:06 -0800
Message-ID: <20241122210719.213373-19-lucas.demarchi@intel.com>
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

From: Imre Deak <imre.deak@intel.com>

commit bbc4a30de095f0349d3c278500345a1b620d495e upstream.

Atm the display HPD interrupts that got disabled during runtime
suspend, are re-enabled only if d3cold is enabled. Fix things by
also re-enabling the interrupts if d3cold is disabled.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241009194358.1321200-5-imre.deak@intel.com
(cherry picked from commit bbc4a30de095f0349d3c278500345a1b620d495e)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index b011a1e3ffa38..696e3cd716991 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -430,6 +430,7 @@ void xe_display_pm_runtime_resume(struct xe_device *xe)
 		return;
 	}
 
+	intel_hpd_init(xe);
 	intel_hpd_poll_disable(xe);
 }
 
-- 
2.47.0


