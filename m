Return-Path: <stable+bounces-255446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DWgNSChGGqblggAu9opvQ
	(envelope-from <stable+bounces-255446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:10:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C2E5F7F64
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC2943032A9D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC66E335566;
	Thu, 28 May 2026 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ll1rkqt7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4FC2F691F;
	Thu, 28 May 2026 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998934; cv=none; b=A44wBl53qyMvCmQHH1+17ciNL0Upr/yfSrlNKVVSsTKGWYKbfWTBJKaNS/Y7sIapGDsO3kW97x7m0Ureo1/WS49oMfxmrRsWK+6Q6J1fQWvI/pXnIuYTV7dcDBpThBpUar9x0LZiliBF8JAH7Gd9p8ah710dEGi6NYAUQ/3d+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998934; c=relaxed/simple;
	bh=jgdM9xjSmbEb3VU58SlZtqhe9myn0sNi2XIAXKWtVSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYawKYOGNcNakUP6l0pGXWq5VOZFXJvc3ydQcyjfF+4BGPDGUlx09K92gdDdbbWubrG4DaKDjTJkdsClk32VrPpyfcRWdwEw0GzFawlzk3tHnaLRT2N71oQj2Gkx+dfALhwTI3AZMoHyRPVVy1Utxh2+b5KXAXx/WpC0Gk9MCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ll1rkqt7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED29B1F000E9;
	Thu, 28 May 2026 20:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998933;
	bh=PyQxcfE2JABASy9sPdHMnHKu/l2oIUY7CqY63W1UXTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ll1rkqt7R10jVnjDyrfA6dGPtP+7gzIFcks5DiWk4kYmlWyOBvtTDIz+PKA2aZt3F
	 GvfpR8oZq+867osb6wF7pivj2N7dXd+my5tpmY6pZ2DVJ5T8s0FxT1Z78nKIUOVsNv
	 xGwgic3S3fBGyGTMwpg+js8hVnxmFWLY4W2kUwa4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 348/461] ASoC: amd: acp-sdw-legacy: check CPU DAI name before logging
Date: Thu, 28 May 2026 21:47:57 +0200
Message-ID: <20260528194657.456971818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255446-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: A8C2E5F7F64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 1afd8f06dcb1d561af3b239c5b14a88b87c13454 ]

devm_kasprintf() can fail and return NULL. The legacy AMD SoundWire
machine driver logs cpus->dai_name before checking the allocation result.

Move the debug print after the NULL check, matching the ordering used by
the SOF AMD SoundWire path after commit 5726b68473f7 ("ASoC: amd/sdw_utils:
avoid NULL deref when devm_kasprintf() fails").

Fixes: 2981d9b0789c ("ASoC: amd: acp: add soundwire machine driver for legacy stack")
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260511-asoc-amd-acp-sdw-legacy-dai-name-null-v1-1-dc6151b6da8a@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index a9c8d9545281e..ae9579c8511eb 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -260,9 +260,9 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 			cpus->dai_name = devm_kasprintf(dev, GFP_KERNEL,
 							"SDW%d Pin%d",
 							link_num, cpu_pin_id);
-			dev_dbg(dev, "cpu->dai_name:%s\n", cpus->dai_name);
 			if (!cpus->dai_name)
 				return -ENOMEM;
+			dev_dbg(dev, "cpu->dai_name:%s\n", cpus->dai_name);
 
 			codec_maps[j].cpu = 0;
 			codec_maps[j].codec = j;
-- 
2.53.0




