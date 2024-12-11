Return-Path: <stable+bounces-100676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D6E9ED1FE
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DBE1662ED
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AE81D619D;
	Wed, 11 Dec 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6+iKf55"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8441A707A
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934805; cv=none; b=gIqZ9H5KFxSojZNQ0FFMAf/Mg1PQACixRD2Dn+Khx19+yfSZz0GRPpw+loPanjws0AcSccwqG1VZtjQEwyz7XlEMSAzsjgyo2W3LBOUQR9KmhQ85Oqbbos/PJJeuIMzMsFr4LEVHWl5x9/k1xiTxTt7oVLAhjFNx2LJHXu37ohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934805; c=relaxed/simple;
	bh=plYolokGNcEF/3TixF8KVmUwyZj7bvNkVBhLjnFFPrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9mqLQVJnn33ZujWuhy4Z03shFeEvYCEbL1SEds8GUKcSiYobwNkNvCaVSPe+RNNQEFJRVla3A+w40psDFTeD3hj8m4u5P0/DtAChh9hHpWPngWVo/RGotcFhLguFkM2zvlZW7bQYP0B3YZuzXASR2MxUskhi+653hPdIyTuXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6+iKf55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71134C4CED2;
	Wed, 11 Dec 2024 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934804;
	bh=plYolokGNcEF/3TixF8KVmUwyZj7bvNkVBhLjnFFPrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6+iKf55nzCpmOqIXnNLai9PX50Vg3xQrJcjZokSnARoprwyxVl4IL9ePG2PlSQ+f
	 fKzweS+e+CjOtlZnrvGnAgahjx/0jblEnyFOeYrF/3eOnT9cGCnxg9bNNkH9P9rkb/
	 tleWQdL1PSk1jxDswEqrMcKqNODUTxMPRBoBW4LjWDBwgSgr0L09JmSA3WfN/xMA3f
	 9iJSY0apvvkFyAJId/9RckSIMZ6zLJM2BX/ua2lQNd05RYhSucGYGMWfxnywUKAPzk
	 LCjnBJ/7Rejo/jRAcUBkPCcGAdxUNNS6CizJBcQc6TCnwX4DgpcuL2vtmjoMB/qQEy
	 L16NbV16X/cwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH][5.15.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Wed, 11 Dec 2024 11:33:23 -0500
Message-ID: <20241211112920-a74a3c57047e24e5@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211083954.3406361-1-guocai.he.cn@windriver.com>
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

The claimed upstream commit SHA1 (7ad4e0a4f61c57c3ca291ee010a9d677d0199fba) was not found.
However, I found a matching commit: bdcb8aa434c6d36b5c215d02a9ef07551be25a37

WARNING: Author mismatch between patch and found commit:
Backport author: guocai.he.cn@windriver.com
Commit author: Juntong Deng <juntong.deng@outlook.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 08a28272faa7)
6.1.y | Present (different SHA1: 7ad4e0a4f61c)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bdcb8aa434c6d < -:  ------------- gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
-:  ------------- > 1:  0f941fc07b046 gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

