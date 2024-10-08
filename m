Return-Path: <stable+bounces-81513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446D6993E91
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799DB2828AF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 06:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DA313E02B;
	Tue,  8 Oct 2024 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mnl3WKFD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B413D635
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367420; cv=none; b=FhxulhSaD0oc3JR4n9rvR2OEzDkHOn1UJ/K7wPID+IpxJDBfkalrcQMdWQFwAhY5zKWlO3MEsBaLcaGHHS4jnxxge99H4oOB2ccJ9FRd2xrrW9IrbzWBR01lVgpFN9opaKDbSdqxYL7ea3+KPyFSFpClHsl3YGfRuKW8WBTddLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367420; c=relaxed/simple;
	bh=Fbd3Slf6EVQpe2b5sHp80lBMHiJG1+TnfRdfoPVvKBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5VNU3Lxy5nszfH3ns2pIlQMWxOGoyb0irV2eVsIy6eVW0krWYvBU7j7K6rNXYL9BuHXjYFxtObyZW2Gl8DBAJBQGb8yNNXgssMo2ltf1eAVo/D1fWIjobYVp/D3aiK+bo0QnhlA/TGj/jBoLo3atjZmisNHfYh/U1OtR/jSoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mnl3WKFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F33AC4CECC;
	Tue,  8 Oct 2024 06:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728367420;
	bh=Fbd3Slf6EVQpe2b5sHp80lBMHiJG1+TnfRdfoPVvKBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mnl3WKFD2MrHfWQtMJm9c4ah4IohniCEeLJjhId1eHffosRB6eZrPRW2OYptLD9ON
	 b+Yoy3fGLTWxZ0M2iR7MzkZzzd71WIG/3VCNs3hDI2BE/TUIoAfJoveoxUnWKH7kjb
	 cmFeG5Wq6JbC/0ORiQa64TZO6UZVe01LEDg+uri73da54s1odZrYzPkjdsPAic320o
	 fi/U84iZp6j8dIAC6cdhH/bTb4S9N9VdbTYVCw5U2uFbd3eGFRiqpA4uhDwcuyZeW9
	 tbTIcf8IQjAsYgVXZiln6SsZ2L7RJLU7aDnNA43HZrJFjESNw+yt5ICS8Foi6xcRqa
	 hTduyUgS1euug==
Date: Tue, 8 Oct 2024 02:03:39 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/net: harden multishot
 termination case for recv" failed to apply to 6.6-stable tree
Message-ID: <ZwTLOyEJ4ZerpK3K@sashalap>
References: <2024100732-pessimist-ambiguous-58e3@gregkh>
 <1d4d32fb-8831-4458-adcb-d9ae9ffb5f15@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1d4d32fb-8831-4458-adcb-d9ae9ffb5f15@kernel.dk>

On Mon, Oct 07, 2024 at 11:49:19AM -0600, Jens Axboe wrote:
>On 10/7/24 11:30 AM, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 6.6-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x c314094cb4cfa6fc5a17f4881ead2dfebfa717a7
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100732-pessimist-ambiguous-58e3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>
>Ditto for 6.6-stable.

Queued up, thanks!

-- 
Thanks,
Sasha

