Return-Path: <stable+bounces-134603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F43A93A05
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1742F1B66AC6
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C231F213E7A;
	Fri, 18 Apr 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6OgKu+X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA721421C
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990961; cv=none; b=J3g801OtWjMGJx0VJXhpJDxJrV4rJ++GJ4rtrIwZaJJqh9+smXJpRz4ISuY7CnGlBU2h6fdufFhvimhIEb3CJUloRSWF5Fh+GC190H3gABezV2WLsTTzGdtwK4XKosgEzxQI51C05PqOmcEp9Ko1UHBo2lP6LVYbr+Sj8JMYo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990961; c=relaxed/simple;
	bh=VS2bqw862oa44SrwZOk2DCiVbX7r683OxutX64dY77c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSvjih2GOUODJ8A0A55ghtSBT3oOWeGHvQzeBuCDKfhBpMNsQuNbi9H0nLj9lCm5zAJheI2EKtMlexbgD0sBkZQ5R/n6RwI0j3vpQ7Fz4R8LDQ2DOzv5Cm7PIPI3cwY5yPwZo9Sw2/WxMEa6PNJaOZqnMJtWRgq2QZsTbTug/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6OgKu+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D75BC4CEE2;
	Fri, 18 Apr 2025 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990961;
	bh=VS2bqw862oa44SrwZOk2DCiVbX7r683OxutX64dY77c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h6OgKu+XzK8uL0qUs/KobIdlTWIQYH2wKCdgBj2Pi+P9Wv/bdYt6vQIpEVun9L5VE
	 +8uSA7odlR2qCxMb6kwR9+ed1JVSIDuFnzuhkSMwSCEs6ETVlWtkEIF1u/J99NGcHF
	 JuBmgz7jTYxRZK/M4xqkySX5KF6W2/dg+cWsQbQnipK46cxa6yfQAQAseoafkLOC/B
	 ZjZvb06NQkSNLSHDf+ms437LE+WVPz0KLdWP30XRL4TwD6PsYyrAdXjZlxOS7+jY/n
	 wknOuyVKb4+uumC//3S+MMqhv6VGUMOWVMzklYMyJWscqZWKf/4LLi1heVfRZCV7pw
	 6/VtKpgu/jihw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15/5.10 1/2] blk-cgroup: support to track if policy is online
Date: Fri, 18 Apr 2025 11:42:39 -0400
Message-Id: <20250418101713-568f155142889ec4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250417073352.2675645-1-bin.lan.cn@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: dfd6200a095440b663099d8d42f1efb0175a1ce3

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Yu Kuai<yukuai3@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  dfd6200a09544 ! 1:  d888a08386872 blk-cgroup: support to track if policy is online
    @@ Metadata
      ## Commit message ##
         blk-cgroup: support to track if policy is online
     
    +    [ Upstream commit dfd6200a095440b663099d8d42f1efb0175a1ce3 ]
    +
         A new field 'online' is added to blkg_policy_data to fix following
         2 problem:
     
    @@ Commit message
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Link: https://lore.kernel.org/r/20230119110350.2287325-3-yukuai1@huaweicloud.com
         Signed-off-by: Jens Axboe <axboe@kernel.dk>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## block/blk-cgroup.c ##
    -@@ block/blk-cgroup.c: static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
    +@@ block/blk-cgroup.c: static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
      		blkg->pd[i] = pd;
      		pd->blkg = blkg;
      		pd->plid = i;
    @@ block/blk-cgroup.c: static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, stru
      	}
      
      	return blkg;
    -@@ block/blk-cgroup.c: static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
    +@@ block/blk-cgroup.c: static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
      		for (i = 0; i < BLKCG_MAX_POLS; i++) {
      			struct blkcg_policy *pol = blkcg_policy[i];
      
    @@ block/blk-cgroup.c: void blkcg_deactivate_policy(struct request_queue *q,
      			pol->pd_free_fn(blkg->pd[pol->plid]);
      			blkg->pd[pol->plid] = NULL;
     
    - ## block/blk-cgroup.h ##
    -@@ block/blk-cgroup.h: struct blkg_policy_data {
    + ## include/linux/blk-cgroup.h ##
    +@@ include/linux/blk-cgroup.h: struct blkg_policy_data {
      	/* the blkg and policy id this per-policy data belongs to */
      	struct blkcg_gq			*blkg;
      	int				plid;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

