Return-Path: <stable+bounces-115288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C7BA342C8
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6228516BE19
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D4A242926;
	Thu, 13 Feb 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ap6WYbK/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91B14B95A;
	Thu, 13 Feb 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457535; cv=none; b=cvzug2skn9DwDlMle/MHHnMR4b6LvCT0FuOuePmm+aBc4k/2xU0MdEcM+mWjCydbqplngzvEZAN5cC9ixFkIB7OMRmXr82V46ACavGMSouubfKuvvJftoSKdFdNyf1+x3hDGrBXbR4kEpwM3kEbDi+sFt04Ae2+QjheafTLI+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457535; c=relaxed/simple;
	bh=WY/i989U0hs/MJB1fntLsREdJlrSX0W6s5TjWclDq1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qc95p6PdXjKNQ7umAKaK4lVH2czbjTCDJAbW9/aAwcMg1T746ITvKXSv35QR9DI0W9C8NakZBhIl4YS5ibyQp1kiLuPoemBmWYT1luHJRVRggx0idfe5/ea9QHyghc9AX/L75oUOQgPkxzzy7NnwYN9YAl7W2OLywkAuIU4uvLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ap6WYbK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CAAC4CED1;
	Thu, 13 Feb 2025 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739457535;
	bh=WY/i989U0hs/MJB1fntLsREdJlrSX0W6s5TjWclDq1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ap6WYbK/TGk6P8RFED3owRPtshnbdMqmZH4KUeLwsh/tv5h/6L0yk753aJNyHsMyN
	 51AoF+yRzr42pRMOoMjZpA9VPcKt9M1J+sPEixOhTRIprr28sEtnIDx24LcIE/WTo9
	 ZJd8T0TyzgRQzTbGW1FCJJGstfJ9W4RpC9AqiOmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	kernel test robot <lkp@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.12 140/422] m68k: vga: Fix I/O defines
Date: Thu, 13 Feb 2025 15:24:49 +0100
Message-ID: <20250213142441.949277766@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 53036937a101b5faeaf98e7438555fa854a1a844 upstream.

Including m68k's <asm/raw_io.h> in vga.h on nommu platforms results
in conflicting defines with io_no.h for various I/O macros from the
__raw_read and __raw_write families. An example error is

   In file included from arch/m68k/include/asm/vga.h:12,
                 from include/video/vga.h:22,
                 from include/linux/vgaarb.h:34,
		 from drivers/video/aperture.c:12:
>> arch/m68k/include/asm/raw_io.h:39: warning: "__raw_readb" redefined
      39 | #define __raw_readb in_8
	 |
   In file included from arch/m68k/include/asm/io.h:6,
		    from include/linux/io.h:13,
		    from include/linux/irq.h:20,
		    from include/asm-generic/hardirq.h:17,
		    from ./arch/m68k/include/generated/asm/hardirq.h:1,
		    from include/linux/hardirq.h:11,
		    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
		    from include/linux/ftrace.h:10,
		    from include/linux/kprobes.h:28,
		    from include/linux/kgdb.h:19,
		    from include/linux/fb.h:6,
		    from drivers/video/aperture.c:5:
   arch/m68k/include/asm/io_no.h:16: note: this is the location of the previous definition
      16 | #define __raw_readb(addr) \
	 |

Include <asm/io.h>, which avoids raw_io.h on nommu platforms.
Also change the defined values of some of the read/write symbols in
vga.h to __raw_read/__raw_write as the raw_in/raw_out symbols are not
generally available.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501071629.DNEswlm8-lkp@intel.com/
Fixes: 5c3f968712ce ("m68k/video: Create <asm/vga.h>")
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v3.5+
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/20250107095912.130530-1-tzimmermann@suse.de
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/m68k/include/asm/vga.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/m68k/include/asm/vga.h
+++ b/arch/m68k/include/asm/vga.h
@@ -9,7 +9,7 @@
  */
 #ifndef CONFIG_PCI
 
-#include <asm/raw_io.h>
+#include <asm/io.h>
 #include <asm/kmap.h>
 
 /*
@@ -29,9 +29,9 @@
 #define inw_p(port)		0
 #define outb_p(port, val)	do { } while (0)
 #define outw(port, val)		do { } while (0)
-#define readb			raw_inb
-#define writeb			raw_outb
-#define writew			raw_outw
+#define readb			__raw_readb
+#define writeb			__raw_writeb
+#define writew			__raw_writew
 
 #endif /* CONFIG_PCI */
 #endif /* _ASM_M68K_VGA_H */



