Return-Path: <stable+bounces-155280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF0BAE339D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 04:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA537A165A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 02:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B209618C933;
	Mon, 23 Jun 2025 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix1C1J+8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002C171A1
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646015; cv=none; b=qLpufOae2s3hma3UNpNw+3AcqQodS5P/A5Y8Q16HzK2SV6cZCAaCbh3K6kmvv/kORIiJDxEnb1QZgzXXD/2ftqdy2C5+xPJr+0p3xpL6yxjeugaGUaHfL9HknhI8ZV0V28/NUFSwq8tCTtacufwBjneVPk/CIvyGofWpJ0fOwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646015; c=relaxed/simple;
	bh=hLNXBbPn4ZWjE1hJa/5VF2HxnltNsof0jZFkiBH0RiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZFF79r06MaKXsSGF4J7h9gmZqRI7ML0pM/hSsmHZRrjBcE6ehm+t2OaVQMC6zOXhe4ZzliJNhD7lU7L4Pq57RZNOhByGd5PJRSFF7a9nSMyoCibQWntoAbYjruyl0wPiPTTvqP3PpCpEIqqvq8+Ite+K+5IOvIgi+sjxTxmzII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix1C1J+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAF1C4CEE3;
	Mon, 23 Jun 2025 02:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750646014;
	bh=hLNXBbPn4ZWjE1hJa/5VF2HxnltNsof0jZFkiBH0RiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ix1C1J+8KNhBTv0X3w3chOFJTEmCz/Dl3EEyKQW79PKWCuJqjzU/nCE6EG9aXvMrq
	 q+pQDjHFDa9Nn6JD+u5W2rLL2CXF9BVrU58/4dJXWF7pDQZczh3c5g0Ezs6QRriBJo
	 473X9nR7v0wRDfaArGpksGbxVMEykP1YVihZYOWHID5sEj0mmEd3ghByuY4nj21lUP
	 o8O0WpVvE/5JmPrGdC+C/fEZz+gTNW28ui3+gB5P/h9SwiVPqKkBoEu4QcLjWyLniE
	 qxiVbJpk/O6jDHnoLd6QJ1c1A+KREcC5GtmTO4CrNdb4MJd7vNbQTaOHorWCUUoMxr
	 awGnfMRv1soFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
Date: Sun, 22 Jun 2025 22:33:33 -0400
Message-Id: <20250622214641-1b1bab51005f15ab@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250622160008.22195-3-sergio.collado@gmail.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: f710202b2a45addea3dcdcd862770ecbaf6597ef

WARNING: Author mismatch between patch and upstream commit:
Backport author: <sergio.collado@gmail.com>
Commit author: Nathan Chancellor<nathan@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 9614c82c0ba2)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f710202b2a45a ! 1:  ffa5674e5ea27 x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
    @@ Metadata
      ## Commit message ##
         x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
     
    +    commit f710202b2a45addea3dcdcd862770ecbaf6597ef upstream.
    +
         After commit c104c16073b7 ("Kunit to check the longest symbol length"),
         there is a warning when building with clang because there is now a
         definition of unlikely from compiler.h in tools/include/linux, which
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

