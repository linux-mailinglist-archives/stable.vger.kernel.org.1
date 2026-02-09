Return-Path: <stable+bounces-214925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC08Bk7WiWnZCAAAu9opvQ
	(envelope-from <stable+bounces-214925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 13:42:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFD710EE30
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 13:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCAB730071EC
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD775376483;
	Mon,  9 Feb 2026 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S2fEhG4H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i4qoXwnn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA90371056
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640970; cv=pass; b=BO4BTCUIdilsqFZwgZ0RBQkSvwF9x4b7JcgwfXfyQXbwc89k0fMkdv/w+AxDCysw9wq+xyjXLCO3FlYZrrEeZjk6zXd7mMxw0mPaGtMP/bqRXOiduhVtoDNeFzWt+WCz5vNecO41n6bnRaAqEgB7rSe1Z5UHj+nfd/5p9jPPOLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640970; c=relaxed/simple;
	bh=1YAPMat3fgMYTPI9lsT4WpJJ+YO7j5j7QhykCTiO9ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmHoK+naGc7QGTv5n9im2dS1YBUOfdhPwhB0VWGBdPJNXQCBn7GMlkmEWYN2qWSvhklRzF+Haq4vASCkT+WIGX3qCfx9xJPO0k92LdvHjkTCphIV3+PHj+Yj5+j1ImIFdqwtNiBlD6afaGocD0DzrYNa1REQlOZBI8pvrFysKuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S2fEhG4H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i4qoXwnn; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6197pPU42968270
	for <stable@vger.kernel.org>; Mon, 9 Feb 2026 12:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4HXOdUncAgw8qzJsoTSeySMYtHEC/kLDp+/WjXf/xvc=; b=S2fEhG4H8sMcdrTh
	FqXnPs1I5xUqwgGJSxlfWg3+yq9FcX0Qi9XO7JzNliDrr0g3H78hxshFeN6i8Jt0
	3JfjAphMhIgDlepocULF72EsgGYuNu8SUcX7+sfWWlUvHC4yLwtmiC8FesSLSqxE
	AIkgBVCf48JLPtddcB4K/hF1NcedQdBmawgLrde3gpM59gi+SJlAFenOE5jsZRqU
	laDu2385LSPRGB0Zz7xfd+gNWY63/YKykdXBOLTYy3BX3DTsUJEQj6EEBfogJZp8
	xfZ5EbQ9HpALMouw8O/yr/LmRQTCS0q8UPvwsssVWo6sw+OllkqCX85/OzaKqr+a
	SZ4V0Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c6g65bgr5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Feb 2026 12:42:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b866e72c00so1335284eec.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 04:42:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770640968; cv=none;
        d=google.com; s=arc-20240605;
        b=dFwmQXzX6xQLb5MlXXvY85+Ck7pt+csZykYxWxbm1XjIE+ebI87rMeHwwCuz5zG5NW
         DBESMNnv0gj572swPLw61pGVXYTEM3Mnl73GljxefUyyoHlIt1jBvYbrKNjWUZJEg006
         1REsSHgKydkU2sn5gaHkwEBLKtsO3exGk9S8WsuvEBvOzP4p6t245nU19qKyT2RWn0iV
         rVmmgUlELnEKj2HDSX4QrxAETLYElnJQnqsBbn5trzInlvlzC5tDCrrFcmrkqCGjhRVU
         ceuNRNZ88O4uXOGl8LaCVp2Ct3qvAOdiRMlI1BL3WwTs1vbPanx1j+Tvev4UEXBFu2+1
         VRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4HXOdUncAgw8qzJsoTSeySMYtHEC/kLDp+/WjXf/xvc=;
        fh=ZckiDYLUOart0d600GE+CHerCvPboEvK6e6djQ7KLDM=;
        b=gbY5lRzSqc86iAQg77MJ9aJjIBf+9vksqXm2MQsP6PKXy2HVcUO3V6RGcsmJbSICvu
         Hw/7UVsTADnaftnt3i9DNv47iZL489WyCCu/cFahvQSE54AOkm0gPI3RBnwXWz6IPa6F
         kLhlmiY7I9/5ixv5wDKKwLyM/FWdwo2VEOwKZKtVQGMGW0uhjcdMZjE8lL3kLFcRIax3
         BCY/DWG5p/RuUhqbAfW40vnmqT6eQBxRvquTBywpQOgEre8LL6ve1Bpdtw06eQ2zdsQW
         G2efmCbtjQdqyH7++hhTeo/+22mlJRFk8brHucfEBDmHDK1bRrFcio+Bqe3pCMExysT4
         SEJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770640968; x=1771245768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HXOdUncAgw8qzJsoTSeySMYtHEC/kLDp+/WjXf/xvc=;
        b=i4qoXwnnJh05Pi5z3tfQ7Rw9tOF+I4resdhn0L8J/UWZaw2rjkdyGLajTPMGptvZHS
         vrWhlDuHi1NmzlSzC3WJZdhwvTwf9PGGLc0BvQdTdrwmtKvjbpBuG71EmqmPtLvsj7ou
         l4itBNBleCIRlI6fLKmblSIyyf4tfl9e3wWsAynoGzomqGsSN4kk9wQ8iM4dJ1aOMreB
         3yqoDDdVwbO1b1bL97vhNiAq3H3eywZWPxpjk39gaugA2xZul9vJWJha0tYyJJ6YGpfq
         pntlk8bejF1yV/tKZuNkwLt/Y5fc67vlz1smqMVstOlWkghnxbIdl0btmLHzhOZ5Qlpf
         9ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770640968; x=1771245768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HXOdUncAgw8qzJsoTSeySMYtHEC/kLDp+/WjXf/xvc=;
        b=ok8pAP3NP8O2A+si7mcKTLsOCkDTmEfE4RCiv7XooNLrhI3s6HX7LnOvdbQcLvKa6T
         UdE22xU4HUQnJ0z47cI0sE2bhA81m1D0smSTxkLekpPmfRKf8voaAZShNHON99y+sP4O
         lSCgpBAlBmewr4wQU3OvFhx3DzC3vxQD+J/OBd8/Kyqp1yP9wyk4J9PUAKb7n64wqhP1
         L2yMAcO07ubbrcYNxyNGqOH7s2vVGw+qbpPxS2o4e615jEEKP3RmbSK4Mqq+Ttu85oE7
         8AEoGaJmeXXyLWwh3Ww6gdYPk1eDkYR0UDzPHfR4CbmKZpPkraO/JJLWo7vr7POyrVNT
         wIAw==
X-Forwarded-Encrypted: i=1; AJvYcCU5IZdF+80GKeClZbIoy2oWjuN6VAn1N97INAprRIbGV3RARK0M+gMdXnSiXJY9eIJ1Jr4Oeh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWnB40wgKC+p0aDlu5z2lGySLtD5OiyIOLjlcuijSjAPqLbP7
	rYHd+PcsShwulSarCCMOmMVcK0DyJZk8UKbuTNsrQtaoxHs/JNlvEidMWMZoayW81t8gNdc9Qe/
	McN3wsbg1Vc+E+O6X26D9UjV5FyrnCYShZCfHF+DavPwTrAVE1EoXEOgni5NbJ4RIaXweBL2wc6
	8651ZlR8xZoq+b6Hqg6HQ2lNH1F2vMupj+0w==
X-Gm-Gg: AZuq6aKIYVZJi5NaJP17KLSN3aGT8acaTaaT3M5dGp9LnNsZg1l/sqJguV7RBC8PlIb
	YbwB+CC/FTNVo7EgvV6c+FzfAWNLBl5Ixvw+MmkOFy1sPuCd7P5GPC0b47qSTgM7AwtrcL1SLVI
	ILnCOQatoQ8EWs0cR8f9SG+QtrocOuACFyXYo6QCXxugGRVkgZpXIsxDrMpNiFiKwgEx1x
X-Received: by 2002:a05:7300:e410:b0:2b7:ee0e:e9ca with SMTP id 5a478bee46e88-2b85647b551mr4807554eec.13.1770640967820;
        Mon, 09 Feb 2026 04:42:47 -0800 (PST)
X-Received: by 2002:a05:7300:e410:b0:2b7:ee0e:e9ca with SMTP id
 5a478bee46e88-2b85647b551mr4807543eec.13.1770640967266; Mon, 09 Feb 2026
 04:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203080712.15480-1-manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20260203080712.15480-1-manivannan.sadhasivam@oss.qualcomm.com>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 18:12:35 +0530
X-Gm-Features: AZwV_QhQGrhmiXiesmhxlG4WV4s55cvRqMlCM-CccbSkZMO1A1Xt1ut2g-2JQXI
Message-ID: <CAGptzHOfmrHeJWvMxWj_xUTt_Xn-WGX04oc5s7DvjujPUOWQZQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: ice: Remove platform_driver support and expose
 as a pure library
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mani@kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GqNPO01C c=1 sm=1 tr=0 ts=6989d649 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=9JMtb3v2HZz85qpu0UYA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: kdqO_dDcywb1S9w4NWTl8iuTdHWtxQ-g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEwNiBTYWx0ZWRfXyadeWAG1SrEo
 V3+esNfsiln600U1ZOJ55rUctscHJOpYRuzq4l7pw8jKc2di86Hqq5VgSYV2pMRj9jdOKoGUGyq
 RlslWLVmSYGdh3LeOO2NtLKzHtZngpmNWhcueCFYaz/HXz5HID3rUDBJdrT/dgmRJXu4fUCbCHa
 q6RsNll5XJDf1VBGPPTWzs9hqBWl6plI+acABP7oOl5d+xFb+RoiU2+TKsCsf1QyVS2KJjcisYY
 tD0qhIrwQnl49s0roFQOk0MifJBxgrzFOB5HcLoNe9aIWo0KJDb9GvS5AFK+W9oqWlIyHfCpf+0
 yvMELEgRvzDDwQGNpxOpwe9wUcyZnOxrotUGZUEUgsDCzyN4nDm15LthNogfmKz78ZPd7GsFM5V
 DDkUQDSMbS6fJwQyTr4UASU8A5IiBNuZBL7v7TfLui46F2Uq5pkFPKyVo8pgAIhgke3pEGKcwKC
 Hlnzufai+18ItPl59MQ==
X-Proofpoint-GUID: kdqO_dDcywb1S9w4NWTl8iuTdHWtxQ-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-214925-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: 7AFD710EE30
X-Rspamd-Action: no action

Hi Mani,

On Tue, Feb 3, 2026 at 1:37=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> The current platform driver design causes probe ordering races with clien=
ts
> (UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE probe
> fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops wit=
h
> -EPROBE_DEFER, leaving clients non-functional even when ICE should be
> gracefully disabled. devm_of_qcom_ice_get() cannot know if the ICE driver
> probe has failed due to above reasons or it is waiting for the SCM driver=
.
>
> Moreover, there is no devlink dependency between ICE and client drivers
> as 'qcom,ice' is not considered as a DT 'supplier'. So the client drivers
> have no idea of when the ICE driver is going to probe.
>
> To avoid all this hassle, remove the platform driver support altogether a=
nd
> just expose the ICE driver as a pure library to client drivers. With this
> design, when devm_of_qcom_ice_get() is called, it will check if the ICE
> instance is available or not. If not, it will create one based on the ICE
> DT node, increase the refcount and return the handle. When the next clien=
t
> calls the API again, the ICE instance would be available. So this functio=
n
> will just increment the refcount and return the instance.
>
> Finally, when the client devices get destroyed, refcount will be
> decremented and finally the cleanup will happen once all clients are
> destroyed.
>
> For the clients using the old DT binding of providing the separate 'ice'
> register range in their node, this change has no impact.
>
> Cc: stable@vger.kernel.org
> Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reported-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicat=
ed driver")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/soc/qcom/ice.c | 100 ++++++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 61 deletions(-)
>

Thanks for this change but we need to avoid building ICE as a module
too and return error code when ICE SCM calls aren't present.

So following diff on top of this patch works for me, feel free to
incorporate it in your patch:

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 2caadbbcf830..db528104488b 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -283,7 +283,7 @@ config QCOM_ICC_BWMON
          memory throughput even with lower CPU frequencies.

 config QCOM_INLINE_CRYPTO_ENGINE
-       tristate
+       bool
        select QCOM_SCM

 config QCOM_PBS
diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 8640e05becd1..139891a122db 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -563,7 +563,7 @@ static struct qcom_ice *qcom_ice_create(struct device *=
dev,

        if (!qcom_scm_ice_available()) {
                dev_warn(dev, "ICE SCM interface not found\n");
-               return NULL;
+               return ERR_PTR(-EOPNOTSUPP);
        }

        engine =3D devm_kzalloc(dev, sizeof(*engine), GFP_KERNEL);

-Sumit

> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index b203bc685cad..b5a9cf8de6e4 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -107,12 +107,16 @@ struct qcom_ice {
>         struct device *dev;
>         void __iomem *base;
>
> +       struct kref refcount;
>         struct clk *core_clk;
>         bool use_hwkm;
>         bool hwkm_init_complete;
>         u8 hwkm_version;
>  };
>
> +static DEFINE_MUTEX(ice_mutex);
> +struct qcom_ice *ice_handle;
> +
>  static bool qcom_ice_check_supported(struct qcom_ice *ice)
>  {
>         u32 regval =3D qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
> @@ -599,8 +603,8 @@ static struct qcom_ice *qcom_ice_create(struct device=
 *dev,
>   * This function will provide an ICE instance either by creating one for=
 the
>   * consumer device if its DT node provides the 'ice' reg range and the '=
ice'
>   * clock (for legacy DT style). On the other hand, if consumer provides =
a
> - * phandle via 'qcom,ice' property to an ICE DT, the ICE instance will a=
lready
> - * be created and so this function will return that instead.
> + * phandle via 'qcom,ice' property to an ICE DT node, then the ICE insta=
nce will
> + * be created if not already done and will be returned.
>   *
>   * Return: ICE pointer on success, NULL if there is no ICE data provided=
 by the
>   * consumer or ERR_PTR() on error.
> @@ -611,11 +615,12 @@ static struct qcom_ice *of_qcom_ice_get(struct devi=
ce *dev)
>         struct qcom_ice *ice;
>         struct resource *res;
>         void __iomem *base;
> -       struct device_link *link;
>
>         if (!dev || !dev->of_node)
>                 return ERR_PTR(-ENODEV);
>
> +       guard(mutex)(&ice_mutex);
> +
>         /*
>          * In order to support legacy style devicetree bindings, we need
>          * to create the ICE instance using the consumer device and the r=
eg
> @@ -631,6 +636,16 @@ static struct qcom_ice *of_qcom_ice_get(struct devic=
e *dev)
>                 return qcom_ice_create(&pdev->dev, base);
>         }
>
> +       /*
> +        * If the ICE node has been initialized already, just increase th=
e
> +        * refcount and return the handle.
> +        */
> +       if (ice_handle) {
> +               kref_get(&ice_handle->refcount);
> +
> +               return ice_handle;
> +       }
> +
>         /*
>          * If the consumer node does not provider an 'ice' reg range
>          * (legacy DT binding), then it must at least provide a phandle
> @@ -643,41 +658,43 @@ static struct qcom_ice *of_qcom_ice_get(struct devi=
ce *dev)
>
>         pdev =3D of_find_device_by_node(node);
>         if (!pdev) {
> -               dev_err(dev, "Cannot find device node %s\n", node->name);
> +               dev_err(dev, "Cannot find ICE platform device\n");
> +               platform_device_put(pdev);
>                 return ERR_PTR(-EPROBE_DEFER);
>         }
>
> -       ice =3D platform_get_drvdata(pdev);
> -       if (!ice) {
> -               dev_err(dev, "Cannot get ice instance from %s\n",
> -                       dev_name(&pdev->dev));
> +       base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base)) {
> +               dev_warn(&pdev->dev, "ICE registers not found\n");
>                 platform_device_put(pdev);
> -               return ERR_PTR(-EPROBE_DEFER);
> +               return base;
>         }
>
> -       link =3D device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPP=
LIER);
> -       if (!link) {
> -               dev_err(&pdev->dev,
> -                       "Failed to create device link to consumer %s\n",
> -                       dev_name(dev));
> +       ice =3D qcom_ice_create(&pdev->dev, base);
> +       if (IS_ERR(ice)) {
>                 platform_device_put(pdev);
> -               ice =3D ERR_PTR(-EINVAL);
> +               return ice_handle;
>         }
>
> -       return ice;
> +       ice_handle =3D ice;
> +       kref_init(&ice_handle->refcount);
> +
> +       return ice_handle;
>  }
>
> -static void qcom_ice_put(const struct qcom_ice *ice)
> +static void qcom_ice_put(struct kref *kref)
>  {
> -       struct platform_device *pdev =3D to_platform_device(ice->dev);
> -
> -       if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
> -               platform_device_put(pdev);
> +       platform_device_put(to_platform_device(ice_handle->dev));
> +       ice_handle =3D NULL;
>  }
>
>  static void devm_of_qcom_ice_put(struct device *dev, void *res)
>  {
> -       qcom_ice_put(*(struct qcom_ice **)res);
> +       const struct qcom_ice *ice =3D *(struct qcom_ice **)res;
> +       struct platform_device *pdev =3D to_platform_device(ice->dev);
> +
> +       if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
> +               kref_put(&ice_handle->refcount, qcom_ice_put);
>  }
>
>  /**
> @@ -713,42 +730,3 @@ struct qcom_ice *devm_of_qcom_ice_get(struct device =
*dev)
>         return ice;
>  }
>  EXPORT_SYMBOL_GPL(devm_of_qcom_ice_get);
> -
> -static int qcom_ice_probe(struct platform_device *pdev)
> -{
> -       struct qcom_ice *engine;
> -       void __iomem *base;
> -
> -       base =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(base)) {
> -               dev_warn(&pdev->dev, "ICE registers not found\n");
> -               return PTR_ERR(base);
> -       }
> -
> -       engine =3D qcom_ice_create(&pdev->dev, base);
> -       if (IS_ERR(engine))
> -               return PTR_ERR(engine);
> -
> -       platform_set_drvdata(pdev, engine);
> -
> -       return 0;
> -}
> -
> -static const struct of_device_id qcom_ice_of_match_table[] =3D {
> -       { .compatible =3D "qcom,inline-crypto-engine" },
> -       { },
> -};
> -MODULE_DEVICE_TABLE(of, qcom_ice_of_match_table);
> -
> -static struct platform_driver qcom_ice_driver =3D {
> -       .probe  =3D qcom_ice_probe,
> -       .driver =3D {
> -               .name =3D "qcom-ice",
> -               .of_match_table =3D qcom_ice_of_match_table,
> -       },
> -};
> -
> -module_platform_driver(qcom_ice_driver);
> -
> -MODULE_DESCRIPTION("Qualcomm Inline Crypto Engine driver");
> -MODULE_LICENSE("GPL");
> --
> 2.51.0
>

