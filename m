Return-Path: <stable+bounces-144417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C2AB7687
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F408C7AE8
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C6429616D;
	Wed, 14 May 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyyW9NuZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EBD295DAD
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253585; cv=none; b=jel2F5T7h73l47pTXTiTbzVIk0IYSCuEWzq/U381PvnM+7ct4gxUY1hLdRyB0eREjUjc/SbrigiRUjGXjLG5NdoT9oamN4tpTz+JqN8vjG/HbVQsb2DzcK6vWiZYkEs5C4TVXjePNiOjhIOeCmt9+E1Q1Oaz1CUHXxwidgLsnpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253585; c=relaxed/simple;
	bh=PQBSc6CuJGuoyOT0G5pxaQzdhwzuyY6wOsvSZlrrw6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQ6iJgGd15wlrJ70X+C7GDyjB2b/yVcV1fnU/1GI2OeGko8qIG1VXnb7MHC+R9Pg9AU16sqlUJ3thKKZBd9XRPhG1sqkXm56HtiCvYu16AS7ms7slnYIxC7VSKQ19BjErFGPL9ycaEUG71FXYKCv3rhS8a1auk5Gr7omQhH/BF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyyW9NuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57C1C4CEF0;
	Wed, 14 May 2025 20:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253584;
	bh=PQBSc6CuJGuoyOT0G5pxaQzdhwzuyY6wOsvSZlrrw6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyyW9NuZKqSTbSG4m8dj7s/kAxbo8kL1kqayg+y4W1Jqv0DPQr8oqFTiKx5ORaAYl
	 KAkuSKWTsSc+JzP+znyT232uhE3RcnvjKXLep+8TII7AP+n2aplp64eyeDGSSgZ9hv
	 lMq9AkBzpxGrUEKpjuBWgK+CL2fJV08AWGDjg9sDnJXNy0FrFa+PKEgEvBlDulFdLQ
	 0rcHlJQ3AkWMSKPmp4O5is5CK2XxPJORnqNw2E3rZKL798VUUPiaa2JCLgeCLp6eOL
	 FwI747/vphQxtmRfobXJLTp9EVbx4/AyrbV5Qs5Ah95W0soRmSXQJIaVyWTSmBlIDQ
	 xxRvTL/WMPvjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/3] x86/alternative: Optimize returns patching
Date: Wed, 14 May 2025 16:13:00 -0400
Message-Id: <20250514103039-75f3bd3f6b74b03f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-fixes-6-1-v1-1-757b4ab02c79@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: d2408e043e7296017420aa5929b3bba4d5e61013

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Borislav Petkov (AMD)<bp@alien8.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Found fixes commits:
4ba89dd6ddec x86/alternatives: Remove faulty optimization

Note: The patch differs from the upstream commit:
---
1:  d2408e043e729 < -:  ------------- x86/alternative: Optimize returns patching
-:  ------------- > 1:  02b72ccb5f9df Linux 6.1.138
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

