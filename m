Return-Path: <stable+bounces-192848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11010C44198
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 16:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8051886882
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEC22FE59A;
	Sun,  9 Nov 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xp+mNtUa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3782FF176;
	Sun,  9 Nov 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762703631; cv=none; b=W4yKsQYqC4wQS1kXAGAtwxV0omOqjkhzD2AkmS8MJquHlLJvQEB2KdG8z2oCXluy8ofcv8xBn+G3PDGFXdTkDwDj8lQJwLHLHHf4wEW5QRUV87t+D3ZCATbCnJyAQcb4FVlDyVo3uZndZSLmV5E41WzarUqyUGY3WhMZoqX3KFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762703631; c=relaxed/simple;
	bh=vtnr5JX3aZxFEhiZwU5mIn0IrYDu1XlOTGx7iqQVMMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4hB/pr6mNI4nmjNzOIG6FLnXcbZYCYVdDZaWYRIq7LRPRBIBkhaPT0z+kkyKMXqfub0g3keK4FAm/DTnvHUm+u7UW2a8l1lEtpcr0ZfD1hQCs6CMWr17YIoxk0RcF11n3ksuixo52OrukS6t1y/cGpi1AdagqoA4Kcu/nb1cDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xp+mNtUa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762703629; x=1794239629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vtnr5JX3aZxFEhiZwU5mIn0IrYDu1XlOTGx7iqQVMMk=;
  b=Xp+mNtUaSZNQ8pMMezGP32Z1ivn9JiOKItnMuQygNI0WcQtRj/J0WCwf
   rawbBGoH88wOUlQAkpmavivV+KT2R0oPBUnIDE2nFbkAnMtnWyLSgfTkU
   GOrbf/r2U2ShNtbHhRbrSSaV4i38Qehb6Fr+LToa1ZLgSi6RhvhJQSr6X
   gm4XGYvry9Wn9ZiAwgc934odjLxPll6HU7VqPoa7bGXWI26tTZvDwA2PF
   CEW8zhwQ2jdAglE1qsCdYFF/riAOY4Sq2Ssjca4pYvYsmvpDBWkeeyAoH
   TQhHf+m1WzXLs/i7RtmTv9KaFVX8RxzCiqW6fLl6ICw6zchqQnSnIHbw5
   w==;
X-CSE-ConnectionGUID: 6YAR+fY6Rn64XE7rwHIfFA==
X-CSE-MsgGUID: LqqiWjhwTIecidm7X5aipQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64702021"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64702021"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 07:53:49 -0800
X-CSE-ConnectionGUID: scdTOcjrSA6xB1Qe6TVcvQ==
X-CSE-MsgGUID: oM+HCqY8QMOLwDsbQ+KmlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="192586950"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 07:53:47 -0800
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	Junxiao Chang <junxiao.chang@intel.com>,
	stable@vger.kernel.org,
	Baoli Zhang <baoli.zhang@intel.com>
Subject: [char-misc] mei: gsc: add dependency on Xe driver
Date: Sun,  9 Nov 2025 17:35:33 +0200
Message-ID: <20251109153533.3179787-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junxiao Chang <junxiao.chang@intel.com>

INTEL_MEI_GSC depends on either i915 or Xe
and can be present when either of above is present.

Cc: <stable@vger.kernel.org>
Fixes: 87a4c85d3a3e ("drm/xe/gsc: add gsc device support")
Tested-by: Baoli Zhang <baoli.zhang@intel.com>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index f8b04e49e4ba..f4eb307cd35e 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -49,7 +49,7 @@ config INTEL_MEI_TXE
 config INTEL_MEI_GSC
 	tristate "Intel MEI GSC embedded device"
 	depends on INTEL_MEI_ME
-	depends on DRM_I915
+	depends on DRM_I915 || DRM_XE
 	help
 	  Intel auxiliary driver for GSC devices embedded in Intel graphics devices.
 
-- 
2.43.0


