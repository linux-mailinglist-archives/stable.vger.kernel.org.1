Return-Path: <stable+bounces-123125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E26EA5A475
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 21:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECA93A782B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4931DE3BA;
	Mon, 10 Mar 2025 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vyt92PPe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAB52AE66
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637540; cv=none; b=HGcn+QUc6LEL6Ohq9bOxsD4gPMjVCmrE/J8VKWKwZ15FQb8TqQ9y3YO8DMiehiUndKJNVxoAfXM5c35qQBv+U1gjsKmUDW6dGMsKu/Q/IKBh7Y9F0/4d3O+sy2x2NCp17l3kU/9CkEox7fzCO6gb9X5IX2RxnA5Q4p9r860MDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637540; c=relaxed/simple;
	bh=aT31OkYa28ZGJUgufGsDa18gtUSc47VEdx7Wy+FoF9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tbgm1jAj/SlsBjdn5UPSWRKBhId3ebQt8ZOHtdcY4lZPk72DP0BKoU23E4+HS72+7WiuL2zl0l9JexO/F/IHXxtHNCbn65btyK3auGRXXP9QKITk9mrtmyc+Px03zpZQw2Du2HU2oLQEOdgtbqFgA3zSdkj/Rxo/2UrFEsDWf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vyt92PPe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741637538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUMBZ32KdQqPLcAUPyQXRUOYVm+5mOZjgmd0uYlCLNg=;
	b=Vyt92PPekvgh6NbeHUF0p4GOsF2gl9KwRLr4RCMrL755U4BnDtZXulhZFiOpPTz7CcKjBI
	T0mtAeTsKEX8CDEEi559HLvOFQJcSI/noe/P7tHOE7qKz3AzHdoAfnoZAMDpdrmbhiCT8o
	s/gKYTq9lkVd2+y0srWMDmCNlRKSENQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-62oq3rohN0mOMKel6ukwig-1; Mon, 10 Mar 2025 16:12:16 -0400
X-MC-Unique: 62oq3rohN0mOMKel6ukwig-1
X-Mimecast-MFC-AGG-ID: 62oq3rohN0mOMKel6ukwig_1741637536
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2840b1ee8so183639366b.1
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 13:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637535; x=1742242335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUMBZ32KdQqPLcAUPyQXRUOYVm+5mOZjgmd0uYlCLNg=;
        b=CHCqagrnEELBcwhyYYkZ2brrIY1FFczJasSmeZ9l5llfThKe+aoUUAfEAMTXetw3MB
         z4BE/7aSn0FicFIdwS8VVSBo4NubeqxWBXD4/fFrqwkjCRYIpLyiaBS9AGTlc8V0JVP8
         DTyivuoOQeY6LVfLV+GGjgtB4uftExeViT0LOy94YCww5ofEBvdeeyOpvDi2LVyIgzJw
         i5C8dmNfdvGMzI80lXE0Oy9ZuDiCY9qnnSoJKyYCMRkRtabz++8AiAJrndQ5cx2LRChD
         xqfZIOHZCyaFUZTjnY0fvh+kw44y1Ju1jzEOcDjxAJZm+iNufiR+R9mMY/XMMh2Xl/v0
         WBLA==
X-Forwarded-Encrypted: i=1; AJvYcCXNv1ZDFD9gGr7KKPi8qspbQpWn79vMFUoEpqVv8/d9IqbfpZwYdjaYObfoYRAHuIGqlXEvjbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOyEeOE2XP1uzj5arGBWy+ludw3l4UyuNb4FcWSjUqRKnO9bvY
	4sVHpVfsomHOp+bsQYRxnMemAuO4zAxSx+th68sYRFyVGpOEPpfIggQwJyKTM0TT0PM0vgq7gMy
	rjQNuCGbhViW26BIPzRSp43fSMzxVF1wSzBqARKSEFh6CBBU3POp1vg==
X-Gm-Gg: ASbGnctapuKqkSRPqNHbGS+9vd3qRZKxt51J/5IRKYzbGhcO7VAyUgdXKO3nG7SvBa1
	1qtl2OOgga3Ms+r8Js4YSU74WQw3D6Jh5ViiC76T+5beYVf//t/G763iMJMdKViZWJ0dHhyFjWD
	FdUWtjQDewaSfaiL5n1mF2ct7CKe+gwia61zoXNCttJgrODY/nj1VoKYCVH79bnGG/xMFAu7bsX
	frKouAKulXpZxglYk3mJ1gtVMcU2012xrvWQaTPDQM5Bl1mla9NRUVFyROgNkt2LhhJAs1TIBXi
	fZD1omdbj9faRHFaaP4TqP2VpdLxPtMapqB6fL4MBrPq/GWocpv4ubu50V5mz/ITdtYq6C3xsl2
	8ttAPueCbrgDx7ZcqH+66kfuh7pJ81h4zmQTARDhuLIEn/MnI/wRw1zcJwQ8+AjG6Vw==
X-Received: by 2002:a17:906:6a29:b0:abf:40ac:4395 with SMTP id a640c23a62f3a-ac252bb26b7mr1959103966b.31.1741637535515;
        Mon, 10 Mar 2025 13:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj3e3Mpx+zqBeN7/u1TmdQVFF3PHupm3Ka2E7nCKCXHNoHeAEGzCJB1T6ZzVuiOMh2f7bfEQ==
X-Received: by 2002:a17:906:6a29:b0:abf:40ac:4395 with SMTP id a640c23a62f3a-ac252bb26b7mr1959099966b.31.1741637535022;
        Mon, 10 Mar 2025 13:12:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25af3cea9sm630700966b.111.2025.03.10.13.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 13:12:14 -0700 (PDT)
Message-ID: <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
Date: Mon, 10 Mar 2025 21:12:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>
Cc: Eric <eric.4.debian@grabatoulnz.fr>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan> <Z8SyVnXZ4IPZtgGN@ryzen>
 <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen> <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen> <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z88rtGH39C-S8phk@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 10-Mar-25 7:13 PM, Niklas Cassel wrote:
> Hello Hans,
> 
> On Mon, Mar 10, 2025 at 10:34:13AM +0100, Hans de Goede wrote:
>>
>> I think that the port-mask register is only read-only from an OS pov,
>> the BIOS/UEFI/firmware can likely set it to e.g. exclude ports which are
>> not enabled on the motherboard (e.g. an M2 slot which can do both pci-e + 
>> ata and is used in pci-e mode, so the sata port on that slot should be
>> ignored).
>>
>> What we seem to be hitting here is a bug where the UEFI can not detect
>> the SATA SSD after reboot if it ALPM was used by the OS before reboot and
>> the UEFI's SATA driver responds to the not detecting by clearing the bit
>> in the port-mask register.
>>
>> The UEFI not detecting the disk after reboot when ALPM was in use also
>> matches with not being able to boot from the disk after reboot.
> 
> If we look at dmesg:
> ahci 0000:00:11.0: AHCI vers 0001.0200, 32 command slots, 6 Gbps, SATA mode
> ahci 0000:00:11.0: 3/3 ports implemented (port mask 0x38)
> ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
> 
> We can see that the controller supports slumber, partial,
> and aggressive link power management ("pm").
> 
> 
> A COMRESET is supposed to take the device out of partial or slumber.
> 
> Now, we do not know if the BIOS code sends a COMRESET, but it definitely
> should.
> 
> Anyway, it is stated in AHCI 1.3.1 "10.1 Software Initialization of HBA",
> 
> "To aid system software during runtime, the BIOS shall ensure that the
> following registers are initialized to values that are reflective of the
> capabilities supported by the platform."
> 
> "-PI (ports implemented)"
> 
> 
>>
>> I think what would be worth a try would be to disable ALPM on reboot
>> from a driver shutdown hook. IIRC the ALPM level can be changed at runtime
>> from a sysfs file, so we should be able to do the same at shutdown ?
>>
>> Its been a while since I last touched the AHCI code, so I hope someone else
>> can write a proof of concept patch with the shutdown handler disabling ALPM
>> on reboot ?
> 
> I mean, that would be a quirk, and if such a quirk is created, it should
> only be applied for buggy BIOS versions.
> 
> (Since BIOS is supposed to initialize the PI register properly.)
> 
> If
> ahci.mobile_lpm_policy=1
> or
> ahci.mobile_lpm_policy=2
> works around your buggy BIOS, then I suggest you keep that
> until your BIOS vendor manages to release a new BIOS version.

I agree with you that this is a BIOS bug of the motherboard in question
and/or a bad interaction between the ATI SATA controller and Samsung SSD
870* models. Note that given the age of the motherboard there are likely
not going to be any BIOS updates fixing this though.

Certainly ahci.mobile_lpm_policy=x can be used to workaround this, but
going by my experience from being involved in resolving:
https://bugzilla.kernel.org/show_bug.cgi?id=201693
which took a long time to resolve and has many comments (1).

I'm afraid that we are going to see more users hit this. This seems
to be another case of samsung sata SSDs and ATI SATA chipsets not
liking each other but this time the problem is triggered by LPM rather
then by NCQ and we likely did not hit this the last time we were
seeing a lot of users reporting issues on this combo because so far
LPM has defaulted to off in these cases.

Note that in commit 7a8526a5cd51 which fixes the bug linked above,
we already disable all NCQ use for "Samsung SSD 870*" models when
used together with SATA controllers with a PCI vendor-id of ATI
because of various severe issues when it is enabled.

I strongly believe that to avoid further regressions from commit
7627a0edef54 ("ata: ahci: Drop low power policy board type") on
ATI SATA controller + Samsung SSD combinations we should probably
extend the special handling of ATI SATA chipsets to also disable LPM.

IOW add a new ATA_QUIRK_NO_LPM_ON_ATI flag which mirrors how
the current ATA_QUIRK_NO_NCQ_ON_ATI works but then for LPM
and set that for "Samsung SSD 870*".

I can prepare a patch for this if that sounds like an acceptable
solution to you.

Regards,

Hans


1) I don't know if you know, but I'm the author of the initial addition
of the "low power policy board type" list, because back then we
needed ALPM to reach high PC-states (e.g. PC10) on Broadwell and newer
Intel SoCs, while at the same time there were reports that ALPM was
causing. I also added quite a few of the initial NOLPM __ata_dev_quirks[]
entries.





