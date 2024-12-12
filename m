Return-Path: <stable+bounces-100892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9617A9EE4D9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2106E165F2E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0F20B7FA;
	Thu, 12 Dec 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PBMkO9dd"
X-Original-To: stable@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD41C5497
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002130; cv=none; b=ujsxs//YSlw9nI13k+0dQkjZyzGJnWEV58fHMXqQHH0E9BzC7+KM4JHtjFudEy4qGCAF6vhV9ZRYNgZ8SLD7d0IG/0R8g4jDNOHKfcj2M2PE9lPMxCOEeKsmh2ueFe1uTY9eYx8A0BGC36a/14YxJM3HXVlPaVE9nzAx7YRBao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002130; c=relaxed/simple;
	bh=7nQK3hn+myDIKNMXRU+1bfVfLiHCII+fzTl4UCKZ2WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmKHPjHm0Md/z8KpIYd4nTzywcBg6Nv42DnyCBgSMekoklq/wsQrm6JDIR3aLr5BoBKuER7ZkifDoNeH6Fq/mQCFp4swfe89jxsTmLqUTMgEoxlZ7PC/RK3jcFOQhmqcNY7A/bj2NAdUYsBoQF5E5QCep8Q+NiuyWHJdxAQ1gR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PBMkO9dd; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734002119; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oeiEubT4CSon5lbj1RfCxVeUR9LtTKc+cOS0O/d82eg=;
	b=PBMkO9dd7KcjgTTriifSubEH7BPPEkm+dh+NCPFbpEDbRfqOKE5iVISozLM4mcEqOTz7V8mrv67xp+4Tx8sWBMsiTQG1SAmmNYLwtkkgU4yNMb8juvKtmH3mYe2nRmj1ZY56vBvkxrtHyUtHF/RJA7wjnyOAraN0YGm1eFjUETY=
Received: from 30.221.82.132(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WLLWitY_1734002117 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 19:15:18 +0800
Message-ID: <20feb966-acb8-40f7-8ee2-26d069b3f939@linux.alibaba.com>
Date: Thu, 12 Dec 2024 19:15:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ocfs2 broken for me in 6.6.y since 6.6.55
To: Greg KH <gregkh@linuxfoundation.org>, Heming Zhao <heming.zhao@suse.com>
Cc: Thomas Voegtle <tv@lio96.de>, Su Yue <glass.su@suse.com>,
 stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <21aac734-4ab5-d651-cb76-ff1f7dffa779@lio96.de>
 <0f122ee5-56e3-45b0-b531-455fcf9cea3c@linux.alibaba.com>
 <2024121244-virtuous-avenge-f052@gregkh>
 <a6054a83-2dda-4548-afd3-96dcea453159@suse.com>
 <2024121210-snowbird-petty-f516@gregkh>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <2024121210-snowbird-petty-f516@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/12/12 19:06, Greg KH wrote:
> On Thu, Dec 12, 2024 at 07:01:08PM +0800, Heming Zhao wrote:
>> Hi Greg,
>>
>> On 12/12/24 18:54, Greg KH wrote:
>>> On Thu, Dec 12, 2024 at 06:41:58PM +0800, Joseph Qi wrote:
>>>> See: https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#t
>>>
>>> And I need a working backport that I can apply to fix this :(
>>
>> I submitted a v2 patch set [1], which has been passed review.
>>
>> [1]:
>> https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#mc63e77487c4c7baba6d28fd536509e964ce3b892
> 
> Then please submit it to the stable maintainers so that we can apply it.
> 

The two patches are now in mm-tree.
We may submit the revert patch to the affected stable trees once it goes into upstream.

Thanks,
Joseph

