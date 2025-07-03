Return-Path: <stable+bounces-160109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B93AF8041
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5DB1CA2D40
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CE02F5C2B;
	Thu,  3 Jul 2025 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiILBtDx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C92F549C
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567697; cv=none; b=GaA1Og/3vXaclnMJAaw0KVlBXIQsLRH+X+2teHjCt2mGJ9HkSAJ7Az8xSuMx9f6PEsY6pzUdJV3rRYeE0V2l6blZ11ES49i9P+WzTgpHHFThVvzMszd435gULEfaU5R91YCHizTJRZrCxWP/Xs49pgS0/lS5nRq38t7OteQX5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567697; c=relaxed/simple;
	bh=qEQlCezD0tX5IOGJgKqeLRcN4vDRHG06RNd04IYZ3TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/XHMrx955z5mMCWw4Ae5tY0wsc3qQZlmaO2o5GGH1XJg16N/SfTOcV6Oklo69km4+uljNOjnHOWMmTN1ep1inDHG7mqPC7n1SyDfa5jLLaHM9lvk+R8VPWL5937eNVlenaI9UawFR6lvXKvfF8SSYagVXlFQo9Ug90xP03pFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiILBtDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B61BC4CEEB;
	Thu,  3 Jul 2025 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567696;
	bh=qEQlCezD0tX5IOGJgKqeLRcN4vDRHG06RNd04IYZ3TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiILBtDxk0+O6QP2vVZiJvq4Vz5WCGQLwGPKxQNWDQB0tmBpFZFnYXUrWGk79m7qs
	 Xc2CaZPquSu2YpoOs4OPp1AqaKx2uQ63i3IMsu/TiRPROfJVlFwoEGdbkDO5X0qky5
	 yFImdVeVY79Lsv4yAGckDGHO7fFS3x7zUjutOcRsbylzyMMeA/gUy6TlqG9fEKhh75
	 /bf/Pjk5JH3km/v6jAF+MfdGotqUk35SZhZzLFW+C6nT5lHKP0hyEmQmgraz4R3f6Q
	 jkEOm7epQQGqKrrstafA03CZkiMMO3xNc17xk4G6yFltmS7mDVhlfXi2ahcRdy6ccy
	 tOiO68VLcfM0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	teddy.astie@vates.tech
Cc: Sasha Levin <sashal@kernel.org>
Subject: =?UTF-8?q?Re=3A=20=3D=3Futf-8=3FQ=3F=5BPATCH=3D205=2E15=2Ey=5D=3D20xen=3A=3D20replace=3D20xen=3D5Fremap=28=29=3D20with=3D20memremap=28=29=3F=3D?=
Date: Thu,  3 Jul 2025 14:34:55 -0400
Message-Id: <20250703095236-eaaec1094f6ebb20@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <2398723b73ddd9923a9bb994364c2c7d3b89d21d.1751446695.git.teddy.astie@vates.tech>
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
     * [new branch]                  HEAD -> log-branch-ec112106cafa
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

