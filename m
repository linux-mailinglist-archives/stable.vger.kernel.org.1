Return-Path: <stable+bounces-220509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLHLDVI6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A11C66C7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBB1B325C8D6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0124481A90;
	Sat, 28 Feb 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SztrSJAA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F93CA79F;
	Sat, 28 Feb 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300393; cv=none; b=mjdMDZmANoP6YcSaaVYvmqglUbqssd6unTbrgox3PmLz299Vtj4aIjwHFcXZIcVglFx8FTxxQxr2UQ3GXhbjf6JjUQ177frJeiQsKeUqVfHRpDsJld0eHElDLariDx7f373wI3/nI+UnwMGc9bJn2+jhFxIoS9PDxRIpb38wArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300393; c=relaxed/simple;
	bh=8TGf0VU6GfG5Mi/G35xP1i+Vl1YCC2XhmyQds21Bc0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyHcv/o/qE5nfiGRL/AFpk8K9NxkP7cFXVDVQF1+uH7kK7QNxaR9clWHHSH2WwtfQgD8e4VkqOWmyAKbsYWlUi31RbOs+8Y6GSQgx3FmxJex2f/3TItanbuTpOeAHjqzhAR//Jir+uB3iSPb9DNOwUE2jL2ZtBC3wfHp7UxGDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SztrSJAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEB0C19425;
	Sat, 28 Feb 2026 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300393;
	bh=8TGf0VU6GfG5Mi/G35xP1i+Vl1YCC2XhmyQds21Bc0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SztrSJAA80ikq4QvDUS5tvIhnIrwUjq0RIqWkkcAQuD69VY7TFvc+hlXJXX+VgPOv
	 JyR54nW1TqlWlvgItfjTVP5I1qMOtDb0mVIJlnUd9pnIDj3k9A6PP2A0C/9Ko2vGnH
	 3bA1ShfTpo9N5VlrKTRovUO4c/D5+nvDwJpKwC3bcJl/MlsYcJBueQfNifkDPCzq7+
	 Rg5VWXlR0Gr0yC8qW0Yt9Y9vcdHe/aO1waKwTlYhriIRKFWceEnmM4xd5+oBaM0zkm
	 5FIc/Qi4HWe79G7UKgWrZluLX/ZbApOUYXzaIlCNSuc+l1Br26LRkQ60WXAGXCQ+/G
	 9ua///FQ6a+fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: YiLing Chen <yi-lchen@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 430/844] drm/amd/display: set enable_legacy_fast_update to false for DCN36
Date: Sat, 28 Feb 2026 12:25:43 -0500
Message-ID: <20260228173244.1509663-431-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220509-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BF0A11C66C7
X-Rspamd-Action: no action

From: YiLing Chen <yi-lchen@amd.com>

[ Upstream commit d0728aee5090853d0b9982757f5fb1b13e2e2b27 ]

[Why/How]
Align the default value of the flag with DCN35/351.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: YiLing Chen <yi-lchen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 6469d5fe2e6d4..a1132102afde4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -769,7 +769,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 };
 
 static const struct dc_check_config config_defaults = {
-	.enable_legacy_fast_update = true,
+	.enable_legacy_fast_update = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.51.0


