Return-Path: <stable+bounces-30377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893C3889052
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8CB1F2B76E
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7499294484;
	Sun, 24 Mar 2024 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElxuyNIE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7BD1FC98E;
	Sun, 24 Mar 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322186; cv=none; b=btnPpaOTc6uskXXQClKICM2TtsXRgmchfVVvs4FqMHkUeLUE0c5lf84EO3VWE/jGO/bQ+Y3kWsyABXKQn1mvxHU0W773vECHBK7y9Y/B4aZiDYltps1fU+KG8isnGmb1qdX+D3Mzy8Hy5V/VABHECpV2r9+PLqKTj0+Aj23ZQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322186; c=relaxed/simple;
	bh=AblLMCLKhGeVcNTlP4GxhDoq/j9RcxhSil5RYWBtqm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9CR125wCKmb08xlp2crfGByvoF9BiVdHbhHGmvUNM11v6eE6RjafzF+ilL/fcs1TBWGZOnSclKPXslMawqjnCZEcrZoWjNehv1Qvh24FR2QaSAzE+YHJRmouXK4VnmdlWV3WrCf6IoQZx7+Kw/QaeqtrFYeP9vjg7ZPALa54kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElxuyNIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7B8C433F1;
	Sun, 24 Mar 2024 23:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322184;
	bh=AblLMCLKhGeVcNTlP4GxhDoq/j9RcxhSil5RYWBtqm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElxuyNIEHFDHaT4Ol2Rr6ytb9dWVn42GhKDQ6B3SFQZce0Lb1yCAZf4k/+uLMelc/
	 g4nVblyW8CTHov9xfzVOEbh9X3r50RKSnMT+1vcKymPtOJyOHrhpf40nTLjJmpghfY
	 GYvMbkGU76kCKnOCu1SGgrnEMX6UcHOkYpxo4qAPBv6s/dMdf2ViEDHVnKhEZctEAt
	 6PFBQ9FcWvc25ZhPFE+0vAPj8U4kcWfOe+IFXgGFbdllMRVXFN+JkvzRldFTK1ZU95
	 tIJLYDHSxuphOskcLq9MlNPOosHheqprzggQK53xneN5m0xl316MTn17Sip7/oRycD
	 YTPtpFJLDGXJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 263/451] PCI/AER: Fix rootport attribute paths in ABI docs
Date: Sun, 24 Mar 2024 19:08:59 -0400
Message-ID: <20240324231207.1351418-264-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 0e7d29a39a546161ea3a49e8e282a43212d7ff68 ]

The 'aer_stats' directory never made it into the sixth and final revision
of the series adding the sysfs AER attributes.

Link: https://lore.kernel.org/r/20240202131635.11405-2-johan+linaro@kernel.org
Link: https://lore.kernel.org/lkml/20180621184822.GB14136@bhelgaas-glaptop.roam.corp.google.com/
Fixes: 12833017e581 ("PCI/AER: Add sysfs attributes for rootport cumulative stats")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index 860db53037a58..24087d5fd417a 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -100,19 +100,19 @@ collectors) that are AER capable. These indicate the number of error messages as
 device, so these counters include them and are thus cumulative of all the error
 messages on the PCI hierarchy originating at that root port.
 
-What:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
 Date:		July 2018
 KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
-What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
 Date:		July 2018
 KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
-What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal
 Date:		July 2018
 KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
-- 
2.43.0


