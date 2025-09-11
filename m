Return-Path: <stable+bounces-179290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F1B53900
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9EE8B61001
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C735CEC5;
	Thu, 11 Sep 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxUOR7TX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972535CEBA;
	Thu, 11 Sep 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607668; cv=none; b=fwwaxUZEEFfe2hhtpUInLxyJQY1FvhKYZXKIgbZKjKgVXxjLJ6NGNxUMbtHnoEr5k2jsSYsKQtwc4NvxaFBfOJWUpZzbLNnvPMVzJhYdLMZIL/p8bFa+kGY6Fn+BKnEA3uecrGY92WWg9TjD/ud5OfTzihJAWSdu7DYIHg7vIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607668; c=relaxed/simple;
	bh=uxnomweZr1hTX1wky47/jnqkf7PygKjVzqKyM3kRnOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kh4yRK+xoZCPXK0ZZz3B/DDdkGz8rHOldro8ELpyl0zoIg62DXdQ1bDLrjTf+rBt5Vxl8+VUVCDP8CQvuGQXlIzYiOC/OqkuG0XjFXJ9mPTeZVDBQ+F7iL5u5OrmBzGQaxg/di2mCxY/Wc76WZR3eKZymMFO7vBK2xZvqpoQp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxUOR7TX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06389C4CEF0;
	Thu, 11 Sep 2025 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757607668;
	bh=uxnomweZr1hTX1wky47/jnqkf7PygKjVzqKyM3kRnOc=;
	h=From:To:Cc:Subject:Date:From;
	b=UxUOR7TXNdunq/a1cIsmwgUePLl1rLdHB6CmnrSkawiimKIz1Bj/LCy93ZocV8ZWJ
	 o68AJ7jJTYcRKjZmhtGYugQ4PhHKUMjZKkZ2BPC1SHgoSil+gvKvft9dvMFJR5jDlE
	 wUzBHseb1766XQ6b87QvWgUx1z3V1VkhdeTdYHws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.152
Date: Thu, 11 Sep 2025 18:21:00 +0200
Message-ID: <2025091101-moneybags-improvise-b8a8@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.152 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
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
 arch/x86/kernel/cpu/common.c                       |   80 ++++--
 arch/x86/kvm/x86.c                                 |    9 
 drivers/base/cpu.c                                 |    7 
 include/linux/cpu.h                                |    1 
 14 files changed, 394 insertions(+), 105 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.1.152

Pawan Gupta (7):
      Documentation/hw-vuln: Add VMSCAPE documentation
      x86/vmscape: Enumerate VMSCAPE bug
      x86/vmscape: Add conditional IBPB mitigation
      x86/vmscape: Enable the mitigation
      x86/bugs: Move cpu_bugs_smt_update() down
      x86/vmscape: Warn when STIBP is disabled with SMT
      x86/vmscape: Add old Intel CPUs to affected list


