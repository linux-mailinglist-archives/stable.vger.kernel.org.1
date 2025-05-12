Return-Path: <stable+bounces-143764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EA8AB415F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C819E3B8C00
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD541DF754;
	Mon, 12 May 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lNkQXO1k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4B175BF;
	Mon, 12 May 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073002; cv=none; b=s+KztRjl8kA9/OKcDuSLvj+e7IWmVS2YEc7JMS5FvCC5IgVnGEisu8WCMgAznTrKDdYYnpWOvRLX3nh68dpBuGsrtHeiz4iVnKASKphNuHaSCUWfunSqqmZaCkcBz2LdTGbGylaj/sv0gcDa8TiIa2zN8WFf4G4G18L7i2+ljps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073002; c=relaxed/simple;
	bh=QV+BGyST/mqHZzbN30ATJut4lUXBtf6XLCsRQKcaHpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUazHwiOOrOuOVvEyrbzq/PXYvtFOkWV6CyehQxv8fV7jUuq+LaCrt4pZD0VAU2Bg+IdikDzxvE8gFk3AVTDprxXo49k6QUp/1BbMdVDF7MKFDNMFnbIsKwusRu7Xv0Jl0Osm6G0N4iUErrTI4N3L8zequwichr44pMuzxtgQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lNkQXO1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BDAC4CEEF;
	Mon, 12 May 2025 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073002;
	bh=QV+BGyST/mqHZzbN30ATJut4lUXBtf6XLCsRQKcaHpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNkQXO1kDqwZ4Tevqbsdn9dM9I45meSyPuC2Lsp6/Y8myBbTDiq+98lfBm1ZGm3i7
	 gjOzGLz0r4KOlbq9cKXp+TRBLic7h91WeFrqIBvd7W8DfTyikruOqdC3hlS9pnLzJs
	 /dl3a0a0TTtbag6tPBrme/U/holUC7xpEfcXz1FQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.12 096/184] drm/amd/display: Copy AUX read reply data whenever length > 0
Date: Mon, 12 May 2025 19:44:57 +0200
Message-ID: <20250512172045.734863507@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wayne Lin <Wayne.Lin@amd.com>

commit 3924f45d4de7250a603fd7b50379237a6a0e5adf upstream.

[Why]
amdgpu_dm_process_dmub_aux_transfer_sync() should return all exact data
reply from the sink side. Don't do the analysis job in it.

[How]
Remove unnecessary check condition AUX_TRANSACTION_REPLY_AUX_ACK.

Fixes: ead08b95fa50 ("drm/amd/display: Fix race condition in DPIA AUX transfer")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9b540e3fe6796fec4fb1344f3be8952fc2f084d4)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12546,8 +12546,7 @@ int amdgpu_dm_process_dmub_aux_transfer_
 		/* The reply is stored in the top nibble of the command. */
 		payload->reply[0] = (adev->dm.dmub_notify->aux_reply.command >> 4) & 0xF;
 
-	if (!payload->write && p_notify->aux_reply.length &&
-			(payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK))
+	if (!payload->write && p_notify->aux_reply.length)
 		memcpy(payload->data, p_notify->aux_reply.data,
 				p_notify->aux_reply.length);
 



