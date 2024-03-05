Return-Path: <stable+bounces-26845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939887281F
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 20:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043C8B23361
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 19:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A841127B4A;
	Tue,  5 Mar 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="LRFnYK1R"
X-Original-To: stable@vger.kernel.org
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3A5A796
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.248.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668725; cv=none; b=C9mPgJilgo0dm9LK6G+SBx1SSrM9GSUz80PV1eFE468gwrZj3NcDXK1ZGi8VdJbyosoif8kkivwWlqfqYtOAlCdS+djnOlQ9oKfLKeQj0QkFfj7fDfJeWqOD6WNgAXFC1Bf0ZpYj5PLy6uj+8IMlm/fo4et3lXlGWwrjRq5rK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668725; c=relaxed/simple;
	bh=BfHJn2fC9ef/7P9RF6kAufaG4X+tKN5PC/F+6mJlzdk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gjRMnz8bnTwcc/QxcVBYHkHBeuAMxsIURY5yWCd2YEClvVYMfgbHNfPFjK6ehEgxsRrgHt0YGrdIUNHDmaMLRsVnUEL55ViEvvuCnDYOiuVuce/11MiE5yAXNAaaFLA6rXXhLY1GtQeJVLv6LIUdQJ0ngFotEIJQBPoaQlB2mgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=LRFnYK1R; arc=none smtp.client-ip=144.217.248.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id F22FE3E88C;
	Tue,  5 Mar 2024 19:58:36 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id C49724007F;
	Tue,  5 Mar 2024 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1709668715;
	bh=BfHJn2fC9ef/7P9RF6kAufaG4X+tKN5PC/F+6mJlzdk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=LRFnYK1RXE+1cTTi9FlYEgvSvuaDK6iLvESVRkACOn7G9WvkourMmxFdr0xTqMhqY
	 i2ReH8i4TVsUlyQUdP6RrucWp3Q77uV5Jd7FPEhIqbo4hjVCC6q6EfDqh9prwWPEpV
	 rajjA7HcGdm26RwLHBy3Ks3h3xGTNPlS5FWmbEPY=
Received: from [10.66.66.8] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 805AD4050C;
	Tue,  5 Mar 2024 19:58:30 +0000 (UTC)
Message-ID: <294c28ba-25c2-4db4-9dea-616ed1e2ea30@pavinjoseph.com>
Date: Wed, 6 Mar 2024 01:28:28 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavin Joseph <me@pavinjoseph.com>
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
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
Content-Language: en-US
In-Reply-To: <Zec5Ubr7G9NbnIyq@swahl-home.5wahls.com>
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
X-Rspamd-Queue-Id: C49724007F

On 3/5/24 20:55, Steve Wahl wrote:
> In the meantime, if you want to try
> figuring out how to increase the memory allocated for kexec kernel
> purposes, that might correct the problem.

I tried all the options and variations possible in kexec. Don't know how 
useful this is but it seems there's a hard limit imposed by kexec on the 
size of the kernel image, irrespective of the format.

pavin@suse-laptop:~> sudo /usr/sbin/kexec --debug --kexec-syscall-auto 
--load '/usr/lib/modules/6.7.6-1-default/vmlinux' 
--initrd='/boot/initrd-6.7.6-1-default' 
--append='root=/dev/mapper/suse-system crashkernel=341M,high 
crashkernel=72M,low security=apparmor mitigations=auto'
Try gzip decompression.
Invalid memory segment 0x1000000 - 0x2c60fff
pavin@suse-laptop:~> file /usr/lib/modules/6.7.6-1-default/vmlinux
/usr/lib/modules/6.7.6-1-default/vmlinux: ELF 64-bit LSB executable, 
x86-64, version 1 (SYSV), statically linked, 
BuildID[sha1]=cd9816be5099dbe04750b2583fe34462de6dcdca, not stripped

Kind regards,
Pavin Joseph.

