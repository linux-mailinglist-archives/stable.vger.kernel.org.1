Return-Path: <stable+bounces-152657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C13ADA214
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1F83B1AE2
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 14:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00BF13B5A9;
	Sun, 15 Jun 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSfuSEXP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D412B9A6;
	Sun, 15 Jun 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749997763; cv=none; b=NUR8IUzLTf3drqA5nFvzQGeLQ8nmu1UApA3H5CVMCtWnFW2uKw5Q4wEY0QmlAPwdm7z7SmTAHfr7jTpxUHhqGxhRpb5rB2fXUl1B29dRjPlxE8Jb3YfVE1n0+Rj3jpUetsfq7HFeSxluzk/4iWPFmBvRnMjJEr2qLiPGLiz1EYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749997763; c=relaxed/simple;
	bh=HG5zvQd0Kmem+EVKNJ8q2gma9d1akCzQ/we4ELacdPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIbORgPFoF7Xb2POB68/bxw1DNlUAq89HfRHSE8l5CLLpTBYujxWOSYqJHaYoLaMG/Mz+6KRE9kSDLSYX+yW5UM3EYBbSS7BreWP4Vep0ONois693NdnS2yx5Nh+072d42nnyGZzGO3q/eUZ4Txc7QNUMIZfKNPAnLiNHCf2+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSfuSEXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E6BC4CEE3;
	Sun, 15 Jun 2025 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749997763;
	bh=HG5zvQd0Kmem+EVKNJ8q2gma9d1akCzQ/we4ELacdPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSfuSEXPBkrMauxl14PjUhzuRyhSXR1Un1iOV/t6AGJBgiZ/53Gccdb3Az2P1D4xM
	 +MlRbOup+J5/qS1P23S9FJ5+l5Gkyi6zfcjt8eYz4lZJr8aTbhGZXqgh5iiOQTqUbA
	 IryMHmsRGpCbIlF0Z+DxnonBk9js+BCo+fvYPwSlRByRaDdnBkg6CDhujk4gKsxbGT
	 nP4Ml9ucwpHQqA3jUBF42Lsk70IUGK4wBqfWBfBCDPgs9NLEY6dxkIN/JSQXJpLtHY
	 PQggFT1UQi0M2AucizKrDA1rQJwwK3zL3sezw55JTkRl1SGIriYdOgmkgCscW3J/J4
	 slEFuB+DfJKrg==
Date: Sun, 15 Jun 2025 10:29:21 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Patch "Bluetooth: MGMT: Remove unused mgmt_pending_find_data"
 has been added to the 6.12-stable tree
Message-ID: <aE7Ywdz3uQGHPdOI@lappy>
References: <20250615130532.1082031-1-sashal@kernel.org>
 <aE7GBFMk20Ipl7rn@gallifrey>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aE7GBFMk20Ipl7rn@gallifrey>

On Sun, Jun 15, 2025 at 01:09:24PM +0000, Dr. David Alan Gilbert wrote:
>* Sasha Levin (sashal@kernel.org) wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     Bluetooth: MGMT: Remove unused mgmt_pending_find_data
>>
>> to the 6.12-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      bluetooth-mgmt-remove-unused-mgmt_pending_find_data.patch
>> and it can be found in the queue-6.12 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>It's a cleanup only, so I wouldn't backport it unless it makes backporting
>a useful patch easier.

Right, it was taken as a dependency to make a later patch apply cleanly:

>>     Stable-dep-of: 6fe26f694c82 ("Bluetooth: MGMT: Protect mgmt_pending list with its own lock")

-- 
Thanks,
Sasha

