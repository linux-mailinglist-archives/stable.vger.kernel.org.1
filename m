Return-Path: <stable+bounces-134688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AECCA94336
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761A68A4423
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A7C1D61BB;
	Sat, 19 Apr 2025 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gvkq3QO9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994BD18DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063241; cv=none; b=JMAXjnsRfNOFT0czKKlkUf/2edzyhEBPQeiOcR8upo24bONV7oCJOC6f7kkpSO8MUcHhn0vjXOO/Wp18P/5bJai3dJbpaqBZ8kk03PvF1ErrpJ5fk2ckgAx7i0NOqObW7BDG1SbiRCgBK2nlWrN33cjSX5i4bFBEZQnTHqmtH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063241; c=relaxed/simple;
	bh=rQujSO9fsewGIIno0eCJSdoALenS078IInmx5rvFJsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IK4RtDc9AXE2QrEqb1o8U6LYKhSCiHETFDyQSgdHMcJ76PhdZbAnvX3DOurT/ydVawE5mW6LRXoXWylMscNaEAzfQWZNSugOt7JgBMsKQ3CDfL5p6lfySldYXv3QtBXOLWGKyK+oxdbSEBciv0Pawllx+dVwLdhWPx1dq4/dXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gvkq3QO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5F0C4CEE7;
	Sat, 19 Apr 2025 11:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063241;
	bh=rQujSO9fsewGIIno0eCJSdoALenS078IInmx5rvFJsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gvkq3QO94JEvKVELtS9a3Tz8ysl5g56ro1Allu+GFIWw3bPHPvTVYvNmhZr93DmqJ
	 pltZ3sXAFUFnp3EQHSpHHl+jWFT3lgwqBJz4qeR0G6h4iSUb6Rz7FAsJeNFWEsrGde
	 wkyFwB6enVAOECwZEA/05lWKURWsQGd2/4MUcdVBnAU6uOylWvc4AH+dws6DRzc64g
	 6xTHfZa503iOcfjB8oXhmyvS73tEB3VT+8i+acFKCH/u4QV9u6b5muCrB6pLA0Bm0o
	 G8DErdg4k44+FEW4fyh8T0NKs0EKH9WqIDj7orWooqovgr/3mLAQzljgW/oxrq7CkV
	 Dmkcqvu7VwjCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
Date: Sat, 19 Apr 2025 07:47:19 -0400
Message-Id: <20250418161311-016e1ce41e30dc16@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418124410.2045902-1-hayashi.kunihiko@socionext.com>
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

Note: The patch differs from the upstream commit:
---
1:  baaef0a274cfb < -:  ------------- misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
-:  ------------- > 1:  db0f8f428d081 misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

