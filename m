Return-Path: <stable+bounces-206418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85783D06C1E
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 02:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2614D300D412
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 01:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B052C2236F3;
	Fri,  9 Jan 2026 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M0zuihtX"
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFAD219A7A
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767922718; cv=none; b=cFSortNA1Vy9NymFuQubQYiN066GBzxt+GU4gvK8g1q9pnqZpWmYzj0t/J9Ser0+y2tLTqVagXmCygSt45qlo/CdqfwBMntHdL0on018lvxP//k6GlirJcCTnIvQkkWzHFPNAU1qJ7sdiW7CkCLS2mNaSF5FogrwY6mVKlnwpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767922718; c=relaxed/simple;
	bh=orLIRsDOg0Ss/GbNx9zufVXFq3XxXTUfIe0yXogBSzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu1GXdWRv5oJXAE5bbGZMXMR6u4+ovXTnAHBahbOIZQDjzOKgkfJG8GNKPYP6pQjTS0hDXsioiHj63ZC/taImMX8EixX33ul4KS6UpAu5b3kloxLlsmOJS+q0zRyQWSFJHDZDNczTu4aDDIn5QbOfEL8KLVGbyn6ei9et8/V1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M0zuihtX; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767922713; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BWPOYhB8c6NttjjGe/ysY/nT7KwQqmra9rrt8ptQzMI=;
	b=M0zuihtXSzmLGUm27iVwJGgAOEZdMRgavy784AodRd9YYY7dY5Kr8pPff7O2kmzCaw75vJDh+SjGnGCLXsEuB37RyqIyltDbTN1jZZd70bL85whFjv+N5iZY3uAe6v0v8JlO7eAoUBdga7zoviy5AHiyaOeE0XTbeR/7hUdEtUk=
Received: from 30.221.147.42(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WweIlk._1767922712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 09:38:33 +0800
Message-ID: <3fcc48e7-776a-48b1-80e9-e972054778d3@linux.alibaba.com>
Date: Fri, 9 Jan 2026 09:38:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.6-stable 0/2] mm: two fixes for bdi min_ratio and max_ratio
 knob
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, stable@vger.kernel.org
References: <20251211023507.82177-1-jefflexu@linux.alibaba.com>
 <2026010849-omission-sublet-23e3@gregkh>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2026010849-omission-sublet-23e3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/8/26 7:07 PM, Greg KH wrote:
> On Thu, Dec 11, 2025 at 10:35:05AM +0800, Jingbo Xu wrote:
>> Have no idea why stable branch missed the "fix" tag.
> 
> Because that does not guarantee a patch will ever be backported.  See:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly in the future.
> 

Sorry I though that a 'fix' tag suffices for stable tree.  Thanks for
the pointer.

-- 
Thanks,
Jingbo


