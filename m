Return-Path: <stable+bounces-122040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB03A59D9C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4213A6D59
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3C23099F;
	Mon, 10 Mar 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E7qR125x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A01226D0B;
	Mon, 10 Mar 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627356; cv=none; b=rP58u4qmjbhA+/8MJxrHeA5JhE78hLACBm84oAbc3ronrkNvMDNaR0R2d4/UrLAMOTFsyB5og/U4vpONns6e/eD9cBKdDGtWsSi+0M4jiNTLeWJUz27HYax39nniBvpynfTIzuVM0b1JaUbMRbHueJpLjwu2TrFnrnGtgqUntww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627356; c=relaxed/simple;
	bh=59FsMmiShYnWU5fRA8bMosVCQ8+SktVT0NobBa1liOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmk5AOKM4GoYsr+JC+1xMzgKDE5Vj7Hxse7hbwzfIRIJltFCJgqEzFi5AYx30K+jwqM1q5DgTEcmUggvTjAlheq0OysT2JtWVMxEdLkrSEBH7DfWoKhmNPD04XXgfQmMYkyh1+kJXyrneXMZe2aTLhsKAB20QhbgeLG+wM+BB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E7qR125x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DADBC4CEE5;
	Mon, 10 Mar 2025 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627356;
	bh=59FsMmiShYnWU5fRA8bMosVCQ8+SktVT0NobBa1liOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7qR125xcLBSVaFfcXrukw6gIoValwnO0awFRoG+iBVjkytqXkaGYk61+S7AePwso
	 V57MjFJfPWHLodkRyi+Uz+HTCah5AA+onuKNYCo+z7TEMGs8mYPLLDhDJD5ywBHJcI
	 DleBS2082oKde3afdkpel6/aOq8faLzgeUnnYA8E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
	Richard Thier <u9vata@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 101/269] drm/radeon: Fix rs400_gpu_init for ATI mobility radeon Xpress 200M
Date: Mon, 10 Mar 2025 18:04:14 +0100
Message-ID: <20250310170501.739367191@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Thier <u9vata@gmail.com>

commit 29ffeb73b216ce3eff10229eb077cf9b7812119d upstream.

num_gb_pipes was set to a wrong value using r420_pipe_config

This have lead to HyperZ glitches on fast Z clearing.

Closes: https://bugs.freedesktop.org/show_bug.cgi?id=110897
Reviewed-by: Marek Olšák <marek.olsak@amd.com>
Signed-off-by: Richard Thier <u9vata@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 044e59a85c4d84e3c8d004c486e5c479640563a6)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/r300.c        |    3 ++-
 drivers/gpu/drm/radeon/radeon_asic.h |    1 +
 drivers/gpu/drm/radeon/rs400.c       |   18 ++++++++++++++++--
 3 files changed, 19 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -359,7 +359,8 @@ int r300_mc_wait_for_idle(struct radeon_
 	return -1;
 }
 
-static void r300_gpu_init(struct radeon_device *rdev)
+/* rs400_gpu_init also calls this! */
+void r300_gpu_init(struct radeon_device *rdev)
 {
 	uint32_t gb_tile_config, tmp;
 
--- a/drivers/gpu/drm/radeon/radeon_asic.h
+++ b/drivers/gpu/drm/radeon/radeon_asic.h
@@ -165,6 +165,7 @@ void r200_set_safe_registers(struct rade
  */
 extern int r300_init(struct radeon_device *rdev);
 extern void r300_fini(struct radeon_device *rdev);
+extern void r300_gpu_init(struct radeon_device *rdev);
 extern int r300_suspend(struct radeon_device *rdev);
 extern int r300_resume(struct radeon_device *rdev);
 extern int r300_asic_reset(struct radeon_device *rdev, bool hard);
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -256,8 +256,22 @@ int rs400_mc_wait_for_idle(struct radeon
 
 static void rs400_gpu_init(struct radeon_device *rdev)
 {
-	/* FIXME: is this correct ? */
-	r420_pipes_init(rdev);
+	/* Earlier code was calling r420_pipes_init and then
+	 * rs400_mc_wait_for_idle(rdev). The problem is that
+	 * at least on my Mobility Radeon Xpress 200M RC410 card
+	 * that ends up in this code path ends up num_gb_pipes == 3
+	 * while the card seems to have only one pipe. With the
+	 * r420 pipe initialization method.
+	 *
+	 * Problems shown up as HyperZ glitches, see:
+	 * https://bugs.freedesktop.org/show_bug.cgi?id=110897
+	 *
+	 * Delegating initialization to r300 code seems to work
+	 * and results in proper pipe numbers. The rs400 cards
+	 * are said to be not r400, but r300 kind of cards.
+	 */
+	r300_gpu_init(rdev);
+
 	if (rs400_mc_wait_for_idle(rdev)) {
 		pr_warn("rs400: Failed to wait MC idle while programming pipes. Bad things might happen. %08x\n",
 			RREG32(RADEON_MC_STATUS));



