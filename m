Return-Path: <stable+bounces-132154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B796A848F9
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52F59C1804
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3741EA7FE;
	Thu, 10 Apr 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbtnKnC3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE51EB5D8
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300444; cv=none; b=rGpI2n6nLAxDmNPG3Qa00oIGKeOCvqGmMZeisIlnnUfh5tveAZluWEiJ4rGkE/r7v9w++Ycq/dpzt916OJ8ySFBQXyy6XcAEw7u4A27votbCqVeMm/JSxrAeszu+R4IPb/uKDWX4ecIkXyqD24Cia9t3PydNfT6YPo1Yr2dVS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300444; c=relaxed/simple;
	bh=ag9QnD72orjIeCsmz5G6J/yk/cReI+Ejxc1pHwWcbkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLJ7NIZSMOSa4tSu5nA1WML9P1lHi/Bhv8pcSW8PzXcKrM/axNDljsQuOFoS5Z/23B/qHF4ldFbXmYobhZTHPagxAHIc7ARCwn/Ua3YawvVeIjrl+nxBzU6khuMjavfqftkIecdaPgSeMUhIFT28S4kjA+kTpcwiPBkFiQS7KSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbtnKnC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7C4C4CEE8;
	Thu, 10 Apr 2025 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300444;
	bh=ag9QnD72orjIeCsmz5G6J/yk/cReI+Ejxc1pHwWcbkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YbtnKnC3L7nWMz9mdbCkohL1LL5IKouFtpTM0BrieMobEdef5A100fm4+eChcqFid
	 H9JeTRe4HZ3D09ddesT7AEeMpjLT5sNEO5V7xO+mf+nAdfhAtoTJpHOlsWGRALoPJE
	 nqtDZwSgq8YXQqePGQMpDwiv/+cITeOfiiiTJB5h5aIPzg9FtEM7aeuR1rDAR3IG43
	 DlXDCayFYeP6737ESJPo2BvunBecbFYwlFRAqhkGHDpetndOWrw1cWSgbiIqGoB/aW
	 VgpRL6Pfu4xCQK8o6dyfunxe6rLQb3V/WmbVT4Z3R0pZG4Y3tAYZzPx00r9dvlxboz
	 Mqo5hNi52JAwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y 5/7] arm64/sysreg: Add register fields for HFGRTR2_EL2
Date: Thu, 10 Apr 2025 11:54:02 -0400
Message-Id: <20250410102358-8e1265af557775a8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408095606.1219230-6-anshuman.khandual@arm.com>
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
ℹ️ This is part 5/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 59236089ad5243377b6905d78e39ba4183dc35f5

Note: The patch differs from the upstream commit:
---
1:  59236089ad524 ! 1:  09f69022df87c arm64/sysreg: Add register fields for HFGRTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-6-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit 59236089ad5243377b6905d78e39ba4183dc35f5]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	nPMIAR_EL1
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

