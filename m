Return-Path: <stable+bounces-132605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B00BA88428
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38D33B3A76
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B6B27FD7A;
	Mon, 14 Apr 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZk6QZJr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086D27FD71;
	Mon, 14 Apr 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637507; cv=none; b=cLiCOKagFOuqBKZEeBXz75NsyrCpyJ5YdNL5lqhgnh+gNkexMuC5ZBbJA84gcnyxe3tafcT4HWaGjKrd4rhr6pcNArIrmKMUfR7BT7FkB0iXb0Os6/SL3tlO7XL9LqV3oygJiK9Y/InUTs3CtHHf3CPGvtNmYqsFzGAV/f8Jrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637507; c=relaxed/simple;
	bh=p1YNscPHnD9q0ry9tfgRP1Fu8zOjJ1pcXTSkJrt5How=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1Mbj6eA6GmP4fjjqljA88dzJhWqhVyQE02an/qkZ/7okkf+RqMrKeix9UpzUqXuzn9eORGT3E1J7hb84ADsS2VDC5V9ywUjBtzONNLsKw3R0zIkUaCmp3lysOeSsSzuQFps1S0M2w/n51Naa3GYq7uHdd+GYJWOJh3vIBARz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZk6QZJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AABC4CEE9;
	Mon, 14 Apr 2025 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637507;
	bh=p1YNscPHnD9q0ry9tfgRP1Fu8zOjJ1pcXTSkJrt5How=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZk6QZJrwMCq2IU4hyq694vZE066RdihOS/yLvfW+Ke9zl+el66nxAYKTa0eJ/BEi
	 dAtKEdkzt+yZsBRzJUaVOJj0WtctMzY83FVj/c/Xfi91ArEepnNqVs+P4Esbv9Szb7
	 VqjUzNcYInHhtolE2VLNB6IjswkQQT/aO2yAx1kHpd0sAGYs+DyDHuBLZ4k9h2F6LJ
	 8znTd4sneUfw/2H2h5TILx0oYTtZEQpMhxQnvHaEt3EbiDOx51cVQ8ElF4lbBu3ZTS
	 +zIvzkKVfnBKmGihbXjwJyV08logXug8zp3l8L1dojnF9YkPYOiPps2R0VMztn1dQi
	 GipMR4+qg3dKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 5.15 10/15] x86/bugs: Use SBPB in write_ibpb() if applicable
Date: Mon, 14 Apr 2025 09:31:20 -0400
Message-Id: <20250414133126.680846-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit

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


