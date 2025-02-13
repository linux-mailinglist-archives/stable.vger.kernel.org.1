Return-Path: <stable+bounces-115736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A46EA345FA
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926D9189B203
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CB3202F97;
	Thu, 13 Feb 2025 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HdzmNUIs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4503202C55;
	Thu, 13 Feb 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459071; cv=none; b=NReWr7/V6uB7tk1FWmePZRelglvpHdsvDNStUwSZ+4s6FhXXuByXBHT2gCUomWXmULlPQ9vHPdxIA/IYmS8Pysnl/Z8wm9sVNsmYDNnV9qAwt+9OT0nmpAU6ufdXogF0n5faSR8ckKR1Bw1K4hUpzFO+skTNsmngAdNOZ0Q/uf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459071; c=relaxed/simple;
	bh=AgsQSCJ2GbuSTi5ML+1+/pM/FOtwr0lwZLOdeiv+qOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvfuU7kR3dwBfke4WMmW3h9inMjkE50L1mzH4lqRhwGRotwrmL8BqlgC+nWzjkG+niUFwbOJQJvjtusGbMY90g57YltrWuUQ2KE1wn7AdyQgJAJ0Lm7BrkgQzXy1V/vO00taipQH9LJVy+h7PvWN1uRYG1Mb8bRsyh78bxDGdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HdzmNUIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84ACC4CED1;
	Thu, 13 Feb 2025 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459071;
	bh=AgsQSCJ2GbuSTi5ML+1+/pM/FOtwr0lwZLOdeiv+qOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdzmNUIswTaq146v6lu99ged07eZTYt5ASyzW6dlwG4YIbJrtOOQgsFeXtsD+YTZZ
	 js+YaoBdqfG7yoJ28uHzu++eFg/CGtMNM9zATLub7mu8m7n44H5+tLxCGNfvoq39/0
	 ifcOpE05+BP1fBA5unuZ9vzx17Ig5oyXPFjvIG9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 6.13 159/443] accel/ivpu: Fix Qemu crash when running in passthrough
Date: Thu, 13 Feb 2025 15:25:24 +0100
Message-ID: <20250213142446.731547896@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

commit 901dd2617c9c3554b2449c8844b6338009112fcf upstream.

Restore PCI state after putting the NPU in D0.
Restoring state before powering up the device caused a Qemu crash
if NPU was running in passthrough mode and recovery was performed.

Fixes: 3534eacbf101 ("accel/ivpu: Fix PCI D0 state entry in resume")
Cc: stable@vger.kernel.org # v6.8+
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241106105549.2757115-1-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -78,8 +78,8 @@ static int ivpu_resume(struct ivpu_devic
 	int ret;
 
 retry:
-	pci_restore_state(to_pci_dev(vdev->drm.dev));
 	pci_set_power_state(to_pci_dev(vdev->drm.dev), PCI_D0);
+	pci_restore_state(to_pci_dev(vdev->drm.dev));
 
 	ret = ivpu_hw_power_up(vdev);
 	if (ret) {



