Return-Path: <stable+bounces-106150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515859FCBEE
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989161612D6
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FC070827;
	Thu, 26 Dec 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSzb4y1o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644D28EC
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231471; cv=none; b=qA//c6Ph5K0RQ8TaxzZBqlJsvfzOFnoH/iEE1+9o3mSwZMnqImFJIv72p8g8glsTfIdx6+h37+boz9XO13XZX7vyb7VyiUfFaQbJmyqhvwONxMF//m1MFsU9NSd5hPFe1jO7nwAv4kSiWq+my83zkU1KKhFfTtuB+nDb7lAV01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231471; c=relaxed/simple;
	bh=MzS83jKhkDPhqGC3nuPspZgfmfF8xywuJRHp5okuHgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTq03UbRQA3VIbZamV/jFR1aIo1nRlLRgjKfP5Z6DlEdPifBk4YRj1eoIKCXZWjSgUjLi+83Z2Yc/r9vEHmEXLHPa+6DYWdmh/7CyVHS0wqIme6KZYhgktPemNa8fTdZZkEdG8HvQn3K1Z8LtORfpx8mx0Xa/Tz/Ete9ssKmjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSzb4y1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B895C4CED1;
	Thu, 26 Dec 2024 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735231471;
	bh=MzS83jKhkDPhqGC3nuPspZgfmfF8xywuJRHp5okuHgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSzb4y1oNowOKiAp1M91mwRrwrs964IDGENNx0esP6RQJ87/5uu+aprNebDkC9qAZ
	 3YKwREByr6UT7WFr6ts/lRMWclbPkFPrMKvkhPKyjvltOFeBtcxhdQoW6xfGpGy2Tk
	 02vWtkrwM/3UTH68YjHBrxIcr7tMlcPwTzBQWyM38L+fMhOPvQbJ8DMR9P4MjFTnIC
	 P2Zm21O6rpCoI2s/GL6YhMiHZOxxqX76Vx4mYamnhau68YsTDl5iFjU7XlwYPIhlrT
	 IAdY916TbEUF8MomGtT2sajPjPu0nnlHYOSUKR+L0T4UWtTtgqCGVfy2qh/YQAGI33
	 riorQahvw2Hqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net/mlx5e: Don't call cleanup on profile rollback failure
Date: Thu, 26 Dec 2024 11:44:29 -0500
Message-Id: <20241226094137-4aaef6d305ca4ea6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241226071131.773866-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 4dbc1d1a9f39c3711ad2a40addca04d07d9ab5d0

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Cosmin Ratiu <cratiu@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4dbc1d1a9f39 < -:  ------------ net/mlx5e: Don't call cleanup on profile rollback failure
-:  ------------ > 1:  4defc045120c net/mlx5e: Don't call cleanup on profile rollback failure
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

