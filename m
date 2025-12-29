Return-Path: <stable+bounces-203525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A26D2CE6A6E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22ED5300091E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBDD27A130;
	Mon, 29 Dec 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BLoYEx1E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UWB/Dw0P"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25861205E25
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767010227; cv=none; b=Tbbjq0rvjfFAr0V/UZML4KuYM9NhlR1MBUQ4ZYX5n9ZkiI5pKpTSjtQqMhKByQY4ZyFi3uvQT4YhfCCyK5ITPhUBO4jZ8BFTLdLzULAKGLbCvSaXFLJcXsMMBz4LoXOUr1wTjMGDD8X99RewRmMqAQGduUAKxwQEpFLhx/PNwu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767010227; c=relaxed/simple;
	bh=A8l/+tDY4TSpp5rdRSoRXaPmugwLl49j/YF2EoHHkPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joJbkMAcMzKrJYq1CAv/h3ASEK7Di0k5aKKiGQQnXK4O6Yw3/jthRzCbt+07rJ8lNBXcaDK+59c579Cjgc23/9SxibvBQuUeF6yYxIG0kNwIsK2ix/kmV20Jg+G7eXAU3YIt7RsQ7TQ+5u41PGI92wZER/pj4Oc8d/9RUaSdR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BLoYEx1E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UWB/Dw0P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTA52tp956363
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 12:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UmRcezJoOaqIculwtm+fWIvmXsoW/ApmQVfbb+Mg22k=; b=BLoYEx1EISjcIZyy
	fpmNK0s13xsxN5PV8gfPO7I46X+5K4ieea1rJgAHkWBFDVwIEK23juj/Kl21VXPP
	qYJCszqcvo5Rb6VWvMBEbluZ00LlnwGOn+IVOtEbMW6hjRrXvw05dcnS3Xw/PdgY
	licow/pNbO7p+MmSuxt7DO60KBULfKeTSpujplhMM2baZEAiLXS0vGRrCj03n+Cc
	emZ1RW8JOaFkY4y5i86UDyviNdIHmRqVnfMQr/j3GpNMa3EgGTs23KLaDK4eDNPf
	nm+k6XEBwrim4Fw69UwAkHnGp08PgtJKK8CIdCZtrSdZxvBaYnd3w3LMXdicQA7S
	2fRNBA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbqk1876q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 12:10:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1aba09639so27019761cf.0
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 04:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767010224; x=1767615024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmRcezJoOaqIculwtm+fWIvmXsoW/ApmQVfbb+Mg22k=;
        b=UWB/Dw0P6tYqXlttQ1MpO9ZJ6gtln6lVXXztcdPE3nZ65+43K2Dnminvecf9FK7Y1g
         pizJjMTBt6CajjtzSSvt2WGOEU3DuMV6mIP5r8ce9PP4pOsvV8BUtBZusMS5U9YYS9mO
         i93acPVmuCocPufWSWODVlKOa8Fy8rq6NkOh920ypLN1KcwqHUQT9DZHA+IoESeljbgn
         jZg9te7gASoq8qZzvuAa6hxQwzT2xJG+TllocvDWMclqesVid84N7+qImvq4fxUyTKdA
         u4WtjEiHL+W+DSL200IJ8+s27UXzT/7E5MUiW5lFZ+8Q6MUYKPMtsV1bYRJsVvQzZPJ4
         X2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767010224; x=1767615024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmRcezJoOaqIculwtm+fWIvmXsoW/ApmQVfbb+Mg22k=;
        b=px3Z2M4TIo8mIFED2SNgyiZJdfyncAVqKNdQYT08O+PCgsviz7mSHuNw7VeCzpUleI
         mE5ccQFdDMvlxlUQaDDVcgdJ2A+SAOeli9FOtE6jAuC9ebQYjbN/FgSTILZJiYIFGvuS
         kWe7sbOpoC0ybPcU6I1V0Z27iXZPo0GhHUKCTk6E4H79Op1HbZFsth8I4/6dz/PJMhfi
         9dFRz7Ckd6vIYXHTZVx1rKBnSMK5BuhemTmqT8VferJ1r80p7bzb2ibHsDoz/t2aH0+b
         aZRI9fSwe9MPu4RPgbjAEQYgtqMaeipj+Hn9K8Gf30qloDXyka311RDaEdQ5UlCfpyn/
         S/MQ==
X-Gm-Message-State: AOJu0YyNdIRJ4znFz4n+UiQw9ApsyCNKZSK5sZRuWWhG7zqq19cFd0PC
	oS7z2l9oBUDoA78H5bEdBakxiBiZuxheSuM9yp1+/VPlACOFabMkgo+DLEtTd25wqtqL1bxQQWS
	ZNZx7kPbzhKiSI9f1uBP0QV+7fzkWIu3SH0UI1GFTyI9j7T4I/PVn1fdYfhQ=
X-Gm-Gg: AY/fxX54mSybLpptvEwmCKyM/U2Dad4jEVwzk5+G6GkOLTpOju6hWbn40Sz0tc168BT
	WV8jBJo24GjbQguIlFLBx3Pqgv9tnBGTULqtA4A0DNsi5PZVnS88cdzPSM0UQGIcH1siinMeYTs
	RMZyWStEud8phDtVTM3lRWjDZVluDBeMrFuN6Z1HHx/3AYS8kSIhPtBdz7jnCdOOpTOXfYRaMwv
	DIiA/3yoB/a3Rmeviwe1H4PH0wEk3wiNCNAalHbE/nmaXoZz+1U3O5Jks2LClL5pKHlHqYGWZvQ
	rsEoI8C33+6DAZRnL9mJpDjeJp8/MokkiEpC0UgWD6xp0mXZmXtBJMbpFWGIpnMmcoMFt6glVKg
	PRx3bOSkoOgrQdOK4Zm4/EUP8xYRU9PJ5hJp0cJSh/lUtTjkHoNtS83GLH18dvDd1tA==
X-Received: by 2002:a05:622a:1920:b0:4ee:2580:9bc5 with SMTP id d75a77b69052e-4f4abce1e37mr308986391cf.2.1767010224111;
        Mon, 29 Dec 2025 04:10:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMKnFdxvstgWTORVPMJFQFOVOtZCz+Jhu7xlTUqWcjCXkeMyACTrlFS4i7qyXEw5yTNfv1NQ==
X-Received: by 2002:a05:622a:1920:b0:4ee:2580:9bc5 with SMTP id d75a77b69052e-4f4abce1e37mr308986151cf.2.1767010223711;
        Mon, 29 Dec 2025 04:10:23 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a60500sm3289805666b.13.2025.12.29.04.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 04:10:23 -0800 (PST)
Message-ID: <fab117be-d9a1-4f4a-b91d-e808c50960e2@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 13:10:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: qcom: sm8750: Fix BAM DMA probing
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251229115734.205744-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251229115734.205744-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iEfvFplxiZ8WQwcAw2yXrQVb_bbJC2iB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDExMiBTYWx0ZWRfX0ccow4oFMVca
 jAUpsYnXAoB76xbJVHZasvh3TI5yeh3YAgNINy9Wr6loOozFKvr2j4hvl30JjCkkP0ZNpNFqocB
 oMahS02C1JQTBuklkQBuFEpGqy/Uh5TMRPw90/cDw+JJiCQb6ADzRZDLwY1OTSJkz3Ta9NdXhet
 I+lb1lBr5LNi0+/BJxJUfPpd1tuJ6ASTIvpU62efx81pmoQgjE/l8PJh+SsRKf4fhllHyr+RprO
 +VkVtwELJqhcB1+DmxMZGUYji80cwAtRjlEFbqfElRhTJB6pGCzrvoM4iHZcqed2PA7FufkcuLS
 LqxKd0X/XOBb/nWvMY+1ms/sa8J6WQSqXNabEJo5bzbcN+MtWvNceKF7iI22pmEUZPLZNdx5O4r
 HH5PjiAGnG+PnEmEbNWTQwF3h2d9FF3rHkLMK1RiSh8O1yyW9PFQLPAVf4mSLVMWcWJjn1VsQ28
 8E0bRYqFwXwhwzdQmZw==
X-Authority-Analysis: v=2.4 cv=Tf6bdBQh c=1 sm=1 tr=0 ts=69526fb1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=HqMmv6ACb4lSiKHDWTEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: iEfvFplxiZ8WQwcAw2yXrQVb_bbJC2iB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_03,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290112

On 12/29/25 12:57 PM, Krzysztof Kozlowski wrote:
> Bindings always required "qcom,num-ees" and "num-channels" properties,
> as reported by dtbs_check:
> 
>   sm8750-mtp.dtb: dma-controller@1dc4000 (qcom,bam-v1.7.4): 'anyOf' conditional failed, one must be fixed:
>     'qcom,powered-remotely' is a required property
>     'num-channels' is a required property
>     'qcom,num-ees' is a required property
>     'clocks' is a required property
>     'clock-names' is a required property
> 
> However since commit 5068b5254812 ("dmaengine: qcom: bam_dma: Fix DT
> error handling for num-channels/ees") missing properties are actually
> fatal and BAM does not probe:
> 
>   bam-dma-engine 1dc4000.dma-controller: num-channels unspecified in dt
>   bam-dma-engine 1dc4000.dma-controller: probe with driver bam-dma-engine failed with error -22
> 
> Fixes: eeb0f3e4ea67 ("arm64: dts: qcom: sm8750: Add QCrypto nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

