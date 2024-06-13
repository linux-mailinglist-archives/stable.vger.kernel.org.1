Return-Path: <stable+bounces-50716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C216906C24
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE61CB24C95
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3356E1448EA;
	Thu, 13 Jun 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ARzCGIaz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B641442EA;
	Thu, 13 Jun 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279181; cv=none; b=EDKFbfmu6Vj2fVGYi6dDEsgwBc22EwMApF8V8VA/SbL3IUbi+WcU2O6nhdDOMJP03q8QirEyfq+9plEuc4V2d/81BOsAiUiHScngOfTFlkvVCEzC4CBIHXTEo3UTRpdKFuN5TtVpjdFl1rmo928uvo14L8Zp7Wm8sWneYPo0ckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279181; c=relaxed/simple;
	bh=JN4sETWbtypg/gAXLUtrEZMzH5GnjxiU0cPStC7Q2Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j55FGFSoWov8v8oS1vjilHUi6CE5/t8SUVTQPCIfvgmLMB0rhOg43z96Yde28Fzd0SFXE6rXqVCwLwlrTNdVziAbNoz9jWA7/rnJjnbSvoz1CefdOJucZPNyYgnJ4zdr824C3uz+zw/L89cnJvBtYCqA02hLxm/VPIFFchiqR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ARzCGIaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE49C4AF1A;
	Thu, 13 Jun 2024 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279180;
	bh=JN4sETWbtypg/gAXLUtrEZMzH5GnjxiU0cPStC7Q2Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ARzCGIazKhcFY8T6v7ywE7hOyeb0ZJgU+QNRE4g3qam1uQri5xtd3J0T7hjI7Rcoz
	 FlCsdPCTCI/z42E30ITivy/dM81pggqW5x+pii1s2lg9WkgZPTxnlw+U6ngDo+DQSY
	 nDQyjvlR491U4jgBDn7dGwK+k1Bv3VO7J4rkTpz0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 4.19 202/213] intel_th: pci: Add Meteor Lake-S CPU support
Date: Thu, 13 Jun 2024 13:34:10 +0200
Message-ID: <20240613113235.770602882@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit a4f813c3ec9d1c32bc402becd1f011b3904dd699 upstream.

Add support for the Trace Hub in Meteor Lake-S CPU.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20240429130119.1518073-15-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -251,6 +251,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Meteor Lake-S CPU */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xae24),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Raptor Lake-S */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7a26),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,



