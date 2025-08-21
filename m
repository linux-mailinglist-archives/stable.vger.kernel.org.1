Return-Path: <stable+bounces-172136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D895DB2FD12
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B86D1D21283
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB6D246348;
	Thu, 21 Aug 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YrIlkBSB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16892571DA
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786532; cv=none; b=oAm53bT6uZkY7DXxE/JdeHnXNPU1iP2mU17gVA4qjSDaf84aPn49G+lYeM3RDY1omCIyfaIgKDZNAwTTkP9k0zNbvEmvZc6H7qpWc3HyiLRyqRyoRVjwV7cTgGWSl9tEP/YCbgDB7BFg6rkG+GuGGo3w8tiWUZsKh3vHhqpV6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786532; c=relaxed/simple;
	bh=ZGGLaQNXJmdm2jEJXbrdY46ERQDtX+qoK/XFt5IrCyA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i0oZC7GvEu55mlsXdCrOHFvtGBtUC12gXArmXDd04/c5Mj5HRPXDoPdDrrP3FPVfv5crHUnPTQzSRb+U7BDHDjMy1Wlx7v07lmCzbpHYyQzI4kOgCA906nAI44fcxmfhTRerOXzYyni9yehQJZIQcYzx3Z/l+3gzvJVmcfF820w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YrIlkBSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413B8C113CF;
	Thu, 21 Aug 2025 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786532;
	bh=ZGGLaQNXJmdm2jEJXbrdY46ERQDtX+qoK/XFt5IrCyA=;
	h=Subject:To:Cc:From:Date:From;
	b=YrIlkBSBPcIrVLOfpErSX2yhPJ2GAUA5zwfBAxaOI2zumRn4xbYhOyEYy6cX2cN43
	 6hiS0tTHWMzvNOyRn2rRLH90wfR1op2g+4QODAeLzoO0UlBNfJHIOf/zFDUUpnmcqX
	 hQ6/MJzyFrHODekxRuRmfYKQPmv/M2EmJe8WkToo=
Subject: FAILED: patch "[PATCH] media: venus: hfi: explicitly release IRQ during teardown" failed to apply to 5.4-stable tree
To: jorge.ramirez@oss.qualcomm.com,bod@kernel.org,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl,quic_dikshita@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:28:38 +0200
Message-ID: <2025082138-folk-resolved-7e00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 640803003cd903cea73dc6a86bf6963e238e2b3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082138-folk-resolved-7e00@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 640803003cd903cea73dc6a86bf6963e238e2b3f Mon Sep 17 00:00:00 2001
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Date: Thu, 19 Jun 2025 09:48:30 +0200
Subject: [PATCH] media: venus: hfi: explicitly release IRQ during teardown

Ensure the IRQ is disabled - and all pending handlers completed - before
dismantling the interrupt routing and clearing related pointers.

This prevents any possibility of the interrupt triggering after the
handler context has been invalidated.

Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Cc: stable@vger.kernel.org
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Tested-by: Dikshita Agarwal <quic_dikshita@quicinc.com> # RB5
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index c982f4527bb0..cec7f5964d3d 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1682,6 +1682,7 @@ void venus_hfi_destroy(struct venus_core *core)
 	venus_interface_queues_release(hdev);
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
+	disable_irq(core->irq);
 	core->ops = NULL;
 }
 


