Return-Path: <stable+bounces-155217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057C1AE281D
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F1E17C958
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D7E1DE4CD;
	Sat, 21 Jun 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpZlu/qB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C01922C4
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495915; cv=none; b=lRdUcMzKGCLfjoBivrxynC1gDHq8KJiCEmSDwqh1O/e1+iKhgDJyhIiFQMk2NWfTPXT3bhtGg1v6UZI3wTjc54T7d57ghB+OxF0PnrTnNWg5jenfxgFE5/SkKibwJLRqTENkUhe+y0crrqUq8royxPWQSzfyQPZDJTpV9cORhnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495915; c=relaxed/simple;
	bh=7PUNJBNdiScZHot9C6XTSNRaLt6FoRiclGbxwcQJOYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QL/1HcdzurGTlRxtMZuveRZpx7ZxGi9FGoiDwY0Eyr8PYpHTaxXEg/eRPKFCFqQ/8GPPcTOcpV0DNfS5I+P2fo3sP6bekiDFfHLQVNfEJGToKaU0eYCuUiojpAA2ZjGv03JHfjAvctxRRXqH07aKXWX2feNCscZ0hrvCOZB11Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpZlu/qB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1FFC4CEE7;
	Sat, 21 Jun 2025 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495915;
	bh=7PUNJBNdiScZHot9C6XTSNRaLt6FoRiclGbxwcQJOYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpZlu/qBboPA3IkRjqDsUkwvWdMuGJD8RIxt6e+/W6lLscJqd3TTw6fF/uGmobmWI
	 nbCj0GiGUyBcP6c+KU43Xdrfqnrp0O/FDORv+rARw0yan4jSvFgzI1+zR7twUPy3Wb
	 5Uqjk8FDyDanM21wluixR87RkiPxQDeU/vvs6bZJkinmf0bVYMMwZl3Xc1O5ktOHWS
	 qJiWGHjSfIq7HE/1xFF9jFkZg2UuitIlZbLNv9ZtwCCcFZD3rU0N5zKeFJZ+J90NAx
	 a232DVMDNwZ7KXgXidWB1FjgaqjzVDXsIFx8jjtM9PRBwZHMgemu+DkS4SoJ+ZEEYw
	 bMAQKVMftNQ4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	superm1@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] drm/amdgpu: read back register after written for VCN v4.0.5
Date: Sat, 21 Jun 2025 04:51:53 -0400
Message-Id: <20250621012446-dd9c8816875490a7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250619215007.2453681-1-superm1@kernel.org>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: ee7360fc27d6045510f8fe459b5649b2af27811a

WARNING: Author mismatch between patch and found commit:
Backport author: Mario Limonciello<superm1@kernel.org>
Commit author: David (Ming Qiang) Wu<David.Wu3@amd.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ee7360fc27d60 < -:  ------------- drm/amdgpu: read back register after written for VCN v4.0.5
-:  ------------- > 1:  8e72224fa5965 drm/amdgpu: read back register after written for VCN v4.0.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

