Return-Path: <stable+bounces-158583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42C6AE85A5
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5554416084D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AF4266B6B;
	Wed, 25 Jun 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5ApZtSG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B7266582
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860452; cv=none; b=Ms9vucJ1YOtagLyc4PFzCYntJa/ch987qpndmOJ0bft+gMtfqGcvhvqgqLRhRUnXYpCObuKGqFBnV+wWfAr2VZ3vPNjL0YcVfWSHYyDGpKILupwQZCfZs7fhx+ElcJVMw2y8Mp/p5g++6NwnmMb66qQgPT3RF/i6nFhbAmFND2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860452; c=relaxed/simple;
	bh=dITUW7eB3ntUL0yUO3cNW2rx2j0ifp10Lt3p86i77a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4kEwl59dVsb7yaop4Kvk2R2G9HQBlAR7j5/kCsAwynoXqoPD6tZ8lEbb8TimxvRn/gklTP3J43UGg0oVgoGhY002FZbrS/wMHOnCcNWV6VFqq80YNx4Olce3CRTrYNp8H7/N131i7+x8+45hswaLNtGPAI0cfa9rkWKw4sNUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5ApZtSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6024BC4CEEA;
	Wed, 25 Jun 2025 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860452;
	bh=dITUW7eB3ntUL0yUO3cNW2rx2j0ifp10Lt3p86i77a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5ApZtSG62f1hoC2EvHf3Rejya0Jkb+ODLON29PQwTEI3LdYsqwSe+MoYT7aYASMW
	 4gCO2s5cj8/6GR5YdgNrzn0pwT2zRZlNf4SCfUK87TgIBt9ZwoXjeiEVIAU3PqHl9R
	 OA4pL69nxca2lc456K5BgjGOogvpiS2Bm7rfpjAAcTDWXViF6gc3zD0FenYaJ+ejTM
	 eVO3jQ5BGZh2xWduba39aJFnHcr03W2LpK0OXnAXzRh1VodZHfNLn6MBPG+ibPc/ti
	 pjupXh8WHj2nGYJPulSX3XwxwZlInjcbQtZc48OzyxPfH2/YKvnj6pVkRoyr/pmoy7
	 wK8dDId1ZqvrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 5.4 and 5.10] ACPI: PAD: fix crash in exit_round_robin()
Date: Wed, 25 Jun 2025 10:07:31 -0400
Message-Id: <20250625011139-5a9918c16a0da499@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <1750809374-29306-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
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

The upstream commit SHA1 provided is correct: 0a2ed70a549e61c5181bad5db418d223b68ae932

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nobuhiro Iwamatsu<nobuhiro1.iwamatsu@toshiba.co.jp>
Commit author: Seiji Nishikawa<snishika@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 68a8e45743d6)
6.1.y | Present (different SHA1: 68a599da16eb)
5.15.y | Present (different SHA1: 92e5661b7d07)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0a2ed70a549e6 ! 1:  bc54e445630f7 ACPI: PAD: fix crash in exit_round_robin()
    @@ Metadata
      ## Commit message ##
         ACPI: PAD: fix crash in exit_round_robin()
     
    +    commit 0a2ed70a549e61c5181bad5db418d223b68ae932 upstream.
    +
         The kernel occasionally crashes in cpumask_clear_cpu(), which is called
         within exit_round_robin(), because when executing clear_bit(nr, addr) with
         nr set to 0xffffffff, the address calculation may cause misalignment within
    @@ Commit message
         Link: https://patch.msgid.link/20240825141352.25280-1-snishika@redhat.com
         [ rjw: Subject edit, avoid updates to the same value ]
         Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    +    Link: https://nvd.nist.gov/vuln/detail/CVE-2024-49935
    +    Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
     
      ## drivers/acpi/acpi_pad.c ##
    -@@ drivers/acpi/acpi_pad.c: static void exit_round_robin(unsigned int tsk_index)
    +@@ drivers/acpi/acpi_pad.c: static void round_robin_cpu(unsigned int tsk_index)
    + static void exit_round_robin(unsigned int tsk_index)
      {
      	struct cpumask *pad_busy_cpus = to_cpumask(pad_busy_cpus_bits);
    - 
     -	cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
     -	tsk_in_cpu[tsk_index] = -1;
    ++
     +	if (tsk_in_cpu[tsk_index] != -1) {
     +		cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
     +		tsk_in_cpu[tsk_index] = -1;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

