Return-Path: <stable+bounces-249698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK0KBgXTDGqJnAUAu9opvQ
	(envelope-from <stable+bounces-249698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:15:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFC358518B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64418304FF2F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4DD31AA9B;
	Tue, 19 May 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="TO/ZC5Tz"
X-Original-To: stable@vger.kernel.org
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478027FD44
	for <stable@vger.kernel.org>; Tue, 19 May 2026 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225346; cv=none; b=mjShFt1CBnJOgoOOG5b6mXph7mNCIPhUjfzJ544h9dm/IZfoHM4bNwOMlGrPSjfHlEEQhEuKTtFXLnoQzCyPs1bDVvRB1Oumi10sCPdYBWipHJrhqZxZrb0oKxThjX1PKeZcJd4y8NA4JSVeQf+DNsinuHj+NbTv+JvoSvNDVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225346; c=relaxed/simple;
	bh=BBlEBeqB+PoyoPifviZgwuZ9xbp7WSqkHi2qx8buDnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBgAKRRG/EjBr1b4NqijvRkp2GStaId2fp7C0oTgxdSImxPMCKrGRwbqaXvxUp0xddqtatWzyOzVORlLukRxWCK8Cx99EyI6uJrUee27JyIN3kLkSzM0cKSU7pJFDkxfM52hTW73G9dSwmuVc+pg5EmD1sO8xstiJbNDQAunz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=TO/ZC5Tz; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1779225341;
	bh=hEHty2k4meSkuJyXOr7GpcJH2Igvo8dRaUue15eUypg=;
	h=From:Subject:Date:Message-ID;
	b=TO/ZC5Tz91HblYLEKYvKG37LisPt8soEeN/uPlUsu6VcspR57mVcERN8JOB/HHEMV
	 myb4Qc+tzqsYiSyjcd49GLZFpQCTKZqhYzN02QmvrChanfUG8VDmHPY6OlQGIH648L
	 A6QF5GP8Rt052dpm8WXOkSrrVp9zdAxISNR1NGwQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.31) with ESMTP
	id 6A0CD2F10000253D; Tue, 20 May 2026 05:15:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7192836816420
X-SMAIL-UIID: F5A0BA850BEE48DDA7824278CA8BECBF-20260520-051530-1
From: Hillf Danton <hdanton@sina.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: mchehab@kernel.org,
	hverkuil+cisco@kernel.org,
	sakari.ailus@linux.intel.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] media: dvb-core: fix use-after-free in dvb_frontend_open()
Date: Wed, 20 May 2026 05:15:19 +0800
Message-ID: <20260519211520.829-1-hdanton@sina.com>
In-Reply-To: <20260519051020.628298-1-yun.zhou@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249698-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[sina.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,windriver.com:email]
X-Rspamd-Queue-Id: 4BFC358518B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 13:10:20 +0800 Yun Zhou wrote:
> dvb_frontend_open() calls dvb_generic_release() in its error path after
> dvb_generic_open() succeeds. dvb_generic_release() drops the device
> reference via dvb_device_put(), and then dvb_device_open() drops it again
> in its error handling, causing a use-after-free and refcount underflow.
> 
> Fix this by introducing __dvb_generic_release() which only restores the
> users/readers/writers counters without dropping the device reference. Use
> it in dvb_frontend_open()'s error path so that dvb_device_open() remains
> the sole owner of the dvb_device_put() on open failure.
> 
Given the relevant code snippet

	dvb_device_open()
	  mutex_lock(&dvbdev_mutex);
	  down_read(&minor_rwsem);
	  dvbdev = dvb_minors[minor];
	  if (dvbdev && dvbdev->fops) {
	    dvb_device_get(dvbdev);
	    err = file->f_op->open(inode, file);
	    up_read(&minor_rwsem);
	    mutex_unlock(&dvbdev_mutex);
	    if (err)
	       dvb_device_put(dvbdev);
	  }

a) the frontend open callback is invoked with refcount incremented, so
why could a single put in the err path drop refcount to ground?
b) worse dvbdev is freed without clearing dvb_minors[minor].

One explanation sounds like

	dvb_device_open(); // err with refcount dropped but
			   // without clearing dvb_minors[minor]
	dvb_device_open(); // single put frees dvbdev

so a simpler fix looks like incrementing refcount before
dvb_generic_release() in the err path.

> Reported-by: syzbot+40339ea82afa8184ad5d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=40339ea82afa8184ad5d
> Cc: stable@vger.kernel.org
> Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
> v2:
>  - Fix Fixes tag commit title
>  - Add Closes: link after Reported-by
>  - Cc stable@vger.kernel.org
> 
>  drivers/media/dvb-core/dvb_frontend.c |  2 +-
>  drivers/media/dvb-core/dvbdev.c       | 17 ++++++++++++-----
>  include/media/dvbdev.h                | 12 ++++++++++++
>  3 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
> index d082b6c57c76..497f5920b267 100644
> --- a/drivers/media/dvb-core/dvb_frontend.c
> +++ b/drivers/media/dvb-core/dvb_frontend.c
> @@ -2887,7 +2887,7 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
>  	mutex_unlock(&fe->dvb->mdev_lock);
>  err2:
>  #endif
> -	dvb_generic_release(inode, file);
> +	__dvb_generic_release(inode, file);
>  err1:
>  	if (dvbdev->users == -1 && fe->ops.ts_bus_ctrl)
>  		fe->ops.ts_bus_ctrl(fe, 0);
> diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
> index d753d329502a..3e0ad67b79a3 100644
> --- a/drivers/media/dvb-core/dvbdev.c
> +++ b/drivers/media/dvb-core/dvbdev.c
> @@ -152,19 +152,26 @@ int dvb_generic_open(struct inode *inode, struct file *file)
>  }
>  EXPORT_SYMBOL(dvb_generic_open);
>  
> -int dvb_generic_release(struct inode *inode, struct file *file)
> +void __dvb_generic_release(struct inode *inode, struct file *file)
>  {
>  	struct dvb_device *dvbdev = file->private_data;
>  
> -	if (!dvbdev)
> -		return -ENODEV;
> -
>  	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
>  		dvbdev->readers++;
>  	else
>  		dvbdev->writers++;
> -
>  	dvbdev->users++;
> +}
> +EXPORT_SYMBOL(__dvb_generic_release);
> +
> +int dvb_generic_release(struct inode *inode, struct file *file)
> +{
> +	struct dvb_device *dvbdev = file->private_data;
> +
> +	if (!dvbdev)
> +		return -ENODEV;
> +
> +	__dvb_generic_release(inode, file);
>  
>  	dvb_device_put(dvbdev);
>  
> diff --git a/include/media/dvbdev.h b/include/media/dvbdev.h
> index e5a00d126612..9e6e5cb43dcb 100644
> --- a/include/media/dvbdev.h
> +++ b/include/media/dvbdev.h
> @@ -343,6 +343,18 @@ int dvb_create_media_graph(struct dvb_adapter *adap,
>   */
>  int dvb_generic_open(struct inode *inode, struct file *file);
>  
> +/*
> + * __dvb_generic_release - Undo dvb_generic_open() counters WITHOUT
> + *      dropping the device reference.
> + *
> + * @inode: pointer to &struct inode.
> + * @file: pointer to &struct file.
> + *
> + * Used in cases where the caller handles dvb_device_put() and ensures
> + * that dvbdev is valid.
> + */
> +void __dvb_generic_release(struct inode *inode, struct file *file);
> +
>  /**
>   * dvb_generic_release - Digital TV close function, used by DVB devices
>   *
> -- 
> 2.43.0

