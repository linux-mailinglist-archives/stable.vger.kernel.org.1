Return-Path: <stable+bounces-158575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20466AE85BB
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE416A551D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12793265606;
	Wed, 25 Jun 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXgdan6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F3A25EFB5
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860443; cv=none; b=qvBy2OIZgGxHrQOiv6dqhk1vkRD4HtZo0DMDujUq/MG5HvABXVMM8V4hMpoM01bMyVeqmEr6Sqastrasovn9CZqtimbg5wCNWmyYZ9AQUkh0uJGe3Y5osV0Hn7e3CawVUH59q5P7qlk7lCpl+skYER0QtPKO4Z9QAgGk4OQyDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860443; c=relaxed/simple;
	bh=Va5A/Sw8dCfn21DyNtmvI9BUCD3kI9YbIXDSQkvdEDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ez2jiHnSS5S5saKuIBqcS94pprN5ix06Zd4/3iBzg8hq+gKTcudOGvuzUfJ0b1h6oRhYb3GmoXSsjEtaxhAmTHx4wS+GaGT2blwElUwSMT6rr1wTJJy/1kmhgy7cUV8bW75U6K69zS9ZA/ULaNTNxCAETtzrJ7PP6uK4A3nzWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXgdan6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830E7C4CEEA;
	Wed, 25 Jun 2025 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860443;
	bh=Va5A/Sw8dCfn21DyNtmvI9BUCD3kI9YbIXDSQkvdEDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXgdan6pP2KcjCJmKdUJGAaIuyY9PzrGpHoGeZ0O8F2XgrG3cAc6nm/loKfr0gtga
	 Tq885MAOvO1r2JinsOa3HBvbeV+U2zQaHxl0gytF+qUYz1JcQa6vBYU3848QynYUBg
	 rF6ZYcnEkOOsPzIiegGgHaHkgfG1CzHZW++ECXBThjaMWuzinbA5Zd9YWy8VLAxZAG
	 AxsminTkWhSwqoMQ3Ny7PGvWbi5rKxhMetNV7zw7zFM35gJN9R5Uk5o7gBtCgNiNXa
	 hYrbztwZc7LYuPQES6BTl6rNN9/2VGMMZYayZsCAKM8gO4Qg3lAWouhA0dNr0n1P9M
	 tsP1xb3cPo5ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1.y 2/2] x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
Date: Wed, 25 Jun 2025 10:07:22 -0400
Message-Id: <20250624212637-996f16e3b55b968c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250624165852.7689-3-sergio.collado@gmail.com>
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
6.12.y | Present (different SHA1: ebd352672790)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f710202b2a45a ! 1:  29c4ece87594a x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
    @@ Metadata
      ## Commit message ##
         x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
     
    +    commit f710202b2a45addea3dcdcd862770ecbaf6597ef upstream.
    +
         After commit c104c16073b7 ("Kunit to check the longest symbol length"),
         there is a warning when building with clang because there is now a
         definition of unlikely from compiler.h in tools/include/linux, which
    @@ Commit message
         Signed-off-by: Nathan Chancellor <nathan@kernel.org>
         Signed-off-by: Ingo Molnar <mingo@kernel.org>
         Acked-by: Shuah Khan <skhan@linuxfoundation.org>
    +    Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
         Link: https://lore.kernel.org/r/20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org
     
      ## arch/x86/tools/insn_decoder_test.c ##
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

