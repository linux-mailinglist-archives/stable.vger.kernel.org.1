Return-Path: <stable+bounces-161851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318F2B041FC
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46786189151F
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953D246BD3;
	Mon, 14 Jul 2025 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XU0c7U4S"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D692580CA
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504065; cv=none; b=kf+Uh2tVCx6x6b2OsvL3Y/hCaqP4YOcrWMX3JOmH7hcGSiQ1zp4pXdQGGBsD1E0o6/6jkYYsPrxQZAE8m4NQFAdoo9AlE8HZn+o6/prhp/BowZ3IJdn+2XyosmYuaceFqd0Wl/SD7dgOEvUGwpYcBQgl282a6RULIznsw2sr330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504065; c=relaxed/simple;
	bh=WkbnkSN/9C9x5BAWT4GOvXy3evb45ZMcjMYvY/vr8qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCS9K+dQ7mxO3H9CcMTjt+/f/GxLthYWX8qeVz1RQNUsbCQ5yU8AWR8obyAxcoRw4jKsTPaEWr+FFfbq5EVXL7HlODwiusuQnxBsRnaTgPKpfaG5+HF2Yh+fZL45/QleG1cZLyxtq8MDaeAMMcvtiZ+U5hubDRrF5L7E8n2bInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XU0c7U4S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752504062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLXKhg1K3xQXwvyv6fgRzq/1onAkTRUAFhWSI1xTzJI=;
	b=XU0c7U4SHvGco2ckJdj7d4yRt73I53c7qGtrFtYvyCSV2Nhj6pAsxmGCx+ifJ1Z1ZTT5sx
	yzG1NJ0ZoswpofHL6WdOse8NRrr12mr+RAfzvesMktnymZHyiq6Pn0+6m3OlmaiqhcysrF
	6dmanAhPz0cU70Hwes4saT1LZsBjmZ8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-bfpdmmkcNJmq4nTW5wGcSg-1; Mon, 14 Jul 2025 10:40:58 -0400
X-MC-Unique: bfpdmmkcNJmq4nTW5wGcSg-1
X-Mimecast-MFC-AGG-ID: bfpdmmkcNJmq4nTW5wGcSg_1752504057
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae6ee7602c7so367891266b.0
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 07:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504056; x=1753108856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLXKhg1K3xQXwvyv6fgRzq/1onAkTRUAFhWSI1xTzJI=;
        b=P3ObtDK701iccBhFnepctNcgxUC3hfUpchNeZ8ee51qK9NYkmuDwlA5pxEyDUiNsAi
         XfUiP1NDFN1nUYwIHkgrBpocJUTMj9ZRZKegnegg917HTjBottY7rhnl1KIvN1wQ8ke1
         RcECAzIe+wqaVRHk0FeA/8W29zKbBG/fdBvi+LApwXp1Ej88E56v82sldVxn0x0yYwWk
         vMNiWVMX5NjkqNRSaaJh5s0nNb9bepymjzm0CGaJzDyZM6HS4k9KcNIuvSDjFG2PTc5g
         9Kkz0KpxrBUMTrqpojGQpFomLeMxFS6ON2TwvnLhGw9gwTss9D0Agin9YnnGttlSvlcN
         dVvg==
X-Forwarded-Encrypted: i=1; AJvYcCVbgT3rVA7PRXwUswfJPV7WVdJTT4ymgHNSTrskBzzHluZv3bc6O5F/7l0uQIYrGeYqe1Q545k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/cOtcIpv1PCit5UwoZT5rNpwwcosbW6aUsbWDNKaPN/ZOro5
	p8IpGStQbcNCTHI6h8dddzmXi+UXJFzQq+HKHivYZl1LaOH+mb3w3pxCtNEWAco6Xm5/01Y0Ymt
	qfk9Kv25LWUIw9Y7AHE0YP+dsErUJryuI846YQx9nXk+MIl69qAVTKxEnOw==
X-Gm-Gg: ASbGncu3k6RTeZbf5Zd1/JHyJESgxxRuumfZVmCbgv8n8M9ifos2LdJIVCEU0PtE6cJ
	YQfsaKIws62ISRjjmfeZDFyACm9YYcvS/rdppqbvag4Dx5nd2uNR66qqFyJued4/b9ZYfF1AZPG
	aBGor5YXRX0NFvsLlMunkdOf2/PEYe0EVduUaHcpjUgmjLP1uv7bbR2oXSRRwxmmXlxo9LyHQqY
	fl+ucjzgxn0EoLD2UfGbDqBXgCVVgh/jvofIwZQDJz6ic5ex2z+0BCRrSDbeDHdoK8DkVOPmUIh
	LvGL91Y5A/ykMdIPTcDtDLA6yuYiMxGNmcjoFI304BCe
X-Received: by 2002:a17:907:3d44:b0:ae3:ab68:4d7a with SMTP id a640c23a62f3a-ae6fbed8219mr1633100066b.25.1752504056147;
        Mon, 14 Jul 2025 07:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHucm1YdLEC7W2MqVgXeYA2wsn4X0D/6ulvdMPDsK2hXL50tiQScU0+GEvdxz/6WUq3kW52KA==
X-Received: by 2002:a17:907:3d44:b0:ae3:ab68:4d7a with SMTP id a640c23a62f3a-ae6fbed8219mr1633096866b.25.1752504055640;
        Mon, 14 Jul 2025 07:40:55 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91a0bsm827763966b.7.2025.07.14.07.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:40:55 -0700 (PDT)
Message-ID: <afeadd0a-d341-46ee-9634-01c5122b416a@redhat.com>
Date: Mon, 14 Jul 2025 16:40:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 087150] Input atkbd - skip ATKBD_CMD_GETID in
 translated mode
To: Wang Hai <wanghai38@huawei.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
 patches@lists.linux.dev, yesh25@mail2.sysu.edu.cn, mail@gurevit.ch,
 egori@altlinux.org, anton@cpp.in, dmitry.torokhov@gmail.com,
 sashal@kernel.org
References: <456b5d9c-f72a-4bfe-a72a-b5cc0f15eb70@huawei.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <456b5d9c-f72a-4bfe-a72a-b5cc0f15eb70@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 14-Jul-25 15:49, Wang Hai wrote:
> 
> 
> On 1970/1/1 8:00,  wrote:
>> 6.6-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>>  From Hans de Goede hdegoede@redhat.com
>>
>> [ Upstream commit 936e4d49ecbc8c404790504386e1422b599dec39 ]
>>
>> There have been multiple reports of keyboard issues on recent laptop models
>> which can be worked around by setting i8042.dumbkbd, with the downside
>> being this breaks the capslock LED.
>>
>> It seems that these issues are caused by recent laptops getting confused by
>> ATKBD_CMD_GETID. Rather then adding and endless growing list of quirks for
>> this, just skip ATKBD_CMD_GETID alltogether on laptops in translated mode.
>>
>> The main goal of sending ATKBD_CMD_GETID is to skip binding to ps2
>> micetouchpads and those are never used in translated mode.
>>
>> Examples of laptop models which benefit from skipping ATKBD_CMD_GETID
>>
>>   HP Laptop 15s-fq2xxx, HP laptop 15s-fq4xxx and HP Laptop 15-dy2xxx
>>    models the kbd stops working for the first 2 - 5 minutes after boot
>>    (waiting for EC watchdog reset)
>>
>>   On HP Spectre x360 13-aw2xxx atkbd fails to probe the keyboard
>>
>>   At least 9 different Lenovo models have issues with ATKBD_CMD_GETID, see
>>    httpsgithub.comyescallopatkbd-nogetid
>>
>> This has been tested on
>>
>> 1. A MSI B550M PRO-VDH WIFI desktop, where the i8042 controller is not
>>     in translated mode when no keyboard is plugged in and with a ps2 kbd
>>     a AT Translated Set 2 keyboard devinputevent# node shows up
>>
>> 2. A Lenovo ThinkPad X1 Yoga gen 8 (always has a translated set 2 keyboard)
>>
>> Reported-by Shang Ye yesh25@mail2.sysu.edu.cn
>> Closes httpslore.kernel.orglinux-input886D6167733841AE+20231017135318.11142-1-yesh25@mail2.sysu.edu.cn
>> Closes httpsgithub.comyescallopatkbd-nogetid
>> Reported-by gurevitch mail@gurevit.ch
>> Closes httpslore.kernel.orglinux-input2iAJTwqZV6lQs26cTb38RNYqxvsink6SRmrZ5h0cBUSuf9NT0tZTsf9fEAbbto2maavHJEOP8GA1evlKa6xjKOsaskDhtJWxjcnrgPigzVo=@gurevit.ch
>> Reported-by Egor Ignatov egori@altlinux.org
>> Closes httpslore.kernel.orgall20210609073333.8425-1-egori@altlinux.org
>> Reported-by Anton Zhilyaev anton@cpp.in
>> Closes httpslore.kernel.orglinux-input20210201160336.16008-1-anton@cpp.in
>> Closes httpsbugzilla.redhat.comshow_bug.cgiid=2086156
>> Signed-off-by Hans de Goede hdegoede@redhat.com
>> Link httpslore.kernel.orgr20231115174625.7462-1-hdegoede@redhat.com
>> Signed-off-by Dmitry Torokhov dmitry.torokhov@gmail.com
>> Signed-off-by Sasha Levin sashal@kernel.org
>> ---
> 
> Hi, Hans
> 
> I noticed there's a subsequent bugfix [1] for this patch, but it hasn't been merged into the stable-6.6 branch. Based on the bugfix description, the issue should exist there as well. Would you like this patch to be merged into the stable-6.6 branch?"
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9cf6e24c9fbf17e52de9fff07f12be7565ea6d61

Yes, if you can submit that patch for inclusion into the 6.6 stable branch
that would be good.

Regards,

Hans


