Return-Path: <stable+bounces-56057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA32091B761
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 08:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E9F8B20DC6
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0783145B31;
	Fri, 28 Jun 2024 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="KhsQ7rSH"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CD013E41F;
	Fri, 28 Jun 2024 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557541; cv=none; b=VXXrUY0VBqXKhFMUUvEL3E3j1wZ3zbuPdSS9KQuGyuKOPDQ/DE0ZiiuQMpcfaAaXU3Syp41CXZHycDx7WEpkLIoB0WwIGUq4zPIY4O/8ctwRjIepFw7ZVboDr8QeTqSBqZ0zZ3vdu9HpY8FLU1WpNV0cd8WHg8Cfaw3W3t0PDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557541; c=relaxed/simple;
	bh=hSGvHb8+lXJuTnoHaB9ScnO2kyc8p5165709XFLnQTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nc8JgqH7SMYxkYscvKLPAXvrrmP6WwvhUdqhze7KMXkatq0NlbVwQHe2rTBiLDX3+iWfOJu0J8LkNRA5GYiefbOWJq4BeIxshl7DJuOfjQU4NY9ZoAVzMVIeU/ih1+v5htpSSX6INi2k2qaEWlLxEoHo4IKNfrj7kdnvUHlka5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=KhsQ7rSH; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Il0HH/jIBQx7Jqc970Ksy6SMmEq0HDWMOl5kd+NG99I=;
	b=KhsQ7rSHqAB/4RBiWFhXtZDud4E+xZj2mOeTARh+bxfQKUxtTtD3rQ31ipgrDe
	IknVfgYtNQkawoEB0AWtAYrYEC/9k0XYOJOSCGSU4s4Cy1QFxRdByHw2V4ZQFJEf
	AWRY6wofDdT2oNY3F5uIvjq0XqgBwbXJJWkOoOYIqQJSw=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3n2+6WX5mlrLJAA--.9596S2;
	Fri, 28 Jun 2024 14:35:40 +0800 (CST)
Message-ID: <53ca3c9c-343a-44fd-b9c9-6c123b3da71d@126.com>
Date: Fri, 28 Jun 2024 14:35:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: Use try_grab_page() instead of try_grab_folio()
 in gup slow path
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 21cnbao@gmail.com,
 peterx@redhat.com, baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1719478388-31917-1-git-send-email-yangge1116@126.com>
 <Zn5UBMfT6LEpdpNW@infradead.org>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <Zn5UBMfT6LEpdpNW@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n2+6WX5mlrLJAA--.9596S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfsqWUUUUU
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOh4MG2VExFYuQwAAst



在 2024/6/28 14:11, Christoph Hellwig 写道:
> I was complaining that switching from a folio to a page interface
> is a retro-step.  But try_grab_page and try_grab_folio actually
> both take a strut page argument and do similar but different things.
> 
> Yikes!
> 
>> -int __must_check try_grab_page(struct page *page, unsigned int flags)
>> +int __must_check try_grab_page(struct page *page, int refs, unsigned int flags)
> 
> This would now make it a try_grab_pages.  Also please try to avoid
> the overly lone lines here and in the external declaration.

Ok, thanks.


