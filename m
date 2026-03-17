Return-Path: <stable+bounces-226570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPB8F3qQuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:33:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA32AFCAA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 358E63288815
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC893F65F7;
	Tue, 17 Mar 2026 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zhxC9y1/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809B3F65F2;
	Tue, 17 Mar 2026 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767276; cv=none; b=ITWL+Svg+nL+uCyt8O+Fm0FMIDQhpxJRCZJW/21DmFEd2o1UCfNZxWs2FXD7RvrwwmEJlGG2dExP7s8tmTWwDTllmauKx59H5n6xe935TWy2Fpui9VuhyMNIg+MTdpurkQWqO9m8MWxHpGKws40aJ3HX2PDHOil/Iy6MpMvm4RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767276; c=relaxed/simple;
	bh=YODosPvtFiK2EB7DYBYU/0SN0yxH5wZA9InfrCHWINI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmFkRqK5Q/2FmxJ74EUjivlD3Afc9wvBzpSxjWDajJfUklZF7Clf6EcKggEDJHJwIbL7ws8lk4+yZUITDnkVmgOTaQ3ILzWSHjKUNbV4dtZspE+dnCBDLcXKElmumf5ve+RtMcQosDbh/VjOzkGLMdSeErGhBiDBKix4poYpnm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zhxC9y1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837B2C4CEF7;
	Tue, 17 Mar 2026 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767276;
	bh=YODosPvtFiK2EB7DYBYU/0SN0yxH5wZA9InfrCHWINI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zhxC9y1/T3hmAB7EwU76VDNjT2GNRisvA4KxeptUFPOk/2t4UGYp9nH9uBPhVcR1v
	 Ia2+8gpE0HKAuIM0UNtB9EemM0rPQMhRm7yJZBLC/ytHaeOElkEwaCglS1XPrSAarZ
	 L+WMnMkPtsT1mJtuteTujv2MgJpQ89hQl/940BtE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matteo Cotifava <cotifavamatteo@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 052/333] ASoC: soc-core: drop delayed_work_pending() check before flush
Date: Tue, 17 Mar 2026 17:31:21 +0100
Message-ID: <20260317163001.296757893@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226570-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7EA32AFCAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: matteo.cotifava <cotifavamatteo@gmail.com>

[ Upstream commit 3c99c9f0ed60582c1c9852b685d78d5d3a50de63 ]

The delayed_work_pending() check before flush_delayed_work() in
soc_free_pcm_runtime() is unnecessary and racy. flush_delayed_work()
is safe to call unconditionally - it is a no-op when no work is
pending. Remove the check.

The original check was added by commit 9c9b65203492 ("ASoC: core:
only flush inited work during free") but delayed_work_pending()
followed by flush_delayed_work() has a time-of-check/time-of-use
window where work can become pending between the two calls.

Fixes: 9c9b65203492 ("ASoC: core: only flush inited work during free")
Signed-off-by: Matteo Cotifava <cotifavamatteo@gmail.com>
Link: https://patch.msgid.link/20260309215412.545628-2-cotifavamatteo@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9dd84d73046be..3b98b3f6cd5fe 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -462,8 +462,7 @@ static void soc_free_pcm_runtime(struct snd_soc_pcm_runtime *rtd)
 
 	list_del(&rtd->list);
 
-	if (delayed_work_pending(&rtd->delayed_work))
-		flush_delayed_work(&rtd->delayed_work);
+	flush_delayed_work(&rtd->delayed_work);
 	snd_soc_pcm_component_free(rtd);
 
 	/*
-- 
2.51.0




