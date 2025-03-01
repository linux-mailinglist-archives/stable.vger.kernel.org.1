Return-Path: <stable+bounces-119983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A8A4A82F
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 03:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97773B8A8E
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 02:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90A717AE11;
	Sat,  1 Mar 2025 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RHBgEY9e"
X-Original-To: stable@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800D28EA;
	Sat,  1 Mar 2025 02:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740797887; cv=none; b=jGjMEaEIear8mS4osnbsNeL5LOhBDAsNnDsKLWOILEGVSsDW2oHJ7lshAqy0T4e7/hA01Asmfqx1qqSI1b3w1d7S+aZjCMjMllYZRWg97ywz86ExgT6kehhFIKObuw2WMz/6tyqVCoAZeeYoc79eJK31+ChysO0N4KyE9qgw4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740797887; c=relaxed/simple;
	bh=TdhWyrVBeenJ2oTaR93MCXPxbvoY4iVENO4GF9P7Ubg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMNg5Zx+VdRHjGDdV5l0Zh+9zdJLlP1JHvWiH/ThRizmNW9IW2WAnxmhzm5HQo/Ukdn1g4MdQRTg8CsavLPTqiHiGMe2xGMjdz6DsN7dASsgFefsCmPaN2dVyMnU9w8Nb96KCD1pGNL3Rg5g4TqKRGMEkOw5UPfUOjZEtrEG+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RHBgEY9e; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740797874; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yBJ/YWZwYMtRqOfTkO0z7TIkn5oTZoJWOZUWl97CPZw=;
	b=RHBgEY9eME7ymLjpqLbs+xi8IoDxH2d/fJ9gmq00DHDCv93jIJRCtTl5GnHnGF2Z9rPTxRrMfAHla87sDfyFIlV5fqjYddzBFEILE7wb9ebGJ0/NiiNfXDy0t8KDYKRUFhUrSip/mFgv8Z2HQly0hbZos+puZ6amQGJUdJHYfCU=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQRC.Xs_1740797551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 10:52:32 +0800
Message-ID: <c9cf602f-de40-4917-9f8a-d6b88e57482d@linux.alibaba.com>
Date: Sat, 1 Mar 2025 10:52:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0/2] erofs: handle overlapped pclusters out of crafted
 images properly
To: Alexey Panov <apanov@astralinux.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Max Kellermann <max.kellermann@ionos.com>
References: <20250228165103.26775-1-apanov@astralinux.ru>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250228165103.26775-1-apanov@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/3/1 00:51, Alexey Panov wrote:
> Commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted
> images properly") fixes CVE-2024-47736 [1] but brings another problem [2].
> So commit 1a2180f6859c ("erofs: fix PSI memstall accounting") should be
> backported too.
> 
> [1] https://nvd.nist.gov/vuln/detail/CVE-2024-47736
> [2] https://lore.kernel.org/all/CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com/
> 

Thanks for your effort! Patches look good to me.

Thanks,
Gao Xiang

