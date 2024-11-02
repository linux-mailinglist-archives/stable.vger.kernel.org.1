Return-Path: <stable+bounces-89558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8989B9EDA
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 11:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41D51C22E9A
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F9C16E89B;
	Sat,  2 Nov 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARQiyEPy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2544EB50
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542879; cv=none; b=Z1MrRSuYzn2dXkhhT5JBCff3DmcySzTqhxmXmEJhmfZCgmPohXX/UENg8bl31plDDci1J9mYIb7Plp5pDHGpV8E/7On/oAyk0KqceEK1h7BGFXpqxot58Dliurw+UBiyVkEbNgT/vSxH2yDRsKVZhxiRmoshlmyPe805SIFBegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542879; c=relaxed/simple;
	bh=ZOodgR/d4O54xFowCK3n036fWi1j1ukK7pPlAioRzzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m955pVFQ1ajBY7F98SRBP/F0znY7KKcTJflwtyeUio7cqmyyaVFcqpG5szfVy3o0ekOiWsuytyI6/znAXZv/uioEMiZ0+EHa6OHmQ+rBIwGjD/5GaNkIXMUACQhycvQwJ01He47RUKdYedCZbDTeyQTfQJcy0MyurE7SmBWlj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ARQiyEPy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso1528680a12.3
        for <stable@vger.kernel.org>; Sat, 02 Nov 2024 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730542877; x=1731147677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w9mwOpHSxODzjR4q2gkwlcsshDXVuzZCm5e0SLSUeV4=;
        b=ARQiyEPyvwzojAVH24SJ2o5MUQz8s4xkChTHwPyQcRZKEYeenwcbcBT24Gxg6LHSHZ
         eNfoObhZ5mWGxYZ5i5ns5pTqOkxCi73Ph6sQEoM5C4uVt1yW0JCI4j/TEuck6TW5Edp8
         ExvCmdb+ljHINH320ROUan6C2MNo/DNW2K9HlsvSRQUKiPoUse9RBTqhEyiL9dopi4Pc
         vMrNFWD09EqIYlWDz4eji9BhO461dND2WzLNw69t0wykw0PyM3tC9GW8xu7//0Qe+FFm
         bwpqDGg2AVxmvwCABEp/U8TLysOoxUIPdW+54kug2LCR8ZaZ6Yr6pTYo8b8DflFUmWMA
         bZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730542877; x=1731147677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9mwOpHSxODzjR4q2gkwlcsshDXVuzZCm5e0SLSUeV4=;
        b=tvEstWhOAx6tWWjJTvzgUKY7XmBQOSCj3Jx4ykZ0ClaL+bNGmXrm5Yl+J4Mrz+046v
         euRAyfETYkiRenzIA3z9d1dNOLutCu2jncWsBbjmW5j6nptOaNviX5g0BKubMDul8wYR
         e9hEsx0A2YgcXEthXdS6ZlBmpctRPn3o2em/YvdhVcSLUrdfJUZwKfDr/D+aeUMMWRXS
         iTCsvSIV13Kc26R//TY2wzow8DHkdL/c/NeF6J8nYyNKm4raa2M+JTF6mUCjoizZLH+Q
         fkcFU+HIQvzfSewMj/05Va9yG0XR0GBPk2SJwxqB8fJDYi/FC71HYxbD5/CpYGm8Ii30
         +A5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXprk4GqchSHf2R7nw3VQJQCCZ4y1bBFfyZ5NKy0K9E8Oxjav1fAFj4CUOHj93Y8g3bO/Sx9oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3Is+RI2dOUCw52pyctYI8RxhPqzx5bjRMfCY/EiEmtPz0SWd
	R1hOLjWCLEMhfq2M7WqunOS4szLLPI6lx5DEupKH69ULNAaCVdh1I0edgD9kGA==
X-Google-Smtp-Source: AGHT+IFQCMS+POsjhJnQMJVJG/NE/hbjOr+SRMbBRpwX75NFlHjZyZ5RYkHfcl7EplG04iGXXvnk5w==
X-Received: by 2002:a17:90b:1bc8:b0:2e2:bd72:543d with SMTP id 98e67ed59e1d1-2e93c31ef6cmr11561510a91.41.1730542877009;
        Sat, 02 Nov 2024 03:21:17 -0700 (PDT)
Received: from thinkpad ([220.158.156.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93dac0150sm4036470a91.25.2024.11.02.03.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 03:21:16 -0700 (PDT)
Date: Sat, 2 Nov 2024 15:51:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bean Huo <beanhuo@micron.com>, stable@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Avri Altman <avri.altman@wdc.com>,
	Maramaina Naresh <quic_mnaresh@quicinc.com>,
	Mike Bi <mikebi@micron.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Luca Porzio <lporzio@micron.com>
Subject: Re: [PATCH] scsi: ufs: Start the RTC update work later
Message-ID: <20241102102108.zmoj7rq53ffr3gnj@thinkpad>
References: <20241031212632.2799127-1-bvanassche@acm.org>
 <20241101075309.wvfv2fcjeuimcihj@thinkpad>
 <116df065-ab9a-46e2-90eb-9ae5f5f01b70@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <116df065-ab9a-46e2-90eb-9ae5f5f01b70@acm.org>

On Fri, Nov 01, 2024 at 09:31:27AM -0700, Bart Van Assche wrote:
> On 11/1/24 12:53 AM, Manivannan Sadhasivam wrote:
> > On Thu, Oct 31, 2024 at 02:26:24PM -0700, Bart Van Assche wrote:
> > > The RTC update work involves runtime resuming the UFS controller. Hence,
> > > only start the RTC update work after runtime power management in the UFS
> > > driver has been fully initialized. This patch fixes the following kernel
> > > crash:
> > > 
> > > Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> > > Workqueue: events ufshcd_rtc_work
> > > Call trace:
> > >   _raw_spin_lock_irqsave+0x34/0x8c (P)
> > >   pm_runtime_get_if_active+0x24/0x9c (L)
> > >   pm_runtime_get_if_active+0x24/0x9c
> > >   ufshcd_rtc_work+0x138/0x1b4
> > >   process_one_work+0x148/0x288
> > >   worker_thread+0x2cc/0x3d4
> > >   kthread+0x110/0x114
> > >   ret_from_fork+0x10/0x20
> > > 
> > > Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > Closes: https://lore.kernel.org/linux-scsi/0c0bc528-fdc2-4106-bc99-f23ae377f6f5@linaro.org/
> > > Fixes: 6bf999e0eb41 ("scsi: ufs: core: Add UFS RTC support")
> > > Cc: Bean Huo <beanhuo@micron.com>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > 
> > Bart, Thanks for the fix! While looking into this patch, I also found the
> > weirdness of the ufshcd_rpm_*() helpers in ufshcd-priv.h. Their naming doesn't
> > seem to indicate whether those helpers are for WLUN or for HBA. Also, I don't
> > see the benefit of these helpers since they just wrap generic pm_runtime*
> > calls. Then there are other open coding instances in the ufshcd.c. Like
> > 
> > pm_runtime_suspended(&hba->ufs_device_wlun->sdev_gendev)
> > pm_runtime_set_active(&hba->ufs_device_wlun->sdev_gendev)
> > 
> > Moreover, we do check for the presence of hba->ufs_device_wlun before calling
> > ufshcd_rpm_get_sync() in ufshcd_remove(). This could be one other way to fix
> > this null ptr dereference even though I wouldn't recommend doing so as calling
> > rtc_work early is pointless.
> > 
> > So I think we should remove these helpers to avoid having these discrepancies.
> > WDYT?
> 
> Hi Manivannan,
> 
> In the context of the Linux kernel, in general, one-line helper
> functions are considered questionable. In this case I prefer to keep the
> helper functions since these encapsulate an implementation detail,
> namely that the WLUN sdev_gendev member is used to control runtime power
> management of the UFS host controller.
> 

IMO this encapsulation is causing confusion since we have a separate PM handling
for the UFS controller itself.

> Checking whether or not the hba->ufs_device_wlun pointer is NULL from
> the ufshcd_rtc_work() function would be racy since that pointer is modified
> from another thread. So I prefer the patch at the start of this
> thread instead of adding a hba->ufs_device_wlun pointer check.
> 

Absolutely! I just pointed out it as a bad example which one could think of due
to these helpers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

