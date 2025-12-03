Return-Path: <stable+bounces-198657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C0CA0A75
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B8CF3004CFB
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E3833B96D;
	Wed,  3 Dec 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G36u5azo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBAA33970C;
	Wed,  3 Dec 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777259; cv=none; b=fAqXpH1rHCvLKBt1VsNeyc45xrpPHcFpbBoLF6Ka46EfrafuPoZ6QOJ4EspQASBCKFAnHSdKeh88SE/VqgJ6n1GT0xtVET2eO9P98mDxYDkNJvZRkTluCJ/CDgrqf4zjjSP0Eh1PFcmxMvlmVCAr79sCD786w2NEdEbtawtJ/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777259; c=relaxed/simple;
	bh=ysNF9zslNgh2d703KVlxHIJ1MpWKkhaU88MggsYotgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpXqSXWb5m2IMYOPAR4+UFKAOrJztOs+x806wnzJBWhJ9oUwYDn15G1D5Zz51GdlpkyCWch/SBwBIC1N7hZYUkTmcC1iELTgCWHGnQlYpb5PLeVaH7KGy7A35ScLFgsOTWkGXDlSPcnPfbBsdWjezOhHPIGq0V7vcvjOYVOWkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G36u5azo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D8FC2BCB8;
	Wed,  3 Dec 2025 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777259;
	bh=ysNF9zslNgh2d703KVlxHIJ1MpWKkhaU88MggsYotgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G36u5azoZkdhXIvnuG/eE1maqbYdqON1epgA7Ql3MDRtN73PbWMEkszDfZXLuTmfa
	 5BaQtCJQD5VXKqTYVZLb6W3oExoM+RHnMMeLnA/k4Z30pVx68hzCM+gnF6spB+6x2A
	 I8ddtjR+ymwLmJiadD9R2ATIOc5VUSi+rWyyxDM8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Chen <michael.chen@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Shaoyun liu <Shaoyun.liu@amd.com>
Subject: [PATCH 6.17 130/146] drm/amd/amdgpu: reserve vm invalidation engine for uni_mes
Date: Wed,  3 Dec 2025 16:28:28 +0100
Message-ID: <20251203152351.230435018@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chen <michael.chen@amd.com>

commit 971fb57429df5aa4e6efc796f7841e0d10b1e83c upstream.

Reserve vm invalidation engine 6 when uni_mes enabled. It
is used in processing tlb flush request from host.

Signed-off-by: Michael Chen <michael.chen@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Shaoyun liu <Shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 873373739b9b150720ea2c5390b4e904a4d21505)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -597,6 +597,9 @@ int amdgpu_gmc_allocate_vm_inv_eng(struc
 		/* reserve engine 5 for firmware */
 		if (adev->enable_mes)
 			vm_inv_engs[i] &= ~(1 << 5);
+		/* reserve engine 6 for uni mes */
+		if (adev->enable_uni_mes)
+			vm_inv_engs[i] &= ~(1 << 6);
 		/* reserve mmhub engine 3 for firmware */
 		if (adev->enable_umsch_mm)
 			vm_inv_engs[i] &= ~(1 << 3);



