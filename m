Return-Path: <stable+bounces-139122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3CAA467A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 11:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB671BC048E
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CA821D3F8;
	Wed, 30 Apr 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4kYwgVh"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5A21C161
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004216; cv=none; b=R0YLoAFwJpHf0trRKog85Oz9Rwy0XmcG+fr/vjlFVMNepUyACLzLDjR+sG6Fhw/eEOH5FnsASaJ98n0wat/HTAjnZfF9CmCMmaZOeYFJt8icAdWhqfhTBdKXmot8MgByygm/vcc+a9CRkpS1naiQletJ4E+ckmEafhU1+TOBY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004216; c=relaxed/simple;
	bh=igMUEO2jdAMJa66FnKgZHk74FDW367SkId7b0Aj61PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTlhRoCieIavTINQIuF7myk8w3axuFqZFReTU4gxHDzBmegqtur5ripVY1xzjSlohkBRc8oRncMaS4KKQprEJhE89mE11p8hy8U7hZat06vCJ/I/o0V26Z4PTKy3iVoeMhZCRdgyWdUuD5zEl7uhC2BhwSkas7vV9m2lfg1fayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4kYwgVh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746004213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBM8h9GXkd4oRheqBQptKlBrFr1ALhS3777dATJTzNQ=;
	b=N4kYwgVh1m05hL0ewz737lPHK6imuCEIm49pHySaVIeQXcoG6Frf6JT7ZSmGvX8qIuKLfk
	k6DmFKUPQt+dbBvi4pQ1RWnE6AfiaLWPnbyZOeSy1L/nGIqnJQAzGsTH9ApjKp1JAcLqEV
	AbwL16RpBIaxjVnQ24NIlCCargOxa18=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-3FdKXS-WPiOtLQkda9Xrnw-1; Wed, 30 Apr 2025 05:10:11 -0400
X-MC-Unique: 3FdKXS-WPiOtLQkda9Xrnw-1
X-Mimecast-MFC-AGG-ID: 3FdKXS-WPiOtLQkda9Xrnw_1746004210
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac710ace217so503526466b.1
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 02:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746004209; x=1746609009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBM8h9GXkd4oRheqBQptKlBrFr1ALhS3777dATJTzNQ=;
        b=Jp5jlgqb6+q+0Bg3c1jk4C4iVwgA5Kcbp7Y8Tz+kunMtHz0KPPXjQdmUdVvp8eVcwJ
         woDyM32fhdt+c240n4PZmHYiL1T27oJxSNPGh1RveT2fCol1CSU4/qleG1l2XCvjohg1
         9IUXoh+wq3SbfvzYT20XCFyZGltjAIhlG+KTBgyt5QZV3qsLd9jzVTnAOupdm3kuaHCH
         p+lJ/zysJEz2fUFH8pImE9VXfhF1OVNQWBW746esXN7K4UwxVxVmmRBK+Ixh1ofITvr7
         ov/iJupr6i7NkFMId4d6FTcC8x934z4Mx51fgXw97oulRKVPl7mXsSRVaWSQX1R+xyl6
         D2OA==
X-Forwarded-Encrypted: i=1; AJvYcCU5WNJHFRWBCSxxsOEePV24mjMZl4yZHlslztgN6CdNDuaM83chSDtn753dV4bhMINM9KMD0K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyyrVpotQ0URE9HWvccH2siBFTR5miqbe5UQRpT4UsqrHhb4Rm
	YxTUrjQZYym0tWEC0F8tdfiUNRl1UUcte06xTiFQPxCxYoDA1KfRI/xxfw6+OI42zTT7iOpegnH
	2cPCgjF+fVLTXWzIApPU7zkOdBDHDjoGFQZVZBsdUv4eamdwVb4xPfA==
X-Gm-Gg: ASbGncttNKaLQW5jCLc9xAkuMjzxUuB72b0/SsE3oOW+liX3dgbCL/wBTj/WDbfN67G
	+j3R9TH2U4nkrIpm7QHMI+UF6scX6D46UpLm4sutrG5qPCOiwg6D5EQD79T1jdHbcKapOPD/Ugd
	NzI+2poJgrtrBfnlI7cZedd9uyFUrh/QNT9cmw4eGgARaQo047XFdmv/p/GnxiSAIx5MC2Lxmzs
	cij6OmH8bHn8AwtB0U12yZbKkB3BIwy6c6gmar7lGDwMfhn0g5AUR52o7hv8rwQdJ8nwnyHWSO/
	BlGel74Z0icSvyJ35Q==
X-Received: by 2002:a17:907:7b82:b0:aca:aeb4:9bd6 with SMTP id a640c23a62f3a-acedc574a4cmr220066466b.10.1746004209570;
        Wed, 30 Apr 2025 02:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBMPamEhDPbDLqOXiGcIZesC1dmK+7e+0MqQ1tv9XUC/crH+ZQmawf9DLNdOJwg2QfTaPusw==
X-Received: by 2002:a17:907:7b82:b0:aca:aeb4:9bd6 with SMTP id a640c23a62f3a-acedc574a4cmr220063766b.10.1746004208996;
        Wed, 30 Apr 2025 02:10:08 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acebe7a4ee8sm313299266b.74.2025.04.30.02.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:10:08 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:10:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 13/21] vhost_task: fix vhost_task_create()
 documentation
Message-ID: <n2c3bjkh4jbzm2psd4wfrxzf5wdzv2qihcnds5apfgfyrojhyd@l6p47teppn62>
References: <20250429235233.537828-1-sashal@kernel.org>
 <20250429235233.537828-13-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250429235233.537828-13-sashal@kernel.org>

On Tue, Apr 29, 2025 at 07:52:25PM -0400, Sasha Levin wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>[ Upstream commit fec0abf52609c20279243699d08b660c142ce0aa ]
>
>Commit cb380909ae3b ("vhost: return task creation error instead of NULL")
>changed the return value of vhost_task_create(), but did not update the
>documentation.
>
>Reflect the change in the documentation: on an error, vhost_task_create()
>returns an ERR_PTR() and no longer NULL.
>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>Message-Id: <20250327124435.142831-1-sgarzare@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> kernel/vhost_task.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

It looks like 6.6 doesn't contain commit cb380909ae3b ("vhost: return 
task creation error instead of NULL") so I think we should not backport 
this.

BTW, this is just a fix for a comment, so not a big issue if we backport 
or not.

Thanks,
Stefano

>
>diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
>index 8800f5acc0071..0e4455742190c 100644
>--- a/kernel/vhost_task.c
>+++ b/kernel/vhost_task.c
>@@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
>  * @arg: data to be passed to fn and handled_kill
>  * @name: the thread's name
>  *
>- * This returns a specialized task for use by the vhost layer or NULL on
>+ * This returns a specialized task for use by the vhost layer or ERR_PTR() on
>  * failure. The returned task is inactive, and the caller must fire it up
>  * through vhost_task_start().
>  */
>-- 
>2.39.5
>


