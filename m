Return-Path: <stable+bounces-127139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D31A76914
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF10188F487
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5920B2222D4;
	Mon, 31 Mar 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGW0m1zl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E15215773
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432501; cv=none; b=u0GFSzzXavJ/96JUEh+RCMpQuNVLzPEtAhKI5qJsI8ooEo7WSIeOMbXW7Axh0Bb+vZwMEoKmVn1eWLhc8gcrb/eAJnoHwov5WZr3bVPP6JMpqB9XRN8hP/W93/1M6MZCka1TiG035+BG/WzH9WikM0Ni7MfjG4LA6Wum4QGaM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432501; c=relaxed/simple;
	bh=dj92Z137uVW7f75TVKoM2b+Agljn7dhJtEehKeMuwR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3nCol/XMEXDL65NNDohInv6TLXDHn7i3cZJAmR5WWpG+DuGSLPjrVbVauFjAB0KpTkVWnzBUdoh8ZZYm8TsB+5R6Tj2vaOlZW9j8o93VIPw1ki4yCCifTbfepGrtnq9BMw2GUncyiQm47Mehxal0ttSFoRMy1aRj4ovXX7/oPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGW0m1zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B34C4CEE3;
	Mon, 31 Mar 2025 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432500;
	bh=dj92Z137uVW7f75TVKoM2b+Agljn7dhJtEehKeMuwR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGW0m1zlxP49RgPpwEklJ/8EPBliTWhffBmVnNHiY/fd0rrJbgGomm+GFf5rKEJrr
	 Bm2tDQUwwviLEEVRY1d02g4bg7h0KKlUAg94HkUPurxOyklV+E2FaBWgGJPsrwco4X
	 k2S6ew24QAUQt/teEHP+M6xlgF+GD+C8tguzOFLQAXA5OlRRJCh4B+hclHvZD06kKd
	 hpcVLeGkhbxOvskimkbQbINgLn+zlsFLAKlU6O//pwMigYwtQHAuFLV0DIH4vOsr7I
	 1PwFnS8yRkmRA8M54VUv9nL0Rg7d3awerSvKZDRqtrhudQzjRJ+I9FFQOo9bWdTxOB
	 GXUPkoeLXcqzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: Check denominator crb_pipes before used
Date: Mon, 31 Mar 2025 10:48:18 -0400
Message-Id: <20250331100733-449fff4a354e9967@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250331123723.711372-1-donghua.liu@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: ea79068d4073bf303f8203f2625af7d9185a1bc6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Alex Hung<alex.hung@amd.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ea79068d4073b ! 1:  958f070b24e78 drm/amd/display: Check denominator crb_pipes before used
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Check denominator crb_pipes before used
     
    +    [ Upstream commit ea79068d4073bf303f8203f2625af7d9185a1bc6 ]
    +
         [WHAT & HOW]
         A denominator cannot be 0, and is checked before used.
     
    @@ Commit message
         Signed-off-by: Alex Hung <alex.hung@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c: static int dcn315_populate_dml_pipes_from_context(
    + ## drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c: static int dcn315_populate_dml_pipes_from_context(
      				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
      						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

