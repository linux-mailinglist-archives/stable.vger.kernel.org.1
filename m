Return-Path: <stable+bounces-195205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7989C716F0
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 00:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A24A4E1F6C
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 23:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425BE2D660D;
	Wed, 19 Nov 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch/i8MOo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BE263F28
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763594328; cv=none; b=pStini96XnLmBDwbPfvn66VWiz2K60BpV4d/pt9d+h/eMades98fDkG5dJUzTtUJcq3N+P57iTQJfrjzJ5PfDG3qeIWvCIJOoug8ZrY15J+W5ZEr3qtD6qIGUqb/g4aDygXV1ul2RuO0xDJZqAxSG0hSdoo1jQdZoFinfw4BPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763594328; c=relaxed/simple;
	bh=MQpYD4WouEOlcC2R4GQr0bmE0kxrkvFpe0KspOnMWWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8/ryxrdI4Oh9lnVt5Zv9WQ62vmWW9/3xIeU070/1E6wTmpsJIPbP0zWh2z71yQrIZtH2mcvcx5V5px21A+Yq1xfLnSQQQ504bkskwov5uTGnqG+N/cmKbqhSnc+6CAJ4LmfsmpqMoiaQpBdyLRrwS3jx8MapouiraY56rHxvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch/i8MOo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so408001a12.1
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 15:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763594324; x=1764199124; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EYaTq04pxx2em+tWLHC+QVEyZDqapxzz1bUuYhfcG8=;
        b=ch/i8MOoMSl8+uHWE1/TRr+7Qgh5VWM0GQ9jkrPoFX7WKFmPt0et6Anh902NQtAbjt
         KJw7p0F3vYXVVsN4rU0+cVkIltTSfXxgZYVLLRt7foUsv9hq06aIPoU3UOoDuIkVbG7n
         1Bmzn+QHxXPf4CrzzrpYX4sLxMRCIxMiKu+xU+0HO8Ati9rwUWLRdxnv54DKDAqpbOAk
         JoIcc8NoIhu2wzuAKK1+mV7xoE0CwyvJo5F2IQaEf3mJOnFmsKj3aZxCSOKX8hk6eM4k
         ePwvDXHed88LCe8n3565d5h8/3IjVFbo3L5FKG5zUw7GsogUOCwM76ashR4BTkNNqRPS
         ck8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763594324; x=1764199124;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EYaTq04pxx2em+tWLHC+QVEyZDqapxzz1bUuYhfcG8=;
        b=lAIxgb4No2CQyVuD4EkBT8fA1j6LHdXBPpgo0KubblM9g8u+uWd+Q7DAzIrF+VJZA3
         fwOvJy1LmiF8FYjHS62PQCauyiBTLpqIFVd/oCX8/gIETLVFUsLVDZk2iehqmuUAKJY8
         n2ui2Fy85UrAfgXY0QY78kmWb74OI71NL2VrpQzKEAfz91r79IsbFcak6OcHsYMA4bcK
         Awn86XhZDA+rgi5DrF1JZFy0dFvJteRttQOoMwHghIcYHHcuSewVB1iUsp8nkX+4+/jK
         OegxXa8FkqQHjGQAgC+P8lQ5YJ9pWI4WIW5uvF9iB+x83ccmv6xVS0C/kIqCnzYH8rYK
         8nKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2f6ahp8/bepOpJn2dEtnEGCdAOojX9dyj8eju7F7KViRJ10+/OZNLe723JXnMk7G75ozlRIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/V33hgSuK+eGlZE0BVfRinftjbI5SUlebYI1ApHpFB+Xd1bvR
	xLjTV9POEhyjeQnNnXPmEFaxsEroJ22CwwO/6zEQv4cOAxfZoyTQl7zn
X-Gm-Gg: ASbGncuknMlYP/kVDHfAOFQ4bQj//UHS6BJ0oOZyNSHTh4ahecQOSQO294ekKU3qtuI
	X3EvFjaE4SLytZnplXvTiSOMNFsvj5IsnBJk/NWpnz2UDvEmSSRxKOQPF5UC9Qv0rrieV5mmkiF
	Le3jJg/QC/FVhEI2kavq0xjOn+lL9DBszfzgo+e5+EwJh6XY1V99Lz3KhjsnH2KBkNk89EWaNSG
	NV/oQYu2GMyCyI0w/HQ5bYbjAydweKm9tnKVUocVIAdXA33d/eP/hrmnXb+zbIsobk/OVMatY/J
	MLlvTqrb21dzB/O4/k6Wo7GBYu9YBgHfxmc2JSKPl9OwevX9BOiX9OZ+lt/Qe7kidsjpWpyAxgq
	K3HWvQunYzMM5a1m807/MdJE55so77yJYvTz9cVyYtO/qf2oVSbTlRoUzUlZhyyC5fUZpXV23gN
	QOW2FUPofBAq5u0A==
X-Google-Smtp-Source: AGHT+IGI0GU21OMn5soG8qAJy7MLT9UuRh/S+6lqQCxYMx0vV4klIgtWKPLqbzRYpnnPguB43plIIQ==
X-Received: by 2002:a05:6402:1472:b0:640:eea7:c95b with SMTP id 4fb4d7f45d1cf-645363c6721mr1018915a12.6.1763594324328;
        Wed, 19 Nov 2025 15:18:44 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b62cesm682240a12.13.2025.11.19.15.18.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Nov 2025 15:18:43 -0800 (PST)
Date: Wed, 19 Nov 2025 23:18:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when
 splitting shmem folio in swap cache
Message-ID: <20251119231843.u7tvwxdoxwqzvxyq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
 <20251119122325.cxolq3kalokhlvop@master>
 <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
 <950DEF53-2447-46FA-83D4-5D119C660521@nvidia.com>
 <4f9df538-f918-4036-b72c-3356a4fff81e@kernel.org>
 <FA37F8FD-DDAB-43B0-9BEA-2AC25986767E@nvidia.com>
 <822641bc-daea-46e1-b2cb-77528c32dae6@kernel.org>
 <14253d62-0a85-4f61-aed6-72da17bcef77@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14253d62-0a85-4f61-aed6-72da17bcef77@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Nov 19, 2025 at 03:46:14PM +0100, David Hildenbrand (Red Hat) wrote:
>On 19.11.25 15:37, David Hildenbrand (Red Hat) wrote:
>> > > Given folio_test_swapcache() might have false positives,
>> > > I assume we'd need a
>> > > 
>> > > 	folio_test_swapbacked() && folio_test_swapcache(folio)
>> > > 
>> > > To detect large large shmem folios in the swapcache in all cases here.
>> > > 
>> > > Something like the following would hopefully do:
>> > > 
>> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> > > index 2f2a521e5d683..57aab66bedbea 100644
>> > > --- a/mm/huge_memory.c
>> > > +++ b/mm/huge_memory.c
>> > > @@ -3515,6 +3515,13 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>> > >           return ret;
>> > >    }
>> > >    +static bool folio_test_shmem_swapcache(struct folio *folio)
>> > > +{
>> > > +       VM_WARN_ON_ONCE_FOLIO(folio_test_anon(folio), folio);
>> > > +       /* These folios do not have folio->mapping set. */
>> > > +       return folio_test_swapbacked(folio) && folio_test_swapcache(folio);
>> > > +}
>> > > +
>> > >    bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>> > >                   bool warns)
>> > >    {
>> > > @@ -3524,6 +3531,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>> > >                                   "Cannot split to order-1 folio");
>> > >                   if (new_order == 1)
>> > >                           return false;
>> > > +       } else if (folio_test_shmem_swapcache(folio)) {
>> > > +               /* TODO: support shmem folios that are in the swapcache. */
>> > > +               return false;
>> > 
>> > With this, truncated shmem returns -EINVALID instead of -EBUSY now.
>> > Can s390_wiggle_split_folio() such folios?
>> 
>> [noting that s390_wiggle_split_folio() was just one caller where I new
>> the return value differs. I suspect there might be more.]
>> 
>> I am still not clear on that one.
>> 
>> s390x obtains the folio while walking the page tables. In case it gets
>> -EBUSY it simply retries to obtain the folio from the page tables.
>> 
>> So assuming there was concurrent truncation and we returned -EBUSY, it
>> would just retry walking the page tables (trigger a fault to map a
>> folio) and retry with that one.
>> 
>> I would assume that the shmem folio in the swapcache could never have
>> worked before, and that there is no way to make progress really.
>> 
>> In other words: do we know how we can end up with a shmem folio that is
>> in the swapcache and does not have folio->mapping set?
>> 
>> Could that think still be mapped into the page tables? (I hope not, but
>> right now I am confused how that can happen )
>> 
>
>Ah, my memory comes back.
>
>vmscan triggers shmem_writeout() after unmapping the folio and after making sure that there are no unexpected folio references.
>
>shmem_writeout() will do the shmem_delete_from_page_cache() where we set folio->mapping = NULL.
>
>So anything walking the page tables (like s390x) could never find it.
>
>
>Such shmem folios really cannot get split right now until we either reclaimed them (-> freed) or until shmem_swapin_folio() re-obtained them from the swapcache to re-add them to the swapcache through shmem_add_to_page_cache().
>
>So maybe we can just make our life easy and just keep returning -EBUSY for this scenario for the time being?
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 2f2a521e5d683..5ce86882b2727 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3619,6 +3619,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>        if (folio != page_folio(split_at) || folio != page_folio(lock_at))
>                return -EINVAL;
>+       /*
>+        * Folios that just got truncated cannot get split. Signal to the
>+        * caller that there was a race.
>+        *
>+        * TODO: this will also currently refuse shmem folios that are in
>+        * the swapcache.
>+        */
>+       if (!is_anon && !folio->mapping)
>+               return -EBUSY;
>+
>        if (new_order >= folio_order(folio))
>                return -EINVAL;
>@@ -3659,17 +3669,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>                gfp_t gfp;
>                mapping = folio->mapping;
>-
>-               /* Truncated ? */
>-               /*
>-                * TODO: add support for large shmem folio in swap cache.
>-                * When shmem is in swap cache, mapping is NULL and
>-                * folio_test_swapcache() is true.
>-                */
>-               if (!mapping) {
>-                       ret = -EBUSY;
>-                       goto out;
>-               }
>+               VM_WARN_ON_ONCE_FOLIO(!mapping, folio);
>                min_order = mapping_min_folio_order(folio->mapping);
>                if (new_order < min_order) {
>

Thanks, will prepare a v2 with this.

>
>-- 
>Cheers
>
>David

-- 
Wei Yang
Help you, Help me

