Return-Path: <stable+bounces-183135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4BBB5010
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 21:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEDF3A92DC
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 19:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628E28504B;
	Thu,  2 Oct 2025 19:27:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F22283FDB;
	Thu,  2 Oct 2025 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433272; cv=none; b=hlGwkwsZ8ub94d2rkpNfszYsRdJktAWBgMGBhfSPn7Al4IFDTUp9lfXgYsP5VJNeR51T4Hm8d94ABH7JS2cy7YzHaSInl5YHbH/rtzRtQEFHLJzQ8s150LECvU1W2y4B4WGwarFgknh1UQzwUZtQGu2NRlXPhE8xEDd/mfMaQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433272; c=relaxed/simple;
	bh=dfPXwzFbTIqiyP8bAZUg9aObi+hSzB7w4wGCsb1cv1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K40vwaj916gGGaVc3x5bz49iKVHgjexAEKc+1CCDGdjxVg1AtgEFj9Hn4cyqC4TEVrp7yreX5sctC7q8oMgnviWLq8qZwgJD5Mvh/cIDy0R1KRmQn06g5HIbyRWaujsYe1kH8ALW9dhVwtT3j44H0ewqvZyGL5+L3AAzkAvQl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [10.42.0.76] ([::ffff:94.44.132.12])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088DEE.0000000068DED233.002B4646; Thu, 02 Oct 2025 21:27:46 +0200
Message-ID: <9a684e939409ed298c69782581fda7f838d61545.camel@irl.hu>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Fix a potential race condition
 that causes a NULL pointer in case no efi.get_variable exsits
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de
Cc: broonie@kernel.org, andriy.shevchenko@linux.intel.com,
  13564923607@139.com, 13916275206@139.com,
  alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
  baojun.xu@ti.com, Baojun.Xu@fpt.com, stable@vger.kernel.org
Date: Thu, 02 Oct 2025 21:27:46 +0200
In-Reply-To: <20250911071131.1886-1-shenghao-ding@ti.com>
References: <20250911071131.1886-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Cc: <stable@vger.kernel.org>

On Thu, 2025-09-11 at 15:11 +0800, Shenghao Ding wrote:
> A a potential race condition reported by one of my customers that leads t=
o
> a NULL pointer dereference, where the call to efi.get_variable should be
> guarded with efi_rt_services_supported() to ensure that function exists.
>=20
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-=
data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> ---
>  sound/hda/codecs/side-codecs/tas2781_hda.c     | 5 +++++
>  sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 5 +++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda.c b/sound/hda/codec=
s/side-codecs/tas2781_hda.c
> index 536940c78f00..96e6d82dc69e 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda.c
> @@ -193,6 +193,11 @@ int tas2781_save_calibration(struct tas2781_hda *hda=
)
>  	efi_status_t status;
>  	int i;
> =20
> +	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> +		dev_err(p->dev, "%s: NO EFI FOUND!\n", __func__);
> +		return -EINVAL;
> +	}
> +
>  	if (hda->catlog_id < LENOVO)
>  		efi_guid =3D tasdev_fct_efi_guid[hda->catlog_id];
> =20
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/c=
odecs/side-codecs/tas2781_hda_i2c.c
> index 008dbe1490a7..4dea442d8c30 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> @@ -317,6 +317,11 @@ static int tas2563_save_calibration(struct tas2781_h=
da *h)
>  	unsigned int attr;
>  	int ret, i, j, k;
> =20
> +	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> +		dev_err(p->dev, "%s: NO EFI FOUND!\n", __func__);
> +		return -EINVAL;
> +	}
> +
>  	cd->cali_dat_sz_per_dev =3D TAS2563_CAL_DATA_SIZE * TASDEV_CALIB_N;
> =20
>  	/* extra byte for each device is the device number */

