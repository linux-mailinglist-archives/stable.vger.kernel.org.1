Return-Path: <stable+bounces-28403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3595087FAA8
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 10:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF3D1B21350
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B927C0BD;
	Tue, 19 Mar 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtlBRdWq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5764CF6
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840288; cv=none; b=eFPHg+4CZuTcWAuabpw6VrbF02JLQ0pQQqn3Wi16tEeLnoVVA3sRC9SUb742ur0/Rg2ZiARiB/N3tN4h/raRK49d/Xj15jqA4+eUafCPu3IzZZRTmCMqh8i3GoPEuLtQChqyWuX2sTaCC7H9FMsJgkudEG5IYQCsDO1RhshJwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840288; c=relaxed/simple;
	bh=HXyiMMTeSojl+C2vg1LYW7kwzoeeV8JIKqcUUrGkj7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rz1O5+NaaOKTApCaClzRcaPQ2lW0d2L0nhb1Jqoli0PTdimOBEVi7SclPneq9t8CezQjm/8bOmuvLh8FpCMs1l1iMM5zGUNQT/wsnXRRg2KR3gMFz1A3DkWQkzLC9bUU55u2IHY5HNkhwqKIR4HtC8KqaApO39fBHEPUziw+UBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtlBRdWq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710840287; x=1742376287;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HXyiMMTeSojl+C2vg1LYW7kwzoeeV8JIKqcUUrGkj7U=;
  b=dtlBRdWqmmBMMwhIoVEpKDmTQZlmVp4AWNkOzZV66zO/Pi9REZlAfFEZ
   2W34SeiY5PpIU7YpJglDTRn2xy1TKRTP0Hzln0hS75+fDK5hdNCFJRYyH
   W26YzaiRoACzUE151fYnDWJao5crSqecRNan+vY8H1SiF+eF13Qjl9tgJ
   UOrq9M04ofZKdIm0SDYw02+3BctVSkE+DDHXmyVFuh2L1ZtRchJiLr6+b
   vh8HhMBj24VdvJwF0vXj5slhMJjVd6f2dKFS2kag51cre5uhXmjjwQm8b
   ArydGEt6JJE20nrA74Ehu2c6T0ZFNFtw9tAZjb1z9iM11ij3k9W/2deFs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5530415"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5530415"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 02:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="827782094"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="827782094"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 19 Mar 2024 02:24:44 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 19 Mar 2024 11:24:43 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] drm/i915/bios: Tolerate devdata==NULL in intel_bios_encoder_supports_dp_dual_mode()
Date: Tue, 19 Mar 2024 11:24:42 +0200
Message-ID: <20240319092443.15769-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

If we have no VBT, or the VBT didn't declare the encoder
in question, we won't have the 'devdata' for the encoder.
Instead of oopsing just bail early.

We won't be able to tell whether the port is DP++ or not,
but so be it.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10464
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_bios.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index c7841b3eede8..c13a98431a7b 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -3458,6 +3458,9 @@ bool intel_bios_encoder_supports_dp_dual_mode(const struct intel_bios_encoder_da
 {
 	const struct child_device_config *child = &devdata->child;
 
+	if (!devdata)
+		return false;
+
 	if (!intel_bios_encoder_supports_dp(devdata) ||
 	    !intel_bios_encoder_supports_hdmi(devdata))
 		return false;
-- 
2.43.2


