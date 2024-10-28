Return-Path: <stable+bounces-89035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C9F9B2DF6
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C251C22250
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EE2200BA5;
	Mon, 28 Oct 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5eofh7b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212A200B8E;
	Mon, 28 Oct 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112785; cv=none; b=OIWMs6Ug2+UhjQbd3QebnYE2+sIVWkyAi3x22bW6NeBVHdo/UgKbltE5F/Mqq30xYv9ybi9FB/1lC/kEEJ1baux2UMPnnS9PbrAbcOfQKh0BV8D2XReCHYGDKAS9WXlNeDt5yy6zE0rjcSENz7vqFz3g1ZJhA+8+BCl/L5o8AXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112785; c=relaxed/simple;
	bh=32MnMsbpgABlYs4RbL3vPVXd0eqsEm84FdrjGK51Owk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3NQbqa2+cGqulNjiJtEBw7mMs7Sx8M7zKBOxjAqBfMc8ckOPlO5h4eqUBHitxKlEB6RNuV+zZNkaMvZluz3T9K4QY3eWvpqqPkklGX+ecXGKdJfhMxuqdKGk5WiTvHkSJdkrdV+1PHafrdXWeR8ygf/hiZtquswiPYKpDXPYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5eofh7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83ABC4CEC3;
	Mon, 28 Oct 2024 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112785;
	bh=32MnMsbpgABlYs4RbL3vPVXd0eqsEm84FdrjGK51Owk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5eofh7bhznA1DqZwLOKh1APKXMoRd1TZTNojYikJIXeMzlIPzugXSUdlHIdHmAQj
	 g6lCH5smA2sLgZYp7rzVYgxJ/XxYXTAODM3EPRkIpa9AM2WFQUtcohJBzBZUeaNNEK
	 KsKcm8Gr3dI4BNMUICkM9xWpXvm4dJxe1FKBXL6WaHLnMZXz97uVnB6MS+5rYu+qo2
	 KiypwwVUuHv1m8h3nbGCDjNROi5oWMHV5dIhTBhqEktzlA/fAvqmLwq8Qal5ncyJpi
	 UljYHsyPoBkHmUjaOdUFJiknO4822K8Fq7sOYBEVS5A6djUBZke+IVh52fctZEwQOc
	 9xXD/b/47e+JA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	maobibo@loongson.cn,
	tglx@linutronix.de,
	zhangtianyang@loongson.cn,
	jiaxun.yang@flygoat.com,
	gaosong@loongson.cn,
	xry111@xry111.site,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 6/8] LoongArch: Use "Exception return address" to comment ERA
Date: Mon, 28 Oct 2024 06:52:47 -0400
Message-ID: <20241028105252.3560220-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105252.3560220-1-sashal@kernel.org>
References: <20241028105252.3560220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
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
index 3d15fa5bef37d..710b005fc8a69 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -325,7 +325,7 @@ static __always_inline void iocsr_write64(u64 val, u32 reg)
 #define  CSR_ESTAT_IS_WIDTH		15
 #define  CSR_ESTAT_IS			(_ULCAST_(0x7fff) << CSR_ESTAT_IS_SHIFT)
 
-#define LOONGARCH_CSR_ERA		0x6	/* ERA */
+#define LOONGARCH_CSR_ERA		0x6	/* Exception return address */
 
 #define LOONGARCH_CSR_BADV		0x7	/* Bad virtual address */
 
-- 
2.43.0


