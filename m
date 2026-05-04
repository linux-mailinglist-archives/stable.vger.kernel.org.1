Return-Path: <stable+bounces-242991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOI2ONJ1+GlavgIAu9opvQ
	(envelope-from <stable+bounces-242991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:32:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DFE4BBC65
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C42C300363D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F643932D1;
	Mon,  4 May 2026 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GQXY4v5U"
X-Original-To: stable@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111C38C423
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890512; cv=none; b=jcQiiUHDIjF0mQN/KtL5t+bWFSBN32Za/jys767zHQ5p3JCWuQMqheur6KjP8tZXkifDgmYVwKxg5DrdRH5+r6aeNvIlpAjlpGsoGw0iCJq7gE6BR/jcVVat+s7sY1g/xRFMT+QWWz3mRRZb456s4/turNu5R/7vdcil8atZF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890512; c=relaxed/simple;
	bh=l0u+qIbMG4K3gGG4R1IQyfVCAKBiFcgivd12uIl/stQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDsujxn3OAfZDDM6eiDJW5NKECfCTPenbOrdjtUnsQCoESMzOzhlrcAhCUJGbG7WCzpWF4hRJo0EDVB5hCYFjbhQZJXj0q33oAtu1WiV0x24d0dBbNFcuKqF/LSsZQCAxibzqRVwIumuUPiYeergv6MgF/ak7NYZdJAOu+QemR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GQXY4v5U; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777890501; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WnrwbVqsOYhf12NlUY/G8R9GdmmzIFV33O/wNPiZVKY=;
	b=GQXY4v5UxLDeR8tpus8UjaTJwjAAXd+1adpgCe936t6fr1jJFIJlXR04IJJxZOIgwL6CW7p3femVBVr/jzmvQ+KNkOW03DwGQtICnDhbcBN/YzniSnVz5hqTOar1/cPZwplIucpfSpSl2tVbkmuiv8eLHl0TxG2uG5SteVt2VIQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X2Aqmdj_1777890494;
Received: from 30.69.177.140(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2Aqmdj_1777890494 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 May 2026 18:28:20 +0800
Message-ID: <4895cf47-70e2-45ec-a7d1-3a762d09c515@linux.alibaba.com>
Date: Mon, 4 May 2026 12:28:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] erofs: fix the out-of-bounds nameoff handling for
 trailing dirents
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo
 <moonafterrain@outlook.com>, Chao Yu <chao@kernel.org>
References: <2026050132-spender-underfoot-6d7b@gregkh>
 <20260501191150.3973995-1-sashal@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260501191150.3973995-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 37DFE4BBC65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242991-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,outlook.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,sashiko.dev:url,linux.alibaba.com:dkim,linux.alibaba.com:mid]



On 2026/5/2 03:11, Sasha Levin wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> [ Upstream commit d18a3b5d337fa412a38e776e6b4b857a58836575 ]
> 
> Currently we already have boundary-checks for nameoffs, but the trailing
> dirents are special since the namelens are calculated with strnlen()
> with unchecked nameoffs.
> 
> If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
> maxsize - nameoff can underflow, causing strnlen() to read past the
> directory block.
> 
> nameoff0 should also be verified to be a multiple of
> `sizeof(struct erofs_dirent)` as well [1].
> 
> [1] https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com
> 
> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
> Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> [ replaced upstream `bsz` with `PAGE_SIZE` and `sizeof(*de)` with `sizeof(struct erofs_dirent)` ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
Looks good to me.

Thanks,
Gao Xiang

