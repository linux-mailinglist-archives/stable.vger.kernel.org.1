Return-Path: <stable+bounces-220206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPazEjIso2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:56:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B47BD1C53B3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91B953112B09
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA32E4D90D1;
	Sat, 28 Feb 2026 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyH0UAce"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E14D90CC;
	Sat, 28 Feb 2026 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300111; cv=none; b=XO80sIF25MKwwu43zvE+mRS4inplYKtnGhfeLUTKDpn1Qj247tgBpc6zvOir9ISBqP2dgBMKQBJit3ETjOlOLchBzgFjJ6n0EVzg18vd4miHVptaUPu1vaGDw28PTiTDeCrmTzdRMzOlun1ZcQXygyvWp8pL5pRrgqtRQ6ifF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300111; c=relaxed/simple;
	bh=Kjivy1/YxcWIrWPJjkwYGfoTheQc5bVZ6kO0ti60zlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEQtABeMVpObz/+D5F746kIvh9SY+DvqoXDbyaymu4Nz0HZ94Gag09lI+9td001cl1AVLGGcl3+jkgoYUUuHvKbNpKNhYenb0Aa36nN8XJpdyR1ug5KzQ8Q7G7LHaI/awvUvZHNbybtMrhH53PqCJQkDWlo/xSuUyGFsjKAAUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyH0UAce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA263C19423;
	Sat, 28 Feb 2026 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300111;
	bh=Kjivy1/YxcWIrWPJjkwYGfoTheQc5bVZ6kO0ti60zlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyH0UAceZElPYcQIuakOkkO6/V3HotwBbBvTsGkuW5Ck0q7kgCiuhuamAVtUWJHu5
	 lKVlS5GsWuVEw0MY0nJESw6W6rYvNLlDFxNKUSCDcs6lhXO2SF3MS3ogaudq9Hflxl
	 fytDEA1/Ognj2tnFWX1hA9HdfhsGidYPxx9uCMhxepJeRdsEs/xjtz+RqzsYG3uewp
	 tVVa4THoSUOkngyxloOukEOMUljLKq1U3O965eSJuRi8hZrMFnI3g4e3TStrJ15EaW
	 QnscTAphKzM4KYMZJ4OqTNmQ17r6UdmS5XFyb1F1XnoCVc7b/MEavrdR/2OgYEbR4F
	 SFrTpEXgyA9RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 128/844] gpu/panel-edp: add AUO panel entry for B140HAN06.4
Date: Sat, 28 Feb 2026 12:20:41 -0500
Message-ID: <20260228173244.1509663-129-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220206-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: B47BD1C53B3
X-Rspamd-Action: no action

From: Alexey Klimov <alexey.klimov@linaro.org>

[ Upstream commit 2976aeb0de77da599ad37691963efbdcb07435ce ]

Add an eDP panel entry for AUO B140HAN06.4 that is also used in
some variants of Lenovo Flex 5G with Qcom SC8180 SoC.

The raw edid of the panel is:

00 ff ff ff ff ff ff 00 06 af 3d 64 00 00 00 00
2b 1d 01 04 a5 1f 11 78 03 b8 1a a6 54 4a 9b 26
0e 52 55 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 14 37 80 b8 70 38 24 40 10 10
3e 00 35 ae 10 00 00 18 10 2c 80 b8 70 38 24 40
10 10 3e 00 35 ae 10 00 00 18 00 00 00 fe 00 41
55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 42 31 34 30 48 41 4e 30 36 2e 34 20 0a 00 eb

I do not have access to the datasheet and but it is tested on above
mentioned laptop for a few weeks and seems to work just fine with
timing info of similar panels.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20251203074555.690613-1-alexey.klimov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 023fbbb10eb4f..2c35970377431 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1904,6 +1904,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x643d, &delay_200_500_e50, "B140HAN06.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
-- 
2.51.0


