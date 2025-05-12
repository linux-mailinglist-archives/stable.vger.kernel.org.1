Return-Path: <stable+bounces-144042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD847AB46B9
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEED1888333
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7BA29992B;
	Mon, 12 May 2025 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID1ULRJa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCCA298C35
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086699; cv=none; b=ayzOMjFVFkStZkGms4OoejnkwdPrUT4RKROfSvmu508BOTqu/OCydCI23KERK0uwU3wER0Nf7lAbhwkXgxvHbc2QKH2nAg0eZRap5kSDl5z4ymtzOOrF6bVVzthEVHRVL8V0wm5jc1nA/Q3fqbHZi592ql0IIn3sd3ROQAMhXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086699; c=relaxed/simple;
	bh=D8w5hwc+j+iW+wfazJbsXHKaB69LX45oDlQDWT5Ok7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RS7uAqJeg4kmh3E4bdrXMN3hnA9AC9ybiA4bWm0P+eaB6kJC2Ej5VUtmPRslQccyWdjmETGux0P3rSPOC72CiXVrmneDo4kxWs+Uzxb5bXy/s0gJlOKm2mSzE7cvzVTufHlPMoSeEFu9rF1MgKpsTK/K5y7poCmJhV80apJW3IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID1ULRJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE33C4CEE7;
	Mon, 12 May 2025 21:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086699;
	bh=D8w5hwc+j+iW+wfazJbsXHKaB69LX45oDlQDWT5Ok7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ID1ULRJaj7zOFZGGBpXAGChqiFXRrV+HHeL7HwDno5X15ijD2TByvj6gZyFcAIpfk
	 MY57bve3eB0O15Zr6zB9qGZ2kM/422GvEZy+saUKgCQ8HuqJ5WJaN+geeolNRL39HC
	 FAs+NuPSrEejTyTglQW/ytuMGKKISVJBWQy9UzvU9JEgtMkWGMiic3oGx4UvzU8X6S
	 ZVq56yMf3//MDkicG6GLqG3xpC05liNmBISZ+O9ypu7s2YigXKrR22fiZczZ0Y1LV3
	 acYhLjrbZW7yOKMZ6asII90XrVRr2g+BEgP9MZ6Xvhp9MZawbF3CGlmHPFFOkc3xfW
	 kxJgy69s7kKiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] netfilter: nf_tables: fix memleak in map from abort path
Date: Mon, 12 May 2025 17:51:34 -0400
Message-Id: <20250512163639-872419907546246b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512030914.3330393-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 86a1471d7cde792941109b93b558b5dc078b9ee9

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Pablo Neira Ayuso<pablo@netfilter.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a1bd2a38a1c6)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  86a1471d7cde7 < -:  ------------- netfilter: nf_tables: fix memleak in map from abort path
-:  ------------- > 1:  d8e7bbe3d277d netfilter: nf_tables: fix memleak in map from abort path
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

