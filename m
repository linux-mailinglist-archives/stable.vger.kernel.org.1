Return-Path: <stable+bounces-104488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BEE9F4B55
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159FD16EFBD
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7961F3D35;
	Tue, 17 Dec 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju14hGIV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CFD1F03DE
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440133; cv=none; b=GJy9Pm7GWSusnX97N7uXKRGGesf/fzl3ZIPGfTPF0tVxenYU22p3ZWVi0c/RrG4EBh491oMJ44TuSti+deaZxWVjkX8ILkyiAKwe6BDLUvBob290OCH5udVB/1W4DTAFmdgNqNrGtMrlIK3BBy4amJ5tSpQUmf6XFm90Ky5a1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440133; c=relaxed/simple;
	bh=PUOQCBBKbVKtQ8Uzfz5IluyAAHtoew/A0W5OB43L/k8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DF04GgcxM7qNA/iHQwEgUjd6aA797NN6F2S3m5sW2oBqTWAIlw4O5NmTew2GEtfbfFLqHTRMr1LBxeDFkRDrlXVd7UPKSCn7ZwNk006m2uVaPFgh9XDuvwRzpgNfyCsNEcsq/b50/dRdP5Uu6b8AvKeezFTUB22/VMdQ6zDpUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju14hGIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8024C4CED3;
	Tue, 17 Dec 2024 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734440133;
	bh=PUOQCBBKbVKtQ8Uzfz5IluyAAHtoew/A0W5OB43L/k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ju14hGIVXTrMwouaFJf4fa6V5VpCXChEDmcAsbmf4+7EMbPqYFGsyzi1QCEJoLRti
	 Mu/rkpBNB5QNG3RbCcF3MWsduamySW976KCRkWhehVbxzj6oKqEM3quKOSx+7lHipQ
	 GfQxz8Xf4RAh8zgXceuoAlbO0EM+fk729bplksx/g5VYHYk+Pj4YrWOGnwCOvTunps
	 hN13+D+lE6+6MtDifffWBG3t5OHHy11bITje+2uzvKYE4+pNcjcQjCzIfFLqDy7Uvw
	 /9PyFBPmXlbf7GjzgIZEzdshtnsJDhe8umZ9AfKZLV8iT+RNA5n6EVTg4p1GEaGtTZ
	 s1qWZy/hLWZQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 v3 1/2] selftests/bpf: Add netlink helper library
Date: Tue, 17 Dec 2024 07:55:31 -0500
Message-Id: <20241217072438-893198153346b0af@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217080240.46699-2-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 51f1892b5289f0c09745d3bedb36493555d6d90c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Commit author: Daniel Borkmann <daniel@iogearbox.net>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  51f1892b5289 ! 1:  ca1838c81e75 selftests/bpf: Add netlink helper library
    @@ Metadata
      ## Commit message ##
         selftests/bpf: Add netlink helper library
     
    +    [ Upstream commit 51f1892b5289f0c09745d3bedb36493555d6d90c ]
    +
         Add a minimal netlink helper library for the BPF selftests. This has been
         taken and cut down and cleaned up from iproute2. This covers basics such
         as netdevice creation which we need for BPF selftests / BPF CI given
    @@ Commit message
         Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
         Link: https://lore.kernel.org/r/20231024214904.29825-7-daniel@iogearbox.net
         Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/Makefile ##
     @@ tools/testing/selftests/bpf/Makefile: endef
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

