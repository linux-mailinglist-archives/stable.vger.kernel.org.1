Return-Path: <stable+bounces-214754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D+2BTkDh2mpSwQAu9opvQ
	(envelope-from <stable+bounces-214754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 10:17:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873091054CC
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 10:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3E6E303BB31
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777630F526;
	Sat,  7 Feb 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z2wAH+CH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ibd3xx/G"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ECC30CD9E
	for <Stable@vger.kernel.org>; Sat,  7 Feb 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770455830; cv=none; b=O2KAL869GNJIKyHvBPm3Cuh3usIdsmjWeaUC3Oz/2a48hPdICoHos425RHtbMst3JfzTHfkQ7nP2qpDV/27DiJpYGtp5cMpRQKWGQyMiYSxB5AuBHVmWgz1VCbCPx43cZC+946k/bDpPdS04rDW9x0L10Y9dY9/6yRDbviRb2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770455830; c=relaxed/simple;
	bh=9NTj8bze6eCT0gE44OzOQat7Pe7A3mxPsta0j/QPQbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sm4iQopbfiuTLJ0FKAJuAmDEJhFS8Vaaaoahe26sL/covgYzgtH0O4yeDutbYZnRePZilCxlkUV9ojMHrFkBZnbC7QRtvp3uIFArs2PpEjAopt4dT1KW5jgF95KBvg4wKTUkOy1G9n/S3s5x+RAxEnbTCzZ2klZvJ7j7kikwcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z2wAH+CH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ibd3xx/G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6174Ou5m1740797
	for <Stable@vger.kernel.org>; Sat, 7 Feb 2026 09:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YDwncRQ168ONlLDkORs7Ecnl
	lvkOETKSKd/v3Pe+RYk=; b=Z2wAH+CHV5GXOnQAn6e5aNvaVwV9hKHnoucdD0fl
	WAkYpYb6KpaAPQj0WgxfwuFN1aBET/jgAh2lrBOmQMMckgZQO1U/tsZLXPGfYzqq
	s5ONSI/h3f7ZJOEdnwJkEjmr3symPMvLIYrZcp5z5YLfzrDcdKx/4xdA/H5NI0qh
	PSoCShabfnGrD0CxJHT05cwlQZRv5/KmplmXOHnpK1+8D2rqUKGiZ4/c3AeNgaQq
	XU/1Kb7raBM5hrnaCA0PMSkTCI+EpH22y+6ZzC9Cj4ingc7nIy0ypOcAeyvLikB5
	4vBQg9VVLI/hAfUHiDnNcxPIr/sVONHmf1GsF/Dq1KgWYw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xbf8dkq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Sat, 07 Feb 2026 09:17:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c711251ac5so774618385a.1
        for <Stable@vger.kernel.org>; Sat, 07 Feb 2026 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770455828; x=1771060628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YDwncRQ168ONlLDkORs7EcnllvkOETKSKd/v3Pe+RYk=;
        b=ibd3xx/GQCkUVLLxD1eA++Mt+5FKEhjD8G1S775JOdek75kxLB/xVwfp4UKvGv9BLZ
         8NAE4hIZAnbsu+x4MF2s4Ag00zhwS0V+w+3CyCB0nvFGrkx5ZHaTJDdSvlwDbQNL+R8v
         D6KhnY1WuT8uHDYe6f5j9CKilvmoi1EglBimtX6N/N8CQX6ZHF13GqAfU6VhJArHiTAb
         2ux0BffePt4UO+XUzsxqVwsBIX7WIpNzQFsS3Xizum96HwlGBElGKMGLEe33ISzN1Jnn
         2GOquFyALLDzeYRSz692b8SnRKZ2SvmH88Sm+ZloIQg1nzIA0xSPivO362b2mG+XCoSh
         Id/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770455828; x=1771060628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDwncRQ168ONlLDkORs7EcnllvkOETKSKd/v3Pe+RYk=;
        b=igivuGSGj0HngB9XnQHQs5p3NyIpllAdCeZIC6qPJXlAPxOKjKeeNsTw3mUfcGySqD
         MdUp/2Q6Xx2AWisGSlye4cavbF8uLvhSGVkSbKPnBWLZ8sChdTWtFWORlJePcFOS+TY3
         V2q/dADUuWENxNRBLnmXZJp0k3NPa59fgkHKdAJO4Jg6i01RbmnmizgeFws3fdjTSU7p
         jMzLh5PXOHIlXx9H940aiDBK3etFV6xXAZvND/DGpbCcvzV7wTGoWN3Rz86HWTN2y/Jd
         ECM8j77+wtxXGUGp6v4GPiwb/5eM/L24jMWDl4OKEN9E2cocw3i0wZoUZLRJCN1GkhQK
         Gs9A==
X-Forwarded-Encrypted: i=1; AJvYcCVhPtShkqS4uL8R6MhZxZr878e3E5chAkIVx0jxvnI9ahNyLLLRao4pe5v/uOSzIyK7KClYKVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCJbs2uoSX9sZvMldrEnhUhP6kwubTwomeIgAWL6HsrusEAgV
	Gn1c0i+Bwh9ubqQ4p9osp9vFniWOZ4GYkc4TXnk+v3syVTzfE1PjFHoxUydYqgO9/5vV7CgiGbb
	MqoaqrWTfpwHosJOU/VYIKFB58YA1hMtyZ7kQqk67eXncclzDCVLXrFA7Zw8pH6QL9cU=
X-Gm-Gg: AZuq6aLcIzsQ6iSGgJ0V7e12uyYTbJzzxjq8RhpvnmnOud4hTB93o5j6+Mu0Qt6XWrM
	Okje+X/24hkX72ZK68qsW2V79dG139C8JTOy4fe0jKtjhZlhO3ioCVmKU9QxEPMeB4wNp9Fzh2Z
	xt8OhfMcC33jAd+L/VAxwxrd5QqjVG8QboTTYN+8sMInMtS4y6f2nKLgUpJ7W9B4hvHJo5TfDnQ
	FBO1iwLg7gZQ0m3cBkbyqcIho0fioVNbYYAVwqxm8El8TRpl/6pdp22VtkUHeuaB8Bg7gK/ZQIg
	BF0/eWhY7+mx5MVz6dXtsgciuh4EyznO0VU15pOrdGBsByYiW82/4qh5lfp2vKxSGzkcbKJKf9q
	sgskcV//Z96P2xoTEJufF0MQiepkFon+NNmg8wZce+G2SWHC0XvJvhnZ4BF1luk5BKJSI5hQH7b
	VIcG6C5k/9Y6fIs/EPu/nwnio=
X-Received: by 2002:a05:620a:390a:b0:8c7:1b3f:5eab with SMTP id af79cd13be357-8caf17e3d13mr709725385a.60.1770455828530;
        Sat, 07 Feb 2026 01:17:08 -0800 (PST)
X-Received: by 2002:a05:620a:390a:b0:8c7:1b3f:5eab with SMTP id af79cd13be357-8caf17e3d13mr709722085a.60.1770455827958;
        Sat, 07 Feb 2026 01:17:07 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b6158615sm10860231fa.0.2026.02.07.01.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 01:17:07 -0800 (PST)
Date: Sat, 7 Feb 2026 11:17:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, robh@kernel.org,
        krzk+dt@kernel.org, cnor+dt@kernel.org, srini@kernel.org,
        perex@perex.cz, tiwai@suse.com, alexey.klimov@linaro.org,
        mohammad.rafi.shaik@oss.qualcomm.com, quic_wcheng@quicinc.com,
        johan@kernel.org, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stable@vger.kernel.org
Subject: Re: [PATCH 02/10] ASoC: qcom: q6apm-lpass-dai: Fix multiple graph
 opens
Message-ID: <62fl655uwn4fevonuuhxs7rplpmcdgkghrivaihhptz3e6empc@snkbjhydc3mu>
References: <20260205171411.34908-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260205171411.34908-3-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205171411.34908-3-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: XM41rgMm0SXtDqflPrJ_7W3teFw5q2WC
X-Proofpoint-GUID: XM41rgMm0SXtDqflPrJ_7W3teFw5q2WC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDA3MiBTYWx0ZWRfX5B+tyhj0e/P/
 vHH8rQcjCi7P9DZR9GuOyoBCH5jTi3lTY36XLY5FSs9kkcYtC2cl72bRoLA3Q1Z4Y1MzwPAHD1J
 yUTXXIGMINU2oyU4M44qsw+s3Km9j9sASDJQqU0SduY5ABVqHS4VKxoOyfTdma6ID+Q6uB/xDRm
 rMg4j3luo8eKlPv6yUUKVdxYt03wuoYOWXeo2y607skHbyyEQI4YIjEqlukPrmwsAZOKFuJb6dz
 38ziWmCUystgrDyJqKoFSfQG7Y8hIwzwrMD4te48LG9s6Fgo3AAO9cAR2FXXHjCz06SObMV1X9O
 fuQzVq3jN6AWygsiqyIbd3q/KJFIhad5oLaIfcwrJNtnC3QXQQ2lzyZh/CjjRp5P3ezcuR8R7fC
 ygaU5tXY5gC1UbwVM+rMPJ0RLxqScjWp5rlbzTIeLecNuY57XQVXxe5DJHjqnkEiCjWXHtxN8kP
 7tn5vKSwhfet1JjDE0w==
X-Authority-Analysis: v=2.4 cv=aIb9aL9m c=1 sm=1 tr=0 ts=69870315 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=wNLNz8utBmpzwjt1yvAA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602070072
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214754-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,linaro.org,oss.qualcomm.com,quicinc.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 873091054CC
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:14:03PM -0500, Srinivas Kandagatla wrote:
> As prepare can be called mulitple times, this can result in multiple
> graph opens for playback path, fix this by checking if there is already a
> graph instance.
> 
> This will result in a memory leaks, fix this by adding a check before
> opening.

I think, the commit message should be improved by removing the first
'fix this' sentence.

> 
> Fixes: be1fae62cf25 ("ASoC: q6apm-lpass-dai: close graph on prepare errors")
> Cc: Stable@vger.kernel.org
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
> index 528756f1332b..f68d4b4974f3 100644
> --- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
> +++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
> @@ -181,7 +181,7 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
>  	 * It is recommend to load DSP with source graph first and then sink
>  	 * graph, so sequence for playback and capture will be different
>  	 */
> -	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && dai_data->graph[dai->id] == NULL) {
>  		graph = q6apm_graph_open(dai->dev, NULL, dai->dev, graph_id);
>  		if (IS_ERR(graph)) {
>  			dev_err(dai->dev, "Failed to open graph (%d)\n", graph_id);
> -- 
> 2.47.3
> 

-- 
With best wishes
Dmitry

