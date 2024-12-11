Return-Path: <stable+bounces-100634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346A9ECF98
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735D6169CC9
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE0D1A0B04;
	Wed, 11 Dec 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BrUgsy/P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA625246356;
	Wed, 11 Dec 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930639; cv=none; b=Ez1Ojz4xm/0tS7RhOPqVjw+HYoqrpefBLVN8iLfybWIyuL/YhkNN3hDrW69C8bFvc6CYtQHqmScPwyD2Vsu7GVcRJw3bdhlNMYNLF+I7fOdf596nnR9Z1ofd2ipO+Cg6YKWfjcWS9L4l7PPZFt19Ty4k3ic1TIpfolVBXp9RYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930639; c=relaxed/simple;
	bh=8GbsKEYc5b4GxDsk9hk4mhOvY1y4D8x35K+YD3gW3e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cz/J/VYycnwUt0T+dXRRiARy0VgNkyIg+56e6jpr2Ofb6egHs9pBhsLAm2LWGE5w2xvLAxJAdVNHuythutqdYRqEUNVwQibDvKU2ijbWlDtX0zuvb0sRwLjyLpVwrMGYf8U/nB6RYLIk3eO80pX8YDBQLrH2OD/ELrZgyQvU9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BrUgsy/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4E2C4CED2;
	Wed, 11 Dec 2024 15:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733930638;
	bh=8GbsKEYc5b4GxDsk9hk4mhOvY1y4D8x35K+YD3gW3e8=;
	h=From:To:Cc:Subject:Date:From;
	b=BrUgsy/PF3BFfoUnCvUxd4rqDeNzG5yoSbFz6x5mKgcEVaIglZTR3aQIRViw3Pfw9
	 DWODuEv/iHXIwHP2/KuEC51+ZzXsYzGRxBiLKXrrRE5CetGyXtNFDbGipVufR1pWV9
	 UJaN3+9V+z4jEUNoIn7oFj6CWqkK+KSWUOPCmPZ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.65
Date: Wed, 11 Dec 2024 16:23:52 +0100
Message-ID: <2024121108-embroider-theology-0e46@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.65 kernel.

This release only fixes a build regression for openrisc, and a runtime
regression for domU guests.  If you don't have problems with them, no
need to upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                           |    2 +-
 arch/openrisc/include/asm/fixmap.h |   31 +------------------------------
 arch/x86/platform/pvh/head.S       |   22 +---------------------
 3 files changed, 3 insertions(+), 52 deletions(-)

Dawei Li (1):
      openrisc: Use asm-generic's version of fix_to_virt() & virt_to_fix()

Greg Kroah-Hartman (3):
      Revert "x86/pvh: Call C code via the kernel virtual mapping"
      Revert "x86/pvh: Set phys_base when calling xen_prepare_pvh()"
      Linux 6.6.65


