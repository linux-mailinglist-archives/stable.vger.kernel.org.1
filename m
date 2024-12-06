Return-Path: <stable+bounces-100003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F5C9E7C48
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 00:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D385166265
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19891C3F34;
	Fri,  6 Dec 2024 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwcu44/e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DE1EE010
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526714; cv=none; b=dGFc5rE1avmMvLZoqJDOvaeYVtorOskGyETk7jsfkw6o6QCU1lpnIKkrMeiq/qPFawMrAExzOShCEXS5y6zPiH2Ak2KB14bEnSY7aa37C5cYtWyih6tsWa1DWUO6PRA9eGQDUD9vOHcK6xklHc56SeVVzPMdTXJ/rrj/gwfBMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526714; c=relaxed/simple;
	bh=C5eZBkhI9RmlKEOismHWEa0zmsFk8qvqSxTd7NPiVB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONF6obkcjWX/x9DIx6U5TOsntQCKnAtrYY/EJ0U4RSw2nI8HEdprrCtPpZQq64m2cScVuz15oU/4E39LDDwlK3oHXBrOKoDe2yGc26nkvzIFaOFB6JO/Bw3lwdL+30wXFYIj/B8Ed0Vs9VgceRsQbaEXDHFHOl3a/2+wnB2MpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwcu44/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE54C4CED1;
	Fri,  6 Dec 2024 23:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733526714;
	bh=C5eZBkhI9RmlKEOismHWEa0zmsFk8qvqSxTd7NPiVB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwcu44/e/5a/QS5FZk2Wv7rJSfGzdCq9uJn1z+jFWSXIY20mPnSPV+0SYMhf/PbiM
	 5soRjhRWIHJD4jxZE8p3NoBFkPVvvnyfMtqAfeZyPFxFOuhH/t+0leRAPung+3LQwm
	 iVR7hmJvb1At1Fj1wqttOuOl5e2+8vPfDUh+ZYO0Pi+HgSy/UCQ8B8SeQ/x4noqAiy
	 SGfW4xyYFqgvydp2wUE8z/wCd6mbqhAKNV5LKg+P22LtafEf2jJ9uO0BX1XLiXYeLA
	 GFSN0iOy6+hxXc9GpD+ZO4nazUy1nzoc0JvZLfzawm9R+x4ZDF9jAZwsQS2hh8cTRx
	 pwaIweC14Nr7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC Policy
Date: Fri,  6 Dec 2024 18:11:52 -0500
Message-ID: <20241206122710-f15a767dd7c51586@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206162117.2496990-1-alexander.deucher@amd.com>
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

Found matching upstream commit: 9afeda04964281e9f708b92c2a9c4f8a1387b46e

WARNING: Author mismatch between patch and found commit:
Backport author: Alex Deucher <alexander.deucher@amd.com>
Commit author: Fangzhi Zuo <Jerry.Zuo@amd.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 2141d5c5c54a)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

