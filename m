Return-Path: <stable+bounces-226587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FIHDvqMuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:18:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8842D2AF4DC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11284322967A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E406B3F65E2;
	Tue, 17 Mar 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O23yMCa2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BF373C18;
	Tue, 17 Mar 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767353; cv=none; b=juDsnW/zvosL8vFB16FqCDKnWVN3Lkip5oG9tt7VK1a+AxVGQZUpq4L0dvSIIcTCQHQk1RIO0MhoO/zsJoXmxwY/ZGk6BG5qxsQ+dFe8XhR88Y+zq6j3GTyJU6LTN466R6w1d2nxls5aKKD16SzpTmvqKEVXwEfij4P3PKd+0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767353; c=relaxed/simple;
	bh=qEJHRLqUsCLru+DqD3jtethObyXEAmY1/3fXgyBXO4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9ezdYDCsZw59w5GYlu2Hx5H+4aLurm2RVkjUN+EJm2KjJ+qvyLSynP9QpNINuThfTf7X4rQOK905AtZTiGMN4+5inORcJ9WxpL+94NcaITgysOjqr23dWKhKcSbe9eB7j+QL4M/0lPFFtWQ6btOc2P4gsMrTOP9z0NBE2m6TJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O23yMCa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C255BC19424;
	Tue, 17 Mar 2026 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767353;
	bh=qEJHRLqUsCLru+DqD3jtethObyXEAmY1/3fXgyBXO4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O23yMCa2uPxHgfsIsYfXFsLnbmzekFf2lX/LB3WsHN23DwU/u8eJeGDfICV3Q/e1n
	 Q9tUVPbQ5Yd/b+hBP5G56WuEgfbafEix5LCb7crQ6KaubZC89Uj7e0/o1bZnh4mAog
	 H4ee7cpLfixw6XMVB4/VRoyZLhfGcsWKybm4B5Ns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 036/333] drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v14
Date: Tue, 17 Mar 2026 17:31:05 +0100
Message-ID: <20260317163000.701642629@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226587-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8842D2AF4DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index bad8dd786bff2..470a901926f33 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2412,7 +2412,8 @@ static int smu_v14_0_2_restore_user_od_settings(struct smu_context *smu)
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




