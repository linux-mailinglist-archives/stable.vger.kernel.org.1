Return-Path: <stable+bounces-240747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ/wKKly62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:39:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D945F59E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AB5A301A714
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5403D47B0;
	Fri, 24 Apr 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UM/1N6P6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1A19A288;
	Fri, 24 Apr 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037732; cv=none; b=lqNKvtx8+bl4aysNCJ3mi9u7IASOauyjEubQDMDd4T+PuYHW3EU6PpH4cYyt7GxkMw8PhXzNmS/9Y5oLtwDIBKqQRAKkJMG1WXiukNKgAbTAk1V+Du4+/jpFZKLSSPtpLGXLkBykPsopSlyh+FsHOziI9szaLwIfs8LuvffGCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037732; c=relaxed/simple;
	bh=9Id83iAMKTpdXIKSVET4zeym2+wZLhpz1V/krXZDp1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQlzCax+IW9EqAxWZMraiW2yN3hAOwDHBeNHd4DWJZ1Yupphu86dYeR3AwPK9bJMPRHt9o+ZdSu55FcgiX/p0wksEB8QN7LoRAxCKqCCK6i3K5NG+GKtAkPOX7VthSsEXCoktemDU3WDdvhhOMsaFAPIK8cAQNBW7vIW5FYRGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UM/1N6P6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE23EC19425;
	Fri, 24 Apr 2026 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037732;
	bh=9Id83iAMKTpdXIKSVET4zeym2+wZLhpz1V/krXZDp1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UM/1N6P6saiPnyrw3nAoRm2k48s9gRIo+JmjiwQhlwd/FEp88sw2wfAmqIpasemab
	 dEC9YuUQD0eIvbS7VndU0xV98/lLvP87A7i+cp8PGdzQ/hPDLXzUjd7hrKUwAqVALe
	 4cNpQ1dZ2U7pzUZvWTkmr30Rf8KiSAw+jz5Nxr8I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 015/166] ASoC: soc-core: call missing INIT_LIST_HEAD() for card_aux_list
Date: Fri, 24 Apr 2026 15:28:49 +0200
Message-ID: <20260424132536.050170878@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 090D945F59E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-240747-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 696f5501a27bc..9cebe0ff9c07d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2681,6 +2681,7 @@ int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->dobj_list);
 	INIT_LIST_HEAD(&component->card_list);
 	INIT_LIST_HEAD(&component->list);
+	INIT_LIST_HEAD(&component->card_aux_list);
 	mutex_init(&component->io_mutex);
 
 	component->name = fmt_single_name(dev, &component->id);
-- 
2.53.0




