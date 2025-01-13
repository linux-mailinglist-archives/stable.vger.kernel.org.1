Return-Path: <stable+bounces-108549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C5CA0C53D
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E20B47A25D3
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E821F9AAE;
	Mon, 13 Jan 2025 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyJdY5oC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB621D5150
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809763; cv=none; b=a6odDYTQ4l+Pso3Szc+yMM/TvvMbgapogs+iExarlO+eiEtHlYNcIqb9UaL5npsblpZ1cG1IBKryHjfpNam0CRkoqtpzF+J0YiE5vqOdz7yoKEeKAmp3efLlE896NsMNeZkLdThE4F6vfiWOAphlTP6Op7JmMirbApYkHnRzmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809763; c=relaxed/simple;
	bh=Mr+KwNyfl6fY8MnvhtF72rXt/UHJKGkpKT2dbCk2Pr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDIJdoEe6g+a+oOTx69WgTOLk0ID/z+XY/ApGw4aT2/lZ9BgkVdymn81vUV2JPN/nDWFyuGZAhDCwc4s+KSfhdpoemc6rnyqlKULH9XcsNSLW+M94q1SiDHNYjtPA88hVsk1bBT4DHW2YPh8fk++jfZfki2lprqwyGzGZvE5Dj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyJdY5oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4C1C4CED6;
	Mon, 13 Jan 2025 23:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809763;
	bh=Mr+KwNyfl6fY8MnvhtF72rXt/UHJKGkpKT2dbCk2Pr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyJdY5oClyyOvLxNPGOEO1MwKKcz0vLjNTOolKQWpl/Kqss81KSlteriOgaCoxaWx
	 XR2pUcKvFnboXUMeQTQ2tmYQ1Z20SL0WVerKrevKfGiV95Mgs6TMhYCgKVuEaDh35i
	 CY5XY5MejZ9J5gEIz9i278RQhlNH1qEE1uMugBXbnHDHFytMXoj7SYEEpDguCOp/ca
	 7xz1JGYeBVRjmXsHpUZ59Av5PBNlWBNqIOMbZgkmtcnvgN0YM9+4tONAlW2GOjBoyp
	 1I+8NNbvqpMa9VygujXwDu7mQ8KH0kRcHy88EAcY3whKK7t8ptYGunLp9PvEUjRADl
	 K4sI3Ejyt2Z2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2] mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
Date: Mon, 13 Jan 2025 18:09:21 -0500
Message-Id: <20250113154528-72e78a7c64520887@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_CD1AB68F5D4976EB329C2698E60661DA8D07@qq.com>
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

The upstream commit SHA1 provided is correct: 091c1dd2d4df6edd1beebe0e5863d4034ade9572

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: David Hildenbrand<david@redhat.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 42d9fe2adf86)
6.6.y | Present (different SHA1: a13b2b9b0b0b)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  091c1dd2d4df < -:  ------------ mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
-:  ------------ > 1:  53f87b7f6966 mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

