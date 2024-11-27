Return-Path: <stable+bounces-95635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567EF9DAB87
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBDA281F30
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B7A200B84;
	Wed, 27 Nov 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5+niXQc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E6200B95
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724105; cv=none; b=RGscyuGZWoTYAIG44vk3cJ0iRzJmFrrYC7bK9ufVwGXX6fObFlTTWqnf/ve9SYw8htSC7v90bAxKKnhvtgHZW7g9kopVrmR2ezQNuwubdvb5mjiUd3/RdeMp7DT+qTgnufgHIHgNx3I26pO3Q3gNlM/S4Ocn3vGj70e7V6oz3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724105; c=relaxed/simple;
	bh=53DtXAcxbCVQaI/CSCDvadCEb3y2Lh1LrSDNCQE4F5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSs/Z/P115R1AJitjYm6H57L4msWNzVA5y1L5ReWLkzlP+CObRHF1VX7p12z5OYUzbspY421KiIIPGi/spXnWULFhWYJ4mYOJflXZrlTsZhi32YdWN4jQ6P0tILv8qtRxuykrZcFU0BJRsYILpBANFrGT40VFllGwJ0BN8mJ5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5+niXQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCCFC4CECC;
	Wed, 27 Nov 2024 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724104;
	bh=53DtXAcxbCVQaI/CSCDvadCEb3y2Lh1LrSDNCQE4F5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5+niXQc8eN31AwhfeshPVs1BCPfylCZJUJ2FpHpUlTLFBWSzbE2dyvTaXgKmDBwv
	 lXNZ+xQrlu53MtJgK8iEI1bijuVlsDVY4NyZDgau/ITEJE2vP1Fp0BJMAnpjPpPsST
	 0ycoSU+aXT1EuDEmQS1DzvZ2Yz4lUNiGtmQQZvjoXmOJFgYVk5hpzX5ivN24g7PI7U
	 xGQjPLbXv7x2fftya3ejoZ76lZtESHXZ658tFjWqX2pAcfrK92LfYgxAjCcJzu0uvR
	 2XOueC/JYGU0regA4YsMedFjT57Gdg2yuP5ADJajET2vh9nbIoCKJpouRsk6nFxm/w
	 L21FhN5YDD6Jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] drm/amd/display: Check null pointer before try to access it
Date: Wed, 27 Nov 2024 11:15:03 -0500
Message-ID: <20241127110521-06651653a6b26cd9@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127122056.1889195-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 1b686053c06ffb9f4524b288110cf2a831ff7a25

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 2002ccb93004)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 11:04:55.475015908 -0500
+++ /tmp/tmp.cuRpI3alDe	2024-11-27 11:04:55.465385699 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 1b686053c06ffb9f4524b288110cf2a831ff7a25 ]
+
 [why & how]
 Change the order of the pipe_ctx->plane_state check to ensure that
 plane_state is not null before accessing it.
@@ -7,32 +9,26 @@
 Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
 Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+[Xiangyu: BP to fix CVE: CVE-2024-49906, modified the source path]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 11 ++++++++---
- 1 file changed, 8 insertions(+), 3 deletions(-)
+ drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 10 +++++++---
+ 1 file changed, 7 insertions(+), 3 deletions(-)
 
-diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
-index 425432ca497f1..a68da1a7092d5 100644
---- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
-+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
-@@ -1932,6 +1932,11 @@ static void dcn20_program_pipe(
+diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+index 2861268ccd23..a825fd6c7fa6 100644
+--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
++++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+@@ -1742,13 +1742,17 @@ static void dcn20_program_pipe(
  	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult))
  		hws->funcs.set_hdr_multiplier(pipe_ctx);
  
+-	if (pipe_ctx->update_flags.bits.enable ||
+-	    (pipe_ctx->plane_state &&
 +	if ((pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult) ||
 +	    pipe_ctx->update_flags.bits.enable)
 +		hws->funcs.set_hdr_multiplier(pipe_ctx);
 +
-+
- 	if (hws->funcs.populate_mcm_luts) {
- 		if (pipe_ctx->plane_state) {
- 			hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
-@@ -1939,13 +1944,13 @@ static void dcn20_program_pipe(
- 			pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
- 		}
- 	}
--	if (pipe_ctx->update_flags.bits.enable ||
--	    (pipe_ctx->plane_state &&
 +	if ((pipe_ctx->plane_state &&
  	     pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change) ||
  	    (pipe_ctx->plane_state &&
@@ -44,3 +40,6 @@
  		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
  
  	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
+-- 
+2.25.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Failed     |  N/A       |

