Return-Path: <stable+bounces-54108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446E90ECB9
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467191F2170D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB374143C4A;
	Wed, 19 Jun 2024 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJbsLDbR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7F12FB31;
	Wed, 19 Jun 2024 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802609; cv=none; b=lpFG+WdHlHxWyax0ronE+InWwZKM6DS+WmRllCJGQSB+x23/dkHJ7oUZEGWB0J/Gmuc0LTvTZNR8PaceYTzLJ41XoROL2YRaF36fQruUYXdz+oNrrqB1z5PaMN08qSXt+hDAtTXFkR2ZFB4rm40JciQezBiELHJFFc9BkLVdWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802609; c=relaxed/simple;
	bh=hc2PxvHx1EHOFKB8KAshlGCAQ9xHChjVAQr8IaQfLf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4UCKv+49rVm8bo/hyv/HA82/+GZ4l6ge4FiN9VMpXOYKEiVcbLpgzAeu10LTqK3SrDNhwLyjO7AnlaCtuLjtc3fnIcUc0Zsnok/vUd+qMml43MZyMIBFNr3ZXSM474dlPRcwkC1NvX+skSDxe7rji4J6JGqEBaUcUKx5QlZl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJbsLDbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8FEC2BBFC;
	Wed, 19 Jun 2024 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802609;
	bh=hc2PxvHx1EHOFKB8KAshlGCAQ9xHChjVAQr8IaQfLf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJbsLDbR6RvEzMm7mZTHBYvJeUvGMpPll7BFm0p1ELB1dlyBWFs9JNTYfpBEfHcxt
	 Y+HLLPiq3QztuSRuiW874MdZS6NjwojeVdnfAzUvIj5X5Itdkq+DmyyE5PfmP87MqD
	 99yqaOblzwbjGK0HeUEJcqe6PMUU2p0tn43Dd4l0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 6.6 223/267] intel_th: pci: Add Lunar Lake support
Date: Wed, 19 Jun 2024 14:56:14 +0200
Message-ID: <20240619125614.885314230@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit f866b65322bfbc8fcca13c25f49e1a5c5a93ae4d upstream.

Add support for the Trace Hub in Lunar Lake.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20240429130119.1518073-16-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -325,6 +325,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Lunar Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa824),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,



