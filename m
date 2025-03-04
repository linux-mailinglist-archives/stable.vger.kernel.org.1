Return-Path: <stable+bounces-120333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F0A4E7EF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BA41883527
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1149D28151A;
	Tue,  4 Mar 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0OZ/PZ9x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A228D071
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106590; cv=none; b=l/nyoLxb4B0/7tNZzOVj+6TRwyLdZFF4/+J5rUOub7TnHKyw7sNFJc1jY3pTg429vEMnEhv/4iKpQfsxrkYdrwFN9Ly1O/vd5tNLd4SxMGGwYqNS5/IbyLh9sWK+RyKG86pileaibO3vlEVvtziw3+Y9oDZglF7rlBxzbV8P6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106590; c=relaxed/simple;
	bh=zjwZpKFTHmp9Uw0Y9bO8Y0RwQ14VGsUNDV2jq5RNK+Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cqkjzWOMfZQJ8j+eK/WZHStRbio6IYs1AJYiA/VGwWI111N5mMj+baK7E9S1LgmIhRMgLfJZFpP6SrqH6U/UC03M94a/dGGTwo3MEW/zI2945wmCxrIpk7eAulR9lL9/K373McMpbQUJ1QdP5SZkBlicxw4qzp1bpwtLulkRX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0OZ/PZ9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC32C4CEE5;
	Tue,  4 Mar 2025 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106590;
	bh=zjwZpKFTHmp9Uw0Y9bO8Y0RwQ14VGsUNDV2jq5RNK+Y=;
	h=Subject:To:Cc:From:Date:From;
	b=0OZ/PZ9x7kLZFmQns9KgaLYpqvfN60zoxTnravxeRCBzLsUMw3KWOEEn8iJSyehcO
	 J8PPA8CFtRyGJsTLBN33VP3AyikKDFu0hgaxvEaF+7dFZECBWHn8oT93ujRjUEFlDS
	 m4LGV2B7+7nu7SqIn1ysV+7LwYXe6MjkEWwKPMqE=
Subject: FAILED: patch "[PATCH] riscv/atomic: Do proper sign extension also for unsigned in" failed to apply to 6.12-stable tree
To: schwab@suse.de,ajones@ventanamicro.com,alexghiti@rivosinc.com,palmer@rivosinc.com,xry111@xry111.site
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:43:07 +0100
Message-ID: <2025030407-tiny-slain-3c45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1898300abf3508bca152e65b36cce5bf93d7e63e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030407-tiny-slain-3c45@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


