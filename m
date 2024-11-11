Return-Path: <stable+bounces-92124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA7D9C3DB8
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53EA28358D
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3225918A6C2;
	Mon, 11 Nov 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mL1Uw/Fj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A20158866
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325829; cv=none; b=e082bf9km14OgTZOGWruH0XwEnct2sG8l5JMacvd+uz0dv6cnUElengXim+LEZmP2A1OcCPyxXoCl8UCSovnzQMJxZxIR7nT8MlPANYhxCbZWse3kn7Im2kGua6a2az4Covfqh1FeAUOg7SCl7dN0VeaDnfK0Ko+OSmq8J22e7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325829; c=relaxed/simple;
	bh=kMjFusVcgt+GJFIJr7Dqn8NKw8ZZbHjNqYt2KKQPxy8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mZj+9AdvTG5NmyienZYp5k51WU5hzhOodCzQmaqitlZJylKf3f++gRIIdp/n4ffxvLvVH/KFy6f3KEfc2b4XgvqVLiGDGbKo2eE/BnqfTaLAMYL4V3Qp+GI1QZ0R1qPf042ldIaupoDux7cQVJiFzQHldrJIUYIzV/0NbGiqn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mL1Uw/Fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C23C4CECF;
	Mon, 11 Nov 2024 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731325828;
	bh=kMjFusVcgt+GJFIJr7Dqn8NKw8ZZbHjNqYt2KKQPxy8=;
	h=Subject:To:Cc:From:Date:From;
	b=mL1Uw/FjRg3DlHz178gThxQ3DdmNyMBoGimkHm8g9dosjvR7AnsTxwR2+1jHezqdn
	 extyqe+jA9PebyQBSLiNBmImy5oJmtPaHzhGsw38P+M/a0kDoQmfM6ePtndAVuGLcC
	 tnMXLMU56NXzLxL68y/IMAN1JZ8Z182vQ+D+Mc/E=
Subject: FAILED: patch "[PATCH] staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state" failed to apply to 6.1-stable tree
To: umang.jain@ideasonboard.com,dan.carpenter@linaro.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Nov 2024 12:50:22 +0100
Message-ID: <2024111121-reabsorb-jockstrap-464b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 404b739e895522838f1abdc340c554654d671dde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111121-reabsorb-jockstrap-464b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


