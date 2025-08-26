Return-Path: <stable+bounces-174587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6ECB363D3
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B405D1BC7C55
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873F13FD86;
	Tue, 26 Aug 2025 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wBZLtyNn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B85AD4B;
	Tue, 26 Aug 2025 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214787; cv=none; b=eiJWQ/9zs2yb/XMOtDBcHYOEWsR7V/DqDHLFTBp4pKUYwb7xQmvqOJtzjKhQe5T7wCC2c9ojkVvl1rTIOGB45paxmBG4twpLdq5VAgueuf5xhoKBaUVVf9dtPlM604PqKVlYq+h91lhmi2V/NHN9imh5vsgwZg4+DUobN6/HWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214787; c=relaxed/simple;
	bh=F0m7+a4xBFY0GwzHIvtJ0O/Sv6Q77yHkGtfEoJPCCNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIHKGEw+FYWsWNxlJ2JGnGy4o7dVkUPRkNh9OybhQI7kK063X5Nv1r+WoKqYqwalZru8MzYXgZNnla4wCSMvzXN+3/UHjSxY5O4mrNmfzj1QPdolukvmCS2KUX3TcgUjDN1A4vBKXf5N+LuTNBm1ZE0MCVVItM9BfeUS9czzLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wBZLtyNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BFEC4CEF1;
	Tue, 26 Aug 2025 13:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214787;
	bh=F0m7+a4xBFY0GwzHIvtJ0O/Sv6Q77yHkGtfEoJPCCNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wBZLtyNn+SneHv0VYtJGCBInROJTaECMvEMqYqjE0GteEs6qZmbA20mNT0Vu8D/7T
	 Shhd4pbNyFGT0BdpMCfUJ4bfVpXtEJyNs9vIcaHqn3hJfhOEnrOdqkLF7CBkRoVxXn
	 Wg5KQKqMnZNFoljiNDFdiTOiajWqDYDCKGdiSIKo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Finn Thain <fthain@linux-m68k.org>,
	Stan Johnson <userm57@yahoo.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 6.1 269/482] m68k: Fix lost column on framebuffer debug console
Date: Tue, 26 Aug 2025 13:08:42 +0200
Message-ID: <20250826110937.411568717@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@linux-m68k.org>

commit 210a1ce8ed4391b64a888b3fb4b5611a13f5ccc7 upstream.

Move the cursor position rightward after rendering the character,
not before. This avoids complications that arise when the recursive
console_putc call has to wrap the line and/or scroll the display.
This also fixes the linewrap bug that crops off the rightmost column.

When the cursor is at the bottom of the display, a linefeed will not
move the cursor position further downward. Instead, the display scrolls
upward. Avoid the repeated add/subtract sequence by way of a single
subtraction at the initialization of console_struct_num_rows.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/9d4e8c68a456d5f2bc254ac6f87a472d066ebd5e.1743115195.git.fthain@linux-m68k.org
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/m68k/kernel/head.S |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -3404,6 +3404,7 @@ L(console_clear_loop):
 
 	movel	%d4,%d1				/* screen height in pixels */
 	divul	%a0@(FONT_DESC_HEIGHT),%d1	/* d1 = max num rows */
+	subql	#1,%d1				/* row range is 0 to num - 1 */
 
 	movel	%d0,%a2@(Lconsole_struct_num_columns)
 	movel	%d1,%a2@(Lconsole_struct_num_rows)
@@ -3550,15 +3551,14 @@ func_start	console_putc,%a0/%a1/%d0-%d7
 	cmpib	#10,%d7
 	jne	L(console_not_lf)
 	movel	%a0@(Lconsole_struct_cur_row),%d0
-	addil	#1,%d0
-	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	movel	%a0@(Lconsole_struct_num_rows),%d1
 	cmpl	%d1,%d0
 	jcs	1f
-	subil	#1,%d0
-	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	console_scroll
+	jra	L(console_exit)
 1:
+	addql	#1,%d0
+	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	jra	L(console_exit)
 
 L(console_not_lf):
@@ -3585,12 +3585,6 @@ L(console_not_cr):
  */
 L(console_not_home):
 	movel	%a0@(Lconsole_struct_cur_column),%d0
-	addql	#1,%a0@(Lconsole_struct_cur_column)
-	movel	%a0@(Lconsole_struct_num_columns),%d1
-	cmpl	%d1,%d0
-	jcs	1f
-	console_putc	#'\n'	/* recursion is OK! */
-1:
 	movel	%a0@(Lconsole_struct_cur_row),%d1
 
 	/*
@@ -3637,6 +3631,23 @@ L(console_do_font_scanline):
 	addq	#1,%d1
 	dbra	%d7,L(console_read_char_scanline)
 
+	/*
+	 *	Register usage in the code below:
+	 *	a0 = pointer to console globals
+	 *	d0 = cursor column
+	 *	d1 = cursor column limit
+	 */
+
+	lea	%pc@(L(console_globals)),%a0
+
+	movel	%a0@(Lconsole_struct_cur_column),%d0
+	addql	#1,%d0
+	movel	%d0,%a0@(Lconsole_struct_cur_column)	/* Update cursor pos */
+	movel	%a0@(Lconsole_struct_num_columns),%d1
+	cmpl	%d1,%d0
+	jcs	L(console_exit)
+	console_putc	#'\n'		/* Line wrap using tail recursion */
+
 L(console_exit):
 func_return	console_putc
 



