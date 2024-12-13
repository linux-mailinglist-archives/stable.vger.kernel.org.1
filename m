Return-Path: <stable+bounces-104113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A04899F108B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62304161249
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6E1E1020;
	Fri, 13 Dec 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCPXWqrs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018F1E22E8
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102790; cv=none; b=uowbNgNu+tBtRri56w7nrV70CKMTosUHdRhGVo7eEdBa2WD5Azq18A9JSEcdBv/yMI388FACWjQcgduuJcT0vrM2G9GNZTzecajksOAyEEkMsuscH9+TeukSLwFwjNeAtPdcIH+PR/T3OodZgfZKOw+lvHYdwwMMSlVHigYpCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102790; c=relaxed/simple;
	bh=RY5G0q0N0MOrBRu2OkUkakYcKJXI5P855lkyt7KklyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oid2X4ORCspxIjT2ayFKf/6T4OEqxy2Muzj/JbNralLcTcS6Ak//VwuY1uJSIjXNk8lMrxUzZOfs6F46pmH8jImHX7ok+D3sKttBdBP6OWodjeJOfeRbopkdZq3Wxb9mdM2/7H0CsfOPlpLEAyx9LTX0vx+jYirxobWoG+e4crg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCPXWqrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35C4C4CED0;
	Fri, 13 Dec 2024 15:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102790;
	bh=RY5G0q0N0MOrBRu2OkUkakYcKJXI5P855lkyt7KklyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCPXWqrsGd+LQJN+guD/72w6qJDaohMjtRmSmtY2yugWAfqtbTMPLy/TrV6xYFLWX
	 rYHYAACHzHhfBs2jwW/DrAWm39DZh5KJx+xeyJWJ4XQBpaVoErk9FCQjjK7dPfL14g
	 Liw14LaQyUM0eP780iWX3iwXbt4hvfS65resnPrzuJ0nF0ZQcPTVEsfYH+N4sBe8Rn
	 FZorXihoG1TbSsqsYxatF3tXGXOJ+p813WTLnbJdo3enhJyYwrMqHs8gJZWzbsb8gO
	 LSHAbJy2JBKFEkrXNRFNraF2mSXtMrYVq47nu+MESkuQ253Q4l3opxI96iaLfhs0NJ
	 8zct+W4QcLs7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2][5.15.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Fri, 13 Dec 2024 10:13:08 -0500
Message-ID: <20241213093540-24339cd56968a053@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213102405.3580198-1-guocai.he.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: bdcb8aa434c6d36b5c215d02a9ef07551be25a37

WARNING: Author mismatch between patch and upstream commit:
Backport author: guocai.he.cn@windriver.com
Commit author: Juntong Deng <juntong.deng@outlook.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 08a28272faa7)
6.1.y | Present (different SHA1: 7ad4e0a4f61c)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bdcb8aa434c6d < -:  ------------- gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
-:  ------------- > 1:  2d1b8021a086d gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

