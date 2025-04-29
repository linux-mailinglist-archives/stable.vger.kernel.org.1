Return-Path: <stable+bounces-138033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22582AA1645
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292E11889885
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1B42459FE;
	Tue, 29 Apr 2025 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IFFPTAyd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648F242D6A;
	Tue, 29 Apr 2025 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947901; cv=none; b=TxjouJgX5yeYxBua05yoa0t6l8z0CLmim59jwP3s8i0PBFwUb1F5Vw2lsQMFjsXGmF7cp1ICMVtimbAP4/MK/3/smCC8IQS5Od4WL+v0l/goZa+xVz/ZLf46h3hC4nZM2AvGATvPDrzHlMDJ0ewxZNUD1u2n1R4MRtMKec4j/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947901; c=relaxed/simple;
	bh=WCA+dnR6NEltMDdQqbisXHpzlKKjgpCiPy3gh4Qig8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nohZ4xdIa+vQ7vgqD61jJAZs5XpjbFwykuwQAjl7VS7r1HOrcaGV86EJGLfbdXQI7Jz8gTl791b6rVn3quHN/1d+Z/7a1vKW3IdhO4WnSJGMBUHcH5//uFRlcpF6mtAKNcu3znw8K9nM/ZIjNB7MFAF6wRmLdUuqjHbb4KfqIy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IFFPTAyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED09BC4CEE3;
	Tue, 29 Apr 2025 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947901;
	bh=WCA+dnR6NEltMDdQqbisXHpzlKKjgpCiPy3gh4Qig8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFFPTAyd8TSLASS/uGG9I6OqenabXz8xoc5hH6Ir+iTLIZIaRWGrzEWAuEimWhb5a
	 AE0bHhDyfgX+CQM7iN0bulXtzw3kvpsQmYzfvAu7BTQEhqeZhF+udjvwVOz703sOfl
	 GX8r5yunkfYM+Biz8KXedgaMKIv/nDCIl4yYkXjI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Petr Tesarik <ptesarik@suse.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 109/280] LoongArch: Remove a bogus reference to ZONE_DMA
Date: Tue, 29 Apr 2025 18:40:50 +0200
Message-ID: <20250429161119.573961581@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

From: Petr Tesarik <ptesarik@suse.com>

commit c37325cbd91abe3bfab280b3b09947155abe8e07 upstream.

Remove dead code. LoongArch does not have a DMA memory zone (24bit DMA).
The architecture does not even define MAX_DMA_PFN.

Cc: stable@vger.kernel.org
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/mm/init.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -65,9 +65,6 @@ void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
-#ifdef CONFIG_ZONE_DMA
-	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
-#endif
 #ifdef CONFIG_ZONE_DMA32
 	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
 #endif



