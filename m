Return-Path: <stable+bounces-211002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEeoHxEecWmodQAAu9opvQ
	(envelope-from <stable+bounces-211002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:42:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 390865B6D3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 014D4865680
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487BD37E30C;
	Wed, 21 Jan 2026 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDDwS3pN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D943376B8;
	Wed, 21 Jan 2026 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020107; cv=none; b=IVWmDAYO/Cz+YD1a5WHja6QyMPAuHWA+xlZmRkVC55LuhdapNYu64EYlZGLxA0DlPl4JzPTE7LxUPXD7ZpHu3L9WxIEULs+WJ3mg1dd6taKb4kthm22rMckciKpwoZEK9/9PuJmtCeS7uZgqoHWmpImqvrKGNvGlGJRGGAh9Ojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020107; c=relaxed/simple;
	bh=jDMHPYWn7X3pphlw/AE2c+X+XoYym7LJG/WY75T/Ba8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJix0yBYpATb6ORpkhWsMx/8ifcOb8DpyXFx8+jz7S7KIXmiL+J3gKYcvN2EtIKTKxKe9Jvxsd1hUZXiKFz7wtXz9BD6r4j7M9N7dsrysPLxSxb1OcSPyNNKXeqP13Kkmq/nxSnz3QNj9h/U7JwuQELpw+JIkAZVIR3iZpEEBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gDDwS3pN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515EEC4CEF1;
	Wed, 21 Jan 2026 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020106;
	bh=jDMHPYWn7X3pphlw/AE2c+X+XoYym7LJG/WY75T/Ba8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDDwS3pNe7mObUs+vXGDVLoPtBQOU8FVspEYlkY6IyWuSLYOdH1mc/GQzkw+PJnCe
	 5RrrqwxVkCmW9chopthM1v625jkUvA3t9O/MbdE5ERdykosAICmqQ4LreZEQNex1hR
	 kf7QwfWFLdPzm45/sZbMZ1CigwH9SrWXncpb5NEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 060/198] drm/amd/pm: fix smu overdrive data type wrong issue on smu 14.0.2
Date: Wed, 21 Jan 2026 19:14:48 +0100
Message-ID: <20260121181420.715708393@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-211002-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 390865B6D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit 90dbc0bc2aa60021615969841fed06790c992bde ]

resolving the issue of incorrect type definitions potentially causing calculation errors.

Fixes: 54f7f3ca982a ("drm/amdgpu/swm14: Update power limit logic")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e3a03d0ae16d6b56e893cce8e52b44140e1ed985)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 086501cc5213b..e735da7ab6126 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1701,8 +1701,9 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 		table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	CustomSkuTable_t *skutable = &pptable->CustomSkuTable;
-	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
+	int16_t od_percent_upper = 0, od_percent_lower = 0;
 	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+	uint32_t power_limit;
 
 	if (smu_v14_0_get_current_power_limit(smu, &power_limit))
 		power_limit = smu->adev->pm.ac_power ?
-- 
2.51.0




