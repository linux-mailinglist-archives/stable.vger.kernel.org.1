Return-Path: <stable+bounces-132495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFDBA8827D
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D00F7AA6CB
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD82F28BA9D;
	Mon, 14 Apr 2025 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2L9lq3u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A21F28BA97;
	Mon, 14 Apr 2025 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637266; cv=none; b=c93K/RxBJU0bVFve9vhqZXVaWmD0glcScMkx3RMylgCZCzKZIa3b8dhsigarP//zeY52PnMiL3Kg0AfBSIY1y6B0y6y+MAhCWHoNZMCw65+XmjflC3bsLSemX0iB+DVVlPqHikp68eSi27SjE7/mvtSaQz2gkcSLU2dyo3ZW0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637266; c=relaxed/simple;
	bh=l/yHk582AK4bFUjbv7xQMGDY1aE4V/qkqvcLDCRbGaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDdX7h9LMJOxJauDIJwXZvxnYdIBOQhSBZVPb9UMjwdx/Qhxmnrt2R9dqNiBHsKW1V5w3g3J0GU4yMf+C0bMhHiUVa/xfZqvofQEw7JqvENl1K7Pa0mSpPd/bDDR/fo64xLrEs8b0K3V4ES9FaCqfD0s0Sk2fLukdoTiqkNuQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2L9lq3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C27C4CEE9;
	Mon, 14 Apr 2025 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637266;
	bh=l/yHk582AK4bFUjbv7xQMGDY1aE4V/qkqvcLDCRbGaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2L9lq3upqVI+SAI17zW0a2ntUNGZv0kQhs3tOeVXAaigbfeKB33pFawJWZKXxeg2
	 v/heFzy8VosVo1JS4t4MDRrCRbmbF6KSdS5kkJ0MCD2kqZoVS1sJmJD2kAO3YmvCDv
	 HC1MJzq3YuRPTjrZc906aNGS28lpAHZB4epAVTMLlON+giRJ9mFBiC+5vpFznTEPRB
	 lmNFILTayYMTS2bzM9faSqUWPri8YIpXEmKFR6t06SxEy43i1v06/JXBzdm34K+WOd
	 WxDI7BtY1r+3xdhytQFdeVvv1JM+E4upHBVQezYqpNN8FCvHGPj6Eg6ut4NDBYknPD
	 I7rnuijhwO/8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	sstabellini@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 6.13 07/34] xen: Change xen-acpi-processor dom0 dependency
Date: Mon, 14 Apr 2025 09:27:01 -0400
Message-Id: <20250414132729.679254-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Jason Andryuk <jason.andryuk@amd.com>

[ Upstream commit 0f2946bb172632e122d4033e0b03f85230a29510 ]

xen-acpi-processor functions under a PVH dom0 with only a
xen_initial_domain() runtime check.  Change the Kconfig dependency from
PV dom0 to generic dom0 to reflect that.

Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250331172913.51240-1-jason.andryuk@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index f7d6f47971fdf..24f485827e039 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -278,7 +278,7 @@ config XEN_PRIVCMD_EVENTFD
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
 	  This ACPI processor uploads Power Management information to the Xen
-- 
2.39.5


