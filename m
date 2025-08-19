Return-Path: <stable+bounces-171799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7156B2C727
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658E617CF63
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1F0273D67;
	Tue, 19 Aug 2025 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEaSC0rW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD4273803
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613939; cv=none; b=QzK39JeCrjLgtP7UTI/VeGf+ptLUCqY/PplsJ94X8BFxSmckFUWLu7QZi+58rsQGsv6wCbcGRCTAvZnxfoSQkUW1hZ0uF+IrrFeR7OdSP8zdsBMo7ZIYFjwMsBd0jToIgXHCx4ER1E8zfruGt/pOAMJtaEgjCQ+ptrq/8AzZyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613939; c=relaxed/simple;
	bh=dS21bU1/zFc9th5K4PM+H/argbckZecsihtwt3L3t5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlHKazBDmSxQjMwr+BGX0cl2rNC08lsZ/qLRY7WXS3da82ByLWbZPS8/MWeSsdST/UBu1RcG+qukEQ0z+8FFiOMjfbdnjWNA8nv5TckVvIX8VyW6Fo5b7XuvOjOfdKX4+HCy8jxBOYnpWpugw3JrZS9hxaNVI7fsY7ts56tW52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEaSC0rW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529A3C4CEF1;
	Tue, 19 Aug 2025 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613939;
	bh=dS21bU1/zFc9th5K4PM+H/argbckZecsihtwt3L3t5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEaSC0rWYj0VwhqRp57FpAqXmPoacifEj5GuCxa+6nIpJ9ThBjXDG4X10OF1g1Ayp
	 X+WiVA8QmiMwVYs9U0+IyOJbjb8DyLLDME1uVY0fVT4Z7044WcWz4bmiETP8QCMq3P
	 LTpXdb5IvsJKPVUdrle1Z5NCdjfTQZNAkSLRmxe6NDwM7yL229bSGqSl8mIuOjafPP
	 0OW1mzWR+P6nWqljqmONkcdQKHWEqr6hmRjE8L/ObxnMe7cNhaaKMbqRYswuruEckk
	 /Ys7EKJoaPgnXpb3tKzvVhxtPBKvVnWOwQwN8VCvrnz8qVec36MDEQwDCRMzvMJVxE
	 xCbHEMoJJe+eg==
Date: Tue, 19 Aug 2025 10:32:18 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: stable@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.6.y 2/2] btrfs: constify more pointer parameters
Message-ID: <aKSK8rNSFR3TrhH3@laps>
References: <2025081832-unearned-monopoly-13b1@gregkh>
 <20250819022753.281349-1-sashal@kernel.org>
 <20250819022753.281349-2-sashal@kernel.org>
 <20250819121837.GR22430@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819121837.GR22430@suse.cz>

On Tue, Aug 19, 2025 at 02:18:37PM +0200, David Sterba wrote:
>On Mon, Aug 18, 2025 at 10:27:53PM -0400, Sasha Levin wrote:
>> From: David Sterba <dsterba@suse.com>
>>
>> [ Upstream commit ca283ea9920ac20ae23ed398b693db3121045019 ]
>>
>> Continue adding const to parameters.  This is for clarity and minor
>> addition to safety. There are some minor effects, in the assembly code
>> and .ko measured on release config.
>>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>What's the rationale for adding this to stable? Parameter constification
>is for programmers and to have cleaner interfaces but there's hardly any
>stability improvement.

When patches that assume that params are consts get backported, they tend to
break the build on older trees that don't have these "constification" changes.

In this case, without this patch, backporting 807d9023e75f ("btrfs: fix
ssd_spread overallocation") will cause the build error below, which is what
made Greg generate this FAILED email:

fs/btrfs/extent-tree.c: In function ‘find_free_extent_check_size_class’:
fs/btrfs/extent-tree.c:3538:54: error: passing argument 1 of ‘btrfs_block_group_should_use_size_class’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  3538 |         if (!btrfs_block_group_should_use_size_class(bg))
       |                                                      ^~
In file included from fs/btrfs/extent-tree.h:7,
                  from fs/btrfs/extent-tree.c:20:
fs/btrfs/block-group.h:375:72: note: expected ‘struct btrfs_block_group *’ but argument is of type ‘const struct btrfs_block_group *’
   375 | bool btrfs_block_group_should_use_size_class(struct btrfs_block_group *bg);
       |                                              ~~~~~~~~~~~~~~~~~~~~~~~~~~^~

So we take the constification patch to fix the issue.

-- 
Thanks,
Sasha

