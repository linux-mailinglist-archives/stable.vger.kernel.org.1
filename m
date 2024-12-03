Return-Path: <stable+bounces-96813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903259E21D8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E2C16AC74
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7431FAC45;
	Tue,  3 Dec 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BFKevKwv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B21F76DE;
	Tue,  3 Dec 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238667; cv=none; b=TpW8lFPqhc1L45iuKbyEgkEBHh8FFQHLkhM9jJ48hrJ3XU/gs7G/m1ON7dAeCgi5k58/+nnrHKgrqlpSqjFqp6pHhpmZItbChAZtZuUaVv0LG4chdiQrgJs2U2LAec/WlGBO0eIYLw43FPFzIuPCKrqotARbAnko5vpP9NoNGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238667; c=relaxed/simple;
	bh=bpNONDKB5iPAFCrbDAYhlm5VSX3L4w9oeHhKCU7xaRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV4Koa6Lq7HLeA9NX2PC3UcxEuf7BYawvKAOL0QtwSmdf9jiAn4W7gMYYpEjXSkWwyuY4K3KlH55Wz58KANqQXDom/GXV5rhMrKCQhyH3vRTCyLxDRzs+1Ffb7217IgxkJKGmNgPXJWvPBoqqyQuvMncSpwUnx1dH6QEj7qHwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BFKevKwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E4FC4CECF;
	Tue,  3 Dec 2024 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238667;
	bh=bpNONDKB5iPAFCrbDAYhlm5VSX3L4w9oeHhKCU7xaRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFKevKwvAW953HsITlWDi85A4O5gEuRhq73ecI/zZnZlFAsewAMLcEVQ91EFjlWUe
	 mpQYDXSO/xivlZMNzj/6tn+2Vj3/5+8FZ6AePPZ9zodNssRnhfgK2tYcxidmfCYpFa
	 EGeGcu9VdxlPXOPCmS9VlAP07HloGHV4FM5N2kXw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 339/817] drm/amdgpu: fix ACA bank count boundary check error
Date: Tue,  3 Dec 2024 15:38:31 +0100
Message-ID: <20241203144009.053777561@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit 2bb7dced1c2f8c0e705cc74840f776406db492c3 ]

fix ACA bank count boundary check error.

Fixes: f5e4cc8461c4 ("drm/amdgpu: implement RAS ACA driver framework")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 43f3e72fb247a..aa66c501580b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -158,7 +158,7 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
 		return -EINVAL;
 	}
 
-	if (start + count >= max_count)
+	if (start + count > max_count)
 		return -EINVAL;
 
 	count = min_t(int, count, max_count);
-- 
2.43.0




