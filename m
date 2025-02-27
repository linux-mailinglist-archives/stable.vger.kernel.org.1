Return-Path: <stable+bounces-119827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38570A47A8F
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 11:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E001890D53
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5DF22CBF8;
	Thu, 27 Feb 2025 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sWVPqCAD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H7PAUxly"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266722A4D5;
	Thu, 27 Feb 2025 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652947; cv=none; b=oanwCiUq7UQoSq86Yhe6vrmJDilpSiemHxazg/nd6KpnO6a8VRvz6D8pjj+ctjbEow/rmFQwabgsGbuymmhTjD5Ht9FbSWvihU//3LfgCSxuVGC6k2AVd4XLF4l2lAsf5YcOKIdZdNpIxG1SJ05OqT6bP496oNLBhCnmHgaZFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652947; c=relaxed/simple;
	bh=jnsFtE6gmAw3ZD1svqKae6yKy3yyxELo2vHClRkWzxY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mtH9EH3qg8ts7WTBLxs4DviXtIIy1yxCz3wfvi07P7i1yqITNYddNR9OW162rj+htSGXpll0YEoAPp6BbRYKlEZO130EMuQ1MfTT//nClMtqLtMcuQR515hNwJu52Im39pBKq9h9CG7naH9n89VTgmTRo/C6TPlOUNwttjduGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sWVPqCAD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H7PAUxly; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:42:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740652944;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vV2vyh0Mra6yvfavisH/CWoRg59+m6BlT+NLT5W/H9c=;
	b=sWVPqCADUPtsnr+eYv3K9OthTa7zNtNbkZElVFvkKKEIL/8kx+XGHJ3+tC/g5L4p//EHXT
	KqmfeRifpeuHpkr4VAeZ0Sh0xLxLA0JpB+Na2KfB2cVQbqT9iJ4DZcmj2I4cdyuigSExVM
	/oMECymGp+HomGxNE2HdebzspXO5UgAzxeb4A4uhyZ7qDMW1NHOdy5M6aE/gxO5KqK4uyw
	Dy3OtBiDoV+cFWvwlH1Yh7W1fZtJLyU0iE1IRvklT3Zg3etRWnbGwsbaJwfNRWRg5VIgLu
	7f8tfOBt9Igqngge8n6rgIiiRwEnipGg6PCLmpH3GQpPKOH3gGWT0ukAOWUqJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740652944;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vV2vyh0Mra6yvfavisH/CWoRg59+m6BlT+NLT5W/H9c=;
	b=H7PAUxlyxeMZRtbMh1LdEPHuXozQtw433kw6VNvQH8pA9hihJJ14+KcEiCOuCHi0x5dGxC
	0LfFD6nuFAmHgnCA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/Kconfig: Add cmpxchg8b support back to Geode CPUs
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226213714.4040853-2-arnd@kernel.org>
References: <20250226213714.4040853-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065294420.10177.7103824159597981558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     6ac43f2be982ea54b75206dccd33f4cf81bfdc39
Gitweb:        https://git.kernel.org/tip/6ac43f2be982ea54b75206dccd33f4cf81bfdc39
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 26 Feb 2025 22:37:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 11:19:05 +01:00

x86/Kconfig: Add cmpxchg8b support back to Geode CPUs

An older cleanup of mine inadvertently removed geode-gx1 and geode-lx
from the list of CPUs that are known to support a working cmpxchg8b.

Fixes: 88a2b4edda3d ("x86/Kconfig: Rework CONFIG_X86_PAE dependency")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250226213714.4040853-2-arnd@kernel.org
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d..42e6a40 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -368,7 +368,7 @@ config X86_HAVE_PAE
 
 config X86_CMPXCHG64
 	def_bool y
-	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
+	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7 || MGEODEGX1 || MGEODE_LX
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.

