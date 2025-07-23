Return-Path: <stable+bounces-164374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83853B0E99F
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8806C68B3
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60F1DFE0B;
	Wed, 23 Jul 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPnVgbTs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E262AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245241; cv=none; b=qJs4GMxx/MqNUMMQHh+L5/+/h4R6ndQTlMBr4XaXg0IcKpy1cEKEx8X1k4yq8m3EmrVZiGucyJcfTlrxCqmfKFf/lcva08HOyQvd+bdOjVqKXYRbXO2nmmiTCoMHs13Oin6BiAvXW304J9ntZ5AMxG2LhOn1kT7WRKzC6sV2ZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245241; c=relaxed/simple;
	bh=7OqRAmFVC+xx7UUGDh3wLQi94PsSSnx4iVsWhuOl7Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Si5c0frsbIHm0XmAAYmX3hAweRJiCqN8SUxATZCi+vvGClc62sfv3Su/i853JdZFtzUSp/ibebor9WE1FIZjgBI26T44783VBrhxcmR2+HMYkt/3vn+upWIaALOaVC8vzc0FIIbvgr3dQ0XCZrUP5VwjUR9ZdTlctkAklAPyIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPnVgbTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1702AC4CEE7;
	Wed, 23 Jul 2025 04:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245240;
	bh=7OqRAmFVC+xx7UUGDh3wLQi94PsSSnx4iVsWhuOl7Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RPnVgbTsLrNmbWNYBc3GESsMwOUVyiDjyxBuZOQVlUApO9vSyrupLeUP60DojFvEA
	 6kHz0lzJhFv+x6SPI6xPawsSpBT60jaVU9YKiCCOrBsZokAn758SUmBSn7cWsW3Kyn
	 EyvKDO9dn2ppgS22OxtKdXdqxozHjb81Xwic2h/SBXJU2prp1P4Z9xfXbYZ+gk5ydD
	 9aKekbyfsGgA3Ke/qIkMVTPrzfHKyfg9/pYillPs3CPI/qtO/+S+CMc4YGY2Sg7ryG
	 ZbwAwHYm53lCv8xrLhnkg4gjizhvZQCgWB5N/vW+CsQ3hVqiYiEutsTLVJExDHlVXe
	 FKynNj+4ktHQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	siddhi.katage@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/4] x86: Fix get_wchan() to support the ORC unwinder
Date: Wed, 23 Jul 2025 00:33:58 -0400
Message-Id: <1753233242-65cf59f4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722062642.309842-2-siddhi.katage@oracle.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: bc9bbb81730ea667c31c5b284f95ee312bab466f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddhi Katage <siddhi.katage@oracle.com>
Commit author: Qi Zheng <zhengqi.arch@bytedance.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Found fixes commits:
5d1ceb3969b6 x86: Fix __get_wchan() for !STACKTRACE

Note: The patch differs from the upstream commit:
---
1:  bc9bbb81730e ! 1:  1f7a2f87bdde x86: Fix get_wchan() to support the ORC unwinder
    @@ Metadata
      ## Commit message ##
         x86: Fix get_wchan() to support the ORC unwinder
     
    +    [ Upstream commit bc9bbb81730ea667c31c5b284f95ee312bab466f ]
    +
         Currently, the kernel CONFIG_UNWINDER_ORC option is enabled by default
         on x86, but the implementation of get_wchan() is still based on the frame
         pointer unwinder, so the /proc/<pid>/wchan usually returned 0 regardless
    @@ Commit message
         Signed-off-by: Kees Cook <keescook@chromium.org>
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Link: https://lkml.kernel.org/r/20211008111626.271115116@infradead.org
    +    Signed-off-by: Siddhi Katage <siddhi.katage@oracle.com>
     
      ## arch/x86/kernel/process.c ##
     @@ arch/x86/kernel/process.c: unsigned long arch_randomize_brk(struct mm_struct *mm)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

