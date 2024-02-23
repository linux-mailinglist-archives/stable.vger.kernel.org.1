Return-Path: <stable+bounces-23478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74467861323
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 14:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7F0B25AC1
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B4280C19;
	Fri, 23 Feb 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZumiBEK0"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891AF7C6E5
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695928; cv=none; b=hqZ1uvI26N7oK1oPzvyLLPz/38N1nXNNQ0hSFwmplSBmZnqIQV4VIMSkjpRAKx474AyJHqY2L9jUwlyHaLzXkg97tacsdzilO621q88TuP64C/PVIKKSi77YfDgVV4LUM9/ARjbQmej46MY7pZLPetqPKt2xI3eS93q+qfd2SBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695928; c=relaxed/simple;
	bh=VwWbvrsIEDuvuEUlBQteX/TwEU3Y02TLmJEjKr8BITQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgWxEFQRmf3KlEwBh/NWgp0OAMnvSDoDo9fDrgUnBhp4SRckuULySH88/pEkhT5Yc1OJDNMVIQGyOXxDpyCZAkTvfy6EtD0I1cQlJobfaJ/KBa6GZ2T+Lh9Fd6UY43UNnZZZAODThuAsnmPPS/jwrm9mfsXX7IOTm7kLNTJvSgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZumiBEK0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 57F3A3FA63
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708695917;
	bh=YPnH3YV5jUJXwIOBYV+ShdRJE9TuisdyWDlJvI8D18M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ZumiBEK098y5SFYnxv+3zfjxLlrWPxhrexT+YMISMUwllprJz25uvHC7DVyL5F3SW
	 Fjzr39f46GceC9LDCf40tCayThaC3pfTbA6NAO03Yam7zyJq6mZ9AWeqWLYV1p/nEp
	 Zq2iu6XmV7b9gQaRkA+Qo/3OgQ96+ix9YYwty2GbiS8Fz2Rb8/uOcuOhPOTchIkSy2
	 S+lPfOC/t4KlgcSLXSZi03CoQZ0kphMUpCTV9hq8cUzFDqSgT9VVbXojg8WlBPLfg9
	 cdUdtaeNW6E78C+zafF8V1v6uGNM/vuafeocD8RGSvGjG0Ps8h4M9y2jb1oqn4tZIF
	 5lJPcbScrplGQ==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5dc91de351fso681291a12.0
        for <stable@vger.kernel.org>; Fri, 23 Feb 2024 05:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695915; x=1709300715;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPnH3YV5jUJXwIOBYV+ShdRJE9TuisdyWDlJvI8D18M=;
        b=WFAQa4+8WNAsLhLVsNv2H+J+UJhIN3LXgJGhQ+xWHRyECeE9pPyj8SgxJaulPJFhgx
         6es9i9gbza6l9S+2CchEhwWRT8QlktRTEOfWQaoDheVXKyYxUJ+8WQnV7egp6/OMYbXG
         /Zjv7xMb8tc51dCL4OLRXeguzCjGj2Joz5++FGKcYyF++/peURWXL/mAJTvnG7gtwTWH
         ivFoQ0TFZy9qRCpI5t6FuRORIodXE6yMfh6mvjaAa1NjhsZe2Zxm1h7Fbjq+kQ6yvyoy
         4tF2P2KvzE6PwuiK2SeTx9V+LpMc1cTnuIqnULPfGCVQPJVsVOLJlAIyfU1+vuk/7xN6
         NiRg==
X-Gm-Message-State: AOJu0Ywa+7VNxQQRMqczgmJlmIlu5Xqif6F/PbmN0/zubyRSpZs6T9zH
	fOFOAS6YUP4q5nelu9HXX8y+yCt6QQLXpagFZNBH8pYVb7aopmEsehsDvctCsVzEuEz22YW7T9p
	57rpZHbkvje6FEZ4gMWuobP0bT1N5gsbqebA/xdJIdx7JNoZuov857x/SEg6sFA8fuu4adA==
X-Received: by 2002:a17:903:32c9:b0:1dc:b64:13cd with SMTP id i9-20020a17090332c900b001dc0b6413cdmr2650558plr.27.1708695914917;
        Fri, 23 Feb 2024 05:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfxbaxzbwX+vOaMy2T14mI0WT4mlvNP130gvn85DHDQD+FaZH6sPgdcg5aNGg1OUSFlg4e0A==
X-Received: by 2002:a17:903:32c9:b0:1dc:b64:13cd with SMTP id i9-20020a17090332c900b001dc0b6413cdmr2650546plr.27.1708695914613;
        Fri, 23 Feb 2024 05:45:14 -0800 (PST)
Received: from ?IPV6:2001:67c:1560:8007::aac:c490? ([2001:67c:1560:8007::aac:c490])
        by smtp.gmail.com with ESMTPSA id lf5-20020a170902fb4500b001db43f3629dsm11647610plb.140.2024.02.23.05.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 05:45:14 -0800 (PST)
Message-ID: <061f700b-77d1-491c-bd9c-79b860d6f6d6@canonical.com>
Date: Fri, 23 Feb 2024 14:44:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Backport commit be80e9cdbca8 ("libbpf: Rename DECLARE_LIBBPF_OPTS
 into LIBBPF_OPTS") to 5.15
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <8a078070-19db-4ca7-8210-077818224f67@canonical.com>
 <2024022318-greedless-unshaven-764a@gregkh>
Content-Language: en-US
From: Roxana Nicolescu <roxana.nicolescu@canonical.com>
Autocrypt: addr=roxana.nicolescu@canonical.com; keydata=
 xsFNBGOz8dUBEACbW6iR0smNW8BxmNcHzzktKmKImDxMdQlHZDYbKfQLBwNPGXaBq9b8vq2h
 Ae9pdbwIvaHmx2dL1hWuD1X1S7CKxqH9lsZXF2FZk/l1wlHSRIsElTaxau5lZP+EwzES2kXM
 9zSRE+R6bD/MkGbwPl5fkRY0yhgLt2pEuc+yBLHVkENpr+cC3saikSRwtI6jfApHv2C9DKlq
 +42n0urEI7WR4l0Gdvw/t9c9B3QeEigxz5u1OicnhKcG4GK9gwmCYP2wbjPVwHr1zAxMxHAY
 sKSmR2jb32N+3QnyoLvvQekk8wG0ainqv332+vvxYeTDXTrohdSg5OZPON1V7Wh3LPLAlQbe
 agI0g+lCRXriv7Lu33tLlL7a2ph3bUEMAvagI4rhsgg7NSg4uzeOeLDAdW42qHQGDyRxX0Lw
 U8ZXuN551KLm0u2I/Ruo2AUFIavkjUfSsXqHJpCY2CXmvjDeHcBsHlN7U8VqNeYsqXn0EnjN
 OqgW94WWDZTS8ZFM8kkYbA2d7DQZstmhS9h/zJ3Y3wdsph4BDebp5yMH3vXnwOh85ijqQXM7
 iUkjIfjpXCejDOaeb9RT4xzwEmxChhGYqBk5mNr/plSyyLD+OkOLzAMeFmh5sx5x+/Oui/Xn
 s97hNlfOKOT42WLkcXcRF8xGborT79Nv5ird9E8qDwpkFT3gwwARAQABzTFSb3hhbmEgTmlj
 b2xlc2N1IDxyb3hhbmEubmljb2xlc2N1QGNhbm9uaWNhbC5jb20+wsGOBBMBCgA4FiEEuTxl
 ymcAhyYitf9DENoe7adEB28FAmOz8dUCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ
 ENoe7adEB29U0w/+KR8ikSBennP/B26R8KhFVFUAJCxBToGdHWWoNzmSBMijTvrz4pSS3OfI
 F8fOFPel0aQqoZOOgqC9rWPMy++o20qSg2pUCRrPvqK1YteIX1PTRfoxRSYP5NPp0uQz8f5w
 BKvXSb6eu8JHNzlFlKCvOt5EeMICsl47qf8vGh2/t3PRsp9aLOed1fXnNUXNxqCLphcRwGy5
 sGezEFK690x6oJHmTkq0r4jCCaJpDvUwx4VAAL1SsaEjRwgyN9O3Hp78KlJq+wdfjtMrtheY
 AnME9B0OjuE/PeScNy4qG/jmmjTmlkT4n99JkkQXTiJeiWZSkBAh/1zR/j59q5GiyTOCEIFw
 IZJNIBTdfHfwEYoPiRiaZk3zCVGgey+F7trwXXM0AY4IoBwvpB671RFxsrrbS/Pz7i1WgtW6
 oSK+u6OqmewRqZAqg+vYCzflxfFk6xKiAuKtLiZED3e2Lt0aHFCKyCDpsdMsTDSupO8WnqvB
 4yJkoO6QyzyGT2Rv5eWI8S3/R7MTtJMt/K+fYJ8+/ltlHqKIcmpFrByft779g3D5dyKtRfWV
 s1FMHwoAdr7xEc8avcVbqTXSurFcnwMCYuM6G9zCB+q2yaKGhMzPA/LHlbGyS8QpO5H3ksp+
 bx/87wRw/0ScbT/eswhg53tZx//Gxf5zIMcPDytp/vwcyk1HWiDOwU0EY7Px1QEQALRjXzH1
 KoYC1+9B2+/s7EQWx5lfXimqnVG+qPl01q9qEPZqrjBwXOWJhLaFYLFa3GWOVxSpzRpZNL64
 wwmABJWQEWqDoW4p37q51TxjcQbs/P8jIy0tvDzYixWUj/NwBJnIuI5ge+GJ9xBtsN+e6/34
 pXs+hOAU2d9HPmpmU4WnRNqIfckBABZK5wB19Xhljo7usXKRciuJkTLp2rQDcmpxBv+VqqKW
 icFmW4iam6ZHuElU56/Li/U51L1LeMOCtXWnrKKoiaRSBK1XiItij1mYs6ayaBlxXk8xceeH
 bAHMgZXnltNJeog4S/1doGnrlJYkYcYdDu+Fzf+c5A5bFbe/s89uSpst3kbEqAD1AFEDBfgK
 Kc7CiI3L0uQJ0oYFRMMeu2FM1GMYFF24VZi72fI9WPpU0HmXF0ZouIcud2fcCVmG0S9euif0
 abPi/1Fhn4zIl7bG2+TeBeS28RYZA7XC4exbiPOPRETbFBsTWp8KloRNdIQGg3FCudMz2LKv
 UOu/IXafwBtgORLDr1dj2Ze2Krf4EkBJh8xRgCYbvBOycceyIkBb+F3IfDxqvmaDqnEnoJyS
 lZ84o8R3V3lhP2OD/Yvb+gBl+O/xXzfP6rRMrruZRFof3AXsuKKOcgDpIXd2/MsG/MK/HTHK
 6KFfZCGUdTxhoAr3XVg8Q0CuwZ3jABEBAAHCwXYEGAEKACAWIQS5PGXKZwCHJiK1/0MQ2h7t
 p0QHbwUCY7Px1QIbDAAKCRAQ2h7tp0QHb9HKD/42ya1pLxmkJ7pAZeWIiszMwDEEmxbQicS9
 fZtjRN/IL3AiVvcWyN8cqsESx9xzCnjad+rCHr4PmuGvTHasolFHziCX5B2bCRAVAkGIBcJC
 2mCPQEGZt8YysGS/y9KxqMgCy045pcBKtmPtRWab26+3FbkjJ/eje9vcDv2GyN09Rh6R57Zx
 2hN4rZjZnbp7vfZPrKhPbIT2ckV5ZtUm9Er0/Vy/Lu/CrnOOYwJrpgLa8R3thBR9t0pDZdFd
 VAwl12qzt2C9Js+XjuxhYuywTtpvr8QgBhu4U/JN7OFfxD5WSanJ38KSFK3FeUdeqIfDDTQK
 d0f6ntHmjLqteo87cedJGwtFIZTW1a5eCZiKsfhosCSmrFw3DLDI5Cun7Sm1SWMShYzSpnSC
 i75PB8GYiH5T12ZSxRhRXCIri0OzPRYvfKZ82Ji33UUG5MZvqKpttEXaK8bxqmAg0TrJ+nLd
 jn99r9WDQokRITZRW4GCUDFY/K6p8MBfGM+sm3oi50hGXi4SRIYD0dZpC7QWRYNmhR9AsxWR
 EGoQV+X6XMEh1XFcBpExwvFrIpD+5SZrWp4e/lGLGA70EBHKFO15YL1Pv+fChskp3wRYr4mG
 Ao8E1tCv1TJZdkVZ7z93qUroOf8qi71FSzApqEHX7OyT3ad5/fYRzeme+3VlwGS6MHMWnpuo Og==
In-Reply-To: <2024022318-greedless-unshaven-764a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 23/02/2024 14:03, Greg KH wrote:
> On Thu, Feb 22, 2024 at 05:02:19PM +0100, Roxana Nicolescu wrote:
>> Hi,
>>
>> Please include commit  be80e9cdbca8 ("libbpf: Rename DECLARE_LIBBPF_OPTS
>> into LIBBPF_OPTS")
>> to the 5.15 stable branch.
>>
>> Commit  3eefb2fbf4ec ("selftests/bpf: Test tail call counting with bpf2bpf
>> and data on stack")
>> introduced in v5.15.39 is dependent on it, and now building selftests fails
>> with:
> Does 5.15.149 still need this?  We fixed up something like this in that
> release.
>
> If not, let us know and I'll add this.
>
> thanks,
>
> greg k-h
Hi,

The test was reverted in 149. I did not see that. All good!

Thanks,
Roxana

