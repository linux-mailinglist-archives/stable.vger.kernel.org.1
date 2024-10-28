Return-Path: <stable+bounces-89025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD3E9B2DD6
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47DF281ACC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535E1E22E6;
	Mon, 28 Oct 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJw4O3k0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A831E1C36;
	Mon, 28 Oct 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112762; cv=none; b=LxDH2W6ZAXS92oAbDIxqaaP9MCgViN1ZJQnaCYGoddDj9LYfEYi+3KAR1rlzUcgl4D0A8lIYDmIgkMwQ2H/sn5bgoPkYmWxU8yxpAXDUXFZuRVw1fEGVNdSDm4vhN7anZYa2JbP3zayYZ9cGgjRcx0M9U1IzFJrK3vMiDqtZm3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112762; c=relaxed/simple;
	bh=nA7JpuNjyKZzGET4voArfdhcMlnnrN3Q5PGS+2Ii+Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ia5CqEJb/AhL325LDxBAKalFND/179KK/DNjj3jL3gw1UNuXW9uKOAAxRve/bPdOkyDfVvjDTdxDD9dYQMT1otCOaDmpmvlRR63TpKP9JbkNpcjnNRZpF70cMd01Ph72F98x6Cke0e6jeI3KEVZ2bq70WAhPGRtSOznmaBkFcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJw4O3k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D48C4CEC3;
	Mon, 28 Oct 2024 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112761;
	bh=nA7JpuNjyKZzGET4voArfdhcMlnnrN3Q5PGS+2Ii+Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJw4O3k0h1MHmqGYgYktOX4lHbiVtSIUj12EEtnEJ+4EBk6FCXm/iVFkgYqSKmC3E
	 9H0W4ReJm0dH2fqCU9hH3NmTdNDY/B2BvlvOhVjn6Nii3zsIsz96T2vM9113TkLhS7
	 48B4WwSsnbQaRzoRjPlFuiWVNVWrvt2gwS1aQrR49uoqTiHfI1d2BYeEXZIlargKIY
	 4GwbrgGMPNrQRNUPjcxtY8+G3Mq5fl092WJsbm8LUy5yjunOevRQLmJA9h2bh4WPWT
	 n0x+1dmGgR4QQqVRoP7RrY3Vi6z+TIpD5/AZUW0YT18b0dGXttzlE2v8UjSq54Oh0q
	 cvBi36nWl3zJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	maobibo@loongson.cn,
	tglx@linutronix.de,
	jiaxun.yang@flygoat.com,
	zhangtianyang@loongson.cn,
	gaosong@loongson.cn,
	xry111@xry111.site,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 11/15] LoongArch: Use "Exception return address" to comment ERA
Date: Mon, 28 Oct 2024 06:52:07 -0400
Message-ID: <20241028105218.3559888-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105218.3559888-1-sashal@kernel.org>
References: <20241028105218.3559888-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

From: Yanteng Si <siyanteng@cqsoftware.com.cn>

[ Upstream commit b69269c870ece1bc7d2e3e39ca76f4602f2cb0dd ]

The information contained in the comment for LOONGARCH_CSR_ERA is even
less informative than the macro itself, which can cause confusion for
junior developers. Let's use the full English term.

Signed-off-by: Yanteng Si <siyanteng@cqsoftware.com.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/loongarch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 33531d432b492..23232c7bdb9ff 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -242,7 +242,7 @@
 #define  CSR_ESTAT_IS_WIDTH		14
 #define  CSR_ESTAT_IS			(_ULCAST_(0x3fff) << CSR_ESTAT_IS_SHIFT)
 
-#define LOONGARCH_CSR_ERA		0x6	/* ERA */
+#define LOONGARCH_CSR_ERA		0x6	/* Exception return address */
 
 #define LOONGARCH_CSR_BADV		0x7	/* Bad virtual address */
 
-- 
2.43.0


