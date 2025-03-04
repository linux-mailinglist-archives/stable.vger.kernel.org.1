Return-Path: <stable+bounces-120340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48611A4E7E8
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDD717ECD0
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A4228153E;
	Tue,  4 Mar 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TTnOlIyy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA927FE84
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106610; cv=none; b=m2cjbdWq9Kpq2zj7jGQM0yxsFQXZ4tmUDC86cHNgb6gcKtdkuXNdCrleFHFGZmvFnCXFxz2wLAdgcrVh1xQhvATM080ezIEWPtOuHP17an3TAhl6nsZ5ayBkTZiPUwv1F620/Vedl8P9aGSLPl6oibBLyXuTbK0wh2Rk9jmg+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106610; c=relaxed/simple;
	bh=jZQNdcCG09eWajkMcjvYrW24pjUIrfX4TKvcWnaZqqY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PhyB+ARse4rak/yqvvbrm/b47IQ0wfsm6INa8a26wVyMH6iXXJaD6OcAceZTYz3KJS7q2UMOab4ivOn82xnl+W0Cn/I+xv5YOf83+0+FPD9NAAdCrqSd7nHmJH2H+rLZ8LIQJArQLqttAL7IHd5AjgVoTPiScOAG6G2v9pZUIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TTnOlIyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A296C4CEE5;
	Tue,  4 Mar 2025 16:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106610;
	bh=jZQNdcCG09eWajkMcjvYrW24pjUIrfX4TKvcWnaZqqY=;
	h=Subject:To:Cc:From:Date:From;
	b=TTnOlIyyyI6C0igD7IsE8LxdA4yODS0kZaUoYaNb0ij6z2lh19SUofye0DoFyiafc
	 hl79RL/AZYeQQzocHy0rSS8u4lnPEjGjwQigNv7iDtnaDP72b2XRo1iRGd8O7Ct2R2
	 s7K0zX+sr0m5owxAaejucfDPtsOKrOVnPsB4T0jw=
Subject: FAILED: patch "[PATCH] riscv/futex: sign extend compare value in atomic cmpxchg" failed to apply to 5.10-stable tree
To: schwab@suse.de,alexghiti@rivosinc.com,bjorn@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:43:24 +0100
Message-ID: <2025030424-jawed-limes-5ba5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 599c44cd21f4967774e0acf58f734009be4aea9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030424-jawed-limes-5ba5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


