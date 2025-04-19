Return-Path: <stable+bounces-134708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDDAA9434C
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3CB3BF6A2
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7B41D5CE8;
	Sat, 19 Apr 2025 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2OLU7jb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47B1BD9DD
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063452; cv=none; b=eeN+3d8ui4Ns/YE/mo67RNOE3updYQ4AgN7MoB8RGf6fYsBRrm9uOa4dFBg1sxqy9a/UvqwD29OVkUuF4xSrW9Xj2nk/ybY29ZUyXNVX7OPecUIfX4DY23ywgNnpxeIpELfJDDkFYa3sAAA9Fk7MhPCuYtTCDYAwKDKWirK4FVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063452; c=relaxed/simple;
	bh=GpnZxT66/oulFeWNoACebTbkFbkztyPeeHQMlOXj++Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+hfp8tfblqzuaDPXFzEyixjuzEf+AzW0/ZrALLYtJd81qLmndYQE6VqEJNtL0AsB1ct3k7Y0WXVRy9W5QIhkSji2vX9xMy8WDX8rxGD7s/8jn1ofPf4KF86unYC3nQ8xgp5mLVtU6pd95W2F6Sl6Ggwy7CIjWVdz75uEQiPFhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2OLU7jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689A1C4CEE7;
	Sat, 19 Apr 2025 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063451;
	bh=GpnZxT66/oulFeWNoACebTbkFbkztyPeeHQMlOXj++Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2OLU7jb0Y/oC0Zp3T+9ZdWbMKHSfxe4EKlyDeVZuMl6pNLGSmztSn7bJ7cQwPAZm
	 puYjrGFyS5NBAbCHyARlO4KOOgEYI3xWaOZ6prWKeINsAal9K9G6tiNAB9mygQSPNG
	 vEl/+u+XC2XS3+T08NePFHF+x6dukGmE6YZfNk98e/BdncXcByqgNxmnCmYNe4VG4j
	 +pdRPMBPjGsg7cfEYPf4di5LnmVEYjJdxmWqJ7ms0Hy2XYzWojRmWJJPyT+gkLR069
	 93LRMw2bjgX4rEprwrQUKseey76TtSEFzbDIOuzOa/o+5jmRdAEKxWtZKwoPce/Md3
	 pk1JMU0EhEYMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
Date: Sat, 19 Apr 2025 07:50:50 -0400
Message-Id: <20250418170738-c4ca630413c63f8c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418124428.2045991-1-hayashi.kunihiko@socionext.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: baaef0a274cfb75f9b50eab3ef93205e604f662c

Status in newer kernel trees:
6.14.y | Present (different SHA1: 30ade0da493e)
6.13.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  baaef0a274cfb < -:  ------------- misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
-:  ------------- > 1:  ad173c593bd27 misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

