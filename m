Return-Path: <stable+bounces-93983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A2E9D25ED
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A792283C02
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281301C727F;
	Tue, 19 Nov 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfdHTswP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F11BDABE
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019492; cv=none; b=KMlVhHyuobBmkr4CMi9yskZdakvjsZ9HGIyR5hARPF7jDIiufjYbsbPYEoOszh45MGyrL3HE9tBnDBfRuKeoIg6q2YkUSPQlLCp5dwwUExV+KS1sBJA87veC1ySu7PG7SWyPGuIyGheeIyc52RS+VXV+3qkBHV5qowo3ZWaunt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019492; c=relaxed/simple;
	bh=x9JXOMGnTvmyZ5/C4nl5GcoQ/yH2k1CRlvEEM4AQCsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SB2IAB7pJBeTTAhdtUjNRDP6ZvFUU6sgsirTcCHkxGJHBSFxlRmRcKDMS53OwHYjP8dhQ2ZfWTE5v7yCMdecvOu0b2PR25ONbXHC+KOvWUd6re3QsHijXwz9N0SXfYvRsE8idQxnfpQGCZxen7ymiTmufNRcBh2WXDC+yYYd5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfdHTswP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC7AC4CECF;
	Tue, 19 Nov 2024 12:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019492;
	bh=x9JXOMGnTvmyZ5/C4nl5GcoQ/yH2k1CRlvEEM4AQCsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfdHTswPSvcMC6zW13bDa48GSg8dDL8HfUV5leFZE+SFfhQXczVO+E6FWHv9EAmFt
	 v6afjoIMa/Um6PnrlP/Rh8dL+codu17tsI/S4do1v8SINEWFm4WRhG1jlW4bxxZVlQ
	 8YBRFlE5Z6VnwEeWEHedjmgORoL3iZhvjsvcKJMPvFPsnpFqu0+jD54T9vckq4Xd6p
	 XN2Pa0PRWmbCDOPT/MyTLeKVZVNYzLEXBXdttz+71Q1FtqOo14bItS/rDWlwm3Yy6m
	 cNFDx61cP6Tm9UCFlW+upR/wzowBlSPmfGq46AoOUJzW2Qvtl03JMP4f4O+t6yileI
	 CShVS8b7hy3XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] net: add copy_safe_from_sockptr() helper
Date: Tue, 19 Nov 2024 07:31:30 -0500
Message-ID: <20241119020537.3050784-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119020537.3050784-2-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 6309863b31dd80317cd7d6824820b44e254e2a9c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Eric Dumazet <edumazet@google.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Present (different SHA1: ae7f73e64e9b)      |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 01:37:21.875695197 -0500
+++ /tmp/tmp.N75ESVdFIm	2024-11-19 01:37:21.870628258 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 6309863b31dd80317cd7d6824820b44e254e2a9c ]
+
 copy_from_sockptr() helper is unsafe, unless callers
 did the prior check against user provided optlen.
 
@@ -25,12 +27,15 @@
 Signed-off-by: Eric Dumazet <edumazet@google.com>
 Link: https://lore.kernel.org/r/20240408082845.3957374-2-edumazet@google.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Stable-dep-of: 7a87441c9651 ("nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies")
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  include/linux/sockptr.h | 25 +++++++++++++++++++++++++
  1 file changed, 25 insertions(+)
 
 diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
-index 307961b41541a..317200cd3a603 100644
+index bae5e2369b4f..1c1a5d926b17 100644
 --- a/include/linux/sockptr.h
 +++ b/include/linux/sockptr.h
 @@ -50,11 +50,36 @@ static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
@@ -67,6 +72,9 @@
 +	return copy_from_sockptr(dst, optval, ksize);
 +}
 +
- static inline int copy_struct_from_sockptr(void *dst, size_t ksize,
- 		sockptr_t src, size_t usize)
+ static inline int copy_to_sockptr_offset(sockptr_t dst, size_t offset,
+ 		const void *src, size_t size)
  {
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

