Return-Path: <stable+bounces-126930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96970A749CC
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 13:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A147A4241
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A13021B9C0;
	Fri, 28 Mar 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cf1eAIlL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/6ymHg8O"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549121ADBC;
	Fri, 28 Mar 2025 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164974; cv=none; b=gxzPAXkAyDjd1DTK/+Crzl5MysEiAEgy1BwRyKXFc+DAEIWz4dde4JLpJeOjnFMTlAsbj44kOB6lnrLxBhVSVpWKEN8+OLg/u3RBMxJFdi51XxwDR3wjh1/t1IZj7T207DKDFjhhX3guBefwWW1gKbfkYVSvehGl3MY+3FKlZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164974; c=relaxed/simple;
	bh=NC71RCgKx1VzfATo4SMybFVbIZBLe1wK7psQL34+xRs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RBBwa0D8zlQ6Ndh4RQwFzGkyPvIdv7oMAztuvqJiXfB8Nf+UebK9OJkaGLuBV71bL7jDqExi6ZEnoJWKX7efqncuKxnxdZbeVKoemUnqtN6cm6FTuL/pCyOQiYjA9yIBMTc7UpR/pYTS+L1T0dlrDFre2uM7MLaUMlG+DFt0F5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cf1eAIlL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/6ymHg8O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Mar 2025 12:29:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743164970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLxxtQfWt8F1cTUmw8yduUelufCDQn4P8udW6pGvP/k=;
	b=Cf1eAIlL/K5XY/cc7tODr7B6wDput7sEFib/bZBdM4E2ZupjgMh+23xOqLIOwGxzLFbaLo
	nMoklVDW+4Ikbh+3h6qUd5v6zZA730wgtB6BygegTSQ01+V42LlHe6eelcpk+vuwHrj6ij
	hJXemRJdbLUnDsWXHRKCdIezv7L83sXAnP16GayskgIaEOTtuK+vUD2+41ZIjSEgcfUIqK
	vvCC+Am6PSWtcr52MP3pbhXfiF4Ky/VhvgxVFB8AVWsyutVS2k+OZrBZLbVKCHlw+zKJGm
	C/bPr/73KzQQ6WUaCfbINGqFkgJhbWfcm309QcM/NPam6uRN/H7xy199VtowIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743164970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLxxtQfWt8F1cTUmw8yduUelufCDQn4P8udW6pGvP/k=;
	b=/6ymHg8OCEXLmslxA8iFXtfmrc2dhH5zyeTgTqQkwz3gKjkz4sHU2tKYcFUrxSxwaz+8Sv
	uuAf1YIxHDubRgDA==
From: "tip-bot2 for Boris Ostrovsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Fix __apply_microcode_amd()'s
 return value
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250327230503.1850368-2-boris.ostrovsky@oracle.com>
References: <20250327230503.1850368-2-boris.ostrovsky@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174316496492.14745.16906685061384112632.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     31ab12df723543047c3fc19cb8f8c4498ec6267f
Gitweb:        https://git.kernel.org/tip/31ab12df723543047c3fc19cb8f8c4498ec6267f
Author:        Boris Ostrovsky <boris.ostrovsky@oracle.com>
AuthorDate:    Thu, 27 Mar 2025 19:05:02 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 28 Mar 2025 12:49:02 +01:00

x86/microcode/AMD: Fix __apply_microcode_amd()'s return value

When verify_sha256_digest() fails, __apply_microcode_amd() should propagate
the failure by returning false (and not -1 which is promoted to true).

Fixes: 50cef76d5cb0 ("x86/microcode/AMD: Load only SHA256-checksummed patches")
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250327230503.1850368-2-boris.ostrovsky@oracle.com
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 138689b..b61028c 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -600,7 +600,7 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
 	unsigned long p_addr = (unsigned long)&mc->hdr.data_code;
 
 	if (!verify_sha256_digest(mc->hdr.patch_id, *cur_rev, (const u8 *)p_addr, psize))
-		return -1;
+		return false;
 
 	native_wrmsrl(MSR_AMD64_PATCH_LOADER, p_addr);
 

