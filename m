Return-Path: <stable+bounces-247315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFRHAjiFBmr0kQIAu9opvQ
	(envelope-from <stable+bounces-247315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:30:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840D5548BBC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B31B2302F586
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706693ACA7C;
	Fri, 15 May 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D1q/oIgW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KGld77B9"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F130FF37
	for <stable@vger.kernel.org>; Fri, 15 May 2026 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812208; cv=none; b=BDpVI5aUBZ1AbHGdK1rajDWsXkWWD4tPQaZv6K/7isuahEimU6CvKy45Uc5ftMe5Hwn1dLgmUqPT75XVrJXeAULQkBJOE6H5INo/M7/lrJxNGd3wqRpjVr54Gy42+PiBdjKYGoUPTYOB3b/6o2hCd3PlfO36C5k5ul8CW1tkKOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812208; c=relaxed/simple;
	bh=6E3uQ5IU5bqGMKWEysYtGMYJL7+gGJ5E600OUI9cBbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UesI1cY+DXw/dnKdZeyB1PSQQ0O+jfHvKGsdxfh5LHn+b8A8VaWR/a11HbSacW7dugyy8NyWWQkpXKOvXTaANdzxfasg+rqdMXYdHbgBT60J0WE3yYlrBc1JMZ82raM1kK07fnzMDMpQ1Fk7WVrgAxgZEXaDc5BypEUof34gVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D1q/oIgW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KGld77B9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpDp8654942
	for <stable@vger.kernel.org>; Fri, 15 May 2026 02:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rrr4c6ZRkiE76n5t5mFlOMtG559/xFzAWj0L7OxzRTc=; b=D1q/oIgW5blnd2+r
	W4kHlLSYTjCweKYIHSqm6lDqJBeETo0rqj9HXvp3En3ovgASv8YzGXZ+sN4bZUV9
	vVz9ceSw3eNuI3F2TlvhTM5KHYLfYPQ4bssaxcg/3M/g53+nuHfUWhAT5Okn4Vlg
	FzonblfjtTmKeuAd+dSrGwl4VoQjTIXQxSpHvrQJlmOYw/R6LIeKSSzlaGlJNG5h
	0oDF9SFCojkBbmSFI51UhNyDM0Ha+tBg6BulxRR/PvAlsrGaQdu3Qd314IqHXHSw
	WVohzoKhkLGXJBq+kaRs11JeFV6L1oLPR0hDG4iXG1KRXOLRvu1U+gjTUHzq4QTb
	Xy2IBg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1ps7b4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 15 May 2026 02:30:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so7322712a91.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 19:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778812204; x=1779417004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrr4c6ZRkiE76n5t5mFlOMtG559/xFzAWj0L7OxzRTc=;
        b=KGld77B9IYRouQ5zEFFkiR4HunFqj+HbPwM8AigXlu72NPB1QYZU+Ge5133Y3g85j7
         Jn5JGaNTn0s06ix+8U/L0I99yB1Pthwzm9totFFE144LB+WOps7CN+5NzRP8b3mJQCRG
         /pqezxvAEr6gPDwTFNfd0mRCnakgVYjV4QMo77XGYicIAKJ3GMYIAcYScuR3CLcVM1mZ
         KsIbiNrsHkekPflsCgSSAxv9zKWk2NodHYhy/d7kaqJSlXp4pcUn3OkQLniqD9V46rdA
         V1XKTkrbDRssrc1SJrZIL0mQqLaud+GT1IxpgHuTgvdPOd4kh0xlRg7nH2BMK0sI3qrU
         a5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812204; x=1779417004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrr4c6ZRkiE76n5t5mFlOMtG559/xFzAWj0L7OxzRTc=;
        b=UqWypATnxds+XHAAsYKdn9SYSLnyB0+z7jlI11NEqWmvTGTiHnkBlfukAbqiVAwsgD
         HNQlsfe2lyHqhvA0m0Gxv5DSNHryywQ2Z4mK1IyqRzOv53oLQOYXygAARNgq0G1Jj29G
         YjBaZNP7iYqnpxOwS/7mVTs0Y0Zxi94Uvh0Z7YDk7s62xDXDEreTv2iGEziTSb8ZhWZ0
         gjBBI+CmFx9dRixwZWwGeBcOrrcd53ibsNWIQTovmw5xyDoTmKE4Z4WR4tsigUVj1wBy
         NyB3tzByv+QOCNnyFx1cyUNxUkmyfgMmHR8RJkMJabh3jpFk4uXRR4LcSHybRm27+74C
         1cKA==
X-Forwarded-Encrypted: i=1; AFNElJ/kCiNawwG+3RWjude4eKiubZEBuYciLNiLPaXNdf00iS6atG226YxhXIa0V+dfOYuoOkeU9LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUXdOPAjP13BCTkN49LoKYZ90dVrUEO3tsF2CLTlBtooAbdNi
	4rSSaa2AcTr1Xd5rJX7OCGW3VfK4eSAR24PoAbJtk9wsYsUui0saBU2if0ZVuw79U6txOT+3Qxo
	a+puj6fMz3+aqcNgMEr4MAj1HJK7BCwdgESZ7iGja3My7kIBPDpiXCoCcxeo=
X-Gm-Gg: Acq92OHMg590LXETFDaa3n3pMdkwEhjsyHMfh5dqLUgL9xMMbcMAvoIc2wUCNuDIdHj
	o1th2UqcrSQpNEEAAJImIWz+Ndq6CZa/rlY3qjIDS7wykN9iTe4tfKuDwRruJYz1jEc4hz9oaKS
	NgWD8vjGL8w3rH5U7Lbg5O0tHerPprmyaHNneIXOJRoYfKdS7fwBhhbpFWbOFEobinUGPCpf9eZ
	GjoW/9lo09nSfJ6x1JEJmZrE0aCCFbv/wRiTY8PJp0/MNkeyc52GnKYtqsJcQ0TfASOnwqxj7fF
	HL8WUWqeTpIjSaSpkXzv0v1qd9K9i/KRMxM2PmRGyD9ZpNdJaqn2vj7rjHQCuHyHA+hpLUidXM7
	ynqSCJFcB3Woz8ivj2RTDgoLS2/tDEEyWVLjE3VAMayV4TXXg37y5Qns5B7AOoIFPFcrb
X-Received: by 2002:a17:90b:57ee:b0:368:147b:536a with SMTP id 98e67ed59e1d1-36951b97c8cmr1913553a91.14.1778812204327;
        Thu, 14 May 2026 19:30:04 -0700 (PDT)
X-Received: by 2002:a17:90b:57ee:b0:368:147b:536a with SMTP id 98e67ed59e1d1-36951b97c8cmr1913510a91.14.1778812203805;
        Thu, 14 May 2026 19:30:03 -0700 (PDT)
Received: from [192.168.58.30] ([152.57.206.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11cbdesm41328565ad.71.2026.05.14.19.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 19:30:03 -0700 (PDT)
Message-ID: <5cf71052-9797-4dd9-a168-1c4ac73dddb4@oss.qualcomm.com>
Date: Fri, 15 May 2026 07:59:56 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: clear shared SRNG pointer state on restart
To: kfarnung@gmail.com, Jeff Johnson <jjohnson@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, santiagorr@riseup.net,
        stable@vger.kernel.org
References: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7P_gDwCF7h2bU0tuc6xzbii4bBToJ4n_
X-Proofpoint-ORIG-GUID: 7P_gDwCF7h2bU0tuc6xzbii4bBToJ4n_
X-Authority-Analysis: v=2.4 cv=GrhyPE1C c=1 sm=1 tr=0 ts=6a06852d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=YxPPAu78v9FaI4eag4rAcQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=xNf9USuDAAAA:8 a=EUspDBNiAAAA:8
 a=yURyTq39TCQ5d30jD7MA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=3w6iy9BqfFbDrj__1GvT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDAyMiBTYWx0ZWRfXx86lEkXn7RlY
 bPVSYtp/gxxzr7bNXEEXR4tkaOV4nxV+A6r5G6xhoxCkP0gZrOJ4gYBs8yY+TQDOCtlRa9otq9I
 hbFbT+xAeSY776/GUn6EvpwwbKbuLeSv1qy7glacgaWG4Rbnf3mfQGnVbnAVJUeCwicsAkl6TFO
 DbhsTB9xzW1Hzx7BTn6Zvw6LRgNmengk8Tk/L3MKqBPBxRb8o6R84Is9Jg219GV4SFtZgLy3kvn
 YhASYh3jMIGOemF/JE1KajElTUX3AXMNoiW4a0bLRVm02La/UC6fkt395VtHL8kWw9x3qFRsgzh
 MdvR8IRUZp8DG+EipvPWdsUiLX3kzkn8KJkIOgscVjIQT6GRhxPDbt1Q43PU1XHZgYcUCeirrA1
 tw+VuBesIoQ2ksDlt9OhIp2/+O/5+z22ArI1Ir9+hevxku9qpfLqk/3dq2uBh9LkyYBEHvxFeQb
 AoB0AQKwAohSvnlgiUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_06,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150022
X-Rspamd-Queue-Id: 840D5548BBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-247315-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,arm.com,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/14/2026 10:22 AM, Kyle Farnung via B4 Relay wrote:
> From: Kyle Farnung <kfarnung@gmail.com>
> 
> LMAC rings reuse the shared rdp/wrp pointer buffers without going
> through the normal SRNG hw-init path that zeros non-LMAC ring
> pointers. After restart, ath11k_hal_srng_clear() can therefore hand
> stale hp/tp state from the previous firmware instance back to the new
> one.
> 
> Clear the shared pointer buffers while keeping the allocations in
> place so restart still avoids reallocating SRNG DMA memory, but starts
> with fresh ring-pointer state.
> 
> Fixes: 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=o9wVcFMc6f-yhmSBcZqQ@mail.gmail.com/
> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> ---
> This patch is the result of investigating suspend/resume failures on a
> Lenovo ThinkPad P14s Gen 5 AMD with ath11k.
> 
> I originally proposed extending the existing ath11k PM quirk for this
> platform, but after discussion in [1] and bisection the issue appears to
> be a regression introduced by [2]. There is also a parallel report in [3]
> that appears consistent with the same root cause. This patch keeps the
> intended no-reallocation behavior from that change, but clears the
> preserved shared SRNG pointer state so restart begins from a clean state.
> 
> Testing so far has been limited to local suspend/resume cycling on the
> affected system. The issue was originally reproduced on v7.0.4, and the
> patch was also built and tested on top of ath-current with repeated
> suspend/resume cycles on a Lenovo ThinkPad P14s Gen 5 AMD.
> 
> [1] https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=o9wVcFMc6f-yhmSBcZqQ@mail.gmail.com/
> [2] 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again")
> [3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1132343
> ---
>   drivers/net/wireless/ath/ath11k/hal.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index e821e5a62c1c0..0c0aeb803018e 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1387,14 +1387,21 @@ EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>   
>   void ath11k_hal_srng_clear(struct ath11k_base *ab)
>   {
> -	/* No need to memset rdp and wrp memory since each individual
> -	 * segment would get cleared in ath11k_hal_srng_src_hw_init()
> -	 * and ath11k_hal_srng_dst_hw_init().
> +	/* Preserve the shared pointer buffers, but clear the previous
> +	 * firmware instance's hp/tp state before handing them back to FW.
> +	 * LMAC rings reuse this shared memory without going through the
> +	 * normal SRNG hw-init path that zeros non-LMAC ring pointers.
>   	 */
>   	memset(ab->hal.srng_list, 0,
>   	       sizeof(ab->hal.srng_list));
>   	memset(ab->hal.shadow_reg_addr, 0,
>   	       sizeof(ab->hal.shadow_reg_addr));
> +	if (ab->hal.rdp.vaddr)
> +		memset(ab->hal.rdp.vaddr, 0,
> +		       sizeof(*ab->hal.rdp.vaddr) * HAL_SRNG_RING_ID_MAX);
> +	if (ab->hal.wrp.vaddr)
> +		memset(ab->hal.wrp.vaddr, 0,
> +		       sizeof(*ab->hal.wrp.vaddr) * HAL_SRNG_NUM_LMAC_RINGS);
>   	ab->hal.avail_blk_resource = 0;
>   	ab->hal.current_blk_index = 0;
>   	ab->hal.num_shadow_reg_configured = 0;
> 
> ---
> base-commit: 54a5b38e4396530e5b2f12b54d3844e860ab6784
> change-id: 20260513-kfarnung-ath11k-srng-clear-pointer-state-91d8ab07e5e2
> 
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

