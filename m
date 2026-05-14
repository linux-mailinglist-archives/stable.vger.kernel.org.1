Return-Path: <stable+bounces-247157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPWdJVyUBWpLYwIAu9opvQ
	(envelope-from <stable+bounces-247157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:22:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4525053FB7D
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DCAF302D5DB
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE95439D6F0;
	Thu, 14 May 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bc7GwRje";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TM9a2plC"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328239AD33
	for <Stable@vger.kernel.org>; Thu, 14 May 2026 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750550; cv=none; b=j6POqqUutweCbUEFk7LdumEtwl2K/L9AjYe2ng6aU5oZd/KNqsfS8ppskir5wqipxEe2deuRslkZo3DwVZ2E7DOvNPUT4Mhxv5Ilpywj1ndgtAzGr9yr3MKHGzX/cnfNi5ASQW86SZSm1AUzjwKep1HVT0cgMAdL9DKqnfkOFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750550; c=relaxed/simple;
	bh=8qvCgOo9gFGl9XcfkFEwQQd+gul4avO4zIY395CfJiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoJ7hCVAOX/MtoZz9n+A6Ol7A/KPSbYz0RoASmr9cy8W/3aNMc6blHO5DKp69qbNVSNhHYcPQ85wRCBP5gbxoPQaybFpWV9IyhXvajbgT4vhl2knF3i9Kyxb4u+cJTmHKsoCazwlQsBIk34oWNNtss/0IpNdsnOFVw5nmILFezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bc7GwRje; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TM9a2plC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E694SB1966465
	for <Stable@vger.kernel.org>; Thu, 14 May 2026 09:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0bgWw2JnGIEYuwfsPsRuR3+f
	K6lh7stB/T9o5jqNXgo=; b=bc7GwRjeHKoPPdUJGNHWcPwkKOF69aKvhgyV4nzK
	QP+2BpS5bEIWAl2VfNPlsDFX+wYkg0LFyQ9zZJ279EOwXOxPGHJL4mpyucUNKJeG
	cExfN4oaGBDMvf+l7py2Jx/bCJ3B1qfnABosL5bhaur7KUphJ+0ZrRdEkUrQLTQb
	snFEL1OpF0RJdueD5pnW5t0llugHRyUJhjO5Usfrc3ZNNmVhcprBx8FqX+6lGW9R
	uYTOKa103IwSi6di14CJdbOhLQtISBS80wSYVMBm/OUrdvc3K1k7ucaPciskCI+R
	nAv6VlWJQ9mmepd/hgIg8PhV76nP35YWOdoqOEGRpkh+pQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e58v88pdy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 14 May 2026 09:22:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e136aff17so26976321cf.3
        for <Stable@vger.kernel.org>; Thu, 14 May 2026 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778750547; x=1779355347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bgWw2JnGIEYuwfsPsRuR3+fK6lh7stB/T9o5jqNXgo=;
        b=TM9a2plCkMFLbU8nYLbi0RP+yh1s4r7kejiYVc0U9xPh9AzRN0wAbIFdaeMg2YIekT
         M754Cdub5N31lLcUOS69bd79NJuZxj/i7jG8gpzwlpnwYXmXeiz+ZzlfD2rh4u5KeA48
         UoYNjtT5QANpbcAsNFx+czNET+ib4do4J2v7PGsJ2Aafd1T4cU6UOBElnzOm/zHZC/NJ
         zoagAm+dZZmSHpnBPYSWTm9qssSCDzn9JOShHXhfKpY+C/Vnuw9N/aT4B2ehbN9+NM3F
         GDU7f8ySzfsyXcjmiEWho7vN6LhCOfml0rXf40JCHYi83UjtSytupMmnK0NHqDoKzMUx
         9r9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778750547; x=1779355347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bgWw2JnGIEYuwfsPsRuR3+fK6lh7stB/T9o5jqNXgo=;
        b=UzRrYK0DfGrHNcBukuo0JQvs/7KTJZCI22rLwyIz/aYQKQpB5WdU77SpHzZYJDcwdR
         4vGus0mPASOvLG8B4Is/IPf9wQlezqYv9/Ai92IpbSsBNTwEqe6tb/SlXEMBiAOCPZly
         2+kPwOpFSHO1fXtxEvu8nTM/azPgEOACXi8I8wkvZQHp0iIq2o6oFrG5v6cSZJdMTp7O
         DgVWF8TEKOB41lCIhjyZqsLabwQoNtDjU6qpcyUexYCJEG7esIJrRACaLRkRId1zKY35
         w8E9HSgvtVeN3GjrsWZiaov2Jf4+L12YGV0hBysD/88bCuBEnuj8elmQ2uwwQKudYBGb
         5R/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/oh8SdFbKyQdmE8baCi590lDsGzzAI13063wTZWClGrYbIhSh6dXG7sk+hd9P41JOm+26JQ3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqtVaho7UQ0w7FDc7YmvYgDYUHDNFrkGXxN3YW4Q8G2QlZAYe7
	q1gbbSs78eS4PBkaPpNqbO347ha9vUqTBiBXWgA/OepHwimKW7esA9YmhwCWQkEMbTQEsA1k2NO
	mcVgQoxuKC9TG5wzDuUaWcW/8pb2ei3JiS5XKH/9mHjAxU1TWOTkwPcEMwZc=
X-Gm-Gg: Acq92OGC1zYPb4cEGnQzQq4mkMT1rI1eZyN2ifT1P7wLTDgJwe53b/BP0zsstSV/uL7
	BjJTjOfvsCFQqV5Wdauq2U2yP2fhQJaRHQJ1c4JXwSR1K/83AXgZxCxrqTSZEde6tyxdMKrXXLz
	tnnZCKkdkqo99xPuPljJSs1jhM3EvWiUMv5HnqMC/ehBF4UqlqTxq20F1ERR0B50Aw1dHX4HxqJ
	X6c2cxp0ZAfMsH02xU17hKKefhGgCjZaFJgVA5MvpimlevVbj3RMMDQ4lgTyaoIxxb00LzTbDwz
	RyoH8rE124jOAntmqWOdHmU3LQwvWxjBmPCTLN6fZ2Ko7/N6WMEP1zY7fk0xojXdb6SxFbKlqEN
	JEW760DAkT1l6wn5/4GV+eMF5bWjOeSkTBnQRU65SXsR73o1n8vI/RudGD2gch73QFpwexDL73J
	jz5bVXoPEMrftaKBbuSijWYyruot0xQUsxlm9hryOX6R6IKg==
X-Received: by 2002:a05:622a:2518:b0:50b:526c:541c with SMTP id d75a77b69052e-5162ff58d84mr87254851cf.50.1778750547470;
        Thu, 14 May 2026 02:22:27 -0700 (PDT)
X-Received: by 2002:a05:622a:2518:b0:50b:526c:541c with SMTP id d75a77b69052e-5162ff58d84mr87254491cf.50.1778750546968;
        Thu, 14 May 2026 02:22:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c944sm363072e87.6.2026.05.14.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:22:25 -0700 (PDT)
Date: Thu, 14 May 2026 12:22:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, jens.glathe@oldschoolsolutions.biz,
        linux-sound@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, johan@kernel.org, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        val@packett.cool, mailingradian@gmail.com, Stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: q6apm-dai: Allocate an extra page for PCM
 buffers
Message-ID: <2pe7rk7jhc36osc6i4rxeyw342mvza2m7i4ztsmm6pjgwtlemc@k4gkw5b4jg7g>
References: <20260514090607.2435484-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514090607.2435484-1-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA5MiBTYWx0ZWRfX3gVm6ZEe5EWr
 8RiN3SxLPdR4c2MtxqR/fTkl9/YnsSlcUc+N2zUbQNAhoqAn+ZKMNf2ospNMlxKOkY6SlyTsdre
 d8SIaC+drBEuSdSDbxJVuHSQ3phoLCVafcPFs+N+IAFmTDIzz2WQ5dq6By3lDC96Jpb0zw960wA
 DIHbUjzw7aSZR8pLkmAzyjLiJzmEz2MPIlcVHbbibPM7SmVDmdnTkTDvxxbtlSEvbmy8V3/mAAt
 bly4ZOPmNRKGiCCn1peP6Zf5TSHHuEybBbZZBVRqotitI5KJSYl1ExEJblfsiAHyQ4DQiUXwbPM
 Ayw2GWNTbSingc2FMQjL+SjptIcbk517sv0oewhfOGZ6+8iE4wOh9CH8hX1P/J9SEL5bLvUPzT3
 HHqurHORSEBWkwSZSGQo2gt0JttVGYkZqRyW7YYFVD7gNOKrlK9pImme1KfVGsvR9CBE+JtqCmu
 U/vE9xVXsB66tVT+oUw==
X-Proofpoint-GUID: 1lfutzvp3s9OAKjvm9ZvZ-ZJPkbbMvbN
X-Authority-Analysis: v=2.4 cv=YZSNIQRf c=1 sm=1 tr=0 ts=6a059454 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=gxl3bz0cAAAA:8 a=EUspDBNiAAAA:8 a=_Q0duRmiTN8AZcyA_C4A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-ORIG-GUID: 1lfutzvp3s9OAKjvm9ZvZ-ZJPkbbMvbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140092
X-Rspamd-Queue-Id: 4525053FB7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247157-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oldschoolsolutions.biz,vger.kernel.org,gmail.com,perex.cz,suse.com,oss.qualcomm.com,packett.cool];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 09:06:07AM +0000, Srinivas Kandagatla wrote:
> Some Old DSP firmware versions use 32-bit address arithmetic and size for
> validating the PCM buffer address range. If a buffer is allocated near
> the top of the 32-bit address space, arithmetic calculations involving
> the end address can overflow and fail checks.

Should we limit the workaround to those platforms only?

> 
> Work around this by increasing the preallocated PCM buffer size by one
> page. The DSP is still passed the usable buffer size, excluding the extra
> page, which prevents the firmware from seeing an end address that crosses
> the 32-bit boundary.
> 
> This was not hit before because PCM buffer allocation and DSP-side
> mapping happened at different points, and the size mapped on the DSP was
> usually nperiods * period_size. Therefore the mapped size was unlikely to
> match the full preallocated buffer size exactly, although the issue was
> still possible. With early buffer mapping on the DSP, the full
> preallocated buffer is mapped during PCM creation, making the failure
> reproducible at boot.
> 
> Fixes: 8ea6e25c8536 ("ASoC: qcom: q6apm: Add support for early buffer mapping on DSP")
> Cc: Stable@vger.kernel.org
> Reported-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Closes: https://lore.kernel.org/all/7f10abbd-fb78-4c3a-ab90-7ca78239891a@oldschoolsolutions.biz/
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/qcom/qdsp6/q6apm-dai.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
> index ede19fdea6e9..3a1be41df096 100644
> --- a/sound/soc/qcom/qdsp6/q6apm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
> @@ -497,7 +497,12 @@ static int q6apm_dai_pcm_new(struct snd_soc_component *component, struct snd_soc
>  {
>  	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>  	struct snd_pcm *pcm = rtd->pcm;
> -	int size = BUFFER_BYTES_MAX;
> +	/*
> +	 * Allocate one extra page as a workaround for a DSP bug where 32-bit
> +	 * address arithmetic can overflow when the buffer is placed near the
> +	 * end of the addressable range.
> +	 */
> +	int size = BUFFER_BYTES_MAX + PAGE_SIZE;
>  	int graph_id, ret;
>  	struct snd_pcm_substream *substream;
>  
> -- 
> 2.47.3
> 

-- 
With best wishes
Dmitry

