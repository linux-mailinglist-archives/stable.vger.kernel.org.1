Return-Path: <stable+bounces-73267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8A96D412
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03031F26AF3
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5D1991A1;
	Thu,  5 Sep 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GV7ikBnU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE3194C7A;
	Thu,  5 Sep 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529676; cv=none; b=l02nq9O7Hge1IIpLENfDizGxscydd7gxy0wJOM0SjiDiSF6FDqehwT1IJeRrFCfRWk1TWS6f2+OdtozJKxN+N/r44Wvqdg8T9O5+ulKbSM4VvabHoWTf10rugdynla3XuzgvNosgFZba0B4zkvg+m1jJ+u5gaTtYpyCEisGRy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529676; c=relaxed/simple;
	bh=q3ZD5uFs1vt3dhdSbaxlcHVEx4OEh6ucxYB6OUomUvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzWoqK8MBpBduBx2Y87B4BTPAX0koopSq42qiqwzZXluHrZ2ae7ucljiHd94U019nvSqjBPpMnNvRCi7N4jqnRewjTMyfZe+hSv0poDMWF7xmsWaN4A5wuXCbkXVRPdSChwliJkoDH41hTX1SAqhfwxkQLwWMoTJB7gedkBdDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GV7ikBnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F621C4CEC3;
	Thu,  5 Sep 2024 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529676;
	bh=q3ZD5uFs1vt3dhdSbaxlcHVEx4OEh6ucxYB6OUomUvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GV7ikBnU1PuXtR/cTaEAjn42zavIo7ukIze7plTA2CACI+a8yGdm3/rS3n5EWa+Q+
	 0sYpPe/Mnc4V+xYlaGTLhyqQInDfCZH7pLHDoMk5H0y6MMS1maQJ0eClVvpRDoCSJB
	 GY6vbjLnqQFjCEBa3nt7SZACmJz0COGzULNU9B0U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 109/184] drm/amdgpu: fix the warning bad bit shift operation for aca_error_type type
Date: Thu,  5 Sep 2024 11:40:22 +0200
Message-ID: <20240905093736.488550394@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit e6ae021adb79e5f4c4bc4362dd651d7b8b646340 ]

Filter invalid aca error types before performing a shift operation.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c50202215f6b..9baee7c246b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -534,7 +534,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 	if (aca_handle_is_valid(handle))
 		return -EOPNOTSUPP;
 
-	if (!(BIT(type) & handle->mask))
+	if ((type < 0) || (!(BIT(type) & handle->mask)))
 		return  0;
 
 	return __aca_get_error_data(adev, handle, type, err_data, qctx);
-- 
2.43.0




