Return-Path: <stable+bounces-7506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6648172DA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3C11C24DEB
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE11D127;
	Mon, 18 Dec 2023 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0390O1M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E97129ECF;
	Mon, 18 Dec 2023 14:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF33C433C8;
	Mon, 18 Dec 2023 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908650;
	bh=aYR87cHzz/wGtC79skjh0R2p+5QDk0vTzDqJG14xyb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0390O1MGuoNwEaRPvzR+VtohxJqAmZxNXF2DCSeA0dL1WGVJ48aH2X+hkeVF3See
	 g9a1KyAlYtCWQEfR3C6NLo1Hrne4xGejbp253mSenfkbWDRDiBYtU1v8WiRLwSqTj/
	 sGZGYq7gyuHZ6sDFrIXLWtrEmyjyVZVAzyxKrebo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 25/40] platform/x86: intel_telemetry: Fix kernel doc descriptions
Date: Mon, 18 Dec 2023 14:52:20 +0100
Message-ID: <20231218135043.638419215@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135042.748715259@linuxfoundation.org>
References: <20231218135042.748715259@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit a6584711e64d9d12ab79a450ec3628fd35e4f476 ]

LKP found issues with a kernel doc in the driver:

core.c:116: warning: Function parameter or member 'ioss_evtconfig' not described in 'telemetry_update_events'
core.c:188: warning: Function parameter or member 'ioss_evtconfig' not described in 'telemetry_get_eventconfig'

It looks like it were copy'n'paste typos when these descriptions
had been introduced. Fix the typos.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310070743.WALmRGSY-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231120150756.1661425-1-andriy.shevchenko@linux.intel.com
Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_telemetry_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_telemetry_core.c b/drivers/platform/x86/intel_telemetry_core.c
index d4040bb222b48..59fc6624b1ac9 100644
--- a/drivers/platform/x86/intel_telemetry_core.c
+++ b/drivers/platform/x86/intel_telemetry_core.c
@@ -102,7 +102,7 @@ static const struct telemetry_core_ops telm_defpltops = {
 /**
  * telemetry_update_events() - Update telemetry Configuration
  * @pss_evtconfig: PSS related config. No change if num_evts = 0.
- * @pss_evtconfig: IOSS related config. No change if num_evts = 0.
+ * @ioss_evtconfig: IOSS related config. No change if num_evts = 0.
  *
  * This API updates the IOSS & PSS Telemetry configuration. Old config
  * is overwritten. Call telemetry_reset_events when logging is over
@@ -176,7 +176,7 @@ EXPORT_SYMBOL_GPL(telemetry_reset_events);
 /**
  * telemetry_get_eventconfig() - Returns the pss and ioss events enabled
  * @pss_evtconfig: Pointer to PSS related configuration.
- * @pss_evtconfig: Pointer to IOSS related configuration.
+ * @ioss_evtconfig: Pointer to IOSS related configuration.
  * @pss_len:	   Number of u32 elements allocated for pss_evtconfig array
  * @ioss_len:	   Number of u32 elements allocated for ioss_evtconfig array
  *
-- 
2.43.0




