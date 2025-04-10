Return-Path: <stable+bounces-132158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE68A84915
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 18:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635404674BA
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B10C1EB1B9;
	Thu, 10 Apr 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN+IYya1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA01E9B2F
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300485; cv=none; b=QPJ7yuaJLcdW4oEh2Dif5m2Nnpt1eFiBfVRI4B/xwNhZuomCG7wkOy5RNq/BWYdDYyeJ+HVnWMupW7HxRy3/zZNYPB05LkatP2Wa9msJ1x8tLN6Nv5E4rRklopHXPZu0OjLabGZNJKsy/NiAne1azdbgHAIcInvCz5v5UTvW9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300485; c=relaxed/simple;
	bh=alD8iwRiulZV2p4ufUhr8XY0+hplyzfzsJc8S2L/vaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCVMjOZVKNQGgQS8S6jjYXs3U59IwNAZMow5PRlf2SYVMmR1rk6XQgsE8S6gkjMLpTJw5Z63W+hGx5b6XL4RXBz4Ld5sr4lyMuGekK+0MXvzdMrLJQoqYloGMCF54u6TEIT26MFB373BQ9OWLOJXBCtyBO2cTUEqhL68K3uICn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN+IYya1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E53C4CEDD;
	Thu, 10 Apr 2025 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300485;
	bh=alD8iwRiulZV2p4ufUhr8XY0+hplyzfzsJc8S2L/vaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VN+IYya16H7Zep+Pq3g97GEQKlNKdiWcMqCvK24RhjL4kJsK+L5lWyE744l7IpS40
	 DyKRZHcd9hGjSQQH0GUjQDa6vbz3+qARNGK7Tna563bfPx7EpsH76pVn4EjYxsdtVK
	 7RZPk13iDZ5iVpIg/scvO1kJ7RriYbYsoDxuQaPIeZNIK7X35lgCjQWhO1e10ocd9Z
	 uhWTqKPCRs7GjWsvDdGXW99aNSpjsz5lorIwIyAoSj/bLFFgmOQKO7z/SVdAcUT+cY
	 xR0EDVSfkQyl0TY5OFK51c64BflmLtDecl9sNBssr5tA8ksNVzRl/6ohucXoBgsKHs
	 +Bpi8L2tHFVLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y 1/7] arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
Date: Thu, 10 Apr 2025 11:54:43 -0400
Message-Id: <20250410082017-e20108903eaf0284@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408093859.1205615-2-anshuman.khandual@arm.com>
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

Found matching upstream commit: cc15f548cc77574bcd68425ae01a796659bd3705

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  cc15f548cc775 ! 1:  0ac931bb8341b arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-2-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit cc15f548cc77574bcd68425ae01a796659bd3705]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: EndEnum
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

