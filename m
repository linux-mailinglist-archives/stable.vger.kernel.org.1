Return-Path: <stable+bounces-141806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F6AAAC42D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 14:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDA416A415
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355B927FD5A;
	Tue,  6 May 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGcgRDnF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554A280313
	for <stable@vger.kernel.org>; Tue,  6 May 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534514; cv=none; b=slKzydHTgGM/23i98TyXJL9Hb2z1pZujZ8XxFjQxg72xyabrByYb5vBIiuST955Lj4IxTfW64altfgDNVvxjiw8c2KkuUOWXtzFvYPnupBJaeXAPJs0Y3NAhAZ77CF62/nnulnQ/zFJa01M+sckoprVHOAMe2kP+MnnoAeH9Oq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534514; c=relaxed/simple;
	bh=svjgCeA4okvl7uFO2WfawpA/ktNJ2XCIYkBBNa1uT1k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZikXkhZEVCra8KAmXXwQkFaXvckY8QnrTIS/MC5RBwiuAUL0+ASs+21LQLDauPP2ovhVn5j9DNMSbcJIM+Eaj5kPzD/su2FuEKyP/p+pcQhc52AoCg2Y3wsH6FmLHc+kGnxW3Rlm9C3HOKUkW3BxZGDKJo+WZFj1eQkPjdYvFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGcgRDnF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746534510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RqHIHWGcV5oq3BR6dRROKyVGbZDU2ZQtpUE9Q3QM1c=;
	b=PGcgRDnFWTsLr/iuOFn4qTuxlY08r2ctMaG/sb6+GfqUarUWACRxF1bXFdNv2lQFjsiKyT
	xk6bgmFpTN3RrMBRw9BrRhg1uwjpL182EkLizRGWwlOhN2i2maxnKUQmE1DOGypzoM/31i
	9XxezwhKZFYZUAlJgeyQk0ImBc5Fumg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-9m9TwKlAPGe_uChjA179IQ-1; Tue,
 06 May 2025 08:28:27 -0400
X-MC-Unique: 9m9TwKlAPGe_uChjA179IQ-1
X-Mimecast-MFC-AGG-ID: 9m9TwKlAPGe_uChjA179IQ_1746534506
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2B33186A72A;
	Tue,  6 May 2025 12:28:18 +0000 (UTC)
Received: from [10.22.80.45] (unknown [10.22.80.45])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44F4519560AF;
	Tue,  6 May 2025 12:28:16 +0000 (UTC)
Date: Tue, 6 May 2025 14:28:13 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dm: fix copying after src array boundaries
In-Reply-To: <20250506-dm-past-array-boundaries-v1-1-b5b1bb8b2b34@linaro.org>
Message-ID: <f9f3b82e-dd37-eff8-3718-1b71746e8c01@redhat.com>
References: <20250506-dm-past-array-boundaries-v1-1-b5b1bb8b2b34@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Tue, 6 May 2025, Tudor Ambarus wrote:

> The blammed commit copied to argv the size of the reallocated argv,
> instead of the size of the old_argv, thus reading and copying from
> past the old_argv allocated memory.
> 
> Following BUG_ON was hit:
> [    3.038929][    T1] kernel BUG at lib/string_helpers.c:1040!
> [    3.039147][    T1] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> ...
> [    3.056489][    T1] Call trace:
> [    3.056591][    T1]  __fortify_panic+0x10/0x18 (P)
> [    3.056773][    T1]  dm_split_args+0x20c/0x210
> [    3.056942][    T1]  dm_table_add_target+0x13c/0x360
> [    3.057132][    T1]  table_load+0x110/0x3ac
> [    3.057292][    T1]  dm_ctl_ioctl+0x424/0x56c
> [    3.057457][    T1]  __arm64_sys_ioctl+0xa8/0xec
> [    3.057634][    T1]  invoke_syscall+0x58/0x10c
> [    3.057804][    T1]  el0_svc_common+0xa8/0xdc
> [    3.057970][    T1]  do_el0_svc+0x1c/0x28
> [    3.058123][    T1]  el0_svc+0x50/0xac
> [    3.058266][    T1]  el0t_64_sync_handler+0x60/0xc4
> [    3.058452][    T1]  el0t_64_sync+0x1b0/0x1b4
> [    3.058620][    T1] Code: f800865e a9bf7bfd 910003fd 941f48aa (d4210000)
> [    3.058897][    T1] ---[ end trace 0000000000000000 ]---
> [    3.059083][    T1] Kernel panic - not syncing: Oops - BUG: Fatal exception
> 
> Fix it by copying the size of src, and not the size of dst, as it was.
> 
> Fixes: 5a2a6c428190 ("dm: always update the array size in realloc_argv on success")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/md/dm-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 9e175c5e0634b49b990436898f63c2b1e696febb..6dae73ee49dbb36d89341ff09556876d0973c4ff 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -524,9 +524,9 @@ static char **realloc_argv(unsigned int *size, char **old_argv)
>  	}
>  	argv = kmalloc_array(new_size, sizeof(*argv), gfp);
>  	if (argv) {
> -		*size = new_size;
>  		if (old_argv)
>  			memcpy(argv, old_argv, *size * sizeof(*argv));
> +		*size = new_size;
>  	}
>  
>  	kfree(old_argv);
> 
> ---
> base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
> change-id: 20250506-dm-past-array-boundaries-1fe2f5a1030f
> 
> Best regards,
> -- 
> Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks

I sent a pull request to Linus that includes this patch.

Mikulas


