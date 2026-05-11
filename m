Return-Path: <stable+bounces-245154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCA5AWOPAWoVeQEAu9opvQ
	(envelope-from <stable+bounces-245154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:12:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC80509E44
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4289930136EF
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE13BA253;
	Mon, 11 May 2026 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm6VS9g+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA83ACF1C
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487040; cv=none; b=ArjjIEtceYWcRa8ibIZw6X5UW/z+0CyHASzDukDOLNrafayEERP/3TPH98qVdz60yDlbOGLx+uLnFgCFbRMpIF1hLByj6VWZof82b81fbks8fqpQwhhf6tD9NwwPxtjZnLWY7Ne8SoKsPVIUluH9VuGaOYAHTfD3sbzIS7eHk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487040; c=relaxed/simple;
	bh=b2Hf8nyIP6xq6oi9O82jXi7fy4vY12OyVdOny1brLIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7DMz/+uJdbcNk60xWO4Z/yBjtajynb/8I1/l5GhhMEvPEvkPxMyoTs8Ga+jGDI597YZXj/7oiNnDCcJcWcEjNZnPczgHSAHhE7V/GanQiwhllYh/9XCWCMCkiWyyVnNA+Ic5ho90bTSObmK4ZwKhIJq6VLRdXomJ5Ke1nzS5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm6VS9g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF48C2BCB0
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778487039;
	bh=b2Hf8nyIP6xq6oi9O82jXi7fy4vY12OyVdOny1brLIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qm6VS9g+aY+cgmcRxvkFG4ik/0BLeYB+ywCr4qvU8uKFa8xRTaRRLYVytt1fzC30i
	 O4S50yhV57DvopBTQGwhwrkjQWSbGxHlsdJ14TbLK8mIWJal+M9eH69+MEw7k6nvHJ
	 BgGHpRvqSDqlTlguLklGzEFrA4PpAkaVQ9mfbTBDTvL2bI5p3p9CyoZlOLlGItpa66
	 o0rvhpHKY9pkJ/YyakMh0NonRpf0LuaFy8CJsJGRnex+BSjm6XlHKfAyB+JCY26Tbq
	 NLjJeXV32zvYe66EW7gTqjEIgBl4/EGFfp8Vw9Fdb2V+dgRCVDhi18k+Az3NhpeplJ
	 qDZLbOngaUdHg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39378db197aso40270841fa.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 01:10:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8cMNyLTre/Fr818WpgXyNh2srkCiJizZ8JXDcIoZrMhOcdVzwQctwrO39BgZXa0BS1uHJh7h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZt3yaxl1GF18gZ/lLxXTVIpGXGfM+Q/QdWh6OLeKAx6uUZoc
	3MjZ8e+plcEQSpuYMTaX90ailA0pPNdlrP+wzFjTijdYYQbf7da6UIYd4x/H48Woj9mOiKcRNFj
	q3KQNx0FcU/r4yfn5/HzDzCMZP7EWsQk=
X-Received: by 2002:a05:6512:3989:b0:5a8:891f:388 with SMTP id
 2adb3069b0e04-5a8b709d36fmr2065976e87.29.1778487033305; Mon, 11 May 2026
 01:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509185108.2681198-1-jarkko@kernel.org>
In-Reply-To: <20260509185108.2681198-1-jarkko@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 11 May 2026 10:10:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLke5Net94=JUCJAyn5YxMx0raCWTUx+Nk6hKhcXxfU-kw@mail.gmail.com>
X-Gm-Features: AVHnY4KCktiDIjkKY1XWWWRgXjTjZN7hq0huZFtBQUeQG6bYGoySbiCtgkgk8wA
Message-ID: <CAD++jLke5Net94=JUCJAyn5YxMx0raCWTUx+Nk6hKhcXxfU-kw@mail.gmail.com>
Subject: Re: [PATCH] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ECC80509E44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net,gmx.de,ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245154-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 9, 2026 at 8:51=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:

> wait_event_interruptible_timeout() evaluates its condition after setting
> the current task state to TASK_INTERRUPTIBLE.
>
> With CONFIG_DEBUG_ATOMIC_SLEEP this triggers a warning when the IRQ wait
> path is used:
>
>     tpm_tis_status()
>       tpm_tis_spi_read_bytes()
>         tpm_tis_spi_transfer_full()
>           spi_bus_lock()
>             mutex_lock()
>
> Address this with the following measures:
>
> 1. Call wait_tpm_stat_cond() only while tasking is running.
> 2. Use wait_woken() to wait for changes.
>
> Cc: stable@vger.kernel.org # v4.19+
> Cc: Linus Walleij <linusw@kernel.org>
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Closes: https://lore.kernel.org/linux-integrity/6964bec7-3dbb-453b-89ef-9=
b990217a8b9@gmx.net/
> Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> Linus' change only unmasked a pre-existing bug but it is the change
> realizes it in tpm_tis_spi.

Took me a while to understand this but looks right to me!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

