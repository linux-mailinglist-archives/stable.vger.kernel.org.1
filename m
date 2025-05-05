Return-Path: <stable+bounces-141055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D713AAB04A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493B54C63A6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC930C1E7;
	Mon,  5 May 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm69Mmf7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A403BA891;
	Mon,  5 May 2025 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487344; cv=none; b=RttU+hD8ed9xHKt/Lj05UxqgDNVhViILwizkuIrQ+41WFtwG8XtKJNe87wCp1ZP8Ue8z0QfYrbHCdN+sK8UdHSuB5YgC6rrPrfhG8Is9S7pD0ZEH9l86JpjDLmP+Bufuw7SpcR/cndIuzrYnaTfmTBv9lc6Wq2FVbmWwHekE4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487344; c=relaxed/simple;
	bh=dhO1wySfaom7bX0z5B2dpNT2HGt71Dc6VZn6YqH1lgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ii6BzofR3shYlIrU0v0SSWaVv5QPtrVQ+7SU9826+S4F+Gg23n5f/RAwhVd+LOHh1PpEZQyeJ90pWJOU7m13AAAW8STvS6Laus6Li0WTbKeHbAKo1TcX7TPbYdZ9NFryUN36EROcEge1N7CfgNFRbg9HOEK3hWt3X7W5SciD/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm69Mmf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605FFC4CEE4;
	Mon,  5 May 2025 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487342;
	bh=dhO1wySfaom7bX0z5B2dpNT2HGt71Dc6VZn6YqH1lgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pm69Mmf7cPq4nylToYoYWEqM5zGM6MzPyHAgrFywlKUKQGIgTwhb2lxvzxbbloPUD
	 Iz1IEkDRfyxjDt9pYfwUHt4FiG1WZfoN2D63XXtji6w6HbN00hGW9Ao6YxyeFsx8Je
	 DpgXsKQBZPCjIlXPgVgxfgvoZdaYneJivwyLE9hzu9A/Ci3DrfNhuD0cTf/K1bqO8U
	 hrbIaI6UJrR4vv/GAZwKXKq/8bV9XSJIpLm+cnYcM1wfgmJmt0yQPmG73aF7T3O31u
	 0DN6kWI/l+nXlARbZzxwNffCCeWRXTNxetl29SUK391hVJ02WR0/VrA1QmhRWZZFL9
	 6xHI1M1MJpB/A==
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
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 17/79] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 19:20:49 -0400
Message-Id: <20250505232151.2698893-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 417ff647fb377..06fb50218136d 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -49,6 +49,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free(__pa(brk_end), uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


