Return-Path: <stable+bounces-232983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULe5IJpVzmnPmwYAu9opvQ
	(envelope-from <stable+bounces-232983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:40:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 725EB388712
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AFBA3015167
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FA63D412D;
	Thu,  2 Apr 2026 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qxg8ONZ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A530E0FC
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129172; cv=none; b=OapUKcqw5pgC2W8fnCzlDuFFN92WquJ17NIKMCwwNMKKfg0ETLIxRfr9SoyeUBKzkQFCt4N+aTxIkvMeiaqz8gLSz15UKhnn2kmGyFCuPcjWt4qLTM9ab9UFpFX3g2/zkzEEf/n5ACMGuGCTcQRrngZQVWLKAYavFUJucja4Hb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129172; c=relaxed/simple;
	bh=M6U4j/NLiQ+/4aHjkSTAmvKfIhe8Sr7hjNTZaZUG7ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okdq+ZXVDdeJIQZCgQ+m68wxJlncI3gD6K99kg3MUxlzzdo8SLA3BMVZJTYHy7POgBaJCbug2ulZVfAHCdFR3wKRIyFlEZQzqbtWPWfB+6PzD0TrS3MunOO7E4vcCdZaltEaCqRwXHlbU5p1Siud/AQJcZkQwpajBUlwPJO/kag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qxg8ONZ/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so8669795e9.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 04:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775129159; x=1775733959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5JQGdVakt/jSwsp5LQgcZLl+3LElhn2BfzsSs+MpKc=;
        b=qxg8ONZ/iN0/apf/OpTmRm8qxs6YGJVBmFU98HzmaDlpfox/AQB4AP4fIkQCQi/bkZ
         kIUPq+cL4QQ293WvW9bPkK4ndKLOxCiHZIvi7i/Uu3J6jf9VJ0mirecvy4Jz3f3JUn7I
         sbiuE8j92dzdUM2PuwTRQE+hpsf2OsZ9Unsk5dWMIfXKz5vKAiwUz3Ufb4ee+xSMv+Fr
         OGfvV0EvHFTcbpSXSlUa9zl9wwLyS//alDmbfxHWSk9mqpSadH1o35fDmoi/d3/2LgS8
         04XIchzP26UH4Y0ikNaN1tvJgIGfYWX81ZJXKhcoShAekciCUZ96aFXPIASpOc+O71TM
         UYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775129159; x=1775733959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5JQGdVakt/jSwsp5LQgcZLl+3LElhn2BfzsSs+MpKc=;
        b=UBdq0fup1zcIdRNCtkoJNucJCq1KtdPabCJx4GO2R3O/znric/IikeOzto75x8noNn
         xobYKSdOGoNEiumpiW4RYJMR6Hy4rAuvG8w7dMe7jb+cCiCBT+PqidXt4v1h1Cuts8d4
         dg9QrEHBQMiewgro8ulxoQxPnuY68YDhCilZUKay6/LvAGctbz+vsmDVZBR8fZCfAPw0
         hO1DI7nexAhY3L5+jlHCdYNaCB2Dvxke7xIFFFuMqmHGnujbfs7dpUPYyJ5Wv34pzSja
         75IH1J9Ko4kQSnRHOtS1u7XCBYYWvKLmfCDDuyGKdsx3YlxyGLoKi4JxWZDPovwzVupI
         jcXw==
X-Forwarded-Encrypted: i=1; AJvYcCWf2Q40UMi/IDvhVuFVR4JmFyWTlAyxs5RRsFyHR6PUTz+5b8ePpoetvzmLazK0UU046BJrAFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyjVehmEZhAjV87FQ18Z1GbdYzYj6YEB6wPBIMs9AOzfygdfG
	6dtx5+GJz14i+mVOrnLXmSJdO5thaQ+u7nkDs6EcWv6Eia7vYxDR/r0te4foTeWXBmQ=
X-Gm-Gg: ATEYQzwL4cMJb8nrsE5SeYKn0MARFPlXFsK9DoUCiAJINMIW0XpD9XnB8OgujhA0gMB
	nWRZQJXbvnhZpPa4sTaht1EIvTFEGX5Z6MY5E5Nzj6DbsEzepDbQHvYbIDo5i09akDUgEIDavhX
	mpYVzYwWcmrZfaIYDS6OfG2DlLqc3eS3qKi7LnkW3ieHd8ZBSiWGkul6av4JBXPXSnq7EEkC9NT
	C8N5SBIqQSACQmJ0HniGgIyZITFuMCkra8e9Qnu+VmExgnYEqjPne9y7SlExCx+aX9I2jNAf0ZH
	F1i+IgL7a+S21cFZvUEzkkhw3T49D+92gdWxZzeFNLzQkbaR3sIJyYfZWtNdD/gilUn4tyM6TPD
	uzlrCNjK3ZG55ohtgi6aGX/b8FL+ShGgezeA+e4kjIElDAlNr+jmF3POGIwaeQTbMQDdON3BL+1
	9N3cRqS1VIHm01+pMhD3B5Cmix1jMAsh6xDZz53VG0/Q==
X-Received: by 2002:a05:600c:4744:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48883591f01mr121033965e9.21.1775129158565;
        Thu, 02 Apr 2026 04:25:58 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad1cd86sm65951315e9.5.2026.04.02.04.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 04:25:58 -0700 (PDT)
Message-ID: <9892a17b-022e-41df-af1c-a2d684aa8db1@linaro.org>
Date: Thu, 2 Apr 2026 14:25:54 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, jyescas@google.com,
 kernel-team@android.com, stable@vger.kernel.org
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
 <20260323135414.GA8437@ziepe.ca>
 <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
 <20260323173138.GB8437@ziepe.ca>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260323173138.GB8437@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-232983-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 725EB388712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Jason,

On 3/23/26 7:31 PM, Jason Gunthorpe wrote:
> On Mon, Mar 23, 2026 at 06:46:39PM +0200, Tudor Ambarus wrote:
> 
>> Downstream we have a display controller that's using:
>> 	iommus = <&sysmmu_19840000>, <&sysmmu_19c40000>;
>>
>> These are 2 distinct platform devices, they probe independently, they
>> each call iommu_device_register() independently.
> 
> Sure, I guessed that is what you ment..
> 
> Do you have an example of this in an upstream DTS file?

Yes, Exynos multimedia blocks use this upstream For example, in
arch/arm64/boot/dts/exynos/exynos5433.dtsi, the `decon` and `decon_tv`
nodes route through multiple sysmmus:
iommus = <&sysmmu_decon0x>, <&sysmmu_decon1x>;

Looking at the upstream exynos-iommu.c driver, it doesn't return
-EPROBE_DEFER if all the instances listed in iommus doesn't exist.

It seems it survives the race though, but only because of the
core_initcall ordering. In downstream the IOMMU is forced to be a
module which exposes this gap.

>  
>> If I understood you correctly, the downstream driver shall model its
>> architecture and call iommu_device_register() only once after both
>> devices are configured.
> 
> No.. I'm not being so perscriptive, I'm just saying that once
> iommu->ops->probe_device() returns then the device is fully setup and
> dev->iommu will operate all of the iommus described in iommus=<..>
> 
> probe_device() cannot return some half setup device with only some of
> the iommu instances working.
> 
> We don't have any core idea of a half setup result from
> probe_device() today.
> 
>> If the core's intent is to strictly enforce a single IOMMU instance,
>> shouldn't iommu_fwspec_init() be checking
>> 	fwspec->iommu_fwnode == iommu_fwnode
>> instead of matching the ops? Because the core currently matches on
>> ops, it permits aggregating multiple physical instances with the
>> same ops into one fwspec.
> 
> The driver is responsible to handle this, not the core. It has to hide
> this mess under its covers, not rely on multiple calls to of_xlate or
> however it has been hacked up.
> 
> Probably it means something like of_xlate/probe_device has to
> EPROBE_DEFER if all the instances listed in iommus don't exist.
> 
I can probably track whether all instances are ready, and defer if any
is not ready, but then I'll force the iommu clients to use the sketchy
replay path, which seems like a bad idea, according to Robin's feedback.

I haven't seen functional problems with the races, just the "something
fishy" dev_WARN. Maybe we shall downgrade that to dev_info.

Thanks!
ta

