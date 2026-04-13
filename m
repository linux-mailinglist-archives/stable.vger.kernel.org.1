Return-Path: <stable+bounces-236822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHDSCEQi3WndaAkAu9opvQ
	(envelope-from <stable+bounces-236822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:05:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF58F3F0ACE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 374CB306BC69
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0B238166;
	Mon, 13 Apr 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tRTE+PnG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCD5225A38;
	Mon, 13 Apr 2026 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097881; cv=none; b=trMpBQgogvTeGdyWj/6fhW7HHa1SFMI2a3I1KBfHx8EpifeuAlmni37V0hLMJ2kvlP2kdeBYIsZyLtIKl7WzNupI+BijHu0nR8Qx0Y4uLwLD9++a0FJWNZ25DXhZnRAG/QoJffUFrTCFgKYBhhhQ4kr79xcwsWLF2bmHs3TKx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097881; c=relaxed/simple;
	bh=BUIGF4i//ZngV6lgmUYGA27+fvjFROgmOkUV+o0V2ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diU6s204SckjeNALURdrNCbikZ/W4w2dfotZT2CMfl+tIBIGZCNE0OAp0WnJ4A473we73nUQKCSBZbA9r8wVrGowGNExT9UzO5OARnMEqrqtkfZBGu6oyvxe6esO3LIZYF1PAWJl7fWbQ3d1W2HyOqq56Bz00BBCyZFfWireDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tRTE+PnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8573BC2BCAF;
	Mon, 13 Apr 2026 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097880;
	bh=BUIGF4i//ZngV6lgmUYGA27+fvjFROgmOkUV+o0V2ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tRTE+PnGZEnutajDP778TKRONbhEI8AhyMxEiXGgkxzCRroaSJzi2h5k0vwtN6WHf
	 8VtkBP5azuqfcBj9ff/PDRtpIjxr3viLQBaSkhcuablJTu6IY9DGvnSUvyfFovWwRA
	 zPYGIFC5ndJ3z4XuD7UgSKZQBaaUEmfkaGQLJpUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 309/570] ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_put_bits()
Date: Mon, 13 Apr 2026 17:57:20 +0200
Message-ID: <20260413155842.073268995@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236822-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: AF58F3F0ACE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 54a86cf48eaa6d1ab5130d756b718775e81e1748 ]

ALSA controls should return 1 if the value in the control changed but the
control put operation fsl_easrc_iec958_put_bits() unconditionally returns
0, causing ALSA to not generate any change events. This is detected by
mixer-test with large numbers of messages in the form:

    No event generated for Context 3 IEC958 CS5
    Context 3 IEC958 CS5.0 orig 5224 read 5225, is_volatile 0

Add a suitable check.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20260205-asoc-fsl-easrc-fix-events-v1-1-39d4c766918b@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_easrc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 95ad4eeec4863..84ef6758cc003 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -52,10 +52,13 @@ static int fsl_easrc_iec958_put_bits(struct snd_kcontrol *kcontrol,
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
 	unsigned int regval = ucontrol->value.integer.value[0];
+	int ret;
+
+	ret = (easrc_priv->bps_iec958[mc->regbase] != regval);
 
 	easrc_priv->bps_iec958[mc->regbase] = regval;
 
-	return 0;
+	return ret;
 }
 
 static int fsl_easrc_iec958_get_bits(struct snd_kcontrol *kcontrol,
-- 
2.51.0




