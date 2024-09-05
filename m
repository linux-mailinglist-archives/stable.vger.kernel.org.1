Return-Path: <stable+bounces-73383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5540496D49E
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135E92828D4
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196FA198A16;
	Thu,  5 Sep 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KbCLQ24I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F21957FC;
	Thu,  5 Sep 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530051; cv=none; b=ZYbjJgAHqG++AaJO+WODy7RKaVMo1Sy4OzYW8GcdQD+SbfU1sIrkyUQhXTRaQr+HUsu5P2J7QZl+0ESZSXY5opr6yMUqAYvPi6XHZs+VJHkjFOm1SsGe2DnB90GwlJCa4mOGXRXOT0dgLou4FLFjOFlg8RgDCmjafOVdGaF/H0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530051; c=relaxed/simple;
	bh=WHqYPXT269RcQ7Bnya/IsQTtpHUDHONDfLpzv2D7Na4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6LSwJi1964Z4q1xFIMxDFECgwyvUnUyFR5zsSfBSUoC1NKX7iYjp3WIMpVMI8wBssI1/nb+NDUZJV3OAZx9qrEC0NM3RKvRf2Yz8FeMxWiT+tfy7sAuABRK9WzIrT5EH53rwoIcCSgUc82dQUL+uYnNLwgUZlp2lodBI4zs2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KbCLQ24I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD17C4CEC3;
	Thu,  5 Sep 2024 09:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725530051;
	bh=WHqYPXT269RcQ7Bnya/IsQTtpHUDHONDfLpzv2D7Na4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbCLQ24I5mEwT+7ALxZSjER0EkHzEoJQXpXZYI6ofc1dZHiJlDXZkRZ8Zax2TjONa
	 fQhlRJ6N6qB04PJjwTybGhmHIi5gnoZ4y8aYFmQPOxB4nzCUQBIEYf3bbaM2NNDXGB
	 o3/H1ArbYyyxTrZUN9uZFuXX7nn9XT/T0s67bTek=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Jun <Jun.Ma2@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 040/132] drm/amdgpu: Fix uninitialized variable warning in amdgpu_afmt_acr
Date: Thu,  5 Sep 2024 11:40:27 +0200
Message-ID: <20240905093723.817465991@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
References: <20240905093722.230767298@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit c0d6bd3cd209419cc46ac49562bef1db65d90e70 ]

Assign value to clock to fix the warning below:
"Using uninitialized value res. Field res.clock is uninitialized"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
index a4d65973bf7c..80771b1480ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
@@ -100,6 +100,7 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock)
 	amdgpu_afmt_calc_cts(clock, &res.cts_32khz, &res.n_32khz, 32000);
 	amdgpu_afmt_calc_cts(clock, &res.cts_44_1khz, &res.n_44_1khz, 44100);
 	amdgpu_afmt_calc_cts(clock, &res.cts_48khz, &res.n_48khz, 48000);
+	res.clock = clock;
 
 	return res;
 }
-- 
2.43.0




