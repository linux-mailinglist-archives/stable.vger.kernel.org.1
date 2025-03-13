Return-Path: <stable+bounces-124324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A4AA5F951
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A7D176AF6
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020B1268C58;
	Thu, 13 Mar 2025 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGafcREk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE93126C1E
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878813; cv=none; b=MRFLmQBqLKG0M19/Sp7wP5NNj1PxVqsS0p41f3Beu9NUEdXuhK1rgWSsg37xcd5BR7Fa1vtdgL+ubVcuH2plL2nsQ55kJejrb76TDC6RoavCYJbidE9xnD/PbHW/RZ8PaIYpxvofihWWF++3K6fhO1ofT1jyEVSKjrxGvlX4zrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878813; c=relaxed/simple;
	bh=F6KcbIPUgfP6kX1LbBxUFczoKtPUcvCPuPG03lq65CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qM4s/UYnmDOfuAwHcbDWT6WXFL5T7tQNka/hQc9hX0De2inTkHCtaN0p6+CbCUDw5csVAyEzAWe0DRzSQfPJUD4Viyav5ECN5g8U02h/dT5fSVYmaIWwKeNYOPOEfXQtmAmJ3sk8GQfpv629ix8GmF9ZngWGNe7csytqMj0qoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGafcREk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741878810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5K4pCCizVTVFaCfJxsbcvtellHTlJx5Au+uaHTpI0k=;
	b=WGafcREkL7Fqyn8lD35rX+99u2SLrOgCM1PAPet6w9qA742qoHPXVQ2k6zQhA0vqlyoCTV
	MnBeypta8xQS8KOZkWXTu0WMCXvYZHyDVg8L5G5cmQwLu98qwXM59POPbzZDhd1bJ+XgeT
	qreIN6nS84y+2wiUa9MYcRk7xzT8avI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-IZ904OcgPbKl6PRCIVX4cw-1; Thu, 13 Mar 2025 11:13:28 -0400
X-MC-Unique: IZ904OcgPbKl6PRCIVX4cw-1
X-Mimecast-MFC-AGG-ID: IZ904OcgPbKl6PRCIVX4cw_1741878807
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab76aa0e72bso93996966b.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 08:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741878807; x=1742483607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5K4pCCizVTVFaCfJxsbcvtellHTlJx5Au+uaHTpI0k=;
        b=BU8C6VljnQhHaX1Rx/ztEUeysKqXtkXoURKCkRuD0GVbDqQsw2Hx8MHkO0NoFmlbW2
         ICzgInavaHF4YVsYrGBNHaqaW5Ipd9pwL4+cy7BVflePrxNpTDL0RGoKgTrLKOxeUFR2
         KOdCshytrFWU4waXzE36OQ9hLmWSbp+LV5/wyG3YnWrWErSrYZOppmGzlt21wIzJ9kmm
         56ud4NadYPjWrsetO4A5FDfO/Up3d88sq1fmfjTETfL0hCMs1bGK6BoREUk9SQ0UOC7W
         oFC8G8V71GP5UuO5r1iALhplyHGzHu4DuWYOaqbzHlhLlrzHRHyRNyoVmOGxqDun8KD9
         GVHg==
X-Forwarded-Encrypted: i=1; AJvYcCV/3xIYt/q9VIxdcDoNAz/uRNZ4hjDqhT+LBCfE+wKXjz/H5mfZyb7J4VtsFEf4I1FbL4qGo5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxq7WpJ+dcU/w2cj5vVC2pQF2up/5LNhiZOal+J58OrVGf/1Rn
	Nu3szChePXnFprWeWDis2ZeIfWSGVL1NjjLGdyP4aJG++0c8prnD7qEFJH+AaN99DeUu1mT3cit
	h9IecqpsfztcKmiSopYERLdkUp6CzBZtGrv14VcSk8s9jppO0e/BX/g==
X-Gm-Gg: ASbGncs+5YTsE5ey/Vb/87NmPQ4XpLDUMIPK3C2s6vxTzq6dHAfYlXIQLoKVg6wBQJs
	Ur4Z3RLbPnjfuJTUuf3as72hJQcASTk7/oHiyJw49zdVMVbtTe84PlIIi16g4rDcmflGebcAX3Y
	o93bsrO5mQsmLifmR7WoSIScbrmIp8/76OzV8otzJoQbiRPCn76U6lcZvVieHbclh9CCPZHdQ6O
	j6/eT0jbvcFaeVAfCQRbGl8QYrIvCskSNHILQOF7vNrUyG6pNnoZK9jijzVHhPv1owjnfMYzvp/
	sAoLLK3GKFi8Nbo+BBVz6krqzzMZ9hZb75KC983nqKFUm0qfzLxbDDD4R/eahWCqqE/YWjcZZSl
	7MDpS1mog1MYbDQOrKsa2F0OQB4bQuTv1zRX6StdH0+67qGgNGJCbI4Jgdj4+HPM0ow==
X-Received: by 2002:a17:906:c381:b0:ac2:ff66:dd68 with SMTP id a640c23a62f3a-ac2ff66e08dmr593616766b.39.1741878806667;
        Thu, 13 Mar 2025 08:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIfef2yMH96c0YIEDZ4YUlcCBGhBwi8aFPWDDZ+VDysqpAUegkeCUPWy1GYkWLR9SUagK39A==
X-Received: by 2002:a17:906:c381:b0:ac2:ff66:dd68 with SMTP id a640c23a62f3a-ac2ff66e08dmr593612466b.39.1741878806264;
        Thu, 13 Mar 2025 08:13:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a40f61sm90305766b.134.2025.03.13.08.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 08:13:25 -0700 (PDT)
Message-ID: <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com>
Date: Thu, 13 Mar 2025 16:13:24 +0100
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
References: <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen> <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen> <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen> <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen> <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
 <Z9LUH2IkwoMElSDg@ryzen>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z9LUH2IkwoMElSDg@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Niklas,

On 13-Mar-25 1:48 PM, Niklas Cassel wrote:
> Hello Hans,
> 
> On Thu, Mar 13, 2025 at 11:04:13AM +0100, Hans de Goede wrote:
>>
>> I do agree with you that it is a question if this is another bad
>> interaction with Samsung SATA SSDs, or if it is a general ATI SATA
>> controller problem, but see below.
> 
> (snip)
> 
>> Right in the mean time Eric has reported back that the above patch fixes
>> this. Thank you for testing this Eric,
>>
>> One reason why ATA_QUIRK_NO_NCQ_ON_ATI was introduced is because
>> disabling NCQ has severe performance impacts for SSDs, so we did not want
>> to do this for all ATI controllers; or for all Samsung drives. Given that
>> until the recent LPM default change we did not use DIPM on ATI chipsets
>> the above fix IMHO is a good fix, which even keeps the rest of the LPM
>> power-savings.
> 
> One slightly interesting thing was that neither the Maxtor or the Samsung
> drive reported support for Host-Initiated Power Management (HIPM).
> 
> Both drives supported Device-Initiated Power Management (DIPM), and we
> could see that DIPM was enabled on both drives.
> 
> We already know that LPM works on the Samsung drive with an Intel AHCI
> controller. (But since the device does not report support for HIPM, even
> on Intel, only DIPM will be used/enabled.)
> 
> 
>>
>> Right I think it is safe to assume that this is not a Samsung drive problem
>> it is an ATI controller problem. The only question is if this only impacts
>> ATI <-> Samsung SSD combinations or if it is a general issue with ATI
>> controllers. But given the combination of DIPM not having been enabled
>> on these controllers by default anyways, combined with the age of these
>> motherboards (*) I believe that the above patch is a good compromise to
>> fix the regression without needing to wait for more data.
>>
>> Regards,
>>
>> Hans
>>
>> *) And there thus being less users making getting more data hard. And
>> alo meaning not having DIPM will impact only the relatively few remaining
>> users
> 
> I'm still not 100% sure with the best way forward.
> 
> The ATI SATA controller reports that it supports ALPM (i.e. also HIPM).
> It also reports support for slumber and partial, which means that it must
> support both host initiated and device initiated requests to these states.
> (See AHCI spec 3.1.1 - Offset 00h: CAP – HBA Capabilities,
> CAP.PSC and CAP.SSC fields.)
> 
> Considering that DIPM seems to work fine on the Maxtor drive, I guess your
> initial suggestion of a Samsung only quirk which only disables LPM on ATI
> is the best way?

I have no objections against going that route, except that I guess this
should then be something like ATA_QUIRK_NO_DIPM_ON_ATI to not loose the
other LPM modes / savings? AFAIK/IIRC there still is quite some powersaving
to be had without DIPM.

> It seems that ATI and Samsung must have interpreted some spec differently
> from each other, otherwise, I don't understand why this combination
> specificially seems to be so extremely bad, ATI + anything other than
> Samsung, or Samsung + anything other than ATI seems to work.

Yes the most severe problems do seem to come from that specific mix,
although the long list of other ATI controller quirks also shows those
controllers are somewhat finicky.

Regards,

Hans



