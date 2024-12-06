Return-Path: <stable+bounces-99961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEFF9E76BE
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3895F188462E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8701E1A05;
	Fri,  6 Dec 2024 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK8urNtF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179F1F3D49
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505088; cv=none; b=lym38pY5u0QWXhSgGgv9pTAgriIoBotIn23evTqYl9GnmbOlIPxZl+a4mo5DTR5JehU+LSAPOfNGPOqjThV21bYIE3cesk6b0XARo0itNnfZa1JPVDPJUwI/i381hLmDFi89rjaEP/xOLlSsZFA7MPtcWI45p7eaIBlkGW9Q7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505088; c=relaxed/simple;
	bh=8CMmPn0QMxDUxGj5fxFn6XEomuGHDb3VHP2rQiEWiIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzYNLwwWv+PPw+p7jGFUIKUbP8mSyd/56Gkzim7MutazXZ9Ipp9pIFJRktCb3VR93L3RMAm6c9M984gu1wa5ZGLRo8IhGGRh9HS147nNyfchlUeLM5yFfwIekpaQbBXpCtnNkbZgWjANuoEPNPiYc2VZm8CQg2linBwLUHNq2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK8urNtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20C8C4CED1;
	Fri,  6 Dec 2024 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505086;
	bh=8CMmPn0QMxDUxGj5fxFn6XEomuGHDb3VHP2rQiEWiIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rK8urNtF6M6FYYMSfM2kxPtUqE4UCieoRP5GgKogZ8bwNLdCmzpuevPasjs2SoG/D
	 jd6jPhIbSbRUWSyktMMZ+d3tpjEogln9SeQuafDHna2QkuJW7EdUxxcKqlQOSHDpJS
	 w5Td743I5kGFKLkGjmbcItg8achnGTdsE5JMYCmCM4O36k6OS4QDR5JCcEfADQe187
	 /1nB7yPtqiNJqgOS+qpiFIMg51su5QhBkLgb5t89zr/Ljmx2g2KR5jo18QFv5fi8oo
	 0qpVloAUGXVioLgQpwPQWAJRBG/z4wAeZ+ivKf1sqZY+IrQpO+7mfXW3EJfRqm33mY
	 gIWvhDBLouXAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] arm64/sve: Discard stale CPU state when handling SVE traps
Date: Fri,  6 Dec 2024 12:11:24 -0500
Message-ID: <20241206095940-7f452f166e2e0511@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206132206.143543-1-broonie@kernel.org>
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

Found matching upstream commit: 751ecf6afd6568adc98f2a6052315552c0483d18


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 51d11ea0250d)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  751ecf6afd656 ! 1:  b773f808e9357 arm64/sve: Discard stale CPU state when handling SVE traps
    @@ Commit message
         Reviewed-by: Mark Rutland <mark.rutland@arm.com>
         Link: https://lore.kernel.org/r/20241030-arm64-fpsimd-foreign-flush-v1-1-bd7bd66905a2@kernel.org
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [Backported to 6.1 -- broonie]
    +    (cherry picked from commit 751ecf6afd6568adc98f2a6052315552c0483d18)
     
      ## arch/arm64/kernel/fpsimd.c ##
     @@ arch/arm64/kernel/fpsimd.c: static void sve_init_regs(void)
    + 		fpsimd_bind_task_to_cpu();
      	} else {
      		fpsimd_to_sve(current);
    - 		current->thread.fp_type = FP_STATE_SVE;
     +		fpsimd_flush_task_state(current);
      	}
      }
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

