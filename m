Return-Path: <stable+bounces-229644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKQHOF9twWnDTAQAu9opvQ
	(envelope-from <stable+bounces-229644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:42:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C62F8A0C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84B09304F6F2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6853BB9EE;
	Mon, 23 Mar 2026 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RD2TSPCb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4703AF662;
	Mon, 23 Mar 2026 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282480; cv=none; b=Nnyw0jk83HXhZLRLo0Mu3v0Ho0y/PELLy2i7UhS+ITngvUerN33jFdsa6TCDRDywEwGGGPqpvezyr4SsO2NmLSGX0czNqxhkiQPnOgJVKzmwJ/ePORfNRW/0D0BuKxm2hkHrzWwazErN7B+lYLerIvNkWvETHoRtf0XObfsXZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282480; c=relaxed/simple;
	bh=DnOpL8tw1x4wqIu1Plj4OxybrU3m2nXNmWcX+ApA36A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEo2XF3UDjkEDzmmyX35c/vbnAA+sILGRPg8QNHNF/gCxrVOkgA1fXnBg5C18j2EniUs4jEtOQTfA9KrMaE3jjuvw8voR0x/up97WwTHUADNN/BjlJATNclVArkCDOVkxe+ZG9ddnEsmYdFxVTqwMOU4QqOBjIWQeGPZ1n6pvbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RD2TSPCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E821FC4CEF7;
	Mon, 23 Mar 2026 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282480;
	bh=DnOpL8tw1x4wqIu1Plj4OxybrU3m2nXNmWcX+ApA36A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RD2TSPCbA4+gNIL23U6dlrFnoyFlBZwZMaTQFA6KeLInS9VrrhgICkVR+Qd1FI5/v
	 15/jFiQcy/g6ZCb5NFFjHLtlXRcu8JbCHvi/y+R83AydblXotCl+7rQ6Q8DWVEDEPV
	 BwNViP6OgdYVxQ549Bkxc2tC0CZMdfXn26nUn9a4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matteo Cotifava <cotifavamatteo@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 171/481] ASoC: soc-core: flush delayed work before removing DAIs and widgets
Date: Mon, 23 Mar 2026 14:42:33 +0100
Message-ID: <20260323134529.388091810@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229644-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 571C62F8A0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 835a9251c074b..c673453e8a747 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1905,6 +1905,9 @@ static void soc_cleanup_card_resources(struct snd_soc_card *card)
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




