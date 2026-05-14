Return-Path: <stable+bounces-247108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMpbMKFVBWqAVAIAu9opvQ
	(envelope-from <stable+bounces-247108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:54:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5045053DC65
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 327F030391CE
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5DF3B8D48;
	Thu, 14 May 2026 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLXLvucV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CHeCZzGf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC03B83E3
	for <stable@vger.kernel.org>; Thu, 14 May 2026 04:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734489; cv=none; b=srjyYORI8yRUiTPe80I28FfMHTsSX7wEFQvv0rrq/j+fv71z6zaSC3DL4hC9CnB++z8N1tIsi07vUT+vPwupVnsvskqcBjHSPjPUok9f2kufYTdbr/e5S076rULgSAtvOW0koo6m9FkBK1GmNQGdndOnguHWyyXmBt9CBATq9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734489; c=relaxed/simple;
	bh=kej3RUhPAMLZrTvAxmEd3g12iVz//65laABXoswSdeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rejlv2KH1dacEHk6qsA1zK8V0ybrdLC+RauocdHTTUEVpFxCGWOKLCQf0K2LJFgwZVxfZnGEbkv60V0zpYfU+gw+hCiWrpdKce7ceTA6jNs7iaKWrmqBmSJc+k2G8YhoRF/t4+zRv3inbZY/jidSQH9zC3Yd0uqzFiVoYqpAimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZLXLvucV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CHeCZzGf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DNp5NX3474767
	for <stable@vger.kernel.org>; Thu, 14 May 2026 04:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZuLPtwpcvWP+BVIoZY2D5pGrjRu1PqelS3IjJR6x5/I=; b=ZLXLvucVCuKvR2EA
	cfvmI3H96Hc4yjIkK/XsZUL93fR0yHnNMcWX/ovEdlcP/9mDz9cBP7uW2eRlTEGo
	krf1OeTikpI6HNfEjAtwtFfRf8+l8CMs/xDP5QC98PkBM1NN61M6ubCNa+X9aqdd
	dyYyMkUfLwWyS8oAozzl2BoHPUrnUWb3jVdaQVA3x3V616GfMDdO5yr9uUsrVXKb
	fyzuc6rgGJrnjzwygrJy2AnqlkptngTGsPi4zXxf2IQKqcWofbruxNislX/LAd2e
	g1n6JIbhTLX8e1z6hkCdP9zlgHU0yz/bEOalhdkH0kAl8untSBAL6Cm51779qXbH
	wut09g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p41c26w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 14 May 2026 04:54:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b7aba0af02so79856955ad.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 21:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778734486; x=1779339286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuLPtwpcvWP+BVIoZY2D5pGrjRu1PqelS3IjJR6x5/I=;
        b=CHeCZzGf1Bh3CF8WEEhw6PwYoM1pXhbsc5dQ6vWk2CEiwExUvHSJpJa9Sfo/JpKtcm
         MVNC5YAG101L8/1JI3pXffou8VfyGplGSFc6FnpPS+Pcd9EocqSW84WYEhcf0rhOV/xg
         d2TU1OK3bbG2Zwx0aT3zf7XJhFSvtOVzvP7ESO1xyOMsr1lUdV0eDSSsEWWFkd0J8d4n
         O0099+Z24Q2L2YoBQmIBqFfUQxYRU1vKk5uRWGw6X4zG0d9+NZexRS2cIwaryEI/KMNA
         UQ0XyoGhWe1Mvw5oMC7v2MiGLAoE6S97QV5ATre4O3LoebbiIv6Y4/h/G6TiVH9pQQIU
         RxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778734486; x=1779339286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuLPtwpcvWP+BVIoZY2D5pGrjRu1PqelS3IjJR6x5/I=;
        b=DtoSLqnmIqNTg0E2dPKNFzurr034v+DrDtO8lj2TZ/hw5NZ/sUb+mFqJJn/EyZJLSj
         +ZW7ocBFfn9B9ZYnRJwac3Oq1Id4Pef85QZXWFQHmqtBaCAxuGrDRAV3zY/b2urJOuWP
         1KPuhxb3ukbvkdAqywr9vfXzs7LMOm0mfeysUKR3kRROW2VGnwEsw2W3mxidWet9/si8
         p4gwnHxtUb3tN/B5nfqyrhOE5u6xBZv7uBzjQaW7FfTBzu14tiR8SVPbhRG+NIK1JqzD
         6+jRd/Vid2oU3KhTIBFBhcqTcdRJ/ZThi8LzOMROf+vNUakMAIq/ctvF+J3Ib7F1pe13
         kt1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+wrpS49Iwzav0Gt7S04zsH5IesKmrrGOo4yYK5il1DYEszifSApz5oYqRG5xteBb+pFEjL1LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtO7WTPB3c3ntBQQ/SKk58FORSCWF6Il4I2tl5DTJY7rkCSEL
	lv3t0GcjpAF30qrKqnt05HMDKNyREHwEMdQyBeufBBzH/YtzzaQmRf7ADpRFu8CaBnJ234MbaeN
	HKS9Q9vlxT1dPA7IaG1a50yJS+kfXZoZKXxMWoqRc3T3LGMeYdqz3CGa3h0o=
X-Gm-Gg: Acq92OFaedEjDz9yF75IoW1+pub3suNmuLE5VIb9hhkaHiwjsv1Ai+jDeRLcpFxXdG9
	nMemwmZ2wIqRstBgMF5x6TKPr2x+UBNovSntg6inrnDF9HjHpQd6GusQL4e2JF/HER5W7T16tr3
	X7OPRfiFKox+arw663q5J9qmoe+kRvKQdch0Sqwhaod+0tGaKn2KaBWrSWmJcgb4Vm5oFgzw5TG
	2LtiQCGHJlAdtzFbdpIwX1Bi4rgbnHTk2EfZ0sT2t8v1wBOeSNTUuFuG0DKsE/iHmIn4La7xwFq
	zfzLJMHD09cVmsMr2Wct3Zj5dyldlMBMYhTQ2pB5D3MTOq7TVjY5e9wzWpjxWT2x2dtUjlf11Mg
	5m1GYT6ujjoKwMaJv2gSeZhHVBaXE+lBvMdyOvcgPkOf0PDGt357D3i1BSVJM04Lt88ZKLtGg
X-Received: by 2002:a17:903:9cf:b0:2b4:65d8:6a20 with SMTP id d9443c01a7336-2bd2f4cc122mr55750055ad.2.1778734485576;
        Wed, 13 May 2026 21:54:45 -0700 (PDT)
X-Received: by 2002:a17:903:9cf:b0:2b4:65d8:6a20 with SMTP id d9443c01a7336-2bd2f4cc122mr55749805ad.2.1778734484963;
        Wed, 13 May 2026 21:54:44 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6512sm9094395ad.52.2026.05.13.21.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 21:54:44 -0700 (PDT)
Message-ID: <324401b9-f6c2-4d2c-92ba-659f78b4ef6c@oss.qualcomm.com>
Date: Thu, 14 May 2026 10:24:40 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        rameshkumar.sundaram@oss.qualcomm.com
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
References: <336655c6-4dac-46e9-a783-549f0a9cccea@oss.qualcomm.com>
 <20260508103202.456865-1-jtornosm@redhat.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260508103202.456865-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a055597 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=M0CKB0vJUJO0TNvbIsAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA0NSBTYWx0ZWRfX7Do56CMVp44w
 zoDICvjKVUZCkiD8Gm/DYjtm24ngYYX07bdk3aegBnPNEs8somIGvZQEljlis3m2XEvEGW9A3ZD
 gRI9Z/10m6E4EDswzGqHdXcJVw533zXwjJAm+N2K+VqXkr+0CIqIl9p1fXyPNOHD2cpx2KORYne
 OeRgfyPPryuE0PSWdi1Fd4811qKU982dXOlcobMpBC1guiInW2+gl1De4wi6yZyDOf2eISmmFL/
 3QiF9rt5pFI/+Ho1KEcVs78NdRVp2rR/ZTQAhxQ7P8hDoMlNwz59s4hew4Y71cLxXS04dspNFCq
 0BzYhz1UQBi6NyF0gvsQNi0hGJSAQfeskdrFSODl1SI5oGY+CPkSlfB4H0tJKeT1VvUGIXvYoe3
 wWvC7s0FyTrNOftDKuq4RF9viRS/d3GAXi4jpk/Xm5hS+TApNruR9p+6FNntkGDjhJa1tSU3or2
 CIxXKoctgW3VM19BHXQ==
X-Proofpoint-GUID: agIm_nrGIaMri8HzQc1-jfOAGRNNLAvo
X-Proofpoint-ORIG-GUID: agIm_nrGIaMri8HzQc1-jfOAGRNNLAvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140045
X-Rspamd-Queue-Id: 5045053DC65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247108-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/8/2026 4:01 PM, Jose Ignacio Tornos Martinez wrote:
> Hello Rameshkumar,
> 
>> What is the exact failure? Do you see any driver error logs when it occurs?
> No error log, just the warning.
> 
>> Got it. I was just thinking along with the proposed fix — whether we
>> might also need to handle the sequencing on QMI failure.
>> In other words, do you think the issue(double free) would still be
>> reproducible if we include a change like below ?
> Yes, I think so and in addition the code is more robust.
> 

I agree that setting tx_status to NULL makes ath11k_dp_free() more
defensive, and it matches the ath12k fix.

However, i am still wondering how the second ath11k_dp_free() is reached 
if ATH11K_FLAG_QMI_FAIL is set.

In ath11k_pci_remove(), when ATH11K_FLAG_QMI_FAIL is set, we take the
qmi_fail path and skip ath11k_core_deinit(). So the normal remove path:

     ath11k_pci_remove()
       ath11k_core_deinit()
         ath11k_core_soc_destroy()
           ath11k_dp_free()

should not run.

So if the double free is still reproducible with QMI_FAIL set (with the 
change i proposed), either the flag is not actually set in this failure 
case, or there is another path calling ath11k_dp_free() ?


--
Ramesh


