Return-Path: <stable+bounces-124238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D98A5EEDA
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA419C0EE6
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECCF263F51;
	Thu, 13 Mar 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX8kbjnn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A78263F52
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856504; cv=none; b=klABFqUoA3DqqZDzcokJYazzLhNXElzxaPFROk0+XPG8dU9gJZPbgC2EN67AHlqf9kWPxWikA1xxjEl/cP59Hzkcrki8IJO/F/fFgTx934Ehx+Kg6qS6EV04ONqAAVayzzqLU2fzNVfoyGPc/t4rNizn91OLdPcAJihvBCReDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856504; c=relaxed/simple;
	bh=IRNz7g9CAfIbxi3lvkKHf871t28N7lVS9AQ9bmxEsUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdfO9QCHtRGkBYr34Nm3bfSj+xDwEdsEnjP49d+jlbQ1lXCO/j43OTEvTctjYWr9twlBKxmXdhKD3mdNUv6k/lkNYIATjF2Zh3AIY0Z5fSu/Bbi/ZXz3j2jhFTDruYNpSXpyaGQtOXbQCNsx3OVk7cNP+NDXbcwhV5fqQkOcwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX8kbjnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D443C4CEDD;
	Thu, 13 Mar 2025 09:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856503;
	bh=IRNz7g9CAfIbxi3lvkKHf871t28N7lVS9AQ9bmxEsUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IX8kbjnnjkyRtrxog75OfLbAGqFbyF6PH58oobDhLgx6QUidyOUbCW1RryJ0yLtjp
	 zZxHlXmLrH1Kumrl8saZ0IyICJ8YhL/3zwGXeNCsmIJJhBmqCGCMxkiSRERzoPUGZa
	 YyEVevsJqHSMvva7NkYhkS4gDUaqVcnnXMgXlep6wzM3SY/YhODYhxR0ysi5F2+dyP
	 zgNapAhlV6O8ZDuTQEDzxUrUxxjs4zhtre1b5ailDHl2GBdj2rMN8GbrqbOyoljVhi
	 isE3ne2KrlM1xvxWrFLa1lOzuZa32DRxvJwHjExXa5vsQkJTN2gDGbWK8OjoBkXNlR
	 bweO9arVGwVzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] wifi: rtw89: pci: add pre_deinit to be called after probe complete
Date: Thu, 13 Mar 2025 05:01:42 -0400
Message-Id: <20250312222401-376773b9df78d3a1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311081001.1394-2-zenmchen@gmail.com>
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

The upstream commit SHA1 provided is correct: 9e1aff437a560cd72cb6a60ee33fe162b0afdaf1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zenm Chen<zenmchen@gmail.com>
Commit author: Ping-Ke Shih<pkshih@realtek.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  9e1aff437a560 < -:  ------------- wifi: rtw89: pci: add pre_deinit to be called after probe complete
-:  ------------- > 1:  1b950ee5b56cc wifi: rtw89: pci: add pre_deinit to be called after probe complete
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

