Return-Path: <stable+bounces-181197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE53B92EE4
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01312190761F
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF6B3128AC;
	Mon, 22 Sep 2025 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tUeU4zIY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7972F0C52;
	Mon, 22 Sep 2025 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569931; cv=none; b=mXA6Xhn3fvFAWiYeT0mJmw/kvdnjtkHSNvsa9OWEcMrjRknVMWtew8Vv92I4F3m64Zdlibrfkbotj5VQp3wjIcY5g4bqNpymDO0orHLO6boo31nNJDElSwKZ7WJv4PF988ic+1kL0NZ23PUeXkDge4q0xgSBZl6lNKLpqHQ1OnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569931; c=relaxed/simple;
	bh=P87LzlnqZlcUylrEI26Nit7wEM+IWAh1fuobTOpNp/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCyC5BphLVyLmIlS62Ebedg3I+dqbafqvFTGsyeEU0GyiAq30tnB4aioJhrZvnuEgnHGFMxHzTxDeK4BxTeKGRoF5uc25+wHu9Hp+yUgeJDzuQAWeIrS88XsdBqnQyNxOfH+J6PcRNd27VwpSjcvxpxOxqE3D73uiAVCA8KJnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tUeU4zIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C37CC4CEF0;
	Mon, 22 Sep 2025 19:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758569931;
	bh=P87LzlnqZlcUylrEI26Nit7wEM+IWAh1fuobTOpNp/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUeU4zIYZELsU8a/0cER8/EFFfzSKLwNjxuaxLYr9BWbBBpg1Xo8ebdpp51mKYrQp
	 XpdHLZhy6SPycxvERCaQMXvF/WTMUxXUPpCEmduySkIGdMsxJ2ux9i9wU9pFQj/XZN
	 WLVsRuhOt+Sk+WlYRyrIZe1XEQN2YsTScNEWeyEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangshuo Li <202321181@mail.sdu.edu.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 048/105] LoongArch: vDSO: Check kcalloc() result in init_vdso()
Date: Mon, 22 Sep 2025 21:29:31 +0200
Message-ID: <20250922192410.176624002@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
References: <20250922192408.913556629@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guangshuo Li <202321181@mail.sdu.edu.cn>

commit ac398f570724c41e5e039d54e4075519f6af7408 upstream.

Add a NULL-pointer check after the kcalloc() call in init_vdso(). If
allocation fails, return -ENOMEM to prevent a possible dereference of
vdso_info.code_mapping.pages when it is NULL.

Cc: stable@vger.kernel.org
Fixes: 2ed119aef60d ("LoongArch: Set correct size for vDSO code mapping")
Signed-off-by: Guangshuo Li <202321181@mail.sdu.edu.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/vdso.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -108,6 +108,9 @@ static int __init init_vdso(void)
 	vdso_info.code_mapping.pages =
 		kcalloc(vdso_info.size / PAGE_SIZE, sizeof(struct page *), GFP_KERNEL);
 
+	if (!vdso_info.code_mapping.pages)
+		return -ENOMEM;
+
 	pfn = __phys_to_pfn(__pa_symbol(vdso_info.vdso));
 	for (i = 0; i < vdso_info.size / PAGE_SIZE; i++)
 		vdso_info.code_mapping.pages[i] = pfn_to_page(pfn + i);



