Return-Path: <stable+bounces-56168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21491D527
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1B81C20BD8
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E512BF24;
	Mon,  1 Jul 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvX6PRWU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15E12BE91;
	Mon,  1 Jul 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792835; cv=none; b=JxEmsro79P6xiT4p+3V8jyQy9cTYE0q5WoIldB2YofGMtXD10aiouX5HgaSt0WnVJ0xj7YAenwlxy5qCzqpHl1OrTM4BLAu2a5d5MnonQSG63DpBZKYqZUDYxbogYyoD5K7ZDudF5ufUjVpbFwoG+5ZXFUeurIrBkVfuq47ZDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792835; c=relaxed/simple;
	bh=hw7u6xYg/+CQm01IClMuBvMqpvZ+em+NVWONFAx+A5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7SXMMrdGS9uI8dExxAIB9HGJaujhNqXlioE0FL9qHJa3pyfMnztY/FXXLffZZtJxSp84MIb1SUTExXdDWUqM0tnFBUfu0YMVkZddWmyUG4/je/MIZctJwmZ+GZYvC9pm4fiUyALUXiGs8CjHONr0kbJvH5UW/qgXhaRTUPUwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvX6PRWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775B0C32786;
	Mon,  1 Jul 2024 00:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792835;
	bh=hw7u6xYg/+CQm01IClMuBvMqpvZ+em+NVWONFAx+A5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvX6PRWU1vgApoY4WbwCryfyYDCd7BWWfkB38M9eS85pLfbIDB5oavcXtmygf8F/V
	 2Z/B3htggA++nMYGbN4wWsg59CIRumSXajf8fHKWwofsJlxfrAyMst9udqnlvhaBqk
	 KA925SKFA0SAdJ98SdsFe5E0+iZtmC8tKC/j1xjM1dfqMx5KJGdBGLEg9nuHVZP6vv
	 bpdSeGRCVQSYa3ghX7D3TaCCC7NTExlB0OiDzyta6kjJY4MPhVJkVUEDn+uJ25/Axt
	 9rtotPdi7h2TPxNcQOlHW1OTougeF1bxD4VsEzoBp+xqMFd1nKxUTlJ/bxpKDZHrLx
	 es3unA40ZjVjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
	kernel test robot <lkp@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 05/12] drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency
Date: Sun, 30 Jun 2024 20:13:24 -0400
Message-ID: <20240701001342.2920907-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001342.2920907-1-sashal@kernel.org>
References: <20240701001342.2920907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.36
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <alexey.makhalov@broadcom.com>

[ Upstream commit 8c4d6945fe5bd04ff847c3c788abd34ca354ecee ]

VMWARE_HYPERCALL alternative will not work as intended without VMware guest code
initialization.

  [ bp: note that this doesn't reproduce with newer gccs so it must be
    something gcc-9-specific. ]

Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240616012511.198243-1-alexey.makhalov@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
index faddae3d6ac2e..6f1ac940cbae7 100644
--- a/drivers/gpu/drm/vmwgfx/Kconfig
+++ b/drivers/gpu/drm/vmwgfx/Kconfig
@@ -2,7 +2,7 @@
 config DRM_VMWGFX
 	tristate "DRM driver for VMware Virtual GPU"
 	depends on DRM && PCI && MMU
-	depends on X86 || ARM64
+	depends on (X86 && HYPERVISOR_GUEST) || ARM64
 	select DRM_TTM
 	select DRM_TTM_HELPER
 	select MAPPING_DIRTY_HELPERS
-- 
2.43.0


