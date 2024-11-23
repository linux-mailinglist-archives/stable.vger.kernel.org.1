Return-Path: <stable+bounces-94678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348AA9D696D
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 15:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE20A281B1C
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB92746B;
	Sat, 23 Nov 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn2NvPGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C7249EB
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372235; cv=none; b=bEpEf1jL8WWGM1zzsmLwotDVQSl4EJuZNOuu01oAqccEkR6Kyn/j+37re65UuB3uBrfFVZoVYImxobSiBSokWTF9+kjy1EFb11YE3iy8aNlXDuUjsSjoGG/Vb72fJjDhkfx9BIXyWxPlR9xtK3pGWspJZ5pdxYYqHPjWylg3C7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372235; c=relaxed/simple;
	bh=cV8Hb4xhQYSw9IWPNtaljo+MtjxC4ScDDPiF8B1nazc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWyOYxUxyrn/0kYr6wJlMY+jCZr/YiLeBhlxGF/rd3zC2dxwc9qDbCNtSgFDCAv8tm5zpeikrXU5btKw5+7XSC6IGx3jFpsCrsdjv5cNYpFpqSU/nuc7IXs231lc+Eelva81OSWcuuSKnbew7LxQm/XvX8sya2dwha4G0ycwTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn2NvPGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2024DC4CECD;
	Sat, 23 Nov 2024 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732372234;
	bh=cV8Hb4xhQYSw9IWPNtaljo+MtjxC4ScDDPiF8B1nazc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mn2NvPGOnS2i4ZbIlGmW/vuaobB/QcInqjbvQzGGoMiQLkGNQ+SEv4ukSzOaXHI7G
	 5qfk2OOETSLYupuuGWoTeIVYxLAPasguumCOaqaIR9dYPTQXtIxRldfywHjsp9yVSQ
	 +kGeRywKVNGMJoRGePv5SX0BJ+r7tKdfzGmoBliNoajnT1QCSSTPLmIyYIZZViigJO
	 +qRAA9LEtLPzRgslXqoWbgpYEs/+2cUMpV+kEx2ynmCBBVepv9bZvAP6GFiGYypTz/
	 manw8WvPAbsgPr/ahlzZReseuPK9Psh4U53u5mA7cjF2X1DeIiN/0kW8A6LjXaT4Cn
	 5eK0WDVNblFlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 05/31] drm/xe/kunit: Simplify xe_dma_buf live tests code layout
Date: Sat, 23 Nov 2024 09:30:32 -0500
Message-ID: <20241123091401-3cbb029eeac20c29@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122210719.213373-6-lucas.demarchi@intel.com>
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

The upstream commit SHA1 provided is correct: ff10c99ab1e644fed578dce13e94e372d2c688c3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lucas De Marchi <lucas.demarchi@intel.com>
Commit author: Michal Wajdeczko <michal.wajdeczko@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-23 09:03:30.172146718 -0500
+++ /tmp/tmp.4Fq75jAh8B	2024-11-23 09:03:30.168217727 -0500
@@ -1,3 +1,5 @@
+commit ff10c99ab1e644fed578dce13e94e372d2c688c3 upstream.
+
 The test case logic is implemented by the functions compiled as
 part of the core Xe driver module and then exported to build and
 register the test suite in the live test module.
@@ -10,6 +12,7 @@
 Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
 Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
 Link: https://patchwork.freedesktop.org/patch/msgid/20240708111210.1154-3-michal.wajdeczko@intel.com
+Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
 ---
  drivers/gpu/drm/xe/tests/Makefile           |  1 -
  drivers/gpu/drm/xe/tests/xe_dma_buf.c       | 16 +++++++++++++---
@@ -126,3 +129,6 @@
  
  MODULE_AUTHOR("Intel Corporation");
  MODULE_LICENSE("GPL");
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

