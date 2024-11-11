Return-Path: <stable+bounces-92127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C7C9C3DBC
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EA71F226BF
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EAC18B46A;
	Mon, 11 Nov 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LUEFAmLV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6218A6C2
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325841; cv=none; b=adxhAIvFmLuhXXX4D5jY2/SWF9fRlOMvkozrNwt5JPBL9CtieQDYISl9BSJGwe4deFyQnV0qiMgEVAVD9Iw6QjT6Ib0DOym0DJJR3b79k0IG5YTo5NAkGxh2kjp0FT48gf+QBF+NFurcG6ck/Z5OsAVHl8V2NmvFPXRhyO7roSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325841; c=relaxed/simple;
	bh=Wa2f/QM1d1MHEBoYcqHBAklitZ+C0Gd2KQV1RAUaBRc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kD4KJp2WGWei6BUvZqPnfIdGk7cxMyuo59mvXmFhR04Hy2PwEP+eJApA478t69HxuEsWR58+O6uTpfX9XFJ+l27RgbVRrZD+Rzrjvt9DboYpASdCRUr7HSV83QbeV2C0ipYr2kdOkGrZoDZGiOcN98/ZTrTwgghpFUuk+dCbn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LUEFAmLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D441EC4CECF;
	Mon, 11 Nov 2024 11:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731325841;
	bh=Wa2f/QM1d1MHEBoYcqHBAklitZ+C0Gd2KQV1RAUaBRc=;
	h=Subject:To:Cc:From:Date:From;
	b=LUEFAmLVm9Jyy0pInwevTgx0QzPlBRmirq6dqSDxQMQ3rtdgdzpCJ9UUKZgPYiXCX
	 02MTdkW+voBVqWuNHnj7bqGlRw7a2KmxoynOaPIpmCgELPHd0wdvZVkklmang1CzBV
	 8UC8pBViuLWKdzgG8guKAwNaQF+TQsMZe5uZIEUQ=
Subject: FAILED: patch "[PATCH] staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state" failed to apply to 5.4-stable tree
To: umang.jain@ideasonboard.com,dan.carpenter@linaro.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Nov 2024 12:50:31 +0100
Message-ID: <2024111130-spearman-gratified-fd88@gregkh>
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
git cherry-pick -x 404b739e895522838f1abdc340c554654d671dde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111130-spearman-gratified-fd88@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


