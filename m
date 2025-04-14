Return-Path: <stable+bounces-132433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEF1A87E77
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35204175DB4
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2861828F948;
	Mon, 14 Apr 2025 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHTCKGI5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD005DF42
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628954; cv=none; b=ieHeesqnYnlMea4z8TWMxtR0NGmInrwTwvaNker9ByKH57zqVsqsXA1HbGcyXBbEh720loJwMWqUB5xoaqQT5xGNmnf2F+xmXq1bjsbzTM9d5qV8mlTF7KPc1AQJ4nlK+f2R8AXpPZlNQvkPe+mKnIzGUUQWocHhSfr37K4RikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628954; c=relaxed/simple;
	bh=JQzE0QXvgs9QTPydQ0P0fHqXnPs3sBXZWskdkJVr7yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxXI/ok4wabSSAiIIslHLR5ymvVI2x6pnZ6vnhC31CIZrA5OlHcSziTjuj5f7W5rTp1eJZ/I3H7jUMJKOCkhILc6gf6Nmspe3HPgnMbc/Iy6hCli5zxVmBGDwWOOUegV3EqDty/tjSlQYxRCCMOJ2P9G76W407S9gyP21+oMvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHTCKGI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D14C4CEEC;
	Mon, 14 Apr 2025 11:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628954;
	bh=JQzE0QXvgs9QTPydQ0P0fHqXnPs3sBXZWskdkJVr7yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHTCKGI5PpO4B9YFqUeQ1hEgYRg3zyGYSUxDKQNmoL3QOXeCskqn0/KhCk72B61Ge
	 i9s7UG2e+ybI4hXur+oOE6LlPg2pJeplAYvcP6bMrsUUsOOftJ5b2TqemWb5i27rHo
	 x9AptvyRyegcKpIErkY35qux+RsznGw6aFACTTsDYgPoMtOZWgo4gI2vDU5Tg2wGJ4
	 WX+VEgYJE3iBn8qJR8tD+EFrm+C3cMuafrRDmzi3uehXDfijKF0f/IIptZLXcYh83b
	 fVPZqbphHB9E0kTXJakrM1w8hsxJF1k0A8Oyw/ZkgV4bKtkoxdkfKCs8LeMIn7A5Ax
	 Tte5yE7kr3+bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.14.y 6/7] arm64/sysreg: Add register fields for HFGWTR2_EL2
Date: Mon, 14 Apr 2025 07:09:12 -0400
Message-Id: <20250414070209-ea19bb20797f0eed@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414045848.2112779-7-anshuman.khandual@arm.com>
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
ℹ️ This is part 6/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: ea37be0773f04420515b8db49e50abedbaa97e23

Note: The patch differs from the upstream commit:
---
1:  ea37be0773f04 ! 1:  a4f04ab50798f arm64/sysreg: Add register fields for HFGWTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-7-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit ea37be0773f04420515b8db49e50abedbaa97e23)
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	nERXGSR_EL1
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

