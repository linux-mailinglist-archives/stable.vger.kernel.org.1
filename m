Return-Path: <stable+bounces-110488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC58A1C960
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8692F166FD8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E001DACA1;
	Sun, 26 Jan 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSbu6HOe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA61DA634;
	Sun, 26 Jan 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903042; cv=none; b=mwu7ZjxJP+ds5RBuoipB43bIkJLLR1+KDdgW+gwFacOpuUs4B7IR1fgBKHBMUT8UeQAs+2H+n8nwIhdSNhx0OAa70WYuSWyJ0BZVXYumOdRBeniZA6gtmwDL+rHz/dJlkRCciH6U8LoN7hplWB5OD/yVhaDvetEWZF+AuO+vmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903042; c=relaxed/simple;
	bh=ivPLaVKVhK8FH75LuU5vK0pflfjwziZzLaukhS3zmEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0Nc/sCELPwmLnmuG/z5RPoMrVx2NuRpqOuOK6nV6yRrA3ihnUUOjOEr1FaDYkFSHRXwMdBI4HDp2z9ihyWM/oQVISKdKDOsIlJGj5V70vqQ644+wSwIY6p7Liu7tHWSDGvO6t9CMQN2ZU7fmlnfjh6qSnntQFbw/Fqkp18e1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSbu6HOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3891BC4CED3;
	Sun, 26 Jan 2025 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903042;
	bh=ivPLaVKVhK8FH75LuU5vK0pflfjwziZzLaukhS3zmEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSbu6HOerXf9YQ2AZscKEWz3TmhwTYYMevyh5rVjS/n+RRJbeR+XnxjHEF3hkixdv
	 abPcxDgf2mlETgEbb2vJIWlr2CrGeEzEXTGh+91fuAev+QVHfMdKNIFOyPkfEF6okB
	 pGbyic5bj4oge0UZr5nk1hc5gLpkHaF7wrcIkWy4LOXTv8+f8HRhB4QUYg5qUHxAnh
	 qlIl8UmkEmnT8g5Ep7ZzIQn3P2++mzRXkIZdI/nDi/G/Gc5kCiKDyyDODIMy/0JJZ/
	 1rlRrZ9xUuBb8NVAoYOOXcHlMdCOmm/ZJYtPwFTgdEgiXP2+P4AgRrFc1cZ/xnKodR
	 gx3L4jkeBNbgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	Shyam-sundar.S-k@amd.com,
	mario.limonciello@amd.com,
	richard.gong@amd.com
Subject: [PATCH AUTOSEL 6.12 7/7] x86/amd_nb: Restrict init function to AMD-based systems
Date: Sun, 26 Jan 2025 09:50:26 -0500
Message-Id: <20250126145027.925851-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145027.925851-1-sashal@kernel.org>
References: <20250126145027.925851-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit bee9e840609cc67d0a7d82f22a2130fb7a0a766d ]

The code implicitly operates on AMD-based systems by matching on PCI
IDs. However, the use of these IDs is going away.

Add an explicit CPU vendor check instead of relying on PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-3-yazen.ghannam@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 9fe9972d2071b..37b8244899d89 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -582,6 +582,10 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return 0;
+
 	amd_cache_northbridges();
 	amd_cache_gart();
 
-- 
2.39.5


