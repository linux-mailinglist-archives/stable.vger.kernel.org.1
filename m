Return-Path: <stable+bounces-26905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E949872D5C
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 04:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D722852EB
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 03:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B812E78;
	Wed,  6 Mar 2024 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="f0j3eHhU"
X-Original-To: stable@vger.kernel.org
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B24DF51
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=137.74.80.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694592; cv=none; b=lRnXDRLaNJumWk/1PjqYXA//OaxTD5SCXGcwCFIubl4CFg12CyZZN1/HLKpl3bw4OWd8bIYi6E10R2q2JRWCw/YueK56OFFbRKGyMNRixiTaot+UwBylFLEw0GnRr2G7NVpq30U23LHbM2fufLro5Ksyf2PpjyoZqMJqJAv7KeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694592; c=relaxed/simple;
	bh=SZWOvVHx5PPe1dYlcu23tYgpYzMdb9vkBaIMHTeGk9Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u6O/ydJ0CqrXttA8vSmozTRwfNbvXPtQUAuNMmG60e4kGGoMJisAyGkNln+WiiVpr1COWXpQ6oZHSNiDeyQEuO7ghrFPZBRR96eBjuXChxyJmheKxDqBtDOB11O3o1lTwDkjUFn7zSCnJQc/8NfWRZaMxdzgO7gNgwAZsm0Qf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=f0j3eHhU; arc=none smtp.client-ip=137.74.80.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 5D8B4203D6;
	Wed,  6 Mar 2024 03:09:44 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id C1FDF4007F;
	Wed,  6 Mar 2024 03:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1709694583;
	bh=SZWOvVHx5PPe1dYlcu23tYgpYzMdb9vkBaIMHTeGk9Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=f0j3eHhUtGpxoJ6d+B1hT9QozmCl9QgwG6Q4lu1C78xUKhnY/jgLHi7MKOum67bON
	 8JTo5nMy0ntHH5gHZ9g0xk4fBfr1jxUMiRtNr6hcn1xuHvPErAAYSxUIKeI0wc0RzZ
	 +rfwG/unNYlCuUhfw6YPqWCdTDQGcIix9AEsemYs=
Received: from [10.66.66.8] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 5CAC640F70;
	Wed,  6 Mar 2024 03:09:41 +0000 (UTC)
Message-ID: <69698702-ae58-4bf8-b8fb-ff4a36c3df77@pavinjoseph.com>
Date: Wed, 6 Mar 2024 08:39:38 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Content-Language: en-US
From: Pavin Joseph <me@pavinjoseph.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
 <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
 <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
 <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
 <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
 <ZeO9n6oqXosX1I6C@swahl-home.5wahls.com>
 <f264a320-3e0d-49b6-962b-e9a741dcdf00@pavinjoseph.com>
 <ZeXzoTjki+1WR258@swahl-home.5wahls.com>
 <fe72c912-f1a0-4a53-88ab-b85e8c3f7bd9@pavinjoseph.com>
 <Zec5Ubr7G9NbnIyq@swahl-home.5wahls.com>
 <294c28ba-25c2-4db4-9dea-616ed1e2ea30@pavinjoseph.com>
In-Reply-To: <294c28ba-25c2-4db4-9dea-616ed1e2ea30@pavinjoseph.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C1FDF4007F

Hello everyone,

I tried optimizing the new stable kernel 6.7.8 for space but that did 
not resolve the issue.

pavin@suse-laptop:~> du -s /usr/lib/modules/6.7.8-local/vmlinuz
10496	/usr/lib/modules/6.7.8-local/vmlinuz
pavin@suse-laptop:~> du -s /usr/lib/modules/6.7.6-1-default/vmlinuz
14012	/usr/lib/modules/6.7.6-1-default/vmlinuz

Kind regards,
Pavin Joseph.

On 3/6/24 01:28, Pavin Joseph wrote:
> On 3/5/24 20:55, Steve Wahl wrote:
>> In the meantime, if you want to try
>> figuring out how to increase the memory allocated for kexec kernel
>> purposes, that might correct the problem.
> 
> I tried all the options and variations possible in kexec. Don't know how 
> useful this is but it seems there's a hard limit imposed by kexec on the 
> size of the kernel image, irrespective of the format.
> 
> pavin@suse-laptop:~> sudo /usr/sbin/kexec --debug --kexec-syscall-auto 
> --load '/usr/lib/modules/6.7.6-1-default/vmlinux' 
> --initrd='/boot/initrd-6.7.6-1-default' 
> --append='root=/dev/mapper/suse-system crashkernel=341M,high 
> crashkernel=72M,low security=apparmor mitigations=auto'
> Try gzip decompression.
> Invalid memory segment 0x1000000 - 0x2c60fff
> pavin@suse-laptop:~> file /usr/lib/modules/6.7.6-1-default/vmlinux
> /usr/lib/modules/6.7.6-1-default/vmlinux: ELF 64-bit LSB executable, 
> x86-64, version 1 (SYSV), statically linked, 
> BuildID[sha1]=cd9816be5099dbe04750b2583fe34462de6dcdca, not stripped
> 
> Kind regards,
> Pavin Joseph.

