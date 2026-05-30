Return-Path: <stable+bounces-258398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI4jH0ApG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE126115BD
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72D9330D2D1A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F43AC0FC;
	Sat, 30 May 2026 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hzov1grU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1229B78B;
	Sat, 30 May 2026 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164219; cv=none; b=VgineHrr2mCbEn0GMeSo07qM/pMdwlmk3y6h7gAgiNpXpa/GjuSTwneMBNn1rAN13tpmIftOCeqjrCMl2MYN+J66/k8rokT5fm+4ucUQqaY0I3BQRZUUKI0cYZjki2C6fhA9THy4UrCXgh8Qpkiw8HVQf1t+ddUd+YkWerfTWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164219; c=relaxed/simple;
	bh=E11UvA47mCwWprDvCO9L7tV+L5cFAlmrlVWXSup5rWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzxbwtyqE8eVn4JXp3hZgKS+7pLuE8gOK9uW8BFurATI5atshpVbnxOJsAJ5UNu5EVDSiwSTfNT/ji7EkYs3/Am4+Z5mO3ZWtNRX/kNoUY4L3yWFv7IVTzGQehYrqDcO0ZAd01ewe56KfMwKaC/XMfpc3uXvpnvUZLn1reVkDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hzov1grU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4985C1F00893;
	Sat, 30 May 2026 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164218;
	bh=CUWW0kbdCdWYcFtV4nCoX8IHPS6jTG753BQwNCc4Xr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzov1grUsAWHNrfmRQXIED6aQsJQxtdea9LBLdI/jCgjzqSAl4bCho23+IOkCQb44
	 h2K3z5fzruq4OflmueZDkKICm9xahWnE3cvxHvSgo1NiJoc50zYuMFOL9OgbS5gHC4
	 7JuLAQwVBG0WoP9iJJJchIcY/oiDYpYzpE2iZ6pw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 462/776] ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_arc_mode_put()
Date: Sat, 30 May 2026 18:02:56 +0200
Message-ID: <20260530160252.297427736@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258398-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EEE126115BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index ae5960b2b6a95..7475dcf58a366 100644
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




