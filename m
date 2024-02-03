Return-Path: <stable+bounces-17997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B88480F5
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26401B274CD
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F9D1B59F;
	Sat,  3 Feb 2024 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ogJVO1NU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84444FC03;
	Sat,  3 Feb 2024 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933471; cv=none; b=aGjzhDuZykrzhpM39d59g+vC3XQONZrvzjj3gW9bch8Mj+JOtQq0O4g3jw60VavLEvVOgZ9YoSiuEVybXgb6FMcKPnLKNganHXlCXpWVbFbPw31C1JPYmDmyilgAVwtGaYXjOseywnzzn/0bDjeYA4yMlShMCuWIFix48Q+JiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933471; c=relaxed/simple;
	bh=E6NosFwnfH7sOxKZumdlbXyucwJBu0XhNH4w30VTS9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1E3NChdDEkFHKNjJ1Jg+xZDUaxTYKwMdX0LQahb81dFeZhRlj89boxTow2KY8Hy5KsTRydLjqSmkCpX+R6DdfNGQpr/+Z64DgzsgUJeL6Rf8gQuGtJipLp5J7dyctgpBfdPReIhcL8HsdUmJAG8oBm0vvPvYS0xyE5P4/NJzvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ogJVO1NU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7E0C43390;
	Sat,  3 Feb 2024 04:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933471;
	bh=E6NosFwnfH7sOxKZumdlbXyucwJBu0XhNH4w30VTS9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogJVO1NUTM7SQLN7z+4JyXp3H/RhUiNlK2UIakJXfWSAnltFM7dsowyLWHDSoZ2aB
	 ExpvsPLnmFmtuiLyzSPPtq66uCCx9KRWkg3M5SmRDMor7n/EF1nXpOIkUfPU7iA0M3
	 I6gxcmBBf4/bDcMGdbBORWgyVxzEPB8nWppI2mk0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.1 213/219] arm64: irq: set the correct node for shadow call stack
Date: Fri,  2 Feb 2024 20:06:26 -0800
Message-ID: <20240203035346.661858536@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Huang Shijie <shijie@os.amperecomputing.com>

commit 7b1a09e44dc64f4f5930659b6d14a27183c00705 upstream.

The init_irq_stacks() has been changed to use the correct node:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=75b5e0bf90bf

The init_irq_scs() has the same issue with init_irq_stacks():
	cpu_to_node() is not initialized yet, it does not work.

This patch uses early_cpu_to_node() to set the init_irq_scs()
with the correct node.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20231213012046.12014-1-shijie@os.amperecomputing.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -47,7 +47,7 @@ static void init_irq_scs(void)
 
 	for_each_possible_cpu(cpu)
 		per_cpu(irq_shadow_call_stack_ptr, cpu) =
-			scs_alloc(cpu_to_node(cpu));
+			scs_alloc(early_cpu_to_node(cpu));
 }
 
 #ifdef CONFIG_VMAP_STACK



