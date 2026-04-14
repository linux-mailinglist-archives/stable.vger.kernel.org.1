Return-Path: <stable+bounces-237736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKBVK7jq3WmulAkAu9opvQ
	(envelope-from <stable+bounces-237736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:20:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3DC3F68A1
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56EF3301A6A1
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53FC35E943;
	Tue, 14 Apr 2026 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqhpidqE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F035E93D
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150736; cv=none; b=Sh60EGiZPUbSUTSq//ruMJKXNmHC4q68WffvTsr+W9VxHpgfYLYhMsaXj0rATeU72LB4GntELBMz2tzL5zkgwizs64d+W7QGYx9N5WSAiwoWtbe8hF5OrwTfSD/KsB0ijwlFGiqWAoZorPUsbD4oxrwjFRVgwmT+G6XfGdRFP6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150736; c=relaxed/simple;
	bh=pc/khuUTh7M50Gs774pXFPkfuOHJz9HSjhJ8TEeqTrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+HiMh8Ghlu/bIXwR1W0PIDe9UjtlynM+mpuZRcukKun5KIGtg/YKwjJOHtmxk5XrNg+cY1zhBuqHEAGJypWQ0OpOBpRFT9exCnazu22/hxwfechYdyCz/fCSd1HV1GJgCmCE7/w1iFfWPl7GRct0sSVWT6N0WN2FUCX0SOqnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqhpidqE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ad135063so49960555e9.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 00:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776150733; x=1776755533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhanaccIGc9hiLH1UN6IYI4Y2aihOg0AcpAQfiO+8sc=;
        b=hqhpidqEStwT0NwwL1oD+WcInDKRiVbovXaKZd8SMkJDGlFEm9ku1lf2KZ+r4sFHac
         8nc+YTRKPweh/Mf2gfPY6b6XhwLHfdLnqEcLtJtn4EA2+z5Gzf1i/7Upcvo3obKOg2MN
         qX5fUzhyRyKfJjTjJWD7x7hYDIXF3GE5Y73EoYXN/8zek5VJtTL4QWRtlD3HPwwlGSTr
         /zv6UZ8ba8b1iM83IVYpgOCEuUHyis2mLR2jbf4Tt7kZbkYwl9uT8Sdr+h9FF0z8wFE9
         MFD+tNWnq7SPz5Q4VHjNzaC/WWQoDWXKH1TDrnxes4wG9eAeb10Hd86iGOAef01cSRde
         NSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776150733; x=1776755533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhanaccIGc9hiLH1UN6IYI4Y2aihOg0AcpAQfiO+8sc=;
        b=gTETOZRyctqmyFmOlJwptgr3saZDda/nX0nHbWF0RH6idTqnD9mGDfaOFbYGuKYfbK
         IPmwVyDpDdNtu2uKTK+k1tjwGJPHXX0CE4dzY2wKUhbYyic1LwoDvDoz+EcLIu5iiHNi
         +rhoef6i8wnsuvHOiDwqFNeptjDvu4yM5mCo6H5XP2IrHXiM02xk0xokFrkbRgoeLZY+
         bsT+1ul4Z7dDx83dXRvchSyAg08iyPQUxfjpdyRGIrvjPfqqDc12KQRHaIF1vMKK5Ms5
         et+2+dOc8c1HuJmPyvjuBLbLi0tF/0VCSTqVV1UtRL/XjHhrXbOg9qBvQ0CBwbg4KvjD
         04Nw==
X-Forwarded-Encrypted: i=1; AFNElJ9oEHF8W1UBUPrIsv38CHuTcnQAxinlz3dBI6gRYP8sTTabxr273OlJwpXw+OXfWrGiJrimGAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdv/naDu0aVUt0WuuncihHVisqcN/xvNOCqIn36gCCdrTDZNjN
	mwpNSR5eJq9coRyY5TRBtCyM9P4bibSV+2k02ZqDkJMZKEA9DCw3xvrY
X-Gm-Gg: AeBDiev8LG8I4gHZeZDj+N2bjpN62ww4anRHGBlyUEwoICEUEwkKpIVrv2Udqtfihz0
	OgxZQFSBPeNLhrf09zh8LvtPgKS9Jg3M6HcNJ4v1I8IjRODRoD+61dzKA1UxzelvCCLjHV8BGLa
	vP3wvdzn9FZyLq62urDJFYjczj1zX8LAuaNTHnKgoxSzxgiKHHzN6AOcRwAPNsI4swB8FlI6udh
	IhOWh7RqGS9VEMmrpCbGrY5g3lw1dol9Jw19Js8Ian7lpZeB7Y0LOJpK1DrchFWZjljqB+Cv4l9
	QzE84gVAoHwIricXruTmMICKFZF4V/4I3hA8DtA2O5zbCmacFbEhgpgmaX30VDG2ueDg9z3rRDV
	LSPEZbcj+OqvEV0K+WWfHh9zz+3lWMf2eUk/ez6xEDnkhq6vqO5wW3fhfgOgeaxn1NnJBiSvWM8
	VNRyxpKugSr+25u72nQNfp/GTiROrk5STL8r2g9hHnVmliliQJuLZqjFPS2HpIGmcI
X-Received: by 2002:a05:600c:8b27:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488d68766c7mr208172865e9.18.1776150733023;
        Tue, 14 Apr 2026 00:12:13 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a53sm38049692f8f.5.2026.04.14.00.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 00:12:12 -0700 (PDT)
Date: Tue, 14 Apr 2026 08:12:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, sathya.prakash@broadcom.com,
 chandrakanth.patil@broadcom.com, stable@vger.kernel.org, Mira Limbeck
 <m.limbeck@proxmox.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3] mpt3sas: Limit NVMe request size to 2 MiB
Message-ID: <20260414081210.2b63e350@pumpkin>
In-Reply-To: <5ecd8d50-d7dc-43a3-b157-8717c6fc02d4@kernel.org>
References: <20260413180003.76489-1-ranjan.kumar@broadcom.com>
	<20260413213335.4010d8f2@pumpkin>
	<5ecd8d50-d7dc-43a3-b157-8717c6fc02d4@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237736-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,proxmox.com:email]
X-Rspamd-Queue-Id: AE3DC3F68A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 05:41:59 +0200
Damien Le Moal <dlemoal@kernel.org> wrote:

> On 2026/04/13 22:33, David Laight wrote:
> > On Mon, 13 Apr 2026 23:30:03 +0530
> > Ranjan Kumar <ranjan.kumar@broadcom.com> wrote:
> >   
> >> The HBA firmware reports NVMe MDTS values based on the underlying drive
> >> capability. However, due to the 4K PRP page size and a limit of
> >> 512 entries, the driver supports a maximum I/O transfer size of 2 MiB.
> >>
> >> Limit max_hw_sectors to the smaller of the reported MDTS and the
> >> 2 MiB driver limit to prevent issuing oversized I/O that may lead
> >> to a kernel oops.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> >> Reported-by: Mira Limbeck <m.limbeck@proxmox.com>
> >> Closes: https://lore.kernel.org/r/291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com
> >> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9b8b84879d4a
> >> Suggested-by: Keith Busch <kbusch@kernel.org>
> >> Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
> >> ---
> >>  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 14 +++++++++++++-
> >>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> >> index 6ff788557294..44dd439e6f17 100644
> >> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> >> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> >> @@ -2738,8 +2738,20 @@ scsih_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
> >>  				pcie_device->enclosure_level,
> >>  				pcie_device->connector_name);
> >>  
> >> +		/*
> >> +		 * The HBA firmware passes the NVMe drive's MDTS
> >> +		 * (Maximum Data Transfer Size) up to the driver. However,
> >> +		 * the driver hardcodes a 4K page size for the PRP list,  
> >                                              ^ buffer ?   
> >> +		 * accommodating at most 512 entries. This strictly limits
> >> +		 * the maximum supported NVMe I/O transfer to 2 MiB.  
> > 
> > Doesn't that make max_fw_entries 4096/8.  
> 
> What is max_fw_entries ?

A mistype for max_hw_sectors :-(

> What the above explains is that a single NVMe page (4K) can store 512 (4096/8)
> PRP entries, each pointing at a 4K nvme page, so 512*4096=2M maximum size.
> 
> > Assuming 4096 byte sectors the longest transfer is then 4096/8*4096.  
> 
> Yes, that's the SZ_2M Bytes.

So write it as (4096/8)*4096

> 
> > So none of this has anything to to with SECTOR_SHIFT.  
> 
> Apparently, nvme_mdts is in bytes, even though the documentation in
> mpt3sas_base.h does not mention anything about its unit. So yes, we need a
> SECTOR_SHIFT to convert that to 512B sectors unit.

It is all very confusing because of the 4k and 512 byte sectors and there
being another 512 constant.
Perhaps the best expression is:
	(4096 /* NVMe page */ / 8) * (4096 /* hw sector size */ >> SECTOR_SIZE)


> 
> >   
> >> +		 *
> >> +		 * Cap max_hw_sectors to the smaller of the drive's reported
> >> +		 * MDTS or the 2 MiB driver limit to prevent kernel oopses.
> >> +		 */
> >> +		lim->max_hw_sectors = SZ_2M >> SECTOR_SHIFT;
> >>  		if (pcie_device->nvme_mdts)
> >> -			lim->max_hw_sectors = pcie_device->nvme_mdts / 512;
> >> +			lim->max_hw_sectors = min_t(u32, lim->max_hw_sectors,
> >> +					pcie_device->nvme_mdts >> SECTOR_SHIFT);  
> > 
> > Why min_t() ?  
> 
> max_hw_sectors is unsigned int and nvme_mdts is u32. Not sure if that bothers
> min(). Worth trying.

It doesn't bother it (any more).

	David

> 
> > 
> > David
> >   
> >>  
> >>  		pcie_device_put(pcie_device);
> >>  		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);  
> >   
> 
> 


