Return-Path: <stable+bounces-195709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ED0C79616
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25F7234AD6A
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866D341043;
	Fri, 21 Nov 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kEyWEaLL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B232773F7;
	Fri, 21 Nov 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731442; cv=none; b=R7ZOkP1WDFY3TGT/tlAigSQgJi7HZSTNiR7YvJc9cKXRoetuYkEAY1ZT0wrzwMbAk1E5x8mlzDpKHT8iKFH1GidBFtrrw1fX+Q1+QpZ2fgq+cPapKiUtyH8nWiSWezIyqLAAugfFMpAYEWHsElyV/Cj/MESIS3PAj3/kIsI4/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731442; c=relaxed/simple;
	bh=2PNJ8HZ0e4Ri5Qzls+rJoOYhZWj8nB7UZG4kZ+Ho2xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXbZ3pDR94fT+pNyK0oeL6DDcAQBcZzxlAPUJ6CuIg6t6XeENQd3wLxINmQA81GT1gQbrrN8OGOSKku2v3oL4aK6xpIXOnEuv9b2/O/uEvl8nvEls7gAgJZW5DPOHpJbWX1ZFchSR19+q7HaY+T8c/tCdxfe9jDw8TUM2pfv52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kEyWEaLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3210C4CEF1;
	Fri, 21 Nov 2025 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763731442;
	bh=2PNJ8HZ0e4Ri5Qzls+rJoOYhZWj8nB7UZG4kZ+Ho2xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEyWEaLLCtefElHcFNjx9/+5BCC9PF2crdB3eHi5AMXM1xzFuGH55IVf+dq7TKq9h
	 BmWh2EOMtdQUJa+EXMAdNW2K1ULdHzKRWejnQ/EzOotitDUx8Mbn0RusRQHtTiz3vX
	 0KTfkDCI9/UdA8lGmq+ZLYUbeBAk3LB215ywwRkg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.17 209/247] LoongArch: Use physical addresses for CSR_MERRENTRY/CSR_TLBRENTRY
Date: Fri, 21 Nov 2025 14:12:36 +0100
Message-ID: <20251121130202.229009786@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130154.587656062@linuxfoundation.org>
References: <20251121130154.587656062@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit 4e67526840fc55917581b90f6a4b65849a616dd8 upstream.

Now we use virtual addresses to fill CSR_MERRENTRY/CSR_TLBRENTRY, but
hardware hope physical addresses. Now it works well because the high
bits are ignored above PA_BITS (48 bits), but explicitly use physical
addresses can avoid potential bugs. So fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/traps.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -1131,8 +1131,8 @@ static void configure_exception_vector(v
 	tlbrentry = (unsigned long)exception_handlers + 80*VECSIZE;
 
 	csr_write64(eentry, LOONGARCH_CSR_EENTRY);
-	csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
-	csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
+	csr_write64(__pa(eentry), LOONGARCH_CSR_MERRENTRY);
+	csr_write64(__pa(tlbrentry), LOONGARCH_CSR_TLBRENTRY);
 }
 
 void per_cpu_trap_init(int cpu)



