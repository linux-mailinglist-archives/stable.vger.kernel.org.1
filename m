Return-Path: <stable+bounces-70177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A903595F052
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64675286A7A
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D550614A4D9;
	Mon, 26 Aug 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GPNg2kCG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84B15532A
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673728; cv=none; b=D0ToPdcyRCkNVJ0WfIN+ajp3CVFYrVMBuKDSv2Fu0dY9ckCn1DUvIzD5dhOq5taxxWGS1Y5HvCLTgANLi56lhu5bQMOj8BK2BNNbogvorVtBoltf69KftpbUpJ6zYS2EfKSr0AWeYOukzlUu4hlAYJGeGhMc7gm5A0Xn7MWX8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673728; c=relaxed/simple;
	bh=ywXsdfRgkWan0b/7dOI3sMYXYHsalMb6Be3XO3gAB+k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EeArkxnBSA5P6q3Y4WjQO2KJpsT17FkgBVEzy4VHnJRZty36jfNS3u18RslY42Pi1H1IoGnsC5lpE74FnwXz6+lBmgT/oiQFFpZJXA6YufVX1Ma3JIFt3un0+iOCBtJlilXg0oW9cWM+EO34/hc2fyseYhrzgfF6mEO80J0DwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GPNg2kCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B0DC51400;
	Mon, 26 Aug 2024 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724673728;
	bh=ywXsdfRgkWan0b/7dOI3sMYXYHsalMb6Be3XO3gAB+k=;
	h=Subject:To:Cc:From:Date:From;
	b=GPNg2kCG/i3pfP62LzTOenq8gDwFgm5pYTOZdgcZXXL3VRGJpC/++/BsuD7FcTUw5
	 vwBUt5PMqavnzcpXxjKo5oOR2p0iMnmvYo2+cCoDlpyFjpdKHOA0exfN8a6MbtQw+Z
	 ov3+Eh5P2ucn8QPxqnwpkJVkVThzeq4uovuzbpLk=
Subject: FAILED: patch "[PATCH] thermal: of: Fix OF node leak in thermal_of_zone_register()" failed to apply to 6.1-stable tree
To: krzysztof.kozlowski@linaro.org,daniel.lezcano@linaro.org,rafael.j.wysocki@intel.com,stable@vger.kernel.org,wenst@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:01:57 +0200
Message-ID: <2024082656-step-coeditor-e1ab@gregkh>
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
git cherry-pick -x 662b52b761bfe0ba970e5823759798faf809b896
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082656-step-coeditor-e1ab@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

662b52b761bf ("thermal: of: Fix OF node leak in thermal_of_zone_register()")
698a1eb1f75e ("thermal: core: Store zone ops in struct thermal_zone_device")
9b0a62758665 ("thermal: core: Store zone trips table in struct thermal_zone_device")
755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
d654362d53a8 ("Merge tag 'thermal-v6.8-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into thermal")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 662b52b761bfe0ba970e5823759798faf809b896 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 21:58:22 +0200
Subject: [PATCH] thermal: of: Fix OF node leak in thermal_of_zone_register()

thermal_of_zone_register() calls of_thermal_zone_find() which will
iterate over OF nodes with for_each_available_child_of_node() to find
matching thermal zone node.  When it finds such, it exits the loop and
returns the node.  Prematurely ending for_each_available_child_of_node()
loops requires dropping OF node reference, thus success of
of_thermal_zone_find() means that caller must drop the reference.

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20240814195823.437597-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 30f8d6e70484..b08a9b64718d 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -491,7 +491,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+		ret = PTR_ERR(trips);
+		goto out_of_node_put;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -519,6 +520,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
+	of_node_put(np);
 	kfree(trips);
 
 	ret = thermal_zone_device_enable(tz);
@@ -533,6 +535,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 out_kfree_trips:
 	kfree(trips);
+out_of_node_put:
+	of_node_put(np);
 
 	return ERR_PTR(ret);
 }


