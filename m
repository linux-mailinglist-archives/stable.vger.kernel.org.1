Return-Path: <stable+bounces-200473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C044CB0C0F
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 18:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3C61300D674
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD461224B0D;
	Tue,  9 Dec 2025 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ6lHMdv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CA2BE7AB
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765301948; cv=none; b=cpOKLNrnTZPVboR0HPHhzD9m1ZDR/8v9AW79okGEXWnw8IC/y/nAfTDT1aIOCkC1BfoT92AwwcqjcMao6I+FqRlBEZsbqqj9f8v2jPE7nVI51BRl4EvGdOd39oE7mkjP7VZ18qxOzAAcmqJ7NxkjpujbZX3dWLxYZL0iDC6dfys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765301948; c=relaxed/simple;
	bh=Ye11IcuWXdM9+xpR/jtMzNKSNPpLwCGfQHPzvnziZhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFJtyBv2h+V9BwoV4ulez5jce+M+sTf1Ie0XHW6uJEbU2r3fKrqB2fJE7hMT6Ppir3Jj2ytVD5J1YrDP8OXZyMSbj0HTZhGQt1SxGd4X2fxvEa5aWq9tIaifIn5826BkPyb7Fn/gv1VotI+okGb87rMI2waR5LSP2Ha0nYsGZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ6lHMdv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ba92341f07so490637b3a.1
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765301946; x=1765906746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scf5q+0s3wMyzUYRgD/IWOZ3a3fw8fKvdmukhDzBXTg=;
        b=TZ6lHMdvLTjetFzlvANWZji4zp2tLl/1ylCDjXIKI4I+yqdXNP9doxnKbnWE/OgAGQ
         28WLKDOc/szqH0B1z0ipal36X0MDRPALuMJ620wXI0pi/Sl+/rrVUqb634+5RTe+nq7M
         R3zLxTm1+DgSi3vajo6A1O9LGJyHtEHJenSMZLoN/ZHeiuZjUbH/VwAC8yphF9FYaxcd
         X8er0gcOLoVAmUP2ZjFdoYLF+Bmqwh1UbovZVAxZi4GFAn+rjD3YThnJTyYQQbURP+jo
         sUpH8zpShJ5p/Aa7h3cEIFRvCZ+kWqjFPWqVvqfQN/ZkDcvB8oOGUAj2XX8qfnVSF/+Y
         oSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765301946; x=1765906746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scf5q+0s3wMyzUYRgD/IWOZ3a3fw8fKvdmukhDzBXTg=;
        b=r7H374y3fH1GdzBlY2hEjH9O4q3HSenwxp96JtLZ+5R0nicVx+AJnH/oYtNH/v+IUI
         R0Qs8vy0hJLhC0P0DwT6pCh8UV34/OooyTQZ1vJjDLLJDMKXhaKyb3yeMuYyZMOWnkIW
         iz8iThfyGJtWHqPFNeWnDsSeYbfhL3zdkCHnSoz48dKEnEiINEYj3GsKJX4dX3xDbLis
         zb512/otLpfLw2DCnmfExiTxKVapNieAGUUiGp3PNQmL0yErQBxv2KW0rWHWRz0gk5c5
         K0v/W4uyB/oKsJPBekywqVsMUJP7cntyV/Jzh6n+75m3R9bQOYiX2Aexi3vk+x36+Iee
         dS6g==
X-Forwarded-Encrypted: i=1; AJvYcCU6GX9bNH4FZ31Nr6n0N/fKwpJOi6ZxELu5ybJfWt3lqbahG9Zw1Cy/GJ11d+XUspMdMDwh/g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWvQ0oU6CW4V56+BNO1bC4WHBRLo/zvYCYB4PE4n0sFBvwyu2
	1Zs6rekmDDckrVO5Jok5tJ5NSc+IeudXztdMfbvfIrQBfPbMh4VrlUGlVlaBvyNRkZZDRNB31xV
	web7cto0RndlPQ6EbeVupUrDmJvA74VTvrQ==
X-Gm-Gg: ASbGnctTuHyi+7bNxZT4nP4C1X9Sp5xpsC1CM77dq+yfYlA25lF+41aY+e8JI/3cnpP
	m0s6gKkowdOu7efTrZ6wIftcet3JWwHd7KTy7j6iTX+S2e2P9Tx6JD6qKq9/osC5ZZHg5DdKg4+
	THHvDEheHKX/DtLtUJV+pXMQK6dICMTJeVv8Qly7c5yflwpBNLhEHGXcWCthoeAjLug19gx8m1o
	UPOeHwNluQb8oeBaTzuSL0Lw08NycaoMOThSuW+rZ14/qnl0NN0Iwo6+azfPzb/PMCUCm8=
X-Google-Smtp-Source: AGHT+IEIfMnZrDOZIAZizXLjusBYlysHvqTBGVTJ6O/RM4zJA3/NW94DtI1gvOTIrZxr7Y7e2YvUsJESl4t5jkmQCcQ=
X-Received: by 2002:a05:7022:323:b0:11b:65e:f33 with SMTP id
 a92af1059eb24-11e03168cb3mr4783691c88.1.1765301945900; Tue, 09 Dec 2025
 09:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209171810.2514240-1-mario.limonciello@amd.com>
In-Reply-To: <20251209171810.2514240-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Dec 2025 12:38:54 -0500
X-Gm-Features: AQt7F2pipxZirUMos8ZVYZFNY1h1cynbTdEfFCmkqLomC9hSeF8U4RhYwDuXNHo
Message-ID: <CADnq5_NPH4NEnTKJLhA9jU8YLo=JdOsqNjCG4YZvut4j6BpFsw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Fix pbn to kbps Conversion"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jerry Zuo <jerry.zuo@amd.com>, 
	stable@vger.kernel.org, nat@nullable.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 12:34=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Deeply daisy chained DP/MST displays are no longer able to light
> up. This reverts commit 1788ef30725da53face7e311cdf62ad65fababcd.
>
> Cc: Jerry Zuo <jerry.zuo@amd.com>
> Cc: stable@vger.kernel.org # 6.17+
> Reported-by: nat@nullable.se
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4756
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 59 +++++++++++--------
>  1 file changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index dbd1da4d85d3..5e92eaa67aa3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -884,28 +884,26 @@ struct dsc_mst_fairness_params {
>  };
>
>  #if defined(CONFIG_DRM_AMD_DC_FP)
> -static uint64_t kbps_to_pbn(int kbps, bool is_peak_pbn)
> +static uint16_t get_fec_overhead_multiplier(struct dc_link *dc_link)
>  {
> -       uint64_t effective_kbps =3D (uint64_t)kbps;
> +       u8 link_coding_cap;
> +       uint16_t fec_overhead_multiplier_x1000 =3D PBN_FEC_OVERHEAD_MULTI=
PLIER_8B_10B;
>
> -       if (is_peak_pbn) {      // add 0.6% (1006/1000) overhead into eff=
ective kbps
> -               effective_kbps *=3D 1006;
> -               effective_kbps =3D div_u64(effective_kbps, 1000);
> -       }
> +       link_coding_cap =3D dc_link_dp_mst_decide_link_encoding_format(dc=
_link);
> +       if (link_coding_cap =3D=3D DP_128b_132b_ENCODING)
> +               fec_overhead_multiplier_x1000 =3D PBN_FEC_OVERHEAD_MULTIP=
LIER_128B_132B;
>
> -       return (uint64_t) DIV64_U64_ROUND_UP(effective_kbps * 64, (54 * 8=
 * 1000));
> +       return fec_overhead_multiplier_x1000;
>  }
>
> -static uint32_t pbn_to_kbps(unsigned int pbn, bool with_margin)
> +static int kbps_to_peak_pbn(int kbps, uint16_t fec_overhead_multiplier_x=
1000)
>  {
> -       uint64_t pbn_effective =3D (uint64_t)pbn;
> -
> -       if (with_margin)        // deduct 0.6% (994/1000) overhead from e=
ffective pbn
> -               pbn_effective *=3D (1000000 / PEAK_FACTOR_X1000);
> -       else
> -               pbn_effective *=3D 1000;
> +       u64 peak_kbps =3D kbps;
>
> -       return DIV_U64_ROUND_UP(pbn_effective * 8 * 54, 64);
> +       peak_kbps *=3D 1006;
> +       peak_kbps *=3D fec_overhead_multiplier_x1000;
> +       peak_kbps =3D div_u64(peak_kbps, 1000 * 1000);
> +       return (int) DIV64_U64_ROUND_UP(peak_kbps * 64, (54 * 8 * 1000));
>  }
>
>  static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_p=
arams *params,
> @@ -976,7 +974,7 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_p=
arams param, int pbn)
>         dc_dsc_get_default_config_option(param.sink->ctx->dc, &dsc_option=
s);
>         dsc_options.max_target_bpp_limit_override_x16 =3D drm_connector->=
display_info.max_dsc_bpp * 16;
>
> -       kbps =3D pbn_to_kbps(pbn, false);
> +       kbps =3D div_u64((u64)pbn * 994 * 8 * 54, 64);
>         dc_dsc_compute_config(
>                         param.sink->ctx->dc->res_pool->dscs[0],
>                         &param.sink->dsc_caps.dsc_dec_caps,
> @@ -1005,11 +1003,12 @@ static int increase_dsc_bpp(struct drm_atomic_sta=
te *state,
>         int link_timeslots_used;
>         int fair_pbn_alloc;
>         int ret =3D 0;
> +       uint16_t fec_overhead_multiplier_x1000 =3D get_fec_overhead_multi=
plier(dc_link);
>
>         for (i =3D 0; i < count; i++) {
>                 if (vars[i + k].dsc_enabled) {
>                         initial_slack[i] =3D
> -                       kbps_to_pbn(params[i].bw_range.max_kbps, false) -=
 vars[i + k].pbn;
> +                       kbps_to_peak_pbn(params[i].bw_range.max_kbps, fec=
_overhead_multiplier_x1000) - vars[i + k].pbn;
>                         bpp_increased[i] =3D false;
>                         remaining_to_increase +=3D 1;
>                 } else {
> @@ -1105,6 +1104,7 @@ static int try_disable_dsc(struct drm_atomic_state =
*state,
>         int next_index;
>         int remaining_to_try =3D 0;
>         int ret;
> +       uint16_t fec_overhead_multiplier_x1000 =3D get_fec_overhead_multi=
plier(dc_link);
>         int var_pbn;
>
>         for (i =3D 0; i < count; i++) {
> @@ -1137,7 +1137,7 @@ static int try_disable_dsc(struct drm_atomic_state =
*state,
>
>                 DRM_DEBUG_DRIVER("MST_DSC index #%d, try no compression\n=
", next_index);
>                 var_pbn =3D vars[next_index].pbn;
> -               vars[next_index].pbn =3D kbps_to_pbn(params[next_index].b=
w_range.stream_kbps, true);
> +               vars[next_index].pbn =3D kbps_to_peak_pbn(params[next_ind=
ex].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
>                 ret =3D drm_dp_atomic_find_time_slots(state,
>                                                     params[next_index].po=
rt->mgr,
>                                                     params[next_index].po=
rt,
> @@ -1197,6 +1197,7 @@ static int compute_mst_dsc_configs_for_link(struct =
drm_atomic_state *state,
>         int count =3D 0;
>         int i, k, ret;
>         bool debugfs_overwrite =3D false;
> +       uint16_t fec_overhead_multiplier_x1000 =3D get_fec_overhead_multi=
plier(dc_link);
>         struct drm_connector_state *new_conn_state;
>
>         memset(params, 0, sizeof(params));
> @@ -1277,7 +1278,7 @@ static int compute_mst_dsc_configs_for_link(struct =
drm_atomic_state *state,
>         DRM_DEBUG_DRIVER("MST_DSC Try no compression\n");
>         for (i =3D 0; i < count; i++) {
>                 vars[i + k].aconnector =3D params[i].aconnector;
> -               vars[i + k].pbn =3D kbps_to_pbn(params[i].bw_range.stream=
_kbps, false);
> +               vars[i + k].pbn =3D kbps_to_peak_pbn(params[i].bw_range.s=
tream_kbps, fec_overhead_multiplier_x1000);
>                 vars[i + k].dsc_enabled =3D false;
>                 vars[i + k].bpp_x16 =3D 0;
>                 ret =3D drm_dp_atomic_find_time_slots(state, params[i].po=
rt->mgr, params[i].port,
> @@ -1299,7 +1300,7 @@ static int compute_mst_dsc_configs_for_link(struct =
drm_atomic_state *state,
>         DRM_DEBUG_DRIVER("MST_DSC Try max compression\n");
>         for (i =3D 0; i < count; i++) {
>                 if (params[i].compression_possible && params[i].clock_for=
ce_enable !=3D DSC_CLK_FORCE_DISABLE) {
> -                       vars[i + k].pbn =3D kbps_to_pbn(params[i].bw_rang=
e.min_kbps, false);
> +                       vars[i + k].pbn =3D kbps_to_peak_pbn(params[i].bw=
_range.min_kbps, fec_overhead_multiplier_x1000);
>                         vars[i + k].dsc_enabled =3D true;
>                         vars[i + k].bpp_x16 =3D params[i].bw_range.min_ta=
rget_bpp_x16;
>                         ret =3D drm_dp_atomic_find_time_slots(state, para=
ms[i].port->mgr,
> @@ -1307,7 +1308,7 @@ static int compute_mst_dsc_configs_for_link(struct =
drm_atomic_state *state,
>                         if (ret < 0)
>                                 return ret;
>                 } else {
> -                       vars[i + k].pbn =3D kbps_to_pbn(params[i].bw_rang=
e.stream_kbps, false);
> +                       vars[i + k].pbn =3D kbps_to_peak_pbn(params[i].bw=
_range.stream_kbps, fec_overhead_multiplier_x1000);
>                         vars[i + k].dsc_enabled =3D false;
>                         vars[i + k].bpp_x16 =3D 0;
>                         ret =3D drm_dp_atomic_find_time_slots(state, para=
ms[i].port->mgr,
> @@ -1762,6 +1763,18 @@ int pre_validate_dsc(struct drm_atomic_state *stat=
e,
>         return ret;
>  }
>
> +static uint32_t kbps_from_pbn(unsigned int pbn)
> +{
> +       uint64_t kbps =3D (uint64_t)pbn;
> +
> +       kbps *=3D (1000000 / PEAK_FACTOR_X1000);
> +       kbps *=3D 8;
> +       kbps *=3D 54;
> +       kbps /=3D 64;
> +
> +       return (uint32_t)kbps;
> +}
> +
>  static bool is_dsc_common_config_possible(struct dc_stream_state *stream=
,
>                                           struct dc_dsc_bw_range *bw_rang=
e)
>  {
> @@ -1860,7 +1873,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
>                         dc_link_get_highest_encoding_format(stream->link)=
);
>         cur_link_settings =3D stream->link->verified_link_cap;
>         root_link_bw_in_kbps =3D dc_link_bandwidth_kbps(aconnector->dc_li=
nk, &cur_link_settings);
> -       virtual_channel_bw_in_kbps =3D pbn_to_kbps(aconnector->mst_output=
_port->full_pbn, true);
> +       virtual_channel_bw_in_kbps =3D kbps_from_pbn(aconnector->mst_outp=
ut_port->full_pbn);
>
>         /* pick the end to end bw bottleneck */
>         end_to_end_bw_in_kbps =3D min(root_link_bw_in_kbps, virtual_chann=
el_bw_in_kbps);
> @@ -1913,7 +1926,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
>                                 immediate_upstream_port =3D aconnector->m=
st_output_port->parent->port_parent;
>
>                         if (immediate_upstream_port) {
> -                               virtual_channel_bw_in_kbps =3D pbn_to_kbp=
s(immediate_upstream_port->full_pbn, true);
> +                               virtual_channel_bw_in_kbps =3D kbps_from_=
pbn(immediate_upstream_port->full_pbn);
>                                 virtual_channel_bw_in_kbps =3D min(root_l=
ink_bw_in_kbps, virtual_channel_bw_in_kbps);
>                         } else {
>                                 /* For topology LCT 1 case - only one mst=
b*/
> --
> 2.51.2
>

