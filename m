Return-Path: <stable+bounces-100438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784FA9EB3E7
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 15:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FD0188A1FF
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFD71B4240;
	Tue, 10 Dec 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpE22AAz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8971B3924;
	Tue, 10 Dec 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842198; cv=none; b=njbq7upODUWwaECIOYKh2k5vGSA2jo5RrCHLeskevn5D6blQtssZC34Sf1wq5c9JAzQvf3kTldwXVfze1yuXo23UbxkPcvyGKNkw8BG31uEgO3U9f5W7g5Zu7njU8eI46IHXvjkfcurEbIY4bAPUvQu0KIGzLg6SgDqijuvfpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842198; c=relaxed/simple;
	bh=RlkJX0MrhsJeOtYwbzKz9uU11pc4QQCMS9xkZOpuwfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkZXskzDVTbw6ZC4F0HqfuBI8q0XzYWSr/Hk4ksV2d3RmS/G0ADPFg7f/vhLEi3kqjj6XXSUBTE6ceM2pQfqGpWBihsfzoZFH1fA3KSTpHutcV5MHChKHNuxXavA3eG4xQnIw6bCwZyduprihWvuTKFIryQd3LmVU3WNLOjjJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpE22AAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE3AC4CED6;
	Tue, 10 Dec 2024 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842197;
	bh=RlkJX0MrhsJeOtYwbzKz9uU11pc4QQCMS9xkZOpuwfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpE22AAz8JnIoPsTCivKa+MP48cXGfDjPi6iVhnuTX92pP2L1fwFaF74b1AouRM3I
	 hw8/z2N4/GHt3TxCzaLEefNkLiX4J0GHt7PqbhcWrZlmiHYF4ka7L2RoWqPgPWslTf
	 ETjvJfCrMRH3W9uWYkTHS0dW6fMRvc43jmxIunnLCll0x6u3twOgvvadqUvUh7Znl4
	 2HOf4pGw3LfIJN0eI+mRrSKQ7RNA2oqwSfbnzsP1TK7ZkqYIlBxQvMuReZ3U+6Dx53
	 LFrQcZHE6+dM89gKR/EIsfsel/b+BJU8Yt5zwDE54ZFcDOsyUZjOxXbn/pdXUQDwf3
	 7I54gtiBA0Yhw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/11] x86/Kconfig: Geode CPU has cmpxchg8b
Date: Tue, 10 Dec 2024 15:49:35 +0100
Message-Id: <20241210144945.2325330-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210144945.2325330-1-arnd@kernel.org>
References: <20241210144945.2325330-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

An older cleanup of mine inadvertently removed geode-gx1 and geode-lx
from the list of CPUs that are known to support a working cmpxchg8b.

Fixes: 88a2b4edda3d ("x86/Kconfig: Rework CONFIG_X86_PAE dependency")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..42e6a40876ea 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -368,7 +368,7 @@ config X86_HAVE_PAE
 
 config X86_CMPXCHG64
 	def_bool y
-	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
+	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7 || MGEODEGX1 || MGEODE_LX
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
-- 
2.39.5


