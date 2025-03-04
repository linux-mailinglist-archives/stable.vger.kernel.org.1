Return-Path: <stable+bounces-120337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A8BA4E9B5
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA298E0D97
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FBC28F920;
	Tue,  4 Mar 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nyNPkXsQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960A278142
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106601; cv=none; b=TWzFNARf953T74qbN26n6RqA7fyMV4ckIecC6cXVs95cBV4CMCj5mim0D95NWvGvrwNc4ctZfljTpXihsjlSeXXHff+b5saq8peLfgbbi27OJ4LIh/ymonHxy1qQ63p/JnDzFfAKv7gWTqPWirutRD6llk16xyKur8SREg+O3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106601; c=relaxed/simple;
	bh=M0+wZlshw11ehlq5ntF7DYm5FHzlRub7xtMKJr99yOc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ceaiebBfG44ry7xCCNtgtNwakUQWZbW8R+hmo1kWrzMPJmfcx1lbDW51avDDHLMczzJGJekrza9zBuomD8jO13ErAK/VzCNTYAdK2ESC5aYQU3HuSQA/ZKVp1FCbBVFqFDPYcuWFGuEbaPqsKrw7TUlPstSFuUcqNxR+Ly4snEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nyNPkXsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616A3C4CEE5;
	Tue,  4 Mar 2025 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106601;
	bh=M0+wZlshw11ehlq5ntF7DYm5FHzlRub7xtMKJr99yOc=;
	h=Subject:To:Cc:From:Date:From;
	b=nyNPkXsQMtwZqjEp2Tb7ydO5zArawInkXp3EnpA/6U7hvvHRrPWV/6OA41i7yet+e
	 T7N7nsd8NZVJ7xQuWpFwoaC+DSLuaCDK3koV8c/Ylp51KbHdiWCyGEthB5UYN9LBEW
	 RVgHkkwdaAlw27ipfS/krkFD6+ZyQTcjuv9AUC9Q=
Subject: FAILED: patch "[PATCH] riscv/atomic: Do proper sign extension also for unsigned in" failed to apply to 5.15-stable tree
To: schwab@suse.de,ajones@ventanamicro.com,alexghiti@rivosinc.com,palmer@rivosinc.com,xry111@xry111.site
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:43:09 +0100
Message-ID: <2025030409-squirt-handprint-3e7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1898300abf3508bca152e65b36cce5bf93d7e63e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030409-squirt-handprint-3e7c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1898300abf3508bca152e65b36cce5bf93d7e63e Mon Sep 17 00:00:00 2001
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 30 Jan 2025 10:25:38 +0100
Subject: [PATCH] riscv/atomic: Do proper sign extension also for unsigned in
 arch_cmpxchg

Sign extend also an unsigned compare value to match what lr.w is doing.
Otherwise try_cmpxchg may spuriously return true when used on a u32 value
that has the sign bit set, as it happens often in inode_set_ctime_current.

Do this in three conversion steps.  The first conversion to long is needed
to avoid a -Wpointer-to-int-cast warning when arch_cmpxchg is used with a
pointer type.  Then convert to int and back to long to always sign extend
the 32-bit value to 64-bit.

Fixes: 6c58f25e6938 ("riscv/atomic: Fix sign extension for RV64I")
Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/mvmed0k4prh.fsf@suse.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 4cadc56220fe..427c41dde643 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -231,7 +231,7 @@
 		__arch_cmpxchg(".w", ".w" sc_sfx, ".w" cas_sfx,		\
 			       sc_prepend, sc_append,			\
 			       cas_prepend, cas_append,			\
-			       __ret, __ptr, (long), __old, __new);	\
+			       __ret, __ptr, (long)(int)(long), __old, __new);	\
 		break;							\
 	case 8:								\
 		__arch_cmpxchg(".d", ".d" sc_sfx, ".d" cas_sfx,		\


