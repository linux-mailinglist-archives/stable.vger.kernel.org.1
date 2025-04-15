Return-Path: <stable+bounces-132782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107C6A8AA3B
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3C23BA72B
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDAD257AD1;
	Tue, 15 Apr 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcj/0UFG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F8253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753388; cv=none; b=ltqHjUMDxtTWY/fL8LCVB+as5LjlYBz+3a1T+93eaFNzfB05iM4SMJWO2MuNcgj6f+LMNPWbztiAxTkWfxBLgDbvUYMac8KvnaAHlKWQdzIc8aEvcTjdyghS0kotdy8782ZUWbIZjcRg4hmDc5ovAea6QZbqIgHSxrAb6+ljVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753388; c=relaxed/simple;
	bh=eN92WWzOGYCl0hCQBDhxeP4+iNDxve8FGT0k6kolasw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UU7uapLaaJW2RYSS5aMKu98F1mtaNJTiSgeDvbACXr/NoBAUUsE1rnctZDAHU/yd9lBGTQju/0pUZLtRrg7gDqEX8eeMZRnYSfRdLqthz8dp2WULwluJMuIL3OPcC6aRIpteNRR98NAupuxTpWU8GvSH9q1exyrhWEd+rRdZHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcj/0UFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B9FC4CEE9;
	Tue, 15 Apr 2025 21:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753387;
	bh=eN92WWzOGYCl0hCQBDhxeP4+iNDxve8FGT0k6kolasw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcj/0UFGxgvmh9/DsXPeTcvqDW8Y/kMqr0bar8Y5SWZ9Cjsl9LpTpKgic3VyxpdPV
	 cOn5OxdHB1dd1ift2HjdJAgXxkzEFnb4OATnvqXxQTkz5tRZS5h7ehoSq69qMIKGCm
	 AF8DnSvCOP2E8Tx93f6zA5wdIrWq63W+KLo9CwyEqtEMtmWzjHaRfo1cv+rNoHyAK4
	 Psc6UY4kxnDdjhZDJXQJm/tT08Qk4OuTwQPJKkDYs7C3dglJtvf5zY2pfDvt6eF6yg
	 pZMH9p4Z6xkDKarrP2FrG3b+lUjj39qSjlzdGdyKmSiZIvHWzTioFBBVCh6LZG7iRo
	 LFhi3lRHt2z7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.12.y 3/7] arm64/sysreg: Add register fields for HDFGWTR2_EL2
Date: Tue, 15 Apr 2025 17:43:05 -0400
Message-Id: <20250415115253-106d034b404f4f6b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415045728.2248935-4-anshuman.khandual@arm.com>
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
ℹ️ This is part 3/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 2f1f62a1257b9d5eb98a8e161ea7d11f1678f7ad

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2f1f62a1257b9 ! 1:  9b69367f213e2 arm64/sysreg: Add register fields for HDFGWTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-4-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit 2f1f62a1257b9d5eb98a8e161ea7d11f1678f7ad)
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	nPMIAR_EL1
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

