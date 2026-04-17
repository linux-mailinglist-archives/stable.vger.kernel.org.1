Return-Path: <stable+bounces-238501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLBgOXpT4mnx4QAAu9opvQ
	(envelope-from <stable+bounces-238501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 17:36:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E241CAEF
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 17:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4873104A01
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9269133A9FE;
	Fri, 17 Apr 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CrS8oMg2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fE9gv91i"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C4334C1D
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439805; cv=none; b=KlwiRfiDV9sVYCeb2jjogO5xxLS00QQzvzxeQM2DrMQvP1HHCNHAu+Q+rqusvvovWAZRX7SFTTGJUpMDfWgUer/nyar12dZWXZDOqNHFgjcNpYa95NhZm+9nVbT1xmgVG7l2bMOp0zYQSDHDS/IX94sDA5/oW1T0c+rKWIFjbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439805; c=relaxed/simple;
	bh=GMFw8UwlvWUDdGB4tOpqJjYQSXWL1VCmb5a+aZUVTx0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pc/X06s+Xu5wiBMAgYdOswkSxBj1avauzH9KUp6fvK9UPnXTgzy/35+iSI+eJSIvx1ODoiBXdFNO3PoICOkb0nFtTT8mcyN6v1LlaQd9MCGs1ykQCcS4V6tF3ge3sdF7bYAxyjwUyekS66deN5VMNQ2LYdgS04H1DLEfUv3ak2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CrS8oMg2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fE9gv91i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HABJix1323226
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 15:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C1RZc4rE6GguQQXCpB0wcbOaTb2Bi4UlZ5HuicWVuYU=; b=CrS8oMg2o47dY/Mv
	p8xTqV7huanvPDeI9l4dOGNQsIGBuB7WohisKEWPAlWn1k+Bpub7XgC2v3oip/u2
	Y+kAWYK1v/AlbPm3l9meCMwxNuvqH8JEboV+Y3GA6WJ+EZGJOJPutNfqVcgGZRU2
	NoarZax3g17DUT+IRq58De/KuiY+jcqie3Iz9WyK2mxt2nLjc8kEIE3v+gKMXjgM
	pelWcGLuTXnk53/HAJMrlszoxOIQI2i9QfyliHWaCfWJvTmEKztrJdMLl6RL9PE4
	bP4HKeF8LnbPhvATwhJ9s+l85Y2wOCR73ocz3xJaJn8gO5A1FjumJqhD/kAZD37P
	DcZ32g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkdgy2arr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 15:30:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b454cac322so7729955ad.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776439801; x=1777044601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C1RZc4rE6GguQQXCpB0wcbOaTb2Bi4UlZ5HuicWVuYU=;
        b=fE9gv91imnHg3KZ9PcV9k60SLkf/rE2SH+bqtF389cLe/Q6qkyrESOZhvblg1qiIQa
         31mk1mnVftrfW1pELV+OzCAOnPSeyf1iQzfbjuCQzLjt58nT4KudMRw2K/YxiPih8P5L
         rnT9yCCgym81/crIvNx7SmV9p989JB68wmR5PM0vh8p7ae74AEoMXNGmOFz0YLvTHj+T
         xvaoohAZMNgD2UOfU9V2bvGvbsrgVw1udNAR0TAmQ1ZxyGNNExqXuSCWXzyB6wAkb2cY
         bZ8OESKeWMAF3oxklgDYzmV546NJHQ7hZoEsG8Y+G43GyMtXE4MFDw6J4QsrKaUNhsBd
         xGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439801; x=1777044601;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1RZc4rE6GguQQXCpB0wcbOaTb2Bi4UlZ5HuicWVuYU=;
        b=O0OBTpnqSsmP00ZqEOe5QpJtaCGAt/mkcc9R3OSigEKCy3yxQbjvZNkFijSlFtsKpL
         OQbUD3uEqe2phxC/k9FSnMypM5oqwdpA7g4fb5z14giSS6ltRtNXh4CtaT2amjY/MDDT
         KK1vWZP7dBxOB9GzD0M9PicU8UZg+VLuvM/0oMg/4NgsUFwHPqsb5IfDmUDAI+mkvJME
         9AW1JjVGjOPch+LdBr6dE2Qu+rrMSSKewcpOb+nH15ex8zUu8o2Q4wFck8GlGFfxhror
         LPVEsPtlGq2PQW3YCMGngYQaO9ijbYGmyfTkagcqtr3iUWWMr1XvJ9UShOZEV1cxEFDR
         HmnA==
X-Forwarded-Encrypted: i=1; AFNElJ88PZLNobTC0xDHVAwC2w+9Tsy2IIsnYHs7A1hLGu+qDY/hEx5Ngw4cJDlkw7xk6vK2B6kDIVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjfHXDfsnmfyOOKKP/MZbfQv3DLeAqoPnV9RZJDS0hgfJ2uHQb
	QDRUnpAAUYduyJeHYnQf+kRG/eF9tikWpOgECLiL0adEMhb440B96Bj77SzK5jaP+U0kWfV8l30
	eUtSiSFsWSafn2tJk2wp3V9iPoFNYmv5XQSaf/pefvvnVCSn15ysHaKR5HAU=
X-Gm-Gg: AeBDieu/bzhkF+dVmjSZ6XYndSkiiZUu/SwKuFmU2OMkRKEZx/WPjO+YZWGxr/HTKCW
	qoPtlK9NG6zrRBtS7OIoqkilLDL0CrZBIW/XGKbkpEWCpg4QAMunKZlNEeEMYnyi1jLBPoFJXHa
	6KTAIm4fMUmk8l2VLF0HcfVqPvT1iYA7zM1MioLqhCT3FVycxcwvVJWqLkma9R5Jh9Cjglqu0gD
	eBlR7yokda6MPstp6+UtOvebWMNMpUM1K4uhuBlAHxhaK+h8nup1rqDMF4uhOS/ubK2BTrJBT5j
	TDXgUIh0pFDxYL+Sa/tiF0dUMMl0/W0piWgjl66cz5DCHbzpd4DjS4b+l5WAwAzUx5GWaMS1oqB
	ZiZKGPX2Wu1e3+cthtvTgxEm/8xzrQGnn8d0fU8gEpyhVY6PCK6COn2oIMy25zcSo
X-Received: by 2002:a17:902:c211:b0:2b2:d5aa:e373 with SMTP id d9443c01a7336-2b5f9ed0d19mr26411885ad.14.1776439800785;
        Fri, 17 Apr 2026 08:30:00 -0700 (PDT)
X-Received: by 2002:a17:902:c211:b0:2b2:d5aa:e373 with SMTP id d9443c01a7336-2b5f9ed0d19mr26411675ad.14.1776439800235;
        Fri, 17 Apr 2026 08:30:00 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab54c2dsm21664015ad.83.2026.04.17.08.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:29:59 -0700 (PDT)
Message-ID: <06395bd6-b3c6-fcc4-bc5e-9e4faa50fa99@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 20:59:50 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH 06/11] media: iris: Fix VM count passed to firmware
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        stable@vger.kernel.org
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
 <otikvdonnfakykra57z4fingdyfm7xebw2h3lmykzk6sbk7emq@xptiwpx5lvjl>
Content-Language: en-US
In-Reply-To: <otikvdonnfakykra57z4fingdyfm7xebw2h3lmykzk6sbk7emq@xptiwpx5lvjl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wUepDmlumOr3ZlCxbTh1SmM6FrgDy6BE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NSBTYWx0ZWRfXw2HHg/navUJs
 WolrlGWBa5IoeRn0TH7HXA1WUcICPZBYymD+x+d+Fzaisu1b8YJcbaSifn89UmSj/c1a+hl8FPg
 II8vFc+zRHABc2t+lCn8zxiwgqyn/1/7Pa9EGdwZiC7N2qVQEb/ow47Ye/ydvSZwhMFZ/sjpt0N
 Q3q19l6LrXXo/DgGmeGj8Gmi9FhTQBIV7QUZmSWuPZ2fdiEbUzAoAeH0vLOET7pb5cjw59UKbsj
 gj88wDAHkippzomxOC9Ec4xAq78bmkvc/KiLL9LijBNMvFECttDGLAtafKT4ZWJIEJQS25CTgWd
 ruyJ0GufIrCSNHGUq8tUJ4lRzjUPcOnVMy49WAHQfoMNPsCWt/1d6QkqdJZsHkz14Wlo+G1xoQf
 x0b8GFp5OENe0ZJv31gTXC6esPqJm3R8MR70KOj/w8u76G10IBg5C6DEY0h0eMRMxxcjpMQe8rr
 JytMR7o0jjnZtAiWqEg==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69e251fa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5Xy_6AgtP5T3jK3p2aAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: wUepDmlumOr3ZlCxbTh1SmM6FrgDy6BE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170155
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238501-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[busanna.reddy@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 361E241CAEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/14/2026 8:50 PM, Dmitry Baryshkov wrote:
> On Tue, Apr 14, 2026 at 10:30:02AM +0530, Vishnu Reddy wrote:
>> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
>> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> Does this apply to Glymur only or to other platforms too?

Only Glymur firmware is currently reading this register and other 
platform firmwares are
ignoring this.

Thanks,
Vishnu Reddy.

>> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
>> remove this write to leave the register at its reset value of 0. This does
>> not affect other platforms as only Glymur firmware uses this register,
>> earlier platform firmwares ignore it.
>>
>> Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> index 548e5f1727fd..bfd1e762c38e 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> @@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
>>   	iris_vpu_setup_ucregion_memory_map(core);
>>   
>>   	writel(ctrl_init, core->reg_base + CTRL_INIT);
>> -	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
>>   
>>   	while (!ctrl_status && count < max_tries) {
>>   		ctrl_status = readl(core->reg_base + CTRL_STATUS);
>>
>> -- 
>> 2.34.1
>>

