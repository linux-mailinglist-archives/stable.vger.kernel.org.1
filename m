Return-Path: <stable+bounces-158838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A87AECC99
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 14:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037A77A35BF
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2466343169;
	Sun, 29 Jun 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EK5bzKb/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C76FBF
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201062; cv=none; b=mgtccqP8izhjMEAhpNlcbQetIbItlKIiRE6LhTfLGyDsHXFTvZJUbRQumTiDIOwmLQ47DnZjC7ioLRlN6Leuq4MqOPuenkacOiaHX8j2aDmtYTEwXx7gG7EqVr/W4S4apgw/I/FLc9wznDzk3PgW9uWtO6LrkCyek8sRTkxYcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201062; c=relaxed/simple;
	bh=PB1GO++ikNoi8nG+XH3/dLG5vuuZVF8d1HoCtMYwVII=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A5dteg+Zt34fS+Il77ey6Cd4EXJZ1g8AstWo0dxAa69za2eM6ryR/+TWXk5hLrxvort2YKSBIK9DfROGPQ9L2iWiIWaDXBblSKy7mLYfHpOniVJjSFRuNn5eA/YMwOkAtq2rdI5t+6pbBTD3yJEL/Zmwmy4wJ6FPdkqustgDryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EK5bzKb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F06C4CEEB;
	Sun, 29 Jun 2025 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751201062;
	bh=PB1GO++ikNoi8nG+XH3/dLG5vuuZVF8d1HoCtMYwVII=;
	h=Subject:To:Cc:From:Date:From;
	b=EK5bzKb/s6MuFISK1OzjD2Bfi97m9CHgsJ3HOaMH4vYUBTH/Q22Rq7asKKbJqSmZ7
	 SNJxaPGB67tKiWG5hPfyIyz26Q9QOb7aRdXVo3U0I7F4yuN2NlYzzrmC7B5whbMAJY
	 Ug785wzkUxFxeu5E+ENrGo14pRqaqqplUNkjM3gQ=
Subject: FAILED: patch "[PATCH] s390/ptrace: Fix pointer dereferencing in" failed to apply to 6.15-stable tree
To: hca@linux.ibm.com,agordeev@linux.ibm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Jun 2025 14:41:28 +0200
Message-ID: <2025062928-revival-saint-3ba2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7f8073cfb04a97842fe891ca50dad60afd1e3121
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062928-revival-saint-3ba2@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f8073cfb04a97842fe891ca50dad60afd1e3121 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Fri, 13 Jun 2025 17:53:04 +0200
Subject: [PATCH] s390/ptrace: Fix pointer dereferencing in
 regs_get_kernel_stack_nth()

The recent change which added READ_ONCE_NOCHECK() to read the nth entry
from the kernel stack incorrectly dropped dereferencing of the stack
pointer in order to read the requested entry.

In result the address of the entry is returned instead of its content.

Dereference the pointer again to fix this.

Reported-by: Will Deacon <will@kernel.org>
Closes: https://lore.kernel.org/r/20250612163331.GA13384@willie-the-truck
Fixes: d93a855c31b7 ("s390/ptrace: Avoid KASAN false positives in regs_get_kernel_stack_nth()")
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 62c0ab4a4b9d..0905fa99a31e 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -265,7 +265,7 @@ static __always_inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *r
 	addr = kernel_stack_pointer(regs) + n * sizeof(long);
 	if (!regs_within_kernel_stack(regs, addr))
 		return 0;
-	return READ_ONCE_NOCHECK(addr);
+	return READ_ONCE_NOCHECK(*(unsigned long *)addr);
 }
 
 /**


