Return-Path: <stable+bounces-256646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPTDKUSrGWodyQgAu9opvQ
	(envelope-from <stable+bounces-256646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:05:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E03604387
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1B8340632E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA03F3F39DD;
	Fri, 29 May 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bu3eS0Io";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bm0W6gOd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83747410D1B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065963; cv=pass; b=OeAlJlzOnfvz8bwErFG4exyjA4x+cRyvS/9FJ9h/UGJuEjpaf+LgS6XSzTsYNImC/oRHStwwb1el8VLvSESyayVh5UWomE1eUlaHnbs2Yxn2BL6DirSKkMyrrB924HPQnJjD8cMOI1gaGglKHXmMVN4D3Isz2qOuyYI0NHCdSzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065963; c=relaxed/simple;
	bh=ZCjavYg2eJB4OU4AVO3054kCUboFVAo39kPcNuUwmNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqPO7gENMHgAerU4LqhcM3pdu+XfMuQhUYwjlC3NrIEFmfIRilqlvsaJGrG56Jysj7C6mJQ03nZHniQ6K3GIvi/lbz4Nr02ULyfbVNNOSm07oMUBh9gxhEWeU8w3x7bzQ4WB7JBfMUC2Ws/OipkRWD003M+aQZ2Qc1JqkycctS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bu3eS0Io; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bm0W6gOd; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKn401202007
	for <stable@vger.kernel.org>; Fri, 29 May 2026 14:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y0uRdyGufttfYsaSEKi83F70fZI3azu4YBlntZSpPu4=; b=Bu3eS0IocdVwcgU3
	CGTFtvJsHhHnWhPRxdFyHJvNRpwXsNF23f6zIOH4cgaJR8KdAGRdP6uxlcvwADxj
	sdfmufVCxLd7S4lfAP8c/cW4sRRY/lpyXpZDEkiTEDqhadvk3J8s+KZEv5AZyR+s
	BLlH1NDNk2MGWYZT3ibgT6O4GUxvmCf0wOcKB+pp81pulce5ifgnR8A8j8q+N14n
	F1C6J6SSYrSHMySeK0wVDH6gHQ6tYPlqNGIMeZANuO5W6VP2b3D9cmsSeGaJwETy
	KiHxJjnm5MukNBqHY0ERqom4iOSWGsq+o0P/58FN7+fYFzqVW+9Nwps8SooyVzqZ
	b19KUA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef3te2ekj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 29 May 2026 14:46:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8b1f39c5827so287026086d6.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 07:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065960; cv=none;
        d=google.com; s=arc-20240605;
        b=Jk8SRzWYIOWnFP+Qko23BgKbPJk4EKrdCbJeaTgb9na+5A38mpHPuY5VL211ZxWBPk
         INv7/vsL5z51K2kSm9s3fksWxAIO078vf4gPjLz0guM19xPgcqNH8+GdKDkxUdPrZkGp
         cH0HY8P455qlGq7otx733DI8NGO/p5X3Nai14gK8my+nuY8fPOWH5VHXuqK8Gunu/QoH
         iNLtBHXCiwpue/kRwxK23pNkQogL/wvh9s+kvCy7XpXg/5iTCQHsoP5rZL2zab4xCeXq
         RFlxbAo3/xdVke8VHzJfBNT2efAd8nahtrrtTiX8A07sQI/MpJcyXD2tlRQAiWGdSFgl
         TqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y0uRdyGufttfYsaSEKi83F70fZI3azu4YBlntZSpPu4=;
        fh=25r9lzlv6LfvBY9pat8OVv6oOHCpdLDIpJuY29kepk8=;
        b=leXLF0NIdGJrRMNBQNf9HLv4WEVgYCa/fRm6evn9Cg7UH5mjeZYRQ65OzL11DSiRpk
         e8ZLaXWB6oyuCRgmQQjHp0ZpZJw+Zeyy8dTPNTpJvUMYLZk6786DYdYxiyWvIMd5yg+o
         o58Zn0KaryepQz7xMzhmmSKqb+TTX0GZA2CP1krMbWHR4hs+sPEza7841Y7yLeD32J1U
         GkL2mhzdvxFRTfOcx+2arzZYdQGkUhQtiVwmM97S/aP88y2imPc7l1/VS9IyzscZJuPw
         BZ0rUIxwezppGmzHUYECW6QXAADSrlU2bpRXnp4FmZn7rQfRJf6rGbI/9/zxWNpJFe9p
         AodA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065960; x=1780670760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0uRdyGufttfYsaSEKi83F70fZI3azu4YBlntZSpPu4=;
        b=bm0W6gOduX/QnYeb6SHM2hEJlXp/4/+ZFPMrxXKw0G0sptIoB58TuJGqbHuTq2R9r/
         riFQG5aELk4qWegevgvLBk60b2hsRlxhtfNFOyp8rbUx7FUUrRt3UJPB+EjFLOURxL+A
         lrFmtKcSS3FMsk84GIGQbDHiNNXbUWbesBdIHLRIv7bOEpGiHoUf2zPrZ/YoAoTq+KdL
         GKDOmyFwdDt6HaC98Gl9DDE8gP9sMcxbSD5aynsFqJoDcloTcJXiv12rH5toTmwvWoAU
         2HMibpfA6KdyvhDm8dmIaIUBpkwJzNcI1lQGuUXmRG2M4aAO+ZCIM0Tcjl3C/8v9tzmu
         O6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065960; x=1780670760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0uRdyGufttfYsaSEKi83F70fZI3azu4YBlntZSpPu4=;
        b=meoITzU+kShCib5skr1aB7GMK2NBhfplGdsY28Ye8GYtTE4sf8UrBkY5+OFsSBEfBG
         yMN1FXv81Dji17i24QYbI/Fg2G3f+WB1xXIEBEePHtT/+ce50fcGxYI2otgpP1NqpxKK
         3uw/q9GbCvDXpGF8Sy5KdxOBeEnO2J8Ug9qvgcV0lPwBvBPtWEB0KLqgKcFlDQ10f6QV
         pBJG5M6B+jFs50CgspmqIPnhttGTF5ckZ34BBWwE14v9KlA+hBGFAO5arF3/Ys3AS/Af
         aYg7MHw/QvTzwZh3sPZVODBOm4D2thOF1WUTw1ORtwP9+ixGfS4Sn7s01sqhJ1zH0dFV
         maMg==
X-Forwarded-Encrypted: i=1; AFNElJ/jLs/OarcuKkgmIojzwTPKXTfOmYzcstAaDlfYQ+6jDryT2nTBsFP0eUuW5wiNPXK5b5DR7qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv19DFgvySs6AIxNkuqom5lU0tcy+n233e5faXpbiw25w6QCds
	4mNbdyYle7dbIOGdo/RALpwU9yobGPNRQ3SLtuZIynUbZNb6UM+sNdFwTw5uB4adp3DwonO9dty
	CNmP9JAr+kZkuO155bVrdrtXKKrdgirQnvB+uUuAbK6DbSUtFRBSEna+XQut/QJKg2YiLCan7En
	PoKfSPl3lx1gV1i/LZEqFp1FHh7ub2LpKTug==
X-Gm-Gg: Acq92OHjO2CqENppJkqPhckgosu1nKZvM8SjHK/3krbxnz+OeUigRPuphhzmuqirYWF
	HnWU9CBman1O2B9Qs2LUmC3ZQm6i/u6KsW4HlJrKwD3msP0iPfHfeFO1OO0x0RKBZ1uD+QRUz/8
	v+E25aVsMaycHJerbOJutYRFH9x9TGQ5teGZyz6K6+z0ywnpjWU0WJiDM6IToaszvD+ihNvq2SB
	y0KBAmbwh7kYLU6RQ==
X-Received: by 2002:a05:6214:230b:b0:8ca:10c9:845d with SMTP id 6a1803df08f44-8cce801f126mr36091376d6.31.1780065960327;
        Fri, 29 May 2026 07:46:00 -0700 (PDT)
X-Received: by 2002:a05:6214:230b:b0:8ca:10c9:845d with SMTP id
 6a1803df08f44-8cce801f126mr36089856d6.31.1780065958269; Fri, 29 May 2026
 07:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522184307.2979579-1-heiko@sntech.de>
In-Reply-To: <20260522184307.2979579-1-heiko@sntech.de>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:47 +0200
X-Gm-Features: AVHnY4J_FLHe1mGcqIVr9GZCUybu2z_sAx_8iofpKeK_xPfv3mpX0W3pewKBvLE
Message-ID: <CAPx+jO9kKCQE+ZtKhJWX9mztEQ2m93irdqt6910wG=9M9zN4KA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Add missing private data for very
 old controllers
To: Heiko Stuebner <heiko@sntech.de>
Cc: ulfh@kernel.org, shawn.lin@rock-chips.com, jh80.chung@samsung.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: iacGZ-AIpdS21-3BKhgk6krlXl11ECEQ
X-Proofpoint-GUID: iacGZ-AIpdS21-3BKhgk6krlXl11ECEQ
X-Authority-Analysis: v=2.4 cv=daSwG3Xe c=1 sm=1 tr=0 ts=6a19a6a9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
 a=zCIS9O9Q-TFeY09dWLwA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX8nby1rQMmjmg
 JyGRHN359S6nB+XrMPMHdO2kcxOu5AT4QD/F2cHey3QGDS9bQs9wNbW2k5HTeuh/vNgnb9YvfFP
 3kILHfecUT+MzQNMYvq23TLhbwUNOX3MH+WFtGFyZPYfBSeNoLX1D3fsWfkTYwNPBlIo61CQUcO
 SeGOZGe/5MRDSF0CwxwxErC03gS5X5fV7STdx7cmEvqsCkSqF29in7r62mQz4Wb9wDlc9C1A4CX
 wt52x1roQKkhKssNT0cGq/EIl3JSrQ8MyAzqjLl68QywWqbYtclMbSeELrEtfbOp9hz0cAm706D
 nJjwgcyipRegDd2ahiP4xkYQhPLCPoXItZRf80tRjIINzk2zPNRh0YjyFTbp2Gk5gYcdGwI1GxD
 SwbUNw57k01Ng1GLWlQNM4yc7fl93dDAz1kM910Nsm0Nf/mqIZXsHQKVfel+OcZDD3loLrSKIqX
 tpLgmUJe7B2Pkb1a7cQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256646-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@oss.qualcomm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:dkim,infradead.org:url,infradead.org:email,sntech.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 02E03604387
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 8:43=E2=80=AFPM Heiko Stuebner <heiko@sntech.de> wr=
ote:
>
> The really old controllers (rk2928, rk3066, rk3188) do not support UHS
> speeds at all, and thus never handled phase data.
>
> For that reason it never had a parse_dt callback and no driver private
> data at all.
>
> Commit ff6f0286c896 ("mmc: dw_mmc-rockchip: Add memory clock auto-gating
> support") makes the private data sort of mandatory, because the init
> function checks whether phases are configured internally or through the
> clock controller.
>
> This results in the old SoCs then experiencing NULL-pointer dereferences
> when they try to access that private-data struct.
>
> While we could have if (priv) conditionals in all places, it's way less
> cluttery to just give the old types their private-data struct.
>
> Fixes: ff6f0286c896 ("mmc: dw_mmc-rockchip: Add memory clock auto-gating =
support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc=
-rockchip.c
> index c6eece4ec3fd..75c82ff20f17 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -441,6 +441,22 @@ static int dw_mci_common_parse_dt(struct dw_mci *hos=
t)
>         return 0;
>  }
>
> +static int dw_mci_rk2928_parse_dt(struct dw_mci *host)
> +{
> +       struct dw_mci_rockchip_priv_data *priv;
> +       int err;
> +
> +       err =3D dw_mci_common_parse_dt(host);
> +       if (err)
> +               return err;
> +
> +       priv =3D host->priv;
> +
> +       priv->internal_phase =3D false;
> +
> +       return 0;
> +}
> +
>  static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>  {
>         struct dw_mci_rockchip_priv_data *priv;
> @@ -514,6 +530,7 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>
>  static const struct dw_mci_drv_data rk2928_drv_data =3D {
>         .init                   =3D dw_mci_rockchip_init,
> +       .parse_dt               =3D dw_mci_rk2928_parse_dt,
>  };
>
>  static const struct dw_mci_drv_data rk3288_drv_data =3D {
> --
> 2.47.3
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

