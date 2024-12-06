Return-Path: <stable+bounces-99975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A9D9E76CC
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AEA282601
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D51F3D49;
	Fri,  6 Dec 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFg1EV7G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2F206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505115; cv=none; b=QMUR2rPIw7UBjDKDfSxTVdCrmCiD4nCHnbL9cdyzOpv2AhRK2ej7CgZcNNIrGBRj6OWOZ7pwacb9E0UGpMRnRWP1uwhrtZvdYbM81RB73xiCp5Uqqg2vUvDsGuVsHQ4TFUj7ilYpwT5UYtiEgMINoNeHjQWSyqIyYbWyWJM7q+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505115; c=relaxed/simple;
	bh=btdFux1m7+JaEgIMiz9NbrFcXjCVPuQxNOckkgY3C+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIFvV+aMEpfaYJs+r9suwgPlmqS63C7Reg52G7/bjUkhyKs6fiHRKLI8VgZWlVYkOOinMuQeVYLRcY1VoALo8FBa0KwCr+G3uwTNRx6yWHRhiLWx0WQI4tYtnqIGLHnCzQGOfjqBov5/CU9BlUvHIbJnIMao48HRPnfKoFGjMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFg1EV7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB00C4CED1;
	Fri,  6 Dec 2024 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505114;
	bh=btdFux1m7+JaEgIMiz9NbrFcXjCVPuQxNOckkgY3C+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFg1EV7Gsf+wDzZeIVI6L42wygAaTxAoBoslaPXnTPLH3nWaAh/wZMgWDVEVaKQ7S
	 2IiWf72s4mImyV7TZI7SCkiM2mHcztWNiTm+XqN9PPQniirag32xThHSghJQa4ktct
	 UByw8MS88YqDf2/tdSYiXNi5JjVJRTr1u6MfzHOuU0L2rn5oAZVrbXbAJk8wmzlgLD
	 KUBQNDF1b8J38i+W1jAG/rr0IW0024iMjsjAiD/DIODBJz97RgXjyIP7QLbjgDQzlT
	 tgJkqWXjD8kaXVLuLYZ9e0JQOsF3lofYw7sARUR8GzPibB9rQeJiICygJJl+Kd8wYb
	 YPgwJiqUFGqGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 2/3] vmlinux: Avoid weak reference to notes section
Date: Fri,  6 Dec 2024 12:11:52 -0500
Message-ID: <20241206110131-c376b642af85a08f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206085810.112341-3-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: 377d9095117c084b835e38c020faf5a78e386f01

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen <chenhuacai@loongson.cn>
Commit author: Ard Biesheuvel <ardb@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  377d9095117c0 ! 1:  c735ac7f41f90 vmlinux: Avoid weak reference to notes section
    @@ Metadata
      ## Commit message ##
         vmlinux: Avoid weak reference to notes section
     
    +    [ Upstream commit 377d9095117c084b835e38c020faf5a78e386f01 ]
    +
         Weak references are references that are permitted to remain unsatisfied
         in the final link. This means they cannot be implemented using place
         relative relocations, resulting in GOT entries when using position
    @@ Commit message
         Acked-by: Arnd Bergmann <arnd@arndb.de>
         Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
         Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## kernel/ksysfs.c ##
     @@ kernel/ksysfs.c: KERNEL_ATTR_RW(rcu_normal);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

