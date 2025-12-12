Return-Path: <stable+bounces-200936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA849CB98D4
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 19:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6473D3017329
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F93019CF;
	Fri, 12 Dec 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="EDkeI2Ig"
X-Original-To: stable@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298DD3019DE
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563725; cv=none; b=fXPD6bknktHPLoqflVjfuQ+zGE2XkerH1QiLfLbqKM+nEACU7ooSQmZOGkFtTgDE/R2PFgLecIrMiZ94gCJVGPm+AUeHnfnr4LHv6uh91W97yW/1Y/8Vh2UTg5WdYmbRiAEsZzYGomleHwFFw0IqSCqq7LnazwJgXD9TOkurK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563725; c=relaxed/simple;
	bh=nlwWzd8H/QFVfZ9XD9u/sEx2dehXu4fN3B5Rte1Am0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRd3D60rKOXfitiO1tsXRH1FhwrUnDVLSHOUfN5ndvhoYXVm5j/Y4I+2KdVCmAP+BpzRbmv8nW5YXECKoq2ftr6YDbbs84ncmjeLzGQClQuq765UbbVRZoxG5DjEnxH8oacruPI+zfR03VljzVWhvlhhCJHIfd188nuHAcasi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=EDkeI2Ig; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-953a8a3ca9; t=1765563723;
 bh=ujl+sTrNhXHxwNX5b2qn7Bp4IFE1VBkaZlKsjfIZgjU=;
 b=EDkeI2Igx04rpUYW+YMCLRdTW38V39eajGm+Ce8ynDv+8OTmJX+3PpgG/CjcW9pY83Oem+T8R
 ixCSnU+f74e7po4gPgrMzIAIxJQ0NHqdtJ5MTWgTflkBl2IQ/5UnCVxOrBDF88Z9RQGfGBUaEkx
 1wbIt62Ln4k5P313e6qCPDER9EhS8E7jycgDwLJ6/ZLHVZubxjWxeelyd1Yds6/BzH/7T8UOfre
 GDnfffw7eSPzWfcgc+W0/vMmc7eXNXqwJJViJv7dlHQYU3p2PYZJUdd3ngrhAN0ygOtFRtFUUXC
 Em32JH+sty9PRCqbjJjYXA/bM6UrGU0ddyfDx/+mCZhg==
X-Forward-Email-ID: 693c5d44fd4b94c0e94ea407
X-Forward-Email-Sender: rfc822; fnordahl@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.6.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <bb4f7703-b704-4eb8-942b-d693f64aed63@ubuntu.com>
Date: Fri, 12 Dec 2025 19:21:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erspan: Initialize options_len before referencing
 options.
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
 Kees Cook <kees@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org
References: <20251212073202.13153-1-fnordahl@ubuntu.com>
 <nZEr2jHd7_uGuwbqEiM3iStGK4aQ_EgMoNLBgyJrYmeTlhzT2-qGpuBxKPW6U7k8ZqAr6HExn5ncXLMA5EbRQQ==@protonmail.internalid>
 <aTwxDBODyDmerGAt@horms.kernel.org>
Content-Language: en-US
From: Frode Nordahl <fnordahl@ubuntu.com>
In-Reply-To: <aTwxDBODyDmerGAt@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/25 16:13, Simon Horman wrote:
> On Fri, Dec 12, 2025 at 07:32:01AM +0000, Frode Nordahl wrote:
>> The struct ip_tunnel_info has a flexible array member named
>> options that is protected by a counted_by(options_len)
>> attribute.
>>
>> The compiler will use this information to enforce runtime bounds
>> checking deployed by FORTIFY_SOURCE string helpers.
>>
>> As laid out in the GCC documentation, the counter must be
>> initialized before the first reference to the flexible array
>> member.
>>
>> In the normal case the ip_tunnel_info_opts_set() helper is used
>> which would initialize options_len properly, however in the GRE
>> ERSPAN code a partial update is done, preventing the use of the
>> helper function.
>>
>> Before this change the handling of ERSPAN traffic in GRE tunnels
>> would cause a kernel panic when the kernel is compiled with
>> GCC 15+ and having FORTIFY_SOURCE configured:
>>
>> memcpy: detected buffer overflow: 4 byte write of buffer size 0
>>
>> Call Trace:
>>   <IRQ>
>>   __fortify_panic+0xd/0xf
>>   erspan_rcv.cold+0x68/0x83
>>   ? ip_route_input_slow+0x816/0x9d0
>>   gre_rcv+0x1b2/0x1c0
>>   gre_rcv+0x8e/0x100
>>   ? raw_v4_input+0x2a0/0x2b0
>>   ip_protocol_deliver_rcu+0x1ea/0x210
>>   ip_local_deliver_finish+0x86/0x110
>>   ip_local_deliver+0x65/0x110
>>   ? ip_rcv_finish_core+0xd6/0x360
>>   ip_rcv+0x186/0x1a0
>>
>> Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
>> Reported-at: https://launchpad.net/bugs/2129580
>> Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
>> Signed-off-by: Frode Nordahl <fnordahl@ubuntu.com>
> 
> Hi Frode,
> 
> Thanks for your patch (and nice to see you recently in Prague :).

Thank you for taking the time to review, much appreciated (I enjoyed the 
recent conference in Prague and our exchanges there!).

> Overall this looks good to me but I have some minor feedback.
> 
> 
> Firstly, the cited patch seems to cover more than erspan.
> So I'm wondering if you took at look at other cases where
> this might occur? No problem either way, but if so it might
> be worth mentioning in the commit message.

I did some quick searches which formed the basis of the statement of the 
normal case being to use the ip_tunnel_info_opts_set(), I could expand a 
bit upon that statement.

> Regarding the comments in the code. I am wondering if the are necessary
> as the information is also contained in the commit message. And if the
> source documented every such case then things could get rather verbose.
> 
> If you do feel strongly about it keeping it then could I ask that
> (other than the URL) it is line-wrapped trimmed to 80 columns wide or less,
> as is still preferred for Networking (but confusingly not all Kernel) code.

Yes, I guess it became a bit verbose.  The thought was that it would be 
very easy to miss this important detail for anyone (including future me) 
spelunking into this part of the code.

I'll trim it down to a single line, which should be enough to give the 
urge to look at the commit message.

> As a fix for code present in net this should be targeted at that tree.
> It's best to do so explicitly like this:
> 
> Subject: [PATCH net] ...

Ack.

> And it's probably also best to CC stable@vger.kernel.org.
> That practice isn't as widespread as perhaps it should be for Networking code.
> But it does seem worth mentioning.

Ack, the intention was indeed to Cc them, I only put them into the 
e-mail header and the stable kernel bot pointed out that the Cc also 
needs to be in the commit message.

-- 
Frode Nordahl

