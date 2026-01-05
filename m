Return-Path: <stable+bounces-204605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41548CF2BAB
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 949F63005314
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319B12D77EA;
	Mon,  5 Jan 2026 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zsxj7SSV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774F4C6C
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605192; cv=none; b=SaaBd2XXmX1c8+/XHEmI26OtoCruHScgCt/VHuFP/bXZoWo4vS+/WAuv7vCFgn14cf/kgj97uEsqk341kOE2iH+lZxfNe8hsFyL1N6Vd3vGxqOqN8u3/d/Vw/LCr6jCActnPn3t35MSzXXoF14XBrLxe2vjwZunSXS+MFqq/CU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605192; c=relaxed/simple;
	bh=ZEK4luNUlPs0yz1wiRYG7S6rPSfn0Z75uc8xxbiIrvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BqbZ9KNe76g/GuuAFwAmNvpsQ9uqvVlwDb8v2TZk+byxnUyJ8PBwWFvpGHfqwe7VDt52PUXE/Feadjqt8Zgbs4H0dsHtQj0RbTkfEAZL8yvdj1BfDm3gLDTsJm7RwSdb3sXVI+HrB+ulV+apvts9f3Wm79c6Zt5CfPvppJXcGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zsxj7SSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA7BC116D0;
	Mon,  5 Jan 2026 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767605192;
	bh=ZEK4luNUlPs0yz1wiRYG7S6rPSfn0Z75uc8xxbiIrvc=;
	h=Subject:To:Cc:From:Date:From;
	b=zsxj7SSV34cRgPmwT7fbbUXGvDt+vLjylQMYVoSHSC+P6lXnrmpqM2sIPu+UC9Y0w
	 50ZfBvigoarAi6HM1EhyP4QDttBwiZWSdkIm14hM/3WhicQoSiwygohOmL0ywjOqmG
	 8tAW6DX9uD57XmNRtbbpLfoPP+7pQyLW7yWItvXU=
Subject: FAILED: patch "[PATCH] ASoC: cs4271: Disable regulators in component_probe() error" failed to apply to 6.6-stable tree
To: herve.codina@bootlin.com,alexander.sverdlin@gmail.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 10:26:17 +0100
Message-ID: <2026010517-drool-consoling-04ab@gregkh>
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
git cherry-pick -x 1e5351ba60f5355809f30c61bbd27e97611d2be9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010517-drool-consoling-04ab@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e5351ba60f5355809f30c61bbd27e97611d2be9 Mon Sep 17 00:00:00 2001
From: Herve Codina <herve.codina@bootlin.com>
Date: Wed, 29 Oct 2025 10:39:18 +0100
Subject: [PATCH] ASoC: cs4271: Disable regulators in component_probe() error
 path

The commit 9a397f473657 ("ASoC: cs4271: add regulator consumer support")
has introduced regulators in the driver.

Regulators are enabled at the beginning of component_probe() but they
are not disabled on errors. This can lead to unbalanced enable/disable.

Fix the error path to disable regulators on errors.

Fixes: 9a397f473657 ("ASoC: cs4271: add regulator consumer support")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://patch.msgid.link/20251029093921.624088-3-herve.codina@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 0ed73ba3625c..f636900e0c1a 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -581,17 +581,17 @@ static int cs4271_component_probe(struct snd_soc_component *component)
 
 	ret = regcache_sync(cs4271->regmap);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulators;
 
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulators;
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN, 0);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulators;
 	/* Power-up sequence requires 85 uS */
 	udelay(85);
 
@@ -601,6 +601,10 @@ static int cs4271_component_probe(struct snd_soc_component *component)
 				   CS4271_MODE2_MUTECAEQUB);
 
 	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
+	return ret;
 }
 
 static void cs4271_component_remove(struct snd_soc_component *component)


