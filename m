Return-Path: <stable+bounces-132793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE05A8AA46
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4878C3BB021
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AD825744B;
	Tue, 15 Apr 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw0WeO2k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAE253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753409; cv=none; b=gseBPFTyL5PSoiukCM5GXBoxZFKseHFlUsmH9bYSFPHtr0fijIulEXRGicxdiyh5003S1PxXko6CrOvrvnBXjbprHTPJn/6j65lAsU0a4NgSosnWaTccL5u13dywAA9c5KYCIFLM1ZJc/w5CVRBx4e19LFEL3Bxx7eLIbZDPZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753409; c=relaxed/simple;
	bh=XTZStcKuQksabTLVxMPcQrzoP8uLxFsdTdrd335zFq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uinkv+TkcSKRtuaGCRkXjeasg+tZ8/uq2eJNhz3rrStVTdlt+udx6Hhwguec+pF1UL1KvYTnMe2sc5vVwcqDWrwWnRkHRhq3eN0Ju4FLhDJXYyP54eXFaJg0TTHkvEz/EfFOhcz6R+lPMga7GKF2O/4oiEUnWSi+IQBu2jfHsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw0WeO2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7D0C4CEE7;
	Tue, 15 Apr 2025 21:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753409;
	bh=XTZStcKuQksabTLVxMPcQrzoP8uLxFsdTdrd335zFq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zw0WeO2kkZwv4ps5l2y1ERyrRnI9M5D+G9jEEnTc5oNXSbMIY/lQBNkgwIT0u3qdy
	 aOR4rr3CRyqSKb/Xz7QTiPBtHAdnUSX0RinEMYBh1Eecm6qI6/mW+9iG7O4K7z1fpO
	 gz4olkzi9KeOd2cqw52VaJLi6q87of+NwUpomoxLt96omYzfznxdJFC6rJUEsUV8rh
	 cdluaVZIl3jfomE/7IlEWmrm43Qm6sOXDYinMekMMci7BdF5d8ycOItlVgKilqqm3f
	 nFfAf9cOGujkOf3C2rD115zVU9rWFr7Rm8v4EwCN4M/wNK1qdSmnrqULMrlUZBtsSr
	 /8K2/LQMASLKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.12.y 6/7] arm64/sysreg: Add register fields for HFGWTR2_EL2
Date: Tue, 15 Apr 2025 17:43:27 -0400
Message-Id: <20250415121723-d974e1b4f1301fc7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415045728.2248935-7-anshuman.khandual@arm.com>
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

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ea37be0773f04 ! 1:  9a57f7e41a048 arm64/sysreg: Add register fields for HFGWTR2_EL2
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
| stable/linux-6.13.y       |  Success    |  Success   |

