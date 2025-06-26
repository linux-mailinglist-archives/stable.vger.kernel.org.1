Return-Path: <stable+bounces-158710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E14FAEA605
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 21:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2123BF6AD
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 19:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BEC2ED163;
	Thu, 26 Jun 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHY9uDwS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B321348
	for <stable@vger.kernel.org>; Thu, 26 Jun 2025 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964649; cv=none; b=fGgjUCTXj5/GnXYHFHzQAPp5THhzwHOyfnrMYKy0ZMeLAVZe9QkEcc4p0W8LnFy8L1HdUINquGNFrwObbXCsdMeRrZv+oAnM6ZYoCqKS+PKGq2G2L4Y4/GpDLEXQcxHrdOhNWW5Dq+OdgD8kPTYWG6r2LZDgPpVkPlAvuiVHfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964649; c=relaxed/simple;
	bh=W96jFi0ozYt7piTYdJEZ/ATHq9mzwXp5ZChmtko8xmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=by+wUi8Ttvumqwwo6X5LjFVpjhkqtT2ZfMTWXA4CinMNBDLKYygxYenc2HzGpu5Zsg7Dbu8VPXEYITjIFB3HMqAp1+SfpcbbYbgZgjBwsfk4mbixJhJXUYCtuGLmTZfYUN9No+ZXDXJpNxQyfqW1mL1+gUMhRPWxUf7VC1uHSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHY9uDwS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750964647; x=1782500647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W96jFi0ozYt7piTYdJEZ/ATHq9mzwXp5ZChmtko8xmQ=;
  b=eHY9uDwSZJbLuY+jfpOAivVmnJucgs40tABBRB8V7Rihx6jwMq44qHfL
   qvkzt29h2ooDMj+HvWl1wuI1oKqENkwPnrbDe+z4i0YKs3bjRX1vtSl/k
   rPoUU0LAyyUdg2aAiwcixCSGDqnxIMgYb/5MSegL4D80itrEUEVKzxres
   iBfAvn7tJQ1tEVXOUI2sYWq4EyFjAIMfS+glVbXuKcbNAL+V/qEtp97Wm
   79dZIXUfeVdW0aenRAQGi66f9hQMJV1omTwu+EhVK2YwVU8Tkp4DyMOlH
   dSQjcKOajjXkoPlLvt7qLl5OO0pT51ySM7nAARyb8zQiv/TcxLKUG5OwT
   A==;
X-CSE-ConnectionGUID: y2ynt3TNTAStqIgmLRYATA==
X-CSE-MsgGUID: J55CQr16Q2yYwycpg6dtdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="75819905"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="75819905"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 12:04:06 -0700
X-CSE-ConnectionGUID: RC1L0FADQt+BgXC73RbPLg==
X-CSE-MsgGUID: k9pklT2dSK+6pmzwwqV5Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="176273419"
Received: from mjruhl-desk.amr.corp.intel.com (HELO mjruhl-desk.intel.com) ([10.124.220.105])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 12:04:05 -0700
From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To: micheal.j.ruhl@intel.com
Cc: "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c/designware: Fix an initialization issue
Date: Thu, 26 Jun 2025 15:03:55 -0400
Message-ID: <20250626190355.469590-1-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i2c_dw_xfer_init() function requires msgs and msg_write_idx from the
dev context to be initialized.

amd_i2c_dw_xfer_quirk() inits msgs and msgs_num, but not msg_write_idx.

This could allow an out of bounds access (of msgs).

Initialize msg_write_idx before calling i2c_dw_xfer_init().

Fixes: 17631e8ca2d3 ("i2c: designware: Add driver support for AMD NAVI GPU")
Cc: <stable@vger.kernel.org>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index c5394229b77f..40aa5114bf8c 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -363,6 +363,7 @@ static int amd_i2c_dw_xfer_quirk(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 	dev->msgs = msgs;
 	dev->msgs_num = num_msgs;
+	dev->msg_write_idx = 0;
 	i2c_dw_xfer_init(dev);
 
 	/* Initiate messages read/write transaction */
-- 
2.49.0


