Return-Path: <stable+bounces-150709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC7DACC652
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 14:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE051885508
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97F91B393C;
	Tue,  3 Jun 2025 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AU/0cjFk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175241E480
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953121; cv=none; b=LaR0QZJ7PcP1vAWSXIwIAWXLqXzCF+eBUrPw83uZCw/O3YK3Ij3bVD30BZvTz4zrRVtZNM0x7RUreVvoc1hthCvYMb8+ZkpaSz+Xr8loqAcQP5Jo49sZEVnz/75SfYw8gibo7Mt2aO0NVB7DkK1UAPmPcWHX/CrG774l2NaYSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953121; c=relaxed/simple;
	bh=hRBfjkyXDEB8n6PRaJohwZBVd9S/I2B0A30GC3UZkSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4kcCT8xnRPbIBsY1SCHzDDA7UMtcQ54CLg6UL8FoFP3pysv2Pwheg2uV0WDQ/1vvBD5M9MhFx9eFwefv1pmb+AgctRa2s+Y37UVjdER0y6zVObPd2uG1zpC/qc78qC72bchWOWuwugW6pgQESAHqwYmf6EyTbkUpNSI+2rGNLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AU/0cjFk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748953119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffXIBf29sZb1K6xWm0mL1At/DHNtjLOFFnwn7PxkVT4=;
	b=AU/0cjFk5dRLReuzDmljTgdwH/+rhwwc1IcAD/xLfnbnpzhZLmE7dGxpFpPDonZNbyACXA
	M/DDr0qSCwoh6qeQg9ayPPBPSFkwrlWvBg6MCY9MU0L23bN1y6dh2L/t/+YmEkAIdotQrt
	Z1f6E+NkzBaQuJo4QlKx6V+2Z5TnpzU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-PGtSdc8xO0a7GUrqCLtoKg-1; Tue, 03 Jun 2025 08:18:36 -0400
X-MC-Unique: PGtSdc8xO0a7GUrqCLtoKg-1
X-Mimecast-MFC-AGG-ID: PGtSdc8xO0a7GUrqCLtoKg_1748953115
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-401c6b8b674so5223444b6e.2
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 05:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748953115; x=1749557915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffXIBf29sZb1K6xWm0mL1At/DHNtjLOFFnwn7PxkVT4=;
        b=nUMS8uwa3jcaZtT9woJSxCLPOILejNEZVhX8nNWVSooITJHvrF70JqzDvYuzgFlPGR
         Iyv4NdXBSMlRuXJ3alUdCHNmtCT8GQnyTSKD2/G9E9+H7Qyo9GueI7kd5nckSY4xzp1g
         cxDGGgNlCo/BXlYuVKZqsVWyn1FhocJvEWfsk5Sgt1OPFJAG2wPrWz+C494pP8UV1O9q
         DMahYODrD5+Y8gyMnsFvgEqDC6cFePQvpRzZV4rYEPFBrlvzyvICXNLpRNyM9Chb/gbD
         jcYRbBv3ihiaTAjqccCOxIm9PNbpq9s23Ci6eyGleQdvwl/BR1ZXevLT8D0MoJORC+/Z
         WOXg==
X-Gm-Message-State: AOJu0YyOm4dCtqF1vCLWXXVhENOjMHX8Ia3tPipOW5tCvlDWH1Bd8cJd
	gb7ErG7jIbI0wsEFssh4Glpy/OCwNlpcQOaenYSZz1tL9jWf/VmVi5kfgnR77pDhIGs8qZ4dG+F
	uFkg8uvxufjxvtCx3RGRQDrLmaKitoMuflEroqkW6NCeZckHsjGydF9wuwJVsAFqhcpYlfm4dmy
	rKIPpd34psOMt5wb6Ad+/zENz7MWogVc7RPq1Rc4/SjQg=
X-Gm-Gg: ASbGncsWcolUAUZyhFHX6pc4sJU1j91DpmFYGeaMqZAc88e8+bd2+rfzr9BGLkn67qP
	cenmFIEt0PZ19OP4aKrtirJVW42Vyq5YWTUmAq3GW9Hn7eq+hSvcTAquLyr80/Gl9kM4=
X-Received: by 2002:a05:6808:6f84:b0:403:3195:58cb with SMTP id 5614622812f47-407a65ef7demr8150042b6e.28.1748953114919;
        Tue, 03 Jun 2025 05:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8KvDsdDkgI+1PNoaL+B3Q6bgNuhvgw/iB+KFAL38XMwrBiuIXT9ZI7YntDi9tKBM5UX0PsshNsCF2QikhX9s=
X-Received: by 2002:a05:690c:6e01:b0:70e:1ef7:6eff with SMTP id
 00721157ae682-71097c2a91amr162686157b3.3.1748953103596; Tue, 03 Jun 2025
 05:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134340.906731340@linuxfoundation.org> <20250602134341.897528821@linuxfoundation.org>
In-Reply-To: <20250602134341.897528821@linuxfoundation.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 3 Jun 2025 14:18:12 +0200
X-Gm-Features: AX0GCFt5-R5_l1JcZoLRDhSODZkzwizMtWUfInGyGiuuSHRx5X0zU78Q3RYWgCE
Message-ID: <CAGxU2F7fRUn1H_-CF5SJJ1DZDEt3xfm+er0kqa_XS9nn6uJi0g@mail.gmail.com>
Subject: Re: [PATCH 6.6 024/444] vhost_task: fix vhost_task_create() documentation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Jun 2025 at 16:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me know.

It seems that commit cb380909ae3b ("vhost: return task creation error
instead of NULL") is not backported to 6.6, so we can skip this patch.
BTW it's just a fix in a comment, so if it's too late, it should not
be a big issue.

Just for my understanding, next time should I add a Fixes tag in this
case, also if the patch doesn't touch code?

Thanks,
Stefano

>
> ------------------
>
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> [ Upstream commit fec0abf52609c20279243699d08b660c142ce0aa ]
>
> Commit cb380909ae3b ("vhost: return task creation error instead of NULL")
> changed the return value of vhost_task_create(), but did not update the
> documentation.
>
> Reflect the change in the documentation: on an error, vhost_task_create()
> returns an ERR_PTR() and no longer NULL.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Message-Id: <20250327124435.142831-1-sgarzare@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/vhost_task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 8800f5acc0071..0e4455742190c 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
>   * @arg: data to be passed to fn and handled_kill
>   * @name: the thread's name
>   *
> - * This returns a specialized task for use by the vhost layer or NULL on
> + * This returns a specialized task for use by the vhost layer or ERR_PTR() on
>   * failure. The returned task is inactive, and the caller must fire it up
>   * through vhost_task_start().
>   */
> --
> 2.39.5
>
>
>


