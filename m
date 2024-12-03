Return-Path: <stable+bounces-96932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 967809E2998
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E5BA43F0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD261F7584;
	Tue,  3 Dec 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zqTYZ3Fv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EBA1F7560;
	Tue,  3 Dec 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239016; cv=none; b=BJZLRwLs3QkrQOyxzMmZKi943Al+DPuDTBgv8oj7EVkGiIC8xCE1z4IlvIf3DMjmNbrM9MrS0HwkSNAICri/1Yx8kAxd8IW9TTJmIT619Lyq5qQ5iwl9E1b9JE6Kw5uOnXj4IZXB8MpoyZHgfUWmceMe1ncZtLYaolmYKeoO/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239016; c=relaxed/simple;
	bh=GHyMUh7kD8Ad9sS7oqQYXmiXxu3Wak19mM2KGQ1IJrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmyrX1JjtBxHnaMraOWpyp2XuFrJiDW+PyivadlHhPVII0oQ0ydPvK9SAReGXl2vUHTcuL/6NUSH0llnU5e1Vx0FtJh83mx7aOVdaASJO+UgqhmrJwvB0hIxEHlNjVtd+p8oFOXOWhQ6VJ2mMpi15dmcQqNffTu6TkscOaGgl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zqTYZ3Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD7CC4CECF;
	Tue,  3 Dec 2024 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239016;
	bh=GHyMUh7kD8Ad9sS7oqQYXmiXxu3Wak19mM2KGQ1IJrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zqTYZ3FvPnRyZJVXVJQ0GmmpS6v4+HnsgLKVOUrTb9CiVrozGmE8DJUB0EZhWSKp1
	 X97XmHnGHIU8b6V8SOwhimLYYFmGSqy8u25DGVqzJWugjSgN1WwKLjzEAsCJCnhBZd
	 A+2Dm/bY4ABcCcdY13GpwKbMLrywMtXgEkcv8EB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 444/817] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
Date: Tue,  3 Dec 2024 15:40:16 +0100
Message-ID: <20241203144013.210849656@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

[ Upstream commit b064043d9565786b385f85e6436ca5716bbd5552 ]

Rename tdx_parse_tdinfo() to tdx_setup() and move setting NOTIFY_ENABLES
there.

The function will be extended to adjust TD configuration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20241104103803.195705-3-kirill.shutemov%40linux.intel.com
Stable-dep-of: f65aa0ad79fc ("x86/tdx: Dynamically disable SEPT violations from causing #VEs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c74bb9e7d7a35..28b321a95a5e8 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -194,7 +194,7 @@ static void __noreturn tdx_panic(const char *msg)
 		__tdx_hypercall(&args);
 }
 
-static void tdx_parse_tdinfo(u64 *cc_mask)
+static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
 	unsigned int gpa_width;
@@ -219,6 +219,9 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
+	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
+	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
+
 	/*
 	 * The kernel can not handle #VE's when accessing normal kernel
 	 * memory.  Ensure that no #VE will be delivered for accesses to
@@ -969,11 +972,11 @@ void __init tdx_early_init(void)
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 	cc_vendor = CC_VENDOR_INTEL;
-	tdx_parse_tdinfo(&cc_mask);
-	cc_set_mask(cc_mask);
 
-	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
+	/* Configure the TD */
+	tdx_setup(&cc_mask);
+
+	cc_set_mask(cc_mask);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
-- 
2.43.0




