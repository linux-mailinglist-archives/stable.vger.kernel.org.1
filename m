Return-Path: <stable+bounces-110859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6C9A1D548
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08498166D9E
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8411FECA0;
	Mon, 27 Jan 2025 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl5Svugy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2425A646
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977126; cv=none; b=L9KL+C73HnCkxsQSx5EnvJtENK68v5xo0c1xtzgtlGAwI22Qs/NQ9NYww+ZEQJeDi2oLJ8HfiYCchC4QVwH2MbIbxZIWnyUNGVUcy3Ae+C4VN2sZGfjv7gjcogxIm8slCkSjz6zrfHvOB9ZwW1w7aIv9OKaM6CyLumwfItq1CGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977126; c=relaxed/simple;
	bh=/dsWySpGwLiiOObCnDY/gecp0x4fddRoci8V5wgjPVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDkXR/GfyA+fMgbUitTppKS32sRUZj1X1+8qgUrdF7LHV0Wv04dZvsfQ61TgHfX+M+RX/MnE6SNWlo2jQ33lt0PcmpqceoC07Fm1W34cho3CF/MEs1gF1QYLERWvxFuQHgZyOU9A8Ex3rnGwZsAXHGHj2gcmI+1mrsHYyZRMzRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl5Svugy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E105EC4CED2;
	Mon, 27 Jan 2025 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737977125;
	bh=/dsWySpGwLiiOObCnDY/gecp0x4fddRoci8V5wgjPVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xl5SvugyHMLw1lPpLf8FiwH1zVBRiyk+IusOcT7tGVAIqLtj0e0fP8jb3v5fQ0r8k
	 xTburEAIl1rLxul/sYk7OhnnS/ZCMZ6eJCVbwAyOsl8wiNbQHCadcR/XbZUym/6Vrm
	 k7kCG2SIIropAS/vpA/lx4pKOcr+lKbe8J1irPC3OvkU6G7xqY305fQgleNuFw4pmA
	 IF9z08k+2IyOkfHbcsR16fszE3xb15JuH09yIJAunPF0D7eMj9vAY4vuUNAYBzvx0s
	 Mj3mdRHwl1bIt+eFBJpVE2riR3010YiwsctyQOlRMPgvn/Q/FOvFRXr0EtSmIehBT8
	 b04uOFwKVQESQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 3/5] md: add a new callback pers->bitmap_sector()
Date: Mon, 27 Jan 2025 06:25:23 -0500
Message-Id: <20250127042253-dcd220a972a726e5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250127085214.3197761-4-yukuai1@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 0c984a283a3ea3f10bebecd6c57c1d41b2e4f518

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yu Kuai<yukuai1@huaweicloud.com>
Commit author: Yu Kuai<yukuai3@huawei.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0c984a283a3ea ! 1:  ff77a8fe4ea71 md: add a new callback pers->bitmap_sector()
    @@ Metadata
      ## Commit message ##
         md: add a new callback pers->bitmap_sector()
     
    +    commit 0c984a283a3ea3f10bebecd6c57c1d41b2e4f518 upstream.
    +
         This callback will be used in raid5 to convert io ranges from array to
         bitmap.
     
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

