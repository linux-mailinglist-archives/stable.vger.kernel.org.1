Return-Path: <stable+bounces-9-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E47F5768
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 05:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4C62816FE
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 04:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D216F79D8;
	Thu, 23 Nov 2023 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3UCdCG/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A2DB9
	for <stable@vger.kernel.org>; Wed, 22 Nov 2023 20:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700713953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/RxEdVo2tTEZY1l5idatcfPWUNnH5H6CT5tTe4WQUs=;
	b=b3UCdCG/WJ75FKQiOjCto+7ack6CLtm0qWk214+Tv3JH9+SZEvLYy/UOMutFrHnDfnIK2f
	gN6dyzfqztcT0iibRZ9fytpRkms3nBOATk8p6decnqtZUoOKwNa3dUsZm5hPcFsdUn+Hlx
	l2v6TH2Kr8vvePm45hVOhFq4/RUxJ5I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-86oEVglrMPe8b5VjOgSajw-1; Wed, 22 Nov 2023 23:32:32 -0500
X-MC-Unique: 86oEVglrMPe8b5VjOgSajw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ce5bad4515so6404605ad.1
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 20:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700713951; x=1701318751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/RxEdVo2tTEZY1l5idatcfPWUNnH5H6CT5tTe4WQUs=;
        b=DFmm4ONII8sjcPZHFoq2qKIgPJlXnuvs2UaQLDem2M+eaNplki1BF+BKfIJdkluoBj
         RWrZlX0XUHdnQTusKQyDEYXLx/IEZOwEmq0pK/gvNCkzkMBPo+kXbcOnedwDslmNloS7
         7Fbeln01xyMHxjiCb7wr64wELsz+TdjQ0eyNkBVBsYHHdl/uSRpaz2anfMQQMB2FsKAU
         SyJv3TtR3rd9G6RAk9R3xySt6NX30GF0OLo2w8qaV9/H/eq6grDr82F2BnTeCCK2Ggww
         Vfl0CX+Y+3+VxfHapRUF+61IOPEKEEv+458fmXsUllYRRW4EL0MnjIms8QOTZc6L3zIo
         BtUA==
X-Gm-Message-State: AOJu0Yxs+jWfwgAiEHjc/JxlhDVop4e8eEpFkhIEpBF83vjJnZ6P2aWq
	cgoycgY/GzWqm5uhNRy78q+ve2qij2RfNcNizxvpqujNS+S3AWgVMAR2fuzLfz8GEJu4owD4pQf
	iEXrBZrP08BDfdUBrCtrol5IBy1M/Uw==
X-Received: by 2002:a17:903:428b:b0:1c3:4b24:d89d with SMTP id ju11-20020a170903428b00b001c34b24d89dmr4875223plb.40.1700713951177;
        Wed, 22 Nov 2023 20:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQx5QnyMOtAGiy5FcvtpmUEdGNjAQiaQOFyix6Z/4HvNl6UhF7Ywdql+khXKEwVycn23klaA==
X-Received: by 2002:a17:903:428b:b0:1c3:4b24:d89d with SMTP id ju11-20020a170903428b00b001c34b24d89dmr4875211plb.40.1700713950895;
        Wed, 22 Nov 2023 20:32:30 -0800 (PST)
Received: from [10.72.112.224] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v3-20020a1709029a0300b001bf044dc1a6sm257314plp.39.2023.11.22.20.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 20:32:30 -0800 (PST)
Message-ID: <9df30dc2-bc1c-b0fc-156f-baad37def05b@redhat.com>
Date: Thu, 23 Nov 2023 12:32:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, ceph-devel@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org, stable@vger.kernel.org
References: <20231123030838.46158-1-ebiggers@kernel.org>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20231123030838.46158-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/23/23 11:08, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> The kconfig options for filesystems that support FS_ENCRYPTION are
> supposed to select FS_ENCRYPTION_ALGS.  This is needed to ensure that
> required crypto algorithms get enabled as loadable modules or builtin as
> is appropriate for the set of enabled filesystems.  Do this for CEPH_FS
> so that there aren't any missing algorithms if someone happens to have
> CEPH_FS as their only enabled filesystem that supports encryption.
>
> Fixes: f061feda6c54 ("ceph: add fscrypt ioctls and ceph.fscrypt.auth vxattr")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   fs/ceph/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
> index 94df854147d35..7249d70e1a43f 100644
> --- a/fs/ceph/Kconfig
> +++ b/fs/ceph/Kconfig
> @@ -1,19 +1,20 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config CEPH_FS
>   	tristate "Ceph distributed file system"
>   	depends on INET
>   	select CEPH_LIB
>   	select LIBCRC32C
>   	select CRYPTO_AES
>   	select CRYPTO
>   	select NETFS_SUPPORT
> +	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
>   	default n
>   	help
>   	  Choose Y or M here to include support for mounting the
>   	  experimental Ceph distributed file system.  Ceph is an extremely
>   	  scalable file system designed to provide high performance,
>   	  reliable access to petabytes of storage.
>   
>   	  More information at https://ceph.io/.
>   
>   	  If unsure, say N.
>
> base-commit: 9b6de136b5f0158c60844f85286a593cb70fb364

Thanks Eric. This looks good to me.

Reviewed-by: Xiubo Li <xiubli@redhat.com>


