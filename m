Return-Path: <stable+bounces-237554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFyFM40j3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-237554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:10:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ACA3F0E58
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A52930AE246
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55BE345CD0;
	Mon, 13 Apr 2026 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cEfKZs+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC4299929;
	Mon, 13 Apr 2026 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099754; cv=none; b=AXHuW12N1BykRIc8dgKS6PpXvCPjvpny9wNNLj29grOCJ1sUZc6LlFyPtuWkBxC4u10guw5gZH9ZdIyD/88KA1hxnJLi2FkmNrluiOkgtQawQ+Ha3ftzVN2S1qj6P31U/P+X4v6PgExtxNNgvEn+NEmf7J1w8EgyDvZ9ZhLJ+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099754; c=relaxed/simple;
	bh=knqkcp6pcOHCVJnrhYuQvBKeT7jZHhXpmbL38oZ3ujg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLzotIDpWAllkw4npRsxBlW6m5O/hpgiRg/7xI9OUxYjR+QxpxxT/mkJTKLVQ/6LATHeRCpKGvTHBAzwhbJdbN5+ilfu6eSua3fkTXX9v6wZRlAaCNe0JUYU2kkQ8qy6T4uiyR4ZX8ijnKsmvILTLpg7ly7BogDjs2mbtBL1iHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cEfKZs+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11282C2BCAF;
	Mon, 13 Apr 2026 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099754;
	bh=knqkcp6pcOHCVJnrhYuQvBKeT7jZHhXpmbL38oZ3ujg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEfKZs+Sc6w6zBxskuvKHlfzmXnQjsrDa+CqJ3CQ/mGZ5hsrWG9FImkSm7eaVlZfo
	 p0gibWAOysNQbST8mL5hM3+9Jxo7kWOPYsd1b8Ej+lQAgzAtMArWkizrwmlINJj6x/
	 nB6up1Nuq+qOW214uwFi+df/2Iv0+0gDW37Hmvis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.10 454/491] ASoC: soc-core: dont use discriminatory terms on snd_soc_runtime_get_dai_fmt()
Date: Mon, 13 Apr 2026 18:01:39 +0200
Message-ID: <20260413155836.033185311@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237554-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 72ACA3F0E58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 640eac4c849d6390f272862ba8db14f28d423670 upstream.

snd_soc_runtime_get_dai_fmt() is using discriminatory terms.
This patch fixup it.

Fixes: ba9e82a1c891 ("ASoC: soc-core: add snd_soc_runtime_get_dai_fmt()")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/874ke9dxkp.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1209,8 +1209,8 @@ found:
 		mask |= SND_SOC_DAIFMT_CLOCK_MASK;
 	if (!(dai_link->dai_fmt & SND_SOC_DAIFMT_INV_MASK))
 		mask |= SND_SOC_DAIFMT_INV_MASK;
-	if (!(dai_link->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK))
-		mask |= SND_SOC_DAIFMT_MASTER_MASK;
+	if (!(dai_link->dai_fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK))
+		mask |= SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
 
 	dai_link->dai_fmt |= (dai_fmt & mask);
 }



