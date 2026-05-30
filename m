Return-Path: <stable+bounces-257515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM9dIY8bG2pk/QgAu9opvQ
	(envelope-from <stable+bounces-257515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:17:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D45560F4DD
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F5C8300A59C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB7334BA42;
	Sat, 30 May 2026 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ne6Czp6s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B933016E1;
	Sat, 30 May 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161263; cv=none; b=Pp+hgYcYM4EXViv0bWy2EN/TecO8yWmm962D6YTpeqew2apFarkvGmBgFUBIM5T6UWWNnSw3Zw0z3c+muR7vd0pVLt4twLkGee3d9cqhY+bWyVtIcb6I/3442ze3prEw8HGa0wSjjOuNlFlXafXFa50Pm61mUtaGIvEtgTah8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161263; c=relaxed/simple;
	bh=OGmLmfXGke6wnHdbUYqw5L1YwrVKNKPfnFpfhcOEUiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry+W/v94TjjpKoktMZDQZtgKAkWmcXSj6ZG45Iw++cp16mLMPGwIJCK5uoMf0HalScJgVUfwQVy0Kl2ANf8vKhmQPhk64mNHIIcU6SYzyAIJXVvuabECn/ibvr6B/9KqX1meJtMWjUUAAimBDU3Zr5B8gdhU5cD/bM10Bu2frQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ne6Czp6s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446391F00893;
	Sat, 30 May 2026 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161261;
	bh=OQU3nMHl2tHoKKR1GShpvfAB4pZ7XvKO5sotehavscY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ne6Czp6sSSpkTZg6PjM/kswBkR5dA/OZAnmRc7QtwZD8t4yWhOMOX5XYn67wtwRBp
	 KEp6bELlCKwGm51K1Gblu1kpXZFAtp0VbaQIfONm5We3VNaWFHj3EoHBIfF6jF9qnY
	 QmcKxhyjESNrZ5yiQQw5yl5B0AnDTd8c7S3VDcGI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 532/969] ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_arc_mode_put()
Date: Sat, 30 May 2026 18:00:56 +0200
Message-ID: <20260530160315.054133724@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257515-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7D45560F4DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 1b61c8103c9317a9c37fe544c2d83cee1c281149 ]

ALSA controls should return 1 if the value in the control changed but the
control put operation fsl_xcvr_arc_mode_put() only returns 0 or a negative
error code, causing ALSA to not generate any change events.

Add a suitable check in the function before updating the arc_mode
variable.

Fixes: 28564486866f ("ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/20260401094226.2900532-8-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_xcvr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 5b61b93772d64..83b1d497fbf5f 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -97,10 +97,17 @@ static int fsl_xcvr_arc_mode_put(struct snd_kcontrol *kcontrol,
 	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int *item = ucontrol->value.enumerated.item;
+	int val = snd_soc_enum_item_to_val(e, item[0]);
+	int ret;
 
-	xcvr->arc_mode = snd_soc_enum_item_to_val(e, item[0]);
+	if (val < 0 || val > 1)
+		return -EINVAL;
 
-	return 0;
+	ret = (xcvr->arc_mode != val);
+
+	xcvr->arc_mode = val;
+
+	return ret;
 }
 
 static int fsl_xcvr_arc_mode_get(struct snd_kcontrol *kcontrol,
-- 
2.53.0




