Return-Path: <stable+bounces-179286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9580B538F8
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6187B51A6
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F46356905;
	Thu, 11 Sep 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rM748PJP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059131CA6D;
	Thu, 11 Sep 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607655; cv=none; b=T0ipjBoPg+ALazMbRe2cBh3gwvY9U5QkOFXR1gxf+p3s5qpXSfCFNWfLNo7DjFjyareTmeF+P8oHyohhI1Fe5Lh+qbpinUvifWWhyCZEhomjXNhhvKFGqNwa7Xl4hKFXtyM3JftwuI9MHrv3xdaASdkYs2mh0qI7fA5uEkVNuxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607655; c=relaxed/simple;
	bh=7DGtYB4l6A8XtCsI/RpY4QjkVB//jE93oWxCdSj+ldk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iab3Iv950ZNCxs8S5ZQ/BQY26oBiNEGkFYEqIGPkVF/CFfGtKkew4Jwg6Y/+8XbefzPIsH0XwwgbUpkH8Cj63J5cCCWAUoj0BvtdikAFizABWt43ErZ5En/DQkJ/ORO3MMwh86E6IXBryjHuxTrfI5KepdPyEs17ZoJ0vRP4XKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rM748PJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2397FC4CEF0;
	Thu, 11 Sep 2025 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757607653;
	bh=7DGtYB4l6A8XtCsI/RpY4QjkVB//jE93oWxCdSj+ldk=;
	h=From:To:Cc:Subject:Date:From;
	b=rM748PJPizFLzaQLcQoKtqzmz65BYYOvp9r3AeVu6FmaDkgFL2Nt2AZi6avFcdoXa
	 IT8N+OTSXO3o4qGe+26afis+z3pOpuxnNrr/O3NRExEIEnIfImgri120DSlhBn9n4X
	 gYFUXbci8jPg3yb5vqS8upwlLJYwUHCkUWdgUczU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.244
Date: Thu, 11 Sep 2025 18:20:48 +0200
Message-ID: <2025091149-atop-bleep-5a24@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.244 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
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
 arch/x86/kernel/cpu/common.c                       |   74 +++--
 arch/x86/kvm/x86.c                                 |    9 
 drivers/base/cpu.c                                 |    6 
 include/linux/cpu.h                                |    1 
 14 files changed, 390 insertions(+), 109 deletions(-)

Greg Kroah-Hartman (1):
      Linux 5.10.244

Pawan Gupta (7):
      Documentation/hw-vuln: Add VMSCAPE documentation
      x86/vmscape: Enumerate VMSCAPE bug
      x86/vmscape: Add conditional IBPB mitigation
      x86/vmscape: Enable the mitigation
      x86/bugs: Move cpu_bugs_smt_update() down
      x86/vmscape: Warn when STIBP is disabled with SMT
      x86/vmscape: Add old Intel CPUs to affected list


