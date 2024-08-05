Return-Path: <stable+bounces-65387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6D4947CCE
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3A11C21D8E
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3613A884;
	Mon,  5 Aug 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJ7rhVVY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7D3EA64;
	Mon,  5 Aug 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868099; cv=none; b=apRCEaBYjWV3bWOUaTXY0JxSQ+T72uZO1qatRlKQpCnOr51MzrzTtpw1E5NtS2FMat/6Lt6bY4EjTBBk2W1BoggrMqo8jtMIpndSoRGQtjjzj2bdsfT3tIjSTwnqTYXSABQirr8vkpyOA89huWUgxo+qFsNgDIS2rjH2orjDHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868099; c=relaxed/simple;
	bh=yKbtl95xINhTP7J1jRhAX6V0rXoLD64gANcmv8E/gsw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HROIrX8XtjoUXo+0iEMojhvdrA1kuL2jHG2ZC7XDvcdZXkRFCNPYvTGgLSO9xEXXuFWNuWJbGGF7myUufjMbcYprTmzG3QnJdGhk+QHed8BSowsqeRo6AjzCbt0iTFJHIyiHt9whfJchEu5KDWOgIbF2bBvrxZF4ldWKX58TL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJ7rhVVY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722868098; x=1754404098;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yKbtl95xINhTP7J1jRhAX6V0rXoLD64gANcmv8E/gsw=;
  b=BJ7rhVVYY51YFMXoMkRwJ28qoJ/lPLumbUEs0NoZ9bB03cfO6HtNrx9M
   fP2+rRQUaqwVw6S+C2CrB0CrT2XC2vwv4aNwTUFKISf5YdYF3+CMbfo/q
   8Y+nqLRXiVAbJPGIl5YRbo40IEUwGt39qNG8/GzukyPg7Sc/K1CHa5URd
   qGDFNNK8fTBiTJTiOolFjCTJFxWT1QJ+KpofPQfqLkNHShRwXFcMwKeXx
   E69wXbfLknT3LHaA8yXhjIL6d2G3K45y6AFUAoob+3IzZAIHWez8q6LVh
   +JfCRChzKXiPKylhcpNnC5HT7N/UfcBnJ+aTWxdB+VhInce/G7xzCaacR
   Q==;
X-CSE-ConnectionGUID: UmpTSRWKSSiSNy/80IELHA==
X-CSE-MsgGUID: P5K+ZroUQQ2oGeQRNr2HVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="38340355"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="38340355"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:28:11 -0700
X-CSE-ConnectionGUID: Ric531ExQP+mpO47+vxDCg==
X-CSE-MsgGUID: /6vJNaXKRhipark9yiKOQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="56123772"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:28:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Aug 2024 17:28:05 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
    Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 03/13] serial: don't use uninitialized value in
 uart_poll_init()
In-Reply-To: <20240805102046.307511-4-jirislaby@kernel.org>
Message-ID: <84af065c-b1a1-dc84-4c28-4596c3803fd2@linux.intel.com>
References: <20240805102046.307511-1-jirislaby@kernel.org> <20240805102046.307511-4-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-792570173-1722868085=:1238"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-792570173-1722868085=:1238
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 5 Aug 2024, Jiri Slaby (SUSE) wrote:

> Coverity reports (as CID 1536978) that uart_poll_init() passes
> uninitialized pm_state to uart_change_pm(). It is in case the first 'if'
> takes the true branch (does "goto out;").
>=20
> Fix this and simplify the function by simple guard(mutex). The code
> needs no labels after this at all. And it is pretty clear that the code
> has not fiddled with pm_state at that point.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Fixes: 5e227ef2aa38 (serial: uart_poll_init() should power on the UART)
> Cc: stable@vger.kernel.org
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/serial_core.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 3afe77f05abf..d63e9b636e02 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2690,14 +2690,13 @@ static int uart_poll_init(struct tty_driver *driv=
er, int line, char *options)
>  =09int ret =3D 0;
> =20
>  =09tport =3D &state->port;
> -=09mutex_lock(&tport->mutex);
> +
> +=09guard(mutex)(&tport->mutex);
> =20
>  =09port =3D uart_port_check(state);
>  =09if (!port || port->type =3D=3D PORT_UNKNOWN ||
> -=09    !(port->ops->poll_get_char && port->ops->poll_put_char)) {
> -=09=09ret =3D -1;
> -=09=09goto out;
> -=09}
> +=09    !(port->ops->poll_get_char && port->ops->poll_put_char))
> +=09=09return -1;
> =20
>  =09pm_state =3D state->pm_state;
>  =09uart_change_pm(state, UART_PM_STATE_ON);
> @@ -2717,10 +2716,10 @@ static int uart_poll_init(struct tty_driver *driv=
er, int line, char *options)
>  =09=09ret =3D uart_set_options(port, NULL, baud, parity, bits, flow);
>  =09=09console_list_unlock();
>  =09}
> -out:
> +
>  =09if (ret)
>  =09=09uart_change_pm(state, pm_state);
> -=09mutex_unlock(&tport->mutex);
> +
>  =09return ret;
>  }

This too needs #include.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-792570173-1722868085=:1238--

