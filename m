Return-Path: <stable+bounces-179293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105ACB53903
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C343C561F99
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CBA35FC39;
	Thu, 11 Sep 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lp8v6LZF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2D35FC35;
	Thu, 11 Sep 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607681; cv=none; b=NAIQe5GPQFasJtyM3pvDRLPuLTVDLESssDhjWgVwIF9eFdRmaqrjHLqJTNHeWL4jfyb12A6uMCjR2b26XjXMJKOye31rMTBBbojUSJt1JMlSjl9ikaULni7T1jUsi4mBUtwehVztcnXz/bFvGss19NDdN9oEIu4JSylVJp/XwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607681; c=relaxed/simple;
	bh=7KINKR/oruimEdypseKgllwmsOXFRz0RXJ6JVxZNYI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtpkzSsl+QRpthOhuQMVwUOoLvYIsWkIuwrjwV7o1pn97Jy+pshAJ8a8ve/ceFVtyYX8jNdgFv8/cHoWyOqeCWqxLHQUetgPT+DPAlkZNUJS2baPrqDPKbCyX1+bEwhdVmxm4f6R6MML4+Q6NJKplbhLTsuHmZvV0PPdxvo9ES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lp8v6LZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE96C4CEF0;
	Thu, 11 Sep 2025 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757607680;
	bh=7KINKR/oruimEdypseKgllwmsOXFRz0RXJ6JVxZNYI4=;
	h=From:To:Cc:Subject:Date:From;
	b=lp8v6LZFPJOp35rbUiP/XTngqbpJID3SLyYhs1QZy2r7ZGp/C0+jnIJkImFmxMLBL
	 yJFxDwkDb1z3OahISSaTuD+rNcZqQEwdFTwQCShXV5CeCwBXC2qbucf1L2rp7bqR7y
	 HiWjES0DD1pu4f142rDLyNjgVV7fIl7VpWBiNzRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.106
Date: Thu, 11 Sep 2025 18:21:10 +0200
Message-ID: <2025091111-stopwatch-grieving-d276@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.106 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |    1 
 Documentation/admin-guide/hw-vuln/index.rst        |    1 
 Documentation/admin-guide/hw-vuln/vmscape.rst      |  110 ++++++++
 Documentation/admin-guide/kernel-parameters.txt    |   11 
 Makefile                                           |    2 
 arch/x86/Kconfig                                   |    9 
 arch/x86/include/asm/cpufeatures.h                 |    2 
 arch/x86/include/asm/entry-common.h                |    7 
 arch/x86/include/asm/nospec-branch.h               |    2 
 arch/x86/kernel/cpu/bugs.c                         |  257 ++++++++++++++-------
 arch/x86/kernel/cpu/common.c                       |   82 ++++--
 arch/x86/kvm/x86.c                                 |    9 
 drivers/base/cpu.c                                 |    3 
 include/linux/cpu.h                                |    1 
 14 files changed, 392 insertions(+), 105 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.6.106

Pawan Gupta (7):
      Documentation/hw-vuln: Add VMSCAPE documentation
      x86/vmscape: Enumerate VMSCAPE bug
      x86/vmscape: Add conditional IBPB mitigation
      x86/vmscape: Enable the mitigation
      x86/bugs: Move cpu_bugs_smt_update() down
      x86/vmscape: Warn when STIBP is disabled with SMT
      x86/vmscape: Add old Intel CPUs to affected list


