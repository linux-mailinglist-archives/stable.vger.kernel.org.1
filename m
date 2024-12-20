Return-Path: <stable+bounces-105449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740FB9F97A7
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77651162E03
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAA7225414;
	Fri, 20 Dec 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE+OVatR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99701225A57;
	Fri, 20 Dec 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714732; cv=none; b=WpsE/FhPySFdSGc0tqNmYh3B6iawtPNttNO20n85T2qkh785V+B5NE6Gffh/XqJX1KB/zSUOqhmZA+OcVQ+ey6poQngQVeB1YRtbnoo+lyArNidlSRhTt/UNQuO/IorNz79d2Fp7beBPHNJwyrIew64DqNVCErxk4mSRQYqjQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714732; c=relaxed/simple;
	bh=wvhvZKGhB/9VYruVPnLK6Em3I237MTUZvuqu9NYbISU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RpPprm0EU20bGROkVzakvmMONOg5dlP622Eaku5TMZQbvJz8G4vUIkoJPIrMFmGQ6Hl1iNdwE/y/52QxfL4Y6H8wRT13ePe1AV3AZ7QARhOropaAifdaEkl7xvnLKdDzVr2X2eCRR+gAg7E+RYpq9AkDvGp+qbT2AP6EpH9Si9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE+OVatR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECB8C4CED3;
	Fri, 20 Dec 2024 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714732;
	bh=wvhvZKGhB/9VYruVPnLK6Em3I237MTUZvuqu9NYbISU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DE+OVatR2tfxiQfYQvJl4Qru4kJcBC+GZ0/4YhtPJMrFinw2kL3xNPUObaI5PbSSq
	 AMcelgRtG43TwM+zJMXi7rIfRjhripqPQr6mseW8VdiNQDbfUVXadAbwWkg4GIEbf3
	 K0hQtY6mCOA2rGpe2hdC+c++qb7RY1Bc8WdEmQbLMtCyN53udbbeCypvZi3QlNFodv
	 JFNvNP5xpUV6MBiiK8TU9NJX0+wQm0/jVDNwDtjW1nB8kMKjEr/M5KMmP3+KdcHsjY
	 zWeGlUiTJSAqv9JoBiFzBDB5bjhPOVsOkViOhZ3WmL/0s2xqwbOeSvnHE/u0asEHh4
	 RWVI+rS/q0xjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vineet Gupta <vgupta@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 17/29] ARC: build: disallow invalid PAE40 + 4K page config
Date: Fri, 20 Dec 2024 12:11:18 -0500
Message-Id: <20241220171130.511389-17-sashal@kernel.org>
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

From: Vineet Gupta <vgupta@kernel.org>

[ Upstream commit 8871331b1769978ecece205a430338a2581e5050 ]

The config option being built was
| CONFIG_ARC_MMU_V4=y
| CONFIG_ARC_PAGE_SIZE_4K=y
| CONFIG_HIGHMEM=y
| CONFIG_ARC_HAS_PAE40=y

This was hitting a BUILD_BUG_ON() since a 4K page can't hoist 1k, 8-byte
PTE entries (8 byte due to PAE40). BUILD_BUG_ON() is a good last ditch
resort, but such a config needs to be disallowed explicitly in Kconfig.

Side-note: the actual fix is single liner dependency, but while at it
cleaned out a few things:
 - 4K dependency on MMU v3 or v4 is always true, since 288ff7de62af09
   ("ARC: retire MMUv1 and MMUv2 support")
 - PAE40 dependency in on MMU ver not really ISA, although that follows
   eventually.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409160223.xydgucbY-lkp@intel.com/
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 5b2488142041..69c6e71fa1e6 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -297,7 +297,6 @@ config ARC_PAGE_SIZE_16K
 config ARC_PAGE_SIZE_4K
 	bool "4KB"
 	select HAVE_PAGE_SIZE_4KB
-	depends on ARC_MMU_V3 || ARC_MMU_V4
 
 endchoice
 
@@ -474,7 +473,8 @@ config HIGHMEM
 
 config ARC_HAS_PAE40
 	bool "Support for the 40-bit Physical Address Extension"
-	depends on ISA_ARCV2
+	depends on MMU_V4
+	depends on !ARC_PAGE_SIZE_4K
 	select HIGHMEM
 	select PHYS_ADDR_T_64BIT
 	help
-- 
2.39.5


