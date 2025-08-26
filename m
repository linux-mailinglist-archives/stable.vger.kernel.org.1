Return-Path: <stable+bounces-173795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF82B35FCD
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C1F1BA5474
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127B1F03D7;
	Tue, 26 Aug 2025 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ockq809W"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5AC7260F
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212689; cv=none; b=N/gfqfuCUcRrPCciaTi4GbF3GIGXNmnNzfWZCazWd+zOvzUmNjcep+h+ZndRiWbudly4HYnZJTcfOkkdUU+RiD/ihcvvC5l7E0U0b6qJALwPedfcPdiaAto14pF1KtR50wyzAIdGVprYaLiCKe7NBIZDn6cA0KBiHf0bK5IjwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212689; c=relaxed/simple;
	bh=quZxizD7fjUB25jilgGMPV6okVzwBXjWP8O0W2gSt9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KijHJ97709pgVQVl2kAlr3D1OG1sHpzb2PNXa6XNat0ha7DdWphevHok0CviJZ4z4/uTjUSJqpE08pvSdrvl1bM3u+XjmHQ+TxJsf3UIjv5N1OnGggCPmBDYVvGlpqIiJJ+dwGbe2b9HMoc1O7+owkXMAK7p4+VjpCViXDNOldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ockq809W; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61c325a4d18so5397082a12.0
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756212686; x=1756817486; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JKK5SDncP3QKyeoqTzwvu03OjuGEJmHoeWEpa7ww0M=;
        b=Ockq809W+NIbZoQ57Kbk1xZth1VTJQLlmJlc2snqw9ecq13bN4h9JJZAI5CSo8m5Hi
         H7FUSgmt+0vxdSeYn8+4WBlmEXfYSvNnfQmWv4se834snf6DnvCFRDDiaKLGNU9xmbbJ
         MhBbRmRFe4JUq7DZXvT5InPZxj+sRfGYeeUjy7xKlf0yaKB1mY8gwz2v3kYmIlydL7ry
         9KWxo9PMqfJFUgQsklyiUOc2lc4FcjTgI0oRwuCH54/Non9J5cLvrub91xYd9uNdGTe3
         BYrPL+ZW2mey3VYmzetdI5tmqCQlDAzC8CY5GrzJr5HzQ3C9aZmhBK0S9ak4K7+VLH4w
         6dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212686; x=1756817486;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JKK5SDncP3QKyeoqTzwvu03OjuGEJmHoeWEpa7ww0M=;
        b=pqfTez0v3mDo/Lx74I3nG6C58MWWzP/u6ESLUYSO2pIIvu4UD69amQK143Pw/zvXQy
         fxcPgLw1pMTZre7pZzYJBH6XWFmNJbYngLi4/y5wPSUN3o33Uu4QeyhUSW0mOl6tZVMW
         aLiVPt6HAaiQSZ9it7Y7UohAEyKiWAF2moRjSBoR+egDwpVxLGJ9aAdWP+awWoT1PF4G
         Y9QqyVT1Lnha46x5aUUOtnjDissEVPcg8RGUEwfs9b8mP/TCSOwDWaEHnAMFi5CDfPQX
         CTt8FgEp3c04Vbq1yk7CalqOMMmN9V/RrnDkMWRR2/i/KL1wxNA36IyxXaXY7nMMeAGR
         pq7w==
X-Forwarded-Encrypted: i=1; AJvYcCW8k70aK49xrdUOxnQdKZQ/POi25lW0wNVOTfLXBSPDbraMky6Y34/t+Lz0W9vCllQs3+zb0fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wRRZ9kJrYXp+fR9gCMBdYGRlouxx/SZx7MKJFPzA2+x5MSe9
	ila43NjZJSjyce/KaUfT4FXvJXv57B7E/gzD7a5Dcu0/u2J9e7fi8kY1
X-Gm-Gg: ASbGnctTqmBHlcrIEPlyqSX1dXQ3UjDqINTamr0rcnZD3r/haX3EV/WzWdcocQBPxp1
	TfGDQChJA8m1WJMC7VuW38WduBUrzeEdgl2JTqF2M0fzZgbfCt4VLqy+tlMAuhyRXCXlxQoYXQP
	UArYJ6XY1RtIOlocOQpa2UeTLuI6mp75NX+c8SmrGhGniHZYyXMp4JQPsVgVnbdz6VkxvrAhmaH
	bLr8eW8ReY78q/c8sk8quUt8kR7DMSueyGhLUBCLga0DqMfxq01bmRDnE7iKJvNna3UzL5Tv449
	PxPNFJldRJl8V8katkq0DK5zpgQk8n6AKmJgY42LJQdcAyCvl766PZ+0aSmj+GkU5btFq+PM2gX
	dkVoeceHbMN5fHAZlLkELdiIrLA==
X-Google-Smtp-Source: AGHT+IGqDw+TcK11sENHUUf1vFPyvCbmWROkG5DAb3lQsEoxoizI8GCl0K7/OMLab0J2SLft/gCIEg==
X-Received: by 2002:a17:906:6a09:b0:afe:ac13:71f with SMTP id a640c23a62f3a-afeac130a1emr193937966b.41.1756212686249;
        Tue, 26 Aug 2025 05:51:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8f8129f0sm299159266b.41.2025.08.26.05.51.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Aug 2025 05:51:25 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:51:25 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix the address passed to notifier on
 testing young
Message-ID: <20250826125125.7dy4stl6nikhyo3a@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250822063318.11644-1-richard.weiyang@gmail.com>
 <0a2004c2-76e7-43ea-be47-b6c957e0fc14@redhat.com>
 <e9342d11-fe37-4df4-bc29-cc7f7e0ed38c@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9342d11-fe37-4df4-bc29-cc7f7e0ed38c@lucifer.local>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 26, 2025 at 10:03:27AM +0100, Lorenzo Stoakes wrote:
[...]
>> >   			referenced++;
>> >   	}
>> >   	if (!writable) {
>>
>> Maybe, just maybe, it's because of *horrible* variable naming.
>>
>> Can someone please send a cleanup to rename address -> pmd_addr and
>> _address -> pte_addr or sth like that?
>
>YES THIS.
>
>>
>> pretty much any naming is better than this.
>
>I despise it, and I realyl underlined this on review in Nico's series because
>it's just beyond belief.
>

I see your comment to Nico's series.

>It's terrible. I mean maybe even I will do something about this, if my review
>load eases up at some point...
>

If you are fine, I could help to do the renaming.

>
>Cheers, Lorenzo

-- 
Wei Yang
Help you, Help me

