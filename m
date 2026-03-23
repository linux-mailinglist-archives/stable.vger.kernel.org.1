Return-Path: <stable+bounces-229973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIrgEMR0wWl5TQQAu9opvQ
	(envelope-from <stable+bounces-229973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:13:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D417F2F99AA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD1C430B0CE7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8339F3C3C01;
	Mon, 23 Mar 2026 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKN8qofn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82483BE15F
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284407; cv=none; b=t7JMb4p8wb7kfE6ZSY1HcrLB2wJgNAXYdq9i4OSbJzSi1KMxACCNsrUeIi1pZ6UvTZi1TJSYScrNsQp5ED+J/l872nXcdUK1kNEAwhIwFumrMFQ979IpOktBZw9+zZbVLWqz899p07zOTxjelIf9kLhW4coOlF00CjpNgCuuAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284407; c=relaxed/simple;
	bh=uT6u28q8xN+HvfAicCvlLrLPXdRQ7Bx/s17nGsTFrHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmKw3kHayMWpqBPnR83yrCUAGmRHWGUqInAnehHEILPgFZ3GdoV9W5KrZVggeuS8wh4p6a/uGzMJLeloyRlHjanhZEOfVZv92Cn+/lsTu0Fep5T6eb59P6T+6LWtFaJUz1uyrFNZGVfpuKZFuOT2KeLTGWdQL0xZVBbw8uHcIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YKN8qofn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486ff201041so24793695e9.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774284403; x=1774889203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMPSjiU3n/bDrZwK2WBMoUe3M4rFzhZbrCZl3W9hGNA=;
        b=YKN8qofnf2P3h96EYPTa3s2HZMUHkJGtqxiKnk6Ng8/4Qp84x6jZvPoTKZsdg0u0lt
         poRnN1k7v4iohr22YBFnCnrMe36Lrt7L5nD6QVuuAH0iHi0HTG9gi24i4mJhoB0NJxx+
         4p6fJ61u1vWKCZtUgGHzD/iPz0WMzWz8WkbyzCdKMVBL4wQIqm+iRErbtJ9a1HfurDOR
         AvA/CQ0dqedDynocrpUJ4tUbmK4GfHVvSkZcz1ep3BMaWPEp1dQeK2CNonTMI7yLDn8N
         EuZ6yyhNVyn03QLB3FSUiptTf1+qg63l0tT8PIBzirFzBzZczFOBvVRCBHkbSu/pEX2w
         8agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774284403; x=1774889203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMPSjiU3n/bDrZwK2WBMoUe3M4rFzhZbrCZl3W9hGNA=;
        b=C/T5FXbpP4xck4Meku0YVBn9b912rYdhABQHuYcI0wsVM5N0WHaN4MBHMEQQg4L4rL
         rpwmda35bbAdS2VqbcWxS3nAI5p4hr0q4Fqdmst/F9iklI6oPSNsawOHWJXmlG02TAri
         VC7rwnj0FoH4gE+Ad6er7r/8mcnG9//il6as7mYeZpIofH7VpMtjgx6tkMmqPpMIYDuT
         546voZuPEoGAoLWae9Kh/MOExDtrqZY2zSDvrfzm1QBJgtkFvsTQH4J0MVhdv8j27Rxo
         VFubJuNdW9eBTgzn0Wbs4EhmN4oIw0nkLCwJt7g98OVanwyskimD7S8xp6UN5bfuFe0/
         cccA==
X-Forwarded-Encrypted: i=1; AJvYcCXbJclbcE4N5BVxTngqmrYpdVLzb8MgJzJh/4YktRhNPa3POa8NgTiu7Ci0Hyn3dRw6ng8Ebp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPvfM80/Au/QLt+obst5t9f50IYFNG6avXbr4TrM/ArzIW/2q
	AuykSGN0BXc2NJnuE4ndSqFfziMOglSZJ+VZtrgDASTmmmHn71WVWEJ+hwo1k+AEqsqGugJUbSN
	SXBhn9NqocA==
X-Gm-Gg: ATEYQzxuzgeY3NW1oiEHrLGl66wfbP7BxoW//41dUFDpL88vCA69LeyKKmKvue8exPd
	qkueQMzDYEl0yc7UY+PtK6oR8z8ghUDs5mVRGCVPMv4zbOmSmp8r6ZmcR9jFESTfW8BGw8WK0W4
	4ZNaGxQo41HObfB7XtWJ4/NyK2S9DxLTgFqgyttudh6k5FHA3Y6nql2Z8/M+EVegQbJ45yxACfZ
	D57ybRLJ5V2gaCLDh4KhQi9SbB0hVStZzFEEuZqRmk5H8BB6t/yVX/xpDJI+pPPvfxggpyDSntH
	2HAwD91c5sQU3toJzXz6kpP61a5+2TCvpBFhNEdk9JuOXTtCPPGjH3heOawOI6eX1Tyt/3LybG6
	3w6G2dSgZYuXIrxN0WYxbDjiHVLlo/xkEOrLosfa8+fGYYf8PRC2MiuFJ2ooRhczkI7ZmJMwUp4
	PO5b7BnlS7ZAO8np0r5Gx1svV2w7yg5ks=
X-Received: by 2002:a05:600c:3b1e:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-486fee1ab10mr180454805e9.24.1774284403113;
        Mon, 23 Mar 2026 09:46:43 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm600421655e9.9.2026.03.23.09.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 09:46:42 -0700 (PDT)
Message-ID: <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
Date: Mon, 23 Mar 2026 18:46:39 +0200
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
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260323135414.GA8437@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_FROM(0.00)[bounces-229973-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D417F2F99AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Jason,

On 3/23/26 3:54 PM, Jason Gunthorpe wrote:
> On Mon, Mar 23, 2026 at 01:09:27PM +0000, Tudor Ambarus wrote:
>> Commit da33e87bd2bf ("iommu: Handle yet another race around
>> registration") introduced a readiness check in `iommu_fwspec_init()` to
>> prevent client drivers from configuring their IOMMUs before
>> `bus_iommu_probe()` has completed.
>>
>> To optimize the replay path, the readiness check was conditionally
>> gated behind `!dev->iommu`:
>>     if (!dev->iommu && !READ_ONCE(iommu->ready))
>>         return -EPROBE_DEFER;
>>
>> However, this assumption breaks down for devices that map to multiple
>> IOMMU instances.
> 
> ?? We don't directly support "multiple IOMMU instances". There is only
> one dev->iommu.
> 
> AFAIK if some drivers need to support multiple different instances of
> the same IOMMU driver they must deal with this fully internally and
> present to the core a "single instance" view.

Thanks for the quick answer. I may miss a few things, I should have
marked this as an RFC. Would you please help me understand a little bit
more on this topic?

Downstream we have a display controller that's using:
	iommus = <&sysmmu_19840000>, <&sysmmu_19c40000>;

These are 2 distinct platform devices, they probe independently, they
each call iommu_device_register() independently.

If I understood you correctly, the downstream driver shall model its
architecture and call iommu_device_register() only once after both
devices are configured.

My downstream reality is different. Here's what I'm encountering:
1/ sysmmu_19840000: dev->iommu is NULL. iommu_fwspec_init() correctly
   evaluates !READ_ONCE(sysmmu_19840000->ready). Assuming it is ready,
   it allocates dev->iommu.

2/ dev->iommu is now NOT NULL. iommu_fwspec_init() is called for the
   second physical instance.

3/ Because of the !dev->iommu gate, the evaluation of
   !READ_ONCE(sysmmu_19c40000->ready) is short-circuited and skipped
   entirely.

But sysmmu_19c40000 is not ready, its specific bus_iommu_probe() is
executing asynchronously on another CPU.

If the core's intent is to strictly enforce a single IOMMU instance,
shouldn't iommu_fwspec_init() be checking
	fwspec->iommu_fwnode == iommu_fwnode
instead of matching the ops? Because the core currently matches on
ops, it permits aggregating multiple physical instances with the
same ops into one fwspec.

Thanks a ton!
ta

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2940,7 +2940,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 		return -EPROBE_DEFER;
 
 	if (fwspec)
-		return iommu->ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
+		return fwspec->iommu_fwnode == iommu_fwnode ? 0 : -EINVAL;
 
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;

