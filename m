Return-Path: <stable+bounces-148352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C8AC9B3C
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312CA1BA0619
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD4023815B;
	Sat, 31 May 2025 13:48:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-38.mail.aliyun.com (out28-38.mail.aliyun.com [115.124.28.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0D18E3F;
	Sat, 31 May 2025 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748699280; cv=none; b=KyTJYeZn2ua0FAzZcaYP6ABl77lmMaFSobtJ9KO4nRiaX/Wy81vXDCpY32ueKLH1OzZ09BU6pX12aLrmqtwshrbr79XWdP7ykXtk46DEfxnMj8O0YcgSthNZ2evcfYizuzZi3b15umNTrqSUikCuyZIIp7Y/pOH2jOUTAq7q238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748699280; c=relaxed/simple;
	bh=ZE8y7AI5VqnyjhS5mla0sAMeI69zZoBlTCBQIQgIJXc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=fv3RGkvFHHNHNuBjpyayXzDDR0Yd7CXH9WL6w6HaFwVw90B1RVwvnzNrWYzhXwFuoXRGD1iuZOdiCxbwsCIMIoxXEW46Vsd1aHvAGKIeF7+JnLzFs1f7pS6/eAGyx6bEdxGCBJwCJU337sTbFwNZ6wu8iTfBj0XEqKzvQaCuDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.d5kicG2_1748697412 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 31 May 2025 21:16:53 +0800
Date: Sat, 31 May 2025 21:16:54 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Filipe Manana <fdmanana@kernel.org>
Subject: Re: 6.1.140 build failure(fs/btrfs/discard.c:247:5: error: implicit declaration of function 'ASSERT')
Cc: linux-btrfs@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>,
 stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <CAL3q7H48BBHKd-3DHCgfxbx5zbJvqfeAr=UV1hQFGj0Lw4DEzA@mail.gmail.com>
References: <20250526134027.187C.409509F4@e16-tech.com> <CAL3q7H48BBHKd-3DHCgfxbx5zbJvqfeAr=UV1hQFGj0Lw4DEzA@mail.gmail.com>
Message-Id: <20250531211653.ED6C.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.08 [en]

Hi,

> On Mon, May 26, 2025 at 6:40?AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> >
> > Hi,
> > Cc: Filipe Manana
> >
> > I noticed 6.1.140 build failure(fs/btrfs/discard.c:247:5: error: implicit declaration of function 'ASSERT')
> >
> > fs/btrfs/discard.c: In function 'peek_discard_list':
> > fs/btrfs/discard.c:247:5: error: implicit declaration of function 'ASSERT'; did you mean 'IS_ERR'? [-Werror=implicit-function-declaration]
> >      ASSERT(block_group->discard_index !=
> >      ^~~~~~
> >      IS_ERR
> >
> > It seems realted to the patch(btrfs-fix-discard-worker-infinite-loop-after-disabling-discard.patch).
> 
> Yes, it is.
> 
> The patch, like most stable backports, was automatically picked by the
> stable scripts and added to stable releases.
> I assume that before the release was made, it was compile tested by
> the stable automatic processes.
> 
> I just tried it, and it compiles successfully for me:
> 
> fdmanana 11:56:26 ~/git/hub/linux ((v6.12))> git clean -xfd
> fdmanana 11:57:27 ~/git/hub/linux ((v6.12))> git co v6.1.140
> fdmanana 11:59:53 ~/git/hub/linux ((v6.1.140))> make defconfig
> 
> fdmanana 12:02:17 ~/git/hub/linux ((v6.1.140))> grep BTRFS .config
> CONFIG_BTRFS_FS=m
> CONFIG_BTRFS_FS_POSIX_ACL=y
> CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
> CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
> CONFIG_BTRFS_DEBUG=y
> CONFIG_BTRFS_ASSERT=y
> CONFIG_BTRFS_FS_REF_VERIFY=y
> 
> fdmanana 12:06:08 ~/git/hub/linux ((v6.1.140))> make fs/btrfs/btrfs.ko
>   LD [M]  fs/btrfs/btrfs.ko
> 
> fdmanana 12:11:12 ~/git/hub/linux ((v6.1.140))> gcc --version
> gcc (Debian 9.3.0-18) 9.3.0

Yes.  this build error does NOT happen on 6.1.140 upstream.

It happened here because of some local btrfs backuport of linux 6.2.

Sorry.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/05/31

> >
> > I walked around it with the following patch.
> 
> In the future please cc the stable list when you find problems with
> stable backports.
> 
> >
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index 98bce18..9ffe5c4 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/math64.h>
> >  #include <linux/sizes.h>
> >  #include <linux/workqueue.h>
> > +#include "messages.h"
> >  #include "ctree.h"
> >  #include "block-group.h"
> >  #include "discard.h"
> >
> >
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2025/05/26
> >
> >
> >



