Return-Path: <stable+bounces-251487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO/4LXvzDWoF5AUAu9opvQ
	(envelope-from <stable+bounces-251487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:46:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68561594876
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C340311D5E1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4262B369999;
	Wed, 20 May 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jEHv/xeq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B039B975;
	Wed, 20 May 2026 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298111; cv=none; b=RmKuYMgy0Tlfucuel0URapOysp8cdmhyUsD4zDzWwzBsB2ZNCXVlwY5DFUKNW+73uXe9N4+O2Ixp/0IrQf5uUSf9Gw214msh7Rgao61eg7S0f9OxIyg8z3IHTA94ETW/UI88Q3H6pnZenhA+Q0amKRmLHyZSBt+bWVF9GswSRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298111; c=relaxed/simple;
	bh=5EHPtV8cn+/lEqW/pwEBYCHuPxrVgGpbJ/Q9Mwbt480=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+DWqSGg9ocjvPVGIEDzYII3ZITgLLiDYlxCkd01bK/TVCz++5e1vFTGiIUk6kHq6t8RN3n09E4Jq1znp04AAfLisnr40F9WQO0R+7r/xe0KvneCiQ99F193R7XFD1p3ETcoKqCp5Zh007R6k2n521wGC0TqRxDCnGfWx1YyIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jEHv/xeq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DF71F000E9;
	Wed, 20 May 2026 17:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298109;
	bh=Yqu4yLfOllwHoOO7uA8MMa0YoUX4d+kuKE1oppmpDjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jEHv/xeq0JBg0K8WXbqqmgikd52wuj8onyEF25Q0dYhGmHkJz7/eqyrZ+wyCAGbNE
	 L/+wj+rgy67BZcx/gyudc3Bn898hkVqLF5UKi4EkmvwWQOYKWbg4L9tLzOgEQtKKf3
	 WTDVSWS2lV7P0zy1ah0m8s2CAH9HaP5rPQRW1XRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 286/957] ASoC: fsl_micfil: Fix event generation in hwvad_put_init_mode()
Date: Wed, 20 May 2026 18:12:49 +0200
Message-ID: <20260520162140.741487497@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251487-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 68561594876
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 7e226209906906421f0d952d7304e48fdb0adabc ]

ALSA controls should return 1 if the value in the control changed but the
control put operation hwvad_put_init_mode() only returns 0 or a negative
error code, causing ALSA to not generate any change events.

Add a suitable check in the function before updating the vad_init_mode
variable.

Fixes: 29dbfeecab85 ("ASoC: fsl_micfil: Add Hardware Voice Activity Detector support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/20260401094226.2900532-4-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_micfil.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 668e6dbe5a712..36eefb7f0eb2f 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -336,13 +336,18 @@ static int hwvad_put_init_mode(struct snd_kcontrol *kcontrol,
 	unsigned int *item = ucontrol->value.enumerated.item;
 	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(comp);
 	int val = snd_soc_enum_item_to_val(e, item[0]);
+	bool change = false;
+
+	if (val < MICFIL_HWVAD_ENVELOPE_MODE || val > MICFIL_HWVAD_ENERGY_MODE)
+		return -EINVAL;
 
 	/* 0 - Envelope-based Mode
 	 * 1 - Energy-based Mode
 	 */
+	change = (micfil->vad_init_mode != val);
 	micfil->vad_init_mode = val;
 
-	return 0;
+	return change;
 }
 
 static int hwvad_get_init_mode(struct snd_kcontrol *kcontrol,
-- 
2.53.0




