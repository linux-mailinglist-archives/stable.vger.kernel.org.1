Return-Path: <stable+bounces-150691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78604ACC51E
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B94164966
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6376B22ACEF;
	Tue,  3 Jun 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1Ly4ryg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA151F5E6;
	Tue,  3 Jun 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949293; cv=none; b=sVIvJ94zbykMX6IxuI8VmyL5JzETiyebZoJn35nf8cniWNoBHenjDlEnM4u3ugguBzbRQYfiTlix/zsL3aP/Y0ly+wCnE3KsKk3DkkXs3iQXUfeqIXBxhpFerKO/mlIkD/x9Lh33jBz/7RObS8hPbwnTW+jkTftrW+XJsjChOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949293; c=relaxed/simple;
	bh=a7VX5kwzCKw1l8FXvnhAUSsUrWFVtENo0dUkI7YQhLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BOKvb7DzrotZY61EqR6en8MJJdGypIweytvTo8M2nB79SJyqJcJJNAN1/I2lNuQg7xqeCbhv27ZPVbPtuewdXnDZt0qAQXOuIGC0J72XCv3MyySBn15szrxEzYKfxkQkfK8QjD0WKna5F37oJ/tZRFkzm4/4eGMwT0lT3w3Xu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1Ly4ryg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD753C4CEED;
	Tue,  3 Jun 2025 11:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748949292;
	bh=a7VX5kwzCKw1l8FXvnhAUSsUrWFVtENo0dUkI7YQhLc=;
	h=From:To:Cc:Subject:Date:From;
	b=T1Ly4rygu5PEF/UdAjCNhR4334dJPzHlcLv8+GhZLC23Cuga6IhPmwCN6/3qcj/Cs
	 K73UnYidlCSWueZ0Z+fhFXN6b/jGfMYa35l/hNU4qwmtYe9gKMzptd0+2qq2mMamAU
	 SZyVTAwDmXCxBLm2tCv8sdKei6Wy6ngYp+kZfzX/6kPeqHdi0VFbd+YKNds1VLMY8k
	 ukkKwXqINUHUAwVQiAa5oOoOdZIlF65JlnvkwvoDpivfgvXH61OUZxYmxA45Pw1AY3
	 +AHKIXXWlsDyK2qraU41uY283wzn/bt1uXdeHOlMhjdgl2MKEl3mZ92626WzP2oaN7
	 XtlnXJamQtYEQ==
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	=?UTF-8?q?J=FCrgen=20Gro=DF?= <jgross@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xin Li <xin@zytor.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 0/5] Fixes for ITS mitigation and execmem
Date: Tue,  3 Jun 2025 14:14:40 +0300
Message-ID: <20250603111446.2609381-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Jürgen Groß reported some bugs in interaction of ITS mitigation with
execmem [1] when running on a Xen PV guest.

These patches fix the issue by moving all the permissions management of
ITS memory allocated from execmem into ITS code.

I didn't test on a real Xen PV guest, but I emulated !PSE variant by
force-disabling the ROX cache in x86::execmem_arch_setup().

Peter, I took liberty to put your SoB in the patch that actually
implements the execmem permissions management in ITS, please let me know
if I need to update something about the authorship.

The patches are against v6.15.
They are also available in git:
https://web.git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=its-execmem/v1

[1] https://lore.kernel.org/all/20250528123557.12847-2-jgross@suse.com/

Juergen Gross (1):
  x86/mm/pat: don't collapse pages without PSE set

Mike Rapoport (Microsoft) (3):
  x86/Kconfig: only enable ROX cache in execmem when STRICT_MODULE_RWX is set
  x86/its: move its_pages array to struct mod_arch_specific
  Revert "mm/execmem: Unify early execmem_cache behaviour"

Peter Zijlstra (Intel) (1):
  x86/its: explicitly manage permissions for ITS pages

 arch/x86/Kconfig              |  2 +-
 arch/x86/include/asm/module.h |  8 ++++
 arch/x86/kernel/alternative.c | 89 ++++++++++++++++++++++++++---------
 arch/x86/mm/init_32.c         |  3 --
 arch/x86/mm/init_64.c         |  3 --
 arch/x86/mm/pat/set_memory.c  |  3 ++
 include/linux/execmem.h       |  8 +---
 include/linux/module.h        |  5 --
 mm/execmem.c                  | 40 ++--------------
 9 files changed, 82 insertions(+), 79 deletions(-)


base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.47.2


