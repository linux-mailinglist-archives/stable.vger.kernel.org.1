Return-Path: <stable+bounces-154563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E19CADDB32
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 20:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67318401FD4
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333EF2EBBBC;
	Tue, 17 Jun 2025 18:18:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from constellation.wizardsworks.org (wizardsworks.org [24.234.38.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CD2EBB93;
	Tue, 17 Jun 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.234.38.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184285; cv=none; b=ogFBM8nBiofpvlFFFKD5arVdKUxa+OjdxKvpTKbjSnVvmdBD3niDe9vthWR9Ihk1fyT5n9jvkQWR82dZgkSf97HFaOYrY9KvrgRFAMBuSFNgxm3IXF4rTeL8vHlAXKzwvpkl268rshGSv+vfccc7hfj3tikxw6K+Ao5VzkNWysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184285; c=relaxed/simple;
	bh=4hx6YBGdH9zrg2hg4KnoxAVKtdMcK9YsjcuPnwFco78=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=oslQ7EmLebk8+jv6rpnMHYR76W9MCt0ARTmpVsDmb3uqLXI2L7WCr/coMXG0EOdlAHiMEDioPZ1hODLDUWu2wnHryaOC6XDdqYDa8qGNHF5yufH/yqliGjzcDimDLU0zivUJh3TqFreB53HmP5wF2nRhXvxOnXaDEgnvIDsgtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org; spf=pass smtp.mailfrom=wizardsworks.org; arc=none smtp.client-ip=24.234.38.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizardsworks.org
Received: from mail.wizardsworks.org (localhost [127.0.0.1])
	by constellation.wizardsworks.org (8.18.1/8.18.1) with ESMTP id 55HIJdef010654;
	Tue, 17 Jun 2025 11:19:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Jun 2025 11:19:39 -0700
From: Greg Chandler <chandleg@wizardsworks.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
 <385f2469f504dd293775d3c39affa979@wizardsworks.org>
 <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com>
Message-ID: <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
X-Sender: chandleg@wizardsworks.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit


Hmm...  I'm wondering if that means it's an alpha-only issue then, which 
would make this a much larger headache than it already is.
Also thank you for checking, I appreciate you taking the time.

I assume the those interfaces actually work right? (simple ping over 
that interface would be enough)  I posted in a subsequent message that 
mine do not appear to at all.

My next step is to build that driver as a module, and see if it changes 
anything (I'm doubting it will).
Then after that go dig up a different adapter, and see if it's the 
network stack or the driver.

I've been hard pressed over the last week to get a lot of diagnosing 
time.



On 2025/06/16 12:01, Florian Fainelli wrote:
> On 6/10/25 11:53, Greg Chandler wrote:
>> 
>> 
>> I decided to test this again before I got sidetracked on my bigger 
>> issue.
>> The kernel I repored this on was 6.12.12 on alpha, this is also that 
>> same version, but with a make distclean, and just about every single 
>> debug option turned on.
>> 
>> I left the last line of the kernel boot in this output as well, 
>> showing "link beat good"
>> 
>> I pulled the plug and it happened again immediately.
>> I waited 10 sec, and plugged it back in, and I do not get a "link up" 
>> type message that I would expect to see.
> 
> I was not able to reproduce this on my Cobalt Qube2 with the link being 
> UP and then pulling the cable unfortunately, I could try other things 
> if you want me to.

