Return-Path: <stable+bounces-270343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IDvHBFMCRmo4HwsAu9opvQ
	(envelope-from <stable+bounces-270343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 08:16:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB66F3BB9
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 08:16:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="ijJw/ilO";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270343-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270343-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B6F30FC018
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 06:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5AA375ADE;
	Thu,  2 Jul 2026 06:10:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE13750B6
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 06:10:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972614; cv=none; b=cpT/0Gl26u+WO1nvv1YnwOdcIvyd0Kgewr0zDoxFR25umQug0kqXX0PI0qHcT/zRViNAQBgEtx9ahcpLPXPe7jKW7QPumrxXspKt6RWCCW4CDAIi/C0bgQw4ifcXc+AbDFgaPHLBYFEd7OV9nriHgKtBxSlCShgi4YT8mmdVLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972614; c=relaxed/simple;
	bh=2mVa806GdsgnBUdtwgowmJH5DKkzweKJma2DxtSgPI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/4/vGfRPiBZbhrSHDc4V1YYEFfUYVK80Jg3CY+CF1rozmiDnOY3uSAoVXSLDJr7Bu585WgMKB504Iv04UGXo+jGXmhtLX0LBm6V54wmfO6jGjDRyie25cKVCsb4Jpw9T301UGGofpH2rG2IlEB8KCQAKeh8Cwd8SU4k2lFMmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ijJw/ilO; arc=none smtp.client-ip=91.218.175.173
Message-ID: <8b1d5b5d-61f5-40b1-95d4-35f98a280db8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782972600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RkVF5jg7OnZN5tmk1b/EFsXMnULO9gOlk19FjEZoQU=;
	b=ijJw/ilOjcdKFD0ygUOYE//04Rf1ZQOb5omPfPZp11rgZqAhjNE8IzN6Y+AgBbao7VvaL6
	KIBNHNCN+XaInpJ8hI/lyObI9ubVMkzQQRIMKsK18UmTHUsWVyGfAr6juB+6p1yYppdl1g
	aaQTYdZi1n/43dBpk7o6g8eNfpqNVGg=
Date: Thu, 2 Jul 2026 14:09:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ext4: get rid of ppath in get_ext_path()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wang Jun <1742789905@qq.com>, tytso@mit.edu, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, libaokun1@huawei.com, 25125332@bjtu.edu.cn,
 Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
References: <tencent_C982B0201FE8F041BD5B4FC1ED7D646A740A@qq.com>
 <2026062643-tamer-limes-a320@gregkh>
 <rrsgndgpxyrmu6okb43u6wkdaibbidlbyqgugeeijd2b44sf4y@6lzmm4v4xvdp>
 <2026070210-catty-grape-2568@gregkh>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <2026070210-catty-grape-2568@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,mit.edu,dilger.ca,vger.kernel.org,huawei.com,bjtu.edu.cn,suse.cz,linux.ibm.com];
	TAGGED_FROM(0.00)[bounces-270343-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:1742789905@qq.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:libaokun1@huawei.com,m:25125332@bjtu.edu.cn,m:jack@suse.cz,m:ojaswin@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47BB66F3BB9


On 7/2/26 1:47 PM, Greg KH wrote:
> On Thu, Jul 02, 2026 at 09:48:33AM +0800, Jiayuan Chen wrote:
>> Hi Greg,
>>
>> Any update here ?
> What is "here"?  There is no context in this email :(


Sorry I dropped the context:

https://lore.kernel.org/stable/tencent_C982B0201FE8F041BD5B4FC1ED7D646A740A@qq.com/


This patch is trying to fix the regression which Introduced by this series:

     [PATCH 6.6 046/567] ext4: get rid of ppath in ext4_ext_insert_extent()

https://lore.kernel.org/all/20260323134534.939905793@linuxfoundation.org/


The series was also backported to 6.1 but reverted later.

https://lore.kernel.org/all/20260408010208.746177-1-sashal@kernel.org/


So I'm confused about the next action will we accept Wang Jun's patch or 
we just revert it as 6.1 did ?



>
>> We rebased the 6.6 stable one week ago and also found the same regression.
> What regression?  Again, no context :(
>
> confused,
>
> greg k-h

