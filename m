Return-Path: <stable+bounces-28214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C094C87C538
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 23:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849EF283454
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEEB1A38FA;
	Thu, 14 Mar 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt9/0zfE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4C6119
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455901; cv=none; b=HgvdKqz4+Sqe0iGyv1YGs/SigvjFGEQxnkp7gq2Nlm+azjWLdDBtc5LW3HilloqT1JjJrOTiVSx9kILvWyeCWeuf8UNiKykq2Q+pKMhhSdMZG0QtYxq4uc68rurYzxQynRnLfxkDiALI1TdhyR+2QoEr+CaPeQZ+51v8KA+uLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455901; c=relaxed/simple;
	bh=Fp+QzUBiLtU2kSxcohL6cNfNyfZ3vX7mpJ/MQYF04V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULGzKmUWMKm32mBm11M1sKGVki8C6BFt64I5sFpMFUIz9Rri+Oyns+IOJ1OJ8o6zpf2uK/JJ5wvp3rJZTWsN0BSKcZS04dONA+9LYBPuwM0OjTruxtQAa0UXbK+K0may0e8iCy1nsec5T/jlm8VLYf2Ci4U6d+HDdRg9/bNNE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt9/0zfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E677CC433F1;
	Thu, 14 Mar 2024 22:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710455901;
	bh=Fp+QzUBiLtU2kSxcohL6cNfNyfZ3vX7mpJ/MQYF04V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yt9/0zfEhsJtMP/udmzemH92HSNVt0zlndQW5U6uNO5eeijx1vN/J3iiUR9K3uGk2
	 L+1nXFqCJGCUv8ejXIqJcSlayzCEt07Emm8tW25QTB+0VbQADLczHw8MOgsGQNYye6
	 I2TUkgTQ3/b/fFKgzCG0BO5J5ojvBy0JXtaPPaUgRahwS8MVvke/NjisDExVf0iWrv
	 4oCzJ7TvE5p9DaiVRucC6ruEgwe2iV9oOy/VLqJjslMoHvm0wS9FnappDqpW2249im
	 +RZ8P4Iia4/9RNKbuBV6vUI1q/biv750MjoD8GpreoeSnYoyFuCtsJFqDp7CJ9I3zo
	 Pe7Bu9/LyPgWQ==
Date: Thu, 14 Mar 2024 18:38:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Helge Deller <deller@kernel.org>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: dddd
Message-ID: <ZfN8WxMrgQBUfjGo@sashalap>
References: <ZfLGOK954IRvQIHE@carbonx1>
 <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>

On Thu, Mar 14, 2024 at 05:46:35AM -0400, Kent Overstreet wrote:
>On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
>> Dear Greg & stable team,
>>
>> could you please queue up the patch below for the stable-6.7 kernel?
>> This is upstream commit:
>> 	eba38cc7578bef94865341c73608bdf49193a51d
>>
>> Thanks,
>> Helge
>
>I've already sent Greg a pull request with this patch - _twice_.

I'll point out, again, that if you read the docs it clearly points out
that pull requests aren't a way to submit patches into stable.

-- 
Thanks,
Sasha

