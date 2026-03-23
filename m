Return-Path: <stable+bounces-228487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHd7BxpNwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:24:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6082F464A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80DA0303BD33
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A756E3AE1B9;
	Mon, 23 Mar 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="swfXJFYE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD543A9D9D;
	Mon, 23 Mar 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275263; cv=none; b=vGjxXLqTICpTz0VLsDeUEBVoazbyoPZWQnQDRWrNq4trOftHLVOVE1naYMNoGrI+vElHg1bbPbZH3BWAL5ObUnCTSgWXueSgZtFi64aCtpKfwzIrJ7xshLpfk5aShRL0tXK/nNbcov/6HVg2Fjt1JcF1qD/Beo55UIpgRfMyFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275263; c=relaxed/simple;
	bh=DOKAVBtsiD4yL/ubqzf5IqlrLUBUfCBZvxT2pd60CYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kInOCB2o5KJ6ESEVq0WbsRqjuEY75Q88OzAH4c9DxTex2V0JztxJYAYoDpknEqLHQdlhsIVEMOd6TdXi0rl9pKiVadiqe3WMJKxiOt7wWeG5u9UDwvuUfVkBfHCJPimQx2URgr9oUob6AZ521PHvtdCtJM/v3tYvNraQMzznX4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=swfXJFYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC95AC4CEF7;
	Mon, 23 Mar 2026 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275263;
	bh=DOKAVBtsiD4yL/ubqzf5IqlrLUBUfCBZvxT2pd60CYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swfXJFYEA3Y0SrmmI5ZmpaNyC6gEXDLRfBV0PFKL0p0XrsXKwHG/N379xcu1P3fqw
	 TFf7f+4ti6o5c40rjQFAN11P9A0xnCFhIcL8Gp314VPBUIUrHtrX+QY7Gsoo50MtIK
	 YC3wIkbskLRzcrZNa4pbOTVg7QwxY/svkh+uCPDs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 033/460] drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v14
Date: Mon, 23 Mar 2026 14:40:29 +0100
Message-ID: <20260323134527.520240402@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228487-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AE6082F464A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit 9d4837a26149355ffe3a1f80de80531eafdd3353 ]

add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v14.0.2/14.0.3

Fixes: 9710b84e2a6a ("drm/amd/pm: add overdrive support on smu v14.0.2/3")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5018
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1b5cf07d80bb16d1593579ccdb23f08ea4262c14)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 3bab8269a46aa..d061467eba2ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2394,7 +2394,8 @@ static int smu_v14_0_2_restore_user_od_settings(struct smu_context *smu)
 	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
 							BIT(PP_OD_FEATURE_UCLK_BIT) |
 							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+							BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
+							BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 	res = smu_v14_0_2_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
-- 
2.51.0




