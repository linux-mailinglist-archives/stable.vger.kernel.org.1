Return-Path: <stable+bounces-250441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBENGoryDWrj4wUAu9opvQ
	(envelope-from <stable+bounces-250441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:42:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B48FE5945D5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DB923509697
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ED5372EF6;
	Wed, 20 May 2026 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GYZlhz9a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A436B05E;
	Wed, 20 May 2026 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295422; cv=none; b=de3oxCqegEGy9hMTBVxV2NfakxXni8Au8jr8NcxVNOu++nW5VMfkXNQOEDfjk7HbTlbUMmGEzk8ozL+vuQi73wWwvL/AsGckYOwZ5MTNftLZ5Xf8l34uoM2MiP03fEZP6K/1nid7uyjSMt5wrVHB3XvBIlB5yxHO594dbwx3/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295422; c=relaxed/simple;
	bh=sbcRiuvf5CP+gc1r99c4czjDTlmu/HHF6d738fiXHXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPlkCcmaiTFaBoJwpkB98UN5tFS8MhcY9V1JqIQyzBFMlL/Dnc2Gmj1UImJ+DXPl/+MVsFVk60NmmGBi26C5sh+cHt19kaskv61ojyx0tuzUQmnoaQrd/IKXSkloVvQKrw7yc5pVATqXnvIzwe8XmlOzjt7877K8VwShoQZ20qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GYZlhz9a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484561F000E9;
	Wed, 20 May 2026 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295421;
	bh=CrghPs43fBLUIFnkyRCXV83uORs5R4znmk9jxPjxV+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GYZlhz9aibEYBTX0oujzkKfRpUGIRrowDhooe6Todx1hZnszkhCZdcSLABjqRfrCV
	 7HAjzDnDb8ydWwyxbm7F08P2Cqk0lSXErh6Q0xrSukGUqqxKH9+xDXA1c3uy7vJTN6
	 NdnMlgKQBFyRtQgh71N4++S03FZgjlVEeOuHbhzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0413/1146] ASoC: amd: ps: fix the pcm device numbering for acp pdm dmic
Date: Wed, 20 May 2026 18:11:03 +0200
Message-ID: <20260520162157.545003307@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250441-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B48FE5945D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Syed Saba Kareem <syed.sabakareem@amd.com>

[ Upstream commit 3666dc0c47c399695d01fde7c36e08b14f834fa0 ]

Fixed PCM device numbering is required for acp pdm dmic pcm device
to have a common UCM changes.
Set the 'use_dai_pcm_id' flag true in acp pdm dma driver for acp 6.3
platform. This will fix the pcm device numbering based on dai_link->id.

Fixes: 33cea6bbe488 ("ASoC: amd: add acp6.2 pdm platform driver")
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Fixes: tag.
Link: https://patch.msgid.link/20260403100624.676953-1-syed.sabakareem@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/ps/ps-pdm-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index c6cd844d458c8..04c014349347e 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -352,6 +352,7 @@ static const struct snd_soc_component_driver acp63_pdm_component = {
 	.hw_params	= acp63_pdm_dma_hw_params,
 	.pointer	= acp63_pdm_dma_pointer,
 	.pcm_new	= acp63_pdm_dma_new,
+	.use_dai_pcm_id = true,
 };
 
 static int acp63_pdm_audio_probe(struct platform_device *pdev)
-- 
2.53.0




