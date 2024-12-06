Return-Path: <stable+bounces-99968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F189E76C5
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEFB1884AE5
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1691F8AF0;
	Fri,  6 Dec 2024 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/9/UNBn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF0206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505101; cv=none; b=OGowUmojh7mAzKB9M89U9FEQy+PKeZsMAoXrhNvU4YzIJkgIJWvtscTMRx5T8hXP73cZ+/i6p2mJkuA3jqocTIJKrJWTOg46s70419/p+7SlvDaWNyXluWI+2nsxjzw2UsIInsjBJp3a/U3RRT83ljfpq0WU9IaaNTSzdf2vY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505101; c=relaxed/simple;
	bh=xRQIpKrsbHk+17kYS4n2XiQOoQVG+8EioOrXnej9Pp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njP0SxII8egPmAAEsHy64WFAamJ6oj+Hja2/1kjv+SbyObZnXMF/fJf6aeU55k++5kgMLYwP6/zl/+NhYhR1M1V82sywDDnmXrbNPVVNeGJwVUX8ORU+nfhb9+20e5N6j05r7dUD0t+x4dHR6l25sJcPyvASIzoItFc2sHT9nxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/9/UNBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508B8C4CED1;
	Fri,  6 Dec 2024 17:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505100;
	bh=xRQIpKrsbHk+17kYS4n2XiQOoQVG+8EioOrXnej9Pp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/9/UNBnMyf03URQ+0KBpsTRexdV3P+Z0bnrWRBUz/gDS+M8iHPSssg5sjbIuhOzh
	 J+ezLtoK3XTFe9wUp25BABm56Dgi5RmyUZemeKGUJ4CoXXYPy80Hkc1GZdXUy+ikFO
	 sTIjVt+2B6lQdouAKqG8clOdwZVkyt0OoNvCexkSYeMhLY4iHR7XIyZLq5YVgKyXUL
	 8TOK9o7PTEZ/2eH6J7DAaDv8LSohsp+n/oEF9Smi/0Hu7HJQOUxoLkUgoqVt2iV3EC
	 9Hdu0g2MhRwfqDiVh/sLz3Qhjm2l+lRufJdffOvVYgWxidWgdtjuIBSW56EpZ8eX6f
	 7xhl1ZwvQuzsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 1/3] kallsyms: Avoid weak references for kallsyms symbols
Date: Fri,  6 Dec 2024 12:11:39 -0500
Message-ID: <20241206105349-968b761dce01d584@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206085810.112341-2-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: 951bcae6c5a0bfaa55b27c5f16178204988f0379

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen <chenhuacai@loongson.cn>
Commit author: Ard Biesheuvel <ardb@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  951bcae6c5a0b ! 1:  a89be9ce6914a kallsyms: Avoid weak references for kallsyms symbols
    @@ Metadata
      ## Commit message ##
         kallsyms: Avoid weak references for kallsyms symbols
     
    +    [ Upstream commit 951bcae6c5a0bfaa55b27c5f16178204988f0379 ]
    +
         kallsyms is a directory of all the symbols in the vmlinux binary, and so
         creating it is somewhat of a chicken-and-egg problem, as its non-zero
         size affects the layout of the binary, and therefore the values of the
    @@ Commit message
         Link: https://lkml.kernel.org/r/20230504174320.3930345-1-ardb%40kernel.org
         Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
         Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## include/asm-generic/vmlinux.lds.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

