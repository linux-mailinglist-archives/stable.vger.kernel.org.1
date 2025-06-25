Return-Path: <stable+bounces-158593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77560AE85C4
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C56188A1F7
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A526561C;
	Wed, 25 Jun 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI8dEx+D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574D25CC72
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860544; cv=none; b=VD1iG1d7pym8YDe7DWJpSRxZyooTfkkBaZImjfySMKFueM+vEpvFgKJOdaxlxdbtBFu9QzCadnm28xOa6Tfd4bIK3B2kqz3DYyfatZxqWfyRaBsHTM+5fIOQO5TRRL/9YL0pljuvNflQApnl6nTRqNpaY2ZhKyGXl8tfF0My6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860544; c=relaxed/simple;
	bh=CpZJkCZWdmobaz18Xrc10k6WPQHdq75K5vPxMIRsRrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahlsJJRL8eMxjoaNOWO6hRS353rskozLkp7or+JK1W/fWXM0Xb1Hct6jB0aWUIIBQdf3QPo65IrauGG27IkKBsJj3k2LPXxWV8uJIiK8yHeuE4MRk9v9eDKvnX4PJQMpSnhq7NnRQnnjJEh8CnMYfYIU/TF7XMQlKxzSs7iGBUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI8dEx+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990F1C4CEEE;
	Wed, 25 Jun 2025 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860543;
	bh=CpZJkCZWdmobaz18Xrc10k6WPQHdq75K5vPxMIRsRrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oI8dEx+DEG7IqwCeeHrR7Dkr/IVuH5n6HR+IFUJ53EbeLa+RNMcjG2ObTtyW2fL5z
	 WDit5ezmCvGCCkE18r4fDplDgr9CDIWjDVp9mIzvpRIGjw+cgGCV094VZGHrkkmJek
	 yIbDYR9KnIxohRlYszgCwhFGsqi7CfTJ2K1hLH/hJVj47XUxJReGX0L7N7x75HrkTU
	 uvTkmDNX8lpOR9ltKzmcznLH+vr4Y8VSrgEOfRqXbsDHdHwASTxIqnWLVNxtKOI7TD
	 BeWu3HGqh23gAUCAtZQlq1TPHfNmYfoZ5mSFxDoDWBWysQ3aAD6o8ZixZeirm1d/Jj
	 DzyaX7TujYkBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chao@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: sysfs: export linear_lookup in features directory
Date: Wed, 25 Jun 2025 10:09:03 -0400
Message-Id: <20250624190110-7be094696d09ba0e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416054805.1416834-2-chao@kernel.org>
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
ℹ️ This is part 2/2 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 617e0491abe4d8d45c5110ca474c0feb428e6828

Note: The patch differs from the upstream commit:
---
1:  617e0491abe4d ! 1:  4c702e18f9b37 f2fs: sysfs: export linear_lookup in features directory
    @@ Commit message
         supported
     
         Signed-off-by: Chao Yu <chao@kernel.org>
    -    Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
     
      ## Documentation/ABI/testing/sysfs-fs-f2fs ##
     @@ Documentation/ABI/testing/sysfs-fs-f2fs: Description:	Shows all enabled kernel features.
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

