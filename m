Return-Path: <stable+bounces-24994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2B786973D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C78D1C23BDE
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7051419AE;
	Tue, 27 Feb 2024 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0C22+w7L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E178B61;
	Tue, 27 Feb 2024 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043561; cv=none; b=mmq359Jjyl2mPwPiM+oEP0fwbj1Pzy0Q2/2ske8E7e6Nk6z/HbqFg0SXthW9TT31mPeKA/1Uv5ygGwxf8rbiSspThTLSVdZbJuP4PB65QUnCAZfSFDmIG51v03FOx9TkL6mDNDQwCfZCnnnh9HUj7dh95KA557mzBA8rWF1u23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043561; c=relaxed/simple;
	bh=RMXLYH39P+52nGdKJDu2dJhhGKXnPHOGMl/OzQRgx1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuDYLjGpg5BL504GmH6Ti/EHZoSsoQBE1utrnVEYxWOQNAS6Wo8IrhjUqT9rWHHC5XOtmkTEl8K6Sl1qiWI6RhKflBTVDgP7iRVMFobXpIGqVFbXKt8xZ5pVRIOkhYCB0ZR72tQszJjyFrPPsU1U4U0gCkTGGkaXtMDsXO6b4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0C22+w7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEBCC43390;
	Tue, 27 Feb 2024 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043561;
	bh=RMXLYH39P+52nGdKJDu2dJhhGKXnPHOGMl/OzQRgx1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0C22+w7L7QnGpyit653lU3t/NBeRrrbJfYY+tyGsBo+RjuR2UYiYwCkmKUOcDDk94
	 lbVi7IYIO6avQDOG5GIPsSmG0dtB7Oa25GSzYx76zzgGIGxcwf7HW175/5JtanQbxI
	 zKoPXOPVbyXVte4yTchUgjrrYUBe1caNipEgDqdI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 152/195] x86/numa: Fix the sort compare func used in numa_fill_memblks()
Date: Tue, 27 Feb 2024 14:26:53 +0100
Message-ID: <20240227131615.437101739@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alison Schofield <alison.schofield@intel.com>

[ Upstream commit b626070ffc14acca5b87a2aa5f581db98617584c ]

The compare function used to sort memblks into starting address
order fails when the result of its u64 address subtraction gets
truncated to an int upon return.

The impact of the bad sort is that memblks will be filled out
incorrectly. Depending on the set of memblks, a user may see no
errors at all but still have a bad fill, or see messages reporting
a node overlap that leads to numa init failure:

[] node 0 [mem: ] overlaps with node 1 [mem: ]
[] No NUMA configuration found

Replace with a comparison that can only result in: 1, 0, -1.

Fixes: 8f012db27c95 ("x86/numa: Introduce numa_fill_memblks()")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/99dcb3ae87e04995e9f293f6158dc8fa0749a487.1705085543.git.alison.schofield@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index e60c61b8bbc61..dae5c952735c7 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -961,7 +961,7 @@ static int __init cmp_memblk(const void *a, const void *b)
 	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
 	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
 
-	return ma->start - mb->start;
+	return (ma->start > mb->start) - (ma->start < mb->start);
 }
 
 static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
-- 
2.43.0




