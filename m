Return-Path: <stable+bounces-88151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D839B0358
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 15:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C214E1F21527
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08D70812;
	Fri, 25 Oct 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSBKpYGI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2172C70803
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861523; cv=none; b=PVim0nPgSQXY/n1/aNA5zwi9OavW6f42NG4Lt+O1JSw+86XarO/RROQBVaP+3RYVv8b1SzD9+/QaObl/YDcEx8MpelZKdGZu6eFNAVpYsZ7hOUDHlkMoyhhVE3GnGlSf8Gav9vS8/bL3VhHa4KbWSru+SeiSXuSO1SOWUlNnyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861523; c=relaxed/simple;
	bh=UCLSDO/jm1mAVqY7mkCIBEwU4gXpjBMrnFbP+zDQ02c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwS7wFZZLcIrY5gJsVLxhanAv2BLc+WcGt58+OrISpYf4fd5MdpWM9tQUtAT7leiaMgQGtGH93QQNsVyZMjTrJ8aJ18Wz/1Oix3xZsuALBqvTXTIDNpeyjgyHpVGTXg5/+ajOAlvPJQ9nkT7G4o+hDWktFWAw/OdKPJqpaPiQ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSBKpYGI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729861519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NN2SUD+OUfJKgPj+21gkXoKJrVd7DZ/UXCkZWnA0qJs=;
	b=aSBKpYGIKK7D+KGs3+iXX15qBEbA5LceCf5I6B92iBQHVqNikzIxSSFLDfK+6Gtfm7/1qh
	Xau9Njf4xVxDoK11WT5lKnQwOaNC5bZpkpOn8ySdbcOKgUvF4s382kPS8gq2YsiFyam4mr
	+j1XP45XVwyEJmyeCnySLFaHuD4Ia7c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-r8ggeuRDMD6pCrMeV7rwqg-1; Fri, 25 Oct 2024 09:05:18 -0400
X-MC-Unique: r8ggeuRDMD6pCrMeV7rwqg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4d51b4efso964732f8f.3
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 06:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729861517; x=1730466317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NN2SUD+OUfJKgPj+21gkXoKJrVd7DZ/UXCkZWnA0qJs=;
        b=gcdUoPzWlz09Vhm+/ysMGIIk/yb+cjQBR4R1jdwF+qZqOa8ZI0dZ4iMPjDnHjWttM6
         vCKXgiNRhtHnDl7oEhnKqCqmVlviEHciU6jxCv/qqeF9wxZ39YFvOyixMbW/jOtTjPk0
         XcJM2jmL9FJ4ZHf6YA38uiynS7l+4Y+nZdWb29maOJlSuEyrqbpAJzIZMhvHzWJWNg8b
         11Fm/HL/sSepii2vGIO+87zvCMT2Rc9/rnEOGKIweEjBBIle29xmst+SGakK39CUz/+r
         xo8b9jtIGkBi8OmBXnIhr8xxXOxtU0olxZO7eI/04JySZh+/tWmbWWqAos6I63F8/fQR
         kGdw==
X-Forwarded-Encrypted: i=1; AJvYcCUXIyxoaKMohwQcssLYVwNLQzyQ35hXKYkuR6/BW/DQOKf418bni7Xw/ue0jXEapf3MoJL0LDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGZyjHRRJCOtLgj9zk/JNEDGgcFq1Xrc3ji54w+DFVbyMy3uk
	8Lh458Gs+Zk8p1oWZ4leOlJuo7axRhQwtRjgd4AFZhEpLOreGbTQTtOi7h/sp48pMH0dJASvnr0
	dt5oNfiYyp6oiB2qFPvPlMnILUMXNSM1NhQFcYYiPf4zBBY0hRxa2ag==
X-Received: by 2002:a5d:6189:0:b0:37d:39c1:4d3 with SMTP id ffacd0b85a97d-3803ac84451mr3932500f8f.6.1729861516624;
        Fri, 25 Oct 2024 06:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHZX9EQgHC8n+5rGdSPJEtECAS97R5nQ80Ja/EQnqyzVVLXnGbDJE3YBe+VRN9JY0lWOP/Cw==
X-Received: by 2002:a5d:6189:0:b0:37d:39c1:4d3 with SMTP id ffacd0b85a97d-3803ac84451mr3932455f8f.6.1729861516074;
        Fri, 25 Oct 2024 06:05:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1459852f8f.100.2024.10.25.06.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 06:05:15 -0700 (PDT)
Message-ID: <7c1a7b1c-6fbf-4bd9-80d0-d2c3d951e342@redhat.com>
Date: Fri, 25 Oct 2024 15:05:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: Don't eagerly teardown the vgic on init error
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, stable@vger.kernel.org,
 Alexander Potapenko <glider@google.com>
References: <20241009183603.3221824-1-maz@kernel.org>
 <3f0918bf-0265-4714-9660-89b75da49859@sirena.org.uk>
 <86ldyd2x7t.wl-maz@kernel.org>
 <eb6e7e29-b0a8-47b1-94c4-f01569aa55cb@sirena.org.uk>
 <92d755af-e19b-49a5-b4df-a8ed0fb7aece@redhat.com>
 <ZxuWIXFJignbcX1m@finisterre.sirena.org.uk>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <ZxuWIXFJignbcX1m@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 10/25/24 14:59, Mark Brown wrote:
> On Fri, Oct 25, 2024 at 02:18:02PM +0200, Eric Auger wrote:
>> On 10/25/24 12:54, Mark Brown wrote:
> 
>>> I'm not even sure that's a terrible fix, looking at the changelog I get
>>> the impression the test is deliberately looking to do problematic things
>>> with the goal of making sure that the kernel handles them appropriately.
>>> That's not interacting well with the KVM selftest framework's general
>>> assert early assert often approach but it's a reasonable thing to want
> 
>> Can you elaborate on the "assert early assert often approach". What
>> shall this test rather do according to you?
> 
> In general the KVM selftests are filled with asserts which just
> immediately cause the test to exit with a backtrace.  That's certainly
> an approach that can be taken with testsuites, but it does make things
> very fagile.  This means that if the test is deliberately doing
> something which is liable to cause errors and put the VM in a bad state
> then it seems relatively likely that some part of a partial cleanup will
> run into a spurious error caused by the earlier testing putting the VM
> in an error state.
OK I better understand now. Thank you for the clarification.
> 
>> I am OoO next week but I can have a look afterwards. On which machine is
>> it failing?
> 
> It was failing on a wide range of arm64 machines, I think every one I
> test (which would track with the change being very generic).

Yes I can reproduce on my end.

Thanks

Eric


