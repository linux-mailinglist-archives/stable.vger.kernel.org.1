Return-Path: <stable+bounces-94683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443D9D6973
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 15:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF9E281AB5
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8183E224F0;
	Sat, 23 Nov 2024 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5YlYlaJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC53208A9
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372245; cv=none; b=Gm0gnLlGj1y4U2/CVQvJNzbLuGeVyRGOoIm9PqeEhq/sIJnM5QUTZVCP4+NldEqyZukZIn0cIi7vWgxrkmpsU6psQvLDi9Y2yPdaPOm7haRlp/h2u0ck3VMpesNqWrzkOsfHnqKq8sPdGXF2iA/NtwzyliI7wH9orMOgprNjZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372245; c=relaxed/simple;
	bh=G1UU8+hu2srABMQlsEX+eJgo0XX2WgXp68NKc/8I8hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFTjUEOGlEs5CREBsljnTeWe5ZIaH2sSwdUNhis+b+fv3JZvvnbO2SmJnPChxoHh0yJx4LPz2uUmZi2sdKmJ/nWZUBKd8vATCxeZqG8xConx6M4YfRbQ9jeXibWjhDfMdKsBxtY++7loUFJUYmWnLrUF8bI9ZJRN/dULSrFWPVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5YlYlaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F22C4CECD;
	Sat, 23 Nov 2024 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732372244;
	bh=G1UU8+hu2srABMQlsEX+eJgo0XX2WgXp68NKc/8I8hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5YlYlaJuOwDkf/wHke2V/C8MLXz+42k8krb0PYOzU5PxQoQYyul7MD3hIKTdq2p0
	 EZFUkYPb0ostihZEfq0pKBchtFgRa3xh7KFNMu8zLUnlYaGsjQH07TxL6tycZMr5Zw
	 9MhHOTlxlsTDKNi5RsoeVerowRtv41mEsH4YhaAQfzz4f+Z4jg7KlnelrbVqDeXDWV
	 DDhu1lLvOli74KhvYwZwSOAftTYteji5Z5m3DjT/lCjAgdWW5aIwaG70rcJOiA0AeI
	 8xB3wrY5sbEIw3C7T5w3Tv5CT9G5H2rl0f1CFn+19Zm5rgbIXzfwhueMk6niNlbEik
	 Tet0i/WBb79Yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 03/31] drm/xe/kunit: Kill xe_cur_kunit()
Date: Sat, 23 Nov 2024 09:30:42 -0500
Message-ID: <20241123085417-8cf09048320e1d0d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122210719.213373-4-lucas.demarchi@intel.com>
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

The upstream commit SHA1 provided is correct: bd85e00fa489f5374c2bad0eac15842d2ec68045

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lucas De Marchi <lucas.demarchi@intel.com>
Commit author: Michal Wajdeczko <michal.wajdeczko@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-23 08:44:57.402624667 -0500
+++ /tmp/tmp.fA20PN065W	2024-11-23 08:44:57.395856119 -0500
@@ -1,8 +1,11 @@
+commit bd85e00fa489f5374c2bad0eac15842d2ec68045 upstream.
+
 We shouldn't use custom helper if there is a official one.
 
 Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
 Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
 Link: https://patchwork.freedesktop.org/patch/msgid/20240705191057.1110-2-michal.wajdeczko@intel.com
+Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
 ---
  drivers/gpu/drm/xe/tests/xe_bo.c       | 4 ++--
  drivers/gpu/drm/xe/tests/xe_dma_buf.c  | 4 ++--
@@ -174,3 +177,6 @@
  #define xe_cur_kunit_priv(_id) NULL
  
  #endif
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

