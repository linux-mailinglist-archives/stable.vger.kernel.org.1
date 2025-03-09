Return-Path: <stable+bounces-121556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A382AA58299
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C654188D9EF
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F81D19DF99;
	Sun,  9 Mar 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZH6VQHkB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF219259F;
	Sun,  9 Mar 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511891; cv=none; b=oVoOPm/3YOHU6dNnfBVUD1/sNJSO+uCf7mmK+Y5zqwKIpDQE99dbv+nzmSroNFqlzk7OcfiwdDbHMgXpsBqrZ5Fk6aB4iaNepNNBkqGlI1cXN/ihdT63Hh9gHO75PACnoeRPqsQsSejsZ6LQbEsDd15PBeHO2i97SyBRzcYAgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511891; c=relaxed/simple;
	bh=Q77QRDZ4Pd4QE01w+F0Lno/svSsw0zVKxGGmOk7nNEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6sjki2e5CCSR0USMneSohGKb6E53W8izcnJ8JGH1JbHcO1qOrf4Y3QU83chaAHR6LSL7j7o5649RWiPNaO/phhzZsmINyqco1sYqL9VT9OqKMILY+4mb69dEpfllIFtKU8KdetzfkoojSpIlKWs3CzewKyW20JAGsRrKvzcdYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZH6VQHkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53712C4CEE5;
	Sun,  9 Mar 2025 09:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741511890;
	bh=Q77QRDZ4Pd4QE01w+F0Lno/svSsw0zVKxGGmOk7nNEM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZH6VQHkBTf2q7eFdtwEVhErqjfXu1RWSNfDqLvuls/YfmAiEiErXygpCCnCwfJMVl
	 CUfGM1iQ/TwWhSdHUxsrRGzylfbX5CJuM+1ha1WnCbpB1uEnLq9OjgJUWe+wGLRXGb
	 reNHimbZm/TvVdZD472xUl2iZQxu0LvyLvH+GLaU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.82
Date: Sun,  9 Mar 2025 10:16:52 +0100
Message-ID: <2025030919-hurdle-tapestry-5b79@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.82 kernel.

All i386 users of the 6.6 kernel series must upgrade (as they skipped
the last release.)  All other arches can skip this one as it should not
affect them.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                         |    2 
 arch/x86/Kconfig                 |    4 +
 arch/x86/include/asm/microcode.h |    2 
 arch/x86/include/asm/setup.h     |    1 
 arch/x86/kernel/Makefile         |    1 
 arch/x86/kernel/head32.c         |  117 ++++++++++++++++++++++++++++-----------
 6 files changed, 93 insertions(+), 34 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.6.82

Thomas Gleixner (6):
      x86/boot/32: Disable stackprotector and tracing for mk_early_pgtbl_32()
      x86/boot: Use __pa_nodebug() in mk_early_pgtbl_32()
      x86/boot/32: De-uglify the 2/3 level paging difference in mk_early_pgtbl_32()
      x86/boot/32: Restructure mk_early_pgtbl_32()
      x86/microcode: Provide CONFIG_MICROCODE_INITRD32
      x86/boot/32: Temporarily map initrd for microcode loading


