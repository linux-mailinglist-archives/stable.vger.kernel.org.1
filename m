Return-Path: <stable+bounces-146376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C32FAC40BF
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 15:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF483B641E
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A321FE470;
	Mon, 26 May 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b="E0xveWwX"
X-Original-To: stable@vger.kernel.org
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65957202F9C
	for <stable@vger.kernel.org>; Mon, 26 May 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.165.83.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267681; cv=none; b=sghxs4C05Mqy7hgFezg7AUG+avubpBOHOVWFyLhqXAAxjS4cD977EKq59INTloeuaLxtiqgZ3Yc81v29xYp4SKL1QR7kcMwn9vJqCswYykpriTuxDb7MceOZ1G8qpJn3LmbkMHZFbL/WDMbxCInq4MQELfFsKtYee0Q7L2vA1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267681; c=relaxed/simple;
	bh=O44GjLqmIUPCcDJhz8yP6ORetrgCreREgJj/6hemkUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtDYtOASlJW1NT24Fge40fMZKOkg07ROU/OO+e8YMTlWREOoE/47B/GUzlKBCjBQN+GAOrPNRu1cqhEMe3t+bYnLK/J4Tiwlo2oZvncJcZIv24jVP6i29DgvrOqcYP8BO5mGujbJ12skOyMX4CZ99to8J/Ubadhhu2QVGnjlwDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de; spf=pass smtp.mailfrom=os-cillation.de; dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b=E0xveWwX; arc=none smtp.client-ip=213.165.83.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os-cillation.de
Received: from core2024.osc.gmbh (p578a635d.dip0.t-ipconnect.de [87.138.99.93])
	by os-cillation.de (Postfix) with ESMTPSA id F2A4FC0089;
	Mon, 26 May 2025 15:54:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
	s=202409; t=1748267677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xqo4U54nE7NzW0Gtdxtq66XrOnvatHmyWovsHo5D54g=;
	b=E0xveWwXdfRsWE7QATlkH9TIUN2AN3/GLhCu4aEDiXfi30pZ35eSaWrR3VsWo90TebOuIP
	RSxBZzOWRSg3hiN3eVlvlL9dOKYXo7SjjXhVl9BYQ3Ba/dEhN7T/XKURZiEthcy2lbw8bU
	1paOXsgm2aKVb9Y417hy2KmDhaOuhnNSWumYskmJJpdWcoCmaMK4C3gTJJuXDpQkiFigvk
	WjE1PsBFkea7UxeAAB1tW/7dbpSfVXTeTEI0eQx5XD6OrY5QdqoyQhIGLsRUSKkoVA35fU
	ZCh9v9my4r96ZJNFQkUdiiVVVpoWBqBPwZHhR2QtEPnJbzWTyjIrTDfe+0tJgg==
Authentication-Results: os-cillation.de;
	auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from [192.168.3.45] (hd2022.osc.gmbh [192.168.3.45])
	by core2024.osc.gmbh (Postfix) with ESMTPSA id 93149200700;
	Mon, 26 May 2025 15:54:36 +0200 (CEST)
Message-ID: <c658e3c0-1dcf-4c0d-ad9f-567e6d6d9574@os-cillation.de>
Date: Mon, 26 May 2025 15:54:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Request to backport b3bee1e7c3f2b1b77182302c7b2131c804175870
 (x86/boot: Compile boot code with -std=gnu11 too)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <8fab7dc7-a99f-4168-8dff-9ef8443faf38@os-cillation.de>
 <2025052621-unclip-monogram-c439@gregkh>
Content-Language: en-US
From: Hendrik Donner <hd@os-cillation.de>
Autocrypt: addr=hd@os-cillation.de; keydata=
 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 li+2
In-Reply-To: <2025052621-unclip-monogram-c439@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello,

On 26.05.25 14:23, Greg KH wrote:
> On Mon, May 26, 2025 at 12:59:20PM +0200, Hendrik Donner wrote:
>> Hello,
>>
>> with gcc 15.1.1 i see the following build issue on 6.6.91:
>>
>>    CC      arch/x86/boot/a20.o
>> In file included from ./include/uapi/linux/posix_types.h:5,
>>                   from ./include/uapi/linux/types.h:14,
>>                   from ./include/linux/types.h:6,
>>                   from arch/x86/boot/boot.h:22,
>>                   from arch/x86/boot/a20.c:14:
>> ./include/linux/stddef.h:11:9: error: cannot use keyword 'false' as
>> enumeration constant
>>     11 |         false   = 0,
>>        |         ^~~~~
>> ./include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23'
>> onwards
>> ./include/linux/types.h:35:33: error: 'bool' cannot be defined via 'typedef'
>>     35 | typedef _Bool                   bool;
>>        |                                 ^~~~
>> ./include/linux/types.h:35:33: note: 'bool' is a keyword with '-std=c23'
>> onwards
>> ./include/linux/types.h:35:1: warning: useless type name in empty
>> declaration
>>     35 | typedef _Bool                   bool;
>>        | ^~~~~~~
>> make[2]: *** [scripts/Makefile.build:243: arch/x86/boot/a20.o] Error 1
>> make[1]: *** [arch/x86/Makefile:284: bzImage] Error 2
>>
>> Fixed by b3bee1e7c3f2b1b77182302c7b2131c804175870 (x86/boot: Compile boot
>> code with -std=gnu11 too), which hasn't been backported yet.
>>
>> Should probably go into all stable trees.z
> 
> Is this the only change that is needed to get gcc15 working on this
> kernel tree?  What about newer kernel branches, they seem to be failing
> on gcc15 still, which implies that 6.6.y still needs more changes,
> right?
> 

that is the only fix i need on 6.6.x with the kernel configuration i
test and build for an x86_64 production environment. I also build arm32
and aarch64 kernel configuration for a few embedded systems with gcc
15.1.1 natively and cross, without issues. But according to the git
history gcc 15 related fixes have already been integrated over the last
few years into mainline and stable trees, so shouldn't be too much left.
The default KBUILD_CFLAGS include --std=gnu11 in the toplevel Makefile,
which takes care of a lot.

That said i haven't done extensive testing with other kernel 
configurations, just what our internal CI is building.

Regards,
Hendrik

> thanks,
> 
> greg k-h


