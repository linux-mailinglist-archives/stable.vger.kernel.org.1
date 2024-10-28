Return-Path: <stable+bounces-89004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E69B2D9C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79312812F0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0481D7E4F;
	Mon, 28 Oct 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWWuEZ7a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CAA1DE3B5;
	Mon, 28 Oct 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112709; cv=none; b=Ud4QAM/vXd5+lEXiKdKL/1wdfTnqtwqXLjy1Fgab3qikzPTn+qxRjsxbOeLHBvVUXdUrEG9yWJxIzPZ/CFa9QVQv4Tuj3rox7eP5oMGqGUwUoz339/6dSHZRC82Al5qcyaBAeRNpvAD6WIvBXuhXh3uOS4Krw2NLtvdqwNXzNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112709; c=relaxed/simple;
	bh=EXFSEkKm+WQOcYd6OyiJDlRKS/PWi0u2XCH/SQalRwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOA2YVPPqY51iInqR1M7ZdbwBJzTZSWqPEPWNBTAvScjU2MD+dTJ8BOLbEqwSXe9Faa6zIBIl9VDf6k1JbUJg+3EvIgKasDEo9SjKaF/h+QC7GMjkIz6rIY4wFTViT7DSFYk8L88x1kLblLHvutuYdMt5vk2sbFHFuGo75Iwju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWWuEZ7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B561C4CEE8;
	Mon, 28 Oct 2024 10:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112708;
	bh=EXFSEkKm+WQOcYd6OyiJDlRKS/PWi0u2XCH/SQalRwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWWuEZ7aHoH5dVTHPdNVFB3fhmifVzaxZ+Uc7FfH8Q3FP4Msw+xIe2HiO4zZXVKqn
	 K4WMrYCxBwYXuUYQKrUSci7TEFcvSZJFsOY/Zqtxp2HYmKuzy5sRqpCSKUE7W9sDpH
	 psDuChrVzAaCqQH/OmOxY5LW81yk2H5/VuyYxI74i3Sfc/b21fSCGUmSMoxBaH+3u+
	 HVaTd+J3QDJSq1AX3y2KHc+kVBJEW4cMZovjTpKNkpBxFfyRT6TVYrDJK3QoHotgc2
	 rx3htg6+t748xaaAw9A3Ykcg3AbDzRTrzgXrTjqLlTUBqFIZmiRSTTqeOj7Oosuavy
	 auqL9OJbZ3pfw==
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
Subject: [PATCH AUTOSEL 6.11 22/32] LoongArch: Use "Exception return address" to comment ERA
Date: Mon, 28 Oct 2024 06:50:04 -0400
Message-ID: <20241028105050.3559169-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
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
index 04a78010fc725..ab6985d9e49f0 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -256,7 +256,7 @@
 #define  CSR_ESTAT_IS_WIDTH		14
 #define  CSR_ESTAT_IS			(_ULCAST_(0x3fff) << CSR_ESTAT_IS_SHIFT)
 
-#define LOONGARCH_CSR_ERA		0x6	/* ERA */
+#define LOONGARCH_CSR_ERA		0x6	/* Exception return address */
 
 #define LOONGARCH_CSR_BADV		0x7	/* Bad virtual address */
 
-- 
2.43.0


