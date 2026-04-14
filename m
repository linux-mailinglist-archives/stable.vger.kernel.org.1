Return-Path: <stable+bounces-237717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ms5FNZ2/3WnMigkAu9opvQ
	(envelope-from <stable+bounces-237717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 06:16:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5603F574F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 06:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF7573012BF8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 04:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A70C25DB12;
	Tue, 14 Apr 2026 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5jqSIxx"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AA19DF4F
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 04:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776140186; cv=pass; b=l+rK5dlBzup+V3w6HuPKQt18cbgKzCDJgyBe/hNDjH0yEk52QUaRQfchm2IEyVD7KyQ+LZMSUTUVavoXPWlqJd6kUvf16LmAxOA8zkG6ctg8/OcJCv3B4Z4WdTuHshJo0fSTUx1Sipkh2mZVy8KiQsvSIDI9Nj3k8CiV1hqftaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776140186; c=relaxed/simple;
	bh=Z5N/rVb+adVyB9rZPmhrqHj2kZpgQYkX0Efp8ZIjmTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJKdHooDVTps84h5KWNcNMr39Pfv71nshVyAlpozvX290XC0YSp3iic1G/2Xth4BK4rYvZGvk3EUNM5eTCZIAt/EPMXlnvGDB+86PsZ9gKYCl9G83Cgwh5ZUPla+qIfpXuWVWaYPa4p+aLZIZWy5mhGRytVYzoX7bcxtsbg74QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5jqSIxx; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-41576c5c01cso3885385fac.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 21:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776140182; cv=none;
        d=google.com; s=arc-20240605;
        b=BItti1lDtUlGfd+56NfF2dQujz/M9ybPviXUx3tzMWNXuusDDnQZ4jceyYbJvjIVQx
         YSWO1I6eac0HPybt5Rp5goSZ/H9myINO4kt68IlJ6TCohAbvDIWRE6NefqtCeYKEfnKW
         pLWYnWr1km36+aMYlgi/YDCmYgAHzP5q57X9HBCYDyCLbGz2d3ddO354i7aI0KVjeeCk
         kMFlsvTEm8kNBxMizv+OvHEKxVtJgso3m5lhIOcLZHQ9aDBLusECfq6bAB+8XRjOxm2L
         ncCHzglJ6hpv8gXsNNIUjrUKnfXYJKacPFuJbArUt9zqpUEqfhS+deTMZ51sVzNe9lej
         +j8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D+WGIUzQXT+3c1N6VUNvjgXRKku5D1uJICQtYt+QceU=;
        fh=3BiUKccvdHbcFvhQ2PfgoiCQK0uQTkL05U6rns9SZKM=;
        b=SaMxSyylRmLtOQ2zUDGpo7geNo0fmiCsB4P7kVh+WFE5Jsh+7VysCbEaPo5TkG+0Kx
         lcGVN/DJaVObwr9md07Az8zeFOG1KHBT/z/cbRPSYD+AGyZLgva1CT9idRZxrVRgUYbY
         Zz60nog1MWsS4XJH1mf7k9KY0csnyQRmkqcmp4qFKXXXtUkHZHoibrhHvvC5iLKS3MC4
         tGSdVeYIURzP4sfAywXbT30bMnSLLXKRvn4TBSA/ptQENHzwu7pagdpOgWZkfve8PAn2
         VXdFyxEbBWOW+GSfVFqKjpuA1wecvyTGquzgXsuVNITKvqk6DlQPKVjyNiYcpnwH24eG
         OWfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776140182; x=1776744982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+WGIUzQXT+3c1N6VUNvjgXRKku5D1uJICQtYt+QceU=;
        b=K5jqSIxxXyRoupUGn0bE3BlifGyjSSNDTpjV9GvPM7V49QggblcCuPMJ0rBjiV7soH
         lulnJkeUM4H6m02ts9HiB8AX/ppzwNcdn62wRdtO3aBqp2xSU+GvZekliX9G6BgcPY5u
         V3er8MJgynMirBrAXaVEoi2HzFUokG0vbWD7Y2kwFjItenQ/XLOHzKYxBeM66zfIyxIJ
         SyZ24zGMCDMqShBSli0JI+5/RKlAJkis0KJ2MHKNRpcinhLlghPsgxHxxZr4Dj5glVHA
         nY8ugfElunoGk4UBOsJptgmCqgqgRRRASkT7s22x6EhiD551sdr5DnJSv9cqAEKK95k6
         Ry1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776140182; x=1776744982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D+WGIUzQXT+3c1N6VUNvjgXRKku5D1uJICQtYt+QceU=;
        b=MtUW+7maUwjLSEvP63uXYHuisr0TYP9jwuNU+kcNuviU/3/tCuRUU5uPEk8aoHGTxz
         vmQ8uX/cdvvFXXVEpJTi4kyUQI6RxBLr79svW8QW6OmtgAKSDgYRgQMHUaYS77bbxsPn
         WL/hMkzANTENc6ov5q44odSJsMLWfIMZHMeKIgQ8R9GRphdRVC7/u9H+0PC7cw8p1J6p
         UI92MOJbFOss131GkONe4MI+ItUimsLtvRa8qXbbcsl2vGKUP4jTxw857+qoph4ZYA7A
         744yeh6INVUZt49q02L3LmMpFqy/WcxIUAmj/cXQ35e5wNhY1hgezT2pOEpFryIGUTLk
         uE1g==
X-Gm-Message-State: AOJu0YwEXcxrSzOCIQq/UJWaJEK7ELwvZeZm34+U6FhRhh9wckuL4VAP
	OTDmHjUHr/Q/arjvbnxsZ7ZyBVzDnHxn0IYj3f7UK75tuqGvVd8nhgLf9GqqmT0eV5OY88xLU2I
	7LWN7aisibND7XU17JIsZH1Oz4kX7zJw=
X-Gm-Gg: AeBDieuAuR9fM3jODcz3RtFp+Srv9cFzyvis13YoX4VnuY+IatUtSMtuB/miSFOor53
	edwB4Nt/wYPmxijOGvlKvY8Mw+Xiobnt/qNqTWwq7dIqPLYh3i2URLswIpyGnuMijH6eHUFBhlS
	z83mOMpHJryiBhEphowWvo1S73b0wxuKRIzyKUo0R72v2qT4uZZQi+Ou8Pdc2c4KofWHylxOgCj
	lYtRTccPmrfi8a0ZJ16MNOMx0jqlZRf/ZpLjNfybCeQiIlsatEf+xTdhy/K1ZsKf8vx8zi+wZzI
	oB6ue/8yfmzi0eDiEDlBnnPHn3xirYMZTU19NhSYYnQ5CMSVXLK3AObCFqhi7HUc98/aFt0nyLo
	mx4H6sJ2vw6C5I/Fkr9tK/vTxqeFN
X-Received: by 2002:a05:6870:176c:b0:417:c695:869c with SMTP id
 586e51a60fabf-423e10e1dd7mr9347428fac.27.1776140182198; Mon, 13 Apr 2026
 21:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413155819.042779211@linuxfoundation.org> <20260413155819.436681483@linuxfoundation.org>
In-Reply-To: <20260413155819.436681483@linuxfoundation.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Tue, 14 Apr 2026 12:16:11 +0800
X-Gm-Features: AQROBzBsLhmYDz5qIxKlxZ6uXmJyhFkiJOcxWp4HE7uRjHVOHfWvJSMxJ2kmQUE
Message-ID: <CALbr=LaxfRiP8totK7_K_ErH8EbYcBxTTZ5dYaXZeo2UCVNSMQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 010/491] bus: fsl-mc: fix use-after-free in driver_override_show()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, pchelkin@ispras.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-237717-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email,nxp.com:email]
X-Rspamd-Queue-Id: 6B5603F574F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 12:43=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.

This patch still needs its prerequisite commit 5688f212e98a ("fsl-mc:
Use driver_set_override() instead of open-coding") [1] to be queued
for the 5.10.y and 5.15.y trees.

Without it, driver_override_store() doesn't hold device_lock(), which
means the race remains and can actually trigger a double free. Fedor
and I previously sent reminders about this missing dependency here
[2][3].

Commit 5688f212e98a applies and builds cleanly on both 5.10.y and
5.15.y. Could you please queue it as well?

Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D5688f212e98a
[2] https://lore.kernel.org/stable/CALbr=3DLY8Shn1Mk2CBu5sCwNeR=3DJn7BndH+q=
vAZGGqWMNoJQePA@mail.gmail.com/
[3] https://lore.kernel.org/stable/20260214220547-5519e7b20a4919ddd81d97c3-=
pchelkin@ispras/

>
> ------------------
>
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
>
> Fix this by holding the device_lock around the read operation.
>
> Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in th=
e mc-bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Link: https://lore.kernel.org/r/20251202174438.12658-1-hanguidong02@gmail=
.com
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-=
bus.c
> index 8f7448da9258d..49eaf5bddd5ad 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -194,8 +194,12 @@ static ssize_t driver_override_show(struct device *d=
ev,
>                                     struct device_attribute *attr, char *=
buf)
>  {
>         struct fsl_mc_device *mc_dev =3D to_fsl_mc_device(dev);
> +       ssize_t len;
>
> -       return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
> +       device_lock(dev);
> +       len =3D sysfs_emit(buf, "%s\n", mc_dev->driver_override);
> +       device_unlock(dev);
> +       return len;
>  }
>  static DEVICE_ATTR_RW(driver_override);
>
> --
> 2.51.0
>
>
>

