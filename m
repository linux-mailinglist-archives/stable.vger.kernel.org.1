Return-Path: <stable+bounces-132160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44448A84903
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0A79C22AA
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F81EBFEB;
	Thu, 10 Apr 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqf6jdXq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB21EBFE0
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300488; cv=none; b=js5jkME9MMw511toxFcg8vZ4SFWbHKbubN2UK4KOz36t0fFwm3cG5ruM5hasVwo3N0H28mWmEfUEW6NSl4h/yCistVfJrAR0sp24Mb47spFMJCphwgtjOLorZ63RO8B4H3Wi2+H01Y9Eh1RyBM+DrH1/3LFefmesdja83cGo83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300488; c=relaxed/simple;
	bh=kJza1EVctG9rNG8eUGA17sccqhC8uK5l9Tq9Tpgxe3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/HtTBhAenLDd4qOpZickMSLDe2fT7hINScctbUqK2BB2JO1WyXdvjozv8wAnHOfRznGo0H0W8/J3FmjtLKf3Iuwp5oz05Gx5AQteJEzjES8pxQNek5lYoa58mQ65Vrl5ciBl0ieYNmiPOiiU3e90Je3mYNj4lmIVRDJpkm8ErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqf6jdXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D35C4CEDD;
	Thu, 10 Apr 2025 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300488;
	bh=kJza1EVctG9rNG8eUGA17sccqhC8uK5l9Tq9Tpgxe3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zqf6jdXqo3mMMZPbnPTpawrZmEI0BiX+5o/JW1nn+Ni5EQihsmdqZj4+1ZR4qkBzy
	 TPfiFyiElbyYX5K3imzMWvQ8Hrc9nEdpI16SWIAi1meGgnkmQl95ujmfpncfOlDYRL
	 2z1G9u2F7Hdv8jZV9hnKXzkwvOPqc/aaZ3wQqQffGt3EhmP4OZCkOiiv/nS2sA4awg
	 3iffjH120AIyAHCuhCKzIgfvrouh8KUrdAhmapoZAzbpMUHQMGv/9xEEoWqDA1Soht
	 UprqdUmjUyuVwreTdgJ1DurcI5r440q0bTbB9wwdpfBZt2R30G3kEmUZws9sFKh4nU
	 mlr1eCjyTow8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y 4/7] arm64/sysreg: Add register fields for HFGITR2_EL2
Date: Thu, 10 Apr 2025 11:54:46 -0400
Message-Id: <20250410084507-c912214a86d2fe9d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408093859.1205615-5-anshuman.khandual@arm.com>
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
ℹ️ This is part 4/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 9401476f17747586a8bfb29abfdf5ade7a8bceef

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9401476f17747 ! 1:  890c5150d605f arm64/sysreg: Add register fields for HFGITR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-5-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit 9401476f17747586a8bfb29abfdf5ade7a8bceef]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	AMEVCNTR00_EL0
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

