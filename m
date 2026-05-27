Return-Path: <stable+bounces-254659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLYjLKVKF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:48:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 126075E9A36
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D88CC30A4026
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217753B19A5;
	Wed, 27 May 2026 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFrdyPkb"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133E3B0AE4
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911229; cv=none; b=XVwERVtwvcAaxA3245dhxy/gzLyMWhRz2BBE2y7IZyNDIfj3uaLELCGClVPBPRrTdvQf+brjN9EcRsI9mZqOyutdZzDJaiwlt+PKbyNbzxyDs3Rj+NlTLSnNYY27OTCkh4CE6H4XXUN3Oi5TcdFnIERETuEETbzk45LEd4AMJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911229; c=relaxed/simple;
	bh=PYpLRUGkx31RSnORmVUud1jDNUKNdi451B07enxpxEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEn4EZg6NvBlg0ngSn+YnVDX5Jf2UutotRgvG5/c0rd7NaCvPOI6bRS4TTy3A0Q4EAoNvSDy7564z8yCGDX6LI84qzWyr54llReClHVFCmys27lYXvfB2SyFdTTPJXrBnlIfgv/rhzCN3V9yTfsvh9GukJVs8afmPZNCpfwyiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFrdyPkb; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3025d725a05so27002232eec.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779911227; x=1780516027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyFFFX6XR0cRJQPeXMVh4IghXeM3GX8dFIEjzWZo0sI=;
        b=oFrdyPkbYtnn0tV79P/aPBBVj11Ep8YLVILDYf/Q45/3LwIvVTIpNaHl/LT/xqA41z
         L0HdW12xjK3ltioru23AGPvjeUoJoRi+ndbM6bC6/uj3mcx/5MJ2pR0MBcAQbJvR/j0C
         BfeGbTiN0AW2tAsQ4Hbx5vGtmUl5EFmh72626vMYCFLLip742OztGI1mhM9xuYzl50PC
         XzTyiKrudnvx2VB8RQZnN0Rk6pLlNBqSpyg8iwyUOtHzU2mtnJ2py+5ylMl2Y9IL9LVv
         4iwrJcrvSV/38hHRnpyE0I5hc8HsIBHCi87UeOuz/QvllFZy6lyF8EUcVSIlQvhMLboo
         1SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911227; x=1780516027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyFFFX6XR0cRJQPeXMVh4IghXeM3GX8dFIEjzWZo0sI=;
        b=Ac0LwSdSoHlxnYSQ096VCXxYz7XE530TUy3WYcBfGo/EGovpRzlizA3suLfTopgSVr
         /41ue/q0cydIWabZWUOnpPyeG0tOp393ZFwBM2qNiA70wX0yjpjpcUX+i9cNocofOb6g
         KRrFi9Dim12Fk7UbrdQ5YfTBC/pwkHwbuSuNbhFo8YOmmPlp4Tej+onGikeUd29Isguj
         Cng5hRGLZUJvsyJ69CdIXWIraU1P0ACypf2ZE5yk4q38d1Cva4vWJLZpP3QgHpYoFF1M
         DoMKYLPZafVJffwI2PhOFOPJeH0+LaoRbiM0v+l8xhR/XD2S8NrEDs0hW0bRzXjsiAUx
         xstw==
X-Forwarded-Encrypted: i=1; AFNElJ8nFYzlAWrCvybNq7WClND0U3co4Xd5qNgE+qPgFkOhh3kle+MT/VgiaNfIWXWdaOzXozpFhuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9V5l+3lImn2mUCIhEMwKZNQ6vW2LFpAh2wKySxgfhQ+qUS/d
	nWRPOaSOJjt8B7htJ/hUqoVxmFfiAi/odCH0j0p70yjIysx0lK4iUD18
X-Gm-Gg: Acq92OFGJQ83MsAcJW3AC+MN2mC0O7eztkk3vCuiG4qqm05tMZVmeUPMUlRwzD7RNbx
	9znNmWHgZGcxJepJW0hF4BULVtqR9YKzQqfp4XtegHnO0a2RvF73wiIkF+A4KtjvYkwDvVV10Bw
	zBR+GFf6dlhIfkAm8cV5nSQDTfLEjRXFiMVTCxA+1qdcCXFBmh9mMg+fSBxs1g892MQkNe9G5xN
	tCisCdHtEXvpCJGiw1SjuaBCjdophAfefUQanOuBnaGU0YCNz9Qnv5Rewt8SA1iRZhNnQ+Py9nF
	w9Ds6sBeh65iHIpVtZybbGEebaj91cKkBhCj6QVi2a8TPXVy6HZ1+z5XYmZzeANms+jLvNc4CmW
	zVmoGoQLpPKUUh9l14zgKeNcb9H3hKSS1Z5U6ysROTt5PmdELc5zjUf3W/7Bm8qokKSGl0M5UL0
	DOVMsp0MKeVwI5Ydnre8x3ekw8Bb0BxgQtbhFCVuSabIG/w5Jl2eTuoFPrZO3oyKFLp/vccdUAC
	qk=
X-Received: by 2002:a05:7300:1481:b0:2e2:3381:2fba with SMTP id 5a478bee46e88-30449037dc6mr12024869eec.3.1779911227370;
        Wed, 27 May 2026 12:47:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ca8d:7a6a:7fd3:5948])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30458ab1a46sm13602131eec.24.2026.05.27.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:47:06 -0700 (PDT)
Date: Wed, 27 May 2026 12:47:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: Jason Gerecke <jason.gerecke@wacom.com>, 
	Ping Cheng <ping.cheng@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: validate report size before kfifo insert
Message-ID: <ahdJzWhVFm7mWu-v@google.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
 <20260524135203.1996265-2-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524135203.1996265-2-jinmo44.yang@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254659-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 126075E9A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 10:52:03PM +0900, Jinmo Yang wrote:
> wacom_wac_queue_insert() passes the report size directly to kfifo_in()
> without checking whether the report fits in the kfifo buffer.
> 
> Since commit 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX
> limit"), the kfifo is sized dynamically as min(PAGE_SIZE, 10 * pktlen),
> which can be as small as 256 bytes. However, reports received via
> UHID_INPUT2 can be up to UHID_DATA_MAX (4096) bytes. When such an
> oversized report reaches wacom_wac_queue_insert(), the existing
> kfifo_avail() loop cannot make room for a record larger than the total
> buffer, causing kfifo_copy_in() to memcpy up to 3840 bytes past the
> slab allocation.

Does it? Or maybe spins there indefinitely? Also, doesn't
kfifo_copy_in() return 0 if a record it too big and not copy anything?

> 
> Add a size check at the top of wacom_wac_queue_insert() to reject
> reports that exceed the kfifo capacity.
> 
> Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
>  drivers/hid/wacom_sys.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index a32320b..cc82c6f 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -54,6 +54,12 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
>  {
>  	bool warned = false;
>  
> +	if (size > kfifo_size(fifo)) {
> +		hid_warn(hdev, "%s: report too large (%d > %u) for kfifo\n",
> +			 __func__, size, kfifo_size(fifo));
> +		return;
> +	}
> +
>  	while (kfifo_avail(fifo) < size) {
>  		if (!warned)
>  			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);

Thanks.

-- 
Dmitry

