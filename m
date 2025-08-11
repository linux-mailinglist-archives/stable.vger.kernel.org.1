Return-Path: <stable+bounces-167075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD9AB2186E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 00:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9516189E5FD
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 22:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35511F4E34;
	Mon, 11 Aug 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk7+15uw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5C38DD3
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951427; cv=none; b=ObpPrz0UmwE7qs7poi/xbaIZJPYb6z4qylQcO6kGX4+CXIye2Fso3ZRDDJjc9PoodY94q3gFoELoRRqYPZzAjwfVl5WYlU2ivpyS9YuevSqeEeamYxynWar9ZD0ozPPeGTWKx8CP1eGnMpDXSk4yoVs70xkkXsMlZy+MMehNykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951427; c=relaxed/simple;
	bh=WHw5kKuecyBTm4zU32qMum0zns0rhJwMUA945ARwP9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ev9gg6J0y2DCVX8Hs7VtvKayk2dnkBeWD+m6H1FCANI8L7dkG5xbfWuF6DOqO2W5oCRE2nK0AWz6XJgAq2QJ+Fbr1dlNL8h8l2rHglmx9Pri0jxZDjcV92Xo3YctvsnqFQpHHJtkVqqnWmPdJLh+PBnOLKn1ZVFoS+EZbZnuFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk7+15uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E2EC4CEED;
	Mon, 11 Aug 2025 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754951427;
	bh=WHw5kKuecyBTm4zU32qMum0zns0rhJwMUA945ARwP9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mk7+15uw0shcyqI+QQNc21Y+SIToACZxMzKgTQ8k9w9tJ1MeHwoPlGZ8QusUfMUUT
	 EkkWL7a+y1AU19vQkWXpaWSXbztohGTZw93tb1EWSAZerDOUkctxpID4JHilCAiCaX
	 OB9cHsXsmHoT89vk+EpTUcvenVEfF2qwEImO/BfsmCiRx+TitkEWG5k07kHMFc2GYK
	 150CqKC1sDlj9wx9seinCk7yjeOYrWriOstNn3uZ/EFBNi8mUhLfwDchXj4HevRyJv
	 LLnqY+I9/YY4PYne2hF9ex2UgQrtytlTuU4rQjTXKM4NIRyhD1PJjWOsZcXOktfKIu
	 2dNSn5n16KSxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2 v5.10] dm: rearrange core declarations for extended use from  dm-zone.c
Date: Mon, 11 Aug 2025 18:30:24 -0400
Message-Id: <1754925042-4d326ede@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811052702.145189-2-shivani.agarwal@broadcom.com>
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

The upstream commit SHA1 provided is correct: e2118b3c3d94289852417f70ec128c25f4833aad

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shivani Agarwal <shivani.agarwal@broadcom.com>
Commit author: Damien Le Moal <damien.lemoal@wdc.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  e2118b3c3d94 ! 1:  e83906552e29 dm: rearrange core declarations for extended use from dm-zone.c
    @@ Metadata
      ## Commit message ##
         dm: rearrange core declarations for extended use from dm-zone.c
     
    +    commit e2118b3c3d94289852417f70ec128c25f4833aad upstream.
    +
         Move the definitions of struct dm_target_io, struct dm_io and the bits
         of the flags field of struct mapped_device from dm.c to dm-core.h to
         make them usable from dm-zone.c. For the same reason, declare
    @@ Commit message
         Reviewed-by: Hannes Reinecke <hare@suse.de>
         Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
         Signed-off-by: Mike Snitzer <snitzer@redhat.com>
    +    [Shivani: Modified to apply on 5.10.y]
    +    Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
     
      ## drivers/md/dm-core.h ##
     @@ drivers/md/dm-core.h: struct mapped_device {
    @@ drivers/md/dm-core.h: struct mapped_device {
      void disable_write_same(struct mapped_device *md);
      void disable_write_zeroes(struct mapped_device *md);
     @@ drivers/md/dm-core.h: struct dm_table {
    - #endif
    + 	struct dm_md_mempools *mempools;
      };
      
     +/*
    @@ drivers/md/dm.c: struct clone_info {
     -	struct dm_target_io tio;
     -};
     -
    - #define DM_TARGET_IO_BIO_OFFSET (offsetof(struct dm_target_io, clone))
    - #define DM_IO_BIO_OFFSET \
    - 	(offsetof(struct dm_target_io, clone) + offsetof(struct dm_io, tio))
    + void *dm_per_bio_data(struct bio *bio, size_t data_size)
    + {
    + 	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
     @@ drivers/md/dm.c: EXPORT_SYMBOL_GPL(dm_bio_get_target_bio_nr);
      
      #define MINOR_ALLOCED ((void *)-1)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

