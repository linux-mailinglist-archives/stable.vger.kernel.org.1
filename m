Return-Path: <stable+bounces-128809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21383A7F311
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 05:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0327A557C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 03:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DC4253B4D;
	Tue,  8 Apr 2025 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUDrN9iJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457D253B46
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081772; cv=none; b=JDuieCkUcxu5ju9OUNhh7vc5Y1YjZrW8JWecg7tQfWQwvnKsyDrBNgo/kvacpD8Cot5fQiqjMrNvOKXwWagY79IRVa4+Drj/8MvBNzXQ8fUmhcTCAcQ+j77CJar01hCN20HA5hqLJS/20MYbsD45IZ51SV9BbZXayQ4kLVC0Kzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081772; c=relaxed/simple;
	bh=8KEGjRzRwrGl+upmEYXATnYvo+BwNae4qGFkeqgvq+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cofawd95plDpjN0KC8lrytWA7TnpMn9YogKx6KquIvkhTYTldhJ92vjoNgP2JPpv77mJiN2eHj//qDIxM/uwitg1a/ffCYXFDiXVY4eIpHRc3gw4VoU9J9lk4Cns1tiPnTsTcZV1I5Rje54Og0rNbfT+xTYjcPP5YInTDb4svGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUDrN9iJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3608AC4CEDD;
	Tue,  8 Apr 2025 03:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744081771;
	bh=8KEGjRzRwrGl+upmEYXATnYvo+BwNae4qGFkeqgvq+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUDrN9iJFq8Iy9FRsNExTdsuiLzM0ATazs2QEk9SggoQAUEdbf7ur7cCjLQf1TMTJ
	 1IkMLz2+3OL2m6YRkrONrvhmi2PjXBQR5PmmRXDHZVVs2xKBMuLurALjRCBUOWAm8z
	 ZKTWZwEoHpkEVyDv6vIIYJUb9ZNJp0aF4drPc9Yhf68VD34G7G7s2dKy5F+H+4ebaT
	 biS4Nlq+7EySzhytbG/Xv43NYLl6wKcHirT/HuiQWgY3fBegd6MvRGMm3IZeunW3Z5
	 WRXuu4rQUNcY3fws0r9iyr4VbMjPht9HTgaxLw3WSQMgpzeBDyiQpcXyW06Krovuji
	 tZKiRhFo5pjvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Check link_index before accessing dc->links[]
Date: Mon,  7 Apr 2025 23:09:29 -0400
Message-Id: <20250407212441-371009161b21515c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408003647.3361342-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 8aa2864044b9d13e95fe224f32e808afbf79ecdf

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Alex Hung<alex.hung@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  8aa2864044b9d ! 1:  1ae9fe5d884d2 drm/amd/display: Check link_index before accessing dc->links[]
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Check link_index before accessing dc->links[]
     
    +    [ Upstream commit 8aa2864044b9d13e95fe224f32e808afbf79ecdf ]
    +
         [WHY & HOW]
         dc->links[] has max size of MAX_LINKS and NULL is return when trying to
         access with out-of-bound index.
    @@ Commit message
         Signed-off-by: Alex Hung <alex.hung@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [The macro MAX_LINKS is introduced by Commit 60df5628144b ("drm/amd/display:
    +     handle invalid connector indices") after 6.10. So here we still use the
    +     original array length MAX_PIPES * 2]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c ##
     @@
      #include "dce/dce_i2c.h"
      struct dc_link *dc_get_link_at_index(struct dc *dc, uint32_t link_index)
      {
    -+	if (link_index >= MAX_LINKS)
    ++	if (link_index >= (MAX_PIPES * 2))
     +		return NULL;
     +
      	return dc->links[link_index];
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

