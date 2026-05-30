Return-Path: <stable+bounces-256969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMzBNEsRG2q/+ggAu9opvQ
	(envelope-from <stable+bounces-256969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:33:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564D60E3E7
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A80A6305A8A1
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C514346A04;
	Sat, 30 May 2026 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DLyAMSM0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B70348C55;
	Sat, 30 May 2026 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158235; cv=none; b=OHpQ72Q9lvwWQIxJmCJqppPA4H4hY0hYW34Wn2ahZFKno66b/RIzjuCwBf1fCUGKCotfAYXoGSIQywEDvnxBZmBqKfVBQAbg/vvc0+Lh9xpO6PVPL+qa18K9y4aJjjBQeTO/pXjWPYrZIXoBEuOtE5LCW5qVRQEcZNPjiNt4sOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158235; c=relaxed/simple;
	bh=VKddbiNwIzRDifmrB2HLWjqKeKzS54UafRIRLyWOj6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kqu1yFoMoxwnfOE4XLqomK768Rwg/T8+I8urz/rWDV567XEB7QQAT2uyeue3+SrGce53fuwHcDmWMXI5oFPGFDp9wltXeIJkj2PaJA0fu/hLDHASQMA0O9UxVC0E9PAb0pcTcKo4YAjS/dDlyNA9Bmu2kgf1ovQrP0d9N2itDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DLyAMSM0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8632E1F00893;
	Sat, 30 May 2026 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780158233;
	bh=8y63+ZBphIHokYV/0pCUDzCotT5pGHVEvj0QmhMsZSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DLyAMSM0SbHp0HPQbxfRq4aavcaEmyQVxjRCJMsHyLVihkVCbMCjIuWyNmzmyAaT0
	 NNbW/exzL9nath1LNuoCZm/gBf+xwUyt9sO+tuIDzLJJPQD3w+nPzvgbgLau9DkfIO
	 2253XFJw6S9rbFiDc7owihO5ApqR8YB6wFVOchHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 013/969] ASoC: soc-core: call missing INIT_LIST_HEAD() for card_aux_list
Date: Sat, 30 May 2026 17:52:17 +0200
Message-ID: <20260530160300.840189261@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-256969-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3564D60E3E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index dfd58d9db7c1f..33c991e578629 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2618,6 +2618,7 @@ int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->dobj_list);
 	INIT_LIST_HEAD(&component->card_list);
 	INIT_LIST_HEAD(&component->list);
+	INIT_LIST_HEAD(&component->card_aux_list);
 	mutex_init(&component->io_mutex);
 
 	component->name = fmt_single_name(dev, &component->id);
-- 
2.53.0




