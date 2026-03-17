Return-Path: <stable+bounces-226571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH9TMvWKuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:10:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D272AF125
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0229B3074160
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67E3F65EF;
	Tue, 17 Mar 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EKNvJkaY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1C3F661E;
	Tue, 17 Mar 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767281; cv=none; b=BimeT+RsYWEh8h9JI5AZWjBpd/4K7QIWXShKg4kMT+nxxfi0CL3RHR6g8lK4bNX8DFbz4yS/IY+SabzB6Mu+W0aqx4f2/qlypzapzofwMIvJULRLXlgnjCyI2+otPQ8DmdZhAzVws0U1jQ+R8S0dmKLLapKmIc4shG9CpvJc4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767281; c=relaxed/simple;
	bh=R0e32i0fuQZ7KMr1UyWD266GE2+BzUFpM0doR9zEmOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jE5aDI9t3oKVGZpxMdZgXVl7SZ1z9yawzxuOTlOg7kVbrcpuCb3lWQSud4uXo4SbYNmSoWLYMc/9gmpUKLP84/VtbfGx1/5NdZsXTiwOoi3PRaJMnoQMnvD39GdWOvZ/vSoPJ42vbG1//7590ib3wqgx0nc4deoJ04YQKKKbue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EKNvJkaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368E7C2BC86;
	Tue, 17 Mar 2026 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767280;
	bh=R0e32i0fuQZ7KMr1UyWD266GE2+BzUFpM0doR9zEmOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKNvJkaYSNrfSlcaCnaGQViXUN8vL6UN0DFWUkauhy9YPaodf1ytKa27YteaqkkxA
	 RZIEite9A7kcSyiCZpCVfmgcpg5XSuvY0NQFKNN6p9jfqsEKyR1EnWa1z9Bv+2Auw/
	 wttP+146y41JQBREYdR8FDLLHbi5lmQwCH/5goIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matteo Cotifava <cotifavamatteo@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 053/333] ASoC: soc-core: flush delayed work before removing DAIs and widgets
Date: Tue, 17 Mar 2026 17:31:22 +0100
Message-ID: <20260317163001.333940004@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226571-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 54D272AF125
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: matteo.cotifava <cotifavamatteo@gmail.com>

[ Upstream commit 95bc5c225513fc3c4ce169563fb5e3929fbb938b ]

When a sound card is unbound while a PCM stream is open, a
use-after-free can occur in snd_soc_dapm_stream_event(), called from
the close_delayed_work workqueue handler.

During unbind, snd_soc_unbind_card() flushes delayed work and then
calls soc_cleanup_card_resources(). Inside cleanup,
snd_card_disconnect_sync() releases all PCM file descriptors, and
the resulting PCM close path can call snd_soc_dapm_stream_stop()
which schedules new delayed work with a pmdown_time timer delay.
Since this happens after the flush in snd_soc_unbind_card(), the
new work is not caught. soc_remove_link_components() then frees
DAPM widgets before this work fires, leading to the use-after-free.

The existing flush in soc_free_pcm_runtime() also cannot help as it
runs after soc_remove_link_components() has already freed the widgets.

Add a flush in soc_cleanup_card_resources() after
snd_card_disconnect_sync() (after which no new PCM closes can
schedule further delayed work) and before soc_remove_link_dais()
and soc_remove_link_components() (which tear down the structures the
delayed work accesses).

Fixes: e894efef9ac7 ("ASoC: core: add support to card rebind")
Signed-off-by: Matteo Cotifava <cotifavamatteo@gmail.com>
Link: https://patch.msgid.link/20260309215412.545628-3-cotifavamatteo@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3b98b3f6cd5fe..013437f845e06 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2118,6 +2118,9 @@ static void soc_cleanup_card_resources(struct snd_soc_card *card)
 	for_each_card_rtds(card, rtd)
 		if (rtd->initialized)
 			snd_soc_link_exit(rtd);
+	/* flush delayed work before removing DAIs and DAPM widgets */
+	snd_soc_flush_all_delayed_work(card);
+
 	/* remove and free each DAI */
 	soc_remove_link_dais(card);
 	soc_remove_link_components(card);
-- 
2.51.0




