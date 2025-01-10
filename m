Return-Path: <stable+bounces-108192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55966A0924F
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 14:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A03D188E394
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654C20E717;
	Fri, 10 Jan 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="In32NS8s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7120E6FE;
	Fri, 10 Jan 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516584; cv=none; b=ToyzaeXr5QVhU7uneRPTJ/k8F3AAfWzGnwo0v5cF0PLHLmqwIdhvQ2LrPyH/3pGb6syVWiYE78epURJ0Wmqay+Za75USvfTrTmDN2+/yKE9WhRARNFBL8L7Ecy2N7jws8cN2nJYvwM5u2bVDGJWsqavdX3gYA8qDmAwmY8HOvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516584; c=relaxed/simple;
	bh=thy2tWcbtGicKxu3OxbCfy5/WhfC8gpSULc8E/1Yznw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDnHp7Twf3D1J2mnFUmMITVI08hReylZDcgZv8jWnG/lVEs1OWtBs4BAx3E8otUUPHEMjoVZ6UzHNnUPiK85bLCI7CYnDzuY/nFUn5uAj9tQYx8N5QPoIuj/yC3ps/q0+8+3PgfHNa84It/5fTO99UxSW9qVQR3zpJf6ox5DQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=In32NS8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B94C4CED6;
	Fri, 10 Jan 2025 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736516583;
	bh=thy2tWcbtGicKxu3OxbCfy5/WhfC8gpSULc8E/1Yznw=;
	h=From:To:Cc:Subject:Date:From;
	b=In32NS8shxu5LnDpZT7CwT4Aad9siCHB0QLyMKEDEIi0TSx5Mitbp7rCiganA8Lp8
	 b4FYSfIP9C3035Kt6/2/P9tdS8dXJFTS6Ncl45Mrbynk8JygGOwHBWM5QdrUsVMzeR
	 AS5O0SSbOI7aawy5jTzTC6veNm8YpduOT42D6mvA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.71
Date: Fri, 10 Jan 2025 14:42:52 +0100
Message-ID: <2025011030-glass-dainty-efee@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.71 kernel.

It's only needed if you could not properly build 6.6.70 as there is a
configuration that is pretty common that would fail to build properly.
That is now resolved.  If you did not have a problem building 6.6.70, no
need to upgrade at this point in time.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                           |    2 +-
 arch/x86/kernel/Makefile           |    4 ++--
 arch/x86/kernel/cpu/mshyperv.c     |   10 ++--------
 arch/x86/kernel/kexec-bzimage64.c  |    4 ----
 arch/x86/kernel/kvm.c              |    4 ++--
 arch/x86/kernel/machine_kexec_64.c |    3 ---
 arch/x86/kernel/reboot.c           |    4 ++--
 arch/x86/kernel/setup.c            |    2 +-
 arch/x86/kernel/smp.c              |    2 +-
 arch/x86/xen/enlighten_hvm.c       |    4 ----
 arch/x86/xen/mmu_pv.c              |    2 +-
 11 files changed, 12 insertions(+), 29 deletions(-)

Greg Kroah-Hartman (3):
      Revert "x86/hyperv: Fix hv tsc page based sched_clock for hibernation"
      Revert "x86, crash: wrap crash dumping code into crash related ifdefs"
      Linux 6.6.71

Naman Jain (1):
      x86/hyperv: Fix hv tsc page based sched_clock for hibernation


