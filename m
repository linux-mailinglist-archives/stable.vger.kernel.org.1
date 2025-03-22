Return-Path: <stable+bounces-125824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF223A6CCE2
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 22:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CB11B60F01
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 21:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934EA1E51EB;
	Sat, 22 Mar 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCIVw+dv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7886338
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742680275; cv=none; b=nzGuBYvDqiLKGfTGlBukquTFcMId62K6rqWViXsSldnV+Jjnv7lOiGEar87pewh2GnUwQQx3d0rarEudECTztj97le7LJ9A1Xn3xfuNCNl3SNlkSA1By03Hr1uCGs3sIzG4dAWWby5DUyasFq3DCthwlhEUXcvesRTTRthdAevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742680275; c=relaxed/simple;
	bh=YN+WUeLT9otMngUbDY6JZ910v1zd8Mqg1TERclfHgD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDN5cpAXBsSF2SsfOBTAMzsLMYMLBFZkVbC6/iBfbVRczBvvl2pKqF3ic1uUw9PX/tEcH5HjuAWTCxNmZAr/qXe2hjvTFviWP8B9mOUTEiFP6mpFOkCLfNt7dqa6Nexx/cqO6A6xvPIrqW/S7McZ+pwDGMeO2j78jtUmYJJ5dc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCIVw+dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B3AC4CEDD;
	Sat, 22 Mar 2025 21:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742680275;
	bh=YN+WUeLT9otMngUbDY6JZ910v1zd8Mqg1TERclfHgD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCIVw+dvYYlYFe6k5vSv7rnODXmXRlD5P0CByBmFjOU6W8xX3QHWzUNVX7RCTX25s
	 bter/SR4+tQYq2FgQ07J5Ni/TyglvFNfe9yjuF0l6vjKb0loLYFZP41+PypGMPifBj
	 gfaHy/SJqI31dvQKdJZu8f02kqfEEP1CZuC1fvwEzCFeD9m4Xx0LmgQtDakqHhUODa
	 gNT/nEy0JoBWc+kyhXNmIEsVVQeFH1IgFlhBYx8tWDV5HGqJHMgdZrcLn0ssbpS938
	 +e5a+PsMAI4HQj00Cq3OboEku6ps5G8Aqxk0y8SLn/iqPoFrBuy5tgWIuec5P4ioMT
	 x675CNvrEiS/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 6.6.y 1/3] mm/filemap: return early if failed to allocate memory for split
Date: Sat, 22 Mar 2025 17:51:03 -0400
Message-Id: <20250322103106-f5ff05052ce8944e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241001210625.95825-2-ryncsn@gmail.com>
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

The upstream commit SHA1 provided is correct: de60fd8ddeda2b41fbe11df11733838c5f684616

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kairui Song<ryncsn@gmail.com>
Commit author: Kairui Song<kasong@tencent.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ff3c557fa93e)

Note: The patch differs from the upstream commit:
---
1:  de60fd8ddeda2 < -:  ------------- mm/filemap: return early if failed to allocate memory for split
-:  ------------- > 1:  344a09659766c Linux 6.1.131
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

