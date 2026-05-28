Return-Path: <stable+bounces-254703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALbTOSKtF2qiNAgAu9opvQ
	(envelope-from <stable+bounces-254703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:49:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 474935EBF70
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C4B315AEC5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D592FD695;
	Thu, 28 May 2026 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Z35J1pDk"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419B253B73;
	Thu, 28 May 2026 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935989; cv=none; b=Zl+JlciVPlNQI9XwKZ2vNQs4EGYV3tEFaE0YNiaQKS1cDA6QqcQxOMSZDhy57j3UwZogfS+Af++oqBO6Oa25RQjgUPfojZJecuQOw8IUBH6Q6Mvn70UE8J6RkqnkJ5MyE6cjrN712aMHDzrHa2QWnZvmm0qMuQI6GM4a9k1AZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935989; c=relaxed/simple;
	bh=Z1msgMieJPoKHWwbYG4wautYzQii+jhNw79PfJkeJQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZw8sod4XzImO57x7f2D0cg5z+Hvd7MpGdlsyF8Qp1Sn6twkmdHM8UW20LVz5UKQYXLCh60zA+odD8EQ5BQ3WdVQjtWa46WfaOZdXsFGvUFW2QKqIcFvFb+t0aal9o1M3oaYkE440eOcJcmb1tEkkugk0qYdK+YcZiJhkpDftfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Z35J1pDk; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779935979;
	bh=eM5Kf2P2muqD9TDUqOMWCASBAGRx4JfmKuvQ3t+VEmc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z35J1pDkWScazd7mwG3uLPYiBbgI8AxeSF82eyetT7NzyYANr9E5hOepMlXVCJckG
	 KgVIdUD0+Gg3vqMgmAOU902wo59c1AzBwTAnP6koDdAKWspvlPE0Nn9RbnrNolWruK
	 LEq5FHltSck7rbMkXEgQPqNX5bo/tuXDQxggQOE6JRSFmSY31k2lLmZBHOQWSS4FCL
	 3ANQpOj+R49xpC6TBKkZE34Bzr2Zmv2lQtv7nn4DQy08I4iFSvLY9tJQPKsLjLJaYS
	 kekFyQCTWCAg1UW1SiRzE5LBv5JNYSm4QRlz2uqrrdwvEMyiJ41sJh9Mm8fq3hUzpt
	 3rSQDL7upkB3Q==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9171B6001B;
	Thu, 28 May 2026 10:39:35 +0800 (AWST)
Message-ID: <1e2b77c7916259e3e269d19f637c29427c175350.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 28 May 2026 12:09:34 +0930
In-Reply-To: <20260527175939.2939714-1-karthiproffesional@gmail.com>
References: 
	<53952f011f2c57ad28d6f864317054a2a34922e5.camel@codeconstruct.com.au>
	 <20260527175939.2939714-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254703-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@codeconstruct.com.au,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:mid,codeconstruct.com.au:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 474935EBF70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Karthikeyan,

On Wed, 2026-05-27 at 17:59 +0000, Karthikeyan KS wrote:
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/a=
speed-lpc-snoop.c
> index eceeaf8df..ef6697a42 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -60,6 +60,7 @@ struct aspeed_lpc_snoop_model_data {
> =C2=A0
> =C2=A0struct aspeed_lpc_snoop_channel {
> =C2=A0	struct kfifo		fifo;
> +	spinlock_t		lock;
> =C2=A0	wait_queue_head_t	wq;
> =C2=A0	struct miscdevice	miscdev;
> =C2=A0};
> @@ -93,7 +94,11 @@ static ssize_t snoop_file_read(struct file *file, char=
 __user *buffer,
> =C2=A0		if (ret =3D=3D -ERESTARTSYS)
> =C2=A0			return -EINTR;
> =C2=A0	}
> +
> +	spin_lock_irq(&chan->lock);
> =C2=A0	ret =3D kfifo_to_user(&chan->fifo, buffer, count, &copied);
> +	spin_unlock_irq(&chan->lock);

This seems inappropriate and I expect is flagged if you compile with
CONFIG_PROVE_LOCKING=3Dy or CONFIG_DEBUG_ATOMIC_SLEEP=3Dy. I suggest both
if you're not already.

Further, I hit conflicts when applying your change on v7.1-rc5. Can you
please ensure you develop, build and test on recent releases.

Thanks,

Andrew

