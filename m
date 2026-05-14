Return-Path: <stable+bounces-247226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCPFC1rlBWoAdQIAu9opvQ
	(envelope-from <stable+bounces-247226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:08:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD9543BC8
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3015E301021F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8960F3BED43;
	Thu, 14 May 2026 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6mpcuPU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C13DFC80;
	Thu, 14 May 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770494; cv=none; b=ElVIE0GbuGW9t3d2aQg2DVS/pys0NPt+XuRL2tImbQ2FOQzLjIHAFqwygsSr7H6Z4qrUbotxG0DsdFDiP27XuvIl1WIqdeEYHikR3YUiZ7DmYFwfzieMA9CKLZAO/VOE+lmIpqw5EyvdEhvby3FcvO4sm8CoBXaWq41m7imh7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770494; c=relaxed/simple;
	bh=S3R5Vazk4xEatM1Ikirj4HAPOqFoNCbbTqLk41Ty2CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leiWueZZT5QBgcaiy/JS9sr9cKo4fynlpKMULkV1kyPi3+7qHES+OqP8aGjmQqCH3AXr1JBCSTybHpY80bXxu7AQDNCaVCTMyvpElHR4/2PG0FYtooaGYgRjXyT/eN64L7p4GRwyDbHzQbK1+xqND4Z5xEgpIfEj3DazFBWHQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6mpcuPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE666C2BCB3;
	Thu, 14 May 2026 14:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778770493;
	bh=S3R5Vazk4xEatM1Ikirj4HAPOqFoNCbbTqLk41Ty2CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6mpcuPU8NaRIyrMj7io3gRapCfD2xtcSUBf7ez5kLu6wFzfgm5JYDY6C8TgTkSUJ
	 gIH3GgnnQW65TFORCKh5Et3NLYW7UJhZ5QRU60bp1JLx2xl+cwXMe/a0MICZncEEvK
	 NabR99KAC3FqL6U8DD4kWNWS/oAKFGQm1/luxrcWILvrcztv0vBVXCyNrtpbe0TxNz
	 Mexh6XpTDcbDrjwHHmj7f+czKQnfLySB/eDazvjktDcQMPEz7nkcTB2QOi0l0PpIMS
	 RX7KT2pmUQvXu1WZkQjVOHWL9oS5BUXAaoYrhYPndYQ6r4ZmWqdzKsMmXJ1oPZQogp
	 eFshWOKZ7NJAA==
Date: Thu, 14 May 2026 15:54:50 +0100
From: Lee Jones <lee@kernel.org>
To: Valery Borovsky <vebohr@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mfd: sm501: fix reference leak on failed device
 registration
Message-ID: <20260514145450.GN305027@google.com>
References: <20260504124841.443496-1-vebohr@gmail.com>
 <20260506154040.672860-1-vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506154040.672860-1-vebohr@gmail.com>
X-Rspamd-Queue-Id: 24AD9543BC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247226-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 06 May 2026, Valery Borovsky wrote:

> When platform_device_register() fails in sm501_register_device(), the
> platform device allocated by sm501_create_subdev() has its struct device
> initialized by device_initialize() inside platform_device_register(). The
> error path logs the error but returns without dropping the device reference,
> leaking the memory allocated by sm501_create_subdev():
> 
>   sm501_register_device()
>     -> platform_device_register(pdev)
>        -> device_initialize(&pdev->dev)   /* kref = 1 */
>        -> platform_device_add(pdev)       /* fails */
>     <- dev_err() called, kref still 1, sm501_device_release never called
> 
> The device's release callback (sm501_device_release) calls kfree() on the
> containing sm501_device structure. Without platform_device_put(), this
> memory is never freed.
> 
> Per platform_device_register() kernel-doc:
> 
>   NOTE: _Never_ directly free @pdev after calling this function, even if
>   it returned an error! Always use platform_device_put() to give up the
>   reference initialised in this function instead.
> 
> Fix this by calling platform_device_put() in the error branch, which
> triggers sm501_device_release() and frees the allocated memory.
> 
> Fixes: b6d6454fdb66 ("[PATCH] mfd: SM501 core driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Valery Borovsky <vebohr@gmail.com>
> ---
>  drivers/mfd/sm501.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I don't see a message from me acknowledging this, but it is applied to my tree.

-- 
Lee Jones

