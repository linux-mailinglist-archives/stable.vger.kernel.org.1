Return-Path: <stable+bounces-256645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AUfBNGrGWpEyQgAu9opvQ
	(envelope-from <stable+bounces-256645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:08:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE562604477
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 461FC316807A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B2D425CF7;
	Fri, 29 May 2026 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETInR+js";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Roln56fH"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560E423A85
	for <stable@vger.kernel.org>; Fri, 29 May 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065933; cv=pass; b=FkRDwb2gjRumYYhB4AyYwQPansG89alon7QWlzwOUO3CwENtBq8DdqzFdgRA0geNfwFxBVfUcZtEYDZLUkObkVmz3Drq2SGJrMnIOrv/c3BP8sAjHmfwGAR+ByMPnUceKCHG35JBRZAUQGHWMUd9TPc99hCiN+sEJhbLiyhpavw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065933; c=relaxed/simple;
	bh=ltU+8vGr8m265DEoH8729VMIv167yBwTAnhDKfwO+Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVPH5gGhZ2QtiTsbtum+fE4Vp2f8dGj+ABvDwlhz3XdaZAy8ID/aeVHIbbMm2yLUl1ZegtWlPoouWcd817HWIhaT/TMWye+MeCcOwu7TJ/PP0FHsGneCFirCTQBTfTHt8Xuqb8kJKgyDOB8/Diz3zsbYKV1QABNKpwRribytorc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETInR+js; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Roln56fH; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDLBLc3656456
	for <stable@vger.kernel.org>; Fri, 29 May 2026 14:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NYoES5F2iAtnc/X2JHN78tmhMrFrXoTmv9nva7e1GQM=; b=ETInR+jsW4mxSZOc
	cTLJc4HTePfLyn0T2m/zeUvv3kgJXfgO33VB6b452LqaI8l3WG9fwq2jJ7gPuJfh
	LRPDKA1aoY+2Lnt6Da2J2BuFGGRZOJq7OTc0EGYp1khz1rGupEUlOHviqSv7P21G
	Ise8yTH+tNQPvBXhBUP8jcZjBE7vhV9ICETPWDNJnhBiEYzTAm/vuTuf8yblFmuk
	/nIwgwK0ldoQMPk71ymLD81rjMvAANVRAXLbaobVBfgJq+6Vto8yCLVjOkQ9uCEg
	vBkIFcM+bdON5ue3KcSOZ+f17j261yfHKtrmeKaKWbUFmPAAyCCm/50EJ3UyfA3g
	MzHv1A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety5vqne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 29 May 2026 14:45:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ca1e4eeadaso54759986d6.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 07:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065930; cv=none;
        d=google.com; s=arc-20240605;
        b=cjpMLl9Rh7A8RxF/FKKlZwYhjwGIGO65Mh0LKGnMiwy0PvEZQUS6GI7dz2f4IXSMPC
         zrlZQV+fXL+84MoWxvmRsP2FwF1JIskrj+DFWN5itixT3lSjNTSqPp+ghUuBX6nXc1nZ
         SxUw/Yf0GkHTpXyTz16QiwNoID9KaSU92/eM/WrXwVecpdrhoUELcIx/RgOr3x0l/4+5
         6d3p1acrUGKEnpOd8aQsq0UfFTnshtdAF88cmQco5xBRQ1F4dYCIiFxUFIYN3lYEZKdT
         CFsf5u5vcrdBsbAtKQ7ugeJSkMn3sHhiJhmOeucfbsZFkWoBBCDegpy8sK8y9p/9mnW+
         iMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NYoES5F2iAtnc/X2JHN78tmhMrFrXoTmv9nva7e1GQM=;
        fh=dTduI0wzRb8bgN39reGlHAy5kElPOCJG5N5vUehpT6A=;
        b=OL8bkwIpSJTTbRnOnEHBf5n2YBB7PHWl0cIhu0/QS201CqdBBpT8UVGOfAk4Ska0CU
         inhNXaEW3MXC0T5FTnJcE66wDk7eqtZdam/9LNgBxQ/fOC/JQk1wdo0rVnv9wo3JRbwl
         rbXcebGOqWowRShnV0RXLlVf8niBSDRLfsHnYR+pFBbyDy2Ug2+6HfvPzY1O+awT66P6
         JBxKBxbcfN7ufE4rKOn51rBoistNG/kq+ii3zdjGzvRVICAQrITmlvb+hQYR+gV77jya
         J1yl2ry3uiB1BwtK9aa/u1dy0BEM5vw6Qt8YwTEtp02jjThdweUnZfca64vtgA0zZLWU
         6h+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065930; x=1780670730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYoES5F2iAtnc/X2JHN78tmhMrFrXoTmv9nva7e1GQM=;
        b=Roln56fHSnDHWHaaqY+LDf7Q0nO4XYHQJumIYEMy091JLOftak0FTOTSdJrS03INfb
         GhDMqqE79RvnSyIde4L+TvkGgwOafEDS7tfKE7gPcHNzo7gztB4U3O8mJo4/ybeVqRq3
         qFweTmaLNU80nOy7fAIjL3RRPG8rWM+lVRrBbUliO4DSCVtjZ3BZog7gwEfxXlVOCEty
         VJx22QC8pdNC1Ln4KxcFEGj6EsO+qjQl5fCn3WNJOvygcECjXwsNLoCT4nh3NRp+Uetr
         0M1WRUONVtvig5/afQvjY2xBZG+K9aMyobEN4jzXN8qXg1WxT8IvZVRVa30pgu8dG/2j
         qbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065930; x=1780670730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYoES5F2iAtnc/X2JHN78tmhMrFrXoTmv9nva7e1GQM=;
        b=USsJiCcZteYfmk5O6+yMdXC+kdy/xUuRI1tYHwhds4tQrlZc+BIWUFB5tFIs2cvyWG
         9oFBBSJ/lzAqn1/VIdGLru1Yd/XzES4IKUzwRoYH0xsv0UeG/NnmDGna+XMHqU2qLumS
         LjMPzHjdvvhDpG6UepZBu9sZ1TRrO3+brT7WokwvZo7HJd+M8F9kxOCy03ozvx+RIggk
         gZYj6tpNL7FHEFb4jG0HdamDPFrEpDn+wuRiCTCec5bWtRR+Ny9xvJNgau3+o5NGGoC0
         iX7MX34MXzInOdx0oushyhjOMjQUXvuRF3j/BEEVi2cL0zHF2FYeWqTswEtaarREUuSz
         G6MA==
X-Forwarded-Encrypted: i=1; AFNElJ/r/DM+77EV5bbn03yi2zSpezevuDzk8p5zp3HsU+IPRmhLu8SjOiC8O+rRJhq2bDDEBlPZ9Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcxk+28DOnRgS8KSPpt86rJNxQAK/TxilBtl0zyXh78yMXZ9sY
	YKi5DL7zJyDd9MGHqsj2bBq+o7CcOjLQpfgNgaqna4DBBswiNja2Z8mwpCABlG2VD2FnzPsr5wq
	hApFtVggyaQmyijGzkGIN4pHNbL/60SyB4ciC+elmIgCqONMA8EZapc8BivAbUpGPYwfZhVfn1B
	cr9ExjdDUgoP+kl7y3Ycc9KF2rON9prRC4dQ==
X-Gm-Gg: Acq92OGGsfGi1WHF1GzJs5K8U7ZEI19oMj9jNfCy6oMiYPt42K+ytYQGX9O+OyO2nAu
	Fxx72fQZA7KAc6ivHmGqerCDcwBz7jP4xUDLMYmAmZUbr7eTELImzqBTCOzd7ChAtFBYqVB50TX
	YKuL5ECfBIftwbkVK0mbUAvdMqZHSIZBpN7pQwHz07v0zAaOuIpfMbxutp4cguCqVLEzY53F+Y4
	gmisL3uxHjMV2yCCA==
X-Received: by 2002:a05:6214:2f0f:b0:8cc:ee2e:8d99 with SMTP id 6a1803df08f44-8ccee2e8e51mr16255156d6.21.1780065930190;
        Fri, 29 May 2026 07:45:30 -0700 (PDT)
X-Received: by 2002:a05:6214:2f0f:b0:8cc:ee2e:8d99 with SMTP id
 6a1803df08f44-8ccee2e8e51mr16254266d6.21.1780065929588; Fri, 29 May 2026
 07:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:18 +0200
X-Gm-Features: AVHnY4IKn338BxMmC7x2RiD8DMfbYOWOavzi_H6yjKizETojXOwI9mPNIlQESac
Message-ID: <CAPx+jO9etdG+BOs5DwJh=EucPe_v=WLnsA4RO883+5NRNA0=QA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 05jxBq7Of6gwx_1YVYc08ioTLaxaAmMU
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a19a68b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=yC-0_ovQAAAA:8 a=VwQbUJbxAAAA:8
 a=U03jwDn8jV92IJQaczoA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 05jxBq7Of6gwx_1YVYc08ioTLaxaAmMU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX6J1/0+iCBUXL
 SKh3ZSA4n0DhAO608x402SQkJcsUkqH/XzFBsxON79eiov1b1kdNrahNVOfmTlFU3JD6/FYEMnl
 E+sPViqmLiEX0ukiNtCKhyx1GWhcVy8DVnLm+Y916bDD9bJzN1KLdeAsc6IWi+zvp9GHDn7jBwK
 TFbgo+7o8Gg5xw903RsH4HFjXElGleRbQfZr0Z6zH3KxnXga73ncouvlO06QZxz4ggVB9f61c2P
 mTVCUw3BrEfVEL+B78TxGgqCJax2JJUcLzFSNrkVgFPSyV7Hrb6OkZHmcNWDbUZHJ7ZZpIhoE+D
 5ys/R7xU+TTq0dNVLFStyOK8nmkGu1AnNG+I5IBKwtPe1PnP6cLnpZxfsFL29KSFrVilo05OlkH
 NbICEw0i0lJCeU/7JcqAsgsMQr7Crp9MW/6nM7h4n1CsaOIPbqjSV7qFojhCp2ioWjucFspp73v
 O3d01iN9uzqPUb+C8ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290147
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256645-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sang-engineering.com,kernel.org,glider.be,gmail.com,vger.kernel.org,bp.renesas.com,renesas.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,oss.qualcomm.com:dkim,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EE562604477
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 3:53=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2H (R8A774E1) SoC was previously handled via the generic
> "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> the SDHI IP on RZ/G2H is identical with the R-Car H3-N (R8A77951), it
> requires the specific quirks and configuration defined in
> `of_r8a7795_compatible` rather than the generic Gen3 data.
>
> Add the explicit "renesas,sdhi-r8a774e1" match entry to map it correctly.
> Note that the DT binding file renesas,sdhi.yaml does not need an update
> as the entry for this SoC is already present.
>
> Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v1->v2:
> - Dropped adding entry in the quirk list instead added entry
>   in the OF match table to map the SoCs to the existing quirks.
> - Updated commit messages to reflect the above change.
> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
> index b716a518f265..1d3cd4c3da1f 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -279,6 +279,7 @@ static const struct renesas_sdhi_of_data_with_quirks =
of_rza2_compatible =3D {
>  static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] =
=3D {
>         { .compatible =3D "renesas,sdhi-r7s9210", .data =3D &of_rza2_comp=
atible, },
>         { .compatible =3D "renesas,sdhi-mmc-r8a77470", .data =3D &of_rcar=
_gen3_compatible, },
> +       { .compatible =3D "renesas,sdhi-r8a774e1", .data =3D &of_r8a7795_=
compatible, },
>         { .compatible =3D "renesas,sdhi-r8a7795", .data =3D &of_r8a7795_c=
ompatible, },
>         { .compatible =3D "renesas,sdhi-r8a77961", .data =3D &of_r8a77961=
_compatible, },
>         { .compatible =3D "renesas,sdhi-r8a77965", .data =3D &of_r8a77965=
_compatible, },
> --
> 2.54.0

