Return-Path: <stable+bounces-136686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54FA9C370
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89433189C50C
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A87214A70;
	Fri, 25 Apr 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PseRv/+G"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6324C6E
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573308; cv=none; b=jduEFGQdlwWiVwp6x4BHtd670N+5tb6nJyjWjT+aGVdOmrxBwFsxmgXyF71Pz5ZIQV/HM6cFe85bcpu9rIGi4f8GgBNKF5gFry2q4KyJVPV0jFtJMp3y0zSGpVgHtSThEMeXXeapNN50zilj54q3VGr7l650IMTadIOFltUk6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573308; c=relaxed/simple;
	bh=t3+q53XNK07U0Ok6/ctrG/tNsyGHpKqHUWKXAIQrnh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uAWfZXmptIf2AR9LD7eLt1AgcpaL4kxfjmR/2DEL0WrAacLSrG8Sp1FGblt8yQsg22tCIPGMjMitgnqRnvTBHfyj5pvjorDIBkwAZCdDF3+xJ7eBZA2OuRbLnWYRRT0R/mvthtdxXrt6FhkKwhMLr1cX4tWagIks66elCflqVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PseRv/+G; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745573307; x=1777109307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t3+q53XNK07U0Ok6/ctrG/tNsyGHpKqHUWKXAIQrnh8=;
  b=PseRv/+GjEQGpqR8s427uM+1PCjCHZ8xirSHj43LgCyujM2pGfIvfUQH
   WKsNbR73cm7Lkoj33bM4wQqKX/nUxqJTc4ooMUan8bq/HhnidyFOM4w2J
   b309BPgEsNPy2F7vwOqdNUaWJ3WPSlTJ7nH6an/KM2N/qZ+BZe8BTcd+Y
   ECs5oQdc+o+5BVwsdcc4+//e87lKSEe8jTAZrqeLHw9PuWvb6avVPdHKi
   P2SV0y57CFjn4ccS3sQUV1mhWSgq43tPcaWh4ZiZ4FGz5tX9pQ4Gg9C55
   QY4kBfXsIAhjtgtYz7wvqAfRtn/hDCeGfIr02fXZCR8O6rvFNBRQvfzBp
   A==;
X-CSE-ConnectionGUID: WPUxCtpRSeaFb65g27AAfA==
X-CSE-MsgGUID: H2aOLMspQVeRq+5ZR30KzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46942531"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="46942531"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 02:28:27 -0700
X-CSE-ConnectionGUID: 7kIYSI20SLKf0fMSErExxQ==
X-CSE-MsgGUID: vFdIMz0bR0qh9ibf1DuBgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133779050"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 02:28:25 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: quic_jhugo@quicinc.com,
	lizhi.hou@amd.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Increase state dump msg timeout
Date: Fri, 25 Apr 2025 11:28:22 +0200
Message-ID: <20250425092822.2194465-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase JMS message state dump command timeout to 100 ms. On some
platforms, the FW may take a bit longer than 50 ms to dump its state
to the log buffer and we don't want to miss any debug info during TDR.

Fixes: 5e162f872d7a ("accel/ivpu: Add FW state dump on TDR")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index ec9a3629da3a9..633160470c939 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -119,7 +119,7 @@ static void timeouts_init(struct ivpu_device *vdev)
 		else
 			vdev->timeout.autosuspend = 100;
 		vdev->timeout.d0i3_entry_msg = 5;
-		vdev->timeout.state_dump_msg = 10;
+		vdev->timeout.state_dump_msg = 100;
 	}
 }
 
-- 
2.45.1


