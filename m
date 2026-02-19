Return-Path: <stable+bounces-217509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDEPFBJ6l2mWzAIAu9opvQ
	(envelope-from <stable+bounces-217509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:01:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C08FB162816
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03AB430071C2
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E0302779;
	Thu, 19 Feb 2026 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IITiZdBf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6CB285071
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534863; cv=pass; b=g+v5ZrCC9HJkuT3Nws3nLDoJe+DOB+F19VSQ7WsEnSeQI/lGbINjiFBmfmbRZBsi1j8XyWkYBql8AImQLDkCD2Nk2M9kxpflI1B/N/5NSi+EA39AkMMsttWAYkq/VaQhOhmlXMAGkSVEDrHEmCQKVfM0qNXYdRUTVW9zgmU6XDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534863; c=relaxed/simple;
	bh=kw9jiAl4cql/VhOlxTU/Fi8scwQyJaEgAQi+fYys1vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqX1t8nMlM4Ii+nqZCluU53j6ODa2FZejfMuWFJ7e7IoOpuuQHKu1mau1URs/J3ZsUhsv9e0JTbh1toPAiiXnKnuGD4IzsjO/UdaUqoBw2a543zQUM59IkdAAzp288Njz0UePuqD7O63MlJk7jTbjk3Ti8BeQgp4VsoeVhm4lDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IITiZdBf; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-127337e3870so120057c88.2
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 13:01:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771534862; cv=none;
        d=google.com; s=arc-20240605;
        b=eFQooBdY20rXzpFDQcxkZDe/GDA2i6XFr2LFJFMsIS4zfMzrrZk6o8adfRYPLYaPb+
         3vJY7bqIIIA3l3akLByIY8xF+YkQ/3WdCVxZ/C+17q28TS+7jstoHUgiN0/2IbCrH8Cy
         8YKfceXbxAzyAZTNhHfWtqQGCggaNBo6qBBt6btxEdcZs3LstCMa414kpKRyg7F8HqGG
         PsdsDYtZG8RS0YQDfWsSO/9iDCj86W+e6ZIhZPMRYrGghHgrmizcw0xoFURAVblr63Z7
         atQ2UqBkPe6XhN91BCtnUYEyc9WFCL9hkEjB4zfBTTjhrvzaw8two4K8yl0/EuiTJ7MD
         j1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0PPyVVLAcp3G+WaD2vy3cNWWUGjwPgDF3ZSaqTuBYms=;
        fh=HWZl9gBxCOrTO4RlMA+13rkcJNT0siVD4hSPeIJ+Qig=;
        b=JxXCXMo/KnNaOiqQjHaGfi9WNEk3GTcuw0Slr98KuqEHWbTG8ICJbLsYf3ytHzl1Tw
         dFZ8ntQU4WG64m/KdJwYP5IYVXSU1ju7B9d/boB6DXc+N3spWqJlU1F/75ADjMO9nJGc
         MHzzR0iuMndJf87HiqYR+tuAQ1DzLlvcEYtgBF8Ov1yGjxOLIriQCSN/1STC5Px0AMKD
         ai8E1+5JLgRhZ6tS5WAhHl+JsIGqQMCZMoEzPH1Amsk/JE/N9imH6Tp/DhJf40QRf9UF
         QyICRprvFgbeKUVENfWHEbTfvTxJTSFySZl0atbrh0LszbHr3hSyOQvFzBRXKpb55JQx
         gLyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771534862; x=1772139662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PPyVVLAcp3G+WaD2vy3cNWWUGjwPgDF3ZSaqTuBYms=;
        b=IITiZdBfZUv+yw8cYaTdmfnGyqwSeDxpM2mOlMq0GjYqt+ATj/0sxq5GjVPBkI28z3
         9VxYEbEb5BgiRDYFMPBs1a5MJmCrQzL03zCeke7orIWNibhAT7/vYQAvBLveOBLak2e4
         et21XQC4/1c8tY7AiK3Dlr2QYfYKYPGAqinWattLWqWsQDARLlUlitb3zO+4DC57GLT8
         5Jw7EFEHuuyhYRO0/usQHi2qbN+w8qJdKW7TPP8mDY02VMOMIo12vdWhUg+LOaixDsPa
         qRU2KUMyxUsYh5G5zyy0+jFBnxz0vhUK10xZn0EOks1J70CwG0OwiRbQ7bUs1si9ejzJ
         Y0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771534862; x=1772139662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0PPyVVLAcp3G+WaD2vy3cNWWUGjwPgDF3ZSaqTuBYms=;
        b=S99s5tCm+BjyA7sb1CtC0KRroQulATsKbJnugAFc2s8iEZwxwXM6FjwPRL6Y6VklZv
         gOBorOy5OgDQYfQZiJA3/LWX6kX6QKC+0nIY8oJn3nXBxxpQXOT4ry5hLbF2QZ4z4Zrt
         LH3kEfh0eCtRzdnzuzhmydLpqO7jw3Qz3t+qfo7ZxuRi7ZlfBZMjN6KhvWqMxQZgnV+x
         3+ezeOOcDQzBuDZuYUOUZLQH7U/gSPToxMpDPZByq2J6ulJW2ehJmpOhburud/Vc+YB+
         CTWutrP01OZyWEw5lFBaU5+qSHHW4jbaQdmABR7Z2WYpu8vE/fXg/K6vHjXTTpYWAxm5
         vlFA==
X-Forwarded-Encrypted: i=1; AJvYcCUfAFvsunKZlvV30buarCYRMeCbnYHtXbJo2f18dUdy9P2BhIft/4Gz3DeD4V/lYY3LUMZvj3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gNXCUYzTiJPM0xeHYc0sWws2vbrL2pCoFto5J9uSYAvoQrPH
	n19pnsnOezFfuWkI4avLFWSrF5+UT+8Tlat1xjV/JxiFz/76QNclg1zmdYhmN6EzM19n51a4IEP
	kuWNhhq0yxF7SnTwRRgpghzOHHGOoEzc=
X-Gm-Gg: AZuq6aILVfP8UpvOhuH990/LDK6s134mQ0qyPE5H2sKlkPZrbu/3VtDS+Lya0SoXpAV
	jciZ+m5iKpbf3KB71INWzT/Ue9cS72VhZYN6rkTVEbG6Nfsl0nHTjH4cmK7EUdz7hQZaaxbw/ze
	Wd7D7smVrNvsOKCtmSv4KZER99Vk9YEpnf2fr8JFQUA2FCNyZUTZYYQhxYWeVzgWOPqLExTP0X5
	eXYzYZRNa4faZ4Yd4MuBgHaakmxdsUzu36U2I8a2GNDpgbWTt/9aTovxsRqWwGPNcIvcVSbj84y
	RMAnT/AzXjp7BnWlf+HhgLvssn2yGQhrA9GpzONQdHsEaVX7U6EDkyezm1dAngFtMPqlew==
X-Received: by 2002:a05:7022:eac5:b0:127:332d:63e with SMTP id
 a92af1059eb24-12739968a00mr5258367c88.5.1771534861412; Thu, 19 Feb 2026
 13:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219000146.21818-1-capajj@gmail.com>
In-Reply-To: <20260219000146.21818-1-capajj@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Feb 2026 16:00:50 -0500
X-Gm-Features: AaiRm51egAMGb_7X26qR2whYgEuJyztBqAYB5HSrKBfFUVp7cQ32nw4H3udEJuw
Message-ID: <CADnq5_PF70O=JBq8zQB6qGgZMbJ1_GAOhqBwxBYBFg9zVHVqTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable pipe1 for Navy Flounder (GC 10.3.2)
 to fix ring timeouts
To: Jiri Spac <capajj@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
	christian.koenig@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217509-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexdeucher@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: C08FB162816
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 6:00=E2=80=AFAM Jiri Spac <capajj@gmail.com> wrote:
>
> From: Ji=C5=99=C3=AD =C5=A0p=C3=A1c <capajj@gmail.com>
>
> Navy Flounder (Navi22, RX 6700/6700 XT, GC IP 10.3.2) suffers repeated
> gfx_0.1.0 ring timeouts when multiple applications request high-priority
> Vulkan GPU contexts simultaneously (e.g. VS Code + Brave browser, both
> Electron/Chromium-based).
>
> On GC 10.3.x hardware, high-priority contexts are routed to the pipe1
> hardware queue (gfx_0.1.0). When multiple processes compete on this
> single queue the Command Processor hangs, and ring reset fails:
>
>   amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 timeout, signaled seq=3D107=
039, emitted seq=3D107040
>   amdgpu 0000:03:00.0: amdgpu: Ring gfx_0.1.0 reset failed
>
> The seq delta of 1 is consistent with a single job submitted to pipe1
> that never completes due to a preemption/scheduling deadlock. Once reset
> fails the display manager crashes and the login screen appears.
>
> Fix this by setting num_pipe_per_me =3D 1 for GC 10.3.2, disabling pipe1.
> All other queue parameters are kept identical to the rest of GC 10.3.x.
>
> Reported-by: Ji=C5=99=C3=AD =C5=A0p=C3=A1c <capajj@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4985

Both gfx pipes have been enabled for years now on gfx10.3 hardware.
Can you provide your dmesg output on the bug tracker so we can see
what's going wrong.

Alex

> Fixes: 3b094d4df4b0 ("drm/amd/amdgpu: add pipe1 hardware support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ji=C5=99=C3=AD =C5=A0p=C3=A1c <capajj@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 1893ceeeb..a44103622 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4773,7 +4773,6 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 adev->gfx.mec.num_queue_per_pipe =3D 8;
>                 break;
>         case IP_VERSION(10, 3, 0):
> -       case IP_VERSION(10, 3, 2):
>         case IP_VERSION(10, 3, 1):
>         case IP_VERSION(10, 3, 4):
>         case IP_VERSION(10, 3, 5):
> @@ -4787,6 +4786,22 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 adev->gfx.mec.num_pipe_per_mec =3D 4;
>                 adev->gfx.mec.num_queue_per_pipe =3D 4;
>                 break;
> +       case IP_VERSION(10, 3, 2):
> +               /*
> +                * Navy Flounder (Navi22): enabling pipe1 (gfx_0.1.0) cau=
ses
> +                * GFX ring timeouts under concurrent high-priority Vulka=
n
> +                * workloads (e.g. multiple Electron/Chromium apps). The
> +                * high-priority contexts routed to pipe1 contend on a si=
ngle
> +                * hardware queue, the CP hangs, and ring reset fails, cr=
ashing
> +                * the display manager. Disable pipe1 to avoid this.
> +                */
> +               adev->gfx.me.num_me =3D 1;
> +               adev->gfx.me.num_pipe_per_me =3D 1;
> +               adev->gfx.me.num_queue_per_pipe =3D 2;
> +               adev->gfx.mec.num_mec =3D 2;
> +               adev->gfx.mec.num_pipe_per_mec =3D 4;
> +               adev->gfx.mec.num_queue_per_pipe =3D 4;
> +               break;
>         default:
>                 adev->gfx.me.num_me =3D 1;
>                 adev->gfx.me.num_pipe_per_me =3D 1;
> --
> 2.51.0
>

