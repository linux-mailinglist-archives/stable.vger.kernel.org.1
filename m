Return-Path: <stable+bounces-135426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599C6A98E26
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5A7447441
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4E7280A47;
	Wed, 23 Apr 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uPav4sMf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978527D76E;
	Wed, 23 Apr 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419892; cv=none; b=rxLQW+Rg1/WN2bu5+h1Bgsj2GPzuorCmXdM8Pl+mVSwifh/65xkWXE8UYJ1V+tds6QKKx6Kt/bSFhK8cC2Py0uMq9I8Ev9yq69jPktc7zulAV7VpF4aERKK5rkpHE40iAvzUEpOwrvmO2BdSAkKEnTQjJk+rDYITKr3EQJWbh0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419892; c=relaxed/simple;
	bh=PHvSiq/0Bk2A0VHSNe3c+vUIhr09VnW57XidyaCDgr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxUSPaXGWvykEFlQveCN1CuXX+Xrt5RnmvY52mABdCGnvgDkwnaH5PKfBHL3UbubiAiTATnh7fJeyvNSI6vIZthMRtC2z9OnqbqYElNb+4sVn9sBKRNHoQV4XTr4/cUf28Mf+nQekZ+F8h8nEciwLlEVHGpuIWT8UCk8kkavs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uPav4sMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D30C4CEE2;
	Wed, 23 Apr 2025 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419892;
	bh=PHvSiq/0Bk2A0VHSNe3c+vUIhr09VnW57XidyaCDgr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPav4sMfpd5hiOE1PzEXZoO3RI1DSTFuCWVMIXaagifmzJVq9jFE/W5qroE1wS0t0
	 NQQwoUT1ke3huJTbwRN40mZg9KbJ/frNZdvIkfJ1JKcwJPxw/OhpImTSiytiRPp6sl
	 JywjqZREBp00z9xVzkoatSBcqw/gNrBPLVlJPL/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Stanner <phasta@mailbox.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 017/393] drm/tests: modeset: Fix drm_display_mode memory leak
Date: Wed, 23 Apr 2025 16:38:33 +0200
Message-ID: <20250423142643.979814998@linuxfoundation.org>
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

From: Maxime Ripard <mripard@kernel.org>

[ Upstream commit dacafdcc7789cfeb0f0552716db56f210238225d ]

drm_mode_find_dmt() returns a drm_display_mode that needs to be
destroyed later one. The drm_test_pick_cmdline_res_1920_1080_60() test
never does however, which leads to a memory leak.

Let's make sure it's freed.

Reported-by: Philipp Stanner <phasta@mailbox.org>
Closes: https://lore.kernel.org/dri-devel/a7655158a6367ac46194d57f4b7433ef0772a73e.camel@mailbox.org/
Fixes: 8fc0380f6ba7 ("drm/client: Add some tests for drm_connector_pick_cmdline_mode()")
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/r/20250408-drm-kunit-drm-display-mode-memleak-v1-2-996305a2e75a@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tests/drm_client_modeset_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
index 7516f6cb36e4e..3e9518d7b8b7e 100644
--- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
+++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
@@ -95,6 +95,9 @@ static void drm_test_pick_cmdline_res_1920_1080_60(struct kunit *test)
 	expected_mode = drm_mode_find_dmt(priv->drm, 1920, 1080, 60, false);
 	KUNIT_ASSERT_NOT_NULL(test, expected_mode);
 
+	ret = drm_kunit_add_mode_destroy_action(test, expected_mode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	KUNIT_ASSERT_TRUE(test,
 			  drm_mode_parse_command_line_for_connector(cmdline,
 								    connector,
-- 
2.39.5




