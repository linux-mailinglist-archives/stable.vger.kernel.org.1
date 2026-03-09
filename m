Return-Path: <stable+bounces-223478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHA8Kq8wrmlrAQIAu9opvQ
	(envelope-from <stable+bounces-223478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:30:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A0223346F
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0EA830068FE
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 02:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD8D25DB1A;
	Mon,  9 Mar 2026 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGMCsrU+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414672367D1
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023401; cv=pass; b=W/ureEORueSaSEAwd+sBnXJbF47QHYNYtohu7ocCjs+Qrd/xcWCCH/6m7W24Iu7ibeNMhpK2po89EiFSJiYphIva7X9kB6Ql50p9sU+cUlgWDAa87G2CtCEzDLE1/G1nSa/G3MjIY47yXK1ZcL9ziNFqXYlC4LMcrfXo1hMsGNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023401; c=relaxed/simple;
	bh=tBh3H9GIDxfVj3BuZmc8pN4aS9Ogfzhe1ECH08piiNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MB+kd1c3ic+v0bOak9WhN5/0PEszADQhXmDhkJrURptOUhp1LcngqCNtdh2yHJ16nWWO6hPfXBa4inyZ2eOwwah4QTf3Elj3T1srnyImae9LOsXzBWaFjCcy0pN6dnv84JZoyRiSMXxY9bspVcRZMPhp3wZcmrFv+uZwhzAUh3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGMCsrU+; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d743ba241aso521744a34.1
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 19:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773023399; cv=none;
        d=google.com; s=arc-20240605;
        b=gXtPmo0uYbd/o6JF0ZIy2ISnUjwGUsrIrKQD3RAbqmEj/403xPgJnE8tyzjqTz8TwM
         EmtxrGa/QXa6iv1RIAj2pZ2ADutPv8YaavyMzrE5R0/wggUN5+yaNGGrvfjxzO7BrlTr
         PysoNATsiYfz00hS1c7DuxTRFHBsKs3GdMTbGUX7q+Btt9C5kLCTn0wWJZUFGl3+WUIw
         oPRN1OOy9c4xLyEqxXZq2njYP1oCaxLyeracSXI8uHQ5Nhks0zPZQVPDz9TTlTMcVScg
         R1NLOgbdVY41cTawi8ysQNasRM/tVE2tOa3TkI2w0RqyC4JFaLw15JsEI3LD5lfEzDPd
         wkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/tm7vFdi+iPNpcKQ7CQNYKRDc9cHVCcl7mgnfQ6OUPA=;
        fh=5kU8b52eQ3Sli96J17b9VqURzgIxuOmXKa6ifw/u59w=;
        b=X4TVa3oMiVGb8CMloRdnD6SKU+i/TaZoWNI6dAUadCVzT+MLmfGp1bGDL5Qa/IVFTC
         mHk7a+GgfWOp52Vbg0cmyauupYSnuooK5dpQODRUaOSG/7M9D4pzXTGCgez5IiLsGxEC
         pVPyIg1ULdZfQ21k0fT1NWAltggLzItPZUIhSK2RPa/ILcsazQUKL5DseoqcD0d+9hqe
         /yORaSTdgRlN7W6S0MubtFwcxyDxNRPkp5qKu5XgLgadtzAWi6rvQ4ck1Sk2j2kKzVce
         PhpGN6OO43mko0AxSOh0GAlnx5FHqwl8IkwukLFoP0slwpmMVJ+AsF6Tn39TyMBj+M4b
         YmfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773023399; x=1773628199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tm7vFdi+iPNpcKQ7CQNYKRDc9cHVCcl7mgnfQ6OUPA=;
        b=aGMCsrU+IJDOjDuWp9W1qUgL6/5J9Vla2jd/yR5tgZWLiTCfO7ptArAkg5HArQUdvF
         B1YnCfy4fCDZi6+aGK7I68Y2Dx3I5goCYWFML4VkvFeUXX2AL29492Z8nYCbOPpC9Erj
         cb4IvMBaSTYOJYUnWo+jh2hQ3H+5wdWcVeJ/Pue7K9uAqpZ7PbD5+8ZjYQTBcfJooo1D
         lgwI8tbi4pH2BDGH8IzNVggHqvGIF1JhNGCRgDRBadRxo4eGp+8YunP5cvEKVdA847Fe
         yjL+YMN8+34F6YnhwzQ3zXSMMhxHJ0kqtlnq+XB8FzuUiyGTTZJgBM/mGKMCEFFPC7Ln
         4usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773023399; x=1773628199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tm7vFdi+iPNpcKQ7CQNYKRDc9cHVCcl7mgnfQ6OUPA=;
        b=aaGGiQWWhB3eeYB4cqSHeHDPu6Uglx0y5HzSAYtwfUGOaTFniAqkfDgwUMcU9mH12W
         OIDL+sdN3i0y0v5kiD7urU//4UhrF64EObYFeDA9vlFtttdf4ROKuj5RL1DMe2+vKmTT
         aW+JaCOp50M2PsvZjPv8U1Q4WlImnFYAgJ+93nky/kgK4yHcLRoeDM6EmSNyzhg1FKi+
         xs9bsbP29HE+88Rm7wLpNQnsHXtO4oDg8n5A6lX+BBpKAAA2mBT/WIoJ0i8FL8XRK650
         CkyGlAMEBtvxS5FvZYfh64EnUT9C4a/7Y4hM3NZ6UlAz9A5zFqVsFdegKWVoDbfV1B5w
         TxyQ==
X-Gm-Message-State: AOJu0YyTKlABmJQR/pN1FafPUDX+qoKfzPHoDklpu/L7c2xHGBypzXDm
	8DyteB5o5PZM82hYB81Go8VfXoHA7RNOww+xvA+U9xadAQunKBl5Fj2yGJ07Zh/ZLkWlmcgqSgL
	278JEE6gO3x+Aie7QGy5BNcD68cVu4SbvJd6O
X-Gm-Gg: ATEYQzxhSh3UJuef2+BSd9ho00RrTPRW4wAaRoRdonXZm8axHz4B5y/tc5TPub8a8Ys
	LOdj6I3MliWlpr+b8mwSyjDpzrNQ4IK507L81bZRR/nKUZ7SHrjDPJ5e6JYt8FaTyUiIyrPOBqR
	s7gbOc/mEMZI9lWs6/bn07TR0BdTchzaxeFY6CN2jgk7XTc4lKr7C+5kLs6qI5Kvi5wMq9Xl25V
	apjPWPUDVpag90yFHQFfHbgBp25ayqagwlLRyAIxE5/1tGP+aJAeHhpwEv8eYLM66x1uvIzOsSM
	yiWvCBM+/xu3tqt91SBLmICcb0BNpJ7P9MbFdRttQwFagu7ksygiYgC0buP5cDa0MCzuxwjNsKE
	j6yov3FDM
X-Received: by 2002:a05:6871:45cc:b0:417:46d:ce2e with SMTP id
 586e51a60fabf-417046ddac1mr2941360fac.33.1773023399073; Sun, 08 Mar 2026
 19:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308164906.34969-1-sashal@kernel.org>
In-Reply-To: <20260308164906.34969-1-sashal@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Mon, 9 Mar 2026 10:29:48 +0800
X-Gm-Features: AaiRm514Rh9W9VXtXQ_Y-mRewINMnl4rYP3HOkI2c8DHk7vwczj1Dbe6E08BJWA
Message-ID: <CALbr=LY8Shn1Mk2CBu5sCwNeR=Jn7BndH+qvAZGGqWMNoJQePA@mail.gmail.com>
Subject: Re: Patch "bus: fsl-mc: fix use-after-free in driver_override_show()"
 has been added to the 5.10-stable tree
To: stable@vger.kernel.org, sashal@kernel.org, pchelkin@ispras.ru
Cc: stable-commits@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 20A0223346F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223478-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.892];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 12:49=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     bus: fsl-mc: fix use-after-free in driver_override_show()
>
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      bus-fsl-mc-fix-use-after-free-in-driver_override_sho.patch
> and it can be found in the queue-5.10 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi Sasha,

It seems you might have missed Fedor's earlier reminder regarding this
patch [1].

We still need to backport commit 5688f212e98a ("fsl-mc: Use
driver_set_override() instead of open-coding") [2] to 5.10.y and
5.15.y.

Without that prerequisite commit, driver_override_store() in these
older kernels doesn't hold device_lock() at all. This means not only
does the original use-after-free race remain, but concurrent store()
calls can actually trigger a double free, which is a more severe
issue.

Could you please queue 5688f212e98a for the 5.10 and 5.15 stable trees as w=
ell?

Thanks.

[1] https://lore.kernel.org/stable/20260214220547-5519e7b20a4919ddd81d97c3-=
pchelkin@ispras/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D5688f212e98a

>
>
>
> commit 09d8eb1f3a01b0d27891a7964da1126b4cba842e
> Author: Gui-Dong Han <hanguidong02@gmail.com>
> Date:   Wed Dec 3 01:44:38 2025 +0800
>
>     bus: fsl-mc: fix use-after-free in driver_override_show()
>
>     [ Upstream commit 148891e95014b5dc5878acefa57f1940c281c431 ]
>
>     The driver_override_show() function reads the driver_override string
>     without holding the device_lock. However, driver_override_store() use=
s
>     driver_set_override(), which modifies and frees the string while hold=
ing
>     the device_lock.
>
>     This can result in a concurrent use-after-free if the string is freed
>     by the store function while being read by the show function.
>
>     Fix this by holding the device_lock around the read operation.
>
>     Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' i=
n the mc-bus")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
>     Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>     Link: https://lore.kernel.org/r/20251202174438.12658-1-hanguidong02@g=
mail.com
>     Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
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

