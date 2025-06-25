Return-Path: <stable+bounces-158476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA706AE74BF
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 04:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E889819234A9
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 02:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3EA1A5B8F;
	Wed, 25 Jun 2025 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="p1BqywLx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E081A5BAE
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750818195; cv=none; b=kMin44eizEO6ZJeTH+QJwTSe0sF4tzVI0++6QpqqZgF9fSYgHPFGaFzcB4d8pIMpx5eNE5Envov0lh0ikDfN89wYgM9bhvQYyQRFVZjbaaSuyrNp4Y0CTE7/DRGqBm8amTG+Zx1sBjVTkh/q7K4LLo42bzfTSMGzeIy7bZtYgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750818195; c=relaxed/simple;
	bh=MKAjTRYlVxqAtG1849BRHiqFqIqlivXACuMojh41xy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao497sBtmI4ubvq3bqoyTPZ1GoFrK+VQbBCQL2Vycl+ABJTsUTpzzN9K49+6RY8IIuj5cC+UA5MJHWNU0ykiZfOeN8teJHgor64Bw5x309Ebd2CiS+7+DXlyZHSd5pR86uP+KbG1nWdhZ7KkSEeqaiWi+HT0MXNtAO9rO3kA/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=p1BqywLx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so9853596d6.0
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1750818192; x=1751422992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhVPhW6zAvMo92rhc/bflxjgJ9TsGXieNEe3ODAbCaM=;
        b=p1BqywLxN2fg45QyJpptBzMWlAqDqZoNzaFnQJF93JTxI3CsgIqXYu1WrTscGmL9vK
         ky1R8b5mLYG9/NzqF5EnnnfvyXGGeCHo06N10RUXOREarpHLzlasFuoXXGFhFo5WQp8+
         ILYrfRLEsPKkXYkrrLZXuBIrV/69kVn3X0R+0Uu/GbmPBKdIIGNyEL35Bya3X0pDW3F7
         VcTFqaMC/rCab7R9eyXEz+GQQq2hgGQdbSIQNRV29RcCMTlXTnmzTA9MJRuAQQjm95xq
         7cuIv8iaSEeDthvkkc5/IrXkcw9RxDqHBTwlI2ywc1rla+0eHddwTvOiS0EGBXFR4w6U
         Q1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750818192; x=1751422992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhVPhW6zAvMo92rhc/bflxjgJ9TsGXieNEe3ODAbCaM=;
        b=R8xu9xasWGpHz4NaWsy2jOeYgHTYwkODzpqb4L6E+IqmVyZpf79bnVfvGbrsuhnqgd
         DmcAqOdiJp/kkJtOAca8vpsgqjSpf9rK6q/U/jZwjHrChqrBiUB7hnEO4Dl5QJ2WWalt
         FMrc89HAY2XcRPSIl7u5m28BXQXivSZmNXz5tKk/7W/x/YLBCDsoozNyL3wTBIMgyIyC
         6HWNYevRrIURVIayQIWYtqSSLdpX7ej+ea22WMcrEB9JyB/TdxwgW1uHilZtFReg2w7K
         25R3DWg0CLpynjHEvhLIkWTFTxmETSG9I0l2Wif4NMWEeIV46Ny63DMq8MxdxROhK5je
         DufA==
X-Forwarded-Encrypted: i=1; AJvYcCUNC5BD8w830DKXtAWOW2c6Cz2PELqyriOv8hQeh3B0F0DaAob/PSoQp30UCdO1UhdCI9bKcTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBwVc5VdI+fJOnIRskvgIx6GnX62SPt4kRdgBI3N2rle2ENSh
	iPg26w7xEFJH1feeR0z59XHBJ9/4UJFohpoCMkdNfZc+g0eBZJl+bFr/szA9btHnyw==
X-Gm-Gg: ASbGnctFimOq4Eo1+4FlOH5yB36QTET0xH6aX4wxS0y4+yGHcr/ckGbzh1gZIJ3dsPm
	44DSmt+BGbIpPxqGSnEUQ7p3oeI/whvfDH14IXlFm134sGq+Xj9orMU+0QDD44qKhoO+a4x51Bd
	U4g74P9ntW9A+RKZkFrDp49rDOwH7LlkI3ZOIelWRI7gpC4AHdcqWXZHdldPZ3rcvFM4kI1pQ3U
	fmep5CEAOAJA0vIKWzCvJPdlGQzTfUOhRRmb0/3LFUX1h8yCtSk1WbWyotpzT4HAqG7mdOJrw6X
	fq1pyzKrth6kc4oTbQOYrwV/07ChiWbRJeuLWcnfMvTWN6ERCMvxrZtMbfbT5u8=
X-Google-Smtp-Source: AGHT+IF90HyR81uc5IHzklkKvJbHJLLUAtNNBbUQ9KJUQ3fycjUPEibTbX4sfUwdYIlH5lDfz+oMpA==
X-Received: by 2002:a05:6214:19c6:b0:6fa:9cdb:31a1 with SMTP id 6a1803df08f44-6fd5ef319d0mr17559236d6.1.1750818192146;
        Tue, 24 Jun 2025 19:23:12 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::9ca8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09599c95sm63214026d6.106.2025.06.24.19.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 19:23:11 -0700 (PDT)
Date: Tue, 24 Jun 2025 22:23:09 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org, Ulrich Hecht <uli@fpond.eu>,
	Pavel Machek <pavel@denx.de>, Bart Van Assche <bvanassche@acm.org>,
	Yi Zhang <yi.zhang@redhat.com>, stable@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH for 4.4] scsi: core: Remove the /proc/scsi/${proc_name}
 directory earlier
Message-ID: <8187ad4f-32e5-4768-8286-984c5b31845b@rowland.harvard.edu>
References: <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>

On Wed, Jun 25, 2025 at 11:00:26AM +0900, Nobuhiro Iwamatsu wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> commit fc663711b94468f4e1427ebe289c9f05669699c9 upstream.
> 
> Remove the /proc/scsi/${proc_name} directory earlier to fix a race
> condition between unloading and reloading kernel modules. This fixes a bug
> introduced in 2009 by commit 77c019768f06 ("[SCSI] fix /proc memory leak in
> the SCSI core").
> 
> Fix the following kernel warning:
> 
> proc_dir_entry 'scsi/scsi_debug' already registered
> WARNING: CPU: 19 PID: 27986 at fs/proc/generic.c:376 proc_register+0x27d/0x2e0
> Call Trace:
>  proc_mkdir+0xb5/0xe0
>  scsi_proc_hostdir_add+0xb5/0x170
>  scsi_host_alloc+0x683/0x6c0
>  sdebug_driver_probe+0x6b/0x2d0 [scsi_debug]
>  really_probe+0x159/0x540
>  __driver_probe_device+0xdc/0x230
>  driver_probe_device+0x4f/0x120
>  __device_attach_driver+0xef/0x180
>  bus_for_each_drv+0xe5/0x130
>  __device_attach+0x127/0x290
>  device_initial_probe+0x17/0x20
>  bus_probe_device+0x110/0x130
>  device_add+0x673/0xc80
>  device_register+0x1e/0x30
>  sdebug_add_host_helper+0x1a7/0x3b0 [scsi_debug]
>  scsi_debug_init+0x64f/0x1000 [scsi_debug]
>  do_one_initcall+0xd7/0x470
>  do_init_module+0xe7/0x330
>  load_module+0x122a/0x12c0
>  __do_sys_finit_module+0x124/0x1a0
>  __x64_sys_finit_module+0x46/0x50
>  do_syscall_64+0x38/0x80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Can you or Bart please explain in more detail the race that causes this 
problem, and add that description to the changelog?  Also, explain how 
this patch fixes the race.

Alan Stern

> Link: https://lore.kernel.org/r/20230210205200.36973-3-bvanassche@acm.org
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 77c019768f06 ("[SCSI] fix /proc memory leak in the SCSI core")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  drivers/scsi/hosts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index c59b3fd6b361..7ffdebdd9c54 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -173,6 +173,7 @@ void scsi_remove_host(struct Scsi_Host *shost)
>  	scsi_forget_host(shost);
>  	mutex_unlock(&shost->scan_mutex);
>  	scsi_proc_host_rm(shost);
> +	scsi_proc_hostdir_rm(shost->hostt);
>  
>  	spin_lock_irqsave(shost->host_lock, flags);
>  	if (scsi_host_set_state(shost, SHOST_DEL))
> @@ -322,6 +323,7 @@ static void scsi_host_dev_release(struct device *dev)
>  	struct request_queue *q;
>  	void *queuedata;
>  
> +	/* In case scsi_remove_host() has not been called. */
>  	scsi_proc_hostdir_rm(shost->hostt);
>  
>  	if (shost->tmf_work_q)
> -- 
> 2.25.1
> 
> 

