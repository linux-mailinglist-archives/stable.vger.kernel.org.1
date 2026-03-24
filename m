Return-Path: <stable+bounces-230211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHg8FwTYwmllmgQAu9opvQ
	(envelope-from <stable+bounces-230211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:29:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A131AD76
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE0DC30EAEB6
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3723A3E6C;
	Tue, 24 Mar 2026 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfg+JLpx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9A391E46
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376801; cv=none; b=E4LwFmSy+/26cnW6mgHgAPtNsTTHULKR0couIEHps4smFEkuHsnYmYKzrRNjgM4FRtNdDvwBFIVvvWixhs7QwXUeGEV6IssQq7Ag8lSuOv4OPUjEIlTeBEU2DS+/60vQwPe8wxXSnFPjPoBW+V0Oe+5BljZXyPf4nVIMceGKUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376801; c=relaxed/simple;
	bh=GGfOKD68lU4mO+i2u+k2K6Xe8E5Qh/5WTgVtHzuV028=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuE/axwIax9ZBwQvlGnbEPqNNomXu6oA7+5lT1dJQmZPDBsJPMlkSMaXkZGJSTr2cwjgp3lZFCqmEpRh8SPnOMN3um1xtAZN+aWxZ0iek2ERJ15nfj2CV7BiTb1v/Kknt1LW8wHrLHLqrKskfNX/apljVOJ5HHeeESrUj0tJ22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfg+JLpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECBCC19424
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 18:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774376801;
	bh=GGfOKD68lU4mO+i2u+k2K6Xe8E5Qh/5WTgVtHzuV028=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cfg+JLpxEk+H5ramG9hxsn7Th0tre4XE69ltgh+19ghxUgDdIZmwGjYxmQYG2PBw0
	 +uEnpme9thyY+NIart74eLizikE9pbj0uDlJWd42xEcQQ2Ev+1xuC40Fnb7JekiaDV
	 /3XFrA/5t8yFZ9120TifIZJ3WdiJ9lfz1ngZc4RNX0XSDqYV5aXyAT2s54ZalGsl5B
	 gRwY1m1ubG3UID+70z+zKsLINJcB4s+jkJe3Oo9DfiVbQKp6iNHMYluejnu3HEn0Vs
	 s6LP5H0atFBrASMWgKZQeBe52iqTRdabzodbipyk0yENYVqYR/hpimTqalqyI8JlSi
	 wMJLVzarG8lew==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67ba5921b84so2401772eaf.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 11:26:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVM0JBYu0osDmz9BzZa1CqUurV52NkyFwKyRdWY+E8Y3jJ5IdNKxf5Hs4tR1idys8HS2qxD4aA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1kwNIReG9FFX3qgdy/aYwBB8xFrHaTA0/6YjvKDvf4Qx+BwS
	SMY6sQcl8Acd50UTxN+txy8f+fKPoQli8S6+n6qkIXudoj4C2j5kWU6wfAv6H2zdKBEIN9Z23od
	FI8Vd2sPjEeLxN5Sy8+r9AD7BHY7Bi70=
X-Received: by 2002:a05:6820:4dc2:b0:67d:eeb3:a2dc with SMTP id
 006d021491bc7-67dff46c33cmr473357eaf.30.1774376800859; Tue, 24 Mar 2026
 11:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324172346.3317145-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20260324172346.3317145-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Mar 2026 19:26:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h7HJqyQeahBv2eyMnhgbKk2X4zvwjpkrGdUhGBwVPueQ@mail.gmail.com>
X-Gm-Features: AaiRm51AofyFCtfcyMJYXZx_-MoCwlvouvVBHdEPvFPgfbuTn6HsAYLZFEFBHdM
Message-ID: <CAJZ5v0h7HJqyQeahBv2eyMnhgbKk2X4zvwjpkrGdUhGBwVPueQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Power Slider: Set offset only
 for balanced mode
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Erin Park <erin.park@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230211-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: CC8A131AD76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 6:23=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The slider offset can be set via debugfs for balanced mode. The offset
> should be only applicable in balanced mode. For other modes, it should
> be set 0 when writing to MMIO offset,
>
> Fixes: 8306bcaba06d ("thermal: intel: int340x: Add module parameter to ch=
ange slider offset")
> Tested-by: Erin Park <erin.park@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@vger.kernel.org # v6.18+
> ---
>  .../intel/int340x_thermal/processor_thermal_soc_slider.c  | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_=
slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slid=
er.c
> index 49ff3bae7271..91f291627132 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> @@ -176,15 +176,21 @@ static inline void write_soc_slider(struct proc_the=
rmal_device *proc_priv, u64 v
>
>  static void set_soc_power_profile(struct proc_thermal_device *proc_priv,=
 int slider)
>  {
> +       u8 offset;
>         u64 val;
>
>         val =3D read_soc_slider(proc_priv);
>         val &=3D ~SLIDER_MASK;
>         val |=3D FIELD_PREP(SLIDER_MASK, slider) | BIT(SLIDER_ENABLE_BIT)=
;
>
> +       if (slider =3D=3D SOC_SLIDER_VALUE_MINIMUM || slider =3D=3D SOC_S=
LIDER_VALUE_MAXIMUM)
> +               offset =3D 0;
> +       else
> +               offset =3D slider_offset;
> +
>         /* Set the slider offset from module params */
>         val &=3D ~SLIDER_OFFSET_MASK;
> -       val |=3D FIELD_PREP(SLIDER_OFFSET_MASK, slider_offset);
> +       val |=3D FIELD_PREP(SLIDER_OFFSET_MASK, offset);
>
>         write_soc_slider(proc_priv, val);
>  }
> --

Applied as 7.0-rc material, thanks!

