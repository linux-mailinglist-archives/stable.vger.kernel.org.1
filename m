Return-Path: <stable+bounces-118663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5227CA40995
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268E63A4780
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC221CBEAA;
	Sat, 22 Feb 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XamTHj9v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAA869D2B
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239613; cv=none; b=KS9ouC8YCv164MjUR9WBQLS68wNLxCvR8Wtqxfzh4s0lHYkHiFktwNiivAXCXVXM8iKeazsBlCAnpCm40OCN6oXWIfYUl1sBdjwoP6tTwHlXBp+j6ONT+OU5edfJ2IqboyZHraVxQhAUy6HSZKOBm+sU+Fm/kBeEZcH7N5zhMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239613; c=relaxed/simple;
	bh=5p/pMjn/H+yuDLi95u7+6pJdwx4+MZwabffHBQs71ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrnnSb7cVk7eEGvy/1wXsQAPKUqE2IPQehF9b3EUvtKGojkpt4SUEQF6BbCs+PWAVkyiQNfVqYPJ6N4AOdAigK1FSFIpKbgKViCJwt9SuyEjhf0hyIW11DB2yLkiQDazoffNI3Yx1FQ2nAWQUfWU9ECWpOnqm7Vw8kE5xm0q2tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XamTHj9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EECC4CED1;
	Sat, 22 Feb 2025 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740239612;
	bh=5p/pMjn/H+yuDLi95u7+6pJdwx4+MZwabffHBQs71ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XamTHj9v2/UOTHGlGtwJPOx825aV2EL5ku7eI58YD7iGwkgseF/7DQKDFC1ZbYyxq
	 /NF7ir711FN1oknUCSHir1I+OA5upW4FV/3Rqd/aY2lx4QPwDkonso+uUaVYvZIJ/Y
	 nS/1KQbDkWu2rLGogaw22hkSRkKj3o+LZt6kU/6qOCobsqydc+CIXfhYgmVZ2KYkVd
	 wZJxjEpZ9WkN2mTf+nW4yl7lF7jb1NR6oV/rC3l1XueK0eOPEs7PFqWjrKknCjbeA6
	 bUfnPbRQ5aW1oAIVJntTFcJI9WKSM0jSq1eq3CSToQ0GYjQMc1RlUXkHC4s/THp+vN
	 YuHOWVHsQUHYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lancelot.six@amd.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] drm/amdkfd: Ensure consistent barrier state saved in gfx12 trap handler
Date: Sat, 22 Feb 2025 10:53:30 -0500
Message-Id: <20250221202405-1793863f78c0922a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250221180852.465651-1-lancelot.six@amd.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: d584198a6fe4c51f4aa88ad72f258f8961a0f11c


Status in newer kernel trees:
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d584198a6fe4c ! 1:  1ba3cbf705dfa drm/amdkfd: Ensure consistent barrier state saved in gfx12 trap handler
    @@ Commit message
         This patch proposes to have all waves in a workgroup wait for each other
         at the end of their save sequence (just before calling s_endpgm_saved).
     
    +    This is a cherry-pick.  The cwsr_trap_handler.h part of the original
    +    part was valid and applied cleanly.  The part of the patch that applied
    +    to cwsr_trap_handler_gfx12.asm did not apply cleanly since
    +    80ae55e6115ef "drm/amdkfd: Move gfx12 trap handler to separate file" is
    +    not part of this branch.  Instead, I ported the change to
    +    cwsr_trap_handler_gfx10.asm, and guarded it with "ASIC_FAMILY >=
    +    CHIP_GFX12".
    +
         Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
         Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
         Cc: stable@vger.kernel.org # 6.12.x
    +    (cherry picked from commit d584198a6fe4c51f4aa88ad72f258f8961a0f11c)
    +    Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
     
      ## drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h ##
     @@ drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h: static const uint32_t cwsr_trap_gfx12_hex[] = {
    @@ drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h: static const uint32_t cwsr_trap_
      	0xbf9f0000, 0xbf9f0000,
      	0xbf9f0000, 0x00000000,
     
    - ## drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm ##
    -@@ drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm: L_SKIP_BARRIER_RESTORE:
    + ## drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm ##
    +@@ drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm: L_RETURN_WITHOUT_PRIV:
      	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
      
      L_END_PGM:
    ++#if ASIC_FAMILY >= CHIP_GFX12
     +	// Make sure that no wave of the workgroup can exit the trap handler
     +	// before the workgroup barrier state is saved.
     +	s_barrier_signal	-2
     +	s_barrier_wait	-2
    ++#endif
      	s_endpgm_saved
      end
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.6.y. Reject:

diff a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h	(rejected hunks)
@@ -4117,7 +4117,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000ffff, 0x8bfe7e7e,
 	0x8bea6a6a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbfb10000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
diff a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm	(rejected hunks)
@@ -1463,6 +1463,12 @@ L_RETURN_WITHOUT_PRIV:
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
+#if ASIC_FAMILY >= CHIP_GFX12
+	// Make sure that no wave of the workgroup can exit the trap handler
+	// before the workgroup barrier state is saved.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+#endif
 	s_endpgm_saved
 end
 
Patch failed to apply on stable/linux-6.1.y. Reject:

diff a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h	(rejected hunks)
@@ -4117,7 +4117,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000ffff, 0x8bfe7e7e,
 	0x8bea6a6a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbfb10000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
diff a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm	(rejected hunks)
@@ -1463,6 +1463,12 @@ L_RETURN_WITHOUT_PRIV:
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
+#if ASIC_FAMILY >= CHIP_GFX12
+	// Make sure that no wave of the workgroup can exit the trap handler
+	// before the workgroup barrier state is saved.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+#endif
 	s_endpgm_saved
 end
 
Patch failed to apply on stable/linux-5.15.y. Reject:

diff a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h	(rejected hunks)
@@ -4117,7 +4117,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000ffff, 0x8bfe7e7e,
 	0x8bea6a6a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbfb10000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
diff a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm	(rejected hunks)
@@ -1463,6 +1463,12 @@ L_RETURN_WITHOUT_PRIV:
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
+#if ASIC_FAMILY >= CHIP_GFX12
+	// Make sure that no wave of the workgroup can exit the trap handler
+	// before the workgroup barrier state is saved.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+#endif
 	s_endpgm_saved
 end
 
Patch failed to apply on stable/linux-5.10.y. Reject:

diff a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h	(rejected hunks)
@@ -4117,7 +4117,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000ffff, 0x8bfe7e7e,
 	0x8bea6a6a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbfb10000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
diff a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm	(rejected hunks)
@@ -1463,6 +1463,12 @@ L_RETURN_WITHOUT_PRIV:
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
+#if ASIC_FAMILY >= CHIP_GFX12
+	// Make sure that no wave of the workgroup can exit the trap handler
+	// before the workgroup barrier state is saved.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+#endif
 	s_endpgm_saved
 end
 
Patch failed to apply on stable/linux-5.4.y. Reject:

diff a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h	(rejected hunks)
@@ -4117,7 +4117,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000ffff, 0x8bfe7e7e,
 	0x8bea6a6a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbfb10000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
diff a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm	(rejected hunks)
@@ -1463,6 +1463,12 @@ L_RETURN_WITHOUT_PRIV:
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
+#if ASIC_FAMILY >= CHIP_GFX12
+	// Make sure that no wave of the workgroup can exit the trap handler
+	// before the workgroup barrier state is saved.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+#endif
 	s_endpgm_saved
 end
 

