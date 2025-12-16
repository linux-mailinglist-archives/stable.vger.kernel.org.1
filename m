Return-Path: <stable+bounces-202060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A075CC288D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53DF930365B7
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D35435970C;
	Tue, 16 Dec 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OunAyBT1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XJXuFp+w"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80173596E6
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886685; cv=none; b=r5QZcVAvpUBK1ecOnuIWgIBbQd2TW//PUsKmeM56yb5TpQrpwvBnU0gQRkVk/ciKcGhmX7JaJf4SVLdYMLGEppwxpAKxP/teyQR5X70e/aP/vbGKJcQmPdBXCFe0TqWBjdXiiCDkJFbmuK1fdPksCwN62kg0vS9HJhh/QxbCPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886685; c=relaxed/simple;
	bh=dmnlCl0YnRBwEuqEB3bnPJ/qfzwfwL4qVP9YEtkt1vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uY0wxF1AJnKhpM0IpNCY+ba0gzaqgV8895//nPy55s1fVw3XEQTRd9fYugR2lGvCU381VcnnUeN8XoIR2V7XBEgqevUaYzqDBEkSX6/CPZhk3MmE6Ilo8GMz6gGQcR39VXaCQgzQNZDBf6VWSMKk+jw77PfFNRA94KA+DAJk8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OunAyBT1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XJXuFp+w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGBvDa52810486
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/I3tyDCjCdF1wuwNszac8HmuXconn83YCBmI3hIHbI=; b=OunAyBT1C1FqBNKf
	vPBxvpvGlFcfznKxAueFjjxt9nNHW5TbUf6qHYhSIGe3kDffBCxgYKIonGGFJrQw
	fgN8v4RTp44g5eiyfr1b9+2VEZPOJBa28GswgtsnIv5zb0s0JumGF4oBW27+YYSb
	CGcPE8htk4aoeQf1XffzGvcMdv9MaaOBxFU3WgYbXKNRl3ksijZshJh+HwEaMJLd
	GLQ9UlF9y8IJRbWqO7AbWxX0gD3Nz3+ZzztpbuNA6vS4mTQhbDwHlJVNjm0P9nEx
	HvZAgyR2jKXZaegIN3YUjlDH7qjkvWtRX39TnALF4vcN4pFmoCabcOdKxB6ekPmv
	KCCIIA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b32gas80m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:04:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f350a08774so12481cf.0
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 04:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765886676; x=1766491476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/I3tyDCjCdF1wuwNszac8HmuXconn83YCBmI3hIHbI=;
        b=XJXuFp+w+z2/psBzP/lOpNP82nJ27lbJOeLzy+LoK6HIdfRfWp8ynRS4weh/mQ3vhj
         xP8sYoQgOAg/1ikZZLH8d31tHeDg9Ra9OvG/EX+srlrgo38qRxJY2Fg6A3GCuKjJ/LuZ
         dXblslMfPzpn5MU4UO1WDj5nOx1y+N1fZp6fixGVo66X7qI3obZB3/SDCzQOSfqGva3u
         DmnwsYxA1DpIZU6SmMRDfbVguO5/SGG668H8jn4+09aF+e+zDYWAvVANBWOcAjDHAMHm
         uvJlkJucxdDpuaZ1VO2AvoClHhUI/rdbpinm3yqsPGe1b5nGJlhO7thXy6X27NQMXPOi
         HVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765886676; x=1766491476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/I3tyDCjCdF1wuwNszac8HmuXconn83YCBmI3hIHbI=;
        b=OkkLPOc1vNqZxh0f7KpWABicCwkYXLVn/ia3T2fKFobbKiLNZgkG9ZXks9QXSViaWG
         +q3hbCk3EsILurfYRpqkjty8y9+/rG4dU66y7gVwmSfY/ANhjR3Xq3nNx3LgDXmSOhZM
         S4J6RQ6hZ/WsZ4HElYk3kT/0AErZv4YQlvJkOmv09Y0ag3YWAnPKaLbwJVKGBrkRtcoo
         HHKR70Zvyo3ZM4jINtq2tpzOOiq2ir1UtxHAe6WRp+k/yTjcShuzzeIxjJWZCLTmFQQl
         9hvjrcVDZO9hBq95UJgyfgzuz/2/2S4XJF0u0XvsDXjXAelEJ3YLwfAr+CZ2JnzM5Kl5
         W+lg==
X-Gm-Message-State: AOJu0Yxr7A83cz99oNWWE/XxA+PoMkB9kAN+/bHVtV/DXrdKzNmwjcX9
	SY+DcFxdKEb4jgGzulFhaQ8ijkeg56G6fh1csM3TMLOoUQxMh29mJeIBLxHbY4ShkiVHll0i4Ka
	Sj9kSIKZ956mAKAwxAiPSDhqHH0je+9fCKxemPHPeUxCv/sUlDUjW6H8FenP0AmC3lzA=
X-Gm-Gg: AY/fxX6S+MST3KYXBxLgUpccrzQH2RADeoyMFWEx3bUM/U5MtAvLDkLIBa0uTPGULOK
	ZUQRejyRy3l8ZxlNX6kOBciy6ru+5obXLeIp0abnIyEucN7Dm2CkQ3sET4i7j4ASmn0BsfZ4WwV
	FlMjHJz51ihfS8zwaaLiIl4PmUbA9F1QFqrlsmfupXBeMkFs0Ct8JxfS55nqwJkcMDt20n1vSs2
	UBNp1ZlZpLWAh7shcv2JTAbVyuhlraZvslLojeNodh7kysA2at6Ou3x6hXO6x5EEZhNAGkqxPDP
	3TSvJDGujd8MD1NcS3+hnrv/T33wqKx26XNT4UTJe/F8MON7umFAIvvahqzr5xWOgx1C5dhQ6A/
	qjgO9zdZp4olvdHIVVaP2yry6O7TrhX2iP7nL/yavVvF7+oBIHGgwgK2Nrtg6iCHnrw==
X-Received: by 2002:a05:622a:1116:b0:4ed:6e12:f576 with SMTP id d75a77b69052e-4f1d06629bcmr154040591cf.8.1765886676117;
        Tue, 16 Dec 2025 04:04:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY9HnP+l5oIztZQa0V6ppxNG9NRO5PPakgz/YURfiBpZ/UTTG/kTENu5LhC/HN4hjOrxg+kA==
X-Received: by 2002:a05:622a:1116:b0:4ed:6e12:f576 with SMTP id d75a77b69052e-4f1d06629bcmr154040231cf.8.1765886675592;
        Tue, 16 Dec 2025 04:04:35 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498204fbb3sm15938559a12.8.2025.12.16.04.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 04:04:34 -0800 (PST)
Message-ID: <b8087506-7cd5-48b2-9564-8788d55e0b08@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 13:04:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "clk: qcom: rpmh: Define RPMH_IPA_CLK on QCS615" has been
 added to the 6.17-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20251213100953.4148111-1-sashal@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251213100953.4148111-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vcb6/Vp9 c=1 sm=1 tr=0 ts=69414adb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Zl-5n85lNOg4vEYqP88A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 4qRhEB9-1Mkni82B8PLdeoGc5F7HjUyH
X-Proofpoint-ORIG-GUID: 4qRhEB9-1Mkni82B8PLdeoGc5F7HjUyH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwMiBTYWx0ZWRfX/VJkGLvdNFRr
 rbFKEXSro8cBAW4W1IH7a46/v/weDRCZqm19Sjn2uF0h7SzY+kbKl5kNXwLUb1xTs6AuHlFjOiW
 yrtArqhmeJ62u3Pq4bgrSzbuZGeTlY5IyROc6/73nTaqgf+Bw9CvXqeogUZziCpudQ39wkQzpb2
 yGoUf5Efbwha4YO+ArZVlR05OZIj5gkkr6zQUqb1OUSYesr0W7hw0zysmMyhCTyqQ641TY5t/s/
 Fl8Lc5HfIOtTaHcBGM2V4lH/AZaKzjntVjkTeaqQtbmsnZzg+XKIiXBUjZRazeQ/biqanTNGBbJ
 M6P9ilUhUahk0L2L4iGRuvrDAFNXF78/i3yPoZpCoJ8iBY66UOhUkUcGtWunYZDXfkv/D+usUuH
 JiIYHk88PG6GqlFm3lQhGE2xAf9HiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160102

On 12/13/25 11:09 AM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     clk: qcom: rpmh: Define RPMH_IPA_CLK on QCS615
> 
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      clk-qcom-rpmh-define-rpmh_ipa_clk-on-qcs615.patch
> and it can be found in the queue-6.17 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop from all queues, this depends on 

cbabc73e85be ("interconnect: qcom: qcs615: Drop IP0 interconnects")

and has no visible effect today (the IP block this resource drives is not
enabled), however potentially handling it in two places could cause issues

Konrad

