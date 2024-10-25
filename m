Return-Path: <stable+bounces-88147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F259B0201
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 14:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F9283BEF
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D042201026;
	Fri, 25 Oct 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9siP94U"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29861FF7B9
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858691; cv=none; b=iXQ4MHOxUeeG4w2FziSHH5EYsPGthYKwYh7X2dAnjWtw4gBG1a6VXmUDQ7VZdkEFzZuqDLLP/ONbyFgoB8wLBWYw3eLxVY7FT5uZhI6QYru1WeMK2OOUolDuMsUglKHfilnTwjDumLBjKOgdz8WAfKq+mQoTQ80zCHe01mLDe20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858691; c=relaxed/simple;
	bh=uslR7BRL60cTwk//jOlbNVg8EbFbaCQXQ5EFpkeNjfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PA3ACvKGsJpEGFSWw9XYm/tT3mHSLeiC/3E/1ZNPfgBmRCoSJC1uf3JTL1bZ+OF7gQCiFOymH6EVOyUR+vkTRKRQdToAltNHaIrtcL42Op2a0pS/U/OJaHbZAzZUCrlYo34wp5Y69Lfha35UUxqOnI9UiD/Glvl2GNZ+HI51ul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9siP94U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729858689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rwfDoTPSMRtfXHmINVRgiQrkEDJjKEQXCOsodjYaCQ=;
	b=M9siP94U6+HxFQA/W2Slaun5C68QuIwefAvuPlkcXYljjIFJ1vLllbGKMTH6Ohqe4w7/Hb
	wK4dljMx3Cq0ul7nwJKYjfk9jJyYOA8lU1iNaQcwC7OMya05BmnEKJ+mSJM8KG7xbrRM5w
	QuEtEWYfHwWOXHSYpZdbM+ssa01RDPg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-OxqSoITMOF-cyJJudtIpSA-1; Fri, 25 Oct 2024 08:18:07 -0400
X-MC-Unique: OxqSoITMOF-cyJJudtIpSA-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e28fc8902e6so3688066276.0
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 05:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729858687; x=1730463487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rwfDoTPSMRtfXHmINVRgiQrkEDJjKEQXCOsodjYaCQ=;
        b=GELJD8aNwQQ6ASsNM8tPRnSFOMahtuFZC55By8Eq+XLeu4n8NjxvqgvY7SnEkg5ur2
         mxgiPHUyWGkI1H2SLzpLC/rqOPzUHSowQBLa15RvJ5Kasp5CfLW93TuPPyvF1xk+UQWU
         jvo1ffkjoAmXKzBk5bWWWtVFgIzoh9Y/t764CScKq7T5JMG/tsznHfgg+NHSSI4d03f5
         wF8jByb0+Zr04gYEjTIphBemj7gylMQbhPr1VDrrAS+CAFby2ucBkIUognXN9NrKe7HE
         iz1RKtZDP0meNAWEyqvasMa43hdOgna1DviUH5Gq5qyO+nIVeztP85P/w1o59hA1nKvk
         GPyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFh5oX7IPru9HpE+bRdYd9Ha5vcJ5NX1wFvIJGTCSVxHB4ab1pBJb8ypg044vYID6RwciX2Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qObGTzPQObTGUawkq2vcaQISKeDwGJ+1K1ap29Fi3MLMikiw
	vRvi1bqhRrjrADkGqF0zubV0V0Mf+BWUQJjQIaXiLsseGcexwFToGt66CDNkPMRnCazyxJ7RjgJ
	pFXMp0JMOCGmzIM7oFRUNyIjgdEpIKgcGzyM9pQQUPJrzITBlkTDdrA==
X-Received: by 2002:a05:6902:2505:b0:e29:6692:d84 with SMTP id 3f1490d57ef6-e2f2fbc0f20mr5328321276.36.1729858687236;
        Fri, 25 Oct 2024 05:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1rUBoEoKRi1UMAQxws2WSnv93vUPbVshx6vDErv0r8+kymJM8JDcqvagwSTJs1tTUrJWTGA==
X-Received: by 2002:a05:6902:2505:b0:e29:6692:d84 with SMTP id 3f1490d57ef6-e2f2fbc0f20mr5328299276.36.1729858686859;
        Fri, 25 Oct 2024 05:18:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323abd6csm5321731cf.94.2024.10.25.05.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 05:18:05 -0700 (PDT)
Message-ID: <92d755af-e19b-49a5-b4df-a8ed0fb7aece@redhat.com>
Date: Fri, 25 Oct 2024 14:18:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: Don't eagerly teardown the vgic on init error
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, stable@vger.kernel.org,
 Alexander Potapenko <glider@google.com>
References: <20241009183603.3221824-1-maz@kernel.org>
 <3f0918bf-0265-4714-9660-89b75da49859@sirena.org.uk>
 <86ldyd2x7t.wl-maz@kernel.org>
 <eb6e7e29-b0a8-47b1-94c4-f01569aa55cb@sirena.org.uk>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <eb6e7e29-b0a8-47b1-94c4-f01569aa55cb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark, Marc,

On 10/25/24 12:54, Mark Brown wrote:
> On Thu, Oct 24, 2024 at 07:05:10PM +0100, Marc Zyngier wrote:
>> Mark Brown <broonie@kernel.org> wrote:
> 
>>> # ==== Test Assertion Failure ====
>>> #   lib/kvm_util.c:724: false
>>> #   pid=1947 tid=1947 errno=5 - Input/output error
>>> #      1	0x0000000000404edb: __vm_mem_region_delete at kvm_util.c:724 (discriminator 5)
>>> #      2	0x0000000000405d0b: kvm_vm_free at kvm_util.c:762 (discriminator 12)
>>> #      3	0x0000000000402d5f: vm_gic_destroy at vgic_init.c:101
>>> #      4	 (inlined by) test_vcpus_then_vgic at vgic_init.c:368
>>> #      5	 (inlined by) run_tests at vgic_init.c:720
>>> #      6	0x0000000000401a6f: main at vgic_init.c:748
>>> #      7	0x0000ffffa7b37543: ?? ??:0
>>> #      8	0x0000ffffa7b37617: ?? ??:0
>>> #      9	0x0000000000401b6f: _start at ??:?
>>> #   KVM killed/bugged the VM, check the kernel log for clues
>>> not ok 10 selftests: kvm: vgic_init # exit=254
> 
>>> which does rather look like a test bug rather than a problem in the
>>> change itself.
> 
>> Well, the test tries to do braindead things, and then the test
>> infrastructure seems surprised that KVM tells it to bugger off...
> 
>> I can paper over it with this (see below), but frankly, someone who
>> actually cares about this crap should take a look (and ownership).
As I am the original contributor of the crap I can definitively have a
look at it and take ownership. Those tests were originally written
because the init sequence was different between kvmtool and qemu and we
had regular regressions when touching the init sequence at some point.
Now this may be not valid anymore ...
> 
> I'm not even sure that's a terrible fix, looking at the changelog I get
> the impression the test is deliberately looking to do problematic things
> with the goal of making sure that the kernel handles them appropriately.
> That's not interacting well with the KVM selftest framework's general
> assert early assert often approach but it's a reasonable thing to want
Can you elaborate on the "assert early assert often approach". What
shall this test rather do according to you?

I am OoO next week but I can have a look afterwards. On which machine is
it failing?

Thanks

Eric


> to test so relaxing the asserts like this is one way of squaring the
> circile.


