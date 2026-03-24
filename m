Return-Path: <stable+bounces-230158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCpSJmqSwmkXfAQAu9opvQ
	(envelope-from <stable+bounces-230158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:32:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D913097A4
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 325573077436
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B5E3DEFE6;
	Tue, 24 Mar 2026 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E71IkiB9"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7452274B5F
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358475; cv=pass; b=ClZeyBMYWIH2/06IDGgynju9a/tVrsI+vAyD7WZBLIXXMRZmSk/Qj/5SPgaHbeRLZ9B2YPOzdePEeY0AZquMFQ+vIUZXdbGIRBPPHIOvrYzosYMN5rbEaO33RpW76jQvGFqn/j0CdXrzjfkTJDilfL+lhztmpU/mI/74OzqSKb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358475; c=relaxed/simple;
	bh=E2K6UWouZ6GIsccDzOW7X05UUlYsTLnpQz7xXosNaUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koVegxcyjIV9M9xssIjDcyH75nHVXB+k+ogPbClErwpEcATiO8Zxn41knOcqUdO+pPnyf3dr3TAPRnhatRRGd43E7/jzLk+zNSYYcuqHcsz4R4B934IwPtrDcqONct2Lr5MaywEjXiwaOmjcUbyq1wjktpLd1ekd4Ux5tmu7lGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E71IkiB9; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c0b6f22aa4so314641eec.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 06:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358473; cv=none;
        d=google.com; s=arc-20240605;
        b=NnL30QlSMgjDMOFbOpoRxUGuE9zKPyFzKFsBacXWniLJS6eGdud+ncdgL1XtB1NkPa
         tPCAaVLSsRTdRhoUKVGdn7UJhYDuE0RtWx1OSPTOxkoZn8veYGqrXQRpYdoL+EAF/WBu
         VT+4TiTN+EUsxnXHcXQ6ZWX5F+LMTY7m05nYWBzid9edIyCDyQd8wgpMX2BwN5UUM1tH
         DV8fQpWMB/0zr2o659LAobwCilZGEFDyEUpS0zFNFT/k91OvBFPXwWU6vzUYfvLJN5p9
         MHl8+OPjwf16odG3LagB5JfzYW1sQfMkgE9oMV9qugSWcrfrdwFZPUyTxg6q9MGJ8FHf
         OQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CutxZk0UywMMX9SEC6rWk5Mmx6PoN5/HmY4U6NLKJsA=;
        fh=EgXva56i5MRNslyBV83R+3TZuAc7uXgC+N17Me73gIk=;
        b=eVHdDUJy+u3nTugnFC8t2GE7QUmXiwP0vtLaRl3ACFeMlstl3K3yP1N6eeAUCEc8lR
         aZ4Uf/b67EK9T4ASvjgxuq3d3rEMUiCeo3Z91ZG46R43eQsxVW/E6OOetYDdCaO+jMct
         vmRFzsLuXkJatD5q/wJC/Dcti317Fpd2D8BbFsvdreuZ0czW8IHkO2oXN9A7N73gJ+ZD
         iCObW9LsI439dSxOVy8vuvyQhSkThC/+9SzczQEyF8BGcfGlhp6y7yT7ZtE1UVvN1D0b
         XWc0D+6ZpeLbS596EItm6k6KWEEOZ32sLqE4/pN997v4j2elh7DFIUfdjW4S7d/NeUSs
         TN2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774358473; x=1774963273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CutxZk0UywMMX9SEC6rWk5Mmx6PoN5/HmY4U6NLKJsA=;
        b=E71IkiB93lvJetEbffXkYPwEivXoezX9QgNpan0PwDOtbEwn9t7wZUsnKdAGE6Jiv0
         zEWyK/KS1haXiJvfvRYDyxjw6tNBYUqteLwvOIFr/zF3r2xg/C058LGt6zR2fTKQujym
         yOUCe6CqmDVMfIASxrLC/X99di6zKG8lQk/b5CcVUPOFmEIhDSiiZsM+/9E4f7B00PdC
         VlPxjDbQns5Ah4uZx0DzM3sXgxUGCUVnxaMXL81TxEaXK/6Z7Dv15bzbjbEoz8mPeP3O
         B89M6FpdWIrVhVhhNg/eCyaR3zl/Pj1JBcCac2VyRBzKFMYp289Tzru7kiOEk8OO8nZm
         33ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358473; x=1774963273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CutxZk0UywMMX9SEC6rWk5Mmx6PoN5/HmY4U6NLKJsA=;
        b=k1+OxJ2S+MgvXfgLTxywNWxiN0By+bbcYEn510crzVBcw92V2Jl7CtRAncQ93mGRH7
         O5Sb7cw4FnaKbRw124dydJhMcPWIGFDPIU87JYV9Vp2mI3tI5tENRmfHHhfyHi2gv618
         x9M3jDtkEPVMVOqFTIQzCnTnexz0xxxlgbRhz1q/CGT5sGe3TymS8ZlgqoxhUvyQPau/
         snBjE+D8spAoudakGX1O3feYJ1RJXo8CiNj/EOZlYNk4z/n4kfr3LQ+oX5OZYOv3kzb0
         gucdC4moNaiV8QPucmTK82JijYiHQo6OgTZMDxk1RbtiEwAI8LfgrTvJH40o+AC2gxZq
         3xgA==
X-Forwarded-Encrypted: i=1; AJvYcCXwZtmFxUeuImps92aFUMmz1PM1wJx87nCLXXKDfHbcOu3CX9YJ2CkNBZQUjaRndVs37b89jWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYKP/mcd1ZXi4kU4IczXL1olpPKyharDhfMYp1Pod2+kweZTQu
	Z5WSHwowhmYSqmKR1qrPPCj2O3weFneNlJLwrIIHG4GBcKMUCt30Yh0jLNHydPJHz/vStyfXcCy
	B1RjNUUik+aQyxEkF7faQHff+HGZEVjE=
X-Gm-Gg: ATEYQzzvA6g6NN7Gwxi8bttP814q+TXtUIIG0tgLxotsAMsV2QpaiqW0Qv3k652RzgR
	MFQAE1voCR8M4dFcuxM9FMgp/4KcIMWO4Q7JunnMV9W5HaHJixqo+VCbq/5o25xGOMbj7oQWj/L
	tkCUTfX7MwSI3uefmUDTYFy/P0VeRNX3C3sDaih1HlLG6PYTek3ld5cssPQbcdxkr001QpZL+M4
	6aGAUMaoTlejNqS7tD8y9jD4ZME06D2Z4uREJqJTQDSfMW9IHNhZL/0cUfPsNYr5yc2OS7UN8TE
	sL/iPDNpFMHyWe0SxKrVV59FPyAwND/rDexhwzBrJ3LES2ozhAHM56C41blofvrHHosUiw==
X-Received: by 2002:a05:7022:6b81:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-12a726b5c4emr3201201c88.3.1774358472868; Tue, 24 Mar 2026
 06:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
In-Reply-To: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:21:01 -0400
X-Gm-Features: AaiRm53DpWv5pr0QiHY6HEkx6D6NV3ewBXmw1gn7c17yw41TFZ5-avxtdFneTm4
Message-ID: <CADnq5_OTKJCJf-szPfak1r04fawGhJ-9H=Uzvyh3dmTmP1KYLg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: Mario Kleiner <mario.kleiner.de@gmail.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
	Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org, Aric Cyr <aric.cyr@amd.com>, 
	Anthony Koo <anthony.koo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, 
	Krunoslav Kovac <krunoslav.kovac@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230158-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexdeucher@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9D913097A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ Harry, Alex

On Sat, Mar 21, 2026 at 1:29=E2=80=AFAM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Commit d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to
> round") degraded display of 12 bpc color precision output to 10 bpc sinks
> by switching 10 bpc output from dithering to "truncate to 10 bpc".
>
> I don't find the argumentation in that commit convincing, but the
> consequences highly unfortunate, especially for applications that
> require effective > 10 bpc precision output of > 10 bpc framebuffers.
>
> The argument wasn't something strong like "there are hardware design
> defects or limitations which require us to work around broken dithering
> to 10 bpc", or "there are some special use cases which do require
> truncation to 10 bpc", but essentially "at some point in the past we
> used truncation in Polaris/Vega times and it looks like it got
> inadvertently changed for Navi, so let's do that again". I couldn't find
> evidence for that in the git commit logs for this. The commit message als=
o
> acknowledges that using dithering "...makes some sense for FP16...
> ...but not for ARGB2101010 surfaces..."
>
> The problem with this is that it makes fp16 surfaces, and especially
> rgba16 fixed point surfaces, less useful. These are now well
> supported by Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by
> OSS AMDVLK Vulkan/WSI/display, and also by GNOME 50 mutter under Wayland,
> and they used to provide more than 10 bpc effective precision at the
> output.
>
> Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuffer,
> e.g., gamma tables, CTM, can be used for color correction and will
> benefit from an effective > 10 bpc output precision via dithering,
> retaining some precision that would get lost on the way through the
> pipeline, e.g., due to non-linear gamma functions.
>
> Scientific apps rely on this for > 10 bpc display precision. Truncating
> to 10 bpc, instead of dithering the pipeline internal 12 bpc precision
> down to 10 bpc, causes a serious loss of precision. This also creates the
> undesirable and slightly absurd situation that using a cheap monitor
> with only 8 bpc input and display panel will yield roughly 12 bpc
> precision via dithering from 12 -> 8 bpc, whereas investment into a
> more expensive monitor with 10 bpc input and native 10 bpc display will
> only yield 10 bpc, even if a fp16 or rgb16 framebuffer and/or a properly
> set up color pipeline (gamma tables, CTM's etc. with more than 10 bpc out
> precision) would allow effective 12 bpc precision output.
>
> Therefore this patch proposes reverting that commit and going back to
> dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8 bp=
c
> output.
>
> Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 with
> a native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer an=
d
> measuring resulting color precision with a photometer. No apparent visual
> artifacts or problems were observed, and effective precision was measured
> to be 12 bpc again, as expected.
>
> Fixes: d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to =
round")
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: stable@vger.kernel.org
> Cc: Aric Cyr <aric.cyr@amd.com>
> Cc: Anthony Koo <anthony.koo@amd.com>
> Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index c9fbb64d706a..29db5404c4a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -5056,7 +5056,7 @@ void resource_build_bit_depth_reduction_params(stru=
ct dc_stream_state *stream,
>                         option =3D DITHER_OPTION_SPATIAL8;
>                         break;
>                 case COLOR_DEPTH_101010:
> -                       option =3D DITHER_OPTION_TRUN10;
> +                       option =3D DITHER_OPTION_SPATIAL10;
>                         break;
>                 default:
>                         option =3D DITHER_OPTION_DISABLE;
> --
> 2.43.0
>

