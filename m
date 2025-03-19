Return-Path: <stable+bounces-124889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB6EA68672
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 09:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B1619C4398
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9430250C16;
	Wed, 19 Mar 2025 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgfVog+z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDE2512F2
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371936; cv=none; b=Lyau0MHDh7Sc325QlrmdwH6R870aFJrhyvoSiz96NgWJT3AFWJTT0Tkz/alcA3jyZrUYlNSrewx38ZV78mE9f+Dccvonq099ryy9xTnUDnwi5m/okWWh/kYCKPRjsklT/4s26svm319mIJR5CkSowgEf9V5vBY4XfZOyK6mdwtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371936; c=relaxed/simple;
	bh=aaacBenPY/kQ+mb5S9b1knYpd12V981qPdu6b3BXtVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK/QfaKsDo1KoaG0U6dX0MDto6smI//uIju6Nz/Oir2m2JZuL+XJNrxTBMUzL6ol17SGaQ0vVRqKl7Ira5f1UiqWH9ftSCtNdQYBjwMRa5nS8q0ntXmsK3yDkE9ymjtbSmJADDfPlsB+LD6Bq7rwrFQo/NhcnDLrws2Flxhx/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgfVog+z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so9200752a12.0
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371933; x=1742976733; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6LER6Zc804dueOJWjEVUMSRCuA11MVDbrJsbbGQOIo=;
        b=KgfVog+zhJdMTABgi7bvaN9gAs80faxqFXO6MbMU+WOuf9Jhl0p52QikDaWx5kZP36
         gzauj4adcHflYTOFq3ywBy9bOZNi9vpjIPGKPA9FuMaW13QNXwDux8kFnkB/pawf2Cuk
         qM8gQmNmb9q1AMF4xH+2Z0HpUuVFx+68mi7UVKNKFmh+flcV3yzpxufkhAElz6Ncn2Q0
         J+xiWNjlr4zNDf8ZvnrsHRYPbIrCEa0LkrFbZIb5tIfVHl30lKlUieDnaAhLaoTnd6y6
         Hi5OAHnUNHwwEvV2GA32EbD0qKXKYG5HQeGccHW9SOLnt7E5XmdYfPnFPLiVBnLNRIIH
         Whqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371933; x=1742976733;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6LER6Zc804dueOJWjEVUMSRCuA11MVDbrJsbbGQOIo=;
        b=wKXuM2Azm91Wt1HuK6PALWGF3wK3YwTGfUiKK+pFtStSaAAoSe2pXnc0RpJ+2/BEzG
         hBFXgU8/ENd2L09V07pcifjT2P/MHnWp9I5ZJdwuTVxn1YiZ85Xdc3l4KkCoF1OCbB96
         9pAkF96VjQWlAN039xAt4FIDWByy7VDU7LJS0XXMvkqgquM2OCPINgQMa2rongZmPB5W
         7MO35H3yUXGyDJp8yUOy9Lfk6FXEidtnjhcMw56GA2Wlw9WsfsJF2rQo8DNIWMKRvt+0
         Kelhp4euN8D5ksI1ucWmpMXLl+BWRLGan1WGkvLPh7tXVKRINAwLxqiJfwJbgvYJMn6A
         r85g==
X-Forwarded-Encrypted: i=1; AJvYcCUE+iTzUZ9ddk7Awom5tkZZh4hZgdSCfXAVQR/P/3Ph3F4hiRUU9h+qiqeEgoDRQXUMKAaQ+70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAlK9/m8tXYazujtPTLM7OxaZWpeTjCMAWltOgjddTyhQAh70
	wqksVFtgg6YYKlJ6+hDpI5RF5/W2EMXZUxcA7h9izQAMvAtCUq2m
X-Gm-Gg: ASbGnctakv+He3+6T35YbTl/VhzJexap4PmkH8WjbQb3ClEoQr9G15snrznzpyxio83
	1HoXelKCZLX0oiDSL6WEvD00qazacmYZ1PN5KnJUynupJEeU36MRtux93idMoypsPSUEF0cut9o
	i6vdKtfQB2mtgwEuf42smmHO22Tj7wP6YfiWfm4aTNH+Ak0VO7lIHx6j6lJ9cdoUDH8XmwIBwpY
	rCGwIj8/rSvcTwskob8V/s1eQQtcSgfNbHnGPExhy1VoJXL48pCas0Jpf287lbc6/zM6eKLdEXB
	oW59+i2RkTGpxh9IeE1muTndOLZyVraIVFzn4td9ycry
X-Google-Smtp-Source: AGHT+IHSikBo+dlkg5EFijI5CqsmrJ6JKgVw15gwKTA5Eh0NXXD5K2kuGO7yBKzI5uC9/9Ch0lHiBQ==
X-Received: by 2002:a05:6402:40c6:b0:5dc:c531:e5c0 with SMTP id 4fb4d7f45d1cf-5eb80fa4388mr1757689a12.27.1742371932982;
        Wed, 19 Mar 2025 01:12:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81697509csm8721327a12.30.2025.03.19.01.12.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Mar 2025 01:12:12 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:12:11 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, rppt@kernel.org,
	akpm@linux-foundation.org, yajun.deng@linux.dev, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [Patch v2 2/3] mm/memblock: repeat setting reserved region nid
 if array is doubled
Message-ID: <20250319081211.c5ewa7ngdvuqasn6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250318071948.23854-1-richard.weiyang@gmail.com>
 <20250318071948.23854-3-richard.weiyang@gmail.com>
 <0bce0252-dd32-4cef-99f7-2222add43e2c@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bce0252-dd32-4cef-99f7-2222add43e2c@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Mar 18, 2025 at 04:25:23PM +0530, Anshuman Khandual wrote:
>On 3/18/25 12:49, Wei Yang wrote:
>> Commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()") introduce
>> a way to set nid to all reserved region.
>> 
>> But there is a corner case it will leave some region with invalid nid.
>> When memblock_set_node() doubles the array of memblock.reserved, it may
>> lead to a new reserved region before current position. The new region
>> will be left with an invalid node id.
>
>But is it really possible for the memblock array to double during
>memmap_init_reserved_pages() ? Just wondering - could you please
>give some example scenarios.
>

The possibility is low, but I think it is possible.

I have created a test case to reproduce it. Not sure it could explain ?


