Return-Path: <stable+bounces-23860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01C2868B97
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799621F21E92
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5632112FF98;
	Tue, 27 Feb 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rzrny31z"
X-Original-To: stable@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040A55784
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024694; cv=none; b=HnVmtpYtzN+kzzSvj8WqpslyX5vgF9CBrlBHISURDh30qlTpvu56jL2VrYsUE1eMeWXRrJNyHJKqQnsJEmv2q/f1Cm1j2ZpApQDzcO8KlnNTJPhAXy2ur9CZwglQkC1E3xlW3TlKMzZWJrfKjfYmgCNCsb4m2GsOoz7yxlGkYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024694; c=relaxed/simple;
	bh=A7evPsmgZ44m271mYe+qFRKf60yaTpcqyxQbwIVrIMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNpNaz2SqM+TBQhlOPFefvhWnooxUd6ZHbtU4UtZC09MIEUoOeZqpESYG8J2lO2W5BsOXn+2BdfMcGRcvUjf+FxwE5xOPLyIRQGG+EieUErCsUOmriZhkENEvLG1ur1v/rRUDIpJ8c1qMk0kl7NGU9qz2lsSgcint55ZwjURDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rzrny31z; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <95333296-d656-4982-bec0-aee2d54ba254@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709024689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7/84TzBF+jT35enfzQ7YOwiSBEUyInd/LOLc13rNuY=;
	b=rzrny31z0/va5av7aj4IxvhsNPqhTFJeHINjDoXq99ZmH+cLC/MNas3W+ltzMMw9JBk8V+
	E7bAM3I/QfzzpsKlRT9dC6EFoFvVEKBJ13PUXWv7/2J/Un/19wNsD4mEMANaJq71Kh0hK+
	/ZWJIZc4ZWgXxDoIKOGd63kwAWWbBEw=
Date: Tue, 27 Feb 2024 17:04:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <2024022622-agony-salvaging-5082@gregkh>
 <20240227022654.3442054-1-chengming.zhou@linux.dev>
 <2024022743-rented-trembling-7797@gregkh>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <2024022743-rented-trembling-7797@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/27 16:54, Greg KH wrote:
> On Tue, Feb 27, 2024 at 02:26:54AM +0000, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> We have to invalidate any duplicate entry even when !zswap_enabled since
>> zswap can be disabled anytime.  If the folio store success before, then
>> got dirtied again but zswap disabled, we won't invalidate the old
>> duplicate entry in the zswap_store().  So later lru writeback may
>> overwrite the new data in swapfile.
>>
>> Link: https://lkml.kernel.org/r/20240208023254.3873823-1-chengming.zhou@linux.dev
>> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Nhat Pham <nphamcs@gmail.com>
>> Cc: Yosry Ahmed <yosryahmed@google.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> (cherry picked from commit 678e54d4bb9a4822f8ae99690ac131c5d490cdb1)
> 
> What tree is this for?

Ah, for linux-6.7.y. I forgot to use your command line to send patch...

Thanks.

