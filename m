Return-Path: <stable+bounces-114117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689DA2AC4A
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CB57A243A
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680DD1E5B7A;
	Thu,  6 Feb 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iL4oXU/u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F51A5B8D;
	Thu,  6 Feb 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855073; cv=none; b=aEFydRF/OxTjsiPSTIm8plO4vjA0XqwQb7uUhh0aMEwsZM7x3Ir/sxITXBMmZvbdYMeWO+JlpPxnU5R9y9mVi3S9/Mhv2xao+iyeAs7AWw278Emdsb/J+sVCFkWb7mStZDhmsdlkUCc9zU7KG18kNt/pvvWV0yHGx9ynPlQb6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855073; c=relaxed/simple;
	bh=kpx4/AxJfjx+HhpAz2rE6HkSsZKKEWVgbbTrvnkZWA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J/yq5nG5qn191krNbEhi6z3qBP58y+yudjlCui04Ni019OUQ2SSCAgsbObGIibrICbzkTV3iO2I7Xd9ifhxgEk5xgQ3LP3Y/lMJeXZoBv2XZsajnD7x49gaAbHOy7bYPjQItTdOkhxXaSV0EjVM7MQTY5u17WAqZGpOWVBmlyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iL4oXU/u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738855071; x=1770391071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kpx4/AxJfjx+HhpAz2rE6HkSsZKKEWVgbbTrvnkZWA0=;
  b=iL4oXU/umhDPykZZ50EQQWD2XbTg0bzaUsKkIuLps6Q8KUzngKlv2L0k
   AGVPrwbTBD2wLwXir3kSBIf4V9qbL9O5n1fi++aogQntbFhRjNr90Adyx
   NOXSvNHTIox/NNFGdFERFhpwn/M8Zn0bdSOTa7+LdABJxheb0BzBxcwnr
   8hJtoAC+c1DqVLIkrYFIzlD4OpN8cBggtiRIzEsDPUJ89IwY6IUbuusOM
   axGMnyUFOEWyoWZHAUMo8s/+cSCU0HK4Bnj1eX7d+oWm095IY40L96lDE
   qJHVtL764nA+tzYO0D+Pn66xgRYfUqgEflQfGURlYo8DjwdE1mn3O1Mo8
   A==;
X-CSE-ConnectionGUID: cyLSPjszR6ip9hAHoKDd1w==
X-CSE-MsgGUID: M19vedbFRLyaMl89LpxK1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50099232"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="50099232"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 07:17:51 -0800
X-CSE-ConnectionGUID: IXTZMq+NSyWNi8uKD2rwIA==
X-CSE-MsgGUID: M7joH1gpRgqfEtzC4PBi7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="142117852"
Received: from unknown (HELO mattu-haswell.fi.intel.com) ([10.237.72.199])
  by orviesa002.jf.intel.com with ESMTP; 06 Feb 2025 07:17:48 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org,
	Forest <forestix@nom.one>
Subject: [PATCH] USB: Add USB_QUIRK_NO_LPM quirk for sony xperia xz1 smartphone
Date: Thu,  6 Feb 2025 17:18:36 +0200
Message-Id: <20250206151836.51742-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fastboot tool for communicating with Android bootloaders does not
work reliably with this device if USB 2 Link Power Management (LPM)
is enabled.

Various fastboot commands are affected, including the
following, which usually reproduces the problem within two tries:

  fastboot getvar kernel
  getvar:kernel  FAILED (remote: 'GetVar Variable Not found')

This issue was hidden on many systems up until commit 63a1f8454962
("xhci: stored cached port capability values in one place") as the xhci
driver failed to detect USB 2 LPM support if USB 3 ports were listed
before USB 2 ports in the "supported protocol capabilities".

Adding the quirk resolves the issue. No drawbacks are expected since
the device uses different USB product IDs outside of fastboot mode, and
since fastboot commands worked before, until LPM was enabled on the
tested system by the aforementioned commit.

Based on a patch from Forest <forestix@nom.one> from which most of the
code and commit message is taken.

Cc: stable@vger.kernel.org
Reported-by: Forest <forestix@nom.one>
Closes: https://lore.kernel.org/hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net
Tested-by: Forest <forestix@nom.one>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 67732c791c93..59ed9768dae1 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -435,6 +435,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0c45, 0x7056), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* Sony Xperia XZ1 Compact (lilac) smartphone in fastboot mode */
+	{ USB_DEVICE(0x0fce, 0x0dde), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Action Semiconductor flash disk */
 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
-- 
2.25.1


