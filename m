Return-Path: <stable+bounces-78632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E6F98D122
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F61F23333
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38B91CEAC4;
	Wed,  2 Oct 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsXprB/g"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADE7197A68
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864726; cv=none; b=oWZ657RbEM9But3MVgi9GJmcxL7s6qiKBfhwsBtL8xgO7lEUyW+58MW38FSZZcuM6EAQjiRBIIynGM7SvthKx+Y9xsqQzjrU8AQxb4JQHshQ7ZkcvyokcI9D/8hSZXlW3Jfvf4DqGyEsTcCguPUsXD+qdg9iYD3LoRtlK5kcx3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864726; c=relaxed/simple;
	bh=Sv0eYa+BUedpmNHSpd2mQgX3k87G112oSGZ52W+9Rms=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pXfj/wYwTE2OmpkOpbRypDfoRJPgnna8GHjZ2p8cDGfjd4aoYKZRDvoycs+o6vcqg8L4UPlXWdyshksnT6OzpFZ/tXDemu+l1tt/5IZbh7/DjHlLfbbms4+Vh9b+X4JNs9uFbDQifnIid1Q9nidlYybebrg7Ovzmd+FCNSRgYoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsXprB/g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727864723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d2qdvuXDa7MwrHS/hq0bMlq8c8yzmsUnsB/+svm1AMQ=;
	b=LsXprB/ggrYRjfUf/TPZVS1ZZkvZtN4eddPX6IL5XQyezonNmGdT1KmKEqYoKPLLz5ecN7
	+qx7ARy0uyj1SUYa549eq3WNFl4rm2Ex8Z24u2CzBnCwzwRNO84PmyW+IlYqqovZt2duE9
	LFAEUwSClQH/uQkytFYRb8q4X7BV03Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-wMwE1mOQO_S7qluXXg6tpA-1; Wed,
 02 Oct 2024 06:25:20 -0400
X-MC-Unique: wMwE1mOQO_S7qluXXg6tpA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D9D619560BC;
	Wed,  2 Oct 2024 10:25:18 +0000 (UTC)
Received: from [10.45.225.58] (unknown [10.45.225.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89E8219560AD;
	Wed,  2 Oct 2024 10:25:16 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:25:11 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: gregkh@linuxfoundation.org
cc: dfirblog@gmail.com, stable@vger.kernel.org, 
    Sami Tolvanen <samitolvanen@google.com>, Will Drewry <wad@chromium.org>
Subject: Re: FAILED: patch "[PATCH] dm-verity: restart or panic on an I/O
 error" failed to apply to 6.1-stable tree
In-Reply-To: <2024100247-friction-answering-6c42@gregkh>
Message-ID: <93f37f10-e291-5c88-f633-9a61833a7103@redhat.com>
References: <2024100247-friction-answering-6c42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Greg

I would like to as you to drop this patch (drop it also from from 6.6, 
6.11 and others, if you already apllied it there).

Google engineeres said that they do not want to change the default 
behavior.

Mikulas



On Wed, 2 Oct 2024, gregkh@linuxfoundation.org wrote:

> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x e6a3531dd542cb127c8de32ab1e54a48ae19962b
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100247-friction-answering-6c42@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:
> 
> e6a3531dd542 ("dm-verity: restart or panic on an I/O error")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From e6a3531dd542cb127c8de32ab1e54a48ae19962b Mon Sep 17 00:00:00 2001
> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Tue, 24 Sep 2024 15:18:29 +0200
> Subject: [PATCH] dm-verity: restart or panic on an I/O error
> 
> Maxim Suhanov reported that dm-verity doesn't crash if an I/O error
> happens. In theory, this could be used to subvert security, because an
> attacker can create sectors that return error with the Write Uncorrectable
> command. Some programs may misbehave if they have to deal with EIO.
> 
> This commit fixes dm-verity, so that if "panic_on_corruption" or
> "restart_on_corruption" was specified and an I/O error happens, the
> machine will panic or restart.
> 
> This commit also changes kernel_restart to emergency_restart -
> kernel_restart calls reboot notifiers and these reboot notifiers may wait
> for the bio that failed. emergency_restart doesn't call the notifiers.
> 
> Reported-by: Maxim Suhanov <dfirblog@gmail.com>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index cf659c8feb29..a95c1b9cc5b5 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -272,8 +272,10 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
>  	if (v->mode == DM_VERITY_MODE_LOGGING)
>  		return 0;
>  
> -	if (v->mode == DM_VERITY_MODE_RESTART)
> -		kernel_restart("dm-verity device corrupted");
> +	if (v->mode == DM_VERITY_MODE_RESTART) {
> +		pr_emerg("dm-verity device corrupted\n");
> +		emergency_restart();
> +	}
>  
>  	if (v->mode == DM_VERITY_MODE_PANIC)
>  		panic("dm-verity device corrupted");
> @@ -596,6 +598,23 @@ static void verity_finish_io(struct dm_verity_io *io, blk_status_t status)
>  	if (!static_branch_unlikely(&use_bh_wq_enabled) || !io->in_bh)
>  		verity_fec_finish_io(io);
>  
> +	if (unlikely(status != BLK_STS_OK) &&
> +	    unlikely(!(bio->bi_opf & REQ_RAHEAD)) &&
> +	    !verity_is_system_shutting_down()) {
> +		if (v->mode == DM_VERITY_MODE_RESTART ||
> +		    v->mode == DM_VERITY_MODE_PANIC)
> +			DMERR_LIMIT("%s has error: %s", v->data_dev->name,
> +					blk_status_to_str(status));
> +
> +		if (v->mode == DM_VERITY_MODE_RESTART) {
> +			pr_emerg("dm-verity device corrupted\n");
> +			emergency_restart();
> +		}
> +
> +		if (v->mode == DM_VERITY_MODE_PANIC)
> +			panic("dm-verity device corrupted");
> +	}
> +
>  	bio_endio(bio);
>  }
>  
> 


