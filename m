Return-Path: <stable+bounces-210996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILLiHUw7cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-210996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:47:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FEA5D8E0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DED218651F2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356DB35EDBB;
	Wed, 21 Jan 2026 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lhGHTo+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6F354AD6;
	Wed, 21 Jan 2026 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020086; cv=none; b=jkyFANTK3KtRerxwpIOo7yPQzqC8V/IIP9/zj8jkKxYboS7CCwNmM81s9K/NqwphJvwF77psBH+0STCIJ5ALUB6u3F0kX0vsfmBdE4l6WNjKBy56DqkjODfS0WxEB8IIsDTRzNsPbad5uQ8BV+dsD4d6MZR3pP7ZRymNzfFUX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020086; c=relaxed/simple;
	bh=gvYjolyc7bZYOLnjFQiT1JHiGgA35CVqrwyLse5XJMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O66lZ66yDij8LfJtAqjFCnG3Dk0sfhxvqJbsMVfWkg8Nb6IQyGuToOdbZN6JFMjuXfziKtbQJIkn55HrDwuThh/P3gRrVJFpq1//+cj2Z51fisLS2ael1FGHxx3j3wGdFwojD9PPAY2CA3RxDEqLmtZ3yu96V4oDGot/RuXFJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lhGHTo+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4C8C4CEF1;
	Wed, 21 Jan 2026 18:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020086;
	bh=gvYjolyc7bZYOLnjFQiT1JHiGgA35CVqrwyLse5XJMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhGHTo+4HC47PNX3xE8U+csh1CG3NklJ+DxjRqS++g9w+iEqALPJZ4H3VvJJ2T5Nz
	 VrF24w90DP82rhNZG8w++kuC80upAxH9nt37CD528zuQXHUzRyKUusivMoJHHWK1Dh
	 95Q2AmQ5lQ7kYID8J4g15LK691z+wlvbEdCaGsF4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Cole Leavitt <cole@unwrap.rs>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 055/198] ASoC: sdw_utils: cs42l43: Enable Headphone pin for LINEOUT jack type
Date: Wed, 21 Jan 2026 19:14:43 +0100
Message-ID: <20260121181420.534856518@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210996-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,cirrus.com:email]
X-Rspamd-Queue-Id: 17FEA5D8E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cole Leavitt <cole@unwrap.rs>

[ Upstream commit 390caeed0897fcac75f3c414dbdd85d593183d9c ]

The CS42L43 codec's load detection can return different impedance values
that map to either HEADPHONE or LINEOUT jack types. However, the
soc_jack_pins array only maps SND_JACK_HEADPHONE to the "Headphone" DAPM
pin, not SND_JACK_LINEOUT.

When headphones are detected with an impedance that maps to LINEOUT
(such as impedance value 0x2), the driver reports SND_JACK_LINEOUT.
Since this doesn't match the jack pin mask, the "Headphone" DAPM pin
is not activated, and no audio is routed to the headphone outputs.

Fix by adding SND_JACK_LINEOUT to the Headphone pin mask, so that both
headphone and line-out detection properly enable the headphone output
path.

This fixes no audio output on devices like the Lenovo ThinkPad P16 Gen 3
where headphones are detected with LINEOUT impedance.

Fixes: d74bad3b7452 ("ASoC: intel: sof_sdw_cs42l43: Create separate jacks for hp and mic")
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
Link: https://patch.msgid.link/20260114025518.28519-1-cole@unwrap.rs
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdw_utils/soc_sdw_cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_cs42l43.c b/sound/soc/sdw_utils/soc_sdw_cs42l43.c
index b415d45d520d0..3e8e2e3bdf7c5 100644
--- a/sound/soc/sdw_utils/soc_sdw_cs42l43.c
+++ b/sound/soc/sdw_utils/soc_sdw_cs42l43.c
@@ -44,7 +44,7 @@ static const struct snd_soc_dapm_route cs42l43_dmic_map[] = {
 static struct snd_soc_jack_pin soc_jack_pins[] = {
 	{
 		.pin    = "Headphone",
-		.mask   = SND_JACK_HEADPHONE,
+		.mask   = SND_JACK_HEADPHONE | SND_JACK_LINEOUT,
 	},
 	{
 		.pin    = "Headset Mic",
-- 
2.51.0




