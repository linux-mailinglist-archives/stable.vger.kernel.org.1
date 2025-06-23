Return-Path: <stable+bounces-155831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D76AE43F5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FEB17EA09
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C042561B9;
	Mon, 23 Jun 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qiDR9mRb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2A2561A8;
	Mon, 23 Jun 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685441; cv=none; b=SQAS/5dxeQG/QACbuUjo6qAasHx1obaw8Ckgbbuv8S9GM+tQZOPcQTficdR0DgbD3f7EAw+pCmsMhxhR5bDspfmUA0yJaV6v1gY/BbI9Y9HBW9G75trA17UNX0G3PC4ZWhpmpeiyG3UN/fCzbVV66KYNN36DI282V0TI/3Q9HA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685441; c=relaxed/simple;
	bh=OP6Dt6USB7tKjJNkl23bT0dideAbwq0t3Kt0JvJyHKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6vQ/mjr9gjN3iUzed8uymaT+UhE/VYROJpWI0jQHIHW4hNxy6tBdzBDO62Pol8qWQGp/VJxusuviJFMsvq9bmWemqyX44rFgKfzFcCZ48Nk09eHwlm1mI6Ac+WJe0PKRfXPXjyvHrlXontHuF6qvNiUwRPhJJ2+wgnXlXVWoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qiDR9mRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B63C4CEEA;
	Mon, 23 Jun 2025 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685440;
	bh=OP6Dt6USB7tKjJNkl23bT0dideAbwq0t3Kt0JvJyHKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qiDR9mRbp0MjtF48qfveT8mVjKvpobyWRNxMDNRHsnQGOqjoiQaxOP2/T7Nq7GZ3a
	 68hb02diHNtwR8GqTfSwsW11eThzTEupErBKI2f1UGd+9NErWbrDyZKG54IUGswnAJ
	 HgtFa5T+20NLH+b1okhtp9x4hVsZyWZyJh8Ozr9c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 5.4 120/222] parisc: fix building with gcc-15
Date: Mon, 23 Jun 2025 15:07:35 +0200
Message-ID: <20250623130615.708809214@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 7cbb015e2d3d6f180256cde0c908eab21268e7b9 upstream.

The decompressor is built with the default C dialect, which is now gnu23
on gcc-15, and this clashes with the kernel's bool type definition:

In file included from include/uapi/linux/posix_types.h:5,
                 from arch/parisc/boot/compressed/misc.c:7:
include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
   11 |         false   = 0,

Add the -std=gnu11 argument here, as we do for all other architectures.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/boot/compressed/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -21,6 +21,7 @@ KBUILD_CFLAGS += -fno-PIE -mno-space-reg
 ifndef CONFIG_64BIT
 KBUILD_CFLAGS += -mfast-indirect-calls
 endif
+KBUILD_CFLAGS += -std=gnu11
 
 OBJECTS += $(obj)/head.o $(obj)/real2.o $(obj)/firmware.o $(obj)/misc.o $(obj)/piggy.o
 



