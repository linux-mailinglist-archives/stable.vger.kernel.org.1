Return-Path: <stable+bounces-58282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5F592B457
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA88282118
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4621915575F;
	Tue,  9 Jul 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NAc8rVeA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61D155753;
	Tue,  9 Jul 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518519; cv=none; b=j8kqE67cnHuzghgL1OMxCCAolVDew6i5Ux7PQUGcGuiUjZCndnXS4+7k/3BkJWsBpX39tg9rTVzZwbPV3Hv9Jks4/FPZCkN9f/ch31UTbMHHhnK62w07B8nO1b80823cTED/PxkwcVTNp+ZT3RGdLuJvBwYQlBX5M71RaKDS5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518519; c=relaxed/simple;
	bh=UJMs8jcYaIZObliI6jdNoX2rii7wpxd+kj8H3koJPIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJuF8zeU0NACMpxmjS49ANQbxEJSTRarYfyR/MAMBEGdK9vSqXij8U7K25m/BmghbxqlLgvv0BUx20mBJgdRngNJPD7qEOXY3A76bm0jGv4xjIVqQXAsj7WUpz3xW12QKAUVOIOOA08rcA5TW/FvO7vG6E1Kdj3Nx5itf7v9PS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NAc8rVeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA03C3277B;
	Tue,  9 Jul 2024 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720518518;
	bh=UJMs8jcYaIZObliI6jdNoX2rii7wpxd+kj8H3koJPIc=;
	h=From:To:Cc:Subject:Date:From;
	b=NAc8rVeA5XLSe7+0PWuaXbLfqpGdoYsG6v7IIuFeltB+IbXobu0oGSMc+eioK6Znn
	 G3Dm1vFjpUipJ4j1tmteIiqaGg9Xn2tK3l/GXAAC/sozNC2O58+6hYlc0Hi4GY4UC/
	 W9+4CrePQOkryvi7UEx4FXIlrznFJFJ3PBIFEJss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.38
Date: Tue,  9 Jul 2024 11:48:29 +0200
Message-ID: <2024070944-broiler-unworthy-3b1d@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.38 kernel.

All powerpc and arm64 users of the 6.6 kernel series must upgrade.
Everyone else probably should as well to be safe.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                          |    2 
 arch/arm/net/bpf_jit_32.c         |   25 ++++----
 arch/loongarch/net/bpf_jit.c      |   22 ++-----
 arch/mips/net/bpf_jit_comp.c      |    3 -
 arch/parisc/net/bpf_jit_core.c    |    8 --
 arch/powerpc/net/bpf_jit.h        |   18 ++++--
 arch/powerpc/net/bpf_jit_comp.c   |  110 ++++++++++----------------------------
 arch/powerpc/net/bpf_jit_comp32.c |   13 ++--
 arch/powerpc/net/bpf_jit_comp64.c |   10 +--
 arch/s390/net/bpf_jit_comp.c      |    6 --
 arch/sparc/net/bpf_jit_comp_64.c  |    6 --
 arch/x86/net/bpf_jit_comp32.c     |    3 -
 include/linux/filter.h            |   10 +--
 kernel/bpf/core.c                 |    4 -
 kernel/bpf/verifier.c             |    8 --
 15 files changed, 86 insertions(+), 162 deletions(-)

Greg Kroah-Hartman (5):
      Revert "bpf: Take return from set_memory_rox() into account with bpf_jit_binary_lock_ro()"
      Revert "powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]"
      Revert "powerpc/bpf: rename powerpc64_jit_data to powerpc_jit_data"
      Revert "bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()"
      Linux 6.6.38


