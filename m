Return-Path: <stable+bounces-130675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66808A805CD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6024A163A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC76626AABD;
	Tue,  8 Apr 2025 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="11wthpI+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C726AAB9;
	Tue,  8 Apr 2025 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114348; cv=none; b=pX3VnBEBZDp6JJQppTBDk0BuIHCVT87MFSPs3QeVCJy6ZP0M35RX/+JIXY9ArhC1ooSkac4I9GDfIaKHqE9kKhcuwPdNE+ko+l7WMamgXuOmaPHeoq3Img4aFjYSOJZSBScAnudPaYSgYINj8ks3IgPb3opdrzvIcOoDT+juIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114348; c=relaxed/simple;
	bh=QbXq0sL2lFUszbUAgyXepf4XE0onm7BA4jJnYZfLLc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogBiJREnVNtnKPpQ8CvsVzEU7DB+/wTcmLpwPYen1lBdIS8tZH7mbEWNZUSUYtH6XL5cM3Odrg6SLtdWW1P7hshd5Ib6PhzAs3LhsHxETSf7MevnM7PHPMcaKMs1cMMOJAt8eprnL9gAXYjIUBX3uIz/0YzkjTjNKkB0kLaeHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=11wthpI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18814C4CEE7;
	Tue,  8 Apr 2025 12:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114348;
	bh=QbXq0sL2lFUszbUAgyXepf4XE0onm7BA4jJnYZfLLc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=11wthpI+ZsRy/gcab4BbBtwBxjJoygN83tGR5DRjD7+GyUgSBTDcvdaR0J224vGOV
	 yz9u8mDApXeQdZISQsBM40aegHKcI81MUIkrE5r9e1MFdZNKtwAFmebkFdX3TtW8Px
	 +X3tHRf+vzwcaWfG4bxIBDgHIQUxslfqtv/CqeFQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Lang Yu <Lang.Yu@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 072/499] drm/amdgpu/umsch: fix ucode check
Date: Tue,  8 Apr 2025 12:44:44 +0200
Message-ID: <20250408104853.023089062@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit c917e39cbdcd9fff421184db6cc461cc58d52c17 ]

Return an error if the IP version doesn't match otherwise
we end up passing a NULL string to amdgpu_ucode_request.
We should never hit this in practice today since we only
enable the umsch code on the supported IP versions, but
add a check to be safe.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502130406.iWQ0eBug-lkp@intel.com/
Fixes: 020620424b27 ("drm/amd: Use a constant format string for amdgpu_ucode_request")
Reviewed-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index bd2d3863c3ed1..ca74af2148348 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -584,7 +584,7 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
 		fw_name = "amdgpu/umsch_mm_4_0_0.bin";
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, "%s", fw_name);
-- 
2.39.5




