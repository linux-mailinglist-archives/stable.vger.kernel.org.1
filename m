Return-Path: <stable+bounces-223216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id btPeJd6dqWmLBAEAu9opvQ
	(envelope-from <stable+bounces-223216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:14:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C55214455
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39EC2305766E
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6493B582A;
	Thu,  5 Mar 2026 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MYuEArvI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H18hMmfa"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1688D3B582C
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722783; cv=none; b=WU28ygyi5GZiKTJvLIi8MOb913YYHZ7rb4shcaVAHlkKLx9v0uu9EfjdqfE8zcqlYt/rAcA7pMNs62LB/z959dIGTLP5gH3lfj1epZn7974Fef/JHgg7MTdUOG1b6aIRYbyiUy+t7K/it5dk9oKWUeWeIJsPWzUSwr5Trz+kKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722783; c=relaxed/simple;
	bh=J2lbMFMnGYo6KcpMR6geLR+TBx5SW6z+n9kOHJ9ak+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h40WFdZaoLUlQBJVEDgM+huWsUs9VYr4nPt968O2f5aLthpOmTtQVRp7bELeMr3xFL40lcRoUn4/NJPZFkSBPdvyifU/ldtkBiyyj4GYV01PFUNNbxM7+IH6KruHqf4geg9wFPCVvG7sZT9bhodHyR1oDSwhbwUm9y/73nO7tC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MYuEArvI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H18hMmfa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFrTu456172
	for <stable@vger.kernel.org>; Thu, 5 Mar 2026 14:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SmnvSi+Mlmxa1/2IVU2T+BS0zKlOzWLnk6SgpB6s5WE=; b=MYuEArvINTLoJXn/
	5uRsYxESNS3mU0eg5ex/bV0qSOVNpejqqM+0NSrTM/9PrAj9giRpE7tLxs3ZWYFs
	Tq3t/E7uDBXw+RRfcFtOHukGf2rQoSJ0wX5wMt9P7GwUXf5iAmgUFtvEmDTV1BQu
	T5mEEsAmQVQCFyPhtu9SrB7+ZnKtA7ADmvyZ9w/jnKeHvy9Hux2cpOADjV66BFvW
	vcI1hXvcFRn6cxqcN9Mjzg4m4uzaMpZhqSBvDUfaC1H6OMfuupc+O1cExTSCyfZt
	m62vsrmeyyC5q1jB5p8mir57ZVUAu5m08vubsVGG0AhAgfFnu3PTXj+XNVi59vDN
	+xrkBw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0wkn48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Mar 2026 14:59:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb3a2eb984so5601283585a.0
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 06:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772722780; x=1773327580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SmnvSi+Mlmxa1/2IVU2T+BS0zKlOzWLnk6SgpB6s5WE=;
        b=H18hMmfa9AAXxi3tUB90f7umkSTsW0ibaHPVjl5IGwSteExRTMvTvIlLb61g25UYsO
         9qJrzsFuJiwz/8Cj1XNMaPMtKrG6RDF/iwaGnVaafxSQbe8WGWxVtiig3MdhtT7CAGy+
         cDjKqf+GBq4MoRlwMiNC1CvzQa0sA7XX4AkM5gH3HSeS0O9vFsiyDgYP/a1P0TG7LlFu
         MIzQ8gDs5WT++t29N52mus5igS9f7AQurMANZsTzFSMdRSfWXUZD/NBoH0kkhLqjOEMm
         KqVj24tZZa1CD1ZnpKzx+0ZVbJpOz4o0gjt0uaLa+6s3doyEetN7Q3JZmGKceq2zl9gn
         D3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772722780; x=1773327580;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmnvSi+Mlmxa1/2IVU2T+BS0zKlOzWLnk6SgpB6s5WE=;
        b=WJa2JzdW0bwQzBPbq03/OeeG7LkDwVRzACkRjtzmHG2BMJ6G8fgSmgK7xifo37ocNm
         eDQ99Hwn8kYmKBIwVTCkflfapdgj8Xf72k8cQLn0pj7KJn3IU6ghs6GjdF4harhSizp7
         adVxGK0aMT6F7a/tjq/HmUNXmxP6nITmk/PDzERYMZlLLKssIcMbb3izzxNFTvLgQwP7
         T/5JYw1fZSLiPeLHvgDpZaCudpCKIAY75JMQdK1qPYF+4x5gaL0Iw/UaPJUKM5Uuc1JB
         svHW5JLoX5bPdyrDVd7PYFtUXP7IzfvLrbfdxLfJF0EF+2F3LSqCdGFDkOfXiMRE+Hea
         9/Nw==
X-Gm-Message-State: AOJu0Yw1Ar8WYX0ValsploJuBytPfYBwlLbxz8AnXtI83R/1JFl9xK8Q
	Nu1KekcxtcG6SB3KOX9XGaYmB0yd1ST6aOGdZ4xJbIcsa6fpniRXGU1NNnYQPFxwiux/JLFztuH
	ULdLt+jn8BbmQoSFqXF9Eu8Ykaoz9Njj2lXoov0Vh9MtKAsagFAMI3LAH1oE=
X-Gm-Gg: ATEYQzxEZTWj/9BrIg1MlvalE21Karn3s3LCvpphgIX990/c+8q3F55VtvQeGrfkU3y
	hs57tM6tIuMnvTAueSvqmqJi4FLw2P/0V2jb2XyKOIwpL8/A6UHKvKDjzGgj+39CrqvRSp//xIT
	shvFzo2FIAF0ssuA9SaPS913Fg2CbIXeF2OdgwGYabcqHl+rPJ6gBQTB4rFVWTzzGJlsl/2z4Ce
	/VKgGY38IFj+m+m4wZ7Qecmqk3nW/G6XYU3aQ/E5kzf3jBXKoCjYwLn6yenVWMxnQeQkYLH0SLT
	Qc7ip69ngpNxb9cCIhxJiV7/pYNbirM6TkpxevBuF2trUwJL9398az2syJXQu5lYRhjIvnXJU9n
	3JXlGPCxriSb30TtOEQscRwancesGXqoaLhDGHLFF61d9OLd1
X-Received: by 2002:a05:620a:4481:b0:8c6:adfc:48f0 with SMTP id af79cd13be357-8cd5aefa21fmr710570485a.28.1772722780166;
        Thu, 05 Mar 2026 06:59:40 -0800 (PST)
X-Received: by 2002:a05:620a:4481:b0:8c6:adfc:48f0 with SMTP id af79cd13be357-8cd5aefa21fmr710564485a.28.1772722779676;
        Thu, 05 Mar 2026 06:59:39 -0800 (PST)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8d20f7sm36871635e9.8.2026.03.05.06.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 06:59:38 -0800 (PST)
Message-ID: <5b6a4284-4766-424c-9171-feaa08c52ad1@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 15:59:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ti: sci: Drop fake 'const' on handle pointer
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260223202426.566958-2-krzysztof.kozlowski@oss.qualcomm.com>
 <195cc8dc-8642-481c-8bdd-f5409ab8f5b5@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <195cc8dc-8642-481c-8bdd-f5409ab8f5b5@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VlYtdt4wzhoVNgIZT0nvkJdUGxKsjrXb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDExOSBTYWx0ZWRfX0mnIGqyatp2N
 WGALEizuvJnZdGO8nMO8KQ3X2RfvoljWb3/JD67VVkCUyUmP2e7cYlwTqDU0Jl1ri3l0PMjud32
 evDLDE9gPunxMVIR7R7BaJZ5CDFjKdg0ZbA3YxBwQVdlv5y+m8BxqEmCxT3csQegknWaadjNoYA
 lLpQQ6oz2T1eJOziRG+xTSD9/1cKzvA24LtqJ9tTyIMCy63Lbh4Q8jQkbos/Kp+yV0DV71sjfSR
 VxoL4jt7h2G2Q1dOOIY6PY1Z+82NrP0AN9tNKzR4Sx6x/Mh7YGd/JSDwQHIweV7naCCa1GFzeGt
 66u6V/fssqhW68XGkWQ0TfXCuIW6a/c2Gjc9Ph8fD/Hbd54gfhvSeV6TSy33wUGHJbYxjgM7ecP
 iC6tN6y5eTTYk1mBJ0/0XAkXRRe+P2mec1i/BuRy6W1mH7CKzDlBKzCU0mJXaI8S8YK23t9PGhf
 sWtpfmPCxP5lIsJiPKA==
X-Authority-Analysis: v=2.4 cv=OYWVzxTY c=1 sm=1 tr=0 ts=69a99a5c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=dua3lmL7_bghm9Z8UcoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: VlYtdt4wzhoVNgIZT0nvkJdUGxKsjrXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050119
X-Rspamd-Queue-Id: C6C55214455
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223216-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,baylibre.com,gmail.com,linaro.org,pengutronix.de,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 02/03/2026 20:12, Andrew Davis wrote:
> On 2/23/26 2:24 PM, Krzysztof Kozlowski wrote:
>> All the functions operating on the 'handle' pointer are claiming it is a
>> pointer to const thus they should not modify the handle.  In fact that's
>> a false statement, because first thing these functions do is drop the
>> cast to const with container_of:
>>
>>    struct ti_sci_info *info = handle_to_ti_sci_info(handle);
>>
>> And with such cast the handle is easily writable with simple:
>>
>>    info->handle.version.abi_major = 0;
>>
> 
> The const is for all the consumers drivers of the handle. Those
> consumers cannot do the above becouse both handle_to_ti_sci_info()
> and struct ti_sci_info itself are only defined inside ti_sci.c.
> 
>> The code is not correct logically, either, because functions like
>> ti_sci_get_handle() and ti_sci_put_handle() are meant to modify the
>> handle reference counting, thus they must modify the handle.
> 
> The reference counting is handled outside of the ti_sci_handle struct,
> the contents of the handle are never modified after it is created.
> 
> The const is only added by functions return a handle to consumers.
> We cannot return non-const to consumer drivers or then they would
> be able to modify the content without a compiler warning, which would
> be a real problem.

This is the same argument as making pointer to const the pointer freed
via kfree() (or free() in userspace). kfree() does not modify the
contents of the pointer, right? The same as getting putting handle does
not modify the handle...

The point is that storing the reference counter outside of handle does
not make the argument correct. Logically when you get a reference, you
increase the counter, so it is not a pointer to const. And the code
agrees, because you must drop the const.


> 
> Andrew
> 
>> Modification here happens anyway, even if the reference counting is
>> stored in the container which the handle is part of.
>>
>> The code does not have actual visible bug, but incorrect 'const'
>> annotations could lead to incorrect compiler decisions.
>>


Please kindly trim the replies from unnecessary context. It makes it
much easier to find new content.


Best regards,
Krzysztof

