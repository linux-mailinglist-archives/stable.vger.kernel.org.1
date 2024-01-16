Return-Path: <stable+bounces-11796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AC482FC80
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 23:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2881F29DC6
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 22:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F2A2C864;
	Tue, 16 Jan 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJIGfXPT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C032C6B8
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439308; cv=none; b=N26gqeidddKEMHbwIVJkVBWY8IWFETN7lWZJ4QInnvrY+33HdrSfj2LowTPNjZEr6upJMUHJsCXwuHtHRcZeQYNXTxkm8mTjDZXGKM64ncMM7LQ8Kvz8vUlD4VVq4sztjLJNAEFKOPRtzeIuQ9jelrR3I5Ns1AbKJND5DXOr6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439308; c=relaxed/simple;
	bh=77CdDDc6o3iAbM+CJcfqyFxbx9fFdEFF0iLtNPrYUY4=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=EB4uIvcRjloQSkpCawVGHVMiZ4rg7/mIdP+8W0rprZgyayUMfqwLVxkT7COsdSd+ehopRMBsxmHF4jz/3laSsvFDRbpWqWxDtuM/ukNtu/XZ2te6VjVFJwKbaWWe9OobmuU8b9IBSmNfFu6HCfl3NW34nZNkIXkfz4d2QBFEZ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJIGfXPT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705439306; x=1736975306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=77CdDDc6o3iAbM+CJcfqyFxbx9fFdEFF0iLtNPrYUY4=;
  b=MJIGfXPTIGIG2llEl0IroXu4BWiMW6V0/nAHJ2DiOGICSuFShOwDnCfj
   bFLNgajI1jfplihPaizaDQReQjSNnAaYPoBNT1LKq6craaLh0VLR0mmjy
   +iGelkO2wBYui5K7PPRjRedktf3EXhXQ37jY9ryWDqaXDbbFTE7WAJ06j
   RjdCKGpkeXmPeB3cBMCDSAT5z/ur9UCI8R6yeyfcBAvlt0v2z6UnY/e4p
   b6lSYQoxC7XELXGZoKUKaWNUxSXp2YeJ5JPArl8ZWCadLUrKFNZ4SFV/l
   nT9wOAgdKCQnsu69SHfQURJRaoXEpK1NurXtrnp5WFcpfNbRGxFRVFOo1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="21468070"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="21468070"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="777201876"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="777201876"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 16 Jan 2024 13:08:21 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 16 Jan 2024 23:08:21 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] Revert "drm/i915/dsi: Do display on sequence later on icl+"
Date: Tue, 16 Jan 2024 23:08:21 +0200
Message-ID: <20240116210821.30194-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

This reverts commit 88b065943cb583e890324d618e8d4b23460d51a3.

Lenovo 82TQ is unhappy if we do the display on sequence this
late. The display output shows severe corruption.

It's unclear if this is a failure on our part (perhaps
something to do with sending commands in LP mode after HS
/video mode transmission has been started? Though the backlight
on command at least seems to work) or simply that there are
some commands in the sequence that are needed to be done
earlier (eg. could be some DSC init stuff?). If the latter
then I don't think the current Windows code would work
either, but maybe this was originally tested with an older
driver, who knows.

Root causing this fully would likely require a lot of
experimentation which isn't really feasible without direct
access to the machine, so let's just accept failure and
go back to the original sequence.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10071
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index ac456a2275db..eda4a8b88590 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1155,6 +1155,7 @@ static void gen11_dsi_powerup_panel(struct intel_encoder *encoder)
 	}
 
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_INIT_OTP);
+	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
 
 	/* ensure all panel commands dispatched before enabling transcoder */
 	wait_for_cmds_dispatched_to_panel(encoder);
@@ -1255,8 +1256,6 @@ static void gen11_dsi_enable(struct intel_atomic_state *state,
 	/* step6d: enable dsi transcoder */
 	gen11_dsi_enable_transcoder(encoder);
 
-	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
-
 	/* step7: enable backlight */
 	intel_backlight_enable(crtc_state, conn_state);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_BACKLIGHT_ON);
-- 
2.41.0


