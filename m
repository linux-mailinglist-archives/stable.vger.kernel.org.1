Return-Path: <stable+bounces-211173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJfvNDo3cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:29:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 472D65D3E2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE2989D029C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957673D3CFC;
	Wed, 21 Jan 2026 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQu+zMG9"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1128000F
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025784; cv=none; b=F97NCMakHfPWpK/vLcnThv67b5SAli2I435tb9/R9bQXNu/+yhiywr0mp3YHBxqJFnjWR6X/69AZUastl/TOjOhB1Je7WM6Ehsvmq9Fk6EEKFv1sxS5KONv2aBvb3lufRGXLXJjQXBT3mpPwj+PZNfKHLCUXBxjQtLsYm+beXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025784; c=relaxed/simple;
	bh=ryGfHyEX0pdgmogicUMhJer8o2q7Zut9okPt2Zf69UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjTbP6+15a/fMJVV1V75V1zfSSgHYti8n5rLcoYn5pqR14QbQfytyebbAknvSGZQSJydAUoPmpg0Rkr5sorRM0FvqWutdCyk/9lYsz1MLt9yYTLyHgePuEc2PGc2yXI/BHwJ1dw4YkNWfTZbPETGMpzIxkYWzriXutj6++FKRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQu+zMG9; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so557338eec.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 12:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769025781; x=1769630581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=noOMWd8451AiWi9sjesHYL9FiLA2for0VqMOqr/FP1M=;
        b=gQu+zMG9Mvr8420xOEK9ciJT6pxxL7WFICPoDrSWDbsUmk75jHuCvz4T9x1zkR/czp
         2895eAQubjtKaXS0lTLnq06kgL1m2xvhNf03p1FVPclgi/Cg1cHxpLCyuCgeX5a4ESiT
         fBc+VE6FWCez2ggpBLijomqYG/E9Si0nMyKaEhj3LsRhD/kwgLUjbH1ArPc/TB7LI/xT
         21GFWHftYp9xc6lryjA9w8iKU4pitaE4wZTGOnWA08NiD6OugWgRnnCQKGys8dwQaput
         dkBMMeyLiS4g9XEDZZR84NyHD+UaBcjppCAPMD/x0FiAiPKstp2RsaBXORxneaPb6xm0
         sTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769025781; x=1769630581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noOMWd8451AiWi9sjesHYL9FiLA2for0VqMOqr/FP1M=;
        b=EKoSOnQJ5jjZX1+DrpPiAmqo3ljyW79QonLE9vzDy/QzUNzeoyMTitwG7SDPzKRJGu
         Edp85y9CKuGLpUiA3Se1v8VHhJnFjYjN0nxW9THIk/j9yh0hLJCt0RJUDpINU2PG3/4T
         Yo4Bp31jM5/409w+DKYTO1MSwT7OZaj4ZCIJ15PtMC92saSeYdji0C2V9WkEfd4rWrqj
         d2SgKh2Lfn8PIQS+XusIvSMGDtSRr2qog9kdzGzSv4GnC5zPWRIq8hg889UG9J0Ffrkm
         ItW2Pa28O7BCQq/Fi2u/0SRQBk9B4HlOUjhLhjzbuUh6XYb8qfNWn/HDvIxRvaIiL4zt
         XpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCYQyx9JsakxnqYceYgeSRsrMEMvtiOu5xc22ejHQnUagimtW3d7IytEJm/LuXMEZRDk+QJs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhRdvHFKhqfTl/m4+DUFJ9oUkNwaYDnj4cECthH6DTSz0lbNtN
	RmmVcDEP/c/+zcHuwE9p8yth5ArYd7SjrA0YzonllGL4fvQqVJeeGQqx
X-Gm-Gg: AZuq6aLI9hrPc/isZzak/D2cM7v6r2ISo1IF6/gfsERbCT4IlE/2ML1+sVqeP7f9yxu
	CE2zagaxHxIUPOSe1l7aMS1uc7mNd1TZP+hUlIeIsrPZ2TeLycg/sDvV253qszUMAxd6WLOz/Wd
	54jzZIOxCzKgkruQiW7oJMgrDRW27bFLfStUPlvqXBSZTmksoS6/aOOjQpAwNLW5CDKRSxJ/nM2
	m432emKQZGDFMh1lgpDWhVqSzyTB2ig89+FljTIkAspP8stSUQAVUcnrJejSX6AnzuBLSYwez7H
	V2F6YAX3qc6VYiSaVuzmf3pTaTM+zNRKrgDQzjNELDd+I/tMIXNSIuUzhv3xkDGVt1EBQGvQgPB
	qgGTlmc+gkM2b59EceMrMLGmXpHydwbAJOzBXB+OzGCC5SEZtmRbxL4Qub6HXalHixAsKDgIhvk
	CWyCiN5fCEBXbLzQUyBHp4rDC0UXIckZqmvubXFIaMJE+9b7ZGoSveMm1Lc4yiDJg=
X-Received: by 2002:a05:693c:2d8f:b0:2ac:1a21:841d with SMTP id 5a478bee46e88-2b6b4e5b5f9mr12956485eec.16.1769025781007;
        Wed, 21 Jan 2026 12:03:01 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7070eeec2sm6086404eec.21.2026.01.21.12.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 12:03:00 -0800 (PST)
Date: Wed, 21 Jan 2026 12:02:56 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Minseong Kim <ii4gsp@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: synaptics_i2c - guard polling restart in resume
Message-ID: <h4k2em6sx5je4yvq26xdelqxxhpnipj6aoq7z6ferpowmfczuv@nib5dh3m45b7>
References: <20260121063738.799967-1-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121063738.799967-1-ii4gsp@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211173-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 472D65D3E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Minseong,

On Wed, Jan 21, 2026 at 03:37:38PM +0900, Minseong Kim wrote:
> synaptics_i2c_resume() restarts delayed work unconditionally, even when
> the input device is not opened. Guard the polling restart by taking the
> input device mutex and checking input_device_enabled() before re-queuing
> the delayed work.
> 
> Fixes: eef3e4cab72ea ("Input: add driver for Synaptics I2C touchpad")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
> ---
>  drivers/input/mouse/synaptics_i2c.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> index a0d707e47d93..fc65e28c1b31 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -615,13 +615,17 @@ static int synaptics_i2c_resume(struct device *dev)
>  	int ret;
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct synaptics_i2c *touch = i2c_get_clientdata(client);
> +	struct input_dev *input = touch->input;
>  
>  	ret = synaptics_i2c_reset_config(client);
>  	if (ret)
>  		return ret;
>  
> -	mod_delayed_work(system_wq, &touch->dwork,
> +	mutex_lock(&input->mutex);

This can be

	guard(mutex)(&input->mutex);

> +	if (input_device_enabled(input))
> +		mod_delayed_work(system_wq, &touch->dwork,
>  				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
> +	mutex_unlock(&input->mutex);
>  
>  	return 0;
>  }

I made the adjustment and applied.

Thanks.

-- 
Dmitry

