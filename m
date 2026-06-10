Return-Path: <stable+bounces-262433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YXWjEi8KKWrWPAMAu9opvQ
	(envelope-from <stable+bounces-262433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 08:54:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A580566668C
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 08:54:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="lw/Zxtk/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262433-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262433-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD8D3311A21F
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35D381B10;
	Wed, 10 Jun 2026 06:52:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F53812EC
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:52:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074367; cv=none; b=BTkZ0VEOQK8P2hPdI5oaEQmSawVawtCidD+VxON38NVvHQs1KXduifqnYC5ti6U3L3UnoXSQDP+k2Ehm7f8MMkjY/EwlMJ9Sw5Qm7c4s8etykKfmbMh102ebgQJhM8Hg2XIEVdfYCZq7lo6EPd1UEeHDVZlY2KdjG2X65f2rGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074367; c=relaxed/simple;
	bh=vOnGpFzXQy6Ue55vjQTHyr5ELkmmon8dURMGdcmFhq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqtjTHrgWQpzjsrq69CtiqEydwu9pGPMzDgL9v+MTRM6te1RUeWvIJTbgk4GueLdf8vXY5VC/BJy742ZWURSIzbyHl+mN4wUgoMFKWOqgVYghVqpBHaUFhL9hTBPAQ/YfeUT7R6d2XLlKu9tfmm4tMBWzpVyoIFaQBeA/aWkBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw/Zxtk/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0C61F0089C
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781074365;
	bh=gp7gs+XC0EzFwQ29+WJ2/FdyGtwF8lME7kmYDPgSmxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lw/Zxtk/uYBjSvZYWFj6HdIOEj+NSHDSM7Z42xZclJNvYzAOKkJlN3S4ZX1iYYLfa
	 xQ7XK3CCGbC0AAf5fQOPf5l4kbcwJkt5J3000ORpx7Kt0Kvnm+nAOnnF7t/dZbioAv
	 v8B+ewve1MWTUuFEejffYYPdmStl0WBwgRTir9pfL96l7yR5cu4oStHagQ+Im6O/yS
	 o20fgBTPEBAmVnXV1dy15i5M2RxfJuzkXgW/FGjJXfhyvLQKdsZOUoItpXu5HxCjn8
	 Y56NYqxRGpOvv2o2dMebqi+y/CEIuH9KHZAK2TmrWgZMUhfUPWbSq4GvH9M4UxcSBS
	 c97GPUlCxoz8g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-397e391cb2aso26704161fa.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 23:52:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+5iDRyL6wlgYca/gBLqqv/npyWikEARnDTFsoIbOop32C8MPCUaVcLs67/6SpcaPwuishTAdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBs9jvmnAtOeQYxCvtwVlaias6CZUGi6Ham4f35Jm3Jy98YK2g
	dpt/WQtRumLTadWivVSAIoA2MVztZ+UUqVF7SamH9PpteHidkQF1jQ83bqTL/znphAe6DBInkc7
	RpwEbG3HD2HSgj31ZPxyebA7mDAAuCK0=
X-Received: by 2002:a05:651c:2116:b0:396:71a5:783 with SMTP id
 38308e7fff4ca-396d08af1c7mr65181281fa.10.1781074363645; Tue, 09 Jun 2026
 23:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609121329.1262170-1-senozhatsky@chromium.org>
In-Reply-To: <20260609121329.1262170-1-senozhatsky@chromium.org>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 10 Jun 2026 01:52:31 -0500
X-Gmail-Original-Message-ID: <CAGp9LzpBUReZtrTEKgUr-+yvB+3tcs5hw7ziC4WaMRFNa2AYpg@mail.gmail.com>
X-Gm-Features: AVVi8CfFDZy0_kkkc64au-27MTcEf01nNZPOagVpGocBD_aPXkss6uRWyZD9Xok
Message-ID: <CAGp9LzpBUReZtrTEKgUr-+yvB+3tcs5hw7ziC4WaMRFNa2AYpg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Mark-yw Chen <mark-yw.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Tomasz Figa <tfiga@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262433-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,mediatek.com,chromium.org,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:senozhatsky@chromium.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:mark-yw.chen@mediatek.com,m:sean.wang@mediatek.com,m:tfiga@chromium.org,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A580566668C

Hi,

On Tue, Jun 9, 2026 at 7:19=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Every once in a while we see a hung btmtksdio_flush() task:
>
>  INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
>  __cancel_work_timer+0x3f4/0x460
>  cancel_work_sync+0x1c/0x2c
>  btmtksdio_flush+0x2c/0x40
>  hci_dev_open_sync+0x10c4/0x2190
>  [..]
>
> It all boils down to incorrect time_is_before_jiffies() usage in
> btmtksdio_txrx_work().  The btmtksdio_txrx_work() loop is expected
> to be terminated if running for longer than 5*HZ.  However the
> timeout check is twisted:  time_is_before_jiffies(old_jiffies + 5*HZ)
> evaluates to true when old_jiffies + 5*HZ is in the past i.e. when a
> timeout has occurred.  Using OR with time_is_before_jiffies(txrx_timeout)
> means that:
> - before the 5-second timeout: the condition is `int_status || false`,
>   so it loops as long as there are pending interrupts.
> - after the 5-second timeout: the condition becomes `int_status || true`,
>   which is always true.
>
> When the loop becomes infinite btmtksdio_txrx_work() loop never
> terminates and never releases the SDIO host.
>
> Fix loop termination condition to actually enforce a 5*HZ timeout.
>
> Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to wo=
rk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/bluetooth/btmtksdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.=
c
> index 5b0fab7b89b5..c6f80c419e90 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_struct *w=
ork)
>                         if (btmtksdio_rx_packet(bdev, rx_size) < 0)
>                                 bdev->hdev->stat.err_rx++;
>                 }
> -       } while (int_status || time_is_before_jiffies(txrx_timeout));
> +       } while (int_status && time_is_after_jiffies(txrx_timeout));

yes, loop continues only while there is interrupt work and the timeout
deadline is still in the future

Reviewed-by: Sean Wang <sean.wang@mediatek.com>

Thanks for fixing this long-standing  issue.

>
>         /* Enable interrupt */
>         if (bdev->func->irq_handler)
> --
> 2.54.0.1064.gd145956f57-goog
>
>

