Return-Path: <stable+bounces-128803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7BAA7F200
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 03:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FFE179DAB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 01:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A044124BCFD;
	Tue,  8 Apr 2025 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAv5iQBt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D92248BA;
	Tue,  8 Apr 2025 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744074588; cv=none; b=QFuGOHGxpeIkJEgfCItmCN8/7DNl5lc5ZAP7OEhYqZNbdIc2Zi4R5MmMdfDVek9vI5hOflO39623pgpOksos5h01zNHet2g1q5SIY6GMs2joRokojwW3/4lP8i4DjlENL7kNYZsnJ/g1NJgLlGgjBpnDunm5eHVg5QOqZMbrJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744074588; c=relaxed/simple;
	bh=Nkt+pY665Nqxt/rn5C7i8gimBxRgZc8VHdvwmYo1izs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGflRgi0C0l/EAG1wNCgz8lD9PyKd1khcD1Evq4XWvXL+nK9P7jnE5iIwM9l379sWtkoAAs89F/Vj7C1zqJvf/KPdFgZjFnICB0Qtb1IN1xg1uVHYnge884BlusKU/oBTpscQkmjCyjMyRUeZbZN9uzIa/wJFkIm3cgPhmvTIOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAv5iQBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E99C4CEDD;
	Tue,  8 Apr 2025 01:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744074587;
	bh=Nkt+pY665Nqxt/rn5C7i8gimBxRgZc8VHdvwmYo1izs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAv5iQBt+R8NEPg1Lba/OGsmp49FvSeuHn2vpMKHui+w6ze7W2m0Nv+IN27cUdv6M
	 suaGeS0QFtonH9XOVbzlBTnFBCFbhGommVD1IrnFXBJ8eNs74vqtIHTMY3V/QgMDKK
	 pIjScgTf/DA/r4wQPZWWWW+yQrrG5dE4QPgfGyoXX1Q3Bp2ukzUzxk/OUFE3hP72qJ
	 SyHUvNxoTUIUvO1GPalHC9GyGr7Fuaribc616XMY9n61odiF4SDh3PMGk1PafL8uL2
	 WM+m1RsxnWCbU0xealY/HOO0tp5tLQ6UjL1raFlbZWVaWayTXfAy24hWJcwg+sxNL9
	 /tkLtLWIQi47g==
Date: Mon, 7 Apr 2025 21:09:43 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	jstultz@google.com, Stephen Boyd <sboyd@kernel.org>
Subject: Re: Patch "timekeeping: Fix possible inconsistencies in _COARSE
 clockids" has been added to the 6.14-stable tree
Message-ID: <Z_R3V-sJDh_VWryx@lappy>
References: <20250407140759.3092465-1-sashal@kernel.org>
 <87zfgsujs5.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87zfgsujs5.ffs@tglx>

On Mon, Apr 07, 2025 at 04:29:46PM +0200, Thomas Gleixner wrote:
>On Mon, Apr 07 2025 at 10:07, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     timekeeping: Fix possible inconsistencies in _COARSE clockids
>>
>> to the 6.14-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      timekeeping-fix-possible-inconsistencies-in-_coarse-.patch
>> and it can be found in the queue-6.14 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>As I asked on the stable list already, please do not add that to any
>stable tree. It has been reverted in Linus tree and the problem will be
>fixed differently.

Sorry about this, now dropped.

-- 
Thanks,
Sasha

