Return-Path: <stable+bounces-249208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLqbHcfECmqa7wQAu9opvQ
	(envelope-from <stable+bounces-249208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:50:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6655681F4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6FD33047E9A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAA23DC852;
	Mon, 18 May 2026 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXAVzmrG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dt+aJF5U"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D43C13F8
	for <stable@vger.kernel.org>; Mon, 18 May 2026 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089797; cv=none; b=uYF6brj4QgI2NxYVKuQdh3wiZUSUNu4IaHkZeNym1iMNcYQKWgreZvwMbV1000gpW0PLwqr2z2IVarW531wHt3Q7ygQvNhTZIqwV5LsQIG1FBVhLLsJFkgewbfbEUQLfiHg/YNwyWUo3/X44HMAePJEct31ssuaMNMd5yirxeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089797; c=relaxed/simple;
	bh=tSY/+9e7Avin2SKeKnn0nYd+uZVQTXgWH36OVAKxF6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/1yfE6Dmbw46un5+2qigbXoCkJgqgEJj6aT2BE0JEkNDjBsrU7O7L5XDWDxafCtH1DJUteBGhnkr6iOi/9JeJDMppMnPJ7V6v+cjCBB3vNg9VoNvXGz8BSeSdnfIGhwzQ7tPJY9EQxTw1ValitStyg7mTfdaw1A6FW/aS1myGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXAVzmrG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dt+aJF5U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779089794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rxj3hjLS1wMg1dys4oRBWhSMYXGodufeExdNLEthm+k=;
	b=iXAVzmrGOhDc/XohA89QOdwhrROBeQerc2ED0fo/I+DXt8G6+uxqrZNRidC8IwCZHKs0v0
	syCn8134XpMPrHT40m28pT4GTpxJ9lxS0V/SMonm5aXNJYwssIjmjfX5iEMXHcN1vU+xkT
	ce9/ffzxH85NzFYAP3ePCbbh99KTe24=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-DbV4FwxHM1KqwcpWTU9oDw-1; Mon, 18 May 2026 03:36:33 -0400
X-MC-Unique: DbV4FwxHM1KqwcpWTU9oDw-1
X-Mimecast-MFC-AGG-ID: DbV4FwxHM1KqwcpWTU9oDw_1779089792
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44696b11265so3041702f8f.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 00:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779089792; x=1779694592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rxj3hjLS1wMg1dys4oRBWhSMYXGodufeExdNLEthm+k=;
        b=Dt+aJF5UjxvV5wDE4PZ4kyPqHENjwo5krRuKY0PLlfknlH6ABYlNuR5ER0jM6vKz5b
         xWuQ2te0CKWAzzTdJzEYRex03jr2xEeVwgr4pFDpVoZaZdLqoDbDhPPnfdhoCBM64NWy
         Azh+1Gvr2Bp1Eh+4GWUQJqfdcgxA1xGyR7+xxB9HpjUaWORnGtsaxuSBj1DnVaCnTpOM
         1fAnP4iaFIzSKhyqMAwp1+UbLQem6k95IaH5kNaN/Aq0YS9rNnkO9I8cRrG7BS4PKh+i
         lOXuGvgFDF1b8chnuY3/pUSqbI//c409joHzhX9cfOMZoDjX9YJ7aQshSskrhmAURnVX
         0TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779089792; x=1779694592;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxj3hjLS1wMg1dys4oRBWhSMYXGodufeExdNLEthm+k=;
        b=j5dCDsKL8nT1K3ZeprFdWU3J7xzohjYmi5f6bm9+WEh7Hgz4hxEPFLZI45/plSHzW0
         EngnuWpuM36f5RRC912EkkqTugpUTMwFejf7am8XQJqWV5DGUe0iJ6zV/CSRn/KGmfI4
         630HX5TloSMO/sUFZKckk8ldNQ3zoqJORQKvJLeMWbczKdIp88c9TWeizYlrqheo2MHC
         FmpMHA0hIoETDk+r1T7pEpx+j9dJBhQPK4PNKPbQKHh8XfFm0WXUEYkHXYNjgjD9lR3g
         mUeWZnN0B5XgsIRKo3He+qZerruGODdv2y2Vawi+5AsTd9xSQoflQ41WvlH6aoCIZA3O
         uqVg==
X-Forwarded-Encrypted: i=1; AFNElJ/otgdZXKWkFcv26uej5eRCbW2z4qLHpJKlE7E/he1a5Oj9QhQZCyryuSGYXlCkKc6wi7f6DD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsI8qLdGEScOitIXYlaHK/VyS1PMqe+lTY+enWgKT6sQuY7yb
	JE/yqGKxs5DrmXXBfiv6E36G1AXZotupzqyoh5Z3BAXWZbG/Jm+4qA3Yl5AKRmsDRVZIGWIz922
	TaWuNn3l6wm4T+wwapunsvgIhLdzgyyw76zZKztpPziVUyFoTZcM82C6wdA==
X-Gm-Gg: Acq92OH0OgyaOOieDCPGBiACyp8TPTVZnhSKarQ92E8VwKrCskr4AC7DyXUL6Y0IaQB
	W5AEuNbcJ2sHnbyN69ExKBVP325aztef0OnKU7ySp5BBLdKwXqxspU/9DXdVvhE1avnNkcBENZh
	JJzt0NpC5AXYlpa8FWrpkVi+QHMoB3jEH8DFZT7tXsTCRgaULK2D6BYXy/xtM3RBS2gM59VBegC
	i3u/yZPTkV6tnOcNOrZMY7WApeDTudBOHN7HHK3GPSAHClpCj3a5RjITg34dVwOu+UhzGrQ6EM/
	7FqdCxcHwYb+NtLmhsgDepIobrBeJ+SXYlDfGF4lpW4dKxKNe/mKf8Ne3SBra+zYH0Wi6gjy2Bk
	UIFplM9uhvtCOpxwf0Y41CN37tRUnLXMoiY/ZRwq1D2aEIhAXgEjBupU=
X-Received: by 2002:a05:6000:401e:b0:449:c5e2:a8b7 with SMTP id ffacd0b85a97d-45e5c59ec1cmr20788004f8f.30.1779089792173;
        Mon, 18 May 2026 00:36:32 -0700 (PDT)
X-Received: by 2002:a05:6000:401e:b0:449:c5e2:a8b7 with SMTP id ffacd0b85a97d-45e5c59ec1cmr20787957f8f.30.1779089791712;
        Mon, 18 May 2026 00:36:31 -0700 (PDT)
Received: from [192.168.100.100] (82-64-211-94.subs.proxad.net. [82.64.211.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm34279591f8f.9.2026.05.18.00.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 00:36:31 -0700 (PDT)
Message-ID: <3550f13e-124c-492f-a5b5-ae6ad95f09f0@redhat.com>
Date: Mon, 18 May 2026 09:36:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] usbnet: limit max_mtu based on device's hard_mtu
To: Matthias May <matthias.may@westermo.com>
Cc: linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Stefano Brivio <sbrivio@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260119075518.2774373-1-lvivier@redhat.com>
 <539202f5-43ba-4938-a9b2-393c1bb3e072@westermo.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <539202f5-43ba-4938-a9b2-393c1bb3e072@westermo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C6655681F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249208-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lvivier@redhat.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[urldefense.com:url,kern.info:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/18/26 09:21, Matthias May wrote:
> On 19/01/2026 8:55 am, Laurent Vivier wrote:
>> The usbnet driver initializes net->max_mtu to ETH_MAX_MTU before calling
>> the device's bind() callback. When the bind() callback sets
>> dev->hard_mtu based the device's actual capability (from CDC Ethernet's
>> wMaxSegmentSize descriptor), max_mtu is never updated to reflect this
>> hardware limitation).
>>
>> This allows userspace (DHCP or IPv6 RA) to configure MTU larger than the
>> device can handle, leading to silent packet drops when the backend sends
>> packet exceeding the device's buffer size.
>>
>> Fix this by limiting net->max_mtu to the device's hard_mtu after the
>> bind callback returns.
>>
>> See https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues/3268__;!! 
>> I9LPvj3b!H-nIZIscCCh_2FnbJInagPxXTe0XcNu58-8k3NqGYKRdDy8LBOBjWiTIc1E- 
>> cC2wnv91MtZrak2pu7K-4cU$  and
>>      https://urldefense.com/v3/__https://bugs.passt.top/attachment.cgi?bugid=189__;!! 
>> I9LPvj3b!H-nIZIscCCh_2FnbJInagPxXTe0XcNu58-8k3NqGYKRdDy8LBOBjWiTIc1E- 
>> cC2wnv91MtZrak2pq4lrvZI$
>>
>> Fixes: f77f0aee4da4 ("net: use core MTU range checking in USB NIC drivers")
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> Link: https://urldefense.com/v3/__https://bugs.passt.top/show_bug.cgi?id=189__;!! 
>> I9LPvj3b!H-nIZIscCCh_2FnbJInagPxXTe0XcNu58-8k3NqGYKRdDy8LBOBjWiTIc1E- 
>> cC2wnv91MtZrak2p8csXaww$
>> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
>> ---
>>   drivers/net/usb/usbnet.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
>> index 36742e64cff7..1093c2a412d9 100644
>> --- a/drivers/net/usb/usbnet.c
>> +++ b/drivers/net/usb/usbnet.c
>> @@ -1821,9 +1821,12 @@ usbnet_probe(struct usb_interface *udev, const struct 
>> usb_device_id *prod)
>>           if ((dev->driver_info->flags & FLAG_NOARP) != 0)
>>               net->flags |= IFF_NOARP;
>> -        /* maybe the remote can't receive an Ethernet MTU */
>> -        if (net->mtu > (dev->hard_mtu - net->hard_header_len))
>> -            net->mtu = dev->hard_mtu - net->hard_header_len;
>> +        if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
>> +            net->max_mtu = dev->hard_mtu - net->hard_header_len;
>> +
>> +        if (net->mtu > net->max_mtu)
>> +            net->mtu = net->max_mtu;
>> +
>>       } else if (!info->in || !info->out)
>>           status = usbnet_get_endpoints(dev, udev);
>>       else {
> 
> Hi Laurent

Hi Matthias,

> 
> This change was backported to 6.6.* and caused a regression with wwan devices via USB when 
> using a mux.
> 
> Tested on a Quectel EM12 running the firmware EM12GPAR01A21M4G_01.300.01.300.
> 
> Tue May  5 09:49:35.638 2026 kern.info kernel: [   10.819620] qmi_wwan 1-1.2:1.4: cdc- 
> wdm0: USB WDM device
> Tue May  5 09:49:35.638 2026 kern.info kernel: [   10.829601] qmi_wwan 1-1.2:1.4 
> cellular0: register 'qmi_wwan' at usb-fsl-ehci.0-1.2, WWAN/QMI device, 6a:c3:49:88:47:b1
> Tue May  5 09:49:35.638 2026 kern.info kernel: [   10.840579] usbcore: registered new 
> interface driver qmi_wwan
> 
> The parent interface (we renamed it "cellular0") requires an MTU of 1504 (4 bytes overhead 
> from the muxer).
> The actual wwan0, wwan1 interfaces have an MTU of 1500.
> 
> With this change it's no longer possible to set an MTU of 1504 on cellular0.

This should be fixed by

55f854dd5bdd ("qmi_wwan: allow max_mtu above hard_mtu to control rx_urb_size") which is in 
v7.0.

Could you have a try?

Thanks,
Laurent


