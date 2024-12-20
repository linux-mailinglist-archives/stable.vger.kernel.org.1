Return-Path: <stable+bounces-105450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844EA9F97AA
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3256616E66F
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A14B22757C;
	Fri, 20 Dec 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgzefnR0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D1227575;
	Fri, 20 Dec 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714736; cv=none; b=kjZhafoBU9nH+IRe523v2ubgbvS1ADKKAG/ap4lgsq0OPY4hHCifRxs1yC25A+4EPaLGHQt5NCmKWl2NSp7WcI3MdkN4evpf3xFfm2lSIiRHw71QOFeBjNneRCEtYk2Efn8BZ3zzKUSUIVEwimjbL3mgmibcGLJ1AfZJHjqvV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714736; c=relaxed/simple;
	bh=q3xrmmT1UJpvd1T/fprCANXtLs8ZiyVYLMFaXW1O6XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IALK1uGJIVK2m0xmt7HswIbMUWPt3sOrUOTSGQZtH4AQ6BnhdA3UN2zje8OudjL7LZ9eXGZVfyxbdjAGKXcy6VyF6KWURfPAy1XCrDxCLVSEXJlCyAev2EeExl7dSD3rBy8v1wpw3r9r8pOUDLEgzdasD/BQXFB4kM3oqqhEdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgzefnR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CA3C4CECD;
	Fri, 20 Dec 2024 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714735;
	bh=q3xrmmT1UJpvd1T/fprCANXtLs8ZiyVYLMFaXW1O6XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgzefnR0+fXFExb3u5G+q75ictHMrwTM+JWh0q+uqdkS/FwKVEGw9ycPUul9Yoqpt
	 IXV+4g09YOyHhUUmI7r0QTtCwSCemW6gExMU+cCLdOtJoi2aA3fcOZizaHhDv1rOqE
	 +X4K9dsD6rZcpLzCAy8EE+j9pYWBRcklhx/GNZqFiFxHxZL4HAyvNeL9mr6NBO9AX/
	 yOMrCdV7S2OrxZYFmnVjbcQWHiNetJhmySe+0KVIGdcBkhkQCt99Yb7K7KA1IehTV2
	 6sfz2ZpWOheovOILWvG5XptxWFThvGeR9xJ3s3XZv/3Kf0pJ+czb3TBGXEV93qPmJX
	 WiqrVo8M6AQXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-snps-arc@lists.infradead.org,
	Vineet Gupta <vgupta@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 18/29] ARC: build: Use __force to suppress per-CPU cmpxchg warnings
Date: Fri, 20 Dec 2024 12:11:19 -0500
Message-Id: <20241220171130.511389-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 1e8af9f04346ecc0bccf0c53b728fc8eb3490a28 ]

Currently, the cast of the first argument to cmpxchg_emu_u8() drops the
__percpu address-space designator, which results in sparse complaints
when applying cmpxchg() to per-CPU variables in ARC.  Therefore, use
__force to suppress these complaints, given that this does not pertain
to cmpxchg() semantics, which are plently well-defined on variables in
general, whether per-CPU or otherwise.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409251336.ToC0TvWB-lkp@intel.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: <linux-snps-arc@lists.infradead.org>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 58045c898340..76f43db0890f 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -48,7 +48,7 @@
 									\
 	switch(sizeof((_p_))) {						\
 	case 1:								\
-		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
 		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
-- 
2.39.5


