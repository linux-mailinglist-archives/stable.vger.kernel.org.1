Return-Path: <stable+bounces-254447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EOLE34KFmpNhAcAu9opvQ
	(envelope-from <stable+bounces-254447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 23:02:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A999A5DC932
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 23:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 385BA30247EE
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960532264D6;
	Tue, 26 May 2026 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mql29AP7"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB493C1F3A
	for <stable@vger.kernel.org>; Tue, 26 May 2026 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829350; cv=pass; b=nU2rJK3zEu87gG8tzHDxPoVV4n7fiebZ9dFuYnct6fsGf+m7o7xjf/NEmVHCYja0bUEU4yOdcyWxqjexgGRiNawKfMDD8vvprIcbAKuUFQtz5ZQrWasPRKlPrZZr8jlrlClIs2M61l4y3Lhc8HVKJ7mXGP7JQUNxGvygDwXUBdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829350; c=relaxed/simple;
	bh=2PRMx1oMj0yTGfolOIpxbMTSlLUZGzC7Mz3Zval2GY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+OFOVTj8W29dXZ03OHyeotrPdsbFwXNHgiHxKjlmOYLytPLvN4vXR8m3iAxiPOjd6iN8Ugpb9ec2T0OBMIcvlP/GX7tFrUqBW1MsyhzRi8SkBdXOP6ip/Y6xK0byMCvLAX4Ui/gCPV3B/ImFVSBsGRCGGaILpmJNw8evA3GuZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mql29AP7; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12db2e9b5a7so328524c88.3
        for <stable@vger.kernel.org>; Tue, 26 May 2026 14:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779829348; cv=none;
        d=google.com; s=arc-20240605;
        b=dXKF54N13Kagje+G9oO8QAZl5xHbfSaTaKKZf25uHlehVTltag1RamNiTEBIdY3Efs
         JuFLbIiipkfPUWuogAIvqnAYKAgBpisA1LnwOTIEHU7Khv/i5WsLBNwfpaY4HfN2yvpL
         W1cKB1YOsL5Bl9o5uviJ9zVX6hFgsg8mvTmEIanaK4ZtATYDZaWMdmYIcekK2lu0o6HZ
         9pWGGx/bWNaMoMiG9UAhj0Bn0TGFEol4h2Gkt7dEM5ziVS+WGc4jGYRlwKZi5CFIPqZ9
         OryoOs8dLVobej29/Ab4MeTPOhdyAyZ7FKMySI6Kru+Kj1fkW6a/unCeWWJPrl2ovpVq
         8GYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xDSN+zAFo3SDyZ1j/OWiBK2mX5qoAAjzuXlq2kenLkU=;
        fh=lv3ja++mt/hzQv2JFtOFNhZFkhAYTX1Ts3RIE4QlLVI=;
        b=OOnPfjl7haFVOx7oAdZlE9MiP8FlODVNHmR85AiBi8lip+6vxvFi2GbVVawh9kBhTe
         fRVEww+7V7aaOUsHpcfNPQ510F4S5FuRtqxkNU6fY3oziTB508WPZF7jEbwE+8IR/gR+
         c2Jul7J7UC38TjSVxhacJq3dgLyVDhlb5jJsqEHJobnPTsDDNo/+3JfJyeXl65vo16Tq
         MMHJroricvffUHaDPDUJP+rOeHfsk/JOEaFrkPJUHuZHKim8wLeb61QlERHyPuIqsNv5
         QxPPb4NvAeyUUImqAX3ELsZ9RQoExmknzUA9HM1OgaCFE22c5Ce0f10/cWJe0561A+/l
         rUiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779829348; x=1780434148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDSN+zAFo3SDyZ1j/OWiBK2mX5qoAAjzuXlq2kenLkU=;
        b=mql29AP73H/Z+DUcLPNGbaFttfzZ3DtXXAy/TOEIXXphbWfIQWkBy90Uu9OirPklef
         pSV5IsEtRyBtoJ9poluOeQkYIKHoATmHPksDrdLKRsfIefrwOPiWFf3vNb9cY/rNsiTw
         lMjQmEw1bCC+cIEtYAKXE5NMZBEGDa0fucDRj+SrrO2y3/Q6Rh/d2FRbi8EV40QHduH7
         h/0ax01qNjTxuoXUJOt6+sWew9WPTt/BkBDeeNO2VIaAvPFoggO+YFr+7VYM3aRskGOC
         jWkROrOA9/zKAgmeKXoksL3n2rC99DHd9GcyIzYqq5n7IrJfs8cjtzSgW870cdZ1IVj6
         jldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779829348; x=1780434148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDSN+zAFo3SDyZ1j/OWiBK2mX5qoAAjzuXlq2kenLkU=;
        b=hPOUP7Ac4SddhmGAOtT1X1kRUwwxaEAfxxxf6o6/Q0lJwW2UzzoCU4+1Pd/vwEBuNH
         1phyxCvrjw8SnTVciDAvHFdpBkBV8Q8Thy4YdxfQACqFmUmlwfD+pmmQzpdIoB9Hgpk6
         WOoeEg7K1MTi+elp8UvohaVhUJZBPeKoUujk1U/NbKIdGB2Y374ncTzMH3BuSbdC+y7A
         H3/b9X2GLuiyCyU1D6XP79jGLRBUdCxg2smvCrp3MJKNsVTZ9lgbt9IhuOqx7OOTYtWW
         Vfh0gICHBeRhRTf0sLYtVXCEyyX4tdoUKuGWJRxhNNS2Q3eQn3ZKtXFd1TwNJ6RklPLB
         Hogw==
X-Forwarded-Encrypted: i=1; AFNElJ85bXkbrfaWoURJPwsLLX9vt3mTgR1j6dl2tOJh+2LyrVy3PWLWCbNl/zny0HZXE/+cdeT2z9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDxCFMXU0cwv8WNPeaDijfpzfnthyWBqH3c8EdAcyHfdAcD+KA
	/tH8/Hw01isyGt3a6MjH/Yf93ctK0he9voPmnbN+tMpCK16jb5kxMZCG8fFiNvceTpcdWKAB68v
	a8KkkUUXlmlYB4ynPhf0t8qPGaYZtBGw=
X-Gm-Gg: Acq92OEet1SE/VTYiZw8JdrA2WvI51C4CoBW2ZgEkLGPVYcovgrOJb/vxnTC8ShlBea
	zHskDdVvQObxB3t2YBmaoPHZ4+SKTWljHdMrQ2diq7vI0b8mi5OxPNj+N8DIKwstozeXW8L2J/E
	PbRjJnWOWljvxBGJbBKyK1MNBhQjiSh3HC0xlUqiiznL8bljsABdfMXs0NIRLf2C+I3u8ma3c2X
	kumSSzp0s2Q1CbidQgN++ISzKGtX+xgtLap8BZWcFUFrqUA0CexnxM8kP14kmZ78JM70ug7nQRK
	O0f1OUMAH3ShHpb/yz57soYuMMPJgtOuEOzdD5Iy4nZdJT+CTX49Nf4KPsyeeBRvLT/VtfTDllQ
	Gg3h6
X-Received: by 2002:a05:701b:4285:10b0:12c:897a:5219 with SMTP id
 a92af1059eb24-1365fd80cd6mr2508477c88.5.1779829348250; Tue, 26 May 2026
 14:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523142645.39102-1-meatuni001@gmail.com> <20260523165646.25645-1-meatuni001@gmail.com>
In-Reply-To: <20260523165646.25645-1-meatuni001@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 17:02:15 -0400
X-Gm-Features: AVHnY4JqZMeWeY53IE6NJ-7vofcMYfgVFqoUhkfR5wacLpNgAvtsXhnZNwnkDGY
Message-ID: <CADnq5_MH_eLM1qeQB4t_uR=T66TuSHCAs5O47Li9_KtatkmgqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix NULL dereference in get_queue_ids()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254447-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexdeucher@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A999A5DC932
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applied.  Thanks!

Alex

On Mon, May 25, 2026 at 5:59=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> When usr_queue_id_array is NULL and num_queues is non-zero,
> get_queue_ids() returns NULL. The callers check only IS_ERR() on the
> return value; since IS_ERR(NULL) =3D=3D false the check passes, and
> suspend_queues() calls q_array_invalidate() which immediately
> dereferences NULL while iterating num_queues times.
>
> Userspace can trigger this via kfd_ioctl_set_debug_trap() by supplying
> num_queues > 0 with a zero queue_array_ptr, causing a kernel panic.
>
> A NULL usr_queue_id_array with num_queues =3D=3D 0 is a legitimate no-op
> (q_array_invalidate never executes, and resume_queues already guards
> all queue_ids dereferences behind a NULL check). Return ERR_PTR(-EINVAL)
> only when num_queues is non-zero and the pointer is absent; both callers
> already propagate IS_ERR() returns correctly to userspace.
>
> Fixes: a70a93fa568b ("drm/amdkfd: add debug suspend and resume process qu=
eues operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c08ad718dbd7..8488b3a6c2ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3312,7 +3312,7 @@ static uint32_t *get_queue_ids(uint32_t num_queues,=
 uint32_t *usr_queue_id_array
>         size_t array_size;
>
>         if (!usr_queue_id_array)
> -               return NULL;
> +               return num_queues ? ERR_PTR(-EINVAL) : NULL;
>
>         if (check_mul_overflow((size_t)num_queues, sizeof(uint32_t), &arr=
ay_size))
>                 return ERR_PTR(-EINVAL);
> --
> 2.53.0
>

