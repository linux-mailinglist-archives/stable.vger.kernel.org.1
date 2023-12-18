Return-Path: <stable+bounces-7819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C048179A0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A79AB22D49
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6CE5D73F;
	Mon, 18 Dec 2023 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SAwSCi2D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEF11DFDE
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FHqmrffu2i8InFHqmryQ1N; Mon, 18 Dec 2023 18:56:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702922181;
	bh=ZJ2LCn3aYYC5eEXqWQDbKA00WL6uafWN8kRPVIHjk14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SAwSCi2Dm5YgLIWhNdQxnDdf51kBmvtGSIsEWReGaCX1S+rI+Le3e6GO5TPxCAdKp
	 AGXbcGCCdedCS1G3tX/UWr66Sv9T1FOGY4mWfrw/D7J5rdxAAqn1go3ba/5wcj+tch
	 YCgzYKL0CADr3nVElbBF8vwZV45FhZHtTpT06lfdPJ3PyF1U3X6GZOeqO/oECjBPGY
	 e5IwC3HiHhlM5ku+N2H4fKGSRql9wZyPnsX/1GpfAz9mZ+YaK7VzF5WfM9W7/6cAqJ
	 wS/tpSldKY/cCdDgCCJrHyGs2F35WB3se7vgsC06EldL+JFGEtq5LqTncLgFGn6KKD
	 2G/fDL4E8eaPg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 18 Dec 2023 18:56:21 +0100
X-ME-IP: 92.140.202.140
Message-ID: <4fb8f26e-cf8d-4ad8-bd44-ecd4198f8072@wanadoo.fr>
Date: Mon, 18 Dec 2023 18:56:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y 003/154] ksmbd: Remove redundant
 'flush_workqueue()' calls
To: Namjae Jeon <linkinjeon@kernel.org>, gregkh@linuxfoundation.org,
 stable@vger.kernel.org
Cc: smfrench@gmail.com, Steve French <stfrench@microsoft.com>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
 <20231218153454.8090-4-linkinjeon@kernel.org>
Content-Language: fr, en-GB
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231218153454.8090-4-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

unless explicitly needed because of other patches that rely on it, 
patches 03, 28 and 42 / 154 don't look as good candidate for backport.

CJ


Le 18/12/2023 à 16:32, Namjae Jeon a écrit :
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> [ Upstream commit e8d585b2f68c0b10c966ee55146de043429085a3 ]
>
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
>
> Remove the redundant 'flush_workqueue()' calls.
>
> This was generated with coccinelle:
>
> @@
> expression E;
> @@
> - 	flush_workqueue(E);
> 	destroy_workqueue(E);
>
> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>   fs/ksmbd/ksmbd_work.c     | 1 -
>   fs/ksmbd/transport_rdma.c | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/fs/ksmbd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
> index fd58eb4809f6..14b9caebf7a4 100644
> --- a/fs/ksmbd/ksmbd_work.c
> +++ b/fs/ksmbd/ksmbd_work.c
> @@ -69,7 +69,6 @@ int ksmbd_workqueue_init(void)
>   
>   void ksmbd_workqueue_destroy(void)
>   {
> -	flush_workqueue(ksmbd_wq);
>   	destroy_workqueue(ksmbd_wq);
>   	ksmbd_wq = NULL;
>   }
> diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
> index 9ca29cdb7898..86446742f4ad 100644
> --- a/fs/ksmbd/transport_rdma.c
> +++ b/fs/ksmbd/transport_rdma.c
> @@ -2049,7 +2049,6 @@ int ksmbd_rdma_destroy(void)
>   	smb_direct_listener.cm_id = NULL;
>   
>   	if (smb_direct_wq) {
> -		flush_workqueue(smb_direct_wq);
>   		destroy_workqueue(smb_direct_wq);
>   		smb_direct_wq = NULL;
>   	}

