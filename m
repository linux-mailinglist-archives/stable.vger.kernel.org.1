Return-Path: <stable+bounces-272673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /uPaFpdyTmrYMwIAu9opvQ
	(envelope-from <stable+bounces-272673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 17:53:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B72272850B
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 17:53:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=A9uHYFTp;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272673-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272673-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997CA31CA4D0
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52F93B71AA;
	Wed,  8 Jul 2026 15:23:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6F439354;
	Wed,  8 Jul 2026 15:23:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524217; cv=none; b=Bsx/E2pplU06JP+UBmRw88HrbBil2gsvmpwRTyTQaJ8INwprTP7zBuh29KoM7Uewh4wPd/ze+Gz90bwNg/Q+pwD2E33g6St8SOBsgSui7Iguk58a+B6WAtsbKnQuna5axLZZO/BKgQ1x0XpVg+T5bb2NpIGC4Y6HYKJqIYr0oM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524217; c=relaxed/simple;
	bh=2bHyd0HYt0l7hyE2ucHxpvOuK+AjtrhAl7AvVaHul+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ora54e8hPlzg47O9Pl1sCTvQfOK1xDXq7EMU8ob9h9Y0gNE4T/z/ppM6Ab89Cjn0Rc/VnbG9Yv9NgEjVsJRjKCOY9/azCtf6CLMMBNUkMIhiSkk4AmfNXj4vdRKkApc6sruqWModVmrMzLbFQ9hWwzJ7AG3NmSwLLg96vxs2yy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9uHYFTp; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783524216; x=1815060216;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=2bHyd0HYt0l7hyE2ucHxpvOuK+AjtrhAl7AvVaHul+w=;
  b=A9uHYFTp8tq9NJ8IsMPrrXqBeiZtWGY6pBIJkJgqp3RG5/5C9mA0474j
   hWbodNoU9io6HPXABaNb9tbUnvJH2+XNQ4D1lCUW9KHj/GKOYnGpiyeGV
   g+kNcBzfCHixA8dmKgnVz+TEUiWAzQdZRwTMdCvd99dwWVqHl7Mcqe2MH
   /L8UGpWIT4xkqy69dYcnPa3p/1IG1RORm1qxXuBglI/pH4grfyAJVi2GM
   MavEb3YKqVm9pJ6uJwwfHG8rYaJHP37T63iR/B2qYv6hQ0vJDX9mm92Q4
   2rWb2c8n0pgE1qPi3MYMO5fDIa5raUBY4GVH/CKkQpFLcrhDzPMFOmN5W
   g==;
X-CSE-ConnectionGUID: qPifkGHKR1GsIUxDXiIjqQ==
X-CSE-MsgGUID: e3b9HfHNQnaBzXKujf1IXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94795910"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94795910"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 08:23:35 -0700
X-CSE-ConnectionGUID: v7cevtXwQgSkrAfmoaX+cQ==
X-CSE-MsgGUID: wxWuiIpTQsWxdUN/fWviSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="278710205"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 08:23:32 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Wed, 08 Jul 2026 18:00:17 +0300
Subject: [PATCH] drm/xe/nvm: fix writable override for CRI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-cri_nvm_fdo_flip-v1-1-792373667334@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBMs+6OrREjpWAOloiCBdPek5
 bd4L0PEQBhhrjIETBTJ2YKmrkCdmz2QkS6GlrcDH/nEVCBp0y2NdtJc5JkQYu+7HhutJyiZD2j
 o+ZfL+r4fclTRvGIAAAA=
X-Change-ID: 20260708-cri_nvm_fdo_flip-333b545e1dd8
To: Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783522843; l=2075;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=2bHyd0HYt0l7hyE2ucHxpvOuK+AjtrhAl7AvVaHul+w=;
 b=u69QQyE7bZIM7sHe+PyjKm6pWbCkMTCF227z8KfKfdORYwtCWqsrtIbSe48v65lka92Q8wfz+
 5Zjzil3vWjOBuedkUx3D3Y2Mq1cPazPHNEaOQ64EwJK1QBlwWFX1yef
X-Developer-Key: i=alexander.usyskin@intel.com; a=ed25519;
 pk=X+qoF/nFCdDOV04IForWSxnkyoCAbUE10egZi6PSfcU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272673-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:alexander.usyskin@intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alexander.usyskin@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,linux.intel.com,gmail.com,ffwll.ch];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.usyskin@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B72272850B

The witable override should be set when FDO_MODE bit is enabled.
Fix the comparison to distingush this case from legacy systems
where bit should be disabled to have override.

Cc: stable@vger.kernel.org
Fixes: 9dde74fd9e65 ("drm/xe/nvm: enable cri platform")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/xe_nvm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
index 33487e91f366..d50ee414e83e 100644
--- a/drivers/gpu/drm/xe/xe_nvm.c
+++ b/drivers/gpu/drm/xe/xe_nvm.c
@@ -60,35 +60,39 @@ static bool xe_nvm_writable_override(struct xe_device *xe)
 	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
 	bool writable_override;
 	struct xe_reg reg;
-	u32 test_bit;
+	u32 test_bit, test_val;
 
 	switch (xe->info.platform) {
 	case XE_CRESCENTISLAND:
 		reg = PCODE_SCRATCH(0);
-		test_bit = FDO_MODE;
+		test_val = test_bit = FDO_MODE;
 		break;
 	case XE_BATTLEMAGE:
 		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	case XE_PVC:
 		reg = HECI_FWSTS2(PVC_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	case XE_DG2:
 		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	case XE_DG1:
 		reg = HECI_FWSTS2(DG1_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	default:
 		drm_err(&xe->drm, "Unknown platform\n");
 		return true;
 	}
 
-	writable_override = !(xe_mmio_read32(mmio, reg) & test_bit);
+	writable_override = (xe_mmio_read32(mmio, reg) & test_bit) == test_val;
 	if (writable_override)
 		drm_info(&xe->drm, "NVM access overridden by jumper\n");
 	return writable_override;

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260708-cri_nvm_fdo_flip-333b545e1dd8

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>


