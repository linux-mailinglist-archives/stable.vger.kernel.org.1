Return-Path: <stable+bounces-69962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53695CC76
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4F6283CD1
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68079185B43;
	Fri, 23 Aug 2024 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYG3ihwL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014318455A;
	Fri, 23 Aug 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416715; cv=none; b=n8EEE9EPesMqGOUszz8sROODTpNiDM5CDDIPQpC1Jw4G5DJQ/ZXaUh6GDyEii95uO3o0q1BrgaPw17dmi6ChZw2F8Y9cZJ7rWpjLK0LOAZ/zLXmrBZ0ZO5H4YyHmkABQe9t6DZO0vj1zmPtnmJIeb+69LFzPdqFF6TjwDVBuDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416715; c=relaxed/simple;
	bh=vF986wTh3AkSKWbZuCa6p5AVtLHE2wT3BtiL0z1YDbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ26qmVAyFVLl800tqOwrhUf9iznsbybJ9mzj4pY48a/qmjpYpoUwO8TdQpCOZw/fepJoxXne9C2zliPGz3yb1ugKkFBtqRZ97fNvzZEhIN5PhN49eqrTntQHbql0LnKfWwgWSIMTkNbEWQp54bh6j76nZzESxE7ObTcdF0kXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYG3ihwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A08C4AF12;
	Fri, 23 Aug 2024 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724416714;
	bh=vF986wTh3AkSKWbZuCa6p5AVtLHE2wT3BtiL0z1YDbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYG3ihwLELeaw0pV9i+7ROz/PM/fjT6rCp7J0od8th6pha/jLbi8+e6nK2YiheVoH
	 jx56W/ZEFKheFlnYcswWXILVCbhNvLUVSYHlN5d+0owFRkipStpKOJaJCe8GxjGziV
	 iFxwV0yugkFLG7EY5T8m0rFaIV3AtDjHbkJVGjSOW7XZ0Ix6QoZjrHbSsmeQayq+im
	 0MHHdgLopjRNJKiuFyfl8RNVX9LYwtfcRBnxHOAK6Tv2sh1WY2XcV0uJmxPuO6BobZ
	 Zi68WuwU/JnSOCH9MePWDWNEeBm4+pWS7hk5yGTWQor9wNymSEp2zmEc8xozIsNBVN
	 2g3l7WMOfpxgA==
Date: Fri, 23 Aug 2024 08:38:33 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: Patch "Input: bcm5974 - check endpoint type before starting
 traffic" has been added to the 6.1-stable tree
Message-ID: <ZsiCyTYvhl3f3ECG@sashalap>
References: <20240819142508.4159199-1-sashal@kernel.org>
 <ZsTHtWLPDvUhzIq0@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZsTHtWLPDvUhzIq0@google.com>

On Tue, Aug 20, 2024 at 09:43:33AM -0700, Dmitry Torokhov wrote:
>On Mon, Aug 19, 2024 at 10:25:08AM -0400, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     Input: bcm5974 - check endpoint type before starting traffic
>>
>> to the 6.1-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      input-bcm5974-check-endpoint-type-before-starting-tr.patch
>> and it can be found in the queue-6.1 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>Please drop it, it was reverted.

Will do, thanks!

-- 
Thanks,
Sasha

