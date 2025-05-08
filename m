Return-Path: <stable+bounces-142883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E40AB0011
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D921BC65B0
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE127F4E5;
	Thu,  8 May 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbHD2phk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAE22422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721067; cv=none; b=bpZTwFzhVGtfz/QW/+sSH7iyuXbk/aMxNaTz9JA3UN8w9ydcm6GZ1ImrdkLdEfH6sBFMp+q2jxGxvIZGcLjCe9jX4XiL/IRKFLYOu3qEhl1zLuQPb6W0sAq2HVwPz8mzjnxUXAAjfu+To6hvde+cKAGbXwxJXXtIcywdO9PMcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721067; c=relaxed/simple;
	bh=uBNG0yKSVCE8mpPmkmJm8onFXGI6nN2ZmUB/n8I3aDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEBBJ52D3BXYxgDz7LA+RokPHUBKqmhdIATyLQJ0kOabmlcMRdWp+kPU5JeLQdzjo35Ma+n7INuhkyaiSl/SKKgzm1cpnN1Txf927dddpJf2yf7Abh6gWxkhJC4jAaq0ViVbY/+t+3xCO/yoxpvpvWVejXLhM7Vl5cGm97Vct9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbHD2phk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F8DC4CEEB;
	Thu,  8 May 2025 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721067;
	bh=uBNG0yKSVCE8mpPmkmJm8onFXGI6nN2ZmUB/n8I3aDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbHD2phkUoRjrzGAoHTFaMwp4UKYRmOpWtsy1C7sViGx26mL+gmmB3m60ebxAdQIP
	 H9FgBkyUdDTneljYSoRh1rIhyK/xULLmZQbVfJjZf/ehZFmXt1Zn0010zVZx0J8+It
	 T4u8H0vihzeYAQ62NvBO4pHynqrwiDe0Q43STZHs/5mvvKTkVHljCvqlnXL/4lS5NV
	 oJucWuWE+g5KrdY1LwPguB5sCiE/UcSizDDejit6leE/p7WbfmfOBkrzty18gM+iq2
	 6I4OOUXDuGjWwvsL/5dZHI2YLPCFe0UlhKpRCzhvmFpYJ0sLOlJw5NJFWyamzDH0dj
	 +8IjaEy+4RevQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 4/7] accel/ivpu: Update VPU FW API headers
Date: Thu,  8 May 2025 12:17:44 -0400
Message-Id: <20250507120702-04fba9a53cf4c7af@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250505103334.79027-5-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: a4293cc75348409f998c991c48cbe5532c438114

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Andrzej Kacprowski<Andrzej.Kacprowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  a4293cc753484 < -:  ------------- accel/ivpu: Update VPU FW API headers
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

