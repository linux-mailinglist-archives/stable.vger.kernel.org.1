Return-Path: <stable+bounces-5402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C080CBC7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D40281FFB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2564779A;
	Mon, 11 Dec 2023 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvBl+m+0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A514776B;
	Mon, 11 Dec 2023 13:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F70CC433C7;
	Mon, 11 Dec 2023 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302851;
	bh=gmWXl8OnCsDxGnfCAvvdJ9/lz1xt84JHADheam84Pw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvBl+m+09oDNEHo5Q4aH4aSNYq1uuGpreTCXZSr+fq6/zGeVIrqeesF+pDMbTWPQz
	 Mty/KJfz/VOiqPxs0kzdlmduh1GRgdiNrg7udScux6bWlfH/1eajcWbom7LejGz1lh
	 Lvdn/CHmwXZpBjjagkDYpW5nboFbbd4uYFO93as7Iduh+QjJ631ExDl+CJngjFQTw5
	 3ECbZyz3lWwqMoGNdSPECQZhZziinpGJ7aWmopuGw7tNLW6qxqwZcSafcaov140a6g
	 IIZJTW7ciKxEdxDSg1kULVGdLxpdGSNwsyZBOI9UFlRmJ5yxw4qSt/xkFIyUa2qW1q
	 qRWJQYfttmrMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	loongarch@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH AUTOSEL 6.6 47/47] LoongArch: Preserve syscall nr across execve()
Date: Mon, 11 Dec 2023 08:50:48 -0500
Message-ID: <20231211135147.380223-47-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Hengqi Chen <hengqi.chen@gmail.com>

[ Upstream commit d6c5f06e46a836e6a70c7cfd95bb38a67d9252ec ]

Currently, we store syscall nr in pt_regs::regs[11] and syscall execve()
accidentally overrides it during its execution:

    sys_execve()
      -> do_execve()
        -> do_execveat_common()
          -> bprm_execve()
            -> exec_binprm()
              -> search_binary_handler()
                -> load_elf_binary()
                  -> ELF_PLAT_INIT()

ELF_PLAT_INIT() reset regs[11] to 0, so in syscall_exit_to_user_mode()
we later get a wrong syscall nr. This breaks tools like execsnoop since
it relies on execve() tracepoints.

Skip pt_regs::regs[11] reset in ELF_PLAT_INIT() to fix the issue.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
index b9a4ab54285c1..9b16a3b8e7060 100644
--- a/arch/loongarch/include/asm/elf.h
+++ b/arch/loongarch/include/asm/elf.h
@@ -293,7 +293,7 @@ extern const char *__elf_platform;
 #define ELF_PLAT_INIT(_r, load_addr)	do { \
 	_r->regs[1] = _r->regs[2] = _r->regs[3] = _r->regs[4] = 0;	\
 	_r->regs[5] = _r->regs[6] = _r->regs[7] = _r->regs[8] = 0;	\
-	_r->regs[9] = _r->regs[10] = _r->regs[11] = _r->regs[12] = 0;	\
+	_r->regs[9] = _r->regs[10] /* syscall n */ = _r->regs[12] = 0;	\
 	_r->regs[13] = _r->regs[14] = _r->regs[15] = _r->regs[16] = 0;	\
 	_r->regs[17] = _r->regs[18] = _r->regs[19] = _r->regs[20] = 0;	\
 	_r->regs[21] = _r->regs[22] = _r->regs[23] = _r->regs[24] = 0;	\
-- 
2.42.0


