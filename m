Return-Path: <stable+bounces-46131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E155D8CEF63
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C31C2092E
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D125A0F8;
	Sat, 25 May 2024 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L6Ybhw/b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647B59161;
	Sat, 25 May 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648470; cv=none; b=J9xKkO//a8IPN6DQliLIHZ6+zXu+NbzBE3G3Ba/L766pdNCWv/xoqNAGarAMcMwbmCpTu/o93+zbsEp2+fOA4STpmdqwhq+lqGYKvoxMkMXiTwcPFMqZOPwCAV0dG0eAy1SHrAVNbtjYuLzp707gK559v7kdwAxYw1F0Ci6G4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648470; c=relaxed/simple;
	bh=eeCR+FVA5mizGL9/V2+mlkpfHe1YBVwWSDeCMIJD0dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAx2eaMOPgA55eiQZJsz31Ctzdt3NGhiycij6+hURlbs/TX6hIVt/yEvRCftBC19JJx5u58AMFwI80bQyznY1NkETuBnrj0RD7hbGbStSYIHoVw/xpzyFlAdkQvg9qYSGN4tTZmvZuN6YFdZa/z7l1xxQNqtupw8wMX0HDm7Lwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L6Ybhw/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A905C2BD11;
	Sat, 25 May 2024 14:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648469;
	bh=eeCR+FVA5mizGL9/V2+mlkpfHe1YBVwWSDeCMIJD0dQ=;
	h=From:To:Cc:Subject:Date:From;
	b=L6Ybhw/bTfx/0uilyWKx+Vk7EvnQZClaFqgMrtWj4KU0e7JtWjfmH6sYs6lWWa1e8
	 6cjlKxwDMFyNkWVF1yzNsAMq29de/YKyWj0SqAsOA9Li6ct8oGcYagOWFE4bejZijr
	 yGIvcMItubvT3Y/JqSTAVpE4HY+02AD+vbcWaChs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.315
Date: Sat, 25 May 2024 16:47:45 +0200
Message-ID: <2024052545-fridge-semester-b4a7@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.315 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/sphinx/kernel_include.py   |    1 
 Makefile                                 |    2 
 drivers/md/dm-core.h                     |    2 
 drivers/md/dm-ioctl.c                    |    3 
 drivers/md/dm-table.c                    |    9 
 drivers/tty/serial/kgdboc.c              |   30 
 fs/btrfs/volumes.c                       |    1 
 include/linux/string.h                   |   20 
 include/linux/trace_events.h             |    2 
 kernel/trace/Kconfig                     |    4 
 kernel/trace/Makefile                    |    1 
 kernel/trace/trace.c                     |   26 
 kernel/trace/trace_dynevent.c            |  210 ++++++
 kernel/trace/trace_dynevent.h            |  119 +++
 kernel/trace/trace_events.c              |   32 
 kernel/trace/trace_events_hist.c         | 1048 ++++++++++++++++++-------------
 kernel/trace/trace_probe.c               |    2 
 kernel/trace/trace_stack.c               |    2 
 tools/testing/selftests/vm/map_hugetlb.c |    7 
 19 files changed, 1050 insertions(+), 471 deletions(-)

Akira Yokosawa (1):
      docs: kernel_include.py: Cope with docutils 0.21

Daniel Thompson (1):
      serial: kgdboc: Fix NMI-safety problems from keyboard reset code

Dominique Martinet (1):
      btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()

Greg Kroah-Hartman (1):
      Linux 4.19.315

Harshit Mogalapalli (1):
      Revert "selftests: mm: fix map_hugetlb failure on 64K page size systems"

Masami Hiramatsu (4):
      tracing: Simplify creation and deletion of synthetic events
      tracing: Add unified dynamic event framework
      tracing: Use dyn_event framework for synthetic events
      tracing: Remove unneeded synth_event_mutex

Mikulas Patocka (1):
      dm: limit the number of targets and parameter size area

Steven Rostedt (VMware) (5):
      tracing: Consolidate trace_add/remove_event_call back to the nolock functions
      string.h: Add str_has_prefix() helper function
      tracing: Use str_has_prefix() helper for histogram code
      tracing: Use str_has_prefix() instead of using fixed sizes
      tracing: Have the historgram use the result of str_has_prefix() for len of prefix

Tom Zanussi (4):
      tracing: Refactor hist trigger action code
      tracing: Split up onmatch action data
      tracing: Generalize hist trigger onmax and save action
      tracing: Remove unnecessary var_ref destroy in track_data_destroy()


