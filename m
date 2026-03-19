Return-Path: <stable+bounces-227373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJg4KrxNvGkXwwIAu9opvQ
	(envelope-from <stable+bounces-227373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 20:25:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9CE2D1A2D
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BB6309BE8A
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FAB37AA72;
	Thu, 19 Mar 2026 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC7q16Lb"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016034D903
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948330; cv=none; b=Br+ZxP/UBUDaY0V++QwY+kb5rQwtfmNtWa66lkw1shGs0IEUfUd0PpwFQrqDF9JALkEGb3HEqD0dGeuMcqFPUJN1FLj/QCWukMxCfEkR3pybGDTsIho0W8Z7Lbt7eV/U8oeWknZBuWmswSu2R6mvmmfA3o91JfUH3Yp8x/g5+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948330; c=relaxed/simple;
	bh=iUslfBDUCNoekXPcVJL0Qmdad7Ch9Oo8SMzHnAFW4Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJGlAtioQ4aVGozMIoM/dVanzKLQFvgSzojuA/jXqOk5qZF8G3GROWqU9pHERvKBALuaZ/TpHqxFgLISvQgeGGpVdsO45dKaDRvWnm3D3miMUrHAKCJEcBSH35LziGBZ62OYg4t/nMDehXGDlA+nHBDHGB9lm68Ecv2jGkFNt50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC7q16Lb; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12732e6a123so2116738c88.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773948329; x=1774553129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=poRUHSD6rTCFS1gx0Ihn5EiVXgymtADueoMvkmlPFWQ=;
        b=bC7q16Lb/3k16llW3rpLs7GM1x8FcvJaFPaeNr0GGOS1dKceSVbUg+lV1Er1OvY5YO
         HqQuNcK9nXhiUYaCM6XMH056sB7HFWuA6+rxNPY9Pczqiea+vksKPqgJh8aH+ka7WcED
         qKwj5AheBz9alFBuVTAtJ0hDuH7t0NE9/H9LlnF5VJHVxt/ksJsExhTyHztHVf/N8Mqa
         MRdXDDU4HkpbMrdi0qZUVM2quregbnqPRbTKgjNKfYqnf6ER4qtpEe4h+9ZJC/zUuvs5
         kYjb9W3AQmHa6e2irobHjlgK+kuOQc0SiuOuIcBck64WlTNqBITC3MMnggzDi8uTsHpp
         ACRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773948329; x=1774553129;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poRUHSD6rTCFS1gx0Ihn5EiVXgymtADueoMvkmlPFWQ=;
        b=cJAozy5FzxkKmRpwsszC5nDzRYWRIlt4Z+ujRwSJwIrlDx6HpWEsMVTaiWijP7uSAI
         A7WDoBGdhU41J6kQbKclP6tZtRQjpb4xZGQa1DgWDc1aGtFSNYE4eC16syaow8+vxoUt
         8a1cX6jEkFMdxSg72mTeAYSQVIQZ/QPlLC/49Jk50Ve4TohAxiA8uuLDQIsF2zqSdRT9
         0WbwDcEjjFbo+/h78j99CkWjaX4l0xH0pL5sdSjq9u54xyiM+jwldJvDbDRCcser19y0
         dV05IVmIgoX5mN7vI/wr+3QBo8k25st4TM2C59zmJ0zSMU+X1sg2UPntFdaKqjSJKJ4V
         hYRg==
X-Forwarded-Encrypted: i=1; AJvYcCVxZNtDnldc4O1tXzGg7KBM3+5jTV2XHw44BHkzP4Ctom2qbMYt2Av2IgdoanWBGg15zQs45x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/BCpdlOEnhRoTR6vx4MkQs7rlnsdv0iCjaKS53FnE6DWSyKa
	OMmCUzmZV8+SoXPmT5IjdNZSVWg508SU+rRP433fU/omYitr74jIlkFS
X-Gm-Gg: ATEYQzw8qqZihAfT9HH3L2DC0FMVCFYc1u8+R5jbLZSDVFOeSRTo5/XqzKVwAT3ShhW
	Pd1634KBsRqoE54Xh+0ypVAAgm1Gw5Ehxt9+8KCSuj1KckiQjzWYgxeafYUDR6j1Hi7dkVBSh25
	U9k1I4WbEV0CrZS/DxUktjOPahso4XUYGFsEhRm2qoiVcZHkk18xlNGthMcLkfVNrf+3zEPTu7R
	jDfFUlu/b3JNylkbxZM1MmAOYy76+AG20/lad3+T3ve9RaKY1V4IsGiSKhQRSYO33hzfvH3oSJm
	A/wZc6JsNxTU9zbTu6GA7/Pzr/1oUAMJ/gnuzbMZFx0NpG8VFldpnzj5D5wviVrNvyINDJ7XrKg
	cmo9RAapIfmfx85E6kRAAzc5tZFJG+GbzTWEBECsxymr23NdDoarizV0rPtczdPe4eqnNt1A68X
	+oJSh3roI0nuLT26RPGU5UP4vNOyaevmNDdJtTW92SVmMSjUkPSsereTneebRKKu1BeeKenQMx
X-Received: by 2002:a05:7022:628c:b0:128:cf5c:5352 with SMTP id a92af1059eb24-12a7266f502mr176456c88.4.1773948328573;
        Thu, 19 Mar 2026 12:25:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b4127b7esm11628826c88.9.2026.03.19.12.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 12:25:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fdf45531-3a62-49ec-bcc7-fb6dbaa01b2f@roeck-us.net>
Date: Thu, 19 Mar 2026 12:25:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA
 deadlock
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, bblock@linux.ibm.com,
 lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
 dtatulea@nvidia.com, mani@kernel.org, lukas@wunner.de, kbusch@kernel.org,
 ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
 michal.wajdeczko@intel.com, piotr.piorkowski@intel.com
References: <20260318210316.61975-1-ionut.nechita@windriver.com>
 <f17b03652a84be73c1d3a2cfea8a016dab99f8e0.camel@linux.ibm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <f17b03652a84be73c1d3a2cfea8a016dab99f8e0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227373-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,mageta.org,nvidia.com,wunner.de,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,intel.com];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:email]
X-Rspamd-Queue-Id: 0F9CE2D1A2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 05:31, Niklas Schnelle wrote:
> On Wed, 2026-03-18 at 23:03 +0200, Ionut Nechita (Wind River) wrote:
>> From: Ionut Nechita <ionut.nechita@windriver.com>
>>
>> Hi Bjorn,
>>
>> This is v10 of the fix for the SR-IOV race between driver .remove()
>> and concurrent hotplug events.  v10 adds a second patch to fix the
>> AB-BA deadlock between device_lock and pci_rescan_remove_lock that
>> was reported by Guenter Roeck (via Google's AI review agent) and
>> confirmed by Benjamin Block.
>>
>> The AB-BA deadlock:
>>
>>    CPU0 (remove_store)               CPU1 (unbind_store)
>>    --------------------              --------------------
>>    pci_lock_rescan_remove()
>>                                      device_lock()
>>                                      driver .remove()
>>                                        sriov_del_vfs()
>>                                          pci_lock_rescan_remove()  <-- WAITS
>>    pci_stop_bus_device()
>>      device_release_driver()
>>        device_lock()                                               <-- WAITS
>>
>> Patch 2/2 fixes this by calling device_release_driver() in
>> remove_store() before pci_stop_and_remove_bus_device_locked(), so
>> that the driver is already unbound when pci_rescan_remove_lock is
>> acquired. Both paths then take locks in the same order: device_lock
>> first, then pci_rescan_remove_lock.
>>
>> Note: the concurrent unbind_store + hotplug-event case (where the
>> hotplug handler takes pci_rescan_remove_lock before device_lock)
>> remains a known limitation.  This is a pre-existing issue that
>> Benjamin Block is addressing separately in:
>>    https://lore.kernel.org/linux-pci/354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com/
>>
> --- snip ---
>>
>> Ionut Nechita (2):
>>    PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
>>      sriov_add_vfs/sriov_del_vfs
>>    PCI: Fix AB-BA deadlock between device_lock and
>>      pci_rescan_remove_lock in remove_store
>>
>>   drivers/pci/iov.c       |  9 +++++----
>>   drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
>>   drivers/pci/probe.c     | 11 +++++++++--
>>   3 files changed, 33 insertions(+), 7 deletions(-)
>>
>> --
>> 2.43.0
> 
> Hi Ionut,
> 
> For your awareness, I saw that this series has some findings on
> Google's new Sashiko AI reviewing tool[0]. At a quick glance the
> findings seem like at least reasonable concerns to me. I'm still
> looking at this independently also of course.
> 

It is almost scary to see how many problems Sashiko is able to find.
The AB-BA deadlock that the second patch in the series tries to fix
was reported by a prototype version of it when running it on an LTS
backport.

Guenter


