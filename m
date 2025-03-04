Return-Path: <stable+bounces-120339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E86A4E7E2
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734C219C4C7D
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A1C27FE65;
	Tue,  4 Mar 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6K1mDuq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268328153E
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106607; cv=none; b=MCMa2KsI9qD/PbD3LPVCokCuhInjMDiQuCWT2b83sxcWfvaHrL69nykwqu/vPjyLT2XqkWerMzg3DXx00Hwkrs6sSAMDJV31LimGX3ec6owkJy16EGwrK9WouyyaNOypQ/eGhHE5RI8j3bPy7GNDYd8xh8SNvCHFbSwQS9E/JvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106607; c=relaxed/simple;
	bh=bOURz20pEfyPc15+igJIAQAgUgJblBBggYYUKE3kVeE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Vy78yoOnXWyjVPKQiVZiJqTfqFuKCEJnuNkdB1JvEQNERm8lVLv7uFt5COm36KvRaNdX8bVyqHk3Hm8TqiYBpR0NF/VJafPiXy3oB9+sacxeZOoxOoZjdw3xIHj5WHLTRQae/4iciME9Eo1Votzy8Jab8tff/86qUf2tO3ybNPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6K1mDuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3852FC4CEE7;
	Tue,  4 Mar 2025 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106607;
	bh=bOURz20pEfyPc15+igJIAQAgUgJblBBggYYUKE3kVeE=;
	h=Subject:To:Cc:From:Date:From;
	b=R6K1mDuqcNuwSF6MBrogi0cSRkpCAJR9U2iYsJ7Cbf8m8wEkaNDEbf3euamwOFZER
	 VwBlzvp6Wv5kL8FJ69ZumHxk7FPIJW14PBUBjDLZZtcF6R+xx9IMmp2cZDDSN/l5Z3
	 UM0N3VAqPW4moQugip9rrOWzyKfmrLE8FqtNPoYQ=
Subject: FAILED: patch "[PATCH] riscv/futex: sign extend compare value in atomic cmpxchg" failed to apply to 5.15-stable tree
To: schwab@suse.de,alexghiti@rivosinc.com,bjorn@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:43:19 +0100
Message-ID: <2025030419-satin-cogwheel-ae89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 599c44cd21f4967774e0acf58f734009be4aea9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030419-satin-cogwheel-ae89@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 599c44cd21f4967774e0acf58f734009be4aea9a Mon Sep 17 00:00:00 2001
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 3 Feb 2025 11:06:00 +0100
Subject: [PATCH] riscv/futex: sign extend compare value in atomic cmpxchg
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make sure the compare value in the lr/sc loop is sign extended to match
what lr.w does.  Fortunately, due to the compiler keeping the register
contents sign extended anyway the lack of the explicit extension didn't
result in wrong code so far, but this cannot be relied upon.

Fixes: b90edb33010b ("RISC-V: Add futex support.")
Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/mvmfrkv2vhz.fsf@suse.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index 72be100afa23..90c86b115e00 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -93,7 +93,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %[r])	\
 		_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %[r])	\
 	: [r] "+r" (ret), [v] "=&r" (val), [u] "+m" (*uaddr), [t] "=&r" (tmp)
-	: [ov] "Jr" (oldval), [nv] "Jr" (newval)
+	: [ov] "Jr" ((long)(int)oldval), [nv] "Jr" (newval)
 	: "memory");
 	__disable_user_access();
 


