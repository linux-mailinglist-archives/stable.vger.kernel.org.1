Return-Path: <stable+bounces-124302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A1A5F491
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328A019C23B1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC71A267B13;
	Thu, 13 Mar 2025 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAmCxTk5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796012676C0
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869113; cv=none; b=Y7T3XtdHodyLSjbBnug+OfZEeaRauTb8/D6ADesdVeUljBJySTraz44gGcYR71yMDOTO9iQo+ogHhAPF+An0w9CK8YNyF705dK1+omD741TazxYX2li7PFQEuipVt3AFuuUxchxP2vDp7kevG26FOzY6Ofs7icifeGucNETUkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869113; c=relaxed/simple;
	bh=r5lnrIa5xB0pcWBxukVlUykrBY320BZh9nZ90rYfkI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7Wm6CfYyNNMdGga6tHDZgEfXInKh4tJtK85R55JrhkwQ5aPCkVGuXhXCoOAFJmdxu67wKrhah4Za00Qnpd9LspAUMN/64upSbwnpyP8bh6LNkpevje5d6ZGZJdQE4UexOP4F0NYSpvvP0+rxegE//nIRHXPIkj//aUSrvK1DAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAmCxTk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17F1C4CEDD;
	Thu, 13 Mar 2025 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869113;
	bh=r5lnrIa5xB0pcWBxukVlUykrBY320BZh9nZ90rYfkI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAmCxTk5yGI7xPZGjEkOXSpSaDmXOFR8TFbQu4Fn/3P9DCgdNRA552oi0u+y6WvOG
	 hsS9qbz0mjni4x6Z+5AArPyWl+iSs5njgQXQRezwERtivuShYOHBVA0ZF+PJrYd4lu
	 qxasy7T9x6/G23GIbc8l/BynEE4zDeXoZYbQuhsGSOjsnGIwNdGGizOD/EM/6t6WXS
	 Q3p5V68ovie7XkcGGTA99UHnIc/JBABqWCmkHGcahTfO9qccT5W8FaVhQNDLtdIZI3
	 S4cyrJ1uHJcljkhnLSk9PC0W9rJKUCy7xx2HOFExv3WAcHu9ROgkWv6Uaaz/bN2mHP
	 Icf3Li1JdGy2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date: Thu, 13 Mar 2025 08:31:51 -0400
Message-Id: <20250313052447-d9e28c823606000d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312120802.19500-1-miguelgarciaroman8@gmail.com>
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

The upstream commit SHA1 provided is correct: 91a4b1ee78cb100b19b70f077c247f211110348f

WARNING: Author mismatch between patch and upstream commit:
Backport author: <miguelgarciaroman8@gmail.com>
Commit author: Konstantin Komarov<almaz.alexandrovich@paragon-software.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  91a4b1ee78cb1 < -:  ------------- fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
-:  ------------- > 1:  a92190c61060e fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

