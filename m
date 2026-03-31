Return-Path: <stable+bounces-231380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKNQObGfy2loJgYAu9opvQ
	(envelope-from <stable+bounces-231380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:19:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1ED367CCB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 388D7305C331
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9AA3CD8D7;
	Tue, 31 Mar 2026 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBADqEWy"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A93A1E73
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952061; cv=pass; b=SnEDDZaIMdXqynTdH84VoZHKE/MkfsIVOvBKs40/1LWM+iR7WoTcgTW9IxpIN0w30YIQy9IUwJ0KQY7/Xz4J1FXCCK9yCMDXveq1hMCkAPP5k0MXPrM3K/LfB7uJi/7GKZmFRuQmH902WkyolgCt0+bkZU0U59oVnQqtJCIfQEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952061; c=relaxed/simple;
	bh=x+hWUIPclyR7BqlGWjp+2Cw6RFCkNpm6eMx7G4FvPDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpdiqXJCAMf4vCg6P8dhAbIZzkOQULJP45AvTxAt7ubkEeH9ssMyteMDCWyKC4Ch4C8mCqVhz6EWPP/s/jmumV+HrqvWySJowwifxnWAKd1AkufcM6TBRPzLPdfXo/syKXwMwuI2RIzSZhHSCopiItS030WEIWTSi8f20DARBj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yBADqEWy; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a2b636b944so1694320e87.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 03:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774952058; cv=none;
        d=google.com; s=arc-20240605;
        b=j0Pa8NHMMTf4Vcz2jBEMy12hH+5+YahueBRjHGCYwIdVR5dlpMFxceOmR/kc6mkm18
         cPYHgQVFrjxDdQuOqEra+cY/DuD8WhOm3kbX/Wi9B8CbKY7VAWpfYcK9ty+KacKqCCqI
         I5oXY6/s+yYtU6h5ejVaWYQbD0vW2fTdxE6wwGzgchMVssgTz+8ZxhietGcFFM0q6dJ+
         0/f2p6bq0riCwpwjc/Nf6sgxOKfv5OE6zvcul/KUTib36R8obGmfY61OakeTmvkbBlQ1
         ZBiaKdiedfm1NlwkCpTEGcQQQsdgRfyjjuoYYEX7/VLH3gK2vj1PJUEpO3WbAlqLl5rQ
         wGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mx/+M5uRKYIghnrRmqlR7yaaW+6rwphedvm5LQykdMQ=;
        fh=hL0AuckgDbKyfkhs6bLwe+l+jjwr39TlbZBUnmlsm6U=;
        b=LM5vFz9xEqpDiw3B/euH7ZIv40MW9cJ3vcLgDLbJTRSXB+I4bP58yqC6aHGkNG04G/
         XVP0yTxIRPLHJia1c0EpHgvYwBj4dpdFS5aNZHaHBHsU6Z+KBMCJFn9TZMAxLuyUb77F
         id2dCiMcfiZ3QWIJpJcAFPeiYptf7HYY4VdAQVw0nqGYuFV8lcAZIPwoEcpMuOOs6ncL
         RLR26RyIKTbUANlJ5cIlV+bNE+402iMZKH1u5gSnh1vUahUsFcE25Xc1jylD7LK+nYi4
         UFp6qwx4vXW2EnTqK+AlTgDQtbiPz8e6jNqnHOmebpQUVnLe4D1+SljfaEiNAeV09+s2
         JSBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774952058; x=1775556858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mx/+M5uRKYIghnrRmqlR7yaaW+6rwphedvm5LQykdMQ=;
        b=yBADqEWyvu6kWKxswsWYb4rfsjbY9TnaWI9Rftfd0FZVeZl2VnLuhFojT9kGyuOF2Z
         dZYeUw/TbFiUqemUlcymIg+XYRL8nQxcIRw4w6fSRPG8k7mU3g2xq/eyWLLvmq1LoZqP
         j/H6bNTRHAiTFjxiUi1hexz7MA18GXakHTIxOhUIF1THoA6WJ3fsw3uZs5oEALk4ktmx
         yo1Y7yqgKgnUkoGOEdsUNnD0j3THyyKkLmeFQcEsAsPEtlJKHAI3Sgst72xDU5oSaDoo
         pAPazmapPAcvNk1Vxu4th5Qzu3uEEc489clOoqMzAFA2BQX0LpMHIjEyEaM00RXzzhMw
         764w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774952058; x=1775556858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx/+M5uRKYIghnrRmqlR7yaaW+6rwphedvm5LQykdMQ=;
        b=Y3cVZYl6KGUCac4iDQWkEO1PfPBrxiAbOEn0WY/97A3u6mrY4hZLpdk9gyVNzBh81Q
         DAcNSRU2AkntTldSVMKZ/RVudI3AEORcnz7Kxn902zlODc2q9YCiKkrzbcqhnpQ1p5Zl
         SZ93soFhdCu6KUMq1BM26qjbnP+nz65Fi+qmi3JS05USN3ksLu2mGF0HMyaSiQxtK8Ew
         fKLkowRscIX5X8mVz/vIVEffB4tckTYfw8q1YDYTFWraFQ/PfDZqlVbXtOyKcc99ALNj
         cW3IA8uUjgu7GQ+KzHkbyPPGoQTPlJrtCvMVcguiqiQb5JZXFXLgoJ2SKDxlqzYFyAGW
         jUWw==
X-Forwarded-Encrypted: i=1; AJvYcCW7wfXeDfNT7+3j7DK+bpxedG/5pauFy1RBWL6oUKNHV9GgK0JQzSQIJzeFiKVLfPqQH13VFh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zYb4Mz7zujsbfWpG1GP0+EYn/IfYD2gz6L6ifqXnvjb3CDlD
	oqqIngXtBn1/ih3UpjoNZB4ZBM873i36UoWZSv6nEkAesm8XaM+WVJLkZN4Qv6namzQ6iyGnk3y
	vjQCeq4gem4khjWPIFMkRv0J8SS5GWXA7byrPdOfMnPyjCTVa38gIhVA=
X-Gm-Gg: ATEYQzxdTor3kIaExMD1ZFTB76UtKeNXoCdK+d3u+hkgtbyGbD4zy9eDaV52j9t8C/Y
	r6xB3Cy1cqBPMnB70N0MDliIjUcnTyQp8PWuvk8EMhvDp985ONxzTp33t/jxp5q0zPHAV8x+R2j
	AutteeEaz/Tis1XFDtb2D7Jr6iBnN2edXHMVkEaMRqkhQtf5GaNvXPVKYVEQ8emS92Z8jFVf4mP
	35csT75qV64rI81pb7ETJqaCots6NWMPw33cOdy5zRvq8vXxzK1HLswiZvhT4GGjMzIf+KL3nFo
	koC4+3pN
X-Received: by 2002:ac2:4307:0:b0:5a2:c05c:1199 with SMTP id
 2adb3069b0e04-5a2c05c141fmr148052e87.15.1774952058111; Tue, 31 Mar 2026
 03:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327105208.1310739-1-johan@kernel.org> <20260327105208.1310739-2-johan@kernel.org>
In-Reply-To: <20260327105208.1310739-2-johan@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 12:13:41 +0200
X-Gm-Features: AQROBzCGShN7LcmS5ZDY0r5zMcz3ndnLqxaBtBqvP89b7e8uYTHkjABOijCfaBI
Message-ID: <CAPDyKFp1DbRufpro86fXi9xXnJGbWW=NrD3Q0NFQ+aHxhxogLg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: vub300: fix NULL-deref on disconnect
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tony Olech <tony.olech@elandigitalsystems.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231380-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:dkim,elandigitalsystems.com:email]
X-Rspamd-Queue-Id: 7D1ED367CCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 at 11:52, Johan Hovold <johan@kernel.org> wrote:
>
> Make sure to deregister the controller before dropping the reference to
> the driver data on disconnect to avoid NULL-pointer dereferences or
> use-after-free.
>
> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> Cc: stable@vger.kernel.org      # 3.0
> Cc: Tony Olech <tony.olech@elandigitalsystems.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mmc/host/vub300.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index ff49d0770506..f173c7cf4e1a 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2365,8 +2365,8 @@ static void vub300_disconnect(struct usb_interface *interface)
>                         usb_set_intfdata(interface, NULL);
>                         /* prevent more I/O from starting */
>                         vub300->interface = NULL;
> -                       kref_put(&vub300->kref, vub300_delete);
>                         mmc_remove_host(mmc);
> +                       kref_put(&vub300->kref, vub300_delete);

While this seems like a step in the right direction, I don't see why
calling usb_set_intfdata(interface, NULL) and assigning
vub300->interface = NULL is safe.

For example, some of the workqueues might be running a work that uses
the vub300->interface, isn't that a problem too?

>                         pr_info("USB vub300 remote SDIO host controller[%d]"
>                                 " now disconnected", ifnum);
>                         return;
> --
> 2.52.0
>

Kind regards
Uffe

