Return-Path: <stable+bounces-132792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3CA8AA45
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8853BAFFB
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9C256C60;
	Tue, 15 Apr 2025 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMahjj64"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910ED253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753407; cv=none; b=RDPBsPnd++dsvxqxC84bRAu75e24z72sbW9afxfylm3EcnVCPg4jWjwTuwilSunFVb5VjoZgwwwjVDnYzvQrlAjcDZ/DB/wq7PABywb72kCv8fT4W0TFVMBNAlMdlASLABBjeEsR8rKWsjiPDwlQB6Cx84RXUTL1FtNpWmZCxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753407; c=relaxed/simple;
	bh=pAdSY0tlDa7r60ME7bUMlyhtiTT35yVLlnYeNuIR85s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8XkJZH14D8+XRnRQOOGZq/CzgyfB5MG5R/LJ/2OHhI0SgFKJl12JtjM16Mr7DwlPGn6j2bKoQ4bwMGo9h4HcFPqDl9LcDCepn3iVCPpEfUP3USHGqDpazBrCfRGFZlzi1ylKBFW8nkmLPeL2v/FL7NltM2wSlWNhX7sQxjqchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMahjj64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A5DC4CEE7;
	Tue, 15 Apr 2025 21:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753407;
	bh=pAdSY0tlDa7r60ME7bUMlyhtiTT35yVLlnYeNuIR85s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMahjj64umoQhc7GxMcj6eo8MbBDsnq4a5qyXQjCFf/v7H1QOifStzJ1yvhQU0kVy
	 hJ8QTxyEkOA72V1Lm3A6eeFO/fgZO551ltih8j/d/mMLVfX9t4mjQzDoY5LOYlo6Yf
	 T+lYT4l0Aygh5FO6gxV47+FV94jlWQMDEkuQ7p406sRaORKUxtMOv9PrzY9jw4q7sM
	 l1mlSYZ8nJanB+XsVaLi1ITbwyI1KDYFO26k2VNCTQ7nNuOBxIJAI2AE86D8sLPRqn
	 JLHIeAZriJHGlq237CtFASTucN0UDduKQ5JGD31ZEAjTTbr0t1GGB+x4z2ehGDRRlo
	 h2K18QNv0LWZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.12.y 5/7] arm64/sysreg: Add register fields for HFGRTR2_EL2
Date: Tue, 15 Apr 2025 17:43:25 -0400
Message-Id: <20250415120919-54748213c8f9c252@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415045728.2248935-6-anshuman.khandual@arm.com>
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

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  59236089ad524 ! 1:  ce81967096841 arm64/sysreg: Add register fields for HFGRTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-6-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit 59236089ad5243377b6905d78e39ba4183dc35f5)
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

