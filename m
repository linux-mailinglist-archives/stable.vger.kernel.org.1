Return-Path: <stable+bounces-109465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A9A15EA5
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 20:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91F53A71D1
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DDE1A3BA1;
	Sat, 18 Jan 2025 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgTd6p9o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBD1F94C
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737229267; cv=none; b=nRSAer5NvuW7nZce9OpB/OpCRPxgOigmwUTKnjqiVJX+rsxLjq0fZaAwu7iQTez8S8F4kRmCTZUh5TOpyd0yvGdKzs0j2EP+Q32Em7rSHQt6B3r69D0dvx3KQuju6xbtjANfp2LehqpO+PJMLxUKKSfbTJqQs3j7TVfTZXJgDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737229267; c=relaxed/simple;
	bh=f6Sx6OYn4gJYdVxwKL2vSCodklOAaw1b388xrCZUdO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Whv9fprtyGyjb5mMyYKEnzLfYSk7CWCszHGP7HnHQu398hifebo5JckeViNv5lxgPgbtI38LbWPi35eCrahECVAMpS/XeXwHxrE9GiIS5i6/MlaC8uGX9EdtYre0hAuZYwACRQrQ6sd6mLqVG7/sE9B1YoIqAFcPWxchlKhPEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgTd6p9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62C5C4CED1;
	Sat, 18 Jan 2025 19:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737229267;
	bh=f6Sx6OYn4gJYdVxwKL2vSCodklOAaw1b388xrCZUdO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgTd6p9oRJxQcviPCo/6HacD2q4NBjev2KSlLPIjffHmwR3ZGFV6zRnOPPOpiNjQe
	 UpOylznX4dCAQWuUek/zEZzp/6xPu+HuYn2k1kOR2YJYABY3Xj5iPpu2xpi40zod5D
	 AvZMpxXsm6WNLG68C6Ni7FcTJ1D9TXurCVpA5PNQGz+Jt9ZiztI8gRVgosVjfOtrad
	 x0ESRd3m/hTmAnvT6Trp4ODp2H6C3cW6bENf3w1BWljGN1axtQBhQmPRqBbf9aGG4D
	 ckRk3xUJ9K7yp18/M1bN6WuCOnodf+UKkdvupXu5pso4JtvMA3SGNWWv5e1WzYDWfE
	 hnVVrpye7YhFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Tritton <terry.tritton@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] Revert "PCI: Use preserve_config in place of pci_flags"
Date: Sat, 18 Jan 2025 14:41:05 -0500
Message-Id: <20250118134658-7b2a2eaeedfc1941@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250117151639.6448-1-terry.tritton@linaro.org>
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

The upstream commit SHA1 provided is correct: 7246a4520b4bf1494d7d030166a11b5226f6d508

WARNING: Author mismatch between patch and upstream commit:
Backport author: Terry Tritton<terry.tritton@linaro.org>
Commit author: Vidya Sagar<vidyas@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3e221877dd92)
6.1.y | Present (different SHA1: f858b0fab28d)

Note: The patch differs from the upstream commit:
---
1:  7246a4520b4bf < -:  ------------- PCI: Use preserve_config in place of pci_flags
-:  ------------- > 1:  b184d5b5306a9 Revert "PCI: Use preserve_config in place of pci_flags"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

