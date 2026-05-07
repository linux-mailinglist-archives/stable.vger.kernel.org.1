Return-Path: <stable+bounces-244524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDotLmRH/GkkNwAAu9opvQ
	(envelope-from <stable+bounces-244524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:03:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C50E04E4763
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1C733007B02
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1384D335BBB;
	Thu,  7 May 2026 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gy69sdVD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IRfbqVNb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA0331A6D
	for <stable@vger.kernel.org>; Thu,  7 May 2026 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141016; cv=none; b=RauXBn0pmodD7S8K+65rZZqXwW5Ctnf/SBg2soGb3pwHzw4tf01er71DE1APCDUP6M+waTQGrnW/eVkIsKcNPZvG9xGWnLTXYVL/9vC0aQsxzzZBq3/8WYm4KaMpLi9fhz5vVR1ojVNfeRyZknDSktEnufut9cvz/hr+/g1hEXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141016; c=relaxed/simple;
	bh=CT3j++ZpGDXY8wdafFXCva+5jnuKJ5HyNp2OUnXXdnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fg/I50S0CkeDKb9LiGhJvUnKafI3AkVlFqng5YLMjBpHQW7YifGqcdnd2gzKr3fRnSsb4y33oEEikOxBTUFqJT6tEFmo9cG1I3LelvFy5DIABmUP6yoUUyDFUVHTXwwRsK8Ua62hGsTOn0YW63C+9Fobutf0EDwm8oPAFY7uOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gy69sdVD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IRfbqVNb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6472CLst260349
	for <stable@vger.kernel.org>; Thu, 7 May 2026 08:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mtfq3/2Ai6rBAqMoI9sGgKJF+BZSrWb/rzLufcVkZVE=; b=Gy69sdVD3lS7laZS
	/wp0O46q9aHxu6nX89nj8qDvQHz6HRUhwMUpIzX3vgS1tfWDRJogRPBlOw4022Dw
	SKN1oB0uCt9UYvZHAaOUV0jr/v26ppMRL0YGqtMtdxap30MVsXE3Itjd3kJiIIl9
	oUFrGPLOuqwjwgT0ofDP9tggROhfDsv7t1MDgiAuhujaTHSZyOt0gIt1ZpMO2L3v
	Zsb/3Bayptn/50bcBGrDnTTe24CidGIsJS9UwgZIpghU/0s8/Pt44+l3TbhouDec
	jXvUO2B7pQo7uDH6ImjgjaNTb6d9kOHN/eiTYb1HocISq9CcQn+z6FBjgD7aQiTR
	bRka+w==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hr8s4dq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 07 May 2026 08:03:34 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-631284608a7so990137.2
        for <stable@vger.kernel.org>; Thu, 07 May 2026 01:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778141013; x=1778745813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mtfq3/2Ai6rBAqMoI9sGgKJF+BZSrWb/rzLufcVkZVE=;
        b=IRfbqVNbc5FSlh2dkNdmfZ7lBRQ7CAOXoGQOjwAZHAfMZu4fvVUvwZnxk6HAsaEl72
         xTzg1oNf5Bel5YJmvjUT4wsLLb7Oy0RLaDXFTpQzEudnmvT7l9NUvfyb8ULBxUZjYHN1
         qWPe6WG/ZhuO5cRqx90PqlGypw3zwUBNRs97BZAeONM/Q2ADR1AbOVFlmkhttD2XzXGK
         CFSYgt+eyq3ymYnDZeSGGlPLoIbpDYroZrsxoZ1ncl8cBp/hiPHKq+dJtKW+E36cAkGj
         y5WfUUpDwo4rWDMTwOnf5oGYUjLWcWlSnXkydSvQSCmn1lRltT7ROQcYNDgsLEWb5cEQ
         URdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778141013; x=1778745813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mtfq3/2Ai6rBAqMoI9sGgKJF+BZSrWb/rzLufcVkZVE=;
        b=XeGLXzKzjIyT7MsFPd548CtJk3fVDDmSzDHNqN1FrfVjGwtda4VD8tQp2q2vqcFjwC
         fEQh7RjYlI+CRgYsgo4INXcdsC4QrVPLAQKIqId+aDrFj6JduAACsiCLjL3QOlfGgM6i
         5LD81zX6Fbqt0Birclhggf0sSd+hrkc+8XUjYk6URIft6ZOjQb+hzo6YzN1iUpqyssOM
         ar1HUSbQJLrvu4Jv+h7Hl3mDFOGkwSJxNBXdtjwebeO1zcz4RvJRpreQxUagCmniacLx
         0QHJGwOTs1J0R55gud3p0Hrxha9mWtBJdvif6tiNmn7FzWeyjra4RZ4dk/87QQtOxjQw
         Ihaw==
X-Forwarded-Encrypted: i=1; AFNElJ9Z3qerbtibKvOPn+x87zaj0UwMGHDpAPO00OcALMXUldIVeCQB4nRRd0BBfFubP6X2umYPpUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnjmtCrpcYudvHXP7f/v6++mn5nMhB4X+2mXcdFYKEfdjJiVU
	WmjcDWbLgufRjst0jYoSLIcShOSjFBjl069voZi0si89uPmu4dNhtz+GF5xQ5R+w6o0pcSoUJ1o
	NDqIbB0wtwEE3YTtrWj9DPz26gc1EADXhzeCZ1BXOZ9vftlID0Z55NpqQ/dc=
X-Gm-Gg: AeBDiespzNMcI4FLr+Agye29+UYCwGIY4nXwFnMaa7zy2FLiRchywMutXeiocOAoBqM
	mMtWU/jCNbqrhTWtYeVvk6M+q820J38EDH4aR/m9yM/PCUc+e+oTtthU8dNIAaXNjOSPU3+QuYt
	YBLERp7H1Vq5YR6SRU6cNnhxCzSj1+c/WmF3iK0nHmz/MmQdtzxKtIzMcEGrBK2msTVczCmA2Qc
	CRAMooSSSpeyixh0tAKHSFnjEkz/pTK5udONKVDU08ue+4MvFmWKZLB78HoIoiLDYuRUP+yZ9TN
	ZkjZ5Z8Dc6GtRzOnai9ygWjCt4aqHqFVTVWnF04MEHPUOgQT3+zWdyxXpdVSgeUhrDXxErs4Gwk
	B6cuH+lfwI83+lOVSOnAi4bEcW1XNTr5KLLiXAjbXsyNXZ0KacAduKpPXoF7uAIzUtDoMK5QS9R
	CpJatIgCEChbOKDHwdr4sFNf81
X-Received: by 2002:a05:6102:5ca:b0:604:f07b:efc0 with SMTP id ada2fe7eead31-630f8e78471mr843254137.2.1778141012931;
        Thu, 07 May 2026 01:03:32 -0700 (PDT)
X-Received: by 2002:a05:6102:5ca:b0:604:f07b:efc0 with SMTP id ada2fe7eead31-630f8e78471mr843244137.2.1778141012470;
        Thu, 07 May 2026 01:03:32 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc833e110fesm51608466b.46.2026.05.07.01.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:03:31 -0700 (PDT)
Message-ID: <fafc85f2-ede0-47db-9961-f34b2536a93a@oss.qualcomm.com>
Date: Thu, 7 May 2026 10:03:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] ASoC: qcom: qdsp6: q6afe: fix clk vote response
 type mismatch
To: Mark Brown <broonie@kernel.org>, Val Packett <val@packett.cool>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bhushan Shah <bhushan.shah@machinesoul.in>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Antoine Bernard <zalnir@proton.me>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260506204142.659778-1-val@packett.cool>
 <20260506204142.659778-2-val@packett.cool> <afvWsfgIz9Q-_cjH@sirena.co.uk>
 <35b45fd0-fffb-455b-b19d-5c29cc955563@packett.cool>
 <afv17gUZnHdXgyF_@sirena.co.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <afv17gUZnHdXgyF_@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fAELipS9A1aAfFH_ogBWP7uDgvbfLX36
X-Authority-Analysis: v=2.4 cv=caHiaHDM c=1 sm=1 tr=0 ts=69fc4756 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=sFoG9ZVZl0XijMoWAhsA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: fAELipS9A1aAfFH_ogBWP7uDgvbfLX36
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA3OCBTYWx0ZWRfX79YxGdqwDqBP
 53pezbShQ0UpDEHqs0sAsn2HNGsKy91bho7NsD9qX4HyXIpFIkvjS0X4Fx58K4rGFaZm3ReqUkD
 ONBIorAxNUPiu8MH8BO5BUtLT6jd2a4J5n3wBALi2E18oJFbL73ss74igTFMQyokl/s0GUYBO/O
 vpiIj6ZKpw0oGasIN+XMOo4Ws4vTLiIl6UouMrJxD2mznu0hg2Xizb2UJwvyCBcDxV3G/XZMWIw
 LQnqu3ARwBkFCmuVGCrDzWofyT0ExpjH1JuisNlqrWzqzQGkwID/72ZLlrYqjKDKDYT9ZatJkKg
 2eS2MA5NpNqUzfyd/tdqTWbVUtoqCgRzWwMang1+l4cuEH6Asj466rdkUHrz8+ByNBe71nwq8Fc
 SWGBTh+Xr0doo4541GIUJbheedetMofFa1aF4/S3rgbQ1gIvm/UDeN4VF5zf8613bSqZaJnGSMt
 9PmS7cV0BLOVLt9uxAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070078
X-Rspamd-Queue-Id: C50E04E4763
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244524-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,oss.qualcomm.com,machinesoul.in,fairphone.com,proton.me,lists.sr.ht,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/7/26 4:16 AM, Mark Brown wrote:
> On Wed, May 06, 2026 at 10:46:33PM -0300, Val Packett wrote:
>> On 5/6/26 9:02 PM, Mark Brown wrote:
> 
>>> Please send cover letters for your serieses, it helps tooling.  Please
>>> also supply inter version changelogs.
> 
>> ummm:
> 
>> https://lore.kernel.org/all/20260506204142.659778-1-val@packett.cool/
> 
>> I even Cc'd all(?) the lists, as usual.. Oh, sorry- not stable@ I guess.
> 
> Nor me, if the mail doesn't end up in my inbox then I'm going to have no
> idea that it exists.  You need to not only write a cover letter, but
> also send it to the relevant maintainers just like the patches.

(which the b4 tool will do for you)

https://b4.docs.kernel.org/

Konrad

