Return-Path: <stable+bounces-87581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C509A6DC8
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39E31F2266B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EAD1E7677;
	Mon, 21 Oct 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="lHr5zkK6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FB1F9402
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523626; cv=none; b=VLgkFP/dPelJXSBZ87TBFX0IHgIUciSITYqFuXTVj4yH1q8iABF16MJ5mzEwx+cPpl+x0UGx1hfS1tsBgiRctG2b9r9lmTkb4OWDGGuPzv9iproZ2Vld0qspSXzMlFFNsyxa8PPMEheFqd22U/OIhnlAZCxJRn0KMHZyuCewhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523626; c=relaxed/simple;
	bh=N6JodVTDxgJRvW8Z4glRLSF0rvxjh9HrccAUx4YttWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrQecObJQhNMeLzMNfw7z7YkC3o4522RsmyIssIisPoaC4Z+DeCdP7tj52jk2jEWxJ0ckg+XLkM2TxkTDD6RG52YuA2FXGhkJAXzI0/VSyZtSHeexIIi0uuEeeX4Z80x/AdEFsoKApqZPgG55r80WklsHgzj9GVTClb5t4TSVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=lHr5zkK6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e59dadebso5828596e87.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1729523622; x=1730128422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwppW5KGzHko9Zrh6awJ4uJN4mUN1akho9LTmYz6AB0=;
        b=lHr5zkK6s6gVMXR1AJxIVeffzJz99pwH7y2kXzMhnarB/k9a3wgdm/vtAg6H/sHYL9
         IKUn1k8H6sqKKVBJ8yaSI0RC4VX0fLK1bzuPAjBMFPf8S9ZiXF9I2gGlbJTmqoSdCi0E
         /4AnJoSfLVgqrFZEuJFqAACtvsSn1eJHIichL/7nhlOozIIG6XttGI/iBpNcAd4AXxr/
         CP0Uw5PBFymK60fKrbr5W1XuyLSyizobAbPr3YuC6gNMmXIgNmPRfJ8jnxx/Rojt7Gh1
         Bz9/xs9AuwzDtcep0QfqGutHT4/w+JNQESlVVSjJJfruy53h0m3r4VEDVIJCgnRCklvO
         GJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729523622; x=1730128422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwppW5KGzHko9Zrh6awJ4uJN4mUN1akho9LTmYz6AB0=;
        b=JcOOGkli0aM30vI3GsjzoAOkc0N23dZockQw0wluDTuGk2WO5SXSzvtNaaHDlg5h0I
         OpzwCPZVYMZnOLYL2lSfO6pDGUUF6Pl8G+wlwhlYD1MPrhEwe6Eb0ebOv1QuM0eukvQB
         0VtpRAKOl4TDaJf0N6Lv4t/f1cH7bT7kU5maLOssc8KSVWfEoPGEskxJ7R8ODVncIU6R
         oXmiCC40bpuiY909q3iXoTqdlnNAXM6uoVdfZCdryvLYghSFcEPBEkq/gGc3/KTduxho
         bvwj+nCL0F3hU0SGn8Q5RWwXpk66uhcdSll7QcU6Hq+IJOhEthIfxE7VJSYmTycDzWN+
         bcSw==
X-Forwarded-Encrypted: i=1; AJvYcCWO2BUJqWykLok7LC9g2xOiuTdkN1jhsVMfwUYPEYgUJO8UCS7L2lbonBpBdS/DK9zB5z1A4rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8NiI8qPq4WRUULqBZRn9CyswU+b8w2JSUcy7G0lY968SJ1E2
	TUxDurngfwfTxiQFk/GttDH65UrULJDEVLh20Wg7eE8o5ee6HxejkHEOAuVGFNCmy5qYHV+r+Rx
	ggjps+NGs1F/Orty/zCKVmd6uK2Z7eC8fhVtc
X-Google-Smtp-Source: AGHT+IFg6sLaPCI4+zu29tq4MBdGk5PGlOsywwq2DfZr8M/tfhZqy+/Jp4NatrckxdCornEORL50z19tm6KxCScHtbQ=
X-Received: by 2002:a05:6512:31ca:b0:52f:2ea:499f with SMTP id
 2adb3069b0e04-53a152199e7mr5802225e87.24.1729523620475; Mon, 21 Oct 2024
 08:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com> <20241021-tidss-irq-fix-v1-5-82ddaec94e4a@ideasonboard.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-5-82ddaec94e4a@ideasonboard.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Mon, 21 Oct 2024 11:13:29 -0400
Message-ID: <CADL8D3Z=4dx5B4YdA_TD-900tnTm+Ev_ar+6CbaQ7iV04p9B0Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/tidss: Clear the interrupt status for interrupts
 being disabled
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:08=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> From: Devarsh Thakkar <devarsht@ti.com>
>
> The driver does not touch the irqstatus register when it is disabling
> interrupts.  This might cause an interrupt to trigger for an interrupt
> that was just disabled.
>
> To fix the issue, clear the irqstatus registers right after disabling
> the interrupts.
>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Disp=
lay SubSystem")
> Cc: stable@vger.kernel.org
> Reported-by: Jonathan Cormier <jcormier@criticallink.com>
> Closes: https://e2e.ti.com/support/processors-group/processors/f/processo=
rs-forum/1394222/am625-issue-about-tidss-rcu_preempt-self-detected-stall-on=
-cpu/5424479#5424479
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> [Tomi: mostly rewrote the patch]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Thanks for the updates. They look pretty similar to the changes I
proposed and thus look good to me.
Reviewed-by: Jonathan Cormier <jcormier@criticallink.com>
Tested an equivalent patch for several weeks.
Tested-by: Jonathan Cormier <jcormier@criticallink.com>
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 99a1138f3e69..515f82e8a0a5 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c



--=20
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211

