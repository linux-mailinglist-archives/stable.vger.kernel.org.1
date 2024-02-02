Return-Path: <stable+bounces-17724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4453E84786F
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 19:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009E328A63B
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5510313C1E7;
	Fri,  2 Feb 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVn4B+s1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6913C1DE;
	Fri,  2 Feb 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899268; cv=none; b=mflxoppGOsu3am1DLct557X2uVhOrzFQ8HfpZeLaW1WzPepJlQCFqzihvBa9AW4C5RwArXMdT54LnDRR0RwtcbP5NaSwVAa0MV+bJrmXRHGn1L6VLgNcezOgdYZJZQIY1r9OYzplIDR0o4pefRQIiBkdIdmdqLnAcxGNJF4PVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899268; c=relaxed/simple;
	bh=nsLYPuH2pq1Xt1/TZ8P40osPZrr8e3p5VpZbIJZkq2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFQYmBIKvnUM+2miFtQNqihZlxs1JD/sOqsguBzQms/iMvz2nWk2s4QA9i/uzqVG15Jz3wucSwgNw/+jwnC4UZ1eJmHKa7xragw7abietj76er0/JxaRLGM15YAeofvxwYM7SOkE65vgtsfLvFXCV0MxOZmCE4IVJGBPnRVnFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVn4B+s1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE226C433C7;
	Fri,  2 Feb 2024 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899267;
	bh=nsLYPuH2pq1Xt1/TZ8P40osPZrr8e3p5VpZbIJZkq2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVn4B+s1R7aFONEqMeKlgQ6pe2zMihZvPfyceqLh0mU3I54V6mrBDuaBxDlKpXCl3
	 7pRBJf0kqh3Mh7uxC/o1dqhyx2JC68+WeR5YQCBgAK6dsEzLExF5WbsMPtMY9PqO7b
	 squ8cf6h1mt6tC5FpMCw7HdK8N596oBAG86KNr0tc+ifOyxoJJ/birnEr3kyhtYkI2
	 40yKUDAKwF5HOsY8v7OMztSR6NIzZOuJ/zStqZGI4zk2zg47R5uJ1zpUO44bEskgSl
	 XNRRk2MM2bNwkfduUCeWLeax/rUVq/oE2PlERcJoCnc8QG+Sr4Gw5dmVE2u7ViwECm
	 xtbc+ogVJY23A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com
Subject: [PATCH AUTOSEL 6.1 05/15] x86/cpu: Add model number for Intel Clearwater Forest processor
Date: Fri,  2 Feb 2024 13:40:42 -0500
Message-ID: <20240202184057.541411-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
Content-Transfer-Encoding: 8bit

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 090e3bec01763e415bccae445f5bfe3d0c61b629 ]

Server product based on the Atom Darkmont core.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240117191844.56180-1-tony.luck@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5190cc3db771..5ad0e9e80773 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -160,6 +160,8 @@
 
 #define INTEL_FAM6_GRANDRIDGE		0xB6
 
+#define INTEL_FAM6_ATOM_DARKMONT_X	0xDD /* Clearwater Forest */
+
 /* Xeon Phi */
 
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
-- 
2.43.0


