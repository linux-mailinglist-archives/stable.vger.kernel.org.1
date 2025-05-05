Return-Path: <stable+bounces-139686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7459AA9412
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2087A16745A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B91B255F2D;
	Mon,  5 May 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dZY2eAbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38723204592
	for <stable@vger.kernel.org>; Mon,  5 May 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450650; cv=none; b=Z91ZBHzE9lX2RwR0DFcuFpmowwCyIozpYNdZn2RA2qxWd0t+SPUwuHjDSyo84V44YGGruL2Y/lINmjIqMTrOYIBeEFq+r1RG+mLFSZn8I5vvawdzDNUUgfvgQI4iEUFWvc1LAIR4RiramgN+QFxLZH0CuofwlIjjkKG7uiR+6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450650; c=relaxed/simple;
	bh=1VDJPX8L/dB5XgHT7AyNd1J7K6OsnMvThuqtx8VSQco=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Uhyvx6Xs5zDK1ovqbZgKiyGI0mzcC1MNVP9ii1I0RC52B41eQiKDjj6jZDZLJmUVg4aMJ92mo/ANcGMJwI0x3KuXFijoz4hdEsB23YTllL/EIbIQU8w7jM2kPnQfkPpmIwN0NeZGup+8Huejpvd6IuL10A7GEb+iond7Vne1O7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dZY2eAbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0B4C4CEE4;
	Mon,  5 May 2025 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746450649;
	bh=1VDJPX8L/dB5XgHT7AyNd1J7K6OsnMvThuqtx8VSQco=;
	h=Subject:To:Cc:From:Date:From;
	b=dZY2eAbphwpn0qdUjZBPnX8Jo4iVHo9ZSMvMVeI7H0GsrFzPw/FJgybSRmItkw7k4
	 UMD36uqi1AB4VX6aKGqiOtMpGi4qZAPB36gczSGAiKys5ufnQAR0lDjXdOM5DaqB0u
	 pyw2f5US7t4XVDNqoUGhrGK/bR3c6dojPSCwWnxQ=
Subject: FAILED: patch "[PATCH] ASoC: soc-core: Stop using of_property_read_bool() for" failed to apply to 6.6-stable tree
To: geert+renesas@glider.be,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 15:10:46 +0200
Message-ID: <2025050546-commute-subduing-1917@gregkh>
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
git cherry-pick -x 6eab70345799
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050546-commute-subduing-1917@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6eab7034579917f207ca6d8e3f4e11e85e0ab7d5 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 22 Jan 2025 09:21:27 +0100
Subject: [PATCH] ASoC: soc-core: Stop using of_property_read_bool() for
 non-boolean properties

On R-Car:

    OF: /sound: Read of boolean property 'simple-audio-card,bitclock-master' with a value.
    OF: /sound: Read of boolean property 'simple-audio-card,frame-master' with a value.

or:

    OF: /soc/sound@ec500000/ports/port@0/endpoint: Read of boolean property 'bitclock-master' with a value.
    OF: /soc/sound@ec500000/ports/port@0/endpoint: Read of boolean property 'frame-master' with a value.

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Replace testing for presence before calling of_property_read_u32() by
testing for an -EINVAL return value from the latter, to simplify the
code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/db10e96fbda121e7456d70e97a013cbfc9755f4d.1737533954.git.geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3c6d8aef4130..26b34b688508 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3046,7 +3046,7 @@ int snd_soc_of_parse_pin_switches(struct snd_soc_card *card, const char *prop)
 	unsigned int i, nb_controls;
 	int ret;
 
-	if (!of_property_read_bool(dev->of_node, prop))
+	if (!of_property_present(dev->of_node, prop))
 		return 0;
 
 	strings = devm_kcalloc(dev, nb_controls_max,
@@ -3120,23 +3120,17 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 	if (rx_mask)
 		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-rx-mask", rx_mask);
 
-	if (of_property_read_bool(np, "dai-tdm-slot-num")) {
-		ret = of_property_read_u32(np, "dai-tdm-slot-num", &val);
-		if (ret)
-			return ret;
+	ret = of_property_read_u32(np, "dai-tdm-slot-num", &val);
+	if (ret && ret != -EINVAL)
+		return ret;
+	if (!ret && slots)
+		*slots = val;
 
-		if (slots)
-			*slots = val;
-	}
-
-	if (of_property_read_bool(np, "dai-tdm-slot-width")) {
-		ret = of_property_read_u32(np, "dai-tdm-slot-width", &val);
-		if (ret)
-			return ret;
-
-		if (slot_width)
-			*slot_width = val;
-	}
+	ret = of_property_read_u32(np, "dai-tdm-slot-width", &val);
+	if (ret && ret != -EINVAL)
+		return ret;
+	if (!ret && slot_width)
+		*slot_width = val;
 
 	return 0;
 }
@@ -3403,12 +3397,12 @@ unsigned int snd_soc_daifmt_parse_clock_provider_raw(struct device_node *np,
 	 * check "[prefix]frame-master"
 	 */
 	snprintf(prop, sizeof(prop), "%sbitclock-master", prefix);
-	bit = of_property_read_bool(np, prop);
+	bit = of_property_present(np, prop);
 	if (bit && bitclkmaster)
 		*bitclkmaster = of_parse_phandle(np, prop, 0);
 
 	snprintf(prop, sizeof(prop), "%sframe-master", prefix);
-	frame = of_property_read_bool(np, prop);
+	frame = of_property_present(np, prop);
 	if (frame && framemaster)
 		*framemaster = of_parse_phandle(np, prop, 0);
 


