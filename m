Return-Path: <stable+bounces-77321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8BB985BC8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CAEB253A9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEED19F48B;
	Wed, 25 Sep 2024 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djfsNcuZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5C185920;
	Wed, 25 Sep 2024 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265171; cv=none; b=mcM9d+d5K1m4Q8klWFEuPnGPXPA6pvinzPhP8YEU+XgIfDeRjLBHhxdIqFc3oykSaMpU/3PhyZge6wW9NTQ8sk5kUCrOi28O3sKtDajI6lG2J9bNH5I9xNJ5dgxv4HsJGDXf97JXQD/5UIKkL9Ixlk2hFlwF+kr8Ij9Gg9NuhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265171; c=relaxed/simple;
	bh=I9htJGahdm5FhRjP/YpLeFy/I0Nbf95X9HivKlsU7f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEWjfhb2TopbNLhSrj14sH9HZ1So+2artglRvGNOL8ukQgvXjaGyJIKnpdbSgu7ev0eKyNYavzKmUXoJTCs7it/l8oZFeXZT/YlPjomGkehHHlMjeqBDt/o7QzaK8p4UePNU5oQmtBWGvN/uLMsc6CWePzlqj2aM62sOAFMAkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djfsNcuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B178C4CEC7;
	Wed, 25 Sep 2024 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265171;
	bh=I9htJGahdm5FhRjP/YpLeFy/I0Nbf95X9HivKlsU7f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djfsNcuZ/awWJcmasxx/W9yp0YBqbxVd4Wbq264a5ij7pRn4EhiiqD34uYyo4+4fh
	 fgLAVljnImdTwXq3V2ZIfmnIHXvpGIalpRgawHBT4ppIRy1VHUZMpFgR56XlqZg8vp
	 TkFWth/5BebuHm+gLQQpCF0lpp6y2z5gnIY10hn3IODhyL4fkwpWdzNdBMZ508kld3
	 DqDVZQzkUXml5iIXH+q7fkpUKTYeyt+5hV11QVSo76419pdB5iu5Cmh3LuNRRqm8Ve
	 r+1WxUBpPeW5ePM8X8q4euXY7jp+Ys+bXNMVGYO7nhC1P1jvGVxGiQpuhoyNtO0jET
	 n1M+MHihnklag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Likun.Gao@amd.com,
	Hawking.Zhang@amd.com,
	kenneth.feng@amd.com,
	sunil.khatri@amd.com,
	Jack.Xiao@amd.com,
	marek.olsak@amd.com,
	Frank.Min@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 223/244] drm/amdgpu/gfx12: use rlc safe mode for soft recovery
Date: Wed, 25 Sep 2024 07:27:24 -0400
Message-ID: <20240925113641.1297102-223-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 21818f39beda2e843199e5d8d9e3f9e43c8080a3 ]

Protect the MMIO access with safe mode.

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1a84163182689..f0f30cfcf0d76 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4605,7 +4605,9 @@ static void gfx_v12_0_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, regSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void
-- 
2.43.0


