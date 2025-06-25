Return-Path: <stable+bounces-158580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACF9AE85C3
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F295A606E
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0979E26656D;
	Wed, 25 Jun 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZblsMPQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98A266565
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860448; cv=none; b=O+4z2D4xeuUONMAoNXwIt5eJsSziYLzv4d0YJmHwfQWFk0Orw0csTxe+fPd+CgSmS5lcnc6fkh/TJBPfXeVDejF10SDx6Qcd/ZFe8JyX49RHW1cXNeQqYxQijNWQLe/98WIZdp6Uv626uTtNEddCz83InPfDI8KNv+HFIvRIFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860448; c=relaxed/simple;
	bh=LRfoGXP+uItb/PAEW2lhJZ8QHQk4pKJzAyEeF1Fp2Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUEADpyR9xjIZlChNQwy36LDg9WRGbce3P+5optkMd+HLKOmz8E8FmSaDG3aC9npgXXxeZz8Cxc0ZJmYjtliJVsWa+GJsZ9Y3xihwGohd2oFDTTVeqUF2IkDkRWXGRqSO4uUn5vABnXW6UGvPm4Q4ojy5TnDkgV7GdJQHNXEQF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZblsMPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C2DC4CEEA;
	Wed, 25 Jun 2025 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860448;
	bh=LRfoGXP+uItb/PAEW2lhJZ8QHQk4pKJzAyEeF1Fp2Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZblsMPQIHowFn4MREi2uHGuKj6rudHEa+Lmdg9A1CmyQESFBZs6Sg2ahl6QTSwVb
	 FHp5KcTAkwjVHtL61wKRLBYMvgC8DhVJbvhF1TlaIgfudMFF4RwTdVPpvLU5rwZ6aH
	 qmCHsN26dX0pbLPns35dsMIst/narsandnqriIqpTrY7g9+/DccCHY9yf7J2Kh76C5
	 nmnxxUfeHRVF4psGYXtpDD3v4HI+4581Bj9Ew4ev8j1K/ldF9J4H0+h36OicXz7Ysc
	 79NZjM7oC3pUWZdhgVIVZJsUuSVVtGbEcHVGl56cOrhnhfXpX6qjq2wvG5I+9YnboG
	 qklMOYLEcqS1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	zhangjian496@huawei.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] [5.10-LTS NFS] fix assert failure in __fscache_disable_cookie
Date: Wed, 25 Jun 2025 10:07:27 -0400
Message-Id: <20250625100635-0871d0f21c906d38@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250626020035.1043638-1-zhangjian496@huawei.com>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

