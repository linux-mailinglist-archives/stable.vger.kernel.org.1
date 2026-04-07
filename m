Return-Path: <stable+bounces-233600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG+XB4cH1WnMzgcAu9opvQ
	(envelope-from <stable+bounces-233600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:32:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE883AF32D
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A7C5305ADC4
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B03B6C1E;
	Tue,  7 Apr 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OIRaG6Ca";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jLqlhxwc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064F3859EC
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568610; cv=pass; b=MEMTOXCBCmE0pPLYpfgP6oW8dU/dgloeXeKtdXCzc1MridH3TTfzPTSu2+axrVLfo3y55diBmxCFuqUbMCLDKl2ECX3CDkb0Wpkt7N0Ahxru2xy/NjThVTvu/dNX1FeC+Ia+jYNkbpGL2sf1EG3jD4Xa6hN3OAkO9d9l0BwiuMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568610; c=relaxed/simple;
	bh=cVBfaWm38Zt4dvT+MEWmCTUPH7hD3s6kknmIa3u2TeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/brqmSSIpYmFv2Yafc4P9wGL7wLzrmXv0bS+Uqef2dZVUfkjDAlEhPGMLK8ahPItqhFWem4WPUjhTKtVHPbOZ2HxhHuXs6T8rT1AavC7uE9iIB/TGDLGiMLpJ3mnKfXPw2evcZ40sUg6S3kInWnxKgzHvT2X3rkHLc30+9VbZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OIRaG6Ca; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jLqlhxwc; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637D3sXG4009056
	for <stable@vger.kernel.org>; Tue, 7 Apr 2026 13:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cXHI+HoMT5nQb1dnewTDRapny/uuf10+QCLdHGxs6MU=; b=OIRaG6CaVv7oidXY
	C71YMfCAvM2n6K5q5kJJkwjL12ryNMuuvAguF3DQQ3Ea80hE9aTnE3XcMdfvUzaQ
	wu4UklE/oE+YXi1QUvYNLUvYnPbEbovwiyxlakGnf8Tc9n+MQAKj18n3TLwjdsJW
	anx4ZDub+aoUf7CaeRGlEzrnLSjMDu+uOmlT4q2g2C7EFTTycsYrSUHMGJP0IuK2
	ZzqV7mUd/19c/NiV8HurNlMIrrIKOl1h8G9AnRi88DGzvox9sw0UklnNddLlSGnC
	H7hLcrBljJAm0eUxmuWyz69McWrbw3MaHpnAq2LWekODiUMAs0h++vFCh1L04gIM
	7TTurw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrktup4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Apr 2026 13:30:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8a5f6110c1cso146087416d6.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 06:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775568607; cv=none;
        d=google.com; s=arc-20240605;
        b=hai4ck9lAS6VqPgLZTYeqSpSbOW1+3RriMff4F2N75k58q1gTihaLVbJv1emgr0eGM
         yD1IOG2QtL3lNCj1zX9Aqn1Lwo3s6WgtX0jeDRryCQ19SNFllvyrvN6tRZmJbkiKjCEZ
         qneagntMYsAj4rQu2r9AYN9VqPx2PKtz981e6rrhnwN5N0e9Qm6d3CfBFhsBzS1zXTmf
         ifQ8D+oiaAE0dGU30DcMYtFVpiO1s9T0zV2CM3Gsdx1TDzLV8Ycu9flcGq7z81lXR6/K
         kTlhDKeBUwj3d+jcYjlI8eb3+4IbyCQVpqzvjBn6ry/jjXHd9VzJPvxhFA954kdfM9zv
         M3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cXHI+HoMT5nQb1dnewTDRapny/uuf10+QCLdHGxs6MU=;
        fh=vzlnfNAXqM3XNvO8mD8IM7FTidc8D2FJIIimWXvNMJk=;
        b=W3MZFgeU5zN35cJoBg2fe9f4M/3ac50xZvAsMy/s9Pls3Go9uFHoA2mu7fQO+Vxfi2
         ibtBYoHM0A450h4yTRHigkd7kJDdw6J5XDClKiIo56RwpOzra0bsfsCAy1ENxybinz+T
         uIWlpAmKXoWeh8BAj/1OM+kk7yrBKVuHh1vm7llUf2Qr0lUeSTOlapmO0+3AmvRbBsWk
         yRSOj/X6ZauK/8cSNf4bouxIwqGn4gBlqr2ydnnKsMS77S3ztwMdtDJ5Aquml4JXRsz0
         QlK3EtfE37sOLhmZHtp580s8030HOhvx/MafcMOTFY+m0o1H8nhg2nmneVZFbyEQDJHa
         r3fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775568607; x=1776173407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXHI+HoMT5nQb1dnewTDRapny/uuf10+QCLdHGxs6MU=;
        b=jLqlhxwc11DcY7cqPl65wEpOwo+1a9mxea7rXEfIMpVRB77S6VwG8l1HY/8saXbmHN
         jJcHwSyfLFI/3iv6OK02yl+Jqm4Ox57LGGMiS0JlCFLeBc600GapWlSwnKMZEaT+Z/Wl
         ZYp2sjXrEr8ZBriaGnnBMJCtzgb3KR6clXueU1OnMaF5EVQEwBl+ugruG7gTzVq1if8x
         +z+awcbt9mTT0LIRTk14PGLsUMXw+KzIRKpeIyprNbrnoy2/J2QpUEo5aHnh5Aa9ohje
         6XNxChgYtEp6KQxhgJJOgW1OI7uj5yAKY5cOqKj4z0IfAAnQfPIuXzG9zZGTVOD0oTi9
         ajvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568607; x=1776173407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXHI+HoMT5nQb1dnewTDRapny/uuf10+QCLdHGxs6MU=;
        b=pJW3UIyZoQuYBGfj8ZV4+KK/rV8oYn+LU5S30aaVqgMR/Gx8IhPMYvDFUSIONWIxX7
         eNXMD1wQa/KOZsMDgwBePo8Rb54+1rEN470y59HOaXqyG32O5sGaTcbUd4R7JrmANmjy
         3GFYBRGTKCKd4Bd96n/uWLZw6gjgt63LJwaBz3GrKjifkwvjj8EOkZg9btKNnqAke5SW
         R1kpYNP8LFmQDQtAU/PjgZKeJTud5iyEywMuRkiQP6nX5IQGDaQNj5TwayGdx0dgrRE6
         unGukJWgg1A6WRF6cSMR/azvKjMpj2erSd87CkohtvKh+qjDHrCtZA0dyQYHbZScFonp
         O+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnnocMlC/UEKryMaDx9AGqa8bu6/hBFaeIu1TXxUnVeP3eeWggForKZTd5sKsaL0GKBOTKAs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Kgoxeewuv6+W3QewhgoS7ZaTabxJXZ1mCslpgrR4ztHhCmzo
	uCrOJiDhIAgZ6qJCQsiOstumsFkRJNzhPREmi6/PyF4ONUf71nXvN1RWgpJJqbo3BisHEJMDmGX
	QwEAE9pieAoheX9hsmH2DMfXzPA4CHwjl8AsYO3tded/szsdyoVPmN4cpIF3szLXUSEBhlrMZRo
	O8dpL7Frncc4FO84TiC2iTigzW2Ca0/e0QQA==
X-Gm-Gg: AeBDievZ40Xh026kIn4/iaq4e04NlI5SLyOMUMLtdVaK4O+iGuYMVv9wCMInUOETU43
	OBRsNCE94RZfOL0b/T+g8peypHS6axNc5PxozyVaVWgvijTw7m5uHXmiZ7m/TrQpqcOGasbWwWA
	Ne262/KXXNDZJMN4cYikm/sYx+79iWc5JUmCyg05Q8d191oJyhrx0MznjfKPvzHAzZGvimBUZfw
	lY+btu4J2gN3VJTVg3VbL7QZkHQu4kIWFL+fao=
X-Received: by 2002:a05:6214:2aa8:b0:89a:9ef:1922 with SMTP id 6a1803df08f44-8a7046deaa4mr266841306d6.40.1775568607160;
        Tue, 07 Apr 2026 06:30:07 -0700 (PDT)
X-Received: by 2002:a05:6214:2aa8:b0:89a:9ef:1922 with SMTP id
 6a1803df08f44-8a7046deaa4mr266840426d6.40.1775568606628; Tue, 07 Apr 2026
 06:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-camss-rdi-fix-v3-0-08f72d1f3442@kernel.org> <20260407-camss-rdi-fix-v3-4-08f72d1f3442@kernel.org>
In-Reply-To: <20260407-camss-rdi-fix-v3-4-08f72d1f3442@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:29:54 +0200
X-Gm-Features: AQROBzACMKUNv5MZOhI59pKgDvTug_LEOvy8laj8LYSN5opN13Mvl97amo_eGE8
Message-ID: <CAFEp6-3VdFVmY8yj4LqVq1wFZ+D07WEfNJA2RhmpTeW2OtAbAw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] media: qcom: camss: Fix RDI streaming for CSID GEN3
To: bod@kernel.org
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Gjorgji Rosikopulos <quic_grosikop@quicinc.com>,
        Milen Mitkov <quic_mmitkov@quicinc.com>,
        Depeng Shao <quic_depengs@quicinc.com>,
        Yongsheng Li <quic_yon@quicinc.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Rrz16imK c=1 sm=1 tr=0 ts=69d506df cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=q9jW2Z7JBf9VXYl_VOsA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NuO-QAUqOxPhOFFp-9wcKOEK0022jePe
X-Proofpoint-GUID: NuO-QAUqOxPhOFFp-9wcKOEK0022jePe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyNiBTYWx0ZWRfX5gUaY7nLfIOF
 yVrJjQnFMwgGbXWMz+Nhi2M4sZxT7SNZ35dfITsNLci+CQDSnE54UP+FsBqtYYmEiT3mC/cfHl4
 jqocFhN0dIfiAq238HG17BydV7WkIl6mIeRXcJK5ENZCY/IjJRjZmtELqsBYpYFzx/DA+G5eM5Y
 jkP/U+Ugx1eEr237TmabJiqiaOo+y5wLayXJYCltfQ3QMdF0Vf0PhIvhnxvMxdsSP2FnurQK7eI
 XcIICX1wRGzhchDKYPkL1Hz4t7PDOvYrIixYV4RaBBjJklTZNH4yG4YtKLgeTAMpstZFJqWH17X
 iFIoDdqACDQ/O3UM5KG3RnFWMLKInR7wTEliyrlgLom4e+zqVGP2S54JFkYF84QMb9ny3hqoXxn
 t35KVEjrCs3ij02cKzqtb6CI1ODMv8ZLZ/9w8+sotjzPxt1gVq5DirPhmxRY0d64nbhWTOaZvns
 wFgIKhMxWVR/1qYj+1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070126
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233600-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,quicinc.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,mail.gmail.com:mid,linaro.org:email,oss.qualcomm.com:dkim]
X-Rspamd-Queue-Id: DFE883AF32D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 12:35=E2=80=AFPM <bod@kernel.org> wrote:
>
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>
> Fix streaming from CSIDn RDI1 and RDI2 to VFEn RDI1 and RDI2. A pattern w=
e
> have replicated throughout CAMSS where we use the VC number to populate
> both the VC fields and port fields of the CSID means that in practice onl=
y
> VC =3D 0 on CSIDn:RDI0 to VFEn:RDI0 works.
>
> Fix that for CSID gen3 by separating VC and port. Fix to VC zero as a
> bugfix we will look to properly populate the VC field with follow on
> patches later.
>
> Fixes: d96fe1808dcc ("media: qcom: camss: Add CSID 780 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  .../media/platform/qcom/camss/camss-csid-gen3.c    | 28 +++++++++++-----=
------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen3.c b/driver=
s/media/platform/qcom/camss/camss-csid-gen3.c
> index bd059243790ed..ed5c5766efd36 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-gen3.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
> @@ -145,12 +145,12 @@ static void __csid_configure_wrapper(struct csid_de=
vice *csid)
>         writel(val, csid->camss->csid_wrapper_base + CSID_IO_PATH_CFG0(cs=
id->id));
>  }
>
> -static void __csid_configure_rdi_stream(struct csid_device *csid, u8 ena=
ble, u8 vc)
> +static void __csid_configure_rdi_stream(struct csid_device *csid, u8 ena=
ble, u8 port, u8 vc)
>  {
>         u32 val;
>         u8 lane_cnt =3D csid->phy.lane_cnt;
>         /* Source pads matching RDI channels on hardware. Pad 1 -> RDI0, =
Pad 2 -> RDI1, etc. */
> -       struct v4l2_mbus_framefmt *input_format =3D &csid->fmt[MSM_CSID_P=
AD_FIRST_SRC + vc];
> +       struct v4l2_mbus_framefmt *input_format =3D &csid->fmt[MSM_CSID_P=
AD_FIRST_SRC + port];
>         const struct csid_format_info *format =3D csid_get_fmt_entry(csid=
->res->formats->formats,
>                                                                    csid->=
res->formats->nformats,
>                                                                    input_=
format->code);
> @@ -163,14 +163,14 @@ static void __csid_configure_rdi_stream(struct csid=
_device *csid, u8 enable, u8
>          * the four least significant bits of the five bit VC
>          * bitfield to generate an internal CID value.
>          *
> -        * CSID_RDI_CFG0(vc)
> +        * CSID_RDI_CFG0(port)
>          * DT_ID : 28:27
>          * VC    : 26:22
>          * DT    : 21:16
>          *
>          * CID   : VC 3:0 << 2 | DT_ID 1:0
>          */
> -       u8 dt_id =3D vc & 0x03;
> +       u8 dt_id =3D port & 0x03;
>
>         val =3D RDI_CFG0_TIMESTAMP_EN;
>         val |=3D RDI_CFG0_TIMESTAMP_STB_SEL;
> @@ -180,7 +180,7 @@ static void __csid_configure_rdi_stream(struct csid_d=
evice *csid, u8 enable, u8
>         val |=3D format->data_type << RDI_CFG0_DT;
>         val |=3D dt_id << RDI_CFG0_DT_ID;
>
> -       writel(val, csid->base + CSID_RDI_CFG0(vc));
> +       writel(val, csid->base + CSID_RDI_CFG0(port));
>
>         val =3D RDI_CFG1_PACKING_FORMAT_MIPI;
>         val |=3D RDI_CFG1_PIX_STORE;
> @@ -189,22 +189,22 @@ static void __csid_configure_rdi_stream(struct csid=
_device *csid, u8 enable, u8
>         val |=3D RDI_CFG1_CROP_H_EN;
>         val |=3D RDI_CFG1_CROP_V_EN;
>
> -       writel(val, csid->base + CSID_RDI_CFG1(vc));
> +       writel(val, csid->base + CSID_RDI_CFG1(port));
>
>         val =3D 0;
> -       writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(vc));
> +       writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(port));
>
>         val =3D 1;
> -       writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(vc));
> +       writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(port));
>
>         val =3D 0;
> -       writel(val, csid->base + CSID_RDI_CTRL(vc));
> +       writel(val, csid->base + CSID_RDI_CTRL(port));
>
> -       val =3D readl(csid->base + CSID_RDI_CFG0(vc));
> +       val =3D readl(csid->base + CSID_RDI_CFG0(port));
>
>         if (enable)
>                 val |=3D RDI_CFG0_EN;
> -       writel(val, csid->base + CSID_RDI_CFG0(vc));
> +       writel(val, csid->base + CSID_RDI_CFG0(port));
>  }
>
>  static void csid_configure_stream(struct csid_device *csid, u8 enable)
> @@ -213,11 +213,11 @@ static void csid_configure_stream(struct csid_devic=
e *csid, u8 enable)
>
>         __csid_configure_wrapper(csid);
>
> -       /* Loop through all enabled VCs and configure stream for each */
> +       /* Loop through all enabled ports and configure a stream for each=
 */
>         for (i =3D 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
>                 if (csid->phy.en_vc & BIT(i)) {
> -                       __csid_configure_rdi_stream(csid, enable, i);
> -                       __csid_configure_rx(csid, &csid->phy, i);
> +                       __csid_configure_rdi_stream(csid, enable, i, 0);
> +                       __csid_configure_rx(csid, &csid->phy, 0);
>                         __csid_ctrl_rdi(csid, enable, i);
>                 }
>  }
>
> --
> 2.52.0
>

