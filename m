Return-Path: <stable+bounces-95720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25469DB909
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42AAFB23CA1
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CB91A9B30;
	Thu, 28 Nov 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k70CTfu7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE119CD01
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801395; cv=none; b=eciJ6yyUEZxQedA97c7cXds8yPU07+T2w5JmTnYRoqSdDs+zIR31IruBHc2AQkHD+ZkMYWyaIIAdwx/B13aSXxrv1CTTbTDZpqWV6XYpLwon/MzVQG3oMLTmqYERvO4UYnBvBS/5xDipP5XDjiQXbhJebk+kfk9FN1OGBVWNxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801395; c=relaxed/simple;
	bh=szBuLMtI9Plm5aeoFPE03HhX0SIHisR/n4LGvT4Mhj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZ+epYEAPuZfAnilPC9JHSD/QAfjjj5An8cY0w+L2IGjgEx2H1F11+U5tdEdUf8vVkGStXJZoZbG/nw0RFQMEdCWd8SYilDNNZC5bcuneLvTz9YWuyWVOqbtk3pLmlkl6hZSGr13ZVuSBgQDB2usXzvSXfWCR6ZEftcMQstBhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k70CTfu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3218C4CECE;
	Thu, 28 Nov 2024 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732801395;
	bh=szBuLMtI9Plm5aeoFPE03HhX0SIHisR/n4LGvT4Mhj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k70CTfu7EAceqtxTWCDBMTHKxkCZHmyi7hRakYEyFuNL2FIVp2afF/vMbS+z9jBmM
	 18Tq1yhr90jfFcojIeh/zqAXNLdFJCjZpELG9IUYVfv2Rk7mlFs+N1g0/GnBqLGvJv
	 VDDzaMxaOEVI5koUD2Omv5JS9EQMvXwOadZ0cBE5IpLIE/c3LMw+wt/dFj3Qo2Kwc+
	 fNwP72sgxfppUZiISJ8xWIlplrpqgMi2SLMuNJdBB1j4bCaoo+iPg5Y5vuCLVWdT24
	 f27Hn9qaZRqyVEIt4gKXA3IVIYytbjHSvkQx326L3IHjjT3QAuL76LIc7psi3lipv1
	 DmTm+eqfpzNyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] ntfs3: Add bounds checking to mi_enum_attr()
Date: Thu, 28 Nov 2024 07:57:03 -0500
Message-ID: <20241128062733-896f44e520bfeffe@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241128114240.4098561-1-bin.lan.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 556bdf27c2dd5c74a9caacbe524b943a6cd42d99

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: lei lu <llfamsec@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 809f9b419c75)
6.6.y | Present (different SHA1: 22cdf3be7d34)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-28 06:21:19.953621926 -0500
+++ /tmp/tmp.MGvAiQzuxM	2024-11-28 06:21:19.951379779 -0500
@@ -1,17 +1,20 @@
+[ Upstream commit 556bdf27c2dd5c74a9caacbe524b943a6cd42d99 ]
+
 Added bounds checking to make sure that every attr don't stray beyond
 valid memory region.
 
 Signed-off-by: lei lu <llfamsec@gmail.com>
 Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  fs/ntfs3/record.c | 23 ++++++++++-------------
  1 file changed, 10 insertions(+), 13 deletions(-)
 
 diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
-index 6c76503edc200..2a375247b3c09 100644
+index 7ab452710572..a332b925cb37 100644
 --- a/fs/ntfs3/record.c
 +++ b/fs/ntfs3/record.c
-@@ -223,28 +223,19 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
+@@ -217,28 +217,19 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
  		prev_type = 0;
  		attr = Add2Ptr(rec, off);
  	} else {
@@ -44,7 +47,7 @@
  	/* Can we use the first field (attr->type). */
  	if (off + 8 > used) {
  		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
-@@ -265,6 +256,12 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
+@@ -259,6 +250,12 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
  	if (t32 < prev_type)
  		return NULL;
  
@@ -57,3 +60,6 @@
  	/* Check overflow and boundary. */
  	if (off + asize < off || off + asize > used)
  		return NULL;
+-- 
+2.34.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

