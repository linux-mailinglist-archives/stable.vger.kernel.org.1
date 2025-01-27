Return-Path: <stable+bounces-110853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57365A1D543
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E51D166DBD
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC181FE46D;
	Mon, 27 Jan 2025 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNIdQrD/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6701FCF6B
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977113; cv=none; b=jS91DlOgJMwlcOsoXNLzBSn/Q4u06x0B+ZcSxJQBmuIL6d9eMv3TlKPG4WsJzQ1bBiFaKS1LocM7ejf28GxAErhVZMcHoYQOqji8g2fhV3MtodwUmdUf5UQXllNbOQrGY3pFGyytop/ArMUBi0fa64Nd30RLkKZBj9mAPkHBKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977113; c=relaxed/simple;
	bh=Ja++qmUyDeBm7mFWd0XAm5Y34tDwG8FN21a6ebaebRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgml49mUZqtfKEDNi6fbG52IaOCDyS3HKwt75JzJ1qIqjYieQSTi4zr2174xJVLAtp1PakMNwA40w70da9K6id+Jcviqq2SoN4EpbawrzTKhiG9qreIlFt1vFky9UeNbxAULt9SEqPvbf3kWuiE/bJGoCc/hJeCO8gybdE6G7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNIdQrD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374B8C4CED2;
	Mon, 27 Jan 2025 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737977112;
	bh=Ja++qmUyDeBm7mFWd0XAm5Y34tDwG8FN21a6ebaebRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNIdQrD/ulHa53leaCFrRjXF+E27f7BWbLy4VxBN6AwAVAL95QYg/e7AshWdW7WIN
	 XaONhSWKEhwdH5HYTfnSiaM+T2EIvGHirt87VNQK0a2Js8Wz4fzpWWURrQW3cyQXUT
	 XC3txwvJCcbUaqrKlsMSQvwWWBkNJGGd8qoominMwmXHB+PFBgbd4wG+46jWxr2rH5
	 M7zT0qbt62I4a73rJbhwIYRhqhBvzRfVbASEHEbmSO29pw/wEYUiDqbIg4YccZ1gQA
	 d7eJODsrrPoAXWP/CshDm3realjLXEF9uKNbQ+I/c8Q2/XJwNqKdGIaNG0q/wj7V97
	 f2PL01yAxgTjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 4/5] md/raid5: implement pers->bitmap_sector()
Date: Mon, 27 Jan 2025 06:25:10 -0500
Message-Id: <20250127042454-182215826602e6e5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250127085214.3197761-5-yukuai1@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 9c89f604476cf15c31fbbdb043cff7fbf1dbe0cb

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yu Kuai<yukuai1@huaweicloud.com>
Commit author: Yu Kuai<yukuai3@huawei.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9c89f604476cf ! 1:  64350810f6159 md/raid5: implement pers->bitmap_sector()
    @@ Metadata
      ## Commit message ##
         md/raid5: implement pers->bitmap_sector()
     
    +    commit 9c89f604476cf15c31fbbdb043cff7fbf1dbe0cb upstream.
    +
         Bitmap is used for the whole array for raid1/raid10, hence IO for the
         array can be used directly for bitmap. However, bitmap is used for
         underlying disks for raid5, hence IO for the array can't be used
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

