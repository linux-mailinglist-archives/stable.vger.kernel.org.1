Return-Path: <stable+bounces-127688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B93EA7A716
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A5D3A4C10
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD824CEE5;
	Thu,  3 Apr 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWAmolCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2C2417C4
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694740; cv=none; b=u6U9gpLEcljH9k2C53pZgNHo+/cyFO6Nh+gbUD87vd0WSTbHHeuK/23rundKHnTYqmCGqWoi2LoMMLMK+83L9/mTdTJ3RTteeUEKZAjDMchj3UEZ6GAVb5ClQ9SNP+0v4ax3s+7MkHEdBMN4lldQt25L8nTLhFH2CgT2KoOKPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694740; c=relaxed/simple;
	bh=UdfRFgsUsmh4OsIEwAE8s8NlBmk28jaK41vIUYOQnJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oh/rgUFqguXCTiDhnWhlHD/HNxN2Z4pjuPmj8u8VWy39UFTJfy3NbmX/MoEkFigMtjsy9We6C+NrKCpOw1s6W5yj4wOqyPGlP3glUpFGLkwwJBu4kcFSBusJmTef/mbgLT7YmOIa9njgdwoBANM63yRG9WGVXWCFahkkewpRIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWAmolCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D53C4CEE5;
	Thu,  3 Apr 2025 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694740;
	bh=UdfRFgsUsmh4OsIEwAE8s8NlBmk28jaK41vIUYOQnJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWAmolChVaxVaarw+C+gP2lAN4hSrO+Bs9umk/i2xzSTaOR83/GSaikKh6leknXN/
	 o7M/lgNnegkBOYTz79naGmB9a3mEJIXwOmm0D2oZVBD11mMrdsJ84UIPA+J22ap0dI
	 +66bUBKV0coJzgUPiUuFqWa3NdKxQoi/WKWDDM1WYQCKcV4f39hE7dgaUlXi6qnnAu
	 5TN8zDZLwBsNWnV8g+J4BhQZ7DkBokMFSJQ86rbJlI4qdcYswXNK14Qe0YBMNEW/Mm
	 Yi951TKwq7RJ8gpfCm9fIi5i73qolc5EYMU9Oxe7fS6j7rV6/HDZiS5AgLTlml8My+
	 km02yJPngM44A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 09/10] KVM: arm64: Calculate cptr_el2 traps on activating traps
Date: Thu,  3 Apr 2025 11:38:55 -0400
Message-Id: <20250403111229-7ccc63471153adcf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403-stable-sve-5-15-v2-9-30a36a78a20a@kernel.org>
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

The upstream commit SHA1 provided is correct: 2fd5b4b0e7b440602455b79977bfa64dea101e6c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Fuad Tabba<tabba@google.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 318ecdc83d48)
6.12.y | Present (different SHA1: 06c606749d21)
6.6.y | Present (different SHA1: 21d66c03ddd0)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2fd5b4b0e7b44 < -:  ------------- KVM: arm64: Calculate cptr_el2 traps on activating traps
-:  ------------- > 1:  5e58aa4bd4c8d KVM: arm64: Calculate cptr_el2 traps on activating traps
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

