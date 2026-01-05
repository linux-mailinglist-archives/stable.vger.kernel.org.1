Return-Path: <stable+bounces-204606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 165E7CF2BE7
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7F39300A52E
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8CC328255;
	Mon,  5 Jan 2026 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UVr6Ce13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48572302CBA
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605196; cv=none; b=euoIIAwBEu0ING0w4oOYEUgXXS26Vo6zDFC4VJ93pQGX/L1iUL1+/gzENa5VGVOemRRKK2MAuVY0b2pF+KCIQCxh9F0wEd/5ScMBCFVLrPMxdoxYW7asgyrizd/w5J316fLj1ding7Ac92SK+P7zWKT3rl7rDaWZI92QY+F7LbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605196; c=relaxed/simple;
	bh=YqYqdcWL2lemMaAqmUL4dKT7tm2JyC7A9PjZsHKr1cs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BP0jxZ44xsx4xuZJA05BiLpYJ0bwaWKTqZakTYxJzdwAbuehMwa1tsKL8i7NRqp6AfzX0rrEY19XNxfmEge+XTxIMcPQfvRTQeLyr7LabIhALqhVNoF6ZXrVfpBO11y2/toRtKME5BcNHUhhjT7vdXfhdncT3qEzOwcmMPWitSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UVr6Ce13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2F1C116D0;
	Mon,  5 Jan 2026 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767605195;
	bh=YqYqdcWL2lemMaAqmUL4dKT7tm2JyC7A9PjZsHKr1cs=;
	h=Subject:To:Cc:From:Date:From;
	b=UVr6Ce13p9sqqMqIZTs/U3Cv2nzmLNJbS+8ZncCYeXJf7LTwZJ2iMbJ7tWXx2xyOE
	 6vSO+2Lj/2qJm905TqNmSq8hYsQJ5ZBYeCGS5414fn9rLHuYiiwcRg7/uAQ+0fjDeG
	 LrFgt+rK5fmlKrwYYiWuRK0dEOddjWsmxeBIP3dQ=
Subject: FAILED: patch "[PATCH] ASoC: cs4271: Disable regulators in component_probe() error" failed to apply to 5.10-stable tree
To: herve.codina@bootlin.com,alexander.sverdlin@gmail.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 10:26:23 +0100
Message-ID: <2026010523-shallow-husband-a1cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1e5351ba60f5355809f30c61bbd27e97611d2be9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010523-shallow-husband-a1cd@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


