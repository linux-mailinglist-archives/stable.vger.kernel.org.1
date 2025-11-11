Return-Path: <stable+bounces-194470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61219C4DA9A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DDF3A3FE6
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 12:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA720358D24;
	Tue, 11 Nov 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gMXc5TrC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P8KERs7Q"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2635772B
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863891; cv=none; b=rRed1byYo1qlfE7GqWcfGx7DQAJjpHoueznOVsbAvrtds3VumUd6WLPtkby97mYVS+hAb+4VPdU69UEvOYhc4IUNkg8IVHn6hh6mjC78wDLadq98ugwcmVDC7ZF19a0YTYrB8W07u/q9hX7VW1O6ENHztBMCMvDBkcBftXjuFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863891; c=relaxed/simple;
	bh=Avw7X3qTk5ackyNEfBq4lhvArrupOq2YpJ4TzkN/XII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paB/TeOt++JBlgaVcPhDvVxengrmbS5XuLo3FVOpY5DXptx+X5edBTV7n/P+y9a1qP13ucHL6WkJiMoE60Qk2w0HME4lxKyzw3UjZfNkEFIq/pCl/AYUzNabN7T9nHEQrYi/kp49nR2So5L1ANuUW0TBPeU7cL33oZcAJcnicvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gMXc5TrC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P8KERs7Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGBTb2165207
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mHNhND58kME9CBxtrtGEGN3WM9sabE8JAt1u7C/HVV0=; b=gMXc5TrC2lD9urT+
	du95VzmXIYitWe+U2x9j71zg+PZrv/TDApG1hbwYGp4wjiZB2SBAAlHLvJOEZPP1
	89idFJglIo32nVBjzTo4hV58QRxb0DVmgLcAaXfzdDywk6u4MY6nOZE1+cf+PKvf
	VUBvn85+s//3vRaPnEAWxpcGj0D++0TfAn7tLQZKRvU+SLQwbQX5oCL11geYuOro
	4hiRL4PGH4CVNGfXS9J80DE1ik+33+kZNtQ/AVs4jx4aK1uHR4sbHYwo3GF/j2sz
	p2omw10nWpPsmvGbYN9BukhQ/ResGxdhc8dj7Nag8N0undIXtERwtruQI/39ZFqT
	LPFzjQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxhhh87n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:24:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29844d9e030so602965ad.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 04:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762863888; x=1763468688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHNhND58kME9CBxtrtGEGN3WM9sabE8JAt1u7C/HVV0=;
        b=P8KERs7Q6XNewMuS0JksUXft1WSRoJPfhRlSM821wht/LI1UeD9bUrXwOUrjA7Ex9a
         de9eFbQ+w94pF5rmpbTcvN8m5VST5fuKoPxcuQZFVuFkGMqBqVGt9kVIkqPL0bS69rZ5
         tAGwksq4JJ4jkfxx9NV5WMdlZhlMtHebO/iv+MGI/5nBnVfgmJ7Dvc0+k++yhGrDRyVe
         aFgcli+qs0RQSj1S7+5a4/Ll6l6jmRXhxCRuX3o6FWB7mKEzneOuIjkTtQ3sXYjbqvrR
         2ebZ/uG8tME3Idm0b/l7TL2i0PcBkptA96N/jZyZjfTjyr5iZ6FYzm19bjDU6/QwQYNo
         /7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762863888; x=1763468688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHNhND58kME9CBxtrtGEGN3WM9sabE8JAt1u7C/HVV0=;
        b=YYAd6CzxUB2DhcXV5KDU4EnYGEGQYS6frv8lJx3wTxX3oconMIDCJvLEkCP+BGOFRq
         fxWT8iaRAOdgWJL/fM8hfwdJ9dfl7M1HzEAW977Kg7QiZToUlrTBu4jq1iZqR8TV+BlY
         C74ZBdgWhu2B3a1wiKTQ2eCvxmfF+dgnTc6sXXKrK8ABJJy3u0J0RIGfSZXlwsrReGUV
         UDJa0YOGG9zUkeZMf4jUh7wTJtPYbXxK2Bl3uedhT/YBPMfP02Ziu7fPh0YMLhdrw4FL
         nAQhOqDo64c41uUEaa2b49e52EXrQakTqtG1ReNpcQ7Obh17y5DImG1UBbKoYg9ltMNj
         Bk3A==
X-Forwarded-Encrypted: i=1; AJvYcCVPJtAHAVT4C+0T1TYJH1c3ty4VnnWltbwfiRh+pdoqy6oX+mglwAF4fIJdYVV8tIPOqvV7JCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvT5nWS4cYHqjL0gDkjFF36TdnZglyWMNyXrjT2PFW3S4SEaeT
	yM3gGv+BfEngzZGarbBLSiynJZe1d4q/TW1KXC4w+5/ykn3pvzdm56Kbx5mB4IHFH64Xrj8ouU5
	pmAc5kSRfjsWE8WDdOma8vhe7XHwyUpH4dcdvx9hdgBDyVIpFB5VVPQ4sVXU=
X-Gm-Gg: ASbGncuJg9yfnm38EyMCk0xs5Ebuad1AwP+w3RMVPNkaOaYuTfQjOvGXS3Ux9ssCQxE
	ni1nvaeAnMeVGu6cggMGlKfhW1U2lTTwD1YG8CmUZKYqPVLAZ8GPWszRspJ7H8Avi28P7q2Ucxd
	VOM82KXm4FsyvOWI6e1aW5FtiRwa4pzJoddTJWilzz1LkMGqcBmqPLWw6WvTdpOVt8BMyK1nD/y
	xpFVLxRmgtBZsS1acQcDKWBe9qRkcO5GTnZFUJR1ezreWiPHJgeh6F+Fo/nadstwEnUbZfAykqR
	Y0/S8e+76xtXQUDtBqel9/wSXCrTX7fFsS0vI1fdWuLHJ36SjtE/95p4hf3CKksG7zUBMAnGKE5
	i3hmfExKM6OV3xg4b6JoH
X-Received: by 2002:a17:902:d490:b0:25a:4437:dbb7 with SMTP id d9443c01a7336-29840fee954mr19500145ad.4.1762863887593;
        Tue, 11 Nov 2025 04:24:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbcdL5X0IACg3A7zoRnqyk+K7b6Xue5ht0hWBXVIM5JAERQTpeICLLunHnEUY591aWR1Lc6w==
X-Received: by 2002:a17:902:d490:b0:25a:4437:dbb7 with SMTP id d9443c01a7336-29840fee954mr19499845ad.4.1762863887025;
        Tue, 11 Nov 2025 04:24:47 -0800 (PST)
Received: from [10.233.17.95] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b801sm183895025ad.7.2025.11.11.04.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 04:24:46 -0800 (PST)
Message-ID: <ee04e03a-ffd0-43c0-ba77-c7ee20aaac43@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 20:24:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_shuaz@quicinc.com
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
 <28ffece5-29b7-4d6f-a6cf-5fdf3b8259ef@oss.qualcomm.com>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <28ffece5-29b7-4d6f-a6cf-5fdf3b8259ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Pc3yRyhd c=1 sm=1 tr=0 ts=69132b10 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=F864Gg6nNBeLBzAGB4AA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: KVV13inibwosnKbuQtb7JPsofUkqU1Wb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5OCBTYWx0ZWRfX8j/LlHX+esRF
 aYS9dxJ/fFNmuBFOWqcUfCyq3Kz1FSQ4dPDPLhWrl58flS5hWOjo1kPwLvRXxYh1i43f/o2Ojx8
 DQj7JOaGsQPqZpwqRbfSW4WrohZAFTKrw0gC8WYBM3py+CIHEYXvRyF09WyvFIMN4hYmJZw0ekN
 ga9oBfvLUGMkZXjCJCiAzOkeO3AV6Xtc2NhlaDxx6HMCBc/NTKW/zua6stSbTNr+vA5MJpRxRoZ
 59wzDc+H0L6JLF0gAwCPTRNuY5X3RHZKtGRmMbNlaFJhIc0XCJxt2zX4Fu4o75vsgeQgNgDp53e
 4VGQW4EJmvHYJVPnikd7Dsn6sBG4fOZ0qPTVSxGYWUJ3CogiNHo37cdmp4dEj/GFEMQZPxMoRuW
 Wrg0OgopyHvisoX7hcZCEeSogoM3Jg==
X-Proofpoint-GUID: KVV13inibwosnKbuQtb7JPsofUkqU1Wb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110098

Hi Konrad,

Thanks for your comments.

On 11/10/2025 7:49 PM, Konrad Dybcio wrote:
> On 11/10/25 6:57 AM, Wei Deng wrote:
>> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
>> Bluetooth work, we need to define the necessary device tree nodes,
>> including UART configuration and power supplies.
>>
>> Since there is no standard M.2 binding in the device tree at present,
>> the PMU is described using dedicated PMU nodes to represent the
>> internal regulators required by the module.
>>
>> The 3.3V supply for the module is assumed to come directly from the
>> main board supply, which is 12V. To model this in the device tree, we
>> add a fixed 12V regulator node as the DC-IN source and connect it to
>> the 3.3V regulator node.
>>
>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>>  &apps_rsc {
>> @@ -627,6 +708,22 @@ &qupv3_id_2 {
>>  	status = "okay";
>>  };
>>  
>> +&qup_uart17_cts {
>> +	bias-disable;
>> +};
>> +
>> +&qup_uart17_rts {
>> +	bias-pull-down;
>> +};
>> +
>> +&qup_uart17_tx {
>> +	bias-pull-up;
>> +};
>> +
>> +&qup_uart17_rx {
>> +	bias-pull-down;
>> +};
> 
> This is notably different than all other platforms' bluetooth pin
> settings - for example pulling down RX sounds odd, since UART signal
> is supposed to be high at idle
> 
> see hamoa.dtsi : qup_uart14_default as an example
> 

I followed the qup_uart17 settings from lemans-ride-common.dtsi. Since these configurations are not required for Bluetooth functionality. I will remove this configuration in the next patch.

> Konrad

-- 
Best Regards,
Wei Deng


