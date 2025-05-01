Return-Path: <stable+bounces-139376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E04AA638B
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318AF1BA8593
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A198224AEF;
	Thu,  1 May 2025 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6h+lkU2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4939F215191
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126629; cv=none; b=jMvBevIL9EX9BAjR8I/HvdhAlw2lrcwjyl1Ogeh71/YQqTrrNNG3MajYBi/Z6eSF3bZHY/Ls15qgvY+eUgdRsAvyjHCPaL7Phql/XRvNPqSFZrJc22T94VpISe8bZDqhGzlpxVQz9D0Ohzw3H8zT7cG4++0/rneFsPsM9zykLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126629; c=relaxed/simple;
	bh=I1pwBqG5JCD8K3LDVzY5AIqQtoaEyb0CxcDbEhh52Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4hqAJF+nUgNFW5MnV3giug8hneWb08e9yNR/Dy01g5mx2SO2qj26bk4cdVKy/JP7V8u7i2Me4xH4So5s73VCT0pEY+Oky8zrcxDqN7to/yITVRczyGU1PJD2qT9dlJ58NRGZj+gDRgquhWiDDgfS/aDzjc576EL3vxnaSNATpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6h+lkU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2881C4CEE3;
	Thu,  1 May 2025 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126628;
	bh=I1pwBqG5JCD8K3LDVzY5AIqQtoaEyb0CxcDbEhh52Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6h+lkU2CDqnhHwpfZ3gibzOqLkToUd1n221WAueeN8gSwCZ1UOammEPK0xqQXnsX
	 6eR3gjeMYqKH2Jv3wHK0yj5tJYPfx/MI9Vhb8BOobm4A4EaBTtgNlRheku+jE5Hn0y
	 uigSp0rUmH6f9hZDe9MBMjvZx4nlKSnpkemh64qQ7Cz0C2dKaUC32lMDNg3jb6v9QN
	 3XAHGmJv/Hd3Dw+eY+tmwcDV3USUx9kfz6LsRaUNMVrtvP/qcfu1SQIt2nCZHGVrvN
	 dXKDZT7dC6XRaZb1zG2QrhVqecbdy/SCEXhAiWSf5Xa5uWeuSYBvCv6ZCQIJSvNAj/
	 5DCt4i+NxIFoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 08/10] selftests/bpf: validate that tail call invalidates packet pointers
Date: Thu,  1 May 2025 15:10:24 -0400
Message-Id: <20250501091311-2a299d8d950461a4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430081955.49927-9-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: d9706b56e13b7916461ca6b4b731e169ed44ed09

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 1062b7612cbd)

Note: The patch differs from the upstream commit:
---
1:  d9706b56e13b7 < -:  ------------- selftests/bpf: validate that tail call invalidates packet pointers
-:  ------------- > 1:  23ec0b4057294 Linux 6.6.88
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

