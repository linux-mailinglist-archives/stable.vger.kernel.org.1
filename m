Return-Path: <stable+bounces-73825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C3F97022F
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 14:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A771C216ED
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D8158DCA;
	Sat,  7 Sep 2024 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PkdZ0cQo"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97A1B85F2;
	Sat,  7 Sep 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725712841; cv=none; b=Wq0Z5gOXFFjk318Vrtjw6JWgAGtdI01zQslXo417unXHolm6kGrti90kueIXNLO26VZYxOzJcClLc/xMG61MfksvzkQSqThj6trRUIo1jSp6nZQQlGmd1XS6DrrBF47gLHvKmcYFryEGQFy/NgmlYVuXBMsFT3mM5nXdYuqteJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725712841; c=relaxed/simple;
	bh=z/is63FAkV1Z6IJEGfbxHiE0+onrQGBt2frnaRyYRYM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WY4gTQe5K826u8CErExI8JZ7xyy/+vYx5iDHyO3zdqt+6BII9ePK8eNPkMgpI3xSQ6ErJ9wAhy3IHGj5kv7Wsboh68fzEar/wWzgs56Bp8TRFKOgpxQirnaiipJ3MV3vGmTlKPYN01o+kj5asoRfFsn20UjNjX3XO62vb0eQftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PkdZ0cQo; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725712812; x=1726317612; i=markus.elfring@web.de;
	bh=3mmhAlGB6MPd7mOF0eOntljHmXDlj+VRCWTezqQ+qHI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PkdZ0cQo9KKQMMR48et2oDjJFh5FL/FYqB/uMFbitc2iGCTwAaMgqdh9IfNlNvGR
	 2Sff+4ABVPyoErJSNE/enhuc63clVgl9PZ3vExuTJ6brKIpAfgeyY/TPZrpty1+5P
	 /fRG/X5YTlXwqA9rJnCMHy6cdCfZ714NVAa19WcJlGFFpdHZkcgzmFar5n/8pQAA7
	 X22to4iPtVD5Z8D9Ho0IJiPG8Tzprqb3Mkjcr/uWYomAOO2pI5tgJT+kL5dEVPUCr
	 ccA3cirwTE70q//afFoMV9WDMzufVaZs6ORrHVELD4nVIM7l1YtD3ZGrTtCoNAlm4
	 sGYOUSSeQ06HsciKsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl4x-1sFH4D05i1-00pS5P; Sat, 07
 Sep 2024 14:40:12 +0200
Message-ID: <99a2d643-9004-41c8-8585-6c5c86fab599@web.de>
Date: Sat, 7 Sep 2024 14:40:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gui-Dong Han <hanguidong02@outlook.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jia-Ju Bai <baijiaju1990@gmail.com>
References: <SY8P300MB0460D0263B2105307C444520C0932@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v2] ice: Fix improper handling of refcount in
 ice_sriov_set_msix_vec_count()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <SY8P300MB0460D0263B2105307C444520C0932@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:InRZd7kFbSfK1e5eW5UUNybW5MJ0wGpHgP81H85hO47pdeGPzIF
 z1G7dIySGs8UknFg7da4mEiFyYD4Nt0GsevsLK+Yr7EeONNjivfdBcLthpCw1LQxotnA7AT
 1Grr3PCRBT8fESdSxUFoBFP0GDz2j9ZAZiLPGuoNGJ6uv9Q/zISR4qHIannHJwq/d0Yi31N
 Jq3mXQ7mp4b/8D7GyvyPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:obGP9V6cqNo=;uWs9GvcuVmU5ECvWaepANbII+up
 VZJIgc8lW0AOCH+QxaYAPX7NoKxkAVJ23NSc7RE/dphrDg4lZJf/KlEeJSrRtfuo4rVa7UrfM
 hwrkD7+EFqKWcF6FyT/Dn449c3XL61OV4h7tifAB5lBzzOv2ABPPJdMt9EbYWULc6lHmp2X/I
 PM5LJtITDX6aBOoTeaw4BjtYM6fhImuyPBRaqZx1CnABTxXpw9NLlj3677j9sBv9rjFB9Ff8E
 erB1pYg+TA0p1e3DGM1jy+Fv/79+YqV2VZHCQI0WzuYnniJYwzpnB+kdw/RW6c7nxEM4/h928
 zyUpYCVNbkaE2r/z/YLmLNg/9jH3xu4+BuN2SNBhzmaRyCwaf6gnfNLXPLoq5z2cUusmTDqD3
 bQV9RMs/qHsMIyCuFnRlcdtNyMIEpjfzchmXoEkLL1uRsftui1/Lj/amdhhoGUmv727r1qLxP
 4qGE6cpzmpXyrZ9WdjLsTYe6iwke5cMGjeCeI7UTsI5sjIksioN6yqXueQ/xq6cLdPIBcdYEr
 jAoRqRNts7102ACfxRGmaynjZMBDJdXqdYTlNifjI6m/HZab/N7nnbmmJ7Dq/LvW76wS6iBkT
 YXw/mYDEzyJJqvNW5TOgVJDauh/rSafyHKMGZZB4Fo/ryoKVoEv5jc+HHQ16S5HhBZlGMRgOW
 zhcqjB7dKqpBGBl6B5eF7Kd7pWaCOHWuyGXNTRZWOj6mCSgDFyqqVgCqfs9yHYPcwd+oPhY3r
 0MGZkxgUXEK8bcnfIAGNaWW3PpF/42LL6VxvRIEy4Wh1l9RIWF+MXifXkn++zOTR5pbFYQxDs
 kAkUPhmqveNLf/urrx0rcYkA==

=E2=80=A6
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1096,8 +1096,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *=
vf_dev, int msix_vec_count)
>  		return -ENOENT;
>
>  	vsi =3D ice_get_vf_vsi(vf);
> -	if (!vsi)
> +	if (!vsi) {
> +		ice_put_vf(vf);
>  		return -ENOENT;
> +	}
>
>  	prev_msix =3D vf->num_msix;
>  	prev_queues =3D vf->num_vf_qs;
> @@ -1142,8 +1144,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *=
vf_dev, int msix_vec_count)
>  	vf->num_msix =3D prev_msix;
>  	vf->num_vf_qs =3D prev_queues;
>  	vf->first_vector_idx =3D ice_sriov_get_irqs(pf, vf->num_msix);
> -	if (vf->first_vector_idx < 0)
> +	if (vf->first_vector_idx < 0) {
> +		ice_put_vf(vf);
>  		return -EINVAL;
> +	}
>
>  	if (needs_rebuild) {
>  		ice_vf_reconfig_vsi(vf);

Would you like to collaborate with any goto chains according to
the desired completion of exception handling?

Regards,
Markus

