Return-Path: <stable+bounces-179134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7A8B507F5
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 23:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED09A1C63C4D
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 21:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8D2571DD;
	Tue,  9 Sep 2025 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXU+R5JK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A67247281
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452656; cv=none; b=GAAx+zEBQnm5gH96igp0MbKi55jgqvOPW5ByTjTzdSOQX31wUSEYjuqqvX/srzmy9zCr5x+l0MqK8XqOIjTz3X93srinTs9bfeW2uX6UEtW7XJoKVbvYJWJPfynpK0WfJOKuEX3utC+7XNEnBAQkXFy/z9lqH4zKF3vu5T7vwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452656; c=relaxed/simple;
	bh=HqYbrFUFeibsZnZKsMf9FgZ9s/maKdF08mAaV92ILmY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=NAtB/L0pqUHc3QSv8cBE/fCMzjDajkZ9hcKdNx/9Hjq2y6Ov5+tEPkhFUA+sUx+dn6Y/X3U9D5AqONPoFKhFEQbPHi5cmzyyqti8W5Hs5OnHaydIWWEOg5UzKuZjTQDXkFFmWsCt+lu7rjkek98ZPEOBz7lwLAPLOqeFh0B57vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXU+R5JK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so56484495e9.1
        for <stable@vger.kernel.org>; Tue, 09 Sep 2025 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757452652; x=1758057452; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N1NCIdRK4PVMotSCtjNyyl/LP3BVDUFyoGUcQcV1nU=;
        b=OXU+R5JKJCIPIgq3vU6oaf28l+4Q8BrC2mqKiprF2BIPhsStdF+nyMi/OstgDrjrhJ
         Mn27jczsEfdUqpTtXRlljAE4ShnSfETnFiXjAGGeUt0Z27ts5QrzeVbFkHt2IcVna14b
         fcmtV6alWLAGsQnYZSHVud5IYmU8Ul0G2ED91VNmjXZB1YcNHQRPaQ9JSLa8rF5uZ7Jv
         Dmc3abjLtBNnbFSIgxTSJT+bXcykoIfJ29Qu8DmSmEl1nqXuIfRtpatFN9hTiAeVOj5+
         6o7fb24yJHTZh51UYPPTiriW7PrkAUnHOolFIQPUDMryp7zrIQoVFUWjxXjdYUV5Zjc0
         l/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452652; x=1758057452;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0N1NCIdRK4PVMotSCtjNyyl/LP3BVDUFyoGUcQcV1nU=;
        b=pD08mzggPocxexY097BVOQis/t/fDa3Dfr6BOdMiJ1jknqKyXVmEjKPyXsrOvS49kt
         0Qp9u2FVhw3kYwVsidcfBOEJBGDNAGIHYCQr6yoF43tQQBFmxMruTC5Bjer8mt5QFSeM
         8wGTuFafttzP0BN4MHmtgVR9+ebibXnXBhhCtMBtNbZtDjuqNArfpyR3uO375/LoUc02
         xA1enzRdedD7+vVE2MlYb/0QsHQJgecaWFF7GIcNN09G09UTTCT8KE3CqI/5X/QryvUp
         1PkLWgsPYa7nWlhe4YHtgEdHI3aDUEpKs5wGetnF60l5N5F0KP0X6qaIC8tSRBzYNpUH
         ahkA==
X-Gm-Message-State: AOJu0Yzxk26eUrDI6WcSvxCNqiPB+58UT5HrTyalBfBXgHWAzkLn4LSJ
	g8lCYF4oAov/Z3D8bfwn6TnFN352NUrGlmUAUSgYo7yROwY4+6Dq5mFvDPXQrry/L5D5o9H6Yz0
	iJ3jb
X-Gm-Gg: ASbGncuP3ro30padUkTMYTEix68lp1/Z9JiltOubSEMr+R8giN69IhsOIrwq5GFUzVZ
	/VgDw6mKNk4z4ammEgL3vzdIisb0mG5eYFIegcBdCMSz5U3KlgS2Uh0Y09bc+T8SK1CBLGSy3RD
	qD90CvqnKHsnkRohvtzjtdCOjBvWAQJp93VhTFv8/qb2zWII4USVLuIciYV05nZpmzKJMd9Oj/T
	mbPWq/hm0vKKfjO2VVEft8npSWOd7HJ67OZ9iJFsnFtxJQ0aD7UPhAqVXBAYxOwtUtIxypzcrK4
	1i1ohMiesmDPTvfMl7G9g8kG6CKCwjhtxUQmXeqaEeeIo4ZMOTmMB4p6RLCNdlcElnqx3v0qt4A
	ZBXiaBwSr4/xI1r61qpjioHtLPmg=
X-Google-Smtp-Source: AGHT+IFfPqt52sJ2bwTn8g9bFD7BIz/dicnzT8ODVk1qTowYr0C9FHz83+RjHbYNDSjICY3IUGu4cA==
X-Received: by 2002:a05:600c:8010:b0:45b:9912:9f1e with SMTP id 5b1f17b1804b1-45df0e619afmr31135875e9.3.1757452652352;
        Tue, 09 Sep 2025 14:17:32 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:c21d:84a2:1410:7b31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81cbd13sm1712005e9.4.2025.09.09.14.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 22:17:31 +0100
Message-Id: <DCOKYY8GG7IP.1ABNFNTEIME4F@linaro.org>
Subject: Re: [PATCH ath-current v2] wifi: ath10k: Fix connection after GTK
 rekeying
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>, <jjohnson@kernel.org>
Cc: <stable@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath10k@lists.infradead.org>, <johannes@sipsolutions.net>
X-Mailer: aerc 0.20.0
References: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>
In-Reply-To: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>

(add stable into c/c)


On Tue Sep 2, 2025 at 3:32 PM BST, Loic Poulain wrote:
> It appears that not all hardware/firmware implementations support
> group key deletion correctly, which can lead to connection hangs
> and deauthentication following GTK rekeying (delete and install).
>
> To avoid this issue, instead of attempting to delete the key using
> the special WMI_CIPHER_NONE value, we now replace the key with an
> invalid (random) value.
>
> This behavior has been observed with WCN39xx chipsets.
>
> Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1
> Reported-by: "Alexey Klimov" <alexey.klimov@linaro.org>
> Closes: https://lore.kernel.org/all/DAWJQ2NIKY28.1XOG35E4A682G@linaro.org
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

The fix works great on RB1 board. Thank you.

Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # QRB2210 RB1

Difficult to say when this issue appeared initially. I'd say that around 6.=
6
it worked fine probably.
But latest few kernel releases like 6.16, 6.15, 6.14 definetely had this is=
sue.
Maybe makes sense to add something like that:

Cc: stable@vger.kernel.org # v6.14

> ---
>  v2: use random value instead of predictable zero value for key
>      Add Tested-on tag
>
>  drivers/net/wireless/ath/ath10k/mac.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless=
/ath/ath10k/mac.c
> index 24dd794e31ea..154ac7a70982 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -16,6 +16,7 @@
>  #include <linux/acpi.h>
>  #include <linux/of.h>
>  #include <linux/bitfield.h>
> +#include <linux/random.h>
> =20
>  #include "hif.h"
>  #include "core.h"
> @@ -290,8 +291,15 @@ static int ath10k_send_key(struct ath10k_vif *arvif,
>  		key->flags |=3D IEEE80211_KEY_FLAG_GENERATE_IV;
> =20
>  	if (cmd =3D=3D DISABLE_KEY) {
> -		arg.key_cipher =3D ar->wmi_key_cipher[WMI_CIPHER_NONE];
> -		arg.key_data =3D NULL;
> +		if (flags & WMI_KEY_GROUP) {
> +			/* Not all hardware handles group-key deletion operation
> +			 * correctly. Replace the key with a junk value to invalidate it.
> +			 */
> +			get_random_bytes(key->key, key->keylen);
> +		} else {
> +			arg.key_cipher =3D ar->wmi_key_cipher[WMI_CIPHER_NONE];
> +			arg.key_data =3D NULL;
> +		}
>  	}
> =20
>  	return ath10k_wmi_vdev_install_key(arvif->ar, &arg);


Best regards,
Alexey

