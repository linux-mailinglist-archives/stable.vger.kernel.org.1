Return-Path: <stable+bounces-270428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kFRVG8xfRmoxSAsAu9opvQ
	(envelope-from <stable+bounces-270428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:55:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A72036F7F9F
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:55:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=NsTgasIa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270428-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270428-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24BA330D95AE
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ACC481A96;
	Thu,  2 Jul 2026 12:42:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4648035B;
	Thu,  2 Jul 2026 12:42:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996175; cv=none; b=BGTw8fE3tSdcjvNkyGYjzB/ikymNABsk99xpRKEwFTvLhVATcJY+WkD/2V9R6G8/dUJSumaKHDD6nYgrtsBSLWDOolcVGpwC9H4eRrQqDDiZQigKH6ZWuBvqENOKMZaltsgTi16U82aG3oJZ1K9YBLkimLMfAw+zcOSeksqll24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996175; c=relaxed/simple;
	bh=MgWRd4h+1ZvF37zSMm+H/b1FobMAkfbtnh54QFTkQ8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXp2d8JhQ2MrHPbwc+i0h94nSoUGPL4RXAEEaLo55JjeFtoVL4Z4pq5CV81DoOTZP97uaE9HHBhqEKX55G2C/6u1r8siF7lv0kFeIyD4U1JnkmEozn/plLaUGgDlRJPaNzz+0Od9rGC7B8iO+9FQMANz9UWs1CFanTnhM4GircU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NsTgasIa; arc=none smtp.client-ip=115.124.30.99
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782996168; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OTB1A/EEfq3n6WQvgiifoOHUPAwpCie6I2ssPdTySVE=;
	b=NsTgasIaPhw7xUDJpGnjtVQGHfnXWfw9/uH61NLBWTUK5pbJATDM63V99/Yc+aCW0WglkwuACAGAWk/9dhZIr9NQ141aAfeKoJelkJNjzbE7wlxAzbVV3SFhvr6Os79TuuFdZVTvT1m9jKNGvPeUBjEMR43FqQa94sk/2ejV1Ro=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X6EmiYR_1782996167;
Received: from 30.221.145.62(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X6EmiYR_1782996167 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 20:42:48 +0800
Message-ID: <941afcdb-ee39-4649-901d-3c7a0d15b0f3@linux.alibaba.com>
Date: Thu, 2 Jul 2026 20:42:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] nvmet-tcp: fix race between ICReq handling and
 queue teardown
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, gregkh@linuxfoundation.org,
 skumar47@syr.edu, kumar.shivam43666@gmail.com, kbusch@kernel.org,
 dust.li@linux.alibaba.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260701134933.66838-1-lulie@linux.alibaba.com>
 <stable-reply-nvmet-tcp-icreq-20260701193800@kernel.org>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <stable-reply-nvmet-tcp-icreq-20260701193800@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:gregkh@linuxfoundation.org,m:skumar47@syr.edu,m:kumar.shivam43666@gmail.com,m:kbusch@kernel.org,m:dust.li@linux.alibaba.com,m:linux-nvme@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kumarshivam43666@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lulie@linux.alibaba.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270428-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulie@linux.alibaba.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lst.de,grimberg.me,nvidia.com,linuxfoundation.org,syr.edu,gmail.com,kernel.org,linux.alibaba.com,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A72036F7F9F



On 7/2/26 8:38 AM, Sasha Levin wrote:

> 
> Would you be able to send backports for 6.1.y/5.15.y/5.10.y as well?
> Your 6.6 adaptation looks like it should carry over with minimal
> context changes.
> 

The 6.6 version can be applied cleanly for 6.1.y/5.15.y/5.10.y. And I 
just sent out those 3 patches :)

Thanks.

-- 
Philo


