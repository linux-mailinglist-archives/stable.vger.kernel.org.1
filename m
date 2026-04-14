Return-Path: <stable+bounces-237868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DUcJoM93mn6pgkAu9opvQ
	(envelope-from <stable+bounces-237868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:13:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED493FA5D7
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06A9E3058DFD
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D0C3E63B8;
	Tue, 14 Apr 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzKwFRLW"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3BC26B0A9
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172299; cv=pass; b=gkhs039f/e8BCu+aCpO0WiWNKuM9tBhU7TrW90Y0A0nkEgjmy7uLpdVMtSN9iG6y853QL/lCLCj+xE9a3iMNzXAxHChjIJxFDkqfZgBSpr0aHd1Gn2L+L/meBOsYlgjTN302C0ZquHC795f7LLYe6CJgPEWfpGwd8Ns/WuNT6WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172299; c=relaxed/simple;
	bh=88tls9oazdI9EjjHwojAGPzNi/Wv+sjj/dFBgG3Cn2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXiwhqoxbdB/HfvLFswSvxXW4CwFXWqyiJF9lKmSf1Ksf7QmQlRIMLI93/p1grWby1D223c+F8aPXozwDv0b0bdXme7FQzOiCOTH33qKl3pqTLT5KfvdVDhFEcS9JTFfSwiZoAnShbS+QMnrP7SctwMK/VIZ7ycP2PX/oumOcrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzKwFRLW; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12736a0147cso397468c88.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776172297; cv=none;
        d=google.com; s=arc-20240605;
        b=YBTAdRqe/1aE9mXS5Nl783x8kQJaiNBNPNZ74fv5aKq+Z1o8brPUyi54gcHPXIrXEY
         XKbsFnoqxFaQdmczqw5qWchiD330lycsgwbbq8Q77jhrXBHy2QR8EYhSxzvx0eooT5aP
         nGDqMNI5slLkY6BrFwKdypcQr5p4G5s/ZYLYXQds6xfOw06mC4iai2tgr4twE7kxZt+w
         5ovEFvVoISgsXF/z9I51AkVeCCmzCzJIIA1Xu64EhyWiy3ImrWhqhsdftV0qwTTYX6YZ
         1VU2vVfLartz8o/KqlJk3QEg/ZmmrbfYonbxRoRTvzmnw/yz8aA/bom7qxwTqxmipbt9
         hQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xAUGbKK/fQ8I+ulZb26pbb2JDvVKutYnIPXuPQk8XPY=;
        fh=kPV4Xbg0hvtkWuCMd+AM8Rli6HaAlKQwJjzB31AlnHE=;
        b=VCksWUHcw0iWDXSiho/raCkWxDbuvgIfPLgwYm3wHbQznCZ4n/LpAe2gt9jOJZuSJj
         gdj9uHB8ydU4St7KgynNB63Ka8A9oEQOmYz3zh/rFTmIjRLwPjSyestgdWCPQoLTMu91
         +q8wCsbNOqRylow0YlCxdivsApJc9hWYFJjt4NPSbXwvnnKMjmMwdm2ZolidSVqSffx4
         B8LoPsi1Vswsn6U2WOE+kquZbxBpxegpoigP1bTsnqgJJ/kVvAQ4PIpY0F1DEHtusx3J
         yDjOUdDLIfA+fwjNN2jXYy1aD9ssUOHrQz4AnLChw8FrikfAI052ggP4DXLYXbH+nlKn
         FUVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776172297; x=1776777097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAUGbKK/fQ8I+ulZb26pbb2JDvVKutYnIPXuPQk8XPY=;
        b=HzKwFRLWXJZWEmzBIUXGM2NuIm4BnFqgQb7tc6umBHf2zePcGMBKQVCfgPvYI1Q1KT
         CRJdQa3euK/0koz6Q8HzGcYwJT8kv3EpmYVD4ETb+zl6Y35PKCNbpvFmLh4SAgIKMDa3
         d5sh92klUdlagzKddehgl+NgWvpni9JpQerV5TafXuroJxYmQPV144XfCwT9PFy2tztg
         FW142f7n9vpIMG147dxtjuAAawR/iYA6Sr1g3MuT1JLWNhAkYuh306QBTWKY6aQclbKZ
         mr2PpsXM9g9P+Qer5lXijomfWjRdzKlr+OqlpYslBJFc/1nTjWbRebNSn+o6zGV2u1Ga
         /gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776172297; x=1776777097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xAUGbKK/fQ8I+ulZb26pbb2JDvVKutYnIPXuPQk8XPY=;
        b=hfMwZxYkr3neoS80mf3pNfue54P/3QGqqrJk3CzjzIvch2xQvwMz9qgdHn+y5a6hSl
         o5AkeXmY+iScoX6stLP3KlPaoxh+HNfrQH5ssVovH5pfNUqBCNXhgQbhhF92c4n2k4JP
         cDoUMn4f6zZQPTFu5snBNy4oZwILSQQ/oZS7LdVagju6FBQ5sdLCJXnhhSOQE6AIKPhr
         VlRUkVcORScC/1DcaruJJ0uGq2HUbJ0HVHbjuPI6+n/SV+buRKqzcsEqXQAsjjWjuN5R
         VPa6FPT4DJ18i1tjGNk09hf5j2zI6k0axN7kxk+EDQLP+w1qqnCHjeH75fwZC/WCu83J
         cObw==
X-Forwarded-Encrypted: i=1; AFNElJ9/moC/AgX1iFiCigIIPrhS1ni/LcecA2Ur1xIo2+xcZEanbTMz9QpwIEoa88VT9AvWbDLdB8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqFH3NnDQySbpzoC3UYVYiVKkgBsagECQN0TXAbYwIoJNAh+T
	tPMJAHjhct2HmYZ/jXHNXwSAntaSf2CmOjlTzfmKWHVGpn/ElSFGb8qnjphx+HieXNrq6OU6ZbS
	Tn0xAqsXLCOhRqa8QZrIY4lCIxxr4sXo=
X-Gm-Gg: AeBDiesVoI4mQJqKMrsug1m719mrb96bHSuQsXBHKMqt3+JHWV2jnd4soI4LWqeiGAz
	ZLs9K5OH+h9/KAhTF+s0/SIVY4b5okyXx0udDWGUMu5Z19D7R3iMA2CYFlnkzHOXx8tDcmsRGAC
	p1vciLFS7CiV2HCqodi6t+6JKIKcVLG8wLkBOozmnvWwMDXtg1PQ97W+1CiB3AUN2mmxE7qj4AE
	3+n4t3o5/P0XexIotSOHJdmKYCSdp2xFZ797nSS6f2BvCo4VynMmGFEu4FJ0FoyP4aL8ugjhOt1
	LYdNxjsujoc/GoeYJBRK7TBdGGpsVQzgImBI7lDzPvnCeUAp3y5Wtcr5KC44hG7nmF/K+Q==
X-Received: by 2002:a05:7022:31b:b0:12c:3ef2:ef0b with SMTP id
 a92af1059eb24-12c3ef2ef95mr3052157c88.6.1776172296806; Tue, 14 Apr 2026
 06:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406225008.2787532-1-werner@verivus.com> <20260406225008.2787532-3-werner@verivus.com>
In-Reply-To: <20260406225008.2787532-3-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Apr 2026 09:11:25 -0400
X-Gm-Features: AQROBzAsbCXMjAgIiqqWYbip5sdNaqMuufvvZpt7WJlaFFjmFoOYluDAPOh2VSY
Message-ID: <CADnq5_OVN+uCioTWNeuHkGpkUU-VhEio_uMEBMVur6-hWXwtug@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: fix integer overflow in radeon_align_pitch()
To: Werner Kasselman <werner@verivus.ai>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-237868-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,suse.de,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,verivus.com:email,verivus.ai:email]
X-Rspamd-Queue-Id: 0ED493FA5D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 3:41=E2=80=AFAM Werner Kasselman <werner@verivus.ai>=
 wrote:
>
> radeon_align_pitch() has the same integer overflow as amdgpu's variant:
> 'aligned * cpp' can overflow signed int to 0 when alignment rounding
> pushes the width past INT_MAX/cpp. This produces a 0-byte GEM buffer
> via radeon_mode_dumb_create(), reachable from unprivileged userspace
> via DRM_IOCTL_MODE_CREATE_DUMB on the render node.
>
> Add an overflow check in radeon_align_pitch() and reject zero pitch/size
> in radeon_mode_dumb_create().
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>

Can you fix this up similar to the amdgpu patch?

Thanks,

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_gem.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 20fc87409f2e..2cd179fef347 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -828,6 +828,11 @@ int radeon_align_pitch(struct radeon_device *rdev, i=
nt width, int cpp, bool tile
>
>         aligned +=3D pitch_mask;
>         aligned &=3D ~pitch_mask;
> +
> +       /* Guard against integer overflow in aligned * cpp. */
> +       if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)
> +               return 0;
> +
>         return aligned * cpp;
>  }
>
> @@ -842,8 +847,12 @@ int radeon_mode_dumb_create(struct drm_file *file_pr=
iv,
>
>         args->pitch =3D radeon_align_pitch(rdev, args->width,
>                                          DIV_ROUND_UP(args->bpp, 8), 0);
> +       if (!args->pitch)
> +               return -EINVAL;
>         args->size =3D (u64)args->pitch * args->height;
>         args->size =3D ALIGN(args->size, PAGE_SIZE);
> +       if (!args->size)
> +               return -EINVAL;
>
>         r =3D radeon_gem_object_create(rdev, args->size, 0,
>                                      RADEON_GEM_DOMAIN_VRAM, 0,
> --
> 2.43.0
>

