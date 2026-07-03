Return-Path: <stable+bounces-271689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YqBTFhN4R2rpYgAAu9opvQ
	(envelope-from <stable+bounces-271689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 10:51:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9FE70047F
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 10:51:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=XH1OtT0m;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271689-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271689-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4637C30C3A22
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 08:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF2F37755C;
	Fri,  3 Jul 2026 08:44:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D636377EB8;
	Fri,  3 Jul 2026 08:44:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068279; cv=none; b=h+nqQ5d0ZpUPnXAnHMj4zCRXcUQwBpxixRf8LlubXmV4GFQuop+1WzfysrNxNMp2k4m19/pAErahPnC45v2yl+q3npoA/wUlzXIjC/qUEcfs1/zEqNNmvZaCK11r/flHuXaQwUtyF403dEwUOcq5u4B4biBiep5XvxvtTYc/mBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068279; c=relaxed/simple;
	bh=5f5VORH3zawg/gO3b17vYMgZ7k1ax6oaoAxOZ6GP99g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQV/1vGPeot0qAiC4WtIRVEYBwTJRVgqi+wU3Ys9KeqACcOfXYIkLJm4kN6SMwIbxTFQt8nmsc0ahxcjSb+9Fn00+7NwUHG8iJ/WQ2O9xXrawB4tSacvwZet8OiyVkrJhCXZE29MyIZmR8+HoNqz7EAk698Ts48mCCAZYY2EhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XH1OtT0m; arc=none smtp.client-ip=115.124.30.110
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783068273; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=heLiIQaQ67iQ8EJ+Osbvfe//KC72f/O5+l/x4rW5RyQ=;
	b=XH1OtT0mQh7l17sKw2Jg9NkVC8PS3Ae95e072pvjRn6ZOSiKoDflw/eDFc3TO9IkQHWDT+w1/xTxTd7QygYFPFofc5Fi7Jdm7WeWbATmRiyENMO+qT2yoFpN+fJCCJKzx57iTSnkbB5Ke+A5kuFf5E7ojQ1R6Ljee4Kex2Pi+EM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6IjTR5_1783068272;
Received: from 30.221.129.235(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X6IjTR5_1783068272 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 16:44:33 +0800
Message-ID: <2904d1db-11fa-450a-89ea-20fe133fa268@linux.alibaba.com>
Date: Fri, 3 Jul 2026 16:44:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: get rid of ppath in get_ext_path()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Wang Jun <1742789905@qq.com>,
 tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 25125332@bjtu.edu.cn,
 Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
References: <tencent_C982B0201FE8F041BD5B4FC1ED7D646A740A@qq.com>
 <2026062643-tamer-limes-a320@gregkh>
 <rrsgndgpxyrmu6okb43u6wkdaibbidlbyqgugeeijd2b44sf4y@6lzmm4v4xvdp>
 <2026070210-catty-grape-2568@gregkh>
 <b93095c6-0717-4616-9702-570b2927429b@linux.alibaba.com>
 <2026070315-crescent-factoid-616d@gregkh>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <2026070315-crescent-factoid-616d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271689-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux.dev,qq.com,mit.edu,dilger.ca,vger.kernel.org,bjtu.edu.cn,suse.cz,linux.ibm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:jiayuan.chen@linux.dev,m:1742789905@qq.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:25125332@bjtu.edu.cn,m:jack@suse.cz,m:ojaswin@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[libaokun@linux.alibaba.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[libaokun@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD9FE70047F

On 2026/7/3 16:20, Greg KH wrote:
> On Fri, Jul 03, 2026 at 03:57:09PM +0800, Baokun Li wrote:
>> On 2026/7/2 13:47, Greg KH wrote:
>>> On Thu, Jul 02, 2026 at 09:48:33AM +0800, Jiayuan Chen wrote:
>>>> Hi Greg,
>>>>
>>>> Any update here ?
>>> What is "here"?  There is no context in this email :(
>>>
>>>> We rebased the 6.6 stable one week ago and also found the same regression.
>>> What regression?  Again, no context :(
>>>
>>> confused,
>>>
>>> greg k-h
>> For some reason, LTS only merged a subset of my patchset, causing
>> some commits to lack their prerequisite patches. This leads to error
>> numbers being interpreted as valid pointers.
>>
>> For details, see the fix patchset that Erkun submitted to 6.6.y
>> (it fell through the cracks for some reason):
>>
>> https://lore.kernel.org/all/20260421113416.4040274-1-yangerkun@huawei.com/
>>
>> Either applying this fix patchset or reverting the incorrectly merged
>> commit should resolve the issue.
> How about submitting a revert so that we can start fresh and work from
> there?

Alright, I can help review the patches.


Thanks,
Baokun


