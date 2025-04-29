Return-Path: <stable+bounces-137879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67658AA1540
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09027A5DDF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB3424111D;
	Tue, 29 Apr 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jagg/5Fn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C0254864;
	Tue, 29 Apr 2025 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947410; cv=none; b=NgdG/daXufy3sGxffyHN1xUsd9v5uGBoCdGI/tvIAL4F03saYveHXWeLy6H5pb5P12K5zLo1UPiYUN4l851b3jYrjd+x9F9I3zTSoDUK4QMGBBLhO06phf+m1uX41dsm/IzBOTOk4r14XdvmAX/S5iY6WR2BU0bDzviMG/AbfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947410; c=relaxed/simple;
	bh=xB45AOdmJhZAE9j3gxMUK1+2rET4UjF9zTUhYZMZnDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B20yyu9U7v9ozbM2DZlnSGTkCQBCs01gUsiz2XwOn+cp3q4TVXpL7yVfUAIngpS/r/uCcwYDF9Xa3B4PJ3wU0RCtEvp6TQTWGTq8+3tmlZUlDZjunIt8Zlanyap5JuWDf6jE+rcj8+dD1d7zWQ46YUP8AX735VTpDeDFcOb+LhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jagg/5Fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451C3C4CEE3;
	Tue, 29 Apr 2025 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947409;
	bh=xB45AOdmJhZAE9j3gxMUK1+2rET4UjF9zTUhYZMZnDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jagg/5FnUyuzUYD3k7lj+i0Za744tI6UgtXzjpRYYaHG5TOrDyw0jVGhSHM43katX
	 7A4I7ebSZj+jf7fpDLUbw9gCObSwqDkG6iAYTIhErdmex0n8TgSsJFn1VIaYXHf6DS
	 hGXzXSMZVk2aIVuXMPJz0D78nhGXbuRabPIs5ZSA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 272/286] x86/bugs: Use SBPB in write_ibpb() if applicable
Date: Tue, 29 Apr 2025 18:42:56 +0200
Message-ID: <20250429161119.109213010@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit fc9fd3f98423367c79e0bd85a9515df26dc1b3cc ]

write_ibpb() does IBPB, which (among other things) flushes branch type
predictions on AMD.  If the CPU has SRSO_NO, or if the SRSO mitigation
has been disabled, branch type flushing isn't needed, in which case the
lighter-weight SBPB can be used.

The 'x86_pred_cmd' variable already keeps track of whether IBPB or SBPB
should be used.  Use that instead of hardcoding IBPB.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/17c5dcd14b29199b75199d67ff7758de9d9a4928.1744148254.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index f4419afc7147d..bda217961172b 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -16,7 +16,7 @@
 
 SYM_FUNC_START(entry_ibpb)
 	movl	$MSR_IA32_PRED_CMD, %ecx
-	movl	$PRED_CMD_IBPB, %eax
+	movl	_ASM_RIP(x86_pred_cmd), %eax
 	xorl	%edx, %edx
 	wrmsr
 
-- 
2.39.5




