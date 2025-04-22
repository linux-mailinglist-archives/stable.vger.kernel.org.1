Return-Path: <stable+bounces-135192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544EDA977AB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 22:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B8A1B62420
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 20:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964A2C2AA1;
	Tue, 22 Apr 2025 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qy8JDyu8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA62DA911
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745353942; cv=none; b=dVmTOml6QCeBxMBSwccNNhgDslI76Y27u4BDXBDlEYqOV6Zf57og5V9vgAMCBO8FUpNOMUAoPhyStZEmkTQT46Ul5ijsqE7reVE0D5hg3Qsiq6iTtKZ8LXF3nVi3Ji8acta0t3TD+MRv1IgkWYlYT8bIjpGtcdPFzQ9cyxGY7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745353942; c=relaxed/simple;
	bh=e947s7vj9DgAZEwGThYJOnOY/ENq4ZjIinQ423qwLiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YISZV48vpnzvMfjYgW6MfH/9Ih/QXRx5TX55JpF2MKmK9EId6llzbguVMVurt3GSatrCpILAdWOxZKnMXu1ABGxIIubtg0LcwOAlTIHBEs1ynit0evAUdRoLqvygLLAYyt9CPL80jExsYlF5kHtR7Dld7PPficu7G/UR12nqUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qy8JDyu8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MI6tjg022109
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 20:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p7fC+usINhtdyGIUDTo2++4styKlE/llRnmMJX05WkI=; b=Qy8JDyu80CYbPvtw
	GTGMzbXhTYQ+iSI4pRiVEcKB5djT6MIQWevPIX3khy68lBuQdpkq20po16TYgh8g
	wt/8+kR/B42urhicgpy9Ae9GTIcQjYZAHp0YitZLbdurIYslgpky++CRAVLjoGDF
	3Rb4fJrQ0DhzPHB+EBUKHpuIsVqp5kvm8HpSiUeof0De4KF3mxTg28WhfHvja7PR
	1TchLNtVxskBaQXCbwcrSuFBheeOtTvwNlKfeBZXDnOcyV32nuebMQwnkvCsuGbs
	apgyMQ/YVoeoq3komUzxBik2karBl6D30K+jwxPAilXHCD/CP/6U8ccryr0ru8u1
	v5cqPQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4641hhs56k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 20:32:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c547ab8273so45834985a.3
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 13:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745353932; x=1745958732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7fC+usINhtdyGIUDTo2++4styKlE/llRnmMJX05WkI=;
        b=Jqm55DQPRogFTP0I/J4osCNTtPCXi3ks1/k/QgEMcVXJMQDbu80QgBFqYOpSqqvXPG
         PHeoUH+Q7IY75zIiHTOYHifvBlFuCr36tWX0elm1lPl1ICQwBVLN44t8JwpabFb1lCQD
         hMJD9zRIggFwXe07fh9LJhvHnlprIZu2TxcPs3u9TuRCGf2+JJt9JH0zE1T4joI30LFe
         x0rewDtrWGJZflbm6g2e+6rCRaAdurW3oxyh/aNWSUTncdMYnofxnNvmkzKguXBgBe2U
         9b786HS8t9kASVeO6Un0moRXxBoJfqFeA30kb3qBOg0AlXIJDd7H48k/KTaaaCZ4v59U
         nHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPgWRJpN8C0GHRHxA+6VSlaDtcYYf7grTIh8jLXKeDYFSNtOMO9r24UtV2vPW45rBmk7TwGJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRLt6a92zHKjybnUpHjn3K49buBCT56FF0qhs08MDO+rUDz5Z
	DsKg9WFfHd5Wh80vWF9AbC9UTi909IL5jMmmdWkEi+607p6uSkoaPlVugiVCvl5xgvYmSSfGAi2
	n+jBkt8UKsRjVqPjUlTb4AILmmRZfhVaxBbxgW9LX8sW14wRGHJL+Voc=
X-Gm-Gg: ASbGncvPPnjyVRpdKI1K2cttqPuEQL3juegCClbdBLfaE4rNzNxtLlx3vcl7KMcPO89
	N7ObCWBcrXDGyRUSZn1pzDgOLTMaUdQ5KqurHMBsw1oHp6uyPnRdhz/7yLQq7MjMy7Zd0mlPtqw
	V3p8Uld2ztYlS9Dx4lhsr92Dt4lLrW9kpzaUcarukDrd/2pbW8/VYtUzd/Z6LCcCVFDyluC5iAW
	FonQ5DT0h5WgFI5PXaTPLzVRw8JNH1lYSc/CAVIs4IACue99H36m4/JUjLr3laHIPPz3Rc/Gda0
	6aWZtt5TOEBaobLdWo7hyG53Y59hRfhlXap36mLwJ7mFzL3txdRm1BpEOz2/vtoyChw=
X-Received: by 2002:a05:620a:19a0:b0:7c0:add8:1736 with SMTP id af79cd13be357-7c94d33c7d9mr38789785a.13.1745353932579;
        Tue, 22 Apr 2025 13:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECPN+gnhFLHpQ4DwkU2Hs6fRx+RAoCulz+9BV0umNnTLhXBZYmVSHmE2UV/CVMqwsUJthtKw==
X-Received: by 2002:a05:620a:19a0:b0:7c0:add8:1736 with SMTP id af79cd13be357-7c94d33c7d9mr38788685a.13.1745353932207;
        Tue, 22 Apr 2025 13:32:12 -0700 (PDT)
Received: from [192.168.65.141] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625834185sm6311589a12.61.2025.04.22.13.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 13:32:11 -0700 (PDT)
Message-ID: <e9f3ebdc-78e1-4e95-92a8-5ab97d6ede0c@oss.qualcomm.com>
Date: Tue, 22 Apr 2025 22:32:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Fix PCIe 3rd controller DBI
 size
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250422-x1e80100-dts-fix-pcie3-dbi-size-v1-1-c197701fd7e4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250422-x1e80100-dts-fix-pcie3-dbi-size-v1-1-c197701fd7e4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Fe43xI+6 c=1 sm=1 tr=0 ts=6807fccd cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=63VBIPp7KmuLgbtEyNwA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4inP4e0FAGbApuyQXnwH08XKaWiUhUqS
X-Proofpoint-ORIG-GUID: 4inP4e0FAGbApuyQXnwH08XKaWiUhUqS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_10,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=705 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220153

On 4/22/25 1:03 PM, Abel Vesa wrote:
> According to documentation, the DBI range size is 0xf20. So fix it.
> 
> Cc: stable@vger.kernel.org # 6.14
> Fixes: f8af195beeb0 ("arm64: dts: qcom: x1e80100: Add support for PCIe3 on x1e80100")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

