Return-Path: <stable+bounces-227942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOUTKoQQwWk7QQQAu9opvQ
	(envelope-from <stable+bounces-227942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:05:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3BC2EFA53
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 588D1300D4DF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCDE38910B;
	Mon, 23 Mar 2026 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI6IM9Fr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB4389106
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260329; cv=none; b=q0Uhj1v4T2wSHLdJsrtmreLRfk0odV9n6QEDWqEtFPAMQtfIT9rg1GFkbJtfUtdJYdb/5Ogdj/Ix6dVtLtyqBheuRsxo6KwuZ7hCz1CpvmpdeoAleBo9sWJHbymDAHaP8ddBti3E25+HYH+XyJ9Bk3oTg3cN4X0nNPfZRiNxSbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260329; c=relaxed/simple;
	bh=mwJTfzyIkiCnBdE3dUrQSRT9nG31XqWTIh4BHAmaAOQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRDltY29cbrygdmtdCIJeVdn1EKMukJrqT84EpIc/0GFZutE1ZXPFP1YdRcMukDUioLGsxpmPio7Len9JCqSWkrIj2jD123M6HMqrZZ9JScEqDYObS/zeQORE2jHftdbbrT2qqhPRcinigsaZ0+hbwNg2fNaqA5f/sv5a5of4Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI6IM9Fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A462FC4AF09
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774260328;
	bh=mwJTfzyIkiCnBdE3dUrQSRT9nG31XqWTIh4BHAmaAOQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=kI6IM9FrMzUJ3JvuxvAN63ykyFjmIoJVdfnMjhUEx2TexPNRF7qnPOau6F7FgraGM
	 gjkO3HF4cMRYJ5kS7BadFTJG9ZAB4PDIvVRZXKPskJAC9jYpx1+P687X6bWLIG25iX
	 sLyYOB35ufZNincMyui5AAiAIIjn1u/SHxPCeiETufYjZRtDtxLxFOt7cpg1vjsALn
	 8UPvP3BoIXv3hetzvfTiga1Bdr6b9Glh0aI3ze/zQS1aoC26GXXi/j8i0iiktKhQKd
	 A6yxmQu8e+pKbKFG83fOQOblBV/2p6Z2iiuW+cfTczVVp+qyPxlQa7gU0xyraJRxs0
	 N9kUX9FkW8wFg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38a23dd61c1so33056971fa.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 03:05:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YwGLFykjL57VdthXJeOqOUXA+lHDIUZHqSkJT2DfbvLDSl1rCB1
	I+lWaYH+d5n9etYl2P250lF+RF1yKVCA++9XxQgtMqVk3x7OJ34j0mbq/IiMeBkDlQ3QW2u9Odn
	q7cGqzugZVYQzNkEvNpKaWtb5j3e2a4KL17NtHQnG4Q==
X-Received: by 2002:a05:651c:1b12:b0:38a:3374:f908 with SMTP id
 38308e7fff4ca-38bf9685a23mr37877011fa.16.1774260327303; Mon, 23 Mar 2026
 03:05:27 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 03:05:26 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 03:05:26 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260321074240.796922-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321074240.796922-1-lgs201920130244@gmail.com>
Date: Mon, 23 Mar 2026 03:05:26 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfLQFbFhJ+sKQSf52xSRLMSoS9q+utDk=AjMT_XJJ7Z1w@mail.gmail.com>
X-Gm-Features: AaiRm52jqR2dzLlhYt1j2cvt2cxvKqTDT6oEarBLzD2_vfQ7PEYDbMtrTWzmqtU
Message-ID: <CAMRc=MfLQFbFhJ+sKQSf52xSRLMSoS9q+utDk=AjMT_XJJ7Z1w@mail.gmail.com>
Subject: Re: [PATCH] reset: gpio: fix double free in reset_add_gpio_aux_device()
 error path
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227942-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4B3BC2EFA53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 21 Mar 2026 08:42:40 +0100, Guangshuo Li
<lgs201920130244@gmail.com> said:
> When __auxiliary_device_add() fails, reset_add_gpio_aux_device()
> calls auxiliary_device_uninit(adev).
>
> The device release callback reset_gpio_aux_device_release() frees
> adev, but the current error path then calls kfree(adev) again,
> causing a double free.
>
> Keep kfree(adev) for the auxiliary_device_init() failure path, but
> avoid freeing adev after auxiliary_device_uninit().
>
> Fixes: 5fc4e4cf7a22 ("reset: gpio: use software nodes to setup the GPIO lookup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/reset/core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 0135dd0ae204..58ecde760b6e 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -856,7 +856,6 @@ static int reset_add_gpio_aux_device(struct device *parent,
>  	ret = __auxiliary_device_add(adev, "reset");
>  	if (ret) {
>  		auxiliary_device_uninit(adev);
> -		kfree(adev);
>  		return ret;
>  	}
>
> --
> 2.43.0
>
>

With recent changes in reset core this all went away but yeah, looks right
and should be backported.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

