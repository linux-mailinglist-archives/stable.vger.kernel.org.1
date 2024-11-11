Return-Path: <stable+bounces-92125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB3F9C3DB9
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADC5283688
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F6918B46A;
	Mon, 11 Nov 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K4T33xYw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44744158866
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325832; cv=none; b=IyXidGIKQ5G3XRmI8ffGu3xazmWFbofz5hzOIZzB+IEg79YCgEk8Os4WwdOW0zLSuLWACm02o26q3mh/AfPs+na+VcH57etbA14TnMLk4pSSxAVgwlkzOQmSHvmUdtvN2/Ea9CXkmQojRrLwQZPc3fPy2O1L8kYRjaP8sB5rr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325832; c=relaxed/simple;
	bh=qYY1iEep+cKIgIVt8dmJVZuXrfK0V3JTG3pNUfYmCH8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UCcehZRfNh9ioxp6ecKX+oCiMd5HEfhxawn7MxJ19E4hA2iiptEE2ZTsy+6voL+pDz0eOnDG6yW9X2sUJKUEDeuM38VKWhfP5t+Ys2Rwty1wb+/PqRAETWudF3x9cX2H1g+6SvZakR80j436pG0rGWm5HuCef0TCQhc9WvPH/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K4T33xYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54016C4CECF;
	Mon, 11 Nov 2024 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731325831;
	bh=qYY1iEep+cKIgIVt8dmJVZuXrfK0V3JTG3pNUfYmCH8=;
	h=Subject:To:Cc:From:Date:From;
	b=K4T33xYw3nVW09Y2+8VsyB4zBmwk1kjdySyMp0V1tGRFoOeHhfxal6E3v6Wq2S6eG
	 uww3TZTzeRmaGI2jHc3FohWKd8n9+AvMBmlwF0TJDoJiYdNzo+2MkgWrstBGP35mDx
	 qRHt43+C11Uc1PAuUoGsEkFrtNgD1CKa7DaYkZks=
Subject: FAILED: patch "[PATCH] staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state" failed to apply to 5.15-stable tree
To: umang.jain@ideasonboard.com,dan.carpenter@linaro.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Nov 2024 12:50:25 +0100
Message-ID: <2024111124-riveting-exceeding-fd63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 404b739e895522838f1abdc340c554654d671dde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111124-riveting-exceeding-fd63@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 404b739e895522838f1abdc340c554654d671dde Mon Sep 17 00:00:00 2001
From: Umang Jain <umang.jain@ideasonboard.com>
Date: Wed, 16 Oct 2024 18:32:24 +0530
Subject: [PATCH] staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state
 allocation

The struct vchiq_arm_state 'platform_state' is currently allocated
dynamically using kzalloc(). Unfortunately, it is never freed and is
subjected to memory leaks in the error handling paths of the probe()
function.

To address the issue, use device resource management helper
devm_kzalloc(), to ensure cleanup after its allocation.

Fixes: 71bad7f08641 ("staging: add bcm2708 vchiq driver")
Cc: stable@vger.kernel.org
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/20241016130225.61024-2-umang.jain@ideasonboard.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3dbeffc650d3..0d8d5555e8af 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -593,7 +593,7 @@ vchiq_platform_init_state(struct vchiq_state *state)
 {
 	struct vchiq_arm_state *platform_state;
 
-	platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
+	platform_state = devm_kzalloc(state->dev, sizeof(*platform_state), GFP_KERNEL);
 	if (!platform_state)
 		return -ENOMEM;
 


