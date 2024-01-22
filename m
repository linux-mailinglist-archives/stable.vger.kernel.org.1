Return-Path: <stable+bounces-12778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D7C837367
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDA02888C2
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C12405C6;
	Mon, 22 Jan 2024 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XDdy0Q2J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298203B790
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953701; cv=none; b=Ta9090aiKMNceqPDGseZDvdQDCo5Qw1UHO/ZPAaU8dZRQpP2oCtozPyRB2uLoQEda/ssOVdmIcxj4OZw4+xtT91E2OcNaAW38UrBtqfPzZkK4kcZuV6OsdlKsnajtQeYkU1XUwB4UlVZABhye7hb5PnytOl2x8Wtcd/m04cSYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953701; c=relaxed/simple;
	bh=u8V0E5EP5mUByES5lAdvxOUCH6s9k2CACklPMRxNuo8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wwc/vrVV+UEhNDKd78G4bJ71Gc5EPNPj+Lk9IeKiTke+MM72jGqwjs7a6/zBLT0a/WzQrmIL9ygsgF2T7eLg3wWIDzjWEUwO0qKvx5jNw0egTsyzxqHu+K9r7Hq/P9He4TuYdUuUDEkQa2flZgWC4rVOacavwaV9dtyvsc1f7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XDdy0Q2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C71C433C7;
	Mon, 22 Jan 2024 20:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705953701;
	bh=u8V0E5EP5mUByES5lAdvxOUCH6s9k2CACklPMRxNuo8=;
	h=Subject:To:Cc:From:Date:From;
	b=XDdy0Q2JFT6sbVpJWwFdc+vtpANPKviuVdW284T5FHOYAsjL5VT3t7lN9SC8dk8ZA
	 migEbrWBy47fdhPZXH3gPtPJsOdJS3g8o3Q7DWV4rjNJkk0Ez5pKlf+Og4X6lQeZgB
	 07Cfgt8o0udQCUP16ewqlEIVg/WurI8XM2dsCMA4=
Subject: FAILED: patch "[PATCH] soundwire: fix initializing sysfs for same devices on" failed to apply to 5.15-stable tree
To: krzysztof.kozlowski@linaro.org,Vijendar.Mukunda@amd.com,broonie@kernel.org,pierre-louis.bossart@linux.intel.com,srinivas.kandagatla@linaro.org,vkoul@kernel.org,yung-chuan.liao@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:01:36 -0800
Message-ID: <2024012236-undertow-petroleum-5828@gregkh>
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
git cherry-pick -x 8a8a9ac8a4972ee69d3dd3d1ae43963ae39cee18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012236-undertow-petroleum-5828@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8a8a9ac8a497 ("soundwire: fix initializing sysfs for same devices on different buses")
92e9f10a0935 ("ASoC: intel: sof_sdw: Add helper to create a single codec DLC")
009582008182 ("ASoC: intel: sof_sdw: Allow direct specification of CODEC name")
656dd91a3a1c ("ASoC: Intel: sof_sdw: break earlier when a adr link contains different codecs")
1d1062382b18 ("ASoC: intel: sof_sdw: Use consistent variable naming for links")
0281b02e1913 ("ASoC: Intel: sof_sdw: add dai_link_codec_ch_map")
d3fc5c4da599 ("ASoC: Intel: sof_sdw: add multi dailink support for a codec")
5714aabdf971 ("ASoC: Intel: sdw_sof: append dai_type and remove codec_type")
cededa5a6486 ("ASoC: Intel: sof_sdw: add codec_info pointer")
b274586533f5 ("ASoC: Intel: sof_sdw: use predefine dailink id")
07140abbbf9e ("ASoC: Intel: sof_sdw: add dai info")
ba032909bb2d ("ASoC: Intel: sof_sdw: add missing exit callback")
f0c8d83ab1a3 ("ASoC: Intel: sof_sdw: start set codec init function with an adr index")
1785af9ff65d ("ASoC: intel: sof: use asoc_dummy_dlc")
dc5a3e60a4b5 ("ASoC: Intel: sof_sdw: append codec type to dai link name")
c8db7b50128b ("ASoC: Intel: sof_sdw: support different devices on the same sdw link")
06b830bd73ec ("ASoC: Intel: sof_sdw: remove late_probe flag in struct sof_sdw_codec_info")
ba7523bb0f49 ("ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.")
5c10da436ebd ("ASoC: Intel: sof_sdw: use common helpers for all Realtek amps")
8c4b3a8ea2c0 ("ASoC: intel: sof_sdw: add rt1318 codec support.")

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


