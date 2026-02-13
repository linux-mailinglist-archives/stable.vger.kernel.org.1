Return-Path: <stable+bounces-216037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKIaMaLxjmk5GAEAu9opvQ
	(envelope-from <stable+bounces-216037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:40:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0152134963
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBD3B300F103
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB534D929;
	Fri, 13 Feb 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dwz+Ec1s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DU7bKN5t"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E334CFC3
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975646; cv=none; b=ZvlK07WQVvfJwoz2S5UGNTOJKmMNBzCHHOhvOuC/tervGKivD2udzlOX+ZimhuGLAQANojqaVij9Y6zOBM95hma0+k5nqndq5p+umUi07fSVLxGKna1NZYuL9QR0soFokLPTdpa/3NpDKpwBXz709DlVJTR8Rr+VgjJh5Ujhn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975646; c=relaxed/simple;
	bh=U7P3olTVkeLfckuqtGg3Ez5sD1mEL8bWEzzRb2X9380=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rERTxyOJNu+2Q+AurN9hwXJoZhHCWMKQ/BiZTg/a/G0ZkB51eGvKaFj+sqMiUkwqrXs3TgZGX3FIdM8gHs+Rf44x3Vp42MSRZBxh+sj4p1jc1DsoDHOYWrgK8+gdw9spP5CTaoShdOBSrKy8h2RkE6KbQFLsk6oRZXRjeI3gciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dwz+Ec1s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DU7bKN5t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D7r58o1642266
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z/lfOtspcFXBYF/xLcKmtVed+E+KcHC6N491qAFBLng=; b=Dwz+Ec1shTYtQITA
	ToovLj98oZarfPQUb5fZIrOu6V3eV3q2NlN//7lGN/Rs76wZPJ5GZ/KXp5urIXEa
	5jqbHFfi1HSYmUGM8XelNyiYAY2BFzGcOKKlLY/GgP0GPUJ4q2TMENcCQ3p+hu1L
	OLNQVgnpsU7fkw6pC4fCmycWJb1sh8G3DuebOQFbU4UjV6Ceupvnvrpd+lCzd07Q
	cwzJP/fpmyQAwImGf3eVJtcXQkRge7OhWiXLPLqgnEwu+NH6EGkhdoWxqwBKrs0Z
	FLQmtk6+Piu2FrbL/dAsxTleHSE6jwQL0EeJmLfAYmBWKAVINU6/M6bGk7CneC/K
	jc216A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ptv28kk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:40:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6e17c2a488so1944712a12.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 01:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770975643; x=1771580443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/lfOtspcFXBYF/xLcKmtVed+E+KcHC6N491qAFBLng=;
        b=DU7bKN5tcErWUevkl3U1Mh3dK5QCR9nWFB858M4Tlvd1YWkgxV8HU/rjouUa2ykjsP
         vOOkzHkq0djzqeehwh0DkDEwiOoaIldzggnnJEjManTEzd/km8bJiv4YKeNXP8H5NFqg
         QFZVUJuZxAYDL0TJeTPgB4vobAOu2fKNYytbqICTt5exyZiPsSSpu7p9zDj9eNoGGXcj
         G/CIREOYAPpp++dG49URty3OMb2kme0Tf4hKBhCbt3avPjwFGt9f48nP3GamgiO7/StY
         lQT9zqFEHxX0rZEQvlwBdXdmtxAH6MWhs3kF+oe915lDK3GUxKerwe1Xf+496eLcG3l9
         9VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770975643; x=1771580443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/lfOtspcFXBYF/xLcKmtVed+E+KcHC6N491qAFBLng=;
        b=IFdmeXYy01QaoPvrzZcXHWtB4ep9MLG0jFFicVLy1aWoNOu1pInUkvolFUqI0RJz8z
         MyN7uRhkCll7iA3CXO3mwZ+gKuLtSz0C9ZGzE7ZM94chHH8WVdZdR2BNEICPhBf3bcwF
         9QjuPXEK7sog/MSNvZAmL4KKAtEGLA95DSwmLhuPMoFcMJughW56Q0a/a3BMbILMNXmp
         Z7HGbav6cUTpKklcTcGjy7NIy47ZA+6dW06LGMlsZkg3iw1urjMarDl/FpA2An/MqSK/
         kOkKDRfv4D1IVjj3I0r3E7Rhw5XVizjjLO7gdipJruWvvnqxVB6eic6siW9B564jHlFD
         56eQ==
X-Gm-Message-State: AOJu0Yx5ncP9gEdC1d3DI/glOmfPhIYPpC9WDcrE4Cxw+0eJooexeLrm
	Z9glzdtdGnj4TzgBsZ2lx6YtntXJ7BwE9f+kWrCl8wiP14qcVp9WFiPLsMgWr5eRhwWVNGvOwKX
	UWT3ABAVXNcuiSmH1QwiGOGF+uopRj1z/nR27XRryoAd6kheFlFR7+yBNOak=
X-Gm-Gg: AZuq6aJMysc9fx8cjqBHLgcuhirH+7FKU+gGZss8cAd1iEdFcHNn1zFUloflizeb7PI
	kIPY4xvM6u/a8LqzgQ/PPW1aHHVQ55J9V++zmI1KyIzps9zNPqgr0o+y+uMBmNuzbYvHcuB4gs8
	Tnm1vvgmWbBzk2CjsWvIsqWo/7qC4HV0KLIjeB5o5gtHpnlhfXlc/1EnzCiWtUB+yLzPBf03+Bu
	CGQ9bVzZys1z1ufDp96iLrk5lnbVlA7KZ/3c/o96nFLN6goy9hIdTSo5BUpNb+h/E4AWRdUSdJt
	iPeOL492nfu+QxwJ7GQty4/c/ZNOcI35RB4srzbDv1aJe/+uQvlZRHLlSKz4CFI0LLjPRHjheOo
	9wM4LGygYq5dAwXk40YM8bgKeYhiXNxkR1DKHExf1KQNpP9EbWpdaWA==
X-Received: by 2002:a05:6a21:a345:b0:38d:edd4:2fc6 with SMTP id adf61e73a8af0-3946c9252a8mr1267467637.70.1770975642923;
        Fri, 13 Feb 2026 01:40:42 -0800 (PST)
X-Received: by 2002:a05:6a21:a345:b0:38d:edd4:2fc6 with SMTP id adf61e73a8af0-3946c9252a8mr1267441637.70.1770975642488;
        Fri, 13 Feb 2026 01:40:42 -0800 (PST)
Received: from [10.0.0.3] ([106.222.229.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a4316fsm2530543b3a.23.2026.02.13.01.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 01:40:42 -0800 (PST)
Message-ID: <e1c14c7b-0447-203e-33fb-97f09b38b82e@oss.qualcomm.com>
Date: Fri, 13 Feb 2026 15:10:37 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] media: iris: Fix dma_free_attrs() size in
 iris_hfi_queues_init()
Content-Language: en-US
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260213091330.23431-2-fourier.thomas@gmail.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20260213091330.23431-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1F0JZV8IXBkZW3vw0ftnc6cbxEWZp_FT
X-Authority-Analysis: v=2.4 cv=eaowvrEH c=1 sm=1 tr=0 ts=698ef19b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=VDDfqcjMpRzOalc4LhIaOQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jz17cmUFc4N99GX7AB4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NCBTYWx0ZWRfX9pPoZJifbMM+
 8FcUSf111EwYjywQJivBvGepXinEcPG+uSk82XnessTALHe5odhPRxyIbFjHJBbOZhuvZ00eOpG
 X3ZIQEW0DBEc0VHB7oBQk94AdKnF526Xs2j28yWV3k4zcBYNA36Xoq4QmXUnZl0ZiN6gcvq0t/i
 pea578eDdOc5ZuhCBO1MgtX47+/xtvxStEl/7yHbucqfA4RmnIh2+7ApKToX8oO/w5c2M8spu0m
 QmxG2PZULPQ314H7kCdJLAnxbxZzQCj2Gmr5DvQEaI1VGwqOYSD9LaOQInJZzdz3PukywTtpwp8
 JGyyywnPKJxsneDBy/V5w0hob+vsSW5hOtOZUKKKaoA6Dp1uYISSRJDJQrHUt/4riYslVg+PlUW
 YW1aOU/lnSmNiFF07yaWWJzeJ2irkgfpBj1vn1/8YcgTJLK2jIyNYyWJHx6JHuKKRG0Wge6Hizd
 uB8VDJXseJzBv9/F29Q==
X-Proofpoint-ORIG-GUID: 1F0JZV8IXBkZW3vw0ftnc6cbxEWZp_FT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-216037-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dikshita.agarwal@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B0152134963
X-Rspamd-Action: no action



On 2/13/2026 2:43 PM, Thomas Fourier wrote:
> The core->iface_q_table_vaddr buffer is alloc'd with size queue_size
> but freed with sizeof(*q_tbl_hdr) which is different.
> 
> Change the dma_free_attrs() size.
> 
> Fixes: d7378f84e94e ("media: iris: introduce iris core state management with shared queues")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/media/platform/qcom/iris/iris_hfi_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
> index b3ed06297953..bf6db23b53e2 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
> @@ -263,7 +263,7 @@ int iris_hfi_queues_init(struct iris_core *core)
>  					  GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
>  	if (!core->sfr_vaddr) {
>  		dev_err(core->dev, "sfr alloc and map failed\n");
> -		dma_free_attrs(core->dev, sizeof(*q_tbl_hdr), core->iface_q_table_vaddr,
> +		dma_free_attrs(core->dev, queue_size, core->iface_q_table_vaddr,
>  			       core->iface_q_table_daddr, DMA_ATTR_WRITE_COMBINE);
>  		return -ENOMEM;
>  	}

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

