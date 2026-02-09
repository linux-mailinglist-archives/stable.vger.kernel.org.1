Return-Path: <stable+bounces-215105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELQOGZHwiWnHEgAAu9opvQ
	(envelope-from <stable+bounces-215105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:34:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA572110785
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BDDA3004D95
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005BE285060;
	Mon,  9 Feb 2026 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jc2qIHjQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859F23D291;
	Mon,  9 Feb 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647691; cv=none; b=iIGXoqVj6ZTm6qzbmwcTE0hSJ7wNqtIfb80VKPs6ksFr+Q8pdS6r49JLA2eqEFNFdyXpAdZf1kf6lQNW8MSzlVXeWuFqmm37SffxCoS1xkySHv8p0D9x/8kUncRuDlkUMxOpp+otJhSHdmX3WrJ/1tmhBOge2tDuoKMhrYge0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647691; c=relaxed/simple;
	bh=NMoFxctIa8GNtjcrHDky5S4C1vRA7m+qWgXib/NQsro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEP12825s9fXZ3TY80HuXsGB9zbn6FF8YWdHnXGMkO9IW5mKxoVYqHizw8HzBz/G+57fIr3FNG669c54rBtDmvyBC3uEn4pyV/BMy1Fem55kDcSzrrd10jxXrJiyptk6ydw3aA5ZRzdwwt2pXItks6Zpj3QiLv6saJAwr5zB6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jc2qIHjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF8EC116C6;
	Mon,  9 Feb 2026 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647691;
	bh=NMoFxctIa8GNtjcrHDky5S4C1vRA7m+qWgXib/NQsro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jc2qIHjQmbkfvr4aWFCyhLNA9um3HDmlqQee72uzSNagU+iQfyz8JvYZ2tlifwsnJ
	 zkSy1p4N9QeqVRj7uQauz7fAtZWiYtmcyahNkrmqEH4GDJcRo/R37x0qZXsyHgJfLc
	 z1pcuwllkXVDiAiI5BRFMrhWF4KeI5rB3bmhQc8k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 161/175] ASoC: amd: fix memory leak in acp3x pdm dma ops
Date: Mon,  9 Feb 2026 15:23:54 +0100
Message-ID: <20260209142326.282923449@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-215105-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA572110785
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Bainbridge <chris.bainbridge@gmail.com>

[ Upstream commit 7f67ba5413f98d93116a756e7f17cd2c1d6c2bd6 ]

Fixes: 4a767b1d039a8 ("ASoC: amd: add acp3x pdm driver dma ops")
Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Link: https://patch.msgid.link/20260202205034.7697-1-chris.bainbridge@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 95ac8c6800375..a560d06097d5e 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -301,9 +301,11 @@ static int acp_pdm_dma_close(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream)
 {
 	struct pdm_dev_data *adata = dev_get_drvdata(component->dev);
+	struct pdm_stream_instance *rtd = substream->runtime->private_data;
 
 	disable_pdm_interrupts(adata->acp_base);
 	adata->capture_stream = NULL;
+	kfree(rtd);
 	return 0;
 }
 
-- 
2.51.0




