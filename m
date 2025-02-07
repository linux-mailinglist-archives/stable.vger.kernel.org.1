Return-Path: <stable+bounces-114325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE47A2D0F5
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD6316D64B
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0581BD03F;
	Fri,  7 Feb 2025 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIYQoMs5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9881AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968658; cv=none; b=ZtT5d7j6Te0oa79U/VJ5Ayfd/C9x8NhxoainqGfg3hmuoEzGthepUd3LmnXE8YLjz6pljNtzEf7Tar55yxEYIRV568ybQwuOtZgvOW6mnf9SoFx1k2JjsoGFV54/Z6OHm9OFUjxsxuXp18hNiD11lImny43nrrgKcWGWpZlfnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968658; c=relaxed/simple;
	bh=m/HX2icXwVCPJMJ0TFrOEXohe8q+ADyJsM2kI1lqahs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtZ8r7CNgGLkvkgttA2LEZwBgA8dE0dB50sG0oQia/Zu89qtL28NtyrxKwKNSWRYNbzc0ppASoS3nAWcL3WL8DNcGEjaHKxaZ2WJwJO87eg4Enj9Qz33eGEYZW7SYncLhGV40NmnQPtO4STJT2oj6COW8rZoHXhngJbtSya89tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIYQoMs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CCCC4CED1;
	Fri,  7 Feb 2025 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968658;
	bh=m/HX2icXwVCPJMJ0TFrOEXohe8q+ADyJsM2kI1lqahs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIYQoMs5LLo0UOImmzNhihHyrJqQMBpzzRwvvDU/No7TKbB4zgzjf6bBLuiWER6ff
	 2bTOO0xcawIShlmT/gRw7pDS/Wcj8CuumG/QIyMsMu2xnyleKYNPlk/Fl59NEDeinC
	 rWYbD3F+nlU3lHfKF4V3aTkdQW7KU53JxVKvmwbnkDNR3Rnzsop38cPa/Bb0EvkdN2
	 7Zf2ncJCGf53+40jfwv25fC8Wb5JYDRKtjWal2iR8Uc7NbzNdaRqx1eUtGRrvVCmhC
	 OM8Zkah1euZnReRLTTgeMkdlkKsvEjV3C7u6XklWBAmsZ0arW7QdUlYop+as2vqd+2
	 Dtq+8kx87gimA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 1/3] kallsyms: Avoid weak references for kallsyms symbols
Date: Fri,  7 Feb 2025 17:50:56 -0500
Message-Id: <20250207165807-194d564469854d1c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241206085810.112341-2-chenhuacai@loongson.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 951bcae6c5a0bfaa55b27c5f16178=
204988f0379

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Ard Biesheuvel<ardb@kernel.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  951bcae6c5a0b ! 1:  d6ccfcaa675df kallsyms: Avoid weak references for k=
allsyms symbols
    @@ Metadata
      ## Commit message ##
         kallsyms: Avoid weak references for kallsyms symbols
=20=20=20=20=20
    +    [ Upstream commit 951bcae6c5a0bfaa55b27c5f16178204988f0379 ]
    +
         kallsyms is a directory of all the symbols in the vmlinux binary, =
and so
         creating it is somewhat of a chicken-and-egg problem, as its non-z=
ero
         size affects the layout of the binary, and therefore the values of=
 the
    @@ Commit message
         Link: https://lkml.kernel.org/r/20230504174320.3930345-1-ardb%40ke=
rnel.org
         Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
         Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
=20=20=20=20=20
      ## include/asm-generic/vmlinux.lds.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-6.1.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

