Return-Path: <stable+bounces-239586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMS2OAVi5mmavgEAu9opvQ
	(envelope-from <stable+bounces-239586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:27:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F5C4313BA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37195303B2BB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2B633A9FF;
	Mon, 20 Apr 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FGiK1f6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C192FE56A;
	Mon, 20 Apr 2026 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700632; cv=none; b=a4fm4PhO2jJYqLd0kMI/VHUzoqFGNi7CP6NXDwr8wtEjX3Gk2KUaHIgd9utLlDRWxr6jO3ok/R0m6cP9G8t8yBtvARwXE00zjM0QXA2isHXro4PVTw5Wp3JkPeGfaV456P1VQubcyXszDeOKh8tYCDB5dO8RRiYNWt6TjszmfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700632; c=relaxed/simple;
	bh=VWx00AEf15tBac2/9DvhtYbbtU/B+Zwlaq9OnMTyz1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYXqwoCCcnRCTVw608Xc2X37d/cIuwKcTKa6n5EPqVlw+oyS39CA8sGn/9GG1g886+fdUYCLTCBOORzcJ70QcAqFn97MtxzpM2OC5JeP7N3DofA/AKy8QwbqSRVga9N7DorwYEfovU4Oo5BhlxipS3b83KW4uCn+1N3nBHbc2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FGiK1f6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CDEC19425;
	Mon, 20 Apr 2026 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700632;
	bh=VWx00AEf15tBac2/9DvhtYbbtU/B+Zwlaq9OnMTyz1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGiK1f6PFPvUO5Sc8qDHdLqBRTuiKerLs5nxXGLXu4EgIl1vPOuAlR1xehEKs92Ck
	 vPgAt4iTondU3YExarUuWDvqhRzRO6adX3o7VoLSc8rmQTyuTlVPbq579sw0jZxNp2
	 zEuvPW9js3sy2qckm+hp7gHwxv5gVg0CkiCHbVk4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 027/198] ASoC: soc-core: call missing INIT_LIST_HEAD() for card_aux_list
Date: Mon, 20 Apr 2026 17:40:06 +0200
Message-ID: <20260420153936.594589354@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239586-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 04F5C4313BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit b9eff9732cb0f86a68c9d1592a98ceab47c01e95 ]

Component has "card_aux_list" which is added/deled in bind/unbind aux dev
function (A), and used in for_each_card_auxs() loop (B).

	static void soc_unbind_aux_dev(...)
	{
		...
		for_each_card_auxs_safe(...) {
			...
(A)			list_del(&component->card_aux_list);
		}			     ^^^^^^^^^^^^^
	}

	static int soc_bind_aux_dev(...)
	{
		...
		for_each_card_pre_auxs(...) {
			...
(A)			list_add(&component->card_aux_list, ...);
		}			     ^^^^^^^^^^^^^
		...
	}

	#define for_each_card_auxs(card, component)	\
(B)		list_for_each_entry(component, ..., card_aux_list)
						    ^^^^^^^^^^^^^

But it has been used without calling INIT_LIST_HEAD().

	> git grep card_aux_list sound/soc
	sound/soc/soc-core.c:           list_del(&component->card_aux_list);
	sound/soc/soc-core.c:           list_add(&component->card_aux_list, ...);

call missing INIT_LIST_HEAD() for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/87341mxa8l.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7a6b4ec3a6990..feecf3e4e38b4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2845,6 +2845,7 @@ int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->dobj_list);
 	INIT_LIST_HEAD(&component->card_list);
 	INIT_LIST_HEAD(&component->list);
+	INIT_LIST_HEAD(&component->card_aux_list);
 	mutex_init(&component->io_mutex);
 
 	if (!component->name) {
-- 
2.53.0




