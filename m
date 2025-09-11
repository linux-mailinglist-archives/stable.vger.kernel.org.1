Return-Path: <stable+bounces-179296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D779AB53912
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1DEB61AE9
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079163629B6;
	Thu, 11 Sep 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RidPc2S5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC73629AE;
	Thu, 11 Sep 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607695; cv=none; b=CYG0QwZVQVb503Qn/DI65MLhrrsygm3eVInL498VPGuJOaUJHqL3SfzwZByU5dxADgohSjPbGXj+WHLeH6v2Y2iJW+ubBjKz+Y2Tug+AD3gfwIJkHmeZHLuDhTuaLo9VidtkfrYFclf7j34uH1VoaP+vpyKN36XfCP4s3sqEPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607695; c=relaxed/simple;
	bh=pSviamux9NYQBKn4/9Uw/1XlLEgAmGwwXfgQmBDlYoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJzdk5nC4nsMJW+H6JlgVSAMJppOI6f5r6B8wUwWwcfQPRzGogQN7Pfe9iOg128sSbb6Hq0uwcCHYxkfvEgxg5zVG3yND676Mi6lm+vWiUutEIKh5K9h7OBIYMUdu4t/rJhoOYSAnOoNg9ABn172VsiRZ3B96MtY8gD8VLxihRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RidPc2S5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00950C4CEF5;
	Thu, 11 Sep 2025 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757607695;
	bh=pSviamux9NYQBKn4/9Uw/1XlLEgAmGwwXfgQmBDlYoU=;
	h=From:To:Cc:Subject:Date:From;
	b=RidPc2S5zn24Xgo61cP8Lb3T2laUDO3V7nM3E5/a9jA7TdNyTuwmw03HDNrGCLIuY
	 1CLHWjeMxXoOwtJDUGCRzNi8E/MRokam0YE3Q4MC3QewK18YIZCSm6tTjI6PpsOHYP
	 lEgAgYSZ6IBaurUjJ4OD/h2f9+gSlJTWBJjfE760=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.7
Date: Thu, 11 Sep 2025 18:21:24 +0200
Message-ID: <2025091125-helper-splashed-ea2a@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.16.7 kernel.

All users of the 6.16 kernel series must upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
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
 arch/x86/kernel/cpu/bugs.c                         |  285 ++++++++++++++-------
 arch/x86/kernel/cpu/common.c                       |   86 ++++--
 arch/x86/kvm/x86.c                                 |    9 
 drivers/base/cpu.c                                 |    3 
 include/linux/cpu.h                                |    1 
 14 files changed, 415 insertions(+), 114 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.16.7

Pawan Gupta (7):
      Documentation/hw-vuln: Add VMSCAPE documentation
      x86/vmscape: Enumerate VMSCAPE bug
      x86/vmscape: Add conditional IBPB mitigation
      x86/vmscape: Enable the mitigation
      x86/bugs: Move cpu_bugs_smt_update() down
      x86/vmscape: Warn when STIBP is disabled with SMT
      x86/vmscape: Add old Intel CPUs to affected list


