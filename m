Return-Path: <stable+bounces-106112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266079FC752
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A057C18826D9
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD39F4C9F;
	Thu, 26 Dec 2024 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq52eqzE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3EBEC5
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176106; cv=none; b=OVdAlFTHLyRMx7UScM22IVWvQADRDzXh4xu9sU0JldbU3Nq2TI812y3hE5/KYinK0Jx6su2gUzcakz3ym/6SoK+JxQXjRpWBOTZ5IO3yqgFgy3GgUEANgoYWWW7R+DFCGkY5IK4rTD3hiHPzl3eW531tyPEfkM3ZGlJLyRMWKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176106; c=relaxed/simple;
	bh=noH+ZsL33efsKxtlkW6ViXOhVLU4yLWuCqxXfNgXtS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRQ+V4pzjxB/gzAkM2MAUHG+3OJYIC0HFvfNNE1hSotXbKN4jawX4JUGcD9crRhpph+815EXXuaadrv1byOlsX6huOLRYKVv3nbdTIkaFoCB6wHU+NFps8vkXUPcWOpY7VltTTkyMS1hR3XlzZOyYEEdN4pRUNGoth1yDE5+GVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq52eqzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98023C4CECD;
	Thu, 26 Dec 2024 01:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176106;
	bh=noH+ZsL33efsKxtlkW6ViXOhVLU4yLWuCqxXfNgXtS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bq52eqzEEWF8R4n4GgV7Vd0iNOHi/bSuDziE//PFVejhB2ruHLMhxlDFBn63jhAeX
	 7Tsjzg6MXIdUVrJ7XycWPlxM8GM5qNAUyuWQLfIwMXu7fmD1yR68flyZrBsZDh+uKi
	 UCjAi626XLiUlQvc1q+y9pZ/tzAnRrYfdOGZZLNvzGuxJwoPiW5q5v24nxQUBDFWcJ
	 CU3SpgOo4oUiv3azdVir22jVmWudAIYBAQFy7XTyEOJwKe3w18EHiz6ojwO4JXVZl7
	 p54bmwO04fKZF3s6T6CxgbS7qMwN3Xyrm6IEc89JaTFsamw4iTqAJSNvuZqlDq2mSq
	 9RA1gjPuNOdbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4~6.6] MIPS: Probe toolchain support of -msym32
Date: Wed, 25 Dec 2024 20:21:44 -0500
Message-Id: <20241225181141-941d612a552d1f6d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <183F7B3F0A07AC93+20241224060918.15199-1-wangyuli@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 18ca63a2e23c5e170d2d7552b64b1f5ad019cd9b

WARNING: Author mismatch between patch and upstream commit:
Backport author: WangYuli <wangyuli@uniontech.com>
Commit author: Jiaxun Yang <jiaxun.yang@flygoat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  18ca63a2e23c ! 1:  8e84f3858fcf MIPS: Probe toolchain support of -msym32
    @@ Metadata
      ## Commit message ##
         MIPS: Probe toolchain support of -msym32
     
    +    [ Upstream commit 18ca63a2e23c5e170d2d7552b64b1f5ad019cd9b ]
    +
         msym32 is not supported by LLVM toolchain.
         Workaround by probe toolchain support of msym32 for KBUILD_SYM32
         feature.
    @@ Commit message
         Link: https://github.com/ClangBuiltLinux/linux/issues/1544
         Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
         Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    +    Signed-off-by: WangYuli <wangyuli@uniontech.com>
     
      ## arch/mips/Makefile ##
     @@ arch/mips/Makefile: drivers-$(CONFIG_PCI)		+= arch/mips/pci/
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

