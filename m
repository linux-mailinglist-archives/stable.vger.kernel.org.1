Return-Path: <stable+bounces-120341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30CCA4E7AC
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E037AB19D
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2382128F93E;
	Tue,  4 Mar 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QA/JWmAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65227FE84
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106614; cv=none; b=TUDkS+cNdy5YXXJjbg/cVV7KKPD6GzoL1Ss1I8RaJNdGKAoeuXYpGq+/75crl3mirMCNjL3kO4676FjX1ew9cmW2aH4X0gvMwTXpbeeD7C3mGBinNd/7+hArW4sJOf7naEf3Y6po4GiZsc7GG28LtnTqlc+souXouwdlxrHph8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106614; c=relaxed/simple;
	bh=vogyElmiX/IPgIWLm4nDKQZJ18YNcWFNk1feI7eCo6I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pAVfk52LwWFP48tcmorQlht0SFXPBj2sYaC6LdscajSZU2/bqtTBFVwQXzgnenfqUTNJcCcb36rVJpzcolAayK1GntagIe+u73hqGVuagbo4+R102iDGvI8vNmnYDfYESgPmV50IL8Bt99ORkthK+6vxzM5PmbqgxzuY09wLPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QA/JWmAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56993C4CEE7;
	Tue,  4 Mar 2025 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106614;
	bh=vogyElmiX/IPgIWLm4nDKQZJ18YNcWFNk1feI7eCo6I=;
	h=Subject:To:Cc:From:Date:From;
	b=QA/JWmAsWZ1z9K++Pco2p781pNSGi1KsRELSgimcW7vA8JSENwwr5OIm06nwBmw/U
	 a5S4c3eUQztVKqFBqLhw25FLBGN7zXg0Opa4bm7HATE4529CtY5sZafJA7oSNDnzpj
	 UeleT1TJwxmrCMee/TNLLJ1wouKYL7rVtBV0GvlY=
Subject: FAILED: patch "[PATCH] riscv/futex: sign extend compare value in atomic cmpxchg" failed to apply to 5.4-stable tree
To: schwab@suse.de,alexghiti@rivosinc.com,bjorn@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:43:25 +0100
Message-ID: <2025030425-shifty-dipper-3fc6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 599c44cd21f4967774e0acf58f734009be4aea9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030425-shifty-dipper-3fc6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


