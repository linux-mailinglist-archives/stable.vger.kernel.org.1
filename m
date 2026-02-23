Return-Path: <stable+bounces-217759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFo6G2FLnGmODAQAu9opvQ
	(envelope-from <stable+bounces-217759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:43:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A3176549
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A1DE30B92A2
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63D8366811;
	Mon, 23 Feb 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC39kg3T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AB36829E;
	Mon, 23 Feb 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850289; cv=none; b=tV9FsKdUOgzKVlf9Xb1sOnfQ2pgQ9wrg+h6JmtrXC75eLvd/xDJKcWAKbL3oxxa20VqG2m+F9yR8GItU5cbNpOroBNAOM8wM6TlSvyZW90xojTSSSHfBjbkwqcNeDKeAuPiy+pG4kWJ+D8fJbY8UFgQzw4XjxbDUGX9Dq2YGHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850289; c=relaxed/simple;
	bh=piEMGXZwt8wLWfoaik1WxIGNNWEo8qL2QNNyNKrGrEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZJn3PCdEf88mcb5P8E7YCVtaPJk4AMLySlqgRyU0FZXGiPQFYIRnBfn5sXWFZlIDpWHK6YnIfAE+bghlpNygHh6h5fk9dsqIeBvivK5yKMZbsIWAl5C9Jg+LlmU33MSHgEUMJYoqJpCWn1fdDBnMzcbwkqvUbTn0FduEDz5EXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC39kg3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E5EC2BC86;
	Mon, 23 Feb 2026 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771850289;
	bh=piEMGXZwt8wLWfoaik1WxIGNNWEo8qL2QNNyNKrGrEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DC39kg3To/G/iH8uBAviqkTV5NDtM+9k3vUOe5XbEO7nKBRk2Vt6FbmB6G4jg30cl
	 Y8/8e3KdlovKP8RSEeKqbqid68NFUm0lQiDZmcy9KvelXxA5IZvQnfBhgIhw/92IuR
	 6jh2WwfU9PT4OJG9G1T2Zoq9z9918+0OIsrGmPnD+rElRLC3malUYUiNh/38BPUuKz
	 THFmIGwGz3fnm2WPD7j8Ady3/7zJWGbV+lOOIU5gsJAb4qfFdUFa7MJsKYyiNn3PU0
	 WYrAG4MAhXyvCG4jaDUaQw1qte1WbzJOBadT0jNob1P1LG1ZDm0d2KL1syAbZt3wR0
	 rQJXHb1dGA1rw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: YiLing Chen <yi-lchen@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] drm/amd/display: set enable_legacy_fast_update to false for DCN36
Date: Mon, 23 Feb 2026 07:37:25 -0500
Message-ID: <20260223123738.1532940-20-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217759-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: C54A3176549
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

LLM Generated explanations, may be completely bogus:

The background task completed but doesn't change my analysis. My
decision stands - this is a valid one-line bug fix for user-visible
display stuttering on DCN36 hardware.

**YES**

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


