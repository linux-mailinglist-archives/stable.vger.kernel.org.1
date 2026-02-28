Return-Path: <stable+bounces-220209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMWKB5wso2me+AQAu9opvQ
	(envelope-from <stable+bounces-220209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D11C545F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88666314EFD2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04034DA520;
	Sat, 28 Feb 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/Sza/uv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B054D991A;
	Sat, 28 Feb 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300114; cv=none; b=P6Ye18wzEXHiQ+Q4z7yz+UmsX65GAdPv5vs4dtwXBlwSuLTgQ6HP8a8vdpQC12fiGeR8zNpxvb5pqPDxYwCk1VTsPPXia5+owBsRVQQbOlO0Xf7dwTmTjAaVvKTT5lTDo8qYJ19wUX0gBBTSAInnq/9z+/eQq48zF2zNWN9yFDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300114; c=relaxed/simple;
	bh=qM7gp6HDaVPEmQMATIfFXNVj9J3aUDIQ9zDTxA3dCqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkFXEFuX+kKV3NqLyyGkCk0xuJnbpHeSYIPMeBawzTyY2iQl9EuMDEi4QKMbzPYahZY62VNs5Owe44ghvc2wBe+w3kGwP3+xU8pURlmv260M2ugpb50DocNMdjQcoAyX4Uy0g7Vqqs7azVOAtHua8qECvUT9Oys0QORlvBG6afE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/Sza/uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95891C19423;
	Sat, 28 Feb 2026 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300114;
	bh=qM7gp6HDaVPEmQMATIfFXNVj9J3aUDIQ9zDTxA3dCqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/Sza/uvloARo5emfZIRZyGlwJanSE6exJIceOGNgIlBggH10o8xQdmQVjdxQuo6l
	 edN8Atcm8gmsWEHWmwgBMAj0N9GA2hWOcwC+UI1pxnIQWGcx2yME5C1A6l6WGsT05E
	 kvymBOn+EimtMiMIu+OrLB7RJ2+wPO9XWAdqui627Jil672GJ+d9bYB3u3oC8i1N4E
	 jI3g1RdFWsLT19MRzi8AAGgmGV/XwWo4yuwrDNmN2Y3XaX3u8sxdraNGwy3ZU8RaYM
	 IrI094+1wweYqnsnC1xNpC+BXq9uuRwW9yEt2qhz21kD8yAfiaYeaFhOX5ilM6M4OT
	 a2iW1KbCWkK1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tao Zhou <tao.zhou1@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 131/844] drm/amdgpu: fix the calculation of RAS bad page number
Date: Sat, 28 Feb 2026 12:20:44 -0500
Message-ID: <20260228173244.1509663-132-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220209-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 868D11C545F
X-Rspamd-Action: no action

From: Tao Zhou <tao.zhou1@amd.com>

[ Upstream commit f752e79d38857011f1293fcb6c810409c3b669ee ]

__amdgpu_ras_restore_bad_pages is responsible for the maintenance of bad
page number, drop the unnecessary bad page number update in the error
handling path of add_bad_pages.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8de9f68f7bea6..9c21401c9b830 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3249,8 +3249,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 						/* deal with retire_unit records a time */
 						ret = __amdgpu_ras_convert_rec_array_from_rom(adev,
 										&bps[i], &err_data, nps);
-						if (ret)
-							con->bad_page_num -= adev->umc.retire_unit;
 						i += (adev->umc.retire_unit - 1);
 					} else {
 						break;
@@ -3263,8 +3261,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		for (; i < pages; i++) {
 			ret = __amdgpu_ras_convert_rec_from_rom(adev,
 				&bps[i], &err_data, nps);
-			if (ret)
-				con->bad_page_num -= adev->umc.retire_unit;
 		}
 
 		con->eh_data->count_saved = con->eh_data->count;
-- 
2.51.0


