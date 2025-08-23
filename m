Return-Path: <stable+bounces-172529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D67B32632
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E64C587EC8
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 01:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82EE1A9F82;
	Sat, 23 Aug 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RciGh010"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB491A5B84
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755912597; cv=none; b=Bv4J9VDxPKdbmx/2uJCJJ/fuh7FbxhxiAa0UPduWUefliXyTP2ZzsWTobk7JoUyyKQnVtB5m7N5lbCnPAqia2rnb8CW87Ie0G1KVEDSeMwLWAtD2yCs81p3xfU7dVFvfBO339M/555+DYxtLXXiAkjTCTSUdpDzIJjCZrz9sX8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755912597; c=relaxed/simple;
	bh=eebTNLbODHnfNYznM66lKU0eFyIocyvIE4h54/e/oQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG7KJnKC/OP3XefPr7nQtEzfbhG2nbQr5XT7I2WngdjsmMenJaMxBJk8azklzD8u8XjgK311EMbs1UCb3NqUUGGagmgNiludnraE0h5PSKpobiRMoCkIy/Ziref9K4bxzrgoT+KPA6kSTqaSXr5Tu796+njitmNGkzPzNZRQmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RciGh010; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb72d51dcso359067166b.0
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755912594; x=1756517394; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN436an4cyg/kh8RbzRxkUUwckCMwEPPW4Ijt1oCsdA=;
        b=RciGh010yCbtUZWM9NTDLuaQWt+ZR0leO8hEP/nNflXpCcUDZFcDofct2OEIuvRib4
         q3k+3pUSK0g0j1Z4oxrJj9U4voJntRebZOm0bj86oRn6Y5IYLCJUk+oWxH3g/y1Mf6Y4
         Ab/pwwEdtKzVmSMCiECEyw7Xhoyamla3lMAd/B1vAmIbDTh6zjBMw85mure2pH9nqVVN
         HDH7RSp+HmIUw6ChuOm5pTtg9XsdmpYtCMCNplIMZCDoJX0CKHzLH+KVTbTamiJhZeeM
         ZBL+IOtrEWfAVU0lEJVa1+QoxUGvVQ1cb+u6sD/lnivZt62MEgn+7rjJTzfbVpLvLUDv
         c+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755912594; x=1756517394;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KN436an4cyg/kh8RbzRxkUUwckCMwEPPW4Ijt1oCsdA=;
        b=itPvmJ3xjfgA8u6Y5ul7cxTRtL8HRn0z34aXVIhFLChcZl/2XbATOL6Wc4AViyLV8o
         IEapF86nF2qMRopISFk5PdyhFIcRwsQrRvyd8cDbEOAuplq0heWtW8NUDxGkGYQMTXFR
         9uwlbFzpD5wc45mtZlhtCDpBrNeJem5rvapRWZ/3VDIEYLNxI7Wd9EoW3aKZm1PWE5Dr
         MIUxo79GGmZcm1CEtqvNiGUSWIe5ZSfp4Y0RfPK5oWgiwY0UtCjJWLHNxUmOZjifdJLV
         3uHXjA4V4JGi7Gp2i+feAFbDpn2iVcC5WyXbTjbFJxz4FfeESqbI1UmEBdVFm07QXowY
         SsWw==
X-Forwarded-Encrypted: i=1; AJvYcCW7+ILg6zzLU8jnr6nzoulwDBOJ1BLXdO7jxkVzkv5JgyVxCAaIYb1buu8hKrg6IHwJy4hdx7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvrI2YImt2zjkGS6dkB5xw3FkUVhcawAWejO1sJvA6KA0ebvgR
	67EEnktJU/u3NvGPkdrk2YolU76zg2y9HIpQ5JGCG6wn7nf2hIrlosbJ
X-Gm-Gg: ASbGnctEwLir1Wn4vkwgOZLu3kxwKaHaWWFs/KVgzwe0hoJthFPaGm7d5rosF8Y6xUF
	KO0RELVz2VCCFSl3eZPB71IzTPvESmkXJoU81osteg+heUp6YMvXFa0ZAJwL/Z9zLzPWXY/A6ck
	qYEywq+MIqZGYXh81TIWSo8ZdjXlq/iO14NON4+wu4VeMEYY7MbgIEUFkEPzgxvi24EyDtSIo77
	daYIottmNyTe0eTRrMYYNdMJp9+glyIHm6XQpsJZEwn94UB/Hydbo4qmwMZYJfvK/xPWvRF2wxT
	NCrYguXyaDQEoNvf0dCqhpHify7phr1VRNox92+boXoLzSxHzoFh66yIR4KuMBldVhKpnKxne23
	lMkPLDAiRdZqsqB1XOycs6GOGpA==
X-Google-Smtp-Source: AGHT+IGwiQlMtlwhYU6c6Jpd6fvq0eyeiYuF/MNEi+zrWiwOkFs9MPE6qPvzRUsvh7G0hZYVa8USog==
X-Received: by 2002:a17:906:c115:b0:af9:d300:c60f with SMTP id a640c23a62f3a-afe28f161c6mr411116666b.18.1755912594089;
        Fri, 22 Aug 2025 18:29:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe4937a15asm71906166b.115.2025.08.22.18.29.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Aug 2025 18:29:53 -0700 (PDT)
Date: Sat, 23 Aug 2025 01:29:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix the address passed to notifier on
 testing young
Message-ID: <20250823012953.cw2n3j7nuqfsle2j@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250822063318.11644-1-richard.weiyang@gmail.com>
 <55735a20-1048-4c04-bcd4-45eff0079f61@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55735a20-1048-4c04-bcd4-45eff0079f61@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 22, 2025 at 01:08:57PM +0530, Dev Jain wrote:
>
>On 22/08/25 12:03 pm, Wei Yang wrote:
>> Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
>> mmu_notifier_test_young(), but we should pass the address need to test.
>> In xxx_scan_pmd(), the actual iteration address is "_address" not
>> "address". We seem to misuse the variable on the very beginning.
>> 
>> Change it to the right one.
>> 
>> Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> CC: <stable@vger.kernel.org>
>> 
>> ---
>
>I hope you must have rebased since your previous patch got pulled, and
>the difference of time between these two events is less than 1.5 hours :)
>

Thanks

I took a look at the latest mm-new, this one applies.


-- 
Wei Yang
Help you, Help me

