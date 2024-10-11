Return-Path: <stable+bounces-83441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF599A37B
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 14:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5531F21837
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02D21500F;
	Fri, 11 Oct 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW0DGp7y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD119923C
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648748; cv=none; b=hhiGddcBt2ufEwWHV3qYx5DeOhQBFgYxuOsWFf45OtgDRmqfZMEXiA/Hiq5E5MmmTqYGsOrh088Kc1YZGEvJbv7B8vpLZQZsIlWoWDRY08MX+DAbk8JaLCZ3aLKAqWpwrnKwkBl//QkyJR2ZuSkqjp6MWssjSZT6L4xuJ9QL8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648748; c=relaxed/simple;
	bh=pthbJVocnuF2tKe9LzoHKqYPYh55qaegrUEbEf7+O1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvSUbW7X2JK7t4WoBxaSvCcUJhNtorzQYf7LaM13/1JEAnEVE9VlC5PstgYRCVIqmws9mmXxuNueksV+bzIEt7VB0+sFcapF+LBaqi6kw1sl29ulw78FsJ7Ta+0fgiuAs+8+qPovCYc5/N7LyNFUreAZv3KoVDXLUr4AQqIglsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW0DGp7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83463C4CEC3;
	Fri, 11 Oct 2024 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648745;
	bh=pthbJVocnuF2tKe9LzoHKqYPYh55qaegrUEbEf7+O1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QW0DGp7yrV5aFhQ2xLd/CAFTRg1AsrYfFkUEslZ46ppaoGUQawgNGdt+h+s+oeX6n
	 uLXyoSc78GwauWKyCuhQMr8BDaAoZNwAi4eCdkgDLV5SLgG7hTW7NaehG3uxznDyQl
	 oHVzWGsAZOscCRrPsyFLzz0YbzWCSt8C+JM30W5LtpDXkT418aunGu9TL/MsR3exDo
	 KS6BRYM9HK3SxjKj25Zf90PQCbDmI5nYmAZzj21xKtRVQg4Z+GbsNToZxwNujeRzIC
	 0qWA1byEctWk80WFcZEyid8oneKCi/dAFjEAohBX0PjKIqeiiWjwssHqJnirvTEKPB
	 VCiKEvrk2EqXw==
Date: Fri, 11 Oct 2024 08:12:23 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christoph Hellwig <hch@infradead.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	kernel-dev@igalia.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6.1 3/3] blk-integrity: register sysfs attributes on
 struct device
Message-ID: <ZwkWJ-ya6-z0Cj9Z@sashalap>
References: <20241008165145.4170229-1-cascardo@igalia.com>
 <20241008165145.4170229-4-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008165145.4170229-4-cascardo@igalia.com>

On Tue, Oct 08, 2024 at 01:51:45PM -0300, Thadeu Lima de Souza Cascardo wrote:
>From: Thomas Weiﬂschuh <linux@weissschuh.net>
>
>Upstream commit ff53cd52d9bdbf4074d2bbe9b591729997780bd3.
>
>The "integrity" kobject only acted as a holder for static sysfs entries.
>It also was embedded into struct gendisk without managing it, violating
>assumptions of the driver core.
>
>Instead register the sysfs entries directly onto the struct device.
>
>Also drop the now unused member integrity_kobj from struct gendisk.
>
>Suggested-by: Christoph Hellwig <hch@infradead.org>
>Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
>Reviewed-by: Christoph Hellwig <hch@lst.de>
>Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>Link: https://lore.kernel.org/r/20230309-kobj_release-gendisk_integrity-v3-3-ceccb4493c46@weissschuh.net
>Signed-off-by: Jens Axboe <axboe@kernel.dk>
>[cascardo: conflict because of constification of integrity_ktype]
>Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

I've queued these up, thanks!

-- 
Thanks,
Sasha

