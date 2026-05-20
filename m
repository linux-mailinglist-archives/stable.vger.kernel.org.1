Return-Path: <stable+bounces-251079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLVNIpTxDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:38:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE25942A7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 939FB30B3725
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290D83D8918;
	Wed, 20 May 2026 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="plEQ+6PZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468D364E89;
	Wed, 20 May 2026 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297044; cv=none; b=Fn5r0HroHzVjEES7xXhnjnvfxaZ9QsnfT8srKZAM4TKXJKIv7cDqn9R6zVNCrShb4NDe/gFAW9EQhR9VNyBXi709X7M/IsyOruLoTbMllfpMiiQkM3mqS5jNJ6zSI255IxJKEy5tnH+js5tf25UTVbXZ36H0besrvfcHZuDudlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297044; c=relaxed/simple;
	bh=ufnb1MVS9g1u69JFudKgthLanM6oPGCm/+8s0g+WAII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkX+8ZR3ny5+ImWezktM2VXLrTzu0Fd6iD6fqc5lvwAq/5oEn0HVPQ21N2fQ1edAZPg8JCtSEeIG86caEhQeouKaKCRIerCODFv7eOnNWAcx2yNVEzPuqq9mNm+rZ5nvI3LwEJQkJsBxSagXTWAddkD/HpBg8J6jFupDCDDzI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=plEQ+6PZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CD71F000E9;
	Wed, 20 May 2026 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297043;
	bh=fqm1kFWmrT3yvdqhctlfWTcwOI84+12sodl6AEjPIcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=plEQ+6PZnrTf9FSicClNVa8SGpBs8ICGo1E0nO98ZBKPlg2DpGh9UaDcaiDpzrVBM
	 TwexKRlPjwsO0krQ9lyeMT086EhWm6e6rvrtrEIKSu6HRDg2LGvlQX7/2BpofCc8My
	 eN/Ue3+y9xqR98KhZ3LVgK4XM1Y0j+QGPGioz0FU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 1002/1146] drm/amd/display: Allow embedded connectors without DDC
Date: Wed, 20 May 2026 18:20:52 +0200
Message-ID: <20260520162210.909928309@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251079-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gitlab.freedesktop.org:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: 28FE25942A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 494941aa772dab79251543764db6cd14bd337e43 ]

On some laptops, the embedded panel may not have
a DDC (display data channel) available. On these,
the EDID may be hardcoded in ACPI or the VBIOS.

In this case, use GPIO_DDC_LINE_UNKNOWN and don't fail.

Fixes: def3488eb0fd ("drm/amd/display: refactor HPD to increase flexibility")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5192
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 75b8a6ca0e8bc3ce24572f854e95f8721b321179)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc.h                | 2 +-
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 3 +++
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 4 +++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4c4239cac863d..8044c80971f04 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1638,7 +1638,7 @@ struct dc_scratch_space {
 	struct dc_link_training_overrides preferred_training_settings;
 	struct dp_audio_test_data audio_test_data;
 
-	uint8_t ddc_hw_inst;
+	enum gpio_ddc_line ddc_hw_inst;
 
 	uint8_t hpd_src;
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index a2c46350e44e8..95f8b7c7d657a 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -646,6 +646,9 @@ enum gpio_result dal_ddc_change_mode(
 enum gpio_ddc_line dal_ddc_get_line(
 	const struct ddc *ddc)
 {
+	if (!ddc)
+		return GPIO_DDC_LINE_UNKNOWN;
+
 	return (enum gpio_ddc_line)dal_gpio_get_enum(ddc->pin_data);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 21815ad01a295..409cc6e6cd846 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -549,7 +549,9 @@ static bool construct_phy(struct dc_link *link,
 		goto ddc_create_fail;
 	}
 
-	if (!link->ddc->ddc_pin) {
+	/* Embedded display connectors such as LVDS may not have DDC. */
+	if (!link->ddc->ddc_pin &&
+	    !dc_is_embedded_signal(link->connector_signal)) {
 		DC_ERROR("Failed to get I2C info for connector!\n");
 		goto ddc_create_fail;
 	}
-- 
2.53.0




