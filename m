Return-Path: <stable+bounces-210329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A527FD3A74A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 266C7300531C
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555B9318B9A;
	Mon, 19 Jan 2026 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iouW5sXL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2627FD62
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823241; cv=none; b=anX7+LF7kcIYKZw9k/ijh/imV67k9TblGagSC3+k03KvjA9oxFtJVVuXXmmY7A27U5PmxYYC+9IwSAEJHogH/BSF/TnByNJEBBsG4sdYVRdHW26x3NXJuvcE9L6etuARoPAqlsq4sb4ue2n5SpFrNaYIfJlNDzL9BSF1AXiup7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823241; c=relaxed/simple;
	bh=oe1jLMedk+ewy0EMAJx14pjXkO0E0srTOw/rvvwT4Ek=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GHvBNO2SzA8+f+aVuairTjtrpWkBtQ7dudbZI00q01nwGfoe/DIbUTNzP850hm8wDI6zkWpd34dD/ozx2h5F0+FI9jBICUlLcvzhjF4HYDu6vsd+fT2faVXOg5QCbgLVP5hySNHC6TTCrxy1gnEWnlqRLDOFp7Ow4YBa/a4eIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iouW5sXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96158C116C6;
	Mon, 19 Jan 2026 11:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768823240;
	bh=oe1jLMedk+ewy0EMAJx14pjXkO0E0srTOw/rvvwT4Ek=;
	h=Subject:To:Cc:From:Date:From;
	b=iouW5sXL0PJHLfoZ/KjMotEDi7DCE9pn0RpqWK85jRCNJweHmP/ATpL12vUoqvgnU
	 Nd9IcUe3qqcTnWqAPijbN0MGDfh/7myB4QkheBXiqmwy3cNnKr9n8wkVSQqgs1cNgx
	 Vzb6hQ+y/TElCrq1VlNAxzdANEujL7bmWskCRNRA=
Subject: FAILED: patch "[PATCH] ASoC: codecs: wsa883x: fix unnecessary initialisation" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org,krzysztof.kozlowski@oss.qualcomm.com,srini@kernel.org,srinivas.kandagatla@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Jan 2026 12:47:10 +0100
Message-ID: <2026011910-hazy-tubular-e9ab@gregkh>
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
git cherry-pick -x 49aadf830eb048134d33ad7329d92ecff45d8dbb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011910-hazy-tubular-e9ab@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49aadf830eb048134d33ad7329d92ecff45d8dbb Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 2 Jan 2026 12:14:10 +0100
Subject: [PATCH] ASoC: codecs: wsa883x: fix unnecessary initialisation

The soundwire update_status() callback may be called multiple times with
the same ATTACHED status but initialisation should only be done when
transitioning from UNATTACHED to ATTACHED.

This avoids repeated initialisation of the codecs during boot of
machines like the Lenovo ThinkPad X13s:

[   11.614523] wsa883x-codec sdw:1:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.618022] wsa883x-codec sdw:1:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.621377] wsa883x-codec sdw:1:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.624065] wsa883x-codec sdw:1:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.631382] wsa883x-codec sdw:1:0:0217:0202:00:2: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.634424] wsa883x-codec sdw:1:0:0217:0202:00:2: WSA883X Version 1_1, Variant: WSA8835_V2

Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
Cc: stable@vger.kernel.org	# 6.0
Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260102111413.9605-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index c3046e260cb9..3ffea56aeb0f 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -475,6 +475,7 @@ struct wsa883x_priv {
 	int active_ports;
 	int dev_mode;
 	int comp_offset;
+	bool hw_init;
 	/*
 	 * Protects temperature reading code (related to speaker protection) and
 	 * fields: temperature and pa_on.
@@ -1043,6 +1044,9 @@ static int wsa883x_init(struct wsa883x_priv *wsa883x)
 	struct regmap *regmap = wsa883x->regmap;
 	int variant, version, ret;
 
+	if (wsa883x->hw_init)
+		return 0;
+
 	ret = regmap_read(regmap, WSA883X_OTP_REG_0, &variant);
 	if (ret)
 		return ret;
@@ -1085,6 +1089,8 @@ static int wsa883x_init(struct wsa883x_priv *wsa883x)
 				   wsa883x->comp_offset);
 	}
 
+	wsa883x->hw_init = true;
+
 	return 0;
 }
 
@@ -1093,6 +1099,9 @@ static int wsa883x_update_status(struct sdw_slave *slave,
 {
 	struct wsa883x_priv *wsa883x = dev_get_drvdata(&slave->dev);
 
+	if (status == SDW_SLAVE_UNATTACHED)
+		wsa883x->hw_init = false;
+
 	if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)
 		return wsa883x_init(wsa883x);
 


