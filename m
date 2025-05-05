Return-Path: <stable+bounces-139861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA22EAAA112
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED46461B0E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACFC29A3C0;
	Mon,  5 May 2025 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQJRpNF6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2375E299ABA;
	Mon,  5 May 2025 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483558; cv=none; b=Pq3/Y3K/1jR2aIF933zrE0lzR2xM0jbQ0bkFk4mKtKb/KfkynhUX0dvaXKPEab4K57UoubWPP/FUaUSPCJDiMB82mq16UBHxVQKAMs0G6Vp+lqv8o59rLjnt0WQJiraWsFUnmE8/cTp0oCOHXy9v+QmYVs7LPS/IeBOsm0+urCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483558; c=relaxed/simple;
	bh=3UEqT/+fIc974jJeUM8R4SRv1mtRRd3KVFibWheaoyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABoOsHEpQiuRFKfd3OQrMKEuKngQwYpI9A+rGmNKhEbX7nMr1nnJhDmWt4Q8bvRTKWKSYRqtmb6M86IEKGvMmcH/AUJlTjwm3LDsPKX6MaUtmKov53ZDI5HCKEvfTpWwlSkK++ZILy61VL5pedA2mOEOcCpqMIY1qSFpanMjLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQJRpNF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A510C4CEE4;
	Mon,  5 May 2025 22:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483558;
	bh=3UEqT/+fIc974jJeUM8R4SRv1mtRRd3KVFibWheaoyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQJRpNF6WSpMW3rVVPyZqLvNyKywQGN7LCch4fkRynSLNJLXG7+xMLV8KmqwuWO3D
	 NzFQtBId34avcgFZgxuDzQBPxWbE0w7DmAQ/XmYKoYw05golDLpkUqI0PWm/2EBKK9
	 rM8vNLqmytY2DURjmvSRq3huw8CZMrfoKhD7bHOfulM4RZn1kFVGRvo7TKhXE8CZvm
	 +3Z28Jv328vO79764t9YpsNrYfqR/jBMTownyVGR20hFtu3cOpH5hq0J52CHkuncqA
	 yg4zv8VikOmHHXEquM5vB7SUGfswl6Qo+H+BLyMBGBwelSyY5vpujFokjVo2bmKJ5D
	 +3eDNptPqKtWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	richard.weiyang@gmail.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 114/642] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 18:05:30 -0400
Message-Id: <20250505221419.2672473-114-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index befed230aac28..91b7710c0a5f4 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -66,6 +66,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


