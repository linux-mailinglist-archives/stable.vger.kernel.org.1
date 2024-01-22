Return-Path: <stable+bounces-12791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7648373AF
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0152A1F22905
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95824123B;
	Mon, 22 Jan 2024 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxavHk8f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6B41743
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955175; cv=none; b=Fj37GVXUz/W2RRdYWVtVnJ4efhybVV4yHKY6Qhaoajih0AQat20U97lTRTLhEFDnjW6lgNkOqlGu4cXlRK+5IrJMfUJC84C6cRYEjpKax5fWHL9pXwLHBECkMWeFYhK2NEzGAF6DETnQ6vIIXJ042Dh1UP9pDibpB77pXDGnPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955175; c=relaxed/simple;
	bh=FSpJMJyj0ZHp3+Vadr3O2C79ZGSDfI+G++mbRZYEdrE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KKmem5xsFMzkCLIJvL5xP06CoPOhY8O/yMjGqm/TvX++ARU1W0nnPIG/Vv8hUwAHHSQfKxazy3fKIFro5Hug+KX2K9ZWsavH9Tns58kzhm+0MdptJ0g7Z97uVzYnsL8kcvvzyE6ZIZV7jaeKQva9psK7KaPnXy0i6ZQ50UiU6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cxavHk8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2951DC433C7;
	Mon, 22 Jan 2024 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705955175;
	bh=FSpJMJyj0ZHp3+Vadr3O2C79ZGSDfI+G++mbRZYEdrE=;
	h=Subject:To:Cc:From:Date:From;
	b=cxavHk8f8yaweYTA8LuRcxjvAkByaaNy7oOeJ3kiq480DrO+59xRvFG1UIq6kggup
	 xjp2fnEBynqGCHitNhtH6EjsmYcXpXtw/7nyn61F5aEqRmHO3cFwIABQXLtK3C8X1f
	 XjTSAN8i/Qxi2G2l7Jcz19T1O0soz+RvoCnFExb0=
Subject: FAILED: patch "[PATCH] soundwire: fix initializing sysfs for same devices on" failed to apply to 6.6-stable tree
To: krzysztof.kozlowski@linaro.org,Vijendar.Mukunda@amd.com,broonie@kernel.org,pierre-louis.bossart@linux.intel.com,srinivas.kandagatla@linaro.org,vkoul@kernel.org,yung-chuan.liao@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:26:06 -0800
Message-ID: <2024012206-halogen-scarcity-a223@gregkh>
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
git cherry-pick -x 8a8a9ac8a4972ee69d3dd3d1ae43963ae39cee18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012206-halogen-scarcity-a223@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

8a8a9ac8a497 ("soundwire: fix initializing sysfs for same devices on different buses")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a8a9ac8a4972ee69d3dd3d1ae43963ae39cee18 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 17 Oct 2023 11:09:33 -0500
Subject: [PATCH] soundwire: fix initializing sysfs for same devices on
 different buses

If same devices with same device IDs are present on different soundwire
buses, the probe fails due to conflicting device names and sysfs
entries:

  sysfs: cannot create duplicate filename '/bus/soundwire/devices/sdw:0:0217:0204:00:0'

The link ID is 0 for both devices, so they should be differentiated by
the controller ID. Add the controller ID so, the device names and sysfs entries look
like:

  sdw:1:0:0217:0204:00:0 -> ../../../devices/platform/soc@0/6ab0000.soundwire-controller/sdw-master-1-0/sdw:1:0:0217:0204:00:0
  sdw:3:0:0217:0204:00:0 -> ../../../devices/platform/soc@0/6b10000.soundwire-controller/sdw-master-3-0/sdw:3:0:0217:0204:00:0

[PLB changes: use bus->controller_id instead of bus->id]

Fixes: 7c3cd189b86d ("soundwire: Add Master registration")
Cc: stable@vger.kernel.org
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20231017160933.12624-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index c1c1a2ac293a..060c2982e26b 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -39,14 +39,14 @@ int sdw_slave_add(struct sdw_bus *bus,
 	slave->dev.fwnode = fwnode;
 
 	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
-		/* name shall be sdw:link:mfg:part:class */
-		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x",
-			     bus->link_id, id->mfg_id, id->part_id,
+		/* name shall be sdw:ctrl:link:mfg:part:class */
+		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x",
+			     bus->controller_id, bus->link_id, id->mfg_id, id->part_id,
 			     id->class_id);
 	} else {
-		/* name shall be sdw:link:mfg:part:class:unique */
-		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x:%01x",
-			     bus->link_id, id->mfg_id, id->part_id,
+		/* name shall be sdw:ctrl:link:mfg:part:class:unique */
+		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x:%01x",
+			     bus->controller_id, bus->link_id, id->mfg_id, id->part_id,
 			     id->class_id, id->unique_id);
 	}
 
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 3312ad8a563b..690c279bbb88 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1232,11 +1232,11 @@ static int fill_sdw_codec_dlc(struct device *dev,
 	else if (is_unique_device(adr_link, sdw_version, mfg_id, part_id,
 				  class_id, adr_index))
 		codec->name = devm_kasprintf(dev, GFP_KERNEL,
-					     "sdw:%01x:%04x:%04x:%02x", link_id,
+					     "sdw:0:%01x:%04x:%04x:%02x", link_id,
 					     mfg_id, part_id, class_id);
 	else
 		codec->name = devm_kasprintf(dev, GFP_KERNEL,
-					     "sdw:%01x:%04x:%04x:%02x:%01x", link_id,
+					     "sdw:0:%01x:%04x:%04x:%02x:%01x", link_id,
 					     mfg_id, part_id, class_id, unique_id);
 
 	if (!codec->name)


