Return-Path: <stable+bounces-63270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AB941829
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD601F23F07
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9A18B468;
	Tue, 30 Jul 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="16FxLg+w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E2189516;
	Tue, 30 Jul 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356280; cv=none; b=r8kW7FwbsF2CJMYa+D7ZUWC+zObjbLfLRo2dEN7rvL5UPvHYh70p99MFji9CX8XjUHpPVp776rhlWEnv9fugDIfu438GEYd6t2S4OtMX5Fw7i0mmVndbU/EcwMEk4HSVJjBdzsw9iXpylOUgtHAXCmC4CIk9prEKatGW2yryIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356280; c=relaxed/simple;
	bh=n+ujX1nP6Pp2iUlj5p0GfcXvR1xZRjOfdQ2K5E8mEKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htKLIJGQZmbnWh1iCPWIWMKEVaXOyhDBaJVs2Ihx3U4DT+9ar4frDIuuU87/akcKJy7BJfGpUvGOtoxH/o+6t5R22C8M/9XelcEO/jQTd0V+PxFDqQJzMyMPsiAsaWVBtZ+8KZYTNLHpalR+QF77yana5I3QOr8fAmD+C5UE/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=16FxLg+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B91AC32782;
	Tue, 30 Jul 2024 16:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356279;
	bh=n+ujX1nP6Pp2iUlj5p0GfcXvR1xZRjOfdQ2K5E8mEKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=16FxLg+wtazuELbj3njRKeQBn4yYkLsz5LK+jbQhpYhKfq4AiAPWQqyYgqn2TTVHT
	 cxWgii51pbkp+8vGWhak94AliI6IBWx+50qkYscx0hRfYpiFGoltgCFe48Yi7+6rVU
	 RkQaXJmg1zuVMedtQvxe8GSHMbcb5uHCt4II8zyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Larsson <andreas@gaisler.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 175/440] sparc64: Fix incorrect function signature and add prototype for prom_cif_init
Date: Tue, 30 Jul 2024 17:46:48 +0200
Message-ID: <20240730151622.709437339@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Larsson <andreas@gaisler.com>

[ Upstream commit a6c3ea1ec96307dbfbb2f16d96c674c5cc80f445 ]

Remove the unused cif_stack argument and add a protype in oplib_64.h
Commit ef3e035c3a9b ("sparc64: Fix register corruption in top-most
kernel stack frame during boot.") removed the cif_stack argument to
prom_cif init in the declaration at the caller site and the usage of it
within prom_cif_init, but not in the function signature of the function
itself.

This also fixes the following warning:
arch/sparc/prom/p1275.c:52:6: warning: no previous prototype for ‘prom_cif_init’

Fixes: ef3e035c3a9b ("sparc64: Fix register corruption in top-most kernel stack frame during boot.")
Link: https://lore.kernel.org/r/20240710094155.458731-3-andreas@gaisler.com
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/asm/oplib_64.h | 1 +
 arch/sparc/prom/init_64.c         | 3 ---
 arch/sparc/prom/p1275.c           | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index a67abebd43592..1b86d02a84556 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -247,6 +247,7 @@ void prom_sun4v_guest_soft_state(void);
 int prom_ihandle2path(int handle, char *buffer, int bufsize);
 
 /* Client interface level routines. */
+void prom_cif_init(void *cif_handler);
 void p1275_cmd_direct(unsigned long *);
 
 #endif /* !(__SPARC64_OPLIB_H) */
diff --git a/arch/sparc/prom/init_64.c b/arch/sparc/prom/init_64.c
index 103aa91043185..f7b8a1a865b8f 100644
--- a/arch/sparc/prom/init_64.c
+++ b/arch/sparc/prom/init_64.c
@@ -26,9 +26,6 @@ phandle prom_chosen_node;
  * routines in the prom library.
  * It gets passed the pointer to the PROM vector.
  */
-
-extern void prom_cif_init(void *);
-
 void __init prom_init(void *cif_handler)
 {
 	phandle node;
diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
index 889aa602f8d86..51c3f984bbf72 100644
--- a/arch/sparc/prom/p1275.c
+++ b/arch/sparc/prom/p1275.c
@@ -49,7 +49,7 @@ void p1275_cmd_direct(unsigned long *args)
 	local_irq_restore(flags);
 }
 
-void prom_cif_init(void *cif_handler, void *cif_stack)
+void prom_cif_init(void *cif_handler)
 {
 	p1275buf.prom_cif_handler = (void (*)(long *))cif_handler;
 }
-- 
2.43.0




