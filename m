Return-Path: <stable+bounces-240439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFsQEz3T6Wm9kgIAu9opvQ
	(envelope-from <stable+bounces-240439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:07:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE61E44E526
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A2BE30182B8
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C43364024;
	Thu, 23 Apr 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ogLZ41lT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vlv74BbY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19182363096
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931634; cv=none; b=tZjHfc2qXmwTELy6fD5lo7rD/BpV9b8OMmitukeiV0vIbkJi6s/ZNxkDKx7ZyoEexn0LfqyxWVPLAzXCjUjssW2JQ8wrfAuuSxfWrO8NsRlNj4z2rZ7WdiOPnBtiODWcL7mN4ABRDP+PeQbL7wzwAAJhI0xzeLM+ia4UjdxIH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931634; c=relaxed/simple;
	bh=9+0W2VWdwc2cB9MzpKPzLqvQtBRd88DboztIZvW7wcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrUlBoOZPo/qDi/0dUpkGlcd67mwisnsCnFIUd4lzMWWYFoSQPXBQGzEpwNHcxR9hbZXVFsmKBuFDA+GYuyxhCS9o7u+Rd2tTLYUHA10eDUz1OVGkDqBuJ7cXlSoJFOtkp1X8O2nVvNWlfAEeYSwh4KPEdleYt+IH7fr3PJS2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ogLZ41lT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vlv74BbY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N4DY061218425
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 08:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5cA4KLyFriM7ec4/EYZtlcwbpyBshVV3+QDW2hRa3qk=; b=ogLZ41lTaJKrurR0
	LMjZ7doJ63U2gowFEBxYYJC1DtJphoGHOdgmLh7yyncX41fP374tLPyAfH+el4JK
	WtSzbM/mGa5NRX/dE28zlfqPupu62h2WvBa0SxpDqtHnriwrTJWsDEijVCWINHGR
	WWCRiq/V0wHBnuD1wMhOdekBOZ1ebglFSkgPNYRoPiw84FzHHiCChdcR26NYud4s
	GvG8aGEHxRYhVum8JYomLllzOlNCVxi4AznlEj7xjz2DHn9mZswI+pKu4/kxqhir
	ypuXg0RU6hWfQ8cSxy7FL6Ysh9A7GjSP2RQpx6jvyLc1aWLH4DDPc/hxI+se2ICv
	dQ6TaQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq282tr2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 08:07:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so89203785ad.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776931632; x=1777536432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cA4KLyFriM7ec4/EYZtlcwbpyBshVV3+QDW2hRa3qk=;
        b=Vlv74BbY4QdkTODBnb4e7ta2bz8Td8Gd8D4eKHrzaA0/C6MS+s4X5Y8XR7zeBsIWu7
         TXeSOF01VBvEroXQIII0GYK+toyFgnSlbnhMW+nTKLmNIZ1GXqkJrvPAdhmSzBSxPTG1
         tuEkj1o4WqWRQU8zBK1aYfDYIl7/6mj4Q9+kyTCIttCAW6+2TpktO/Qwt4DcIVs9+3eZ
         JZftFpwTIn962QF8/KivkMakahY1tnsgBaznaxSzKX65v7Cgfw+wu7ZnvW58E9JEVzHC
         5Kc1W6dPODWWNags0r/CvzOUnXOYHcN0I2wExxR/3LGn7+3SUzK4rhRpyMRooBUvjA29
         RDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931632; x=1777536432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cA4KLyFriM7ec4/EYZtlcwbpyBshVV3+QDW2hRa3qk=;
        b=ZCcvdUyS7xjHf+4Uilp88yOsEQSN8n+AbdMks9866d1O6n3KJCyixWWYAiLQkyJi/A
         Zkt2iuAsUlsr2E1rzhWx65J9TuJYZLvsAZdmtUR+E0MS3+z45rNATbAZ3YS/as8m7eMf
         27k+GGUQeK/49vsY3rEcBB34eY6NSofEnyDLcs3d4gOi7F3KxDHBDE+e3sVGfFVtrF9w
         FBq6FkV7r47ZZnoMX95rxKEkH9llhVZ6L4BlmduWZnpHxVfdmptfeInH/j1UJ8Ttag2W
         Mq6PH79PDZd2vWubzAUP1tF5PXOOLjT7lgTEla3pUHhBZ+zknMCA6cauOvrFZ87jFKvF
         55mg==
X-Forwarded-Encrypted: i=1; AFNElJ85yF0xr5+V+ulUEEAHZ8CNiVHdb38dsyNd+07LkQ2TlU7ckETd7pmabaAZn6NDU0Mf9lbRcPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyGFXbFbWKdza9cLuv6tyNzC0Nhx2rl9CM65LXv3zpSZdcKWre
	XNIePG5eInBSw1JgU8OLIk+e7s1EMuHS3/PpsLmU4dOmfQe/1sKWarMmHoMtfBEtdYkWt70oqXh
	6aF3wj2k1mdsv5gSVZWI/rdVb2lHtkz1V+WiHQAMzEL6qIkTUznWzauJHuTw=
X-Gm-Gg: AeBDievBD0x05TMDM6vDg6oF0QVMVAo4Xa2YTQ01Nppwly8Tt37SPawjtHQ6DwgV1J1
	bxmpjJDkGjeSH91bg3UZqMv7wMH4yh3Zny+DagMmpiHjcs6xfF5FQ4kiX0KTP0+G/U3661B2NEx
	B8WT14Lab4QzXrAAC5DpBxRYJXRXGproAalOAIm6MUwQubhxFxX387wpg65bzJEstu39yo1nRdJ
	ag6v0RBPLXjqabHYPokpQ5AVjCQZyxR2XJbNv2fGMWb8PF1vJ7hRjA5jYHEH2D6Tt2HmKuHLN7x
	5MYJEbAYJDpMR7eJQtpOB9yf9aydhhnHfdiRx7eltnE7ICcrh1wnVpQH3VTablcqvVCMhDJzHZl
	sKAIVLg5XweaK6sQ882IUsCf4lE7XtD33l2HhfFM/hoBQqOH/AiaRLVg+eP/G
X-Received: by 2002:a17:902:9a4a:b0:2b2:4eec:9806 with SMTP id d9443c01a7336-2b5f9e78234mr194281265ad.8.1776931631553;
        Thu, 23 Apr 2026 01:07:11 -0700 (PDT)
X-Received: by 2002:a17:902:9a4a:b0:2b2:4eec:9806 with SMTP id d9443c01a7336-2b5f9e78234mr194281025ad.8.1776931631021;
        Thu, 23 Apr 2026 01:07:11 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab30f29sm185133235ad.68.2026.04.23.01.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 01:07:10 -0700 (PDT)
Message-ID: <6e8f523f-7ad4-4472-aca8-118de81223e7@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 13:37:06 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: hamoa-iot-evk: Enable retimer on USB0
 port
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable@vger.kernel.org
References: <20260422093924.2976069-1-prashanth.k@oss.qualcomm.com>
 <6c2c5fd6-c032-4658-9a15-039c77074c4b@oss.qualcomm.com>
 <8cb5e28c-1c6e-450e-855b-32491ee73885@oss.qualcomm.com>
 <3d50f17c-060a-4a1d-b539-1bea9b3e6cd0@oss.qualcomm.com>
 <79926b02-a892-4e59-b794-e8534136fe07@oss.qualcomm.com>
 <efa2da27-79d3-4cbe-ba3c-2446c6252058@oss.qualcomm.com>
 <hctf2vexnfd2lbnggvoanm424rmpzadg6daqq4477audy6mu2e@nwyp3ijbhay3>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <hctf2vexnfd2lbnggvoanm424rmpzadg6daqq4477audy6mu2e@nwyp3ijbhay3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA3NyBTYWx0ZWRfX0Uv3tf82pcWz
 tKIEsMhhYAyMOMluT4Whc7n9MAGyb/OjVjH8QSkMn3y6fcDvYrL+7JI1P21NSqcfHxgNerNz6Ti
 1chPL37irw+NQtU9V2u0eYnHJdkEZXVmxGqcwJ1kCbpspWmN8BcvjSr65l9NAt7qCOqCnwgX2P5
 a7Q4r8lYnaynH4FEP0dVa6gtTGLeTWJBRIjkupkxKZSViB3dvjB/B3/ALcsKF7symbQacr+fUlw
 BSF0Pz1z+ZozST7/kzl99P5f+EJUOs/sX6RgwGOhKDfa2pSor47LP7cd6XDkcWhTZ2lMqQonhNP
 1hvQKx9b53qu+bBPdD1oLZUh0iyCHzWNeBaClbYXNqV/Wds0istmeLbBIb9mXdv9rrvlOZNm4wP
 QRluuQ+Ije9DgIad+sVFI3HZdG1ce6ISkG8iDGZ6OLrnFlt48aYQBMnQAZaqsNQTp9i5qZHEyAX
 1tkQlXKt+vlTn1lWpmw==
X-Authority-Analysis: v=2.4 cv=Zond7d7G c=1 sm=1 tr=0 ts=69e9d330 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=BqLQL_UPtuLX997o1IYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: w8JZDYQo2OxXvg57gg9htPuV7JQYFxC3
X-Proofpoint-ORIG-GUID: w8JZDYQo2OxXvg57gg9htPuV7JQYFxC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230077
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.2:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.0:email];
	TAGGED_FROM(0.00)[bounces-240439-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	PRECEDENCE_BULK(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	FROM_NEQ_ENVFROM(0.00)[prashanth.k@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE61E44E526
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/22/2026 5:22 PM, Dmitry Baryshkov wrote:
> On Wed, Apr 22, 2026 at 01:09:22PM +0200, Konrad Dybcio wrote:
>> On 4/22/26 1:04 PM, Prashanth K wrote:
>>>
>>>
>>> On 4/22/2026 4:13 PM, Konrad Dybcio wrote:
>>>> On 4/22/26 12:32 PM, Prashanth K wrote:
>>>>>
>>>>>
>>>>> On 4/22/2026 3:56 PM, Konrad Dybcio wrote:
>>>>>> On 4/22/26 11:39 AM, Prashanth K wrote:
>>>>>>> Add the retimer for usb_1_ss0 port (USB0), in order to enable
>>>>>>> super-speed enumeration on that port.
>>>>>>>
>>>>>>> Fixes: c11645afb0e2 ("arm64: dts: qcom: Add base HAMOA-IOT-EVK board")
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>
>>>>>> This is a feature addition, not a fix
>>>>>>
>>>>>> [...]
>>>>>>
>>>>> Sure.
>>>>>>> +		ports {
>>>>>>> +			#address-cells = <1>;
>>>>>>> +			#size-cells = <0>;
>>>>>>> +
>>>>>>> +			port@0 {
>>>>>>> +				reg = <0>;
>>>>>>> +
>>>>>>> +				retimer_ss0_ss_out: endpoint {
>>>>>>> +					remote-endpoint = <&pmic_glink_ss0_ss_in>;
>>>>>>> +				};
>>>>>>> +			};
>>>>>>> +
>>>>>>> +			port@1 {
>>>>>>> +				reg = <1>;
>>>>>>> +
>>>>>>> +				retimer_ss0_ss_in: endpoint {
>>>>>>> +					remote-endpoint = <&usb_1_ss0_qmpphy_out>;
>>>>>>> +				};
>>>>>>> +			};
>>>>>>> +
>>>>>>
>>>>>> Stray \n, but you should really have a @2 port here as well.
>>>>>>
>>>>>> Konrad
>>>>> Can we ad port@2 and leave it empty?
>>>>
>>>> Why would you? Just connect it to port2 of the connector under pmic-glink
>>>>
>>>> Konrad
>>>
>>> Because the port@2 of pmic-glink (pmic_glink_ss0_sbu) is already
>>> connected to usb-1-ss0-sbu-mux (onn,fsusb42). This is different compared
>>> to other connectors.
>>
>> Are both the SBU mux and the Parade retimer present on board?
>>
>> The former is redundant since the retimer already has a superset of its
>> functionality, so that sounds rather odd.
> 
> fsusb42 might be also used to switch SBU lines for other purposes (e.g.
> for the debug).
> 
I just checked, fsusb42 is not present in evk, not sure why it was added
in the first place. Will link the retimer port@2 with pmic-glink.

Regards,
Prashanth K

