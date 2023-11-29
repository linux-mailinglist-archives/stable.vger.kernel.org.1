Return-Path: <stable+bounces-3165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B817FDE2C
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 18:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E043CB20E9B
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 17:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960046BA0;
	Wed, 29 Nov 2023 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjYSDssl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD4C4
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 09:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701278452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdZcz1CbfySNC/voTyNm3HwHoiZ6xk0K2b5NJeG5dMA=;
	b=OjYSDsslJpAgGClQxC29K8Y1F+K829lAQvMFDPHxG1qwAtCb7o5JC5zSMS50xVXRQthOL8
	xdptytQtNg1aPvlm/ut+rUwBsFNfW4MUPqI4bjUuNiOV/bXV2bhw4ljfJGdNVFBo+ZD2t2
	BTIgQgIvZ3LWixvHA0a6y0hCVm11WHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-D6fCWJHpNYaP3WRafceDHA-1; Wed, 29 Nov 2023 12:20:47 -0500
X-MC-Unique: D6fCWJHpNYaP3WRafceDHA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36BA08556F5;
	Wed, 29 Nov 2023 17:20:47 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EF57492BEF;
	Wed, 29 Nov 2023 17:20:47 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id F055830C1A8C; Wed, 29 Nov 2023 17:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id EBCA23FB76;
	Wed, 29 Nov 2023 18:20:46 +0100 (CET)
Date: Wed, 29 Nov 2023 18:20:46 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Wu Bo <bo.wu@vivo.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
    Wu Bo <wubo.oduw@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dm verity: init fec io before cleaning it
In-Reply-To: <4257e74602bd0ea192011eaefdbf8a2205382b56.1700623691.git.bo.wu@vivo.com>
Message-ID: <64cbcac5-6ad-945d-32e9-87497c3615a6@redhat.com>
References: <cover.1700623691.git.bo.wu@vivo.com> <4257e74602bd0ea192011eaefdbf8a2205382b56.1700623691.git.bo.wu@vivo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9



On Tue, 21 Nov 2023, Wu Bo wrote:

> If BIO error, it may goto verity_finish_io() before
> verity_fec_init_io(). Therefor, the fec_io->rs is not initialized and
> may crash when doing memory freeing in verity_fec_finish_io().
> 
> Crash call stack:
>  die+0x90/0x2b8
>  __do_kernel_fault+0x260/0x298
>  do_bad_area+0x2c/0xdc
>  do_translation_fault+0x3c/0x54
>  do_mem_abort+0x54/0x118
>  el1_abort+0x38/0x5c
>  el1h_64_sync_handler+0x50/0x90
>  el1h_64_sync+0x64/0x6c
>  free_rs+0x18/0xac
>  fec_rs_free+0x10/0x24
>  mempool_free+0x58/0x148
>  verity_fec_finish_io+0x4c/0xb0
>  verity_end_io+0xb8/0x150
> 
> Cc: stable@vger.kernel.org      # v6.0+
> Fixes: 5721d4e5a9cd ("dm verity: Add optional "try_verify_in_tasklet" feature")
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  drivers/md/dm-verity-target.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index e115fcfe723c..beec14b6b044 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -642,7 +642,6 @@ static void verity_work(struct work_struct *w)
>  
>  	io->in_tasklet = false;
>  
> -	verity_fec_init_io(io);
>  	verity_finish_io(io, errno_to_blk_status(verity_verify_io(io)));
>  }
>  
> @@ -792,6 +791,8 @@ static int verity_map(struct dm_target *ti, struct bio *bio)
>  	bio->bi_private = io;
>  	io->iter = bio->bi_iter;
>  
> +	verity_fec_init_io(io);
> +
>  	verity_submit_prefetch(v, io);
>  
>  	submit_bio_noacct(bio);
> -- 
> 2.25.1

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>


