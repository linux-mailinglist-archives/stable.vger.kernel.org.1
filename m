Return-Path: <stable+bounces-92123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B20469C3DB7
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396F2B21EDD
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B10B18A6C2;
	Mon, 11 Nov 2024 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DqQEGbAc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7DE158866
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325823; cv=none; b=GgQanNKvGn7Z2jLO7KJDtG6rBX3FX7gIjOM8CeT426VjCxQ9CXGlRw0zk+6MDZnm45fMFkvwOsI8Q188EkZdwiAQ6vte6/I6TXXA+jPmQqHtVZyaJHLxdrak4+++7FAvf4baAQ5Fhi9R7NY/8nscF+wLTdU5+hji44hnO6s231Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325823; c=relaxed/simple;
	bh=Qu3YgbQ24RGenX2rHXEwxTRWuAa3FjyWx7LB74+wb4Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ReGbsUWqHuypSdE5BXKY7z8EsThauWdlmI1U5+aVtEpud0xHlAUGN88UYCxoEIGwGbWzQzQ7RNje+4ARwybYNCmgWLREUYjM+FJAXJVgVnLTRgR9Muu9Msvjl+0w2PAsN2uaGZUf2PJNZX6MSWoA6E1p2hogukbOeBrSQJaELw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DqQEGbAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39025C4CECF;
	Mon, 11 Nov 2024 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731325822;
	bh=Qu3YgbQ24RGenX2rHXEwxTRWuAa3FjyWx7LB74+wb4Q=;
	h=Subject:To:Cc:From:Date:From;
	b=DqQEGbAcqj81wGrhmS8NwjLK59EetezHANGRZ2smxC/k2Ui2aZgni6ePEGkUdpvg4
	 LHYAX6PiEOfmRDr0dpLhn+QHW0sXchPJN7XjGBOX/pykor0JIKoNf5IdvJTeKIf4Rm
	 SNWQST+PJjLxsyOZ6x89Qe857MX/916iG7qauGqc=
Subject: FAILED: patch "[PATCH] staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state" failed to apply to 6.6-stable tree
To: umang.jain@ideasonboard.com,dan.carpenter@linaro.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Nov 2024 12:50:19 +0100
Message-ID: <2024111118-underfoot-footrest-44b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 404b739e895522838f1abdc340c554654d671dde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111118-underfoot-footrest-44b3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


