Return-Path: <stable+bounces-130013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D40A8025F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C9C1896102
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C16267AF2;
	Tue,  8 Apr 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jO6EZrV4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B2265CDF;
	Tue,  8 Apr 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112582; cv=none; b=YUM/yS/QfQDcF2w7StlKAHZ6gz2oYRfdVI+ET410rkX4mT4U66oe0kZFbNSF5lWjJkSXMd4uC47kldrNd8RmzdVx5xaZ6uAIWqY2KMqwaAEcv7i0/16zjswnpcfkPVdo7OCa03YnfPXzAbDtOjjNe1rwI2fEZFohmb8GVDVpI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112582; c=relaxed/simple;
	bh=WmUuqs6CdHU6MXg0AnTGNtUxrHetnU+H455jvl6ZtX4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cA9ZGqb+syegHvpWOp2rOh11briASgWWCZytIerNIr1+kPPHonPmhs0twvAcYVO7muexqFFlECkmOiFFMSg+DbFID6XT6d7R91T2nckhQZRr9kVv0QenaBtwJyouGpFDsGZlHrhAqwzzy+lGhb+PoweHngQQhhHNW+ZbZGJO3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jO6EZrV4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744112580; x=1775648580;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WmUuqs6CdHU6MXg0AnTGNtUxrHetnU+H455jvl6ZtX4=;
  b=jO6EZrV4aMOhdxczwbY7ktDxVNxZc5awWTlBUNtD/bi929TCSTjboOIf
   6GIV8MJGuKT9sk3F55GsCwhdIZ8qoIo0MIoe7CfzhNK5hmPw5Y9ANme0O
   EeFBYHo0NA1AhGT3X4g7AsaWYuF14MbcSTfut/VmLQBJ0xzAjfxXSvYwE
   daIAxwg1nXyfPiQo8LqZGA/BsPTj4/3K9XXZsX6nS15S1FlxgGngSqBWz
   j8owiHjp1SRG4T+zslACeP60HSfCsiWkP9p3A7fI8lPl7nEmODwgPNTLj
   1u5nkNvgMNb+RJobXobcggPIUS3dPQmEhcnyraU+MogWMWVkjcVwWpKi5
   Q==;
X-CSE-ConnectionGUID: eLbSPKHtSRqj4Xfy6lig6w==
X-CSE-MsgGUID: ye75B30QTuqm3C0+x12TFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49336257"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="49336257"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 04:42:59 -0700
X-CSE-ConnectionGUID: 8nKxi5wEQeqiVFGQp4ldlw==
X-CSE-MsgGUID: A44sj+qEQPivZUYrdKaH2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="128754099"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 04:42:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 8 Apr 2025 14:42:53 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: mario.limonciello@amd.com, Shyam-sundar.S-k@amd.com, 
    Hans de Goede <hdegoede@redhat.com>, Yijun Shen <Yijun.Shen@dell.com>, 
    stable@vger.kernel.org, Yijun Shen <Yijun_Shen@Dell.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: amd: pmf: Fix STT limits
In-Reply-To: <20250407181915.1482450-1-superm1@kernel.org>
Message-ID: <18b0780e-15bd-d186-d14b-74638e298055@linux.intel.com>
References: <20250407181915.1482450-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-253956325-1744112573=:930"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-253956325-1744112573=:930
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 7 Apr 2025, Mario Limonciello wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> On some platforms it has been observed that STT limits are not being
> applied properly causing poor performance as power limits are set too low=
=2E
>=20
> STT limits that are sent to the platform are supposed to be in Q8.8
> format.  Convert them before sending.
>=20
> Reported-by: Yijun Shen <Yijun.Shen@dell.com>
> Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Policy B=
inary")
> Cc: stable@vger.kernel.org
> Tested-by: Yijun Shen <Yijun_Shen@Dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
> v3:
>  * Add a helper with a generic name (so it can be easily be moved to libr=
ary
>    code in the future)
> ---
>  drivers/platform/x86/amd/pmf/auto-mode.c |  4 ++--
>  drivers/platform/x86/amd/pmf/cnqf.c      |  8 ++++----
>  drivers/platform/x86/amd/pmf/core.c      | 14 ++++++++++++++
>  drivers/platform/x86/amd/pmf/pmf.h       |  1 +
>  drivers/platform/x86/amd/pmf/sps.c       | 12 ++++++++----
>  drivers/platform/x86/amd/pmf/tee-if.c    |  6 ++++--
>  6 files changed, 33 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/platform/x86/amd/pmf/auto-mode.c b/drivers/platform/=
x86/amd/pmf/auto-mode.c
> index 02ff68be10d01..1400ac70c52d1 100644
> --- a/drivers/platform/x86/amd/pmf/auto-mode.c
> +++ b/drivers/platform/x86/amd/pmf/auto-mode.c
> @@ -120,9 +120,9 @@ static void amd_pmf_set_automode(struct amd_pmf_dev *=
dev, int idx,
>  =09amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pwr_ctrl->sppt_apu_on=
ly, NULL);
>  =09amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pwr_ctrl->stt_min, NU=
LL);
>  =09amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> -=09=09=09 pwr_ctrl->stt_skin_temp[STT_TEMP_APU], NULL);
> +=09=09=09 fixp_q88_from_integer(pwr_ctrl->stt_skin_temp[STT_TEMP_APU]), =
NULL);
>  =09amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> -=09=09=09 pwr_ctrl->stt_skin_temp[STT_TEMP_HS2], NULL);
> +=09=09=09 fixp_q88_from_integer(pwr_ctrl->stt_skin_temp[STT_TEMP_HS2]), =
NULL);
> =20
>  =09if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
>  =09=09apmf_update_fan_idx(dev, config_store.mode_set[idx].fan_control.ma=
nual,
> diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/a=
md/pmf/cnqf.c
> index bc8899e15c914..3cde8a5de64a9 100644
> --- a/drivers/platform/x86/amd/pmf/cnqf.c
> +++ b/drivers/platform/x86/amd/pmf/cnqf.c
> @@ -81,10 +81,10 @@ static int amd_pmf_set_cnqf(struct amd_pmf_dev *dev, =
int src, int idx,
>  =09amd_pmf_send_cmd(dev, SET_SPPT, false, pc->sppt, NULL);
>  =09amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pc->sppt_apu_only, NU=
LL);
>  =09amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pc->stt_min, NULL);
> -=09amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, pc->stt_skin_temp[STT=
_TEMP_APU],
> -=09=09=09 NULL);
> -=09amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, pc->stt_skin_temp[STT=
_TEMP_HS2],
> -=09=09=09 NULL);
> +=09amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> +=09=09=09 fixp_q88_from_integer(pc->stt_skin_temp[STT_TEMP_APU]), NULL);
> +=09amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> +=09=09=09 fixp_q88_from_integer(pc->stt_skin_temp[STT_TEMP_HS2]), NULL);
> =20
>  =09if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
>  =09=09apmf_update_fan_idx(dev,
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/a=
md/pmf/core.c
> index a2cb2d5544f5b..5209996eba674 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -176,6 +176,20 @@ static void __maybe_unused amd_pmf_dump_registers(st=
ruct amd_pmf_dev *dev)
>  =09dev_dbg(dev->dev, "AMD_PMF_REGISTER_MESSAGE:%x\n", value);
>  }
> =20
> +/**
> + * fixp_q88_from_integer: Convert integer to Q8.8
> + * @val: input value
> + *
> + * Converts an integer into binary fixed point format where 8 bits
> + * are used for integer and 8 bits are used for the decimal.
> + *
> + * Return: unsigned integer converted to Q8.8 format
> + */
> +u32 fixp_q88_from_integer(u32 val)
> +{
> +=09return val << 8;
> +}
> +
>  int amd_pmf_send_cmd(struct amd_pmf_dev *dev, u8 message, bool get, u32 =
arg, u32 *data)
>  {
>  =09int rc;
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/am=
d/pmf/pmf.h
> index e6bdee68ccf34..2865e0a70b43d 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -777,6 +777,7 @@ int apmf_install_handler(struct amd_pmf_dev *pmf_dev)=
;
>  int apmf_os_power_slider_update(struct amd_pmf_dev *dev, u8 flag);
>  int amd_pmf_set_dram_addr(struct amd_pmf_dev *dev, bool alloc_buffer);
>  int amd_pmf_notify_sbios_heartbeat_event_v2(struct amd_pmf_dev *dev, u8 =
flag);
> +u32 fixp_q88_from_integer(u32 val);
> =20
>  /* SPS Layer */
>  int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf);
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/am=
d/pmf/sps.c
> index d3083383f11fb..dfc5285b681f7 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -198,9 +198,11 @@ static void amd_pmf_update_slider_v2(struct amd_pmf_=
dev *dev, int idx)
>  =09amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
>  =09=09=09 apts_config_store.val[idx].stt_min_limit, NULL);
>  =09amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> -=09=09=09 apts_config_store.val[idx].stt_skin_temp_limit_apu, NULL);
> +=09=09=09 fixp_q88_from_integer(apts_config_store.val[idx].stt_skin_temp=
_limit_apu),
> +=09=09=09 NULL);
>  =09amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> -=09=09=09 apts_config_store.val[idx].stt_skin_temp_limit_hs2, NULL);
> +=09=09=09 fixp_q88_from_integer(apts_config_store.val[idx].stt_skin_temp=
_limit_hs2),
> +=09=09=09 NULL);
>  }
> =20
>  void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
> @@ -217,9 +219,11 @@ void amd_pmf_update_slider(struct amd_pmf_dev *dev, =
bool op, int idx,
>  =09=09amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
>  =09=09=09=09 config_store.prop[src][idx].stt_min, NULL);
>  =09=09amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> -=09=09=09=09 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU], NU=
LL);
> +=09=09=09=09 fixp_q88_from_integer(config_store.prop[src][idx].stt_skin_=
temp[STT_TEMP_APU]),
> +=09=09=09=09 NULL);
>  =09=09amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> -=09=09=09=09 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2], NU=
LL);
> +=09=09=09=09 fixp_q88_from_integer(config_store.prop[src][idx].stt_skin_=
temp[STT_TEMP_HS2]),
> +=09=09=09=09 NULL);
>  =09} else if (op =3D=3D SLIDER_OP_GET) {
>  =09=09amd_pmf_send_cmd(dev, GET_SPL, true, ARG_NONE, &table->prop[src][i=
dx].spl);
>  =09=09amd_pmf_send_cmd(dev, GET_FPPT, true, ARG_NONE, &table->prop[src][=
idx].fppt);
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86=
/amd/pmf/tee-if.c
> index a1e43873a07b0..22d48048f9d01 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -123,7 +123,8 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev=
 *dev, struct ta_pmf_enact_
> =20
>  =09=09case PMF_POLICY_STT_SKINTEMP_APU:
>  =09=09=09if (dev->prev_data->stt_skintemp_apu !=3D val) {
> -=09=09=09=09amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val, NULL);
> +=09=09=09=09amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> +=09=09=09=09=09=09 fixp_q88_from_integer(val), NULL);
>  =09=09=09=09dev_dbg(dev->dev, "update STT_SKINTEMP_APU: %u\n", val);
>  =09=09=09=09dev->prev_data->stt_skintemp_apu =3D val;
>  =09=09=09}
> @@ -131,7 +132,8 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev=
 *dev, struct ta_pmf_enact_
> =20
>  =09=09case PMF_POLICY_STT_SKINTEMP_HS2:
>  =09=09=09if (dev->prev_data->stt_skintemp_hs2 !=3D val) {
> -=09=09=09=09amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val, NULL);
> +=09=09=09=09amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> +=09=09=09=09=09=09 fixp_q88_from_integer(val), NULL);
>  =09=09=09=09dev_dbg(dev->dev, "update STT_SKINTEMP_HS2: %u\n", val);
>  =09=09=09=09dev->prev_data->stt_skintemp_hs2 =3D val;
>  =09=09=09}
>=20
--8323328-253956325-1744112573=:930--

