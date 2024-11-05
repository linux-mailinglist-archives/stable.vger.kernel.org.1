Return-Path: <stable+bounces-89870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59AB9BD256
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035F21C21CF3
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9CA1D86C0;
	Tue,  5 Nov 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TblMTMAc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10949178383
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824203; cv=none; b=Spq/p37sybUfyJrzyCGaCZd4wmE5EJ88hleKw2kJD/iAhXbDz76S91JUw55xFSurY6nBT+MdbKE7mF1cOh4lW88hTZjqVRyhBQjd71GU6awjePEdJTfyjPbZY8rQf8j8bm/FXn8yCxgon7M+68M1kWCFnbI6+4BQJEgTuxCvxJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824203; c=relaxed/simple;
	bh=wXxtlkccCV2fjc3JvjDdnRXoBN9Ek+twIQyr83yZKaw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aWBiZmi4pH1uV/7agKPvkZtYnDky2JUsD22NV/x9vio0xhwWCOU7uAD4B8wWZzeG/g037zgSAnxGddifAl9DVlzALl5ygaAGEvApgr1g7SsmgLE+RHDnQ0jgNq6QJHEKzFS9iUxouQnYWbO6Z/wx30J3s4ieUWCYuxTW1NaG9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TblMTMAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E411C4CECF;
	Tue,  5 Nov 2024 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730824202;
	bh=wXxtlkccCV2fjc3JvjDdnRXoBN9Ek+twIQyr83yZKaw=;
	h=Subject:To:Cc:From:Date:From;
	b=TblMTMAcH5grPzayFHnM5xhkEPdms0KNGt0gLDP14MTneHrIt1TDg2ZGrrzcn0t1l
	 IMuM95mWZgj2K9H1DX7KpMtxRnyGu7qeNE0u4q4Sh0XPb0WyLWyhxKDzEeJV9hLfFg
	 rOi84rB3WMoXCe6/BlYfDlAxM9t8KpCI6ZsdePpc=
Subject: WTF: patch "[PATCH] riscv: Remove duplicated GET_RM" was seriously submitted to be applied to the 6.11-stable tree?
To: zhangchunyan@iscas.ac.cn,alexghiti@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:29:42 +0100
Message-ID: <2024110542-irregular-oppressor-7d11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit

The patch below was submitted to be applied to the 6.11-stable tree.

I fail to see how this patch meets the stable kernel rules as found at
Documentation/process/stable-kernel-rules.rst.

I could be totally wrong, and if so, please respond to 
<stable@vger.kernel.org> and let me know why this patch should be
applied.  Otherwise, it is now dropped from my patch queues, never to be
seen again.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 164f66de6bb6ef454893f193c898dc8f1da6d18b Mon Sep 17 00:00:00 2001
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Date: Tue, 8 Oct 2024 17:41:39 +0800
Subject: [PATCH] riscv: Remove duplicated GET_RM

The macro GET_RM defined twice in this file, one can be removed.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Fixes: 956d705dd279 ("riscv: Unaligned load/store handling for M_MODE")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20241008094141.549248-3-zhangchunyan@iscas.ac.cn
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index d4fd8af7aaf5..1b9867136b61 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -136,8 +136,6 @@
 #define REG_PTR(insn, pos, regs)	\
 	(ulong *)((ulong)(regs) + REG_OFFSET(insn, pos))
 
-#define GET_RM(insn)			(((insn) >> 12) & 7)
-
 #define GET_RS1(insn, regs)		(*REG_PTR(insn, SH_RS1, regs))
 #define GET_RS2(insn, regs)		(*REG_PTR(insn, SH_RS2, regs))
 #define GET_RS1S(insn, regs)		(*REG_PTR(RVC_RS1S(insn), 0, regs))


