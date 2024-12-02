Return-Path: <stable+bounces-96055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1004C9E04EE
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E86169252
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD7E1FECD5;
	Mon,  2 Dec 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyuc14k6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B130204F6B
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149616; cv=none; b=lfNdbSS6UmmU8IxWMuNeeTWRDDN/i6/KHfjlNtHAE6WJID3AD4Evm2yUB6Md8d/eA5gjoROuYhQQ/u6pPxowzr9wXC6wQhlsO8kU0mEjJ3Gy5FNCKNwVrdnYSOCxsBUnzRD/RjdzyvaHWgKxwflbyqir0nb2TSatAFCyT4G88vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149616; c=relaxed/simple;
	bh=69s2LvvnbVR1BBCp2cD8ZsXcP1poDvF9A+UNaqABqkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAH7oJigNjJO2O3yVeBozAJ/Lx7jY5njvqSvOOdqfeqGhA1QHk0UrSJbfefEea1XAsn5+yjc3C6beA65x1xPawVmfOgSeZ+w4yWeoHbCI9BK2wG538LTpseW/K4U/19dGM/zp3Oim20R/ixLG4QXuPukhqOH2cL7tqU0dKkxvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyuc14k6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2EAC4CED1;
	Mon,  2 Dec 2024 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149616;
	bh=69s2LvvnbVR1BBCp2cD8ZsXcP1poDvF9A+UNaqABqkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cyuc14k6oglKMxitvAuGx+h+yzdAkz41bzY8xyXbJueN2j0251fjT4kkKBv/Wh549
	 gxmBCwPIeBqpK/GKOMB+MvgP5MadvD43NdJWErTyviHPONgFSA20525Xc2Cn9JdriM
	 6TRMkosSIt76KyRUO7TOpjyvGKhoEw/FQN9EyXkKgoLNiHpmfWcnGd2ej/ZQEmVCe0
	 2OuqiT5AVjoivocV3ZVdkSc4ZUVUq4k8+Q+VVDMP5iAiVYcczqyTDQMmGuPX0u2U92
	 v8yf35yGtQrX9syJEjGwIjyodUqK6VH3uygjPHrFHo7Frm0SVum0ociMJUoOFj3gAP
	 eCMvZIIQCY4xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 1/1] ACPI: PAD: fix crash in exit_round_robin()
Date: Mon,  2 Dec 2024 09:26:54 -0500
Message-ID: <20241202074352-31ad9e70ffdb3173@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202121104.35898-2-n.zhandarovich@fintech.ru>
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

The upstream commit SHA1 provided is correct: 0a2ed70a549e61c5181bad5db418d223b68ae932

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Commit author: Seiji Nishikawa <snishika@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 27c045f868f0)
6.6.y | Present (different SHA1: 68a8e45743d6)
6.1.y | Present (different SHA1: 68a599da16eb)
5.15.y | Present (different SHA1: 92e5661b7d07)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0a2ed70a549e6 ! 1:  fa503f92cd35f ACPI: PAD: fix crash in exit_round_robin()
    @@ Metadata
      ## Commit message ##
         ACPI: PAD: fix crash in exit_round_robin()
     
    +    [ Upstream commit 0a2ed70a549e61c5181bad5db418d223b68ae932 ]
    +
         The kernel occasionally crashes in cpumask_clear_cpu(), which is called
         within exit_round_robin(), because when executing clear_bit(nr, addr) with
         nr set to 0xffffffff, the address calculation may cause misalignment within
    @@ Commit message
         Link: https://patch.msgid.link/20240825141352.25280-1-snishika@redhat.com
         [ rjw: Subject edit, avoid updates to the same value ]
         Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    +    [ Nikita: fix conflict due to missing blank line from commit
    +    c8eb628cbdd9 ("ACPI: acpi_pad: add a missed blank line after
    +    declarations"). ]
    +    Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
     
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
| stable/linux-5.10.y       |  Success    |  Success   |

