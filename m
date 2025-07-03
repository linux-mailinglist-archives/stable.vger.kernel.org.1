Return-Path: <stable+bounces-160107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08396AF804A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221373AAD0B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5F2F546F;
	Thu,  3 Jul 2025 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5FDXa07"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76962F546A
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567692; cv=none; b=Jf1X5QWzeTlX5p9m8OPksfBBU1Cxm0CV5KSWBoTxLCg0uHel13s4ZC+Vp2sNPylM3pr7LQF1O4jqwj/69fNwbPGoCXkt/eWEqFQIuqXYCsc05R/CyDvh2DH6sDJU8AFYA4hOjKgvUHWAMsJH5PNDux9gp2TXemWTS4iX0Sdec/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567692; c=relaxed/simple;
	bh=0ohIukKV3zEw383GQMaBj4fizFXmXZc/SHkjsgsm1uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQr+3FJORMAPHeCWuGb94PahEFDSRcGtsK8YzfBRJM4VlEiW9M+VIbtbUR1pFlzOShna1kdfc46ZDs2td6jKYiU7K/mNTeJ6hIKYQzK38k7s0rDDq+4oB5K2KQzdmdHndIV+TZ4nacuH8XvlpjQJEJL+gW6t+BXEeG+Zwc+JCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5FDXa07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DBAC4CEE3;
	Thu,  3 Jul 2025 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567692;
	bh=0ohIukKV3zEw383GQMaBj4fizFXmXZc/SHkjsgsm1uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5FDXa077lGogzvh74BkazRuOmfWHms2S9iT1CR//pZfNT17SuMYcHst/WHRFJvzc
	 tzGj/lo9IJgWWMLAtaev/RB527LXXmXnUeIoGgFvIjF2M/T1c53jlGq2/YWFhmO1nN
	 C4ldhkA+yssyrjOD1h3+JTcl258/L4dP+R7piWH6OZmoHjf/eh6cNU+/HRcPSCOXtV
	 YKwkQFttdWXddtMqVUYMMUjZme5qaJaATIxLi7nagxfgG6eqZPpE0SDZIZMNqquviR
	 0A5ZcNajkj8KCo34dvG/g9w1+aqdhk7cfdbO0StZL3yczwVK3Mmr/K0UvWzb1wWcP5
	 /x6ghmy5djT/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	teddy.astie@vates.tech
Cc: Sasha Levin <sashal@kernel.org>
Subject: =?UTF-8?q?Re=3A=20=3D=3Futf-8=3FQ=3F=5BPATCH=3D205=2E15=2Ey=3D20v2=5D=3D20xen=3A=3D20replace=3D20xen=3D5Fremap=28=29=3D20with=3D20memremap=28=29=3F=3D?=
Date: Thu,  3 Jul 2025 14:34:51 -0400
Message-Id: <20250703102903-de26f0e96813af08@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <816ab25650e06a5fb51c5a51ec0108aa2238271a.1751449523.git.teddy.astie@vates.tech>
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
❌ Build failures detected

The upstream commit SHA1 provided is correct: 41925b105e345ebc84cedb64f59d20cb14a62613

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Teddy Astie"<teddy.astie@vates.tech>
Commit author: Juergen Gross<jgross@suse.com>

Note: The patch differs from the upstream commit:
---
1:  41925b105e345 < -:  ------------- xen: replace xen_remap() with memremap()
-:  ------------- > 1:  e60eb441596d1 Linux 6.15.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

Build Errors:
Build error for stable/linux-5.15.y:
    Building current HEAD with log output
    To ssh://sws/home/sasha/linux
     * [new branch]                  HEAD -> log-branch-832194978679
    drivers/tty/hvc/hvc_xen.c: In function 'xen_hvm_console_init':
    drivers/tty/hvc/hvc_xen.c:273:22: error: implicit declaration of function 'xen_remap'; did you mean 'memremap'? [-Werror=implicit-function-declaration]
      273 |         info->intf = xen_remap(gfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE);
          |                      ^~~~~~~~~
          |                      memremap
    drivers/tty/hvc/hvc_xen.c:273:20: warning: assignment to 'struct xencons_interface *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      273 |         info->intf = xen_remap(gfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE);
          |                    ^
    cc1: some warnings being treated as errors
    make[3]: *** [scripts/Makefile.build:289: drivers/tty/hvc/hvc_xen.o] Error 1
    make[3]: Target '__build' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:552: drivers/tty/hvc] Error 2
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:552: drivers/tty] Error 2
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1926: drivers] Error 2
    make: Target '__all' not remade because of errors.
    Build x86: exited with code 2
    Cleaning up worktrees...
    Cleaning up worktrees...

