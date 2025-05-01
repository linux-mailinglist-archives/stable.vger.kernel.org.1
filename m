Return-Path: <stable+bounces-139381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3BAA6393
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA224C2DD7
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD71DF751;
	Thu,  1 May 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgnAO/4L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5775224AE8
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126700; cv=none; b=ICK/08jbpLLTMfacW22lzjlY33MAQMgvnKeTGLvoB69hbkGtSGRTKka9SRY+0JUG32RFKbfR+shDezw6luy7MYTgPgEdTL8dWansExBK8JP43B6oh5jpd42cK89Oa+2gTh0IXYAD8xANIzvSKQ7VdYpjevIvlFyMvGBnES71T4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126700; c=relaxed/simple;
	bh=pP2ALbVZTYC7Yyvv7001DMtab8Zt7NPdNNzFjGsjzgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9RzFeUl873DAIGcovd+OeoUFbC565AzCWky8ppuMB16icgQzsA2G9g9ucGPt8jhiDslBdLx0+3dh2JsagTkIfV4a/d8eBcCC9qeQuHxvV1fVZNhPRCTa7A7PlPKMwoEAtWBzQOHdwHWa6QFWt2DK56XUeA/zdSGs3nedY1C2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgnAO/4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD683C4CEE9;
	Thu,  1 May 2025 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126699;
	bh=pP2ALbVZTYC7Yyvv7001DMtab8Zt7NPdNNzFjGsjzgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgnAO/4LTCL52IOoVbUWGs8EvsuOaZSf+qJGdwxkzor91Rk3azQjPPXC1np3EzjzC
	 Nzq3i+mXJ+UEM/SjvOMMuKRFSVuFRdAmfPwqW+xJBWIr8IhglrUettLjgZFg5NFd5d
	 zf5eDPex8HYPOfCxiNAo+HqhMlyarCyx8b7ED6r20WzZPY5xpynj6T+Tpn8vkintM4
	 Z4l2B25FPsvpkCoy9Pdv3ZIrRVH+3AWG8B6icE8MR8V7SMdYIFk+QRtMsVKpml0LBu
	 P5YLJ+Lfiu5ilzCHWgG2QKY/+HSqj39Vjd59LGS5pn2vEn4aABNSQifnTk1DfpclTq
	 16UWDnIBERlyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] comedi: jr3_pci: Fix synchronous deletion of timer
Date: Thu,  1 May 2025 15:11:35 -0400
Message-Id: <20250501071630-02b3dd194edfb7e7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250429130601.672190-1-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 44d9b3f584c59a606b521e7274e658d5b866c699

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  44d9b3f584c59 < -:  ------------- comedi: jr3_pci: Fix synchronous deletion of timer
-:  ------------- > 1:  79900d6e5bb4b comedi: jr3_pci: Fix synchronous deletion of timer
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

