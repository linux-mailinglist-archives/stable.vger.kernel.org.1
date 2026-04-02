Return-Path: <stable+bounces-232910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCjlJUX0zWlLjgYAu9opvQ
	(envelope-from <stable+bounces-232910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:44:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1525F383B94
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8443B30254DE
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 04:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1B936657B;
	Thu,  2 Apr 2026 04:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ineCa20N"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B393366800;
	Thu,  2 Apr 2026 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775105069; cv=none; b=nVsTozOBVbACzGy9ulOQW529os7RgLzSlGJGFwGCnMK4QuX07pm+ijhs5sY2QkvIE4v5RBSqxE7AiCJuTgpjpHiZtPiaTt+RZBSfeTBnhUUlp8BaQbG8JnC1XdsjtvleenO0DI9cGA7FiH9njvi4r9N46WtR3Skj8ngFmkrxru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775105069; c=relaxed/simple;
	bh=5jZatumzTwetQf+a59y3hc8iMuwSoHglSHKuz1ZMO6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oa9VqMieORR57wo3A5xq8PTQHuUPWUghuleI+Cpbtptm1oN2qNFDf413rc7w93saCK2bg+v4OhTr88TQohUGwhCH6VmpqhKjRqq9q1RD9zOZW1ZRPSpd/IUNjY4u8KLpIpJse70tw+gC67/mm/He3sNTa88Wo3TICk2CzjsH/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ineCa20N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.12] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2534420B710C;
	Wed,  1 Apr 2026 21:44:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2534420B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775105068;
	bh=RcOVBpXNTnGFlAFScnVQtoQRFGOne0v6JKfhc+RakUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ineCa20NM4HZqc0TncOKDKzndmknUsUaT4SESR1NpsC+/YiPuCXiNRVDZEyXScrOF
	 dD/RjraEHSzAd7ujlfenUYiUHVJgvMIVtCufOQ2T/D5W8edCY0Ms1ktYHvKJI3o4TR
	 UaAmQBhgjSwwUu2dmhQ/DxmVthOuMti2ZgrMcHgA=
Message-ID: <12005a02-a1cd-46ca-8782-c727a7d5e5c6@linux.microsoft.com>
Date: Thu, 2 Apr 2026 10:14:24 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/cdx: Fix NULL pointer dereference in interrupt
 trigger path
To: Alex Williamson <alex@shazbot.org>, "Gupta, Nipun" <nipun.gupta@amd.com>
Cc: nikhil.agarwal@amd.com, pieter.jansen-van-vuuren@amd.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
 <e9f01579-fd53-50b9-996b-cd1d3342f453@amd.com>
 <20260401122254.363d93c2@shazbot.org>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20260401122254.363d93c2@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232910-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptsm@linux.microsoft.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1525F383B94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 01-04-2026 23:52, Alex Williamson wrote:
> On Wed, 1 Apr 2026 15:11:17 +0530
> "Gupta, Nipun" <nipun.gupta@amd.com> wrote:
> 
>> On 20-03-2026 15:49, Prasanna Kumar T S M wrote:
>>> Add validation to ensure MSI is configured before accessing cdx_irqs
>>> array in vfio_cdx_set_msi_trigger(). Without this check, userspace
>>> can trigger a NULL pointer dereference by calling VFIO_DEVICE_SET_IRQS
>>> with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE flags before
>>> ever setting up interrupts via VFIO_IRQ_SET_DATA_EVENTFD.
>>>
>>> The vfio_cdx_msi_enable() function allocates the cdx_irqs array and
>>> sets config_msi to 1 only when called through the EVENTFD path. The
>>> trigger loop (for DATA_BOOL/DATA_NONE) assumed this had already been
>>> done, but there was no enforcement of this call ordering.
>>>
>>> This matches the protection used in the PCI VFIO driver where
>>> vfio_pci_set_msi_trigger() checks irq_is() before the trigger loop.
>>>
>>> Fixes: 848e447e000c ("vfio/cdx: add interrupt support")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
>>
>> Acked-by: Nipun Gupta <nipun.gupta@amd.com>
> 
> It's an improvement, but I think it also highlights that interrupt
> setup for vfio-cdx devices is racy.  I think it should adopt a mutex on
> the vfio_cdx_device that is acquired with a guard in
> vfio_cdx_set_irqs_ioctl().  That would make config_msi stable for this
> test.  Thanks,
> 
> Alex

This patch is fixing a specific problem. User space can make VFIO_* 
calls in a specific order to trigger NULL pointer access. This will not 
get fixed with a mutex.

Regards,
Prasanna Kumar

