Return-Path: <stable+bounces-107818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EADA03BA9
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 10:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59841885D0D
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE6A1E32D3;
	Tue,  7 Jan 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rBFhj2FV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UHFcH4L4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rBFhj2FV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UHFcH4L4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC819D8A7;
	Tue,  7 Jan 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736243969; cv=none; b=X7E46Kw4CXjkM1kE9chrlckeTFEkENdjQEDNLDD4Gx59XXbisFQS1nYssfpoC5nW3T7f94mKWh+lHqhM0RCFFMk/usz5LRLxMkcG8yw5PVg7kCSL0e5Z1PxWCGOqCZ9vPaBCMP2ZRes5VF17BKWUKwzGXQg6sI2UHRpH57yy72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736243969; c=relaxed/simple;
	bh=K3yiQu3UMMTCUSqXQIEGgdTippoNqGWKJg7o3Jg8YGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScjXFIZ0GmwH8IDTUTwBBpLwxthdYq6I6LPy6NUP6oR4GlISilDfjX9nRMoT7koTo+x7c1RPa+MmhLFveCRGK1zH5uEiigFHVI0XmfdCCKrXSouvUudxZzyRDjachfk9tdLr3lQWVe4uxg6AnBJHNyU5WQ4klMha+knmUsft5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rBFhj2FV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UHFcH4L4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rBFhj2FV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UHFcH4L4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73494210FB;
	Tue,  7 Jan 2025 09:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736243964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PwNdwPJJXI1eGcccxHp4G4DSMu/Ufq1Spn6zfqh2oDY=;
	b=rBFhj2FVeUMZcZynCcl983MNvGk/2bImm+aI2E07VKrXum9sypkwij0KMzcbRnQY2z3ynM
	qulPkINgVUycwAOm6oK3pkiqmOjM418I93Ga0+0Zfh5okVQftLdIe/sPwOJkqRTcY65CyQ
	01WeTVNXWTxxRdcF7X6BJmFcnuKgjH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736243964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PwNdwPJJXI1eGcccxHp4G4DSMu/Ufq1Spn6zfqh2oDY=;
	b=UHFcH4L4ud8kmXmhTh2iWTfk8QVAA1/ypOZh3e6oikk8tLojor7qTmkYXINKI2b0VKr1f3
	4yb4qo98jKl6WDCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736243964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PwNdwPJJXI1eGcccxHp4G4DSMu/Ufq1Spn6zfqh2oDY=;
	b=rBFhj2FVeUMZcZynCcl983MNvGk/2bImm+aI2E07VKrXum9sypkwij0KMzcbRnQY2z3ynM
	qulPkINgVUycwAOm6oK3pkiqmOjM418I93Ga0+0Zfh5okVQftLdIe/sPwOJkqRTcY65CyQ
	01WeTVNXWTxxRdcF7X6BJmFcnuKgjH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736243964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PwNdwPJJXI1eGcccxHp4G4DSMu/Ufq1Spn6zfqh2oDY=;
	b=UHFcH4L4ud8kmXmhTh2iWTfk8QVAA1/ypOZh3e6oikk8tLojor7qTmkYXINKI2b0VKr1f3
	4yb4qo98jKl6WDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E85F13A6A;
	Tue,  7 Jan 2025 09:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZXy1Cfz6fGfIWwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 07 Jan 2025 09:59:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	kernel test robot <lkp@intel.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Helge Deller <deller@gmx.de>,
	stable@vger.kernel.org
Subject: [PATCH] m68k: Fix VGA I/O defines
Date: Tue,  7 Jan 2025 10:58:56 +0100
Message-ID: <20250107095912.130530-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux-m68k.org,vger.kernel.org,suse.de,intel.com,lists.freedesktop.org,gmx.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Level: 

Including m86k's <asm/raw_io.h> in vga.h on nommu platforms results
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

Include <asm/io.h>, which avoid raw_io.h on nommu platforms. Also change
the defined values of some of the read/write symbols in vga.h to
__raw_read/__raw_write as the raw_in/raw_out symbols are not generally
available.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501071629.DNEswlm8-lkp@intel.com/
Fixes: 5c3f968712ce ("m68k/video: Create <asm/vga.h>")
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v3.5+
---
 arch/m68k/include/asm/vga.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/vga.h b/arch/m68k/include/asm/vga.h
index 4742e6bc3ab8..cdd414fa8710 100644
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
-- 
2.47.1


