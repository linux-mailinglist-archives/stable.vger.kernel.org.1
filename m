Return-Path: <stable+bounces-179288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FB9B538F6
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED7E58311F
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472335A2BC;
	Thu, 11 Sep 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vvxv9uho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1B35A2B3;
	Thu, 11 Sep 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607663; cv=none; b=AoG63lHqXp25vUdmWrOrIuiSrVVOohNabXCVrBRjKnyhmBC3dCmigczjtXEAabsomDndyAN5w5z+HDDVRlVwxHHDANoGDBpls5SZbjkAb/r2v0nm/mdyroi3hmY9HGBofnwhS346v5t1MJmNONIxWGxj6iF2iN4q4Dv2iRB38bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607663; c=relaxed/simple;
	bh=+ihM9kGpXxhuMkTL7NTYJ8EaFaGikwOoHk85S2o3DSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HV7Of/n3ug63YPr7VkyMyQcaSbWgSgFcYflNXtthEmVlLIgvcUP6VRtCAn2LBk+nXvolAwDMsalmwbtZ8bwf9TvQTW5pZQotPYZUsEY7suUkTdtvVeGj8kjMFJd9+qwWw2KX0W/Qx0MKewQnUe5TBKtWYc5F/7vF/lwATTA7sto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vvxv9uho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBD7C4CEF0;
	Thu, 11 Sep 2025 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757607661;
	bh=+ihM9kGpXxhuMkTL7NTYJ8EaFaGikwOoHk85S2o3DSg=;
	h=From:To:Cc:Subject:Date:From;
	b=Vvxv9uho3CgCcLMzjEbq4omvmH0OyM0q0PXs7YnMyUTWdAblYBm8Aw/4TxO6/Z3rV
	 fnNQYgb1VWzZDZxG6QCRC4g19SGbHa33BjWM87/wGt/25ZJpN6pJQTDIgVAt4O5axj
	 mxbuCLFSaKLWgUp2etikvzIQfqNoFgtmYhtoDGog=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.193
Date: Thu, 11 Sep 2025 18:20:54 +0200
Message-ID: <2025091155-skyrocket-respect-aa75@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.193 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
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
 arch/x86/kernel/cpu/bugs.c                         |  264 ++++++++++++++-------
 arch/x86/kernel/cpu/common.c                       |   77 +++---
 arch/x86/kvm/x86.c                                 |    9 
 drivers/base/cpu.c                                 |    6 
 include/linux/cpu.h                                |    1 
 14 files changed, 393 insertions(+), 109 deletions(-)

Greg Kroah-Hartman (1):
      Linux 5.15.193

Pawan Gupta (7):
      Documentation/hw-vuln: Add VMSCAPE documentation
      x86/vmscape: Enumerate VMSCAPE bug
      x86/vmscape: Add conditional IBPB mitigation
      x86/vmscape: Enable the mitigation
      x86/bugs: Move cpu_bugs_smt_update() down
      x86/vmscape: Warn when STIBP is disabled with SMT
      x86/vmscape: Add old Intel CPUs to affected list


