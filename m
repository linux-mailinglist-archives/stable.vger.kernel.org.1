Return-Path: <stable+bounces-124248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF9A5EF20
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD323188ADAE
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02AF264F88;
	Thu, 13 Mar 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMOYNkEL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1E264A7B
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856930; cv=none; b=XkaDqGGzniegefmbt1fwyTKKsv2J/GvzFUa0Th/EnUbIj+ZZjFsN1OZ8XQXn3svY98irH+JoaBspVSqp4rQrUAN59WWuHAYFUOdDkOVr7paI9gboL8wQjm32o3FMDZdbMFK04HnwFr/p8s4Fzo1iOQqy5iXAbTdIfDKthI4nOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856930; c=relaxed/simple;
	bh=lwSeuVvVYfb1NcCAd4t5+wlyQY16PWEpdQhrMVyjnjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWInU25IYZcS7BlF5kZ4mBNsTRSIeDl2kGCVDc02IWuB+lNSLwWedVRsn4PXp3tb+sFuldIpMGMwKI9XGvBamELp0VfkDAIYlzpXlHrXXd4SN/J/L0ZjRx6or/cJHfvzmHls9iB9XVFE11IlW9FzAZy1hpZSEpaQNRrLeuXQ11o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMOYNkEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78670C4CEDD;
	Thu, 13 Mar 2025 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856929;
	bh=lwSeuVvVYfb1NcCAd4t5+wlyQY16PWEpdQhrMVyjnjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMOYNkELsYu24b21DApmaA+p/pf0Cy+KJ7+SIUtDjWOjMfXqhZpeeNPBsOmnU3vBU
	 gVcdzlgwWfM3GtF4boaUEfzlG8O89Ok7JYtLMYyqMAYJf/hK8HkSq3oZYc8woxzSji
	 WztF141hIZ+LRwW6yE8pK9jwOwhrODwAb2CVv2vW17lJUASL1pT7yYxhHBKKBTsknY
	 qUCoHjA0MDKwPCqxyYXrQ3lZ72ifBjfQeLfbJc0dokpj/jhb0puROZVpuYivp6YJ10
	 Xfaw62/Mf1xE8X1uqlZdfcwcfHs4dp8sFhr4RboWbG3TWHPltW6wBC/rOs3J+Ug+88
	 ygdDP+2JWlnKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date: Thu, 13 Mar 2025 05:08:48 -0400
Message-Id: <20250312221634-814bd966ecd9cc70@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250310084820.20680-1-miguelgarciaroman8@gmail.com>
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
Backport author: =?UTF-8?q?Miguel=20Garc=C3=ADa?=<miguelgarciaroman8@gmail.com>
Commit author: Konstantin Komarov<almaz.alexandrovich@paragon-software.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  91a4b1ee78cb1 < -:  ------------- fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
-:  ------------- > 1:  eda5808d02243 fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

