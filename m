Return-Path: <stable+bounces-94045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402789D29A2
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 16:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDC528169B
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC3A1CEEB9;
	Tue, 19 Nov 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0/zfugY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB91CF5C7
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030213; cv=none; b=UeboH+lDCyMPjmKYu1Dtzf7xXfMdueXQ6FTRwGhqVJjlbrjz37SccAJhQfUlpp9qggjJU7nwGccMLhKafQRYAvdLJQ2Wz8zUkFX3BAiTtgvC5YgrS0+XUC6A1u7UgjDLWlxSx+Q6rszEgUj3kT2PDAZyDGYXkLA1ixrIyOZ+JHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030213; c=relaxed/simple;
	bh=trkbb9owAfXXQ+XDnKApPjIqqEPc5U9HDoCYDOY3pcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8vrD31HkVhahPqh2b+PDkRV/0s8X1xZAXyfUBy3K53rPuZj3e+rx97L85v+KsVzbibZ1G4nv8D2m8gwjt9vjZZ/l/flGyHi86CrvFLx+u2bVk8DQoIZ9o3i/dxRILyp2qrvdacIsX72XC9X3A3KpuPh6VVgl+L6pLaSI8BbgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0/zfugY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549CFC4CECF;
	Tue, 19 Nov 2024 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732030212;
	bh=trkbb9owAfXXQ+XDnKApPjIqqEPc5U9HDoCYDOY3pcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0/zfugYheXZ6qUAME8h/iSM5J5mnL6u/2DXwA67Z64orbLVoPLHtpAnc1r9gI7Nw
	 xnirCvnEC1Q6sr0wE28/UjjjSAy1AQYuBY/ZNOpXzNGS4VNN6xm8yFS7MRz0vDaoLL
	 eF7LcBOemM00kbHzyM58Q+Bz8dQb/trOHMiGbfnP46xVUi2WhQKwvgtjWrVf5aRTKX
	 tpLfLwFmwUryARSlhjybSbp41qlh32EyTHfKWa4or0TkmSZgOUIYU450XQyZIjDc6r
	 lCQSEoBl2sq3LDg1j3IZZ2DO8KABB75d92jhWXqOKQqxWgjQImVTumupMRgKvPfbyl
	 RX6ZFQyNteMEg==
Date: Tue, 19 Nov 2024 10:30:10 -0500
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, stable@vger.kernel.org,
	cel@kernel.org
Subject: Re: [PATCH 6.1 1/5] NFSD: initialize copy->cp_clp early in
 nfsd4_copy for use by trace point
Message-ID: <ZzyvAnV1p00w5f2_@sashalap>
References: <20241118211900.3808-2-cel@kernel.org>
 <20241118211900.3808-2-cel@kernel.org>
 <ZzybZplCfSkWKsyi@tissot.1015granger.net>
 <2024111915-annually-semisoft-c5d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2024111915-annually-semisoft-c5d6@gregkh>

On Tue, Nov 19, 2024 at 03:13:51PM +0100, Greg KH wrote:
>On Tue, Nov 19, 2024 at 09:06:30AM -0500, Chuck Lever wrote:
>> On Mon, Nov 18, 2024 at 11:36:15PM -0500, Sasha Levin wrote:
>> > [ Sasha's backport helper bot ]
>> >
>> > Hi,
>> >
>> > The upstream commit SHA1 provided is correct: 15d1975b7279693d6f09398e0e2e31aca2310275
>> >
>> > WARNING: Author mismatch between patch and upstream commit:
>> > Backport author: cel@kernel.org
>> > Commit author: Dai Ngo <dai.ngo@oracle.com>
>>
>> Is this a bug in my backport script? Should patches backported
>> to LTS retain the upstream patch author, or should they be From:
>> the backporter? If the former, I can adjust my scripts.
>
>No, this is correct, I think Sasha's scripts are a bit too sensitive
>here and in a few other places.

Right, sorry - this is more of an indicator for me to say "this patch
was backported by someone who's not the author, review it more
carefully".

-- 
Thanks,
Sasha

