Return-Path: <stable+bounces-50272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6B6905510
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AB51F232B5
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705817E452;
	Wed, 12 Jun 2024 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XbVpxxRJ"
X-Original-To: stable@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0912B89;
	Wed, 12 Jun 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202364; cv=none; b=Qkinaq5zrh0NvvAqpq/S2RBbBgiLmuLe4/IBv5AQrcSdZDJUsZVUhzcwUB9vb6pSz8eq7daZGYUbWD5IsTNOMK9d61FgncPLkduQ9m2QwUnmcxIUKcNbpBMWyGWRxmw9hm3l5WrE66R4chinwChdzYrjZ4VOzKrV/ie0fXsqEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202364; c=relaxed/simple;
	bh=nFmnwpGodliBEE0WLwypy43OmDGr37yuAlhyk+8JRBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRbPFkB+j8WtHqa6PrpHzg21L03WGjlaf8578NEPD+sgP6xcDtqsqR//ZW8ur6XbK4hW3UbwZ4K4f1aE5GUvM2rps8ROPQBehlCwbhUQ2iVSGoOYqUuaWqM8v7EAx3J9oUbN51Ja6TSoRVLs/XjFKY6Y/UpkZDS4+FK2U0quln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XbVpxxRJ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718202353; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VPqsnngP6Msuty09s5btoVz23RhEI/2lKIgk4pnmyxU=;
	b=XbVpxxRJzieCzcjXcUllWbI4gmMEaWZqSHEQP1Gu/6YRXM0VJjhzjIICGWLErAf5TZIB4d/Q8JVA5IQb1KFuazDChfk1ziBEQiZ3nBvRbEryJeTarOudtkjjzAxtxGqBPQEKqqN9WJRKR2RQTbk8JbhT2bxEnUmO00ClR0voox0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W8L5hzk_1718202351;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8L5hzk_1718202351)
          by smtp.aliyun-inc.com;
          Wed, 12 Jun 2024 22:25:52 +0800
Message-ID: <8d9753ad-9c88-49e5-b590-2e0ea9374bb4@linux.alibaba.com>
Date: Wed, 12 Jun 2024 22:25:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9.y] erofs: avoid allocating DEFLATE streams before
 mounting
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, Baokun Li <libaokun1@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Sandeep Dhavale <dhavale@google.com>,
 stable@vger.kernel.org
References: <20240530092201.16873-1-hsiangkao@linux.alibaba.com>
 <2911d7ae-1724-49e1-9ac3-3cc0801fdbcb@linux.alibaba.com>
 <2024061231-nuclear-almighty-1a81@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024061231-nuclear-almighty-1a81@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/12 20:54, Greg Kroah-Hartman wrote:
> On Tue, Jun 04, 2024 at 08:33:05PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> ping? Do these backport fixes miss the 6.6, 6.8, 6.9 queues..
> 
> Sorry for the delay, all now queued up.
> 
> well, except for 6.8.y, that branch is now end-of-life, sorry.

Thanks Greg!

Thanks,
Gao Xiang

> 
> greg k-h

