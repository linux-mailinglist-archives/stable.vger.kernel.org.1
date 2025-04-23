Return-Path: <stable+bounces-135443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B86A98E4E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A42A5A701A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8259A27F755;
	Wed, 23 Apr 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wgFTBglv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82918DB17;
	Wed, 23 Apr 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419937; cv=none; b=dg+oRj99JITuONuxS26+cGgYQ2imZkmfqgtCtxsu2I1zwDA2MOfgzjaXNFCyzK9okVST72uUERhJ86P+Z1zXqxj8BPJpVkLOb8R5+8ki+gnEErhkQatDJyC/B3crzwobu4XgaDiJQhAXTH43ik7XD/ZdFmpH9Vz63TSMwHuVYF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419937; c=relaxed/simple;
	bh=2tY9F2s1ly2KRgMTcA5ZNpr2DN6kz2W3vouWsDDmC94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/EuAFkMejDswfw9xUv0YgNEosSedFAmgXLjm5iuu9Q0kHh/06GNCjMOE2d3qnaWNOFdkvGf16YoIKxegcwi/uKh9p0m7n8Dgwwqz2xFwjK37sGFgsxkgQasPMLsg/g+YY5Y4WdmNGg7al1TaG5FVfoH7iFcOSS5mPKOnM+CrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wgFTBglv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B51C4CEE2;
	Wed, 23 Apr 2025 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419937;
	bh=2tY9F2s1ly2KRgMTcA5ZNpr2DN6kz2W3vouWsDDmC94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wgFTBglvsjVwHUnspMYSX33eTXNymW6gUBgUzjHcg7Uck7yANVKsC6bQ3SNPcbiCj
	 3DNIiLKXF4HILSUghIqCRs4CpCzfpPbXcQ6JNhtvg1DhE+YfyhSPyHXXobOylHVzZn
	 HZmPEXzcefMURUj5JL6Ep6PCP7ig/auxUc+1gCC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 022/393] drm/tests: helpers: Fix compiler warning
Date: Wed, 23 Apr 2025 16:38:38 +0200
Message-ID: <20250423142644.181918477@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu-Chun Lin <eleanor15x@gmail.com>

[ Upstream commit b9097e4c8bf3934e4e07e6f9b88741957fef351e ]

Delete one line break to make the format correct, resolving the
following warning during a W=1 build:

>> drivers/gpu/drm/tests/drm_kunit_helpers.c:324: warning: bad line: for a KUnit test

Fixes: caa714f86699 ("drm/tests: helpers: Add helper for drm_display_mode_from_cea_vic()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501032001.O6WY1VCW-lkp@intel.com/
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250104165134.1695864-1-eleanor15x@gmail.com
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Stable-dep-of: 70f29ca3117a ("drm/tests: cmdline: Fix drm_display_mode memory leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 9a35b2cf6a032..12d58353a54ef 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -392,8 +392,7 @@ static void kunit_action_drm_mode_destroy(void *ptr)
 }
 
 /**
- * drm_kunit_display_mode_from_cea_vic() - return a mode for CEA VIC
-					   for a KUnit test
+ * drm_kunit_display_mode_from_cea_vic() - return a mode for CEA VIC for a KUnit test
  * @test: The test context object
  * @dev: DRM device
  * @video_code: CEA VIC of the mode
-- 
2.39.5




