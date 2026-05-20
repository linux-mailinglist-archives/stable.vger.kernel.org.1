Return-Path: <stable+bounces-252351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJweF6QkDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:16:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C836059AA18
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0BFC30D5FD1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B83A6B6D;
	Wed, 20 May 2026 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RBn3rare"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFE42A96;
	Wed, 20 May 2026 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300449; cv=none; b=c2L01CtOH1sRfsCNtX1DovFpWP+qCOH0SIoDZOs0fG9y0y1gbJeOM3Avo/+I3Pky+8I+Ysa+Fbx3J2BdwpKO6bwvqVmy4Rlf5fOYXsJFhpKcphvGO0KGApoLRDQa6R4j6foaWrkKIvqMKYWzeGS97GzQ3YGAajZDU6yDZ5H7CNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300449; c=relaxed/simple;
	bh=YM3VIwpbwn7DMWmPNaeQKeNrApCwMESXuR/YELSXhqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGqnNEGdDSYMgEcvjceN88iw2WRkfwcEnBLPmvrs19//fu15m5BI1ek0m1yXZMXuOBJ/N9XMo32b042JFHLKQRdbmyaMQxlPTys9UwDpAapTNkWio6mCc0c9J3UwqMT0fGgupC87++RelTwBrsyk+UYKuUDfqQZ+rj5ibosc1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RBn3rare; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA411F000E9;
	Wed, 20 May 2026 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300448;
	bh=2A/2DV7hCQHOOG/9r85ZAjzQcuBz5rcToDM6kGpjwVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RBn3rareTEa34bfISNr0IRWXymRHfJOZscxHGPHL67P+IAMjh6sqs7nUHWqZyw1LS
	 YjmFLw92pJBgsPIaIwPH4VH/QHeUmjuzFLYnudROAtxaET7tLnkBKmmK5UYsQ3Mp7c
	 NHwAOOsFtG01c8n8kXrO6Jl8OR9OrAet/NzhpIFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 180/666] drm/amd/pm/ci: Clear EnabledForActivity field for memory levels
Date: Wed, 20 May 2026 18:16:31 +0200
Message-ID: <20260520162115.101426610@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252351-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: C836059AA18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 5facfd4c4c67e8500116ffec0d9da35d92b9c787 ]

Follow what radeon did and what amdgpu does for other GPUs with SMU7.

Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (v3)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 1d99b4f9bc03e..1494143132eb5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -1217,7 +1217,7 @@ static int ci_populate_single_memory_level(
 	}
 
 	memory_level->EnabledForThrottle = 1;
-	memory_level->EnabledForActivity = 1;
+	memory_level->EnabledForActivity = 0;
 	memory_level->UpH = data->current_profile_setting.mclk_up_hyst;
 	memory_level->DownH = data->current_profile_setting.mclk_down_hyst;
 	memory_level->VoltageDownH = 0;
-- 
2.53.0




