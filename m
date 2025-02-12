Return-Path: <stable+bounces-114977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99622A31A75
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 01:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AED43A6638
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 00:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6061A17C2;
	Wed, 12 Feb 2025 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0mx9PFo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2394C81
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320004; cv=none; b=cwK8N9086KNipuG1tX5h0wVhxFwSQ7u0zwUjXVey/gU47zzqa4G8gRs2DPMWy5jsrsjy/dg1ckejEvRv9jomi+VXIS7lb9VX7w4gveNMNFNq8O0m5N1oKhai3nP4KXo5fJDxKBgqLESe46UJ5VB+SyGqCgVT0S48ilAu960zJbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320004; c=relaxed/simple;
	bh=0EFMjBnK6aIaEZi0NjpdjeTlnhISTwoG/4K7RvWFbFg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=impwuUVJj6wMBxd17iLvh7uxW2SbNqAnRcCRQEM3Jk8BKNbcXkye9Tp+YRT0LMts3LKVUH3J2upKNRKdqRn+eLkDkzI2P39CspnSuw/QntGTWHPEp9aVaRgNTZilSGtDVMREqw0yw6F9z0uOJiVjrxQDHFy08nrI44+UAZ4TBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0mx9PFo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7d583d2afso57422966b.0
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739320001; x=1739924801; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDi9b8nXfOgLC4OZ8uFrFGTWicCHZv9D3lGMNmGIIOQ=;
        b=d0mx9PFoI1nEKEnIEl6ZV5qHki0jhwHfWCBtktHzI5+MCAbhrEfME++lHWJoCh8i6v
         vrKs6OJcu+4G8Xim+9jqeiZLgqwLDxCZDv8JMQ5ZF5d1aC6cX43EeUjVyrpSWda/9rd0
         ffJN76EY6oM8Th95Z9udjw9v7MEPkaIpR9Og/Ug/oj5uE7DlL5ChJBLx0HjMlHhF5HmT
         lkljCEwMeBbKBTVxxN7hnjtcebNQabpO0RZGPnoBjEDlvYsIXv+OWDXhw8qGnXfmYspU
         dxV7e+C/jC3926STF3PwHnomk9127ePtgTBkJ3N84Rgd3J/PhMaFO6mGIHNtIuwwhLhn
         zt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739320001; x=1739924801;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cDi9b8nXfOgLC4OZ8uFrFGTWicCHZv9D3lGMNmGIIOQ=;
        b=GVYg0S3qFnCHuPaU6Fy53h60NmLc6+ZaqaPS/j/YpSH7s4QOgVpGbpTVQAKJSlMP2l
         O/6k69VzRQ7oyoN/0ofgxZbkAK8eu3SZOWm9qTzlm26vQ9adkiZjhhcOnHzD91V9T90M
         /7U6wq0X30Wh49Uv1qbBzyRsuC/Q2AUIzetgdOZ8p526IyV+a4nrwEw7S/db/Nye54xU
         qureXvYJUtv5ZpbKKx2phr5UZufSQYjhJde5c581m/rGSwkYcQbukGNTADMaJ5JICBP5
         UGRyYmCtM1yyux8KCKp8X7AcgL/o1/9JNXrmR+/5uVxcuoKEkccGhO4auiZbY9Leflau
         pfBg==
X-Forwarded-Encrypted: i=1; AJvYcCV8W3q0APskgTwvMM5uer72Vu+Z2w+G1477lr1sGbGBSPhNVKZhZkUYrQjOa52Dq2EtL+5ekuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7EZ/EC3o5NDAlbjs+dmgw3xBNkN5X3emam7E7V/pMitdJJNoe
	XMMX93TS1wHHOwDNu3bwNPeux77d+Bs8R1HhvQGQFmuaq7gp+T2G
X-Gm-Gg: ASbGncu7orRWRkxf+CEBdruKRRIae0Ra/KaZe22ErDnhgEqYuzMyJBjXoTal/L3LgTd
	tTPHPcLlKzBMQzAWl5YSaZpt1y5AhTIRpjZWEvYCHj5ROFmfXcqfM6joIm73Dw632LvFx1OoS8v
	7M7tJyYZ6LKolBN2XuxU+xdH0kGwTAlgZf6faVNw2zkM2eJFJXYnblScQoaP8oYFIVakD3foalG
	7FruiMjum5VXm+/7krtm2cxmILGNJCLUnqGWTNqA9VqpciBAKk5AYzueCrlz1atfZARK5qgnPE5
	S0pVMJ4malI44bE=
X-Google-Smtp-Source: AGHT+IEjSlp61Q6LQWyzaFOEGsjnlMCh/lUAcmzkLtMwEKIPuAbfFSjW71fS0ETLPZ9zmVLwo52EiA==
X-Received: by 2002:a17:907:2d8a:b0:ab7:cf7c:f9ed with SMTP id a640c23a62f3a-ab7db5a5addmr412852166b.24.1739320000406;
        Tue, 11 Feb 2025 16:26:40 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5ef7029asm7229761a12.58.2025.02.11.16.26.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2025 16:26:39 -0800 (PST)
Date: Wed, 12 Feb 2025 00:26:38 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] maple_tree: may miss to set node dead on destroy
Message-ID: <20250212002638.m5bp2qxo4rhrqkij@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250208011852.31434-1-richard.weiyang@gmail.com>
 <20250208011852.31434-2-richard.weiyang@gmail.com>
 <42meyihs3gnp3bbvn5o76tzh6h2txwquqdfur5yfpfu36gapha@rtb73qgdvfag>
 <20250211074821.uw43qk5mk2shrndk@master>
 <cczf2ivzq6aj6hhxkpzlbmvjbcl72podpyzqf22p2qwhrf3gv7@gxs5hnjcky5a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cczf2ivzq6aj6hhxkpzlbmvjbcl72podpyzqf22p2qwhrf3gv7@gxs5hnjcky5a>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Feb 11, 2025 at 10:23:26AM -0500, Liam R. Howlett wrote:
>* Wei Yang <richard.weiyang@gmail.com> [250211 02:49]:
>> On Mon, Feb 10, 2025 at 09:19:46AM -0500, Liam R. Howlett wrote:
>> >* Wei Yang <richard.weiyang@gmail.com> [250207 20:26]:
>> >> On destroy, we should set each node dead. But current code miss this
>> >> when the maple tree has only the root node.
>> >> 
>> >> The reason is mt_destroy_walk() leverage mte_destroy_descend() to set
>> >> node dead, but this is skipped since the only root node is a leaf.
>> >> 
>> >> This patch fixes this by setting the root dead before mt_destroy_walk().
>> >> 
>> >> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
>> >> Cc: <stable@vger.kernel.org>
>> >> ---
>> >>  lib/maple_tree.c | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >> 
>> >> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> >> index 198c14dd3377..d31f0a2858f7 100644
>> >> --- a/lib/maple_tree.c
>> >> +++ b/lib/maple_tree.c
>> >> @@ -5347,6 +5347,8 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
>> >>  {
>> >>  	struct maple_node *node = mte_to_node(enode);
>> >>  
>> >> +	mte_set_node_dead(enode);
>> >> +
>> >
>> >This belongs in mt_destroy_walk().
>> 
>> You prefer a change like this?
>
>Yes.
>

Thanks, will adjust in v2.

>> 
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index e64ffa5b9970..79f8632c61a3 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -5288,6 +5288,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
>>  	struct maple_enode *start;
>>  
>>  	if (mte_is_leaf(enode)) {
>> +		mte_set_node_dead(enode);
>>  		node->type = mte_node_type(enode);
>>  		goto free_leaf;
>>  	}
>> >
>> >>  	if (mt_in_rcu(mt)) {
>> >>  		mt_destroy_walk(enode, mt, false);
>> >>  		call_rcu(&node->rcu, mt_free_walk);
>> >> -- 
>> >> 2.34.1
>> >> 
>> 
>> -- 
>> Wei Yang
>> Help you, Help me

-- 
Wei Yang
Help you, Help me

