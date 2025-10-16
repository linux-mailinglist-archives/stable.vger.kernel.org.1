Return-Path: <stable+bounces-186058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 353BABE3791
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D65BC35885F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB2324DFF4;
	Thu, 16 Oct 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWN2olis"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121F2E413
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618735; cv=none; b=ogckVBJnJjIaA+BjTg8f3HRWhsoeaUrZZDC/qxc6jDtZ5fgT9Fv4a65zDPrZ/ZhIWVVI/Xl3iMP4Q7OZJ/UUQmfU/0rv4LegBmGya85SZdXQw1yR/PpC+MYNc0BpgJF607Wx+PZkEvgkXXIkGW3X8SS7yhV29N8opmNjEtqyJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618735; c=relaxed/simple;
	bh=PDi+gP8O5YiKxDUkCu+MRCqRNVnnxhltI37Bsh7pQaA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kDwapB+nAYXeUrLzOTIAokWh+c48/wKFa37r3T5q76ue0vZgF35GVA2v3Ggg510M0jo+65ytMmmPKcwjh07x7v+H1JC5TIjxboUJVpvb/mpK9A19VtTDMhCB8f+IBM0rdr/8P7A2rt36l4fBmGdU0ZLzgk/rNbscuml0PbTt5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWN2olis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1887EC4CEFE;
	Thu, 16 Oct 2025 12:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760618734;
	bh=PDi+gP8O5YiKxDUkCu+MRCqRNVnnxhltI37Bsh7pQaA=;
	h=Subject:To:Cc:From:Date:From;
	b=XWN2olisSfqzh/jfHRB0tgvGibROnO27BO7KrPLUKMKZW5OhHRP2mzip2wgRO+tAH
	 zg+DwO39QvY77hSLzaglfC/BYxOEVW1nWyb6KPC/RC0ekJgPLenc7WXPoNXqWAsYtK
	 ls4KM3nfPVdn483Hd0lTw+YvtoKmJ3lk7d4kL0LI=
Subject: FAILED: patch "[PATCH] iommu/vt-d: PRS isn't usable if PDS isn't supported" failed to apply to 5.10-stable tree
To: baolu.lu@linux.intel.com,joel.granados@kernel.org,joerg.roedel@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:45:31 +0200
Message-ID: <2025101631-encrust-snagged-88c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5ef7e24c742038a5d8c626fdc0e3a21834358341
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101631-encrust-snagged-88c4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ef7e24c742038a5d8c626fdc0e3a21834358341 Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Thu, 18 Sep 2025 13:02:02 +0800
Subject: [PATCH] iommu/vt-d: PRS isn't usable if PDS isn't supported

The specification, Section 7.10, "Software Steps to Drain Page Requests &
Responses," requires software to submit an Invalidation Wait Descriptor
(inv_wait_dsc) with the Page-request Drain (PD=1) flag set, along with
the Invalidation Wait Completion Status Write flag (SW=1). It then waits
for the Invalidation Wait Descriptor's completion.

However, the PD field in the Invalidation Wait Descriptor is optional, as
stated in Section 6.5.2.9, "Invalidation Wait Descriptor":

"Page-request Drain (PD): Remapping hardware implementations reporting
 Page-request draining as not supported (PDS = 0 in ECAP_REG) treat this
 field as reserved."

This implies that if the IOMMU doesn't support the PDS capability, software
can't drain page requests and group responses as expected.

Do not enable PCI/PRI if the IOMMU doesn't support PDS.

Reported-by: Joel Granados <joel.granados@kernel.org>
Closes: https://lore.kernel.org/r/20250909-jag-pds-v1-1-ad8cba0e494e@kernel.org
Fixes: 66ac4db36f4c ("iommu/vt-d: Add page request draining support")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20250915062946.120196-1-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9c3ab9d9f69a..92759a8f8330 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3812,7 +3812,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_pri_supported(pdev))
+			    ecap_pds(iommu->ecap) && pci_pri_supported(pdev))
 				info->pri_supported = 1;
 		}
 	}


