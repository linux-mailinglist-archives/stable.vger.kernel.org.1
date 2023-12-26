Return-Path: <stable+bounces-8571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4295181E429
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 01:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAFF1C21B6E
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 00:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C311353E37;
	Tue, 26 Dec 2023 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfLjt/jY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2260EF7;
	Tue, 26 Dec 2023 00:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617BBC433C7;
	Tue, 26 Dec 2023 00:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550459;
	bh=vHIiMB+tdtmJ2Ky5sIfHg7G79ZSwjuZF+SkYK1pld2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfLjt/jY1ljaehi1JkVo7yFecuIeUBfhB2A1Ero1o2Tlbn27faHPsjLnTzxdqUhtJ
	 ujGLxSph6hysBV/I+LWyGidJV2QC7525stAD2Zuct379RfVhngAixnEqPNMMRkpiDz
	 4S6UVxHlJmZ+hXLNQ6EQ37wT1usEBoKhX0ZA8ffI2jiE3D3nWDWi/WhPdxMZvMwMyk
	 bQ8DDRbkp258IPogPipipPzN7pieh0QzvVgrDuMbfVvObcZu81s0+MB5c3CBvFT8yE
	 pveZ+Yr/P5va7VmsE+WVvP4Hy/pJrRXTq7bBb2+LwyU9pn7Cor5p4AAsymiUcHGCAU
	 2HL3sdkAXrr0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vineet Gupta <vgupta@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	arnd@arndb.de,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 5/6] ARC: fix spare error
Date: Mon, 25 Dec 2023 19:27:12 -0500
Message-ID: <20231226002725.7471-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002725.7471-1-sashal@kernel.org>
References: <20231226002725.7471-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.334
Content-Transfer-Encoding: 8bit

From: Vineet Gupta <vgupta@kernel.org>

[ Upstream commit aca02d933f63ba8bc84258bf35f9ffaf6b664336 ]

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312082320.VDN5A9hb-lkp@intel.com/
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 68901f6f18bab..c36e642eb1a0a 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -64,7 +64,7 @@ struct rt_sigframe {
 	unsigned int sigret_magic;
 };
 
-static int save_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
+static int save_arcv2_regs(struct sigcontext __user *mctx, struct pt_regs *regs)
 {
 	int err = 0;
 #ifndef CONFIG_ISA_ARCOMPACT
@@ -77,12 +77,12 @@ static int save_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
 #else
 	v2abi.r58 = v2abi.r59 = 0;
 #endif
-	err = __copy_to_user(&mctx->v2abi, &v2abi, sizeof(v2abi));
+	err = __copy_to_user(&mctx->v2abi, (void const *)&v2abi, sizeof(v2abi));
 #endif
 	return err;
 }
 
-static int restore_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
+static int restore_arcv2_regs(struct sigcontext __user *mctx, struct pt_regs *regs)
 {
 	int err = 0;
 #ifndef CONFIG_ISA_ARCOMPACT
-- 
2.43.0


