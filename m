Return-Path: <stable+bounces-215226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JP3CGf1iWkaFAAAu9opvQ
	(envelope-from <stable+bounces-215226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:55:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B144B111352
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7BBB30626F1
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F80276028;
	Mon,  9 Feb 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tPmRDS/r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F4537998B;
	Mon,  9 Feb 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648096; cv=none; b=Uq/1eNeW5Wfm1Wytc4eqY8C6ge+xvOqLZx4M7twpd2Lo8hdX02PJSmgZAUXxSxKXhp5wKh6U2Jp8+qbDtKGVzx35cy0jO0Mj6wZ5j9+m3lSaxLC1V5djDYkS9nY+Qy2rDQVyN7qXEOhJG21/9H/yrmmRSrfvoAi8oOZ/3VL3n/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648096; c=relaxed/simple;
	bh=f9JUuATp1+kRZ4o2+nOltmscZXBm6cSWLM2aXtHPYos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6cR8laKq3JuXv15HOZZY+240MMKIazJT2uF3tSvxLeUwQqp9vW6erco2yBPQNFJNLeTPVm8TVCc20aFBYTt6a27iCV0SfRpMfhsDRHWjguvS/PxW4MFW+Ni1rAMa8XQ5E3RjTFhY8zsIe+1PckH0Pou57vYKVRoFwbW2mLg0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tPmRDS/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C321C16AAE;
	Mon,  9 Feb 2026 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648096;
	bh=f9JUuATp1+kRZ4o2+nOltmscZXBm6cSWLM2aXtHPYos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPmRDS/rnYbi9H6v6jjP2ZX3tQWsQQSMUbBnjKwtQypWRybkHvTx/HmfrAG6fGivI
	 En4o0PEZsNxu+Gz61rAVLR6nGsUOPdRU43OPCaF+DeZw8rjDMWrZ/+FgFXdMrIW04W
	 xJ+cNJwkSjMqWJedAK5FoVpI+1HO8Z7mV47JBmOE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 105/113] ASoC: amd: fix memory leak in acp3x pdm dma ops
Date: Mon,  9 Feb 2026 15:24:14 +0100
Message-ID: <20260209142313.947430684@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-215226-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: B144B111352
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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




