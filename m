Return-Path: <stable+bounces-109458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5251DA15EA1
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 20:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6687A3447
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46C54723;
	Sat, 18 Jan 2025 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzzxN+9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3231B7F4
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737229254; cv=none; b=LphfTotcNPUblOLGQeu2y4sH2dwGV2kZGPJdG5e4P1gDDjSs4U/rqpyjnWfZ/4DRyA8DsWRhYouep9D+BV7dHbMoGLLLpct5eTMjDja9jcsBQq590KbK0sv5UpB42HUcXK0p/cfcJ7HTyEQQFoHV2iDcWSuB8CqZAohw2286Gjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737229254; c=relaxed/simple;
	bh=1xCr/HclmQFXziUk8CZ9DuhEzzFUsl0B943hJ9O7tto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FFQwl2tM9H0Xhe7N3TrF510ZPoSzTtd3fzHPvrYdx9yS2gZx/QAeMLaP9F9lSE8f5dlmsIio9D3OmFQNrdFJTsoLw0fdgrS+Q5sKvv42S5EmF1Aco0+1Wk2aAbXv+/iN23djpe8ngD8pfTe9VYOAb/5U/Fdp7ysmHNHdWUmV5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzzxN+9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE45DC4CED1;
	Sat, 18 Jan 2025 19:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737229253;
	bh=1xCr/HclmQFXziUk8CZ9DuhEzzFUsl0B943hJ9O7tto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BzzxN+9d6+O5c/3Unnc6GgWOO4UDhFm5a5iZgwXZeLnqKVQ4pyKdCIom61bXTLWoB
	 2+hMmRneUCOEGKozVOdj+cPRO+eP7QiEBRgvJxm8rMo45687p+aHkthPEsW+eKqc/T
	 +lcY/cTjzeozRxtnALIdpJhLWCJr6mImKQTMv4oI/xMT8zWfOLoe+hs12Az2H/8MVx
	 aopjagBvPtOxnf0uShxmQoM1FTnhNFce4OaenbFVkZ49t/5VN3ZS+G01kQc35SQDx7
	 BjOc/2VG580MEaScTaseiVip19aSPqj2M6iTwKRSF20mJ3zuMlO8NsRXhv6S1r2Ff5
	 b+iMDVMUfZebQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: hsimeliere.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6-v6.1] block: fix uaf for flush rq while iterating tags
Date: Sat, 18 Jan 2025 14:40:51 -0500
Message-Id: <20250118131628-4c44dbdc7c1071d4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250117144136.6631-1-hsimeliere.opensource@witekio.com>
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

The upstream commit SHA1 provided is correct: 3802f73bd80766d70f319658f334754164075bc3

WARNING: Author mismatch between patch and upstream commit:
Backport author: hsimeliere.opensource@witekio.com
Commit author: Yu Kuai<yukuai3@huawei.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 61092568f2a9)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  3802f73bd8076 ! 1:  e56389adaaf72 block: fix uaf for flush rq while iterating tags
    @@ Metadata
      ## Commit message ##
         block: fix uaf for flush rq while iterating tags
     
    +    [ Upstream commit 3802f73bd80766d70f319658f334754164075bc3 ]
    +
         blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
         checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
         in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
    @@ Commit message
         Reviewed-by: Ming Lei <ming.lei@redhat.com>
         Link: https://lore.kernel.org/r/20241104110005.1412161-1-yukuai1@huaweicloud.com
         Signed-off-by: Jens Axboe <axboe@kernel.dk>
    +    Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
    +    Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
     
      ## block/blk-sysfs.c ##
     @@ block/blk-sysfs.c: int blk_register_queue(struct gendisk *disk)
    @@ block/genhd.c: void del_gendisk(struct gendisk *disk)
     -	}
     +	else if (queue_is_mq(q))
     +		blk_mq_exit_queue(q);
    + }
    + EXPORT_SYMBOL(del_gendisk);
      
    - 	if (start_drain)
    - 		blk_unfreeze_release_lock(q, true, queue_dying);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

