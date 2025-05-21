Return-Path: <stable+bounces-145910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9ADABFB1E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 18:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2859B1BA358E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5592222B2;
	Wed, 21 May 2025 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rxpR8S8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584D16DC28
	for <stable@vger.kernel.org>; Wed, 21 May 2025 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844743; cv=none; b=YC/YobuaatZd/rWE/fzvWNZn3gX/QsWRgzzt2lRycvSmNdCf8kxFZcl9yxuMFGC9ZU/4bFUGpzag/se7aLVlAKxertQBM6+woX5pl42LY/5IfKYxqpon3zszEcdWVvPEkGznXjZJ0TgvMTu83va7Nn+EfJFDrFdYcPS6xc+x+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844743; c=relaxed/simple;
	bh=dKUB9Kc5stprKBs7cxtM1HrC3SsNUSrr0+eXebS4F30=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JTasB4hgYLkIR17LB0p2bbNo3ymbPcetrrBsx9zUSy5ALl3GHm6DrMlHDHfFH75oiUPRls5nD8IiGexaZm5rtAx3WBcJhyiR7HmqB+S0mDucBZfXScyVEuh2WSIBDottzwgVSzoiezcTO9BSsGbqLAysvdoIU7aTG9sxLjVxy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rxpR8S8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2211DC4CEE4;
	Wed, 21 May 2025 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747844742;
	bh=dKUB9Kc5stprKBs7cxtM1HrC3SsNUSrr0+eXebS4F30=;
	h=Subject:To:Cc:From:Date:From;
	b=rxpR8S8wwPbR8kLXm5P0K3jbbkp8YelEtuC56op3ZuBkNtVwWJPQlFr3doeKS2ME5
	 q5UUb3TtsNGVVwE4FFz+AuGaTgMIM61MNXN3/LFyD92bJSLFP7PEdA1fsxmquYPXcD
	 lQc1emwkGMDtabXGU7j/CrD2+x14hcY2wzYDUgs0=
Subject: FAILED: patch "[PATCH] drm/amdgpu: read back register after written for VCN v4.0.5" failed to apply to 6.14-stable tree
To: David.Wu3@amd.com,alexander.deucher@amd.com,mario.limonciello@amd.com,ruijing.dong@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 May 2025 18:25:39 +0200
Message-ID: <2025052139-turkey-gumminess-1680@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x ee7360fc27d6045510f8fe459b5649b2af27811a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052139-turkey-gumminess-1680@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee7360fc27d6045510f8fe459b5649b2af27811a Mon Sep 17 00:00:00 2001
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Date: Mon, 12 May 2025 15:14:43 -0400
Subject: [PATCH] drm/amdgpu: read back register after written for VCN v4.0.5

On VCN v4.0.5 there is a race condition where the WPTR is not
updated after starting from idle when doorbell is used. Adding
register read-back after written at function end is to ensure
all register writes are done before they can be used.

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 07c9db090b86e5211188e1b351303fbc673378cf)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a1171e6152ed..f11df9c2ec13 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1023,6 +1023,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
@@ -1205,6 +1209,10 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+
 	return 0;
 }
 


