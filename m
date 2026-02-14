Return-Path: <stable+bounces-216496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHsuMvvLkGn3cwEAu9opvQ
	(envelope-from <stable+bounces-216496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 20:24:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0578A13D056
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 20:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FE4C30209C0
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0CC1E3DCD;
	Sat, 14 Feb 2026 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="rgne2MZh"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDD63CB
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097080; cv=none; b=JUlnPXLRIJfsTVS2f7jADXoRSvMQeaCfHwDlmsgsjKPICnu/JEPighAeKNjgJLDqIZf96ucl4nVl0sfQrgg0L7xQLnY+f28x5OvXELiaZHoYiHGai8vcJLZmiUgeOZlpprkAOuzwQnge64d9l8Vs0SDZLnDqQPZRMtu30yNniQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097080; c=relaxed/simple;
	bh=Kp44IYqk+wOuxpGu7TZUv8EHFqbVtfis/wSiM2ihV/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b2OmQ+8tWGpD2LdFS3sPrTLvpoeM3u0yPlyqJ+mXRd8zfqsthW9wqtDepI/BZSmMWdrZvGp+RAa/b/9KjECJbP6MuDnw1MGAPmmQ79JXb7Qb4HrSzsLBtHRoIFtzSnq+Ns7GAecrZUmVyGU2ffNXEAdyoOPpQQu6Mn84+f6Zu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=rgne2MZh; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.28])
	by mail.ispras.ru (Postfix) with ESMTPSA id 23979406C740;
	Sat, 14 Feb 2026 19:24:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 23979406C740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1771097076;
	bh=ntMNzgclp/GdxjkGoBg0gNkZ62yb0h9Uw6t9gxqnK04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rgne2MZhX5gNbZZ0SvPSfsVqIuUc+1G9dzw744cqeFmiuPFp+zqQPY1lhQQ09sv+j
	 AW1+jp2lbYFELQNHg1HynjaNf5XaRCh09AG4dwRaMlMlS2PLNOw0obe980jUNVCEAK
	 qq2LScEA1j5QNf+T7fiMkFpffc0VeuAQJVgGq1x8=
Date: Sat, 14 Feb 2026 22:24:36 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Sasha Levin <sashal@kernel.org>
Cc: Gui-Dong Han <hanguidong02@gmail.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y 2/2] bus: fsl-mc: fix use-after-free in
 driver_override_show()
Message-ID: <20260214220547-5519e7b20a4919ddd81d97c3-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260214010236.3700986-2-sashal@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216496-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ispras.ru:+];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,kernel.org,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0578A13D056
X-Rspamd-Action: no action

Sasha Levin wrote:
> From: Gui-Dong Han <hanguidong02@gmail.com>
> 
> [ Upstream commit 148891e95014b5dc5878acefa57f1940c281c431 ]
> 
> The driver_override_show() function reads the driver_override string
> without holding the device_lock. However, driver_override_store() uses
> driver_set_override(), which modifies and frees the string while holding
> the device_lock.
> 
> This can result in a concurrent use-after-free if the string is freed
> by the store function while being read by the show function.


There is no upstream commit 5688f212e98a ("fsl-mc: Use driver_set_override()
instead of open-coding") in kernels 5.10 and 5.15.

This means the concurrent driver_override_store() in fsl-mc driver doesn't
have a call to device_lock(), and the race would still exist.

5688f212e98a does apply to 5.10.y and 5.15.y and build cleanly AFAICS.

--
Fedor

> 
> Fix this by holding the device_lock around the read operation.
> 
> Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Link: https://lore.kernel.org/r/20251202174438.12658-1-hanguidong02@gmail.com
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 7b0c58f31acf2..48e5990394a51 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -194,8 +194,12 @@ static ssize_t driver_override_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> +	ssize_t len;
>  
> -	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
> +	device_lock(dev);
> +	len = sysfs_emit(buf, "%s\n", mc_dev->driver_override);
> +	device_unlock(dev);
> +	return len;
>  }
>  static DEVICE_ATTR_RW(driver_override);
>  
> -- 
> 2.51.0


