Return-Path: <stable+bounces-172135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675ECB2FCE9
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA925A00277
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FC72857E0;
	Thu, 21 Aug 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XvqHlQvA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACBE1F03F3
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786529; cv=none; b=CfdmunIac54w7nS2W/QRrtNOuUFX6UsJvzQ84KWALXnqtwAHq462ErvajCxosmuKlLfDvtzFGcJe0eMFgr+XdeKlQ4DUbPXBF7UMag0hUt/bVmsCGD8oU/UFoqWNfbgdfQ22nwqWN7Er9IqmPTqpHnUITaeO5Zojyv5qSBW8DSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786529; c=relaxed/simple;
	bh=k+vK9VJBnv1R/tv2Nd29xjyETFmtos6l6cLmJDL/cMo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CDm/x5v+FpPXfh5RsWQjl0VLGeNF0Q2ux+eXSjm4Be1GzHBeE6Q93I02WM+iDAq8pJ1Sof5ZqRbD2BJPgDLgAU9BDtdII9mAvyIAN+eYXh2lYFEuXJ+MPDYIxXsDUqI+kVaUdwnYkBWiciu3r7HIkX1uwxyK0IcjalWtpnFEKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XvqHlQvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA61FC4CEED;
	Thu, 21 Aug 2025 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786529;
	bh=k+vK9VJBnv1R/tv2Nd29xjyETFmtos6l6cLmJDL/cMo=;
	h=Subject:To:Cc:From:Date:From;
	b=XvqHlQvA5CHzMQhl0Cck8NTjwBf4AoecxM8N3WmuoKjfz5GZwShlGtivDYFpoMsid
	 WeH5chjcelL81ZUN0Z0oolbh/FaB7812B6bkr+uvVmKKWyf6rwzqCsDuppyzuFwa3n
	 cofED3c/v5B1pDPu54cFd2w5d+svrgrFq99j74pE=
Subject: FAILED: patch "[PATCH] media: venus: hfi: explicitly release IRQ during teardown" failed to apply to 5.10-stable tree
To: jorge.ramirez@oss.qualcomm.com,bod@kernel.org,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl,quic_dikshita@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:28:37 +0200
Message-ID: <2025082137-defiant-headstone-4d37@gregkh>
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
git cherry-pick -x 640803003cd903cea73dc6a86bf6963e238e2b3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082137-defiant-headstone-4d37@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


