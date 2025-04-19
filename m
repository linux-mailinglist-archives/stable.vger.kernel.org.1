Return-Path: <stable+bounces-134683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA47CA94332
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381F0189A042
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D631C84A8;
	Sat, 19 Apr 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1JmWyJk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C111D61BB
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063231; cv=none; b=czc8a3FfwYQ3l48nletOL/bBfAvuSUJ1gByQA4gFPuKDiAtoF/b0mAKFWRXye2Bd7gNPHbZKCX0eCrNBxRrSVjzm/ihF4DW26dh1eNuur81i1jZ2TkMmUZmGVSX2nrMUilMRKonARqnCMZHkNni1N+1j3BvgGH3RZvWylDVgO3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063231; c=relaxed/simple;
	bh=IwYyqto/YaFqaCXk2DjLLHuO0AOYOJJo+uQSwtQRcT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNN68Xg3zNzaj3Bk3PCC3tiGQCH9YRj/bEGEXUhh6PfynPKCO8onnNtFgr2q7JzcYiSng/oSH9YPMobDi8+mtHSsVzYnPf9iv8+9P/Y05/PEPkE5m7v49PU0k1yYZGcmAzuE6OUKWYxyFVHDwfitzAA/DZLQ6ZYqR4TYz9sUjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1JmWyJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1789C4CEE7;
	Sat, 19 Apr 2025 11:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063231;
	bh=IwYyqto/YaFqaCXk2DjLLHuO0AOYOJJo+uQSwtQRcT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F1JmWyJk2Dq8bGyBTYL4RxLLLhsW0yn2bil0hBvqQEghpkARrNzkX5Tj6j1tGEsvK
	 yYEJSup5X1flemNKIlMr8JqDZwAvlkmoJzVyWJC5XMMxoI7n9QLBipjdg9EEbwGBRl
	 FABODmpHkAEr/KeXGDXfvlNba3V1HX0bZKg94ddOszeUgwkXqxUqISoRPXIg5EIg5j
	 BDJ7x3RpjYZSi8cikrMqu3ER4jGMqfXuCwyWcRxSs1UEI3/I1wwOlhHIqio9sd3wYP
	 XRjb1/KoOksoXOa4whBI2LzYTycwZbqKw5YifS5A2sOh6xDEDjsIkI06n2MOx4gMUU
	 7pJFw1wYdZt2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
Date: Sat, 19 Apr 2025 07:47:09 -0400
Message-Id: <20250418191038-7525df6970a5a32b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418124508.2046260-1-hayashi.kunihiko@socionext.com>
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
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  baaef0a274cfb < -:  ------------- misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
-:  ------------- > 1:  bfebcb91d3dcd misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

