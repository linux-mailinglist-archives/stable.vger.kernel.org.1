Return-Path: <stable+bounces-220255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEMBISEvo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E101C5748
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6967315D805
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30B379EC0;
	Sat, 28 Feb 2026 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od3LX1vk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1095375AC8;
	Sat, 28 Feb 2026 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300158; cv=none; b=CIslrpL82OACdka6+MmEdpt8/PVYfwTobnqAatf7KHMP3CgiTsLshDTddC2lKNEBuXrHL7y17i1Qbyx7Fg342IO6WnaPuT7ANRJ1YHyuwyq05Bk6XT3PIlKo1vveIxiaYLEEBhUDwEQvB0Qt3ZM3rNG4V7NcYP5R0Am+ePTgmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300158; c=relaxed/simple;
	bh=jpKIwh4BedLUAcItD23Wa7pLpbf3RV8K9IItLA6XWio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAJZ3129EfVtVwb9icmofFTwel3EoPkh6NndRf2rCVrWsuVnhia1VsEJw2/E0P/7bBnk+feZrtKhjhrgw4JNorks6kdR0Sq3IDu4p869k7I8k0j0kJOoRFLMvJf2lPPPeqasCarGYG9bPbgTLuC8F1g8/Qus2tLFWAGnQHv3YNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od3LX1vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14915C2BC87;
	Sat, 28 Feb 2026 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300158;
	bh=jpKIwh4BedLUAcItD23Wa7pLpbf3RV8K9IItLA6XWio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Od3LX1vk33gmOhtM7VMUvuxHUYm+dEfyUEToUqmUGiO8H/tumdL+j3H98bRwyMYsB
	 1hUNa7Sg9zWPSd2fnyufa280G8UmzHPzAxr7kRllgGA/KTEp1n2wCsKpxbNgwnMoQQ
	 y89hxqlG5ttLr3hGhoedHB3TsTmk/5B85N2n/dPCpQfkldYLw9eH2HZMmlcsjvFxRK
	 4bsqPgtmXjjR/EhswUpmgL+rKiLHuv5YJxB+NGXhNfPAC72T0Fuz90zJUYIeLrkvbg
	 g3HPtHPPvGJU4wJooS6EMz2TBc6svdwdJEYu8/LSV9tGTvLAxzz4wG/1bmT6RHX86O
	 u3383ybEqIX6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tuo Li <islituo@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 177/844] drm/panel: Fix a possible null-pointer dereference in jdi_panel_dsi_remove()
Date: Sat, 28 Feb 2026 12:21:30 -0500
Message-ID: <20260228173244.1509663-178-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linaro.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220255-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linaro.org:email]
X-Rspamd-Queue-Id: 16E101C5748
X-Rspamd-Action: no action

From: Tuo Li <islituo@gmail.com>

[ Upstream commit 95eed73b871111123a8b1d31cb1fce7e902e49ea ]

In jdi_panel_dsi_remove(), jdi is explicitly checked, indicating that it
may be NULL:

  if (!jdi)
    mipi_dsi_detach(dsi);

However, when jdi is NULL, the function does not return and continues by
calling jdi_panel_disable():

  err = jdi_panel_disable(&jdi->base);

Inside jdi_panel_disable(), jdi is dereferenced unconditionally, which can
lead to a NULL-pointer dereference:

  struct jdi_panel *jdi = to_panel_jdi(panel);
  backlight_disable(jdi->backlight);

To prevent such a potential NULL-pointer dereference, return early from
jdi_panel_dsi_remove() when jdi is NULL.

Signed-off-by: Tuo Li <islituo@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20251218120955.11185-1-islituo@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
index 23462065d726b..ea975170fafff 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
@@ -434,8 +434,10 @@ static void jdi_panel_dsi_remove(struct mipi_dsi_device *dsi)
 	int err;
 
 	/* only detach from host for the DSI-LINK2 interface */
-	if (!jdi)
+	if (!jdi) {
 		mipi_dsi_detach(dsi);
+		return;
+	}
 
 	err = jdi_panel_disable(&jdi->base);
 	if (err < 0)
-- 
2.51.0


