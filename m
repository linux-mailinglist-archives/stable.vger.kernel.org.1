Return-Path: <stable+bounces-136796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E52A9E536
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 02:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29797AB802
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 23:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764CE1D6AA;
	Mon, 28 Apr 2025 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toQxu9oO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305488F77;
	Mon, 28 Apr 2025 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745798423; cv=none; b=nYP3TzMLX5y8lNdQBLN3vIvJ7B/pnq9mG/yeIzRm19b3roOGivsK5D71nPDy46GEo5Y68zF2v9N4V5Z+NUR6em7E5wxFhWpP2mddxclAGN+hYB46gE+zDvR2jaS1RQMYB8Kk08Av9Bpe7zSOkQW4SrCHJXlLBsQwkZPoKGGCSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745798423; c=relaxed/simple;
	bh=IU7HSUz+UthbAhhEiD8ZYvTSvQYphVH7wCBb1yhsLQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRD26qhcOPjFpXGzKQ7f5PXLpHKB+tyDQ1cmrIz9uW/V7OsK8cRQJNwBEpiGSrBJvs51bqBpjJfCr7QjWqbSIJqG74f83qj0Wtwj7M/Cuk6SWc3MtKvCrUPsWGN2xXBSGA7fdXFBBxtpp9H/oowQo5FL13e09QtO/jcPVYZj6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toQxu9oO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC53C4CEE3;
	Mon, 28 Apr 2025 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745798422;
	bh=IU7HSUz+UthbAhhEiD8ZYvTSvQYphVH7wCBb1yhsLQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=toQxu9oOpoZ2jxuhyxYqhFAv/OeiU6bydfBfy5nkt93/5a/lXDWuLb0ZavnBmXNhh
	 jgFLlKoazsLK/L1H68iK8iuXOfVeMI2S3tMLp73haqwPfxYWxT4gLYLvCeQF9CmXwA
	 Qt4jUOxqZIhG8gM4DJZ8jmxnvgvNo5hRslkrmhBoEv6fp/2jWdukpaQxncgqkaxkl6
	 vT2bYqcMqM2ChPCPQuNYypyNYcejXTtiNMmlgTMy96cmCuiO3ZhAUi/sl2J/kj1AIs
	 YIEDDMWelNMWfu/gXWSz07QTBBfWGRfZN/ArNH3XjenU3n+DvMQkSm+B1wSkcEkKa9
	 5etLPvEUCiWTQ==
Date: Sun, 27 Apr 2025 20:00:21 -0400
From: Sasha Levin <sashal@kernel.org>
To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	benjamin.berg@intel.com, linux-um@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.13 23/28] um: Rewrite the sigio workaround
 based on epoll and tgkill
Message-ID: <aA7FFcn6gjIC8jCe@lappy>
References: <20250407181224.3180941-1-sashal@kernel.org>
 <20250407181224.3180941-23-sashal@kernel.org>
 <621e867f-5427-4062-8783-e474e3dcdb3f@antgroup.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <621e867f-5427-4062-8783-e474e3dcdb3f@antgroup.com>

On Tue, Apr 08, 2025 at 12:38:12PM +0800, Tiwei Bie wrote:
>On 2025/4/8 02:12, Sasha Levin wrote:
>> From: Tiwei Bie <tiwei.btw@antgroup.com>
>>
>> [ Upstream commit 33c9da5dfb18c2ff5a88d01aca2cf253cd0ac3bc ]
>>
>> The existing sigio workaround implementation removes FDs from the
>> poll when events are triggered, requiring users to re-add them via
>> add_sigio_fd() after processing. This introduces a potential race
>> condition between FD removal in write_sigio_thread() and next_poll
>> update in __add_sigio_fd(), and is inefficient due to frequent FD
>> removal and re-addition. Rewrite the implementation based on epoll
>> and tgkill for improved efficiency and reliability.
>>
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>> Link: https://patch.msgid.link/20250315161910.4082396-2-tiwei.btw@antgroup.com
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  arch/um/drivers/random.c       |   2 +-
>>  arch/um/drivers/rtc_user.c     |   2 +-
>>  arch/um/include/shared/os.h    |   2 +-
>>  arch/um/include/shared/sigio.h |   1 -
>>  arch/um/kernel/sigio.c         |  26 ---
>>  arch/um/os-Linux/sigio.c       | 330 +++++----------------------------
>>  6 files changed, 47 insertions(+), 316 deletions(-)
>
>Please drop this patch. Thanks! Details can be found here:
>
>https://lore.kernel.org/linux-um/ffa0b6af-523d-4e3e-9952-92f5b04b82b3@antgroup.com/

Dropped, thanks.

-- 
Thanks,
Sasha

