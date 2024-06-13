Return-Path: <stable+bounces-51177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2909906EAB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497981F20C71
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249FB146587;
	Thu, 13 Jun 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A2QzSSm4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5C1448DD;
	Thu, 13 Jun 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280532; cv=none; b=K27Ge7JoRjc1QOFTtxYgbY2GZsAMvjd+kGJFiG6vLyxFiGR67vL6pe1V39nttP8KnQK0GSw3/Fc3odXNvvnLPv8eK008Btm3zmv0h94BGcSc0DYIbo6r7ekM2P+qycbX3kgTas1O7y1i6TgveYWnPgn2L2Gw474csvVTbnSphvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280532; c=relaxed/simple;
	bh=EYxyWF3EHpB69AJbkfOVE0PtXq/QiUq/+geKB7Ms/CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmhjxREKirfBXAFGO0UC+EeN0G2cwisWENoJ/V+Zq46yWOZRT3O17sKwK/UR0pDOz6nDrUt89opr/CiNLvR/hIPks5DPxcniJ4dZ7WubTkug+ohV+eD3o9vJWTvYJx0AVFfpegpwNQ2zEfr1sn2ay7RuZWqw40/NBUeZ1HMEIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A2QzSSm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAA5C2BBFC;
	Thu, 13 Jun 2024 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280532;
	bh=EYxyWF3EHpB69AJbkfOVE0PtXq/QiUq/+geKB7Ms/CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2QzSSm4TnbgORnSq//me5pyWmhOkfmkJ0ElgTECodlKlVZMkNvigbh1oa3DT7gY9
	 VdZIAV/2ztLG+yJ2gkRYVlTKsUNoN8yPXec6rTwyQKYO09wQ9KhcrySVoZX6ICiUXK
	 0k/WM86Bs0w4YKVzvZy/+PEiyNgg2TPw+rY8bXEg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 6.6 086/137] intel_th: pci: Add Meteor Lake-S CPU support
Date: Thu, 13 Jun 2024 13:34:26 +0200
Message-ID: <20240613113226.634522533@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
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
@@ -290,6 +290,11 @@ static const struct pci_device_id intel_
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



