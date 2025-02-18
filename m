Return-Path: <stable+bounces-116712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6749A39AB6
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E27816F716
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69AF233D8C;
	Tue, 18 Feb 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jqHn2eSn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8D1B21B7
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877974; cv=none; b=tFPlqpCQVecNxDVU3tJ8g7lMEKtmZPkEKWkOSQazN1apaTsPeva6RwmJBynJ/kD9xDgThqV4OiB+DF+xQkD0LBOAgAb1a7cl8F2UZcMq/QH9VgZTARtTT0OoeffSVGXSYH6qZpUF3sc/inU7S0PeVWU0lYUA7Zqh8UWD8q/c7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877974; c=relaxed/simple;
	bh=mkhau3LSaMqEonGLff9e3N7E/Fw1K5N8myGQ7bhgJq0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bQ7kmnOFGlfkqwMOHbsFts2CyowpAWVkLpPkzr3yYuuUukNCAmT4GFGSJitqWyjiWoUwfO3kMiyDxKcO3VUxsSaumH47ipOXC3DgQClleKOD0HNqyqQzdZaoTGPJKpj9iOResuORb4NDMWE4HlhFb+FJj3HWgRFFbUCMCPgPx3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jqHn2eSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D60C4CEE2;
	Tue, 18 Feb 2025 11:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739877974;
	bh=mkhau3LSaMqEonGLff9e3N7E/Fw1K5N8myGQ7bhgJq0=;
	h=Subject:To:Cc:From:Date:From;
	b=jqHn2eSnkbWSAOuJ/G/W22rXv1UjhT4uv6AqYbSwF5u334YeH35Pw1Vknfp0CG5Nm
	 sOFQlLNaxE5NhKXSw3R/srl37vwtQINd3ju9KJOzTKpedsuR0KgG0BnRQ9Bjh0FXIO
	 vS4Nt2mur1l3YNJLML/z+xGKRBncM+68DTdWaXIk=
Subject: FAILED: patch "[PATCH] drm/amdkfd: Ensure consistent barrier state saved in gfx12" failed to apply to 6.12-stable tree
To: lancelot.six@amd.com,alexander.deucher@amd.com,jay.cornwall@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:26:03 +0100
Message-ID: <2025021803-fondness-ship-dc72@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d584198a6fe4c51f4aa88ad72f258f8961a0f11c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021803-fondness-ship-dc72@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d584198a6fe4c51f4aa88ad72f258f8961a0f11c Mon Sep 17 00:00:00 2001
From: Lancelot SIX <lancelot.six@amd.com>
Date: Tue, 28 Jan 2025 19:16:49 +0000
Subject: [PATCH] drm/amdkfd: Ensure consistent barrier state saved in gfx12
 trap handler

It is possible for some waves in a workgroup to finish their save
sequence before the group leader has had time to capture the workgroup
barrier state.  When this happens, having those waves exit do impact the
barrier state.  As a consequence, the state captured by the group leader
is invalid, and is eventually incorrectly restored.

This patch proposes to have all waves in a workgroup wait for each other
at the end of their save sequence (just before calling s_endpgm_saved).

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.12.x

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 984f0e705078..651660958e5b 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4121,7 +4121,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000ffff, 0x8bfe7e7e,
 	0x8bea6a6a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbfb10000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 1740e98c6719..7b9d36e5fa43 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -1049,6 +1049,10 @@ L_SKIP_BARRIER_RESTORE:
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
+	// Make sure that no wave of the workgroup can exit the trap handler
+	// before the workgroup barrier state is saved.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
 	s_endpgm_saved
 end
 


