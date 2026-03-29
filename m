Return-Path: <stable+bounces-230825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAjJCnijyGnBoAUAu9opvQ
	(envelope-from <stable+bounces-230825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 05:58:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38497350983
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 05:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBDCF30074CE
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 03:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FEB2253EB;
	Sun, 29 Mar 2026 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruWNHOfY"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75A1DF755
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774756721; cv=none; b=JzCqfQ8On/Sxe4MIM8QyxLGJxlfJ/WAUqEs7dhpKyPmvzIxvOGCFRAedihcqM2qPdLaHuPPVdFaxzQpHH4BnPCi/nipvWuBdEb3Cqq45ud30WCZcErGJOd/pRspIUPWkUfXQmM4kUQbDiKtGho54LaRcy7lF7d6+P4BXy/N3B80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774756721; c=relaxed/simple;
	bh=sshz5FD1TgQ54dWoM4YPVAKYRwh8lH/QVA1oFvN8f8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3y35wDar1C10TVEGtvYYrTdeLI0/s3neT3PM4GuKLzqVlPAw/8VOWvLu9ZpxVDw2y0Rj62SUaeWpRo6yr6JwOUzJ8FN5xPqCGRLbus5Kyo1r7Kv+d+amUdGLSwHLPvkHoCiJDwG5g8MbEsBHZhI1xwHSvWB3qu0zDVeCdmURWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruWNHOfY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e4a04f059so3491324e87.2
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 20:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774756718; x=1775361518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LaBnkj4q34KLx3lNj+b95IrchjrEJG61P5Z/zGq1Xg=;
        b=ruWNHOfYazFA9O2XroiZ5Vwgi5GSE+njKR7Wk58dZ/mjjkuOdonbNLNyexLAzvBPY6
         sTn+zduMcpX2enMXvEsZEpcj+2dbkpEwGgxlU48Aq3zOpK/jb0N95mZZWGtyTksZav5f
         X2k1H3UYEclOFl4qTkAlom52FJK4lFzMjc8I8s+MInS3pUGzv6acgxlQp4pURAbEZzaq
         CdABtfKNyLA0e2mBiFmh5cnWGFEYR0wtp3rn4FtByx5lsUsCb7GcFbKJglxRvunZKa/t
         SJKggDyyiXw6RSUYJb8NMUAAF+Z4b39M+WVvdGJPNma/g0mdKTzn+3AdduyESFC/lOi1
         eFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774756718; x=1775361518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LaBnkj4q34KLx3lNj+b95IrchjrEJG61P5Z/zGq1Xg=;
        b=pSzAI+xD1ZXxRnvOXsef+BusxLZyMI720RXZCRMd2LhRdADNLux0aBwpTscrqqS6/D
         4j1/83WThjLwVL0hqjCT1QOJiClWAMMDtEMCFys33fGbmiRyYXW+s3QSmeO/PqyThtga
         0cZW/eFrpvBV4YdOZ/NoSvZREIvkCL/tVyB7vRJtw4ev7pskCCeRBD3j9xJHwNG2g7AZ
         XCjl73P+uv+M6vnZM0d9hm+rdP08F/Q2HqJ1yz+1m4TuqUdnymlXqGAFT267m2ygPBII
         AuxblCHx9UahzeaKFAZ3RHe4xICZlPTqJHhx4IhfAnTeVBv5dLZDE9/v8t/CnIkuY7OG
         Hq+g==
X-Forwarded-Encrypted: i=1; AJvYcCW/3uT1IHm049TsBLLfAaxe8YxVNXbgGfEKO065vL0WMjo8alEqZQBu7aSf1x1dgwoD+jd0Erk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWa/qfyNKClcIXsUaCGrcjvWSx/zrj1+BIE6iibXbUE/Hcc30
	R6Xf2USSmm25bocAzysnjp+KtTZehv+aU2ewoHHoSv384BJFCVWjjuc=
X-Gm-Gg: ATEYQzy5TY2gIBK2NXjIzK+L662SljTUGuFyLDj6NBZ+Txotl9PKp/Jnvuj9l99O62T
	IUiEE3HlrLAnKrrqX1FGrlkAQ1MMnNTqfpQz9/+a1oXASJCcku22qABcwfeNfmGB6AhVd51N/2F
	mb2RpjotpwTi6SGM38Lj34C/uwCD6XuoAQP5ATry+R6rMAQyUz3kRhwMkOb5kol56Esufe6O843
	yCTNNnX7A30jM97PuQPS8m5Lk2xsW5/P1cn6iPgFzbWqcg2KL54+RpM6u0zKiIpbUzsp9BgyyaW
	4AYDhTiAjjtKp6MjNP8D2FgfxcUO+D7lXvYIszZVawf62nE/SurNfM+8WswMO6x/hAXlhE3UFin
	wT9zM9CN0M2NxnF4n30yAqC7SYlTHAmWr+9cfoRG9TUv79yuI9SvG8lakdr4edCZtrdcs+AQf5/
	NKD0hzSNv9kejE0Z8wT6U8TTt3xUDQMRj0u/6eog==
X-Received: by 2002:a05:6512:39d2:b0:5a1:7434:6b2b with SMTP id 2adb3069b0e04-5a2ab925fbbmr2914375e87.27.1774756717809;
        Sat, 28 Mar 2026 20:58:37 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b13f41f4sm806136e87.13.2026.03.28.20.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 20:58:37 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	alex.deucher@amd.com,
	tom.chung@amd.com,
	Sbenazar <voroninan95ton@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] drm/amd/display: disable Panel Replay selective update on DCN 3.14
Date: Sun, 29 Mar 2026 06:58:29 +0300
Message-ID: <20260329035830.21953-4-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230825-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[voroninan95ton@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 38497350983
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On DCN 3.14 (Phoenix/Hawk Point, Radeon 780M), the DMCUB firmware
produces visual artifacts when Panel Replay operates in selective update
mode. The artifacts manifest as brief green/purple horizontal bands
during any screen content change — workspace switches, scrolling in
browsers, window management — and do not appear in screenshots,
confirming the corruption occurs at the display controller level rather
than in the compositor or rendering pipeline.

The issue is widely reported across multiple vendors (Framework 16,
Lenovo T14, HONOR MagicBook) and Linux distributions, tracked upstream
as drm/amd#5087. The current community workaround is to disable Panel
Replay entirely via amdgpu.dcdebugmask=0x410.

Rather than disabling Panel Replay altogether and losing its power
savings during static screen periods, disable only the selective update
component on DCN 3.14. With SU disabled, Panel Replay still allows the
panel to enter low-power mode when the screen is static, but any pixel
change triggers a full frame update instead of a partial one. This
avoids the DMCUB firmware's buggy SU code path while preserving the
primary power saving benefit of Panel Replay.

The DMCUB firmware on newer generations (DCN 3.2+) handles SU correctly
and is not affected by this change.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5087
Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 .../dc/link/protocols/link_edp_panel_control.c    | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1055,7 +1055,16 @@ static bool edp_setup_panel_replay(struct dc_link *link, const struct dc_stream_
 	if (link->replay_settings.replay_feature_enabled) {
 		pr_config_1.bits.PANEL_REPLAY_ENABLE = 1;
 		pr_config_1.bits.PANEL_REPLAY_CRC_ENABLE = 1;
-		pr_config_1.bits.PANEL_REPLAY_SELECTIVE_UPDATE_ENABLE = 1;
+		/*
+		 * Disable selective update on DCN 3.14 (Phoenix/Hawk Point).
+		 * The DMCUB firmware on this generation produces visual
+		 * artifacts during selective updates. Full frame updates
+		 * within Panel Replay still work correctly and preserve
+		 * static-screen power savings.
+		 */
+		pr_config_1.bits.PANEL_REPLAY_SELECTIVE_UPDATE_ENABLE =
+			(link->ctx->dce_version != DCN_VERSION_3_14) ? 1 : 0;
+
 		pr_config_1.bits.PANEL_REPLAY_EARLY_TRANSPORT_ENABLE = 1;

 		pr_config_1.bits.IRQ_HPD_ASSDP_MISSING = 1;
--
2.48.1


