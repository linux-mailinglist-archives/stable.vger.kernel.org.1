Return-Path: <stable+bounces-59209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B9593014A
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 22:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BBB1C22720
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 20:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9645007;
	Fri, 12 Jul 2024 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0wmrH4Va"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB544C68;
	Fri, 12 Jul 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815869; cv=none; b=gMJYtq2lueSyCKGsZllmG2V0WuNDDnhstAa7Pj2A0C8XvWfeir9FDg+7jCBbCgbnWawmm+5g0v38lAs1WCqlmhfnLK0jgekOWVj/n4Ng23TMadqmmOMuB0fgZF8HrQ7uZj/5NTwZOf5j5E26U31SAvc1YrKxxmjyCl0Uay9+tB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815869; c=relaxed/simple;
	bh=Lywo0Rs2LR+sXjxxzG5c4AObsksCws41AlWygkxuasU=;
	h=Date:To:From:Subject:Message-Id; b=iIjgGkdWI+o64NZT3ovW3SreGcTKWyipC+l2gSoa4hKg806xmNWjidjYZd2KDLuoIgkIA04GtRh4QoqzBY8rgijOUPloxpEyEgGHNvda5VQtosMZN4UzDaRQwI7m6sTTnedliUA3M5VtyKSbKUKSzzwUK/R0s8x+LTWn9pGKxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0wmrH4Va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A34C32782;
	Fri, 12 Jul 2024 20:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720815868;
	bh=Lywo0Rs2LR+sXjxxzG5c4AObsksCws41AlWygkxuasU=;
	h=Date:To:From:Subject:From;
	b=0wmrH4VayX/NvEwH/04Qh9lg8jdIlD6yDuw1t1lRriHnA9v669t1voqkXrOsaqneV
	 SSl+2QaOAxi7iOlQ4nSVF+mYC3jBJtz6179hn/cTcsFf2w/mSnU2KXOqtQA+HztH3N
	 QMAt5DCIfp7PMiYLR1duhS9woo+o9VRqPaIjdlSA=
Date: Fri, 12 Jul 2024 13:24:28 -0700
To: mm-commits@vger.kernel.org,willy@infradead.org,surenb@google.com,stable@vger.kernel.org,riel@surriel.com,jirislaby@kernel.org,corsac@debian.org,cl@linux.com,carnil@debian.org,ben@decadent.org.uk,yang@os.amperecomputing.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-huge_memory-use-config_64bit-to-relax-huge-page-alignment-on-32-bit-machines.patch added to mm-hotfixes-unstable branch
Message-Id: <20240712202428.91A34C32782@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm: huge_memory: use !CONFIG_64BIT to relax huge page alignment on 32 bit machines
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-huge_memory-use-config_64bit-to-relax-huge-page-alignment-on-32-bit-machines.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-huge_memory-use-config_64bit-to-relax-huge-page-alignment-on-32-bit-machines.patch

This patch will later appear in the mm-hotfixes-unstable branch at
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
From: Yang Shi <yang@os.amperecomputing.com>
Subject: mm: huge_memory: use !CONFIG_64BIT to relax huge page alignment on 32 bit machines
Date: Fri, 12 Jul 2024 08:58:55 -0700

Yves-Alexis Perez reported commit 4ef9ad19e176 ("mm: huge_memory: don't
force huge page alignment on 32 bit") didn't work for x86_32 [1].  It is
because x86_32 uses CONFIG_X86_32 instead of CONFIG_32BIT.

!CONFIG_64BIT should cover all 32 bit machines.

[1] https://lore.kernel.org/linux-mm/CAHbLzkr1LwH3pcTgM+aGQ31ip2bKqiqEQ8=FQB+t2c3dhNKNHA@mail.gmail.com/

Link: https://lkml.kernel.org/r/20240712155855.1130330-1-yang@os.amperecomputing.com
Fixes: 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignment on 32 bit")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Reported-by: Yves-Alexis Perez <corsac@debian.org>
Tested-by: Yves-Alexis Perez <corsac@debian.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Christoph Lameter <cl@linux.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>	[6.8+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/huge_memory.c~mm-huge_memory-use-config_64bit-to-relax-huge-page-alignment-on-32-bit-machines
+++ a/mm/huge_memory.c
@@ -858,7 +858,7 @@ static unsigned long __thp_get_unmapped_
 	loff_t off_align = round_up(off, size);
 	unsigned long len_pad, ret, off_sub;
 
-	if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
+	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
 		return 0;
 
 	if (off_end <= off_align || (off_end - off_align) < size)
_

Patches currently in -mm which might be from yang@os.amperecomputing.com are

mm-huge_memory-use-config_64bit-to-relax-huge-page-alignment-on-32-bit-machines.patch


