Return-Path: <stable+bounces-231834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHp8D9b/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-231834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:09:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E0536E081
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 441ED309624E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637E5423A93;
	Tue, 31 Mar 2026 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nx+UQuFX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7D3E3C40;
	Tue, 31 Mar 2026 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975190; cv=none; b=h6qlbltg10ju6AT9f6XL4ZVFgNiXkIV89LHz4OJnH5ouJohp8b3dv0TMjjWpKJ2QTyiSZYssW0dbX6CsAdULOfr+J8+4zVd3jSyPWs9+tdsM/DOK8u2hjL6dXHoMxQkg0eSTGpOqxFp8qgErgmyhGJuJ2GIXUPayEOXD/QfvxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975190; c=relaxed/simple;
	bh=Wzmz8KT8SlinsEiir3v4YNzwRTadvINF7qj7CN85Z2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDjM/9FXT52PRrvmhvaGKfT/lLoos7nHxyaenJtlNg5kWul1GRMjF7UMV4KJin8KOycMJDgGsw/opSNHwmRrGAna0l9e0STWEm9SgxpAQqUIn054qxF/j+DQ1xirWOElsJvzcJJl1iWCDWi6fckSP8KSzN8UTofMwxBvP+soCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nx+UQuFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD2AC19423;
	Tue, 31 Mar 2026 16:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975190;
	bh=Wzmz8KT8SlinsEiir3v4YNzwRTadvINF7qj7CN85Z2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nx+UQuFXr1+M1hxo+9GSesJNuQZqP+hh/DFlECMx6cBq8N0p8P69rbelqvAwonwCE
	 plWK0r+Q0v9iqtnbLAKsk09cX+02H8Y+mJHNKAR1rmKsPVi3swk2/cF9jwkth90Jj7
	 9j7awtf0DRcBqfc8N2lXC8pbcLkgTTB2oEx5UIEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 165/342] ASoC: fsl: imx-card: initialize playback_only and capture_only
Date: Tue, 31 Mar 2026 18:19:58 +0200
Message-ID: <20260331161805.082740249@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231834-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email,msgid.link:url,nxp.com:email]
X-Rspamd-Queue-Id: 40E0536E081
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit ca67bd564e94aaa898a2cbb90922ca3cccd0612b ]

Fix uninitialized variable playback_only and capture_only because
graph_util_parse_link_direction() may not write them.

Fixes: 1877c3e7937f ("ASoC: imx-card: Add playback_only or capture_only support")
Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/20260318102850.2794029-3-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-card.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index 05b4e971a3661..a4518fefad690 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -710,6 +710,8 @@ static int imx_card_parse_of(struct imx_card_data *data)
 			link->ops = &imx_aif_ops;
 		}
 
+		playback_only = false;
+		capture_only  = false;
 		graph_util_parse_link_direction(np, &playback_only, &capture_only);
 		link->playback_only = playback_only;
 		link->capture_only = capture_only;
-- 
2.53.0




