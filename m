Return-Path: <stable+bounces-52056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC9C9074C2
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CCD1F215F4
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2930C146A6E;
	Thu, 13 Jun 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2+F/1YC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B0146A63;
	Thu, 13 Jun 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287906; cv=none; b=JG0MU4eCIyO2w/KRmoDd/C5xf82lYIBX1FDRubn4ZTzChJznngwCi0vOM7tObQXxuW+08EYL/L1KsK3kJRF2l87avXwB9sBvdGoa+t3ws7GQiCslZxPQT2e9sRR0nGi9XM0+rtGnBh3y56+/DZUwPtcOg4dQef3GlyiAMwpbA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287906; c=relaxed/simple;
	bh=g3mPo55/Gt1FBgk79gnSHReqipxiT916wmvC5/CqQlk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qM37Z9TyHePq3o4oBi3CetGr3OZbliRXK0ET7lUxDFP3AkEOc7Nl4eMVnzP741wYPKe9Qo/kGAduwGRiKewPTjbz7ncshqKGDbvUGUInVyEgWTvv0ZwTItS+bUkAZZe+bm+3gHWij57sxI/SYDAbrpaEQktPyAMkRG2Hf54A+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2+F/1YC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1F4C2BBFC;
	Thu, 13 Jun 2024 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718287906;
	bh=g3mPo55/Gt1FBgk79gnSHReqipxiT916wmvC5/CqQlk=;
	h=Date:From:To:Cc:Subject:From;
	b=V2+F/1YC3QM+UAga0rqtKPdNgFHTPaW2EKtXOWvRtmwd32p6O2alJ9fzG3HBTegtY
	 pN9CthUgAaV7LkRjBHpadqfziegxidT6KX5+JyJB+FH3Ht/u+xI9eKDy+uzUJrcGnt
	 CiQWRGrPytaQyEueoX7BKOtUstryK7qczuZudIx9BJKoJHNEpk3xAkBScApk4qUWTJ
	 MZeQXYQKjF4bhdAKdRsT0gItmsN51557UxnqivtuzF+yE9d4zULLMX6byvVzHvNpLB
	 jbHu6tk4XhtQBkZv4sFcUszjl85vJbJM+4BHU9deVo1s+qtSYZQ+nRFDOPE6hcWg5u
	 w80fLFhGgSH/g==
Date: Thu, 13 Jun 2024 17:09:36 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Narasimhan V <Narasimhan.V@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock:fix validation of NUMA coverage
Message-ID: <Zmr9oBecxdufMTeP@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock 

for you to fetch changes up to 3ac36aa7307363b7247ccb6f6a804e11496b2b36:

  x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node() (2024-06-06 22:20:39 +0300)

----------------------------------------------------------------
Jan Beulich (2):
      memblock: make memblock_set_node() also warn about use of MAX_NUMNODES
      x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()

 arch/x86/mm/numa.c | 6 +++---
 mm/memblock.c      | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
Sincerely yours,
Mike.

