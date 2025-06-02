Return-Path: <stable+bounces-148954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1442FACAF3C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05433A7EAD
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C1E22129E;
	Mon,  2 Jun 2025 13:41:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280FC2AD1C;
	Mon,  2 Jun 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871675; cv=none; b=qHYJGL4eTEKIqsPfQHVjXtYQpa5BQMl5rEqKwJbrmPKA6NIc5r11cCO/GyLjaoTDWWEhoQo9EGzJzgEf1Cyz63psWuddbL7TdVZDpPg52fcxZ6Exj6Ns/2ZUc79YBfY1SEovYG3eRehjCZGDAPAqLMk4roWq4OQPtlzO8NFkK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871675; c=relaxed/simple;
	bh=LrGXX0ytLpJHG5PcCLWzObiPuSCT1TcTq4syPexx9Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRTINSyPYXAiNVgrM10ZFAm/bTzSgPQ8/Bu9HkX9FdjJzG0XxJ6SIIzICuHkRgcVIMi2vR48e8sO37qQQ6nWC8rBpwpRGmvwEJQ3e5WrjLFcbXUJHCf1fvx5JML0QhfaOdPS+td/t9sERk+p6JZhSE94qq0akXyGYuEEbajW/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 97B591012E8;
	Mon, 02 Jun 2025 13:41:00 +0000 (UTC)
Message-ID: <16cc8c9d-f89a-406c-9427-94ca75984752@enpas.org>
Date: Mon, 2 Jun 2025 22:40:55 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tty: Fix race against tty_open() in
 tty_register_device_attr()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20250528132816.11433-1-max@enpas.org>
 <20250528132816.11433-2-max@enpas.org>
 <6068387e-7064-0c2b-700a-3817bea1045b@linux.intel.com>
From: Max Staudt <max@enpas.org>
Autocrypt: addr=max@enpas.org; keydata=
 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
 1Nk4wgjdif6n69chAwuDQyOfWdz/dQ==
In-Reply-To: <6068387e-7064-0c2b-700a-3817bea1045b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/2/25 19:31, Ilpo Järvinen wrote:
>> +	mutex_lock(&tty_mutex);
> 
> Use guard() so you don't need to change the returns and rollback path.

Thanks, I didn't know about this new kind of helper.

I'll leave it up to the TTY maintainers - if they don't express a 
preference for guard(), then I deem this code simple enough to leave it 
as-is, because I don't have any experience with guard(), and in fact, 
until 5 minutes ago, I didn't know at all that GCC cleanup attributes 
even exist.

Interestingly, Documentation/process/maintainer-netdev.rst documents a 
preference against guard(). I wonder why, but that's for another day.


Do you have an idea on how to solve the circular lock that the kernel 
test robot found for v1 of this patch?

   https://lore.kernel.org/linux-serial/202505281412.8c836cb7-lkp@intel.com/

							

Max


