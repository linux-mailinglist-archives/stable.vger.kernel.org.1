Return-Path: <stable+bounces-76951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8364983C22
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 06:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C6D1C21837
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 04:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A22941B;
	Tue, 24 Sep 2024 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1SKWmFw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B45199B9;
	Tue, 24 Sep 2024 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727153409; cv=none; b=ll+byymQPew2UI9jaRCPFP52A2faFre4OqNb/v5hH29NEMw7wE/ujQU83Zf+XJR+Ubr5+7k1oM+uOMZvQsGJCKgdyrKHzJjQ7UTvMoJ6OjA6vrL1awMbHKC3VyTXmt1hbWWu36Y5xd5igctaQ1HH/3HKGkI2YQgSQhBOVo7p37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727153409; c=relaxed/simple;
	bh=DcTngQDtm8rPXKhB60uE0gMkwkb4YNyvUCNbGJ13rFg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=kjWUV80f8AdWLEFIkeohraKcOkJRReLEfEGPlWpZkgajENl2icSNV/0orXXpSkwWEfkkHtEW6Lu5sPgA/sQu6irCgPDlQM0Y75REa/PkeZp9e6zHWZYBAi2goZ7RqqJomuUSGgZp2Xu8RCW17i9F9FBdu0p52vz9HKV+opGLWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1SKWmFw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71798a15ce5so4244397b3a.0;
        Mon, 23 Sep 2024 21:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727153407; x=1727758207; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d74Ho1WHawE+5XcSs6MQhq9EWssysWWKSXZfRcAZZ94=;
        b=I1SKWmFwlfSddDVrJZLTYaXSx48l3mxVsGuNg46ptrXQ2WnkuklrpicVVlQii57Z4i
         HZC3VzoIIqyekvfRGnQlbOt0AekQ6sFkhzy2TufhtILq1xd/B03aaSY9uDlD60ydLroe
         h5Q+HoTa93538AG1F+5HpL9VkfXXaG/9Q4TKai083bFrr6cGsJojRwjgJot+OCa75jBT
         Wv8l5o6/BacLE0Hc6+mDOlnwB9tUWdcsrHBpJA52lW4KMhjAr3P85WLRQob5E3fziZVN
         pBB37fkFOuohp99h37dc6XA+csX4D+7Pofrkd0vyCqFlPzfJ247RJLBQI2NrbIfw9Ngu
         gHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727153407; x=1727758207;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d74Ho1WHawE+5XcSs6MQhq9EWssysWWKSXZfRcAZZ94=;
        b=FQ/BwoMuoIu5VgbayhvLH8Mfwfwq0tj5i9S3HQXdetv6vz2tazgrHcrtTtG0ZcePPD
         whXZ6kRz+vFshxK06+ikULXwp28vuW0kLnpwC+36YvlOwhpi+n6olaJWwNcKaGX8aJB3
         WEESDx+t9C19wqVX7MqJkzzb1yneLGtGdohD/p2SkZeNokQUHki/lYbdK+TKECpHAL8y
         a6Ytpk8Qm1zR4NFAjQSc8M732YEGNX2+heY2bw2lOwdq1s4p+qHWjyH1QnJ/mhsc6ul2
         wSwTnIpqTsQ7AMixRKb3TaOsCbHBcpUlGb4yo0dByprqnIEjBrnIQp/ELlySvqjrkuzX
         61XQ==
X-Forwarded-Encrypted: i=1; AJvYcCU395R7ydnRIuC5E1epfGFAlqK7M97V9RUn3PWj1y3nRPel74MJsLNGPDO087ofZUb7+QLPDn0R@vger.kernel.org, AJvYcCUnET1SX8t5IkNn83uIA737jOZ+i83aL/joD264KfZ9EsHFTNL1lt9V3s1tmuisMpfprTIgBtdSQIpDSgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxs6adiuN9JwHpZ++An9INFnB1BekM8f6tMl1UOBmDI1ZNOTia
	de4zRXFV8rr8r7dSBn/XE5BTnI2fBpRRy0BajwpwIqjFEHHADuBzPzZ9bPSr
X-Google-Smtp-Source: AGHT+IGxnjLeasV01GQR3c/k7jfMr6OFFpgVkxR0DbPq5BAGkfddsJeKaE8mJODv29DHO7DVMj2UaQ==
X-Received: by 2002:a05:6a20:5520:b0:1cf:49a6:992a with SMTP id adf61e73a8af0-1d343cbab3cmr3086297637.21.1727153406852;
        Mon, 23 Sep 2024 21:50:06 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a02a:7af0:89b:3903:a61c:1a89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c7a8bsm399220b3a.201.2024.09.23.21.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 21:50:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: migrate: fix data-race in migrate_folio_unmap()
Date: Tue, 24 Sep 2024 13:49:54 +0900
Message-Id: <BE930CC0-7F11-44AE-BCFB-C18A292140FB@gmail.com>
References: <ZvIjRZgyAGLmys7c@casper.infradead.org>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot <syzkaller@googlegroups.com>
In-Reply-To: <ZvIjRZgyAGLmys7c@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: iPhone Mail (21G93)



> Matthew Wilcox <willy@infradead.org> wrote:
>=20
> =EF=BB=BFOn Tue, Sep 24, 2024 at 09:28:44AM +0900, Jeongjun Park wrote:
>>> Matthew Wilcox <willy@infradead.org> wrote:
>>>=20
>>> =EF=BB=BFOn Mon, Sep 23, 2024 at 05:56:40PM +0200, David Hildenbrand wro=
te:
>>>>>> On 22.09.24 17:17, Jeongjun Park wrote:
>>>>>> I found a report from syzbot [1]
>>>>>>=20
>>>>>> When __folio_test_movable() is called in migrate_folio_unmap() to rea=
d
>>>>>> folio->mapping, a data race occurs because the folio is read without
>>>>>> protecting it with folio_lock.
>>>>>>=20
>>>>>> This can cause unintended behavior because folio->mapping is initiali=
zed
>>>>>> to a NULL value. Therefore, I think it is appropriate to call
>>>>>> __folio_test_movable() under the protection of folio_lock to prevent
>>>>>> data-race.
>>>>>=20
>>>>> We hold a folio reference, would we really see PAGE_MAPPING_MOVABLE fl=
ip?
>>>>> Hmm
>>>=20
>>> No; this shows a page cache folio getting truncated.  It's fine; really
>>> a false alarm from the tool.  I don't think the proposed patch
>>> introduces any problems, but it's all a bit meh.
>>>=20
>>=20
>> Well, I still don't understand why it's okay to read folio->mapping
>> without folio_lock .
>=20
> Because it can't be changed in a way which changes the value of
> __folio_test_movable().  We have a refcount on the folio at this point,
> so it can't be freed.  And __folio_set_movable() happens at allocation.
>=20

Thanks for the explanation. Then it seems appropriate to annotate=20
data-race in __folio_test_movable() so that KCSAN ignores it.

I will apply the change and send you a new patch.

Regards,
Jeongjun Park=

