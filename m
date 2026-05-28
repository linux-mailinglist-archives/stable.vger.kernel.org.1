Return-Path: <stable+bounces-255427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGEkLeOiGGrJlggAu9opvQ
	(envelope-from <stable+bounces-255427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:17:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 353495F84C3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFEA631C97A4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC343318EE1;
	Thu, 28 May 2026 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BqX2pRRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355832ABC0;
	Thu, 28 May 2026 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998879; cv=none; b=ba38gEaBPEmSGML+WZUzrlJ3Ei6I0FMNZWB2cxIBvaa9vIIn4BwU3tZiQ2dGaG0IBJwYsB8nCEsDH6hJECP2dByZemjGqVx5zXRlCnBiJNWqPRa+ygkbQkBS48OBSlTbIdvfaPURq/LLLoPjmmk/WPtqYvm8HMvZ7U76BsgqN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998879; c=relaxed/simple;
	bh=hkeE5hWeNFeUGSxYnt9nkh9wbINzuGbaCtFBt5n2Ek8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRYTAfpmh30PXLunlBk3wqb7ZLVM3EcpRCALJjdMeT54CohtxMp7NEr+Qa6XpSF4rkSlhP84TbsULLlF3V8cwRqLqZcg4sMkwac905petZLN2eQjd/NjrYAQfhcRj6ZeH6WwXdixS4NJvJhlAA5O0uIBbWs9agh7XhPNzDIYsqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BqX2pRRZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16BC1F00A3A;
	Thu, 28 May 2026 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998878;
	bh=JeyAQcwtia3yiyH3sPsOPsE+YZMRAoAFz3oKdT77C2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqX2pRRZmS2e9qxcu8Jr+5dg3fY3oEAHvE5wquuQumSym5Kx7iBt2mIPJ5/AJTKm9
	 ZN55hnRPDxTPGdQktRHdlFDiMP5ss8zioXNyt8GM/WJcUrTLejKgBKsBcObpctCSGX
	 2+OpiMuKFhD2XSSMpujb85aWRAY6TXWnodb/n0SU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 313/461] ASoC: sdw_utils: Check speaker component string allocation
Date: Thu, 28 May 2026 21:47:22 +0200
Message-ID: <20260528194656.349696481@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255427-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 353495F84C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 5a30862dec5a70da0a9d259de3f87a7542cc95b2 ]

devm_kasprintf() can fail while building the temporary speaker
component string. If that happens, spk_components is set to NULL, but
the current code can still pass it to strlen() on a later loop iteration
or after the loop when appending the speaker component list to
card->components.

Use NULL to represent the initial "no speaker components" state, and
return -ENOMEM immediately if building spk_components fails.

Fixes: 0f60ecffbfe3 ("ASoC: sdw_utils: generate combined spk components string")
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260512-asoc-sdw-utils-spk-components-alloc-v1-1-c9bbd6d2e123@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index bf6629dd48860..1b897c8c2c2ca 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -928,7 +928,7 @@ int asoc_sdw_rtd_init(struct snd_soc_pcm_runtime *rtd)
 	struct asoc_sdw_codec_info *codec_info;
 	struct snd_soc_dai *dai;
 	struct sdw_slave *sdw_peripheral;
-	const char *spk_components="";
+	const char *spk_components = NULL;
 	int dai_index;
 	int ret;
 	int i;
@@ -1011,7 +1011,7 @@ int asoc_sdw_rtd_init(struct snd_soc_pcm_runtime *rtd)
 			else
 				component = codec_info->dais[dai_index].component_name;
 
-			if (strlen (spk_components) == 0)
+			if (!spk_components)
 				spk_components =
 					devm_kasprintf(card->dev, GFP_KERNEL, "%s", component);
 			else
@@ -1019,13 +1019,15 @@ int asoc_sdw_rtd_init(struct snd_soc_pcm_runtime *rtd)
 				spk_components =
 					devm_kasprintf(card->dev, GFP_KERNEL,
 						       "%s+%s", spk_components, component);
+
+			if (!spk_components)
+				return -ENOMEM;
 		}
 
 		codec_info->dais[dai_index].rtd_init_done = true;
-
 	}
 
-	if (strlen (spk_components) > 0) {
+	if (spk_components) {
 		/* Update card components for speaker components */
 		card->components = devm_kasprintf(card->dev, GFP_KERNEL, "%s spk:%s",
 						  card->components, spk_components);
-- 
2.53.0




