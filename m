Return-Path: <stable+bounces-227903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD/LDpLzwGkwPAQAu9opvQ
	(envelope-from <stable+bounces-227903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:02:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F932EE05D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3AEC3064EB8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB4366067;
	Mon, 23 Mar 2026 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ek3hlyfs"
X-Original-To: stable@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3023630BB;
	Mon, 23 Mar 2026 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252438; cv=none; b=a7ZYRqDXnAhqmVKIw1VIP6OunYcxcE7p4lvljllooXa2Y4qKWds5eyXYTM1T0Fh9sPd7M3H7RUkADYdFbLptrcEr6kf9EQZe3OL3NtOwe6mesC1b8TjJnHN+3FfpY39Ic624zfa+qq/vmupyommutdhz1m8mCmadfQW6AaizgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252438; c=relaxed/simple;
	bh=J68KqhTXz6bi1IqomhwUAlcCPOfYnJUdodygPhZvjaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Huv0ETalqNG6Kqz6gKxXXCheaJLGKcCyVVWfKl4CI5+kDtLbd5xY9PA1BSEpEZ92wOV2l94T1QAnVTN8Z1WGd6v68pcj4pEWzN5c4/6tvxTW6P+4rJhOPxKV4yEDq5KPsk9dgnK0WjQWlPxcdPtySKCL9M9+4zhGJHu8RvReMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ek3hlyfs; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774252430; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wJD2ZsTg6dIpYoe1fEovOgNeGSCaqIxgGZVO3kFEUcA=;
	b=Ek3hlyfsG/f5KsUCBwVIjBQRhuwPuARpNXjiyu9NZVr+ZnDl7qpThj8FyW6MU5kp4Z8uJFqMLjkOTJx5lUcSOqWKAau2rzjLZr/RJV8fF560Z3OegJXUR5tHT4YTmSzaUo8o8Gk2+BANqIBStYgFF0EhQX2kp/rEb0lrWUSE4A8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X.UYuOz_1774252428;
Received: from 30.221.131.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.UYuOz_1774252428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 15:53:49 +0800
Message-ID: <f9f2bd53-fc30-4606-bae3-4c8960e6c54d@linux.alibaba.com>
Date: Mon, 23 Mar 2026 15:53:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 1/1] erofs: enable large folios for iomap mode
To: Denis Arefev <arefev@swemel.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20260323074809.4542-1-arefev@swemel.ru>
 <20260323074809.4542-2-arefev@swemel.ru>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260323074809.4542-2-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227903-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid,swemel.ru:email]
X-Rspamd-Queue-Id: 81F932EE05D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Denis,

On 2026/3/23 15:48, Denis Arefev wrote:
> From: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> commit ce529cc25b184e93397b94a8a322128fc0095cbb upstream.
> 
> Enable large folios for iomap mode.  Then the readahead routine will
> pass down large folios containing multiple pages.
> 
> Let's enable this for non-compressed format for now, until the
> compression part supports large folios later.
> 
> When large folios supported, the iomap routine will allocate iomap_page
> for each large folio and thus we need iomap_release_folio() and
> iomap_invalidate_folio() to free iomap_page when these folios get
> reclaimed or invalidated.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Link: https://lore.kernel.org/r/20221130060455.44532-1-jefflexu@linux.alibaba.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

I think we have no plan to enable large folios for
Linux 6.1 kernels, if the following part is what you
need, how about just backporting the following snippet
with the updated commit message for some explanation:

> +	.release_folio = iomap_release_folio,
> +	.invalidate_folio = iomap_invalidate_folio,


Thanks,
Gao Xiang

