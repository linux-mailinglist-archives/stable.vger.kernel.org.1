Return-Path: <stable+bounces-140835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E685AAABBA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC2217B825
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F4C2857D5;
	Mon,  5 May 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz6UImvY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5C3991AE;
	Mon,  5 May 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486468; cv=none; b=WGnLgYr+ZkzdAsUDp40peGS2sOFfRHWDW5aNCC9iE/BHQE8fIfy59lMjTtbdujlAxTbhb8LvrfKt1XPg4wklHhHdrPwUXlxgIZ8+GpmZ8eRWwYAmL6AXujNQhT3KLoOJ9Y/s2lffmIueCEthjIq6hT2ct7HVU8wbdA6L0wWmDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486468; c=relaxed/simple;
	bh=rK8UgpSEnGG6WpUj0pfBe+FyfH9qHFqoFjKvOIgzK70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bxksCudbc3LZM8RPloo2+9dSvLtADKHrgGMnndcOKzzRooNjOln8gdDd2giP3bQeZwSxkkQkvPg9Z6ouDw3McxhFejQ9eoNlU8jcr5UYzZU3RZxkrhyh6++/63w3eOGC4nFf099D4/Sw8UqRFHA5jUDA88EjvDjzvUJ0QZwio/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz6UImvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5138C4CEE4;
	Mon,  5 May 2025 23:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486468;
	bh=rK8UgpSEnGG6WpUj0pfBe+FyfH9qHFqoFjKvOIgzK70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jz6UImvYDtBD0ScAzErGDFaG2YYpR+y9P6O+8fLP0p6vRY7YpbXooqAiH4GEeW1wU
	 rx8ehehmNok4gTJcoa4dM8FcpvXDQYxRiniOmpO5y8g00S7WTEnJ1UVZ9XAkoqFuFD
	 UwVjbz3uef7P7HzmsxiBrzkf80XtIqae/Zd0pud5RPvnMZ3CDi+yj12rLKrr/DyDDU
	 ShCDxbHTqpTFtXceZKnm8IxiqRcU6PNFLl3PdWs7it1fk7yRU2A9ibqtPUqeo3ODLY
	 AGm/xQZboNC1FfDMbHBeYxUWyI+X01z9Pyhoi61BszcaQRNIjWa1VHZ/IUMkDG9cyC
	 gDFPs+puk2zPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	rppt@kernel.org,
	dave.hansen@linux.intel.com,
	akpm@linux-foundation.org,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 045/212] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 19:03:37 -0400
Message-Id: <20250505230624.2692522-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit e82cf3051e6193f61e03898f8dba035199064d36 ]

When uml_reserved is updated, min_low_pfn must also be updated
accordingly. Otherwise, min_low_pfn will not accurately reflect
the lowest available PFN.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250221041855.1156109-1-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 38d5a71a579bc..f6c766b2bdf5e 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -68,6 +68,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


