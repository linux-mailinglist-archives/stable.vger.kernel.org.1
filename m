Return-Path: <stable+bounces-43504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47A98C14BD
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 20:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588AF1F22EFE
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA287E78E;
	Thu,  9 May 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rucfJYQa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA887D41F;
	Thu,  9 May 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279268; cv=none; b=W/67wXJVM6YQg+jILkgC6A6iI0y8ZBmZcdluJDAiV2Hqr3yHneAn+T7HLqWBskFleE6TXixgAptlgfEgsyZBIJXIQ8mr/yacNclVrOnptQSLgrg83utj4QaEauo80Een00FLUHR3x/hTrA+okPMIJk/ARq2Cr7JWX6YdRqiJZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279268; c=relaxed/simple;
	bh=RwF9Ky79Nr0kK/vewzqtG7SJuC3KEaUY7spiwqX/PhE=;
	h=Date:To:From:Subject:Message-Id; b=TV+0xOI9uzUkgI2as58JnnCbiMzSB0DrD+uriwid3DZ+0dprqUoCs1HgJ0Bb+YO/ihjzDomkdzfY4yz5VYgXJNpQ139YzTFUa4b9GKD7Czt2aKDx4JT1te4xjQ2Z1CBPoxNORHFI8Y+Mh9wyKWLcfQGwjy0sfHg93Hl8gPBTSjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rucfJYQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4414C116B1;
	Thu,  9 May 2024 18:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715279267;
	bh=RwF9Ky79Nr0kK/vewzqtG7SJuC3KEaUY7spiwqX/PhE=;
	h=Date:To:From:Subject:From;
	b=rucfJYQai7p8l16LB+HRJKLIq0lS4Y/03B+lJypCXdGLYVt6fzpSahRxoS9nSrg66
	 t9sBBxOXeK7MgIxhOwPqz0/snlNQRBkwa+II7LbxZh6vnKfMVFYPU+ftiWzaRfE259
	 26VBZQ1qmr2W/W25ywOiW1XFKIlI1HWPaHrESsTQ=
Date: Thu, 09 May 2024 11:27:46 -0700
To: mm-commits@vger.kernel.org,vgoyal@redhat.com,stable@vger.kernel.org,dyoung@redhat.com,bhe@redhat.com,riel@surriel.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + fs-proc-fix-softlockup-in-__read_vmcore.patch added to mm-nonmm-unstable branch
Message-Id: <20240509182747.B4414C116B1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: fs/proc: fix softlockup in __read_vmcore
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     fs-proc-fix-softlockup-in-__read_vmcore.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/fs-proc-fix-softlockup-in-__read_vmcore.patch

This patch will later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Rik van Riel <riel@surriel.com>
Subject: fs/proc: fix softlockup in __read_vmcore
Date: Tue, 7 May 2024 09:18:58 -0400

While taking a kernel core dump with makedumpfile on a larger system,
softlockup messages often appear.

While softlockup warnings can be harmless, they can also interfere with
things like RCU freeing memory, which can be problematic when the kdump
kexec image is configured with as little memory as possible.

Avoid the softlockup, and give things like work items and RCU a chance to
do their thing during __read_vmcore by adding a cond_resched.

Link: https://lkml.kernel.org/r/20240507091858.36ff767f@imladris.surriel.com
Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/proc/vmcore.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/proc/vmcore.c~fs-proc-fix-softlockup-in-__read_vmcore
+++ a/fs/proc/vmcore.c
@@ -383,6 +383,8 @@ static ssize_t __read_vmcore(struct iov_
 		/* leave now if filled buffer already */
 		if (!iov_iter_count(iter))
 			return acc;
+
+		cond_resched();
 	}
 
 	list_for_each_entry(m, &vmcore_list, list) {
_

Patches currently in -mm which might be from riel@surriel.com are

fs-proc-fix-softlockup-in-__read_vmcore.patch


