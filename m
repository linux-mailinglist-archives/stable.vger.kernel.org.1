Return-Path: <stable+bounces-126032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0956DA6F44A
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6BF16B383
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826A0255E4E;
	Tue, 25 Mar 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jow2AcZi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB7BA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902445; cv=none; b=ptZdGHfC5Wh7PGoyty5VTEVQCFBfUIIgDkCNpjh97vhOF0TmA8IeO4a7JS8nasYQpSjnLB1hG1Dq96ioghS1tCeqJsmik6kQnKQb213uO8uurnfc4R9Wx4tSBmcoqbROmKC7+givdWb3k9tC96vTufL6jVoTS1Zylk/xhNWV30Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902445; c=relaxed/simple;
	bh=bGpmSQqlI60wcwSDlp68dJk5D2MjCQnHpMKtf19gHM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jP43vYJIibAPnAi4fYRPUc0XsR5CIZTP8BMdOoPc+1kh4tlWKAJ1C1/zomrtAR0JX/yP77D3r17lTLpl6sk1nACVcYPVF7KtJc0mim8QXOaHHzRad9vD3Oa/SSZDdVMXaP6cVWMG/mPH29NCP/SglMeoU1yyYJZeiFiLz+opq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jow2AcZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC05CC4CEE4;
	Tue, 25 Mar 2025 11:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902445;
	bh=bGpmSQqlI60wcwSDlp68dJk5D2MjCQnHpMKtf19gHM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jow2AcZi6N7nKuUqgvskc3Hzaqhp/1D1O/HEP8tn2pmDxeXf69XYHI1YifRR4tGIn
	 KLULRFlSoanU6XnfPL3moA5kgxpDynA6ahbfeOmLwxUGGufrm6guHJpdYrNmcT4pAk
	 iNLY4kgTO2ZJSiHKYwycsJtISF3wTMtZUZPI3GzVVaMDypAxAs5wUV4Ae4hafUK4io
	 o64gnB6+PDVgZMI/Xw1u25w5M90wF/54g8FGD6QCIvh0mvC3A1wHNDdyX8ugezsw87
	 SJcYJb4/vyDOncgEH/WGgru13NPU+BZ0tBcdPzJDP3e1TExTQZ13C46JnQSayN7Pn0
	 SXXOfGSNKAqkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] libsubcmd: Silence compiler warning
Date: Tue, 25 Mar 2025 07:34:03 -0400
Message-Id: <20250324211143-20c5597cf447387f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324062003.1203741-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 7a4ffec9fd54ea27395e24dff726dbf58e2fe06b

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Eder Zulian<ezulian@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  7a4ffec9fd54e ! 1:  eada5c1cb53ec libsubcmd: Silence compiler warning
    @@ Metadata
      ## Commit message ##
         libsubcmd: Silence compiler warning
     
    +    [ Upstream commit 7a4ffec9fd54ea27395e24dff726dbf58e2fe06b ]
    +
         Initialize the pointer 'o' in options__order to NULL to prevent a
         compiler warning/error which is observed when compiling with the '-Og'
         option, but is not emitted by the compiler with the current default
    @@ Commit message
         Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
         Acked-by: Jiri Olsa <jolsa@kernel.org>
         Link: https://lore.kernel.org/bpf/20241022172329.3871958-4-ezulian@redhat.com
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## tools/lib/subcmd/parse-options.c ##
     @@ tools/lib/subcmd/parse-options.c: static int option__cmp(const void *va, const void *vb)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

