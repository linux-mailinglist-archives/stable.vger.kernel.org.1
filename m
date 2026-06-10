Return-Path: <stable+bounces-262400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l87MNxa+KGqrIwMAu9opvQ
	(envelope-from <stable+bounces-262400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:29:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A786665373
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:29:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=T5VL9X7q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262400-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262400-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 995EA305F568
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 01:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050727A107;
	Wed, 10 Jun 2026 01:29:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28145272E7C;
	Wed, 10 Jun 2026 01:29:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054980; cv=none; b=pehNgAL0XsmVBKO3kmCLNjKlYkN0tcELE0X4OVefsx8uhh239Q+ZXOyVA4UfSfKaIqsbp1wnwxmQoETjZJhq5Ic0wCnuMyFNocmecCbSS2AfYNpJpH12Jrl/l3PS/NPAWSq2cnIsPeSgJqbok5ii6qPUh3GoNysTVHil7h5vhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054980; c=relaxed/simple;
	bh=BaMBhH4UBV/eRZkCM3tE+1Q0BPtUIU4D6dWPrPx/skw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qjb9ae9X1tiaU4Zz9jMhLUtBYrLlGNuYEMzIBOOZtDLha/WXJ9BMBhyFvQPn6JV30644EwxwLH/KrLnxH8+16WZ1ZdMmOuJ+2m+V/UC5mh1fMaZZ0lUhQOq/VwE7bg41wu0dY1Ai2qo/hiftriI9MmPY5e+uAo1Bxr7ng0q5gsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5VL9X7q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A271F00893;
	Wed, 10 Jun 2026 01:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054979;
	bh=mcwyzflTFzQMbgkW9om/kpXbBJQYlUaJarM14jOFs1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T5VL9X7qMptDXVDGdYS/8chvo3Mht3G14p/QTb+o2WkMpWISDO1Zaz2TYlPYWNP9t
	 46RpBd73POBInXOl8zfIWFxdOa8tL3YnwKaEeBhAYbPv9S+kegE6LxQoSMlGvOKILx
	 0yWh4C24AtH+Xf7rklLX+Nta04SuKkhZXg7Tj6qd6LXHgRXwR1ijRiSxN5bxBVP8Rq
	 Fg5QwAQXsLMagS0vixsTOIeqw5nets7wpdKmyvq0a1KSBMbdJULydCY7aDwvWIs+05
	 MxHwnigzqNMyu5d5RPjeu3UhQdQVXFfZYtuMG69Y8dSh4/OuSzsEzxmtw40K9Uo+U3
	 quvFq42QrcZuQ==
Date: Wed, 10 Jun 2026 09:29:34 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Robert Baldyga <r.baldyga@samsung.com>,
	Michal Nazarewicz <mina86@mina86.com>,
	Felipe Balbi <balbi@kernel.org>, stable@vger.kernel.org,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_fs: initialize reset_work at allocation
 time
Message-ID: <aii9/vGi5ZOEZ9uO@nchen-desktop>
References: <20260609193635.2284430-1-tyler.baker@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609193635.2284430-1-tyler.baker@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tyler.baker@oss.qualcomm.com,m:gregkh@linuxfoundation.org,m:r.baldyga@samsung.com,m:mina86@mina86.com,m:balbi@kernel.org,m:stable@vger.kernel.org,m:loic.poulain@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[peter.chen@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262400-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.chen@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nchen-desktop:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A786665373

On 26-06-09 15:36:34, Tyler Baker wrote:
> ffs_fs_kill_sb() unconditionally calls cancel_work_sync() on
> ffs->reset_work when a functionfs instance is unmounted:
> 
> 	ffs_data_reset(ffs);
> 	cancel_work_sync(&ffs->reset_work);
> 
> However ffs->reset_work is only ever initialized via INIT_WORK() in
> ffs_func_set_alt() and ffs_func_disable(), and only on the
> FFS_DEACTIVATED path. That state is reached solely by ffs_data_closed()
> when the instance is mounted with the "no_disconnect" option, so for the
> common case (no "no_disconnect", or mounted and unmounted without ever
> being deactivated) reset_work is never initialized.
> 
> ffs_data_new() allocates the ffs_data with kzalloc_obj() and does not
> initialize reset_work, and ffs_data_reset()/ffs_data_clear() do not touch
> it either, so reset_work.func is left NULL. cancel_work_sync() on such a
> work then trips the WARN_ON(!work->func) guard in __flush_work():
> 
>   WARNING: kernel/workqueue.c:4301 at __flush_work+0x330/0x360, CPU#3: umount
>   Call trace:
>    __flush_work
>    cancel_work_sync
>    ffs_fs_kill_sb [usb_f_fs]
>    deactivate_locked_super
>    deactivate_super
>    cleanup_mnt
>    __cleanup_mnt
>    task_work_run
>    exit_to_user_mode_loop
>    el0_svc
> 
> On older kernels cancel_work_sync() on a zero-initialized work struct was
> a silent no-op, which hid the missing initialization.
> 
> Initialize reset_work once in ffs_data_new() so it is always valid for
> the lifetime of the ffs_data, and drop the now-redundant INIT_WORK()
> calls from the two deactivation paths.
> 
> Fixes: 18d6b32fca38 ("usb: gadget: f_fs: add "no_disconnect" mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Reviewed-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/gadget/function/f_fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 75912ce6ab55..1ee21e29ef73 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -288,6 +288,7 @@ static int ffs_acquire_dev(const char *dev_name, struct ffs_data *ffs_data);
>  static void ffs_release_dev(struct ffs_dev *ffs_dev);
>  static int ffs_ready(struct ffs_data *ffs);
>  static void ffs_closed(struct ffs_data *ffs);
> +static void ffs_reset_work(struct work_struct *work);
>  
>  /* Misc helper functions ****************************************************/
>  
> @@ -2221,6 +2222,7 @@ static struct ffs_data *ffs_data_new(const char *dev_name)
>  	init_waitqueue_head(&ffs->ev.waitq);
>  	init_waitqueue_head(&ffs->wait);
>  	init_completion(&ffs->ep0req_completion);
> +	INIT_WORK(&ffs->reset_work, ffs_reset_work);
>  
>  	/* XXX REVISIT need to update it in some places, or do we? */
>  	ffs->ev.can_stall = 1;
> @@ -3775,7 +3777,6 @@ static int ffs_func_set_alt(struct usb_function *f,
>  	if (ffs->state == FFS_DEACTIVATED) {
>  		ffs->state = FFS_CLOSING;
>  		spin_unlock_irqrestore(&ffs->eps_lock, flags);
> -		INIT_WORK(&ffs->reset_work, ffs_reset_work);
>  		schedule_work(&ffs->reset_work);
>  		return -ENODEV;
>  	}
> @@ -3806,7 +3807,6 @@ static void ffs_func_disable(struct usb_function *f)
>  	if (ffs->state == FFS_DEACTIVATED) {
>  		ffs->state = FFS_CLOSING;
>  		spin_unlock_irqrestore(&ffs->eps_lock, flags);
> -		INIT_WORK(&ffs->reset_work, ffs_reset_work);
>  		schedule_work(&ffs->reset_work);
>  		return;
>  	}
> -- 
> 2.43.0
> 
> 

-- 

Best regards,
Peter

