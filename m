Return-Path: <stable+bounces-183136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDE5BB502B
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 21:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6034B3C0A6D
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 19:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95DA27B325;
	Thu,  2 Oct 2025 19:31:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF9A93D;
	Thu,  2 Oct 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433481; cv=none; b=WLXU45/z+eNkaXMuo321kffhMkBWvGcSAKyLwxcdk2SCRu4gkrmBX6RewSW887YPJQ21TsDOiddlStnG0k4HX7pxGeHO5DE/TdTU4EkyUQbjmZOCbjkY8x7wR42SlaQtU8gyqhh76Emn6Nt1N3uBTq7WQ2X42/svkVRU+y5X6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433481; c=relaxed/simple;
	bh=uJ6VvsarBYT3wlZHSIo5DU3IhfD35toP8v+Z77bcdyQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uPN5YyhnbSiQxxpprpqzCje86lMdbFtADWTSGtvYyJEP/m8UA6lZLDlgFTZ0UO1SCV1tRObsGJsvawIBK/z08bgRxlv0T/hZar0smVPPQBmdEM2nuIbc5HGz8u5j4yQDIpwDy3I+Hwf7M12JtI8PVZkrLA7cQoNekXeDzfJ3/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [10.42.0.76] ([::ffff:94.44.132.12])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088DE7.0000000068DED1D0.002B460A; Thu, 02 Oct 2025 21:26:07 +0200
Message-ID: <d11c8b06ec79871df74f893da41e81c2f1bcaee2.camel@irl.hu>
Subject: Re: [PATCH v4] ALSA: hda/tas2781: Fix the order of TAS2781
 calibrated-data
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de
Cc: broonie@kernel.org, andriy.shevchenko@linux.intel.com,
  13564923607@139.com, 13916275206@139.com,
  alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
  baojun.xu@ti.com, Baojun.Xu@fpt.com, stable@vger.kernel.org
Date: Thu, 02 Oct 2025 21:26:06 +0200
In-Reply-To: <20250907222728.988-1-shenghao-ding@ti.com>
References: <20250907222728.988-1-shenghao-ding@ti.com>
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

On Mon, 2025-09-08 at 06:27 +0800, Shenghao Ding wrote:
> A bug reported by one of my customers that the order of TAS2781
> calibrated-data is incorrect, the correct way is to move R0_Low
> and insert it between R0 and InvR0.
>=20
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-=
data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>=20
> ---
> v4:
>  - Add missing base into cali_cnv().
> v3:
>  - Take Tiwai's advice on cali_cnv() to make it more simpler.
> v2:
>  - Submit to the sound branch maintained by Tiwai instead of linux-next
>    branch
>  - Drop other fix
> ---
>  sound/hda/codecs/side-codecs/tas2781_hda.c | 25 +++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda.c b/sound/hda/codec=
s/side-codecs/tas2781_hda.c
> index f46d2e06c64f..536940c78f00 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda.c
> @@ -33,6 +33,23 @@ const efi_guid_t tasdev_fct_efi_guid[] =3D {
>  };
>  EXPORT_SYMBOL_NS_GPL(tasdev_fct_efi_guid, "SND_HDA_SCODEC_TAS2781");
> =20
> +/*
> + * The order of calibrated-data writing function is a bit different from=
 the
> + * order in UEFI. Here is the conversion to match the order of calibrate=
d-data
> + * writing function.
> + */
> +static void cali_cnv(unsigned char *data, unsigned int base, int offset)
> +{
> +	struct cali_reg reg_data;
> +
> +	memcpy(&reg_data, &data[base], sizeof(reg_data));
> +	/* the data order has to be swapped between r0_low_reg and inv0_reg */
> +	swap(reg_data.r0_low_reg, reg_data.invr0_reg);
> +
> +	cpu_to_be32_array((__force __be32 *)(data + offset + 1),
> +		(u32 *)&reg_data, TASDEV_CALIB_N);
> +}
> +
>  static void tas2781_apply_calib(struct tasdevice_priv *p)
>  {
>  	struct calidata *cali_data =3D &p->cali_data;
> @@ -103,8 +120,7 @@ static void tas2781_apply_calib(struct tasdevice_priv=
 *p)
> =20
>  				data[l] =3D k;
>  				oft++;
> -				for (i =3D 0; i < TASDEV_CALIB_N * 4; i++)
> -					data[l + i + 1] =3D data[4 * oft + i];
> +				cali_cnv(data, 4 * oft, l);
>  				k++;
>  			}
>  		}
> @@ -130,9 +146,8 @@ static void tas2781_apply_calib(struct tasdevice_priv=
 *p)
> =20
>  		for (j =3D p->ndev - 1; j >=3D 0; j--) {
>  			l =3D j * (cali_data->cali_dat_sz_per_dev + 1);
> -			for (i =3D TASDEV_CALIB_N * 4; i > 0 ; i--)
> -				data[l + i] =3D data[p->index * 5 + i];
> -			data[l+i] =3D j;
> +			cali_cnv(data, cali_data->cali_dat_sz_per_dev * j, l);
> +			data[l] =3D j;
>  		}
>  	}
> =20

