Return-Path: <stable+bounces-154922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC63AE1348
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F6119E14F4
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6193212FB8;
	Fri, 20 Jun 2025 05:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKq8IRCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9E380
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398433; cv=none; b=BmxiqAlkT/ldTs7CryC7IfDkplWw6XWpY+6yn+25/UkfD8houyckesZSADrBS7crJfJMijXBD6TwSLNNDleOkRHmxD28zOwB1QMWThVhWAzYBPNH2AhDNURt6E/HMs3mthEOZ86Qnu8M2eRGlOX/oAezWH8jnp2tSNPVN7B9bNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398433; c=relaxed/simple;
	bh=IJgJC3cr+IN75FxmXev5nhy3Q483/4UYXdEHX2CphJY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p1E1scJisKcUWLN6G9mmOT2MjEAf36DxK2U3wpyw+pK3sx+Esm774WFjlVxW+ZlwvaFNhDDKoYEfSDUVELybMBDkPdYpQyIvuPGpP9uqEyCg4+0iPOGaY0JHMlvs2fhQddjDZjOqeX0NDwqbQRdig7roMzMfOdq5fvk+WMsA2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKq8IRCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB232C4CEE3;
	Fri, 20 Jun 2025 05:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398433;
	bh=IJgJC3cr+IN75FxmXev5nhy3Q483/4UYXdEHX2CphJY=;
	h=Subject:To:Cc:From:Date:From;
	b=VKq8IRCVzbOuFiPi0OZaZLUvRd6EOGr0ySJS62MBeXcXlK+O6Pk/CUvf7kT0HBl+c
	 M7zMB1ZTtPzaJFZA0zoDwJ9jsDdToJIye/E81sHX5m5yJFSdZO3YQnvquBX8rttRot
	 s8mHhjT5Af9dx4Y4MS64wcGRLOZnF5iBaaeudtYw=
Subject: FAILED: patch "[PATCH] ASoC: meson: meson-card-utils: use of_property_present() for" failed to apply to 5.4-stable tree
To: martin.blumenstingl@googlemail.com,broonie@kernel.org,christianshewitt@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:45:24 +0200
Message-ID: <2025062024-swimming-dawdler-bce4@gregkh>
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
git cherry-pick -x 171eb6f71e9e3ba6a7410a1d93f3ac213f39dae2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062024-swimming-dawdler-bce4@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 171eb6f71e9e3ba6a7410a1d93f3ac213f39dae2 Mon Sep 17 00:00:00 2001
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 19 Apr 2025 23:34:48 +0200
Subject: [PATCH] ASoC: meson: meson-card-utils: use of_property_present() for
 DT parsing

Commit c141ecc3cecd ("of: Warn when of_property_read_bool() is used on
non-boolean properties") added a warning when trying to parse a property
with a value (boolean properties are defined as: absent = false, present
without any value = true). This causes a warning from meson-card-utils.

meson-card-utils needs to know about the existence of the
"audio-routing" and/or "audio-widgets" properties in order to properly
parse them. Switch to of_property_present() in order to silence the
following warning messages during boot:
  OF: /sound: Read of boolean property 'audio-routing' with a value.
  OF: /sound: Read of boolean property 'audio-widgets' with a value.

Fixes: 7864a79f37b5 ("ASoC: meson: add axg sound card support")
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://patch.msgid.link/20250419213448.59647-1-martin.blumenstingl@googlemail.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index cfc7f6e41ab5..68531183fb60 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -231,7 +231,7 @@ static int meson_card_parse_of_optional(struct snd_soc_card *card,
 						    const char *p))
 {
 	/* If property is not provided, don't fail ... */
-	if (!of_property_read_bool(card->dev->of_node, propname))
+	if (!of_property_present(card->dev->of_node, propname))
 		return 0;
 
 	/* ... but do fail if it is provided and the parsing fails */


