Return-Path: <stable+bounces-253466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNocHGS3DmrBBgYAu9opvQ
	(envelope-from <stable+bounces-253466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:42:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9955A0455
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3BDE300EC5F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5483713DDAE;
	Thu, 21 May 2026 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdgJ7aKe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K7hKTzeU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8F2BEFF6
	for <stable@vger.kernel.org>; Thu, 21 May 2026 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349217; cv=none; b=oNU19vU6ny/D7IaGD268byTbMi6ONceTT8UDqm35rxVSdc5M/hoTv1pELUCLN0e2cngIXcQgmTQpmpNyt+XMlt+xj12+3c7qzMSW4udyDKXO4kIvXQ8Wda2aJ50Bzv5sKS41EIZ8DqjqKlTqKhL9YK9aoyJo5tmGq6XkwdbDF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349217; c=relaxed/simple;
	bh=mnp0hDUMzsfuD8bK3qz6ZH9GHD+w1suz58/r0pz4j0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8Xmkm9DvVNbxbNcZ7plEUy5JIh1iwdeKYexTS87nhLod6DtFMT/4JTajtW7nQkvmHhGdIR5SO3D46P2v2GC0BWNKF/CArjq7HhFiIaDPnjfYtxNahQD0fepRNVYaq0ySzfmPQV0Bkp+T1jdg9BTxC5XqJVqt4cc6O0tCcFGnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EdgJ7aKe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K7hKTzeU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L2T2Ku3816667
	for <stable@vger.kernel.org>; Thu, 21 May 2026 07:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zJVuFDQsF4Iwfpmap+pWFBw4cYfM0g67R2E4BQtznhI=; b=EdgJ7aKe0dbx0o9S
	oswDIcris1MmJIdTlkWGyqwXmEyMm/3+tcV0c8RVBba2keOATX6VY1IK7+RhInKX
	68T0EmvjiVGxca3xv3eZLnruWsOkpD8IaTEebkgqbmb2gJI/DRPlOxka8RpPltRx
	kn8eJOm2v7YhxVfCX/7nVahcBv8XmSQASVDC8Jdk7bun1eBRHu6UII+Q/SfmIIJm
	8tuT2Hf/2AdyVCxdYCK2dUIiLdAFLLUI7zI7M/IyZCV/KH68mC0Z5T9NjJgCdK/m
	g0dbgmfs1x/0/vVsQxUAqDxXjW0K/cZ8PgWFUtvkpejH2LFhWivsL+vAMPCwqp7z
	gqQU3A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa11qd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 07:40:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so7879299b3a.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 00:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779349214; x=1779954014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJVuFDQsF4Iwfpmap+pWFBw4cYfM0g67R2E4BQtznhI=;
        b=K7hKTzeUefitX8Niim8JrJK3puF/pQ7MiQHQyCdu7F3jp3CdNxH986I88wTBCt9osI
         N36s3uP6RIXeWvokNLenBFtKNiKJKyCDHVclAlHGpRRF2DuQ2f7TLmVixzOY+APyc2aL
         yk1bxMxrTYYoRudED3yVz6+YuyCoupo9zzwo3TXXVXJJ4NIvPeKtCRLF7GMwMAhNBgnx
         CAkEbeDhI/uafbMYA2JKZlzm9pHxJs+3v7Is/pnj0e5vbypY+LISK+HKnUr3LcXBLhHw
         dqXGi8bLJEBEJJ+MgKcM4I4JgiyJwnQkkKVZnEd+LXR2TuR98/JqTmmjLO1iWRnk8zxe
         cDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779349214; x=1779954014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJVuFDQsF4Iwfpmap+pWFBw4cYfM0g67R2E4BQtznhI=;
        b=eq+LRzatGiOqxlX8wTGAe27tjS7nyT0PGtw3f4AB2CshqxZyGRjXKeJSEKNey/0qWC
         vtHyEjKNPZp9hJm5A8CNVfOu/+zt8UpvXnch8iGKjfl2ahEKLt3WupudLLxdWCQSEy+3
         P0vLJj8R+f0+pOYIaSziGPDSf+CdeOwkIKkbidm9cfIodAk3xmGn+wQI0kNWl/IwCyUv
         usvXKcsDCby+yq+7deXqXC+8zYj8TjcVL9L5O3lINXF0dgz47UcUySr0+0/PVkCxGgDj
         wZNH7rmITtqktulNUHzQiCgoVa8/2Q9ujEbEwVNf7VRC0fEXMdSX13RxpIQ13fZYyAVV
         rz3A==
X-Forwarded-Encrypted: i=1; AFNElJ9AfBYsACcyyNCnWY7XtRMr0Uxyf1jpAZCA+6I6Tk5q1TWHvr7NXIHCUdaZpWx4TpncSNxGiLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoD6xyXK4DT5CVEiKALp71b+bRCVfn68FBgwM5Ck7OzsevADVj
	Vv5JBFwzM5UwYYeXFEjWopiw1T1UA9V15MjJmRIiTs+BT7nGjtybPONFO8I8BHi1sqcPhRX1r6l
	J8Y01yjFY1HMaTe0LOxzATabycpAfD7j61zLnWu2hBZKsIesy1H3/KCALpLk=
X-Gm-Gg: Acq92OEMBnLMk5syNaMNgOxyE01/Tfd3rDfD+m+7EMgc3C9Tm+TM0bkoFD1G0BOzls1
	t5HBwa2cJkYIQDM+FriUT6wMhXYiIt2rl9VjTe5f01WSS2E03f0FcmVkvF2pZXDhRucwwg+m8Kc
	9VMc9eBzfHzbE134zJoJR0sviFqm65l1pOUiZ4hLsIM7erSkvEyRS2/2d/3dWzE8GRpD+tjmGlp
	l1dJ7t6Tfw6TC7oj3lTag0SerYnmWynaSHdWQUPY3GMbfgFy6Q51FP49sPmw5DuVNgL1xnYKNV+
	97cM7tBbVhJ2/n6R71fMv3Kc/3XurqyheaTtAEOTdBkO4x8C7LKH2UCa/esbOjbz9q+QhXr5FBq
	1Fyl0pSAqtDpW1dVCuWXJM/yVMJlLzfvVwL1FgutIKjPHR+I+YmRaXX5NOHzlVsHk270=
X-Received: by 2002:a05:6a00:4006:b0:827:2a07:231d with SMTP id d2e1a72fcca58-8414acdeba9mr2010670b3a.17.1779349214173;
        Thu, 21 May 2026 00:40:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:4006:b0:827:2a07:231d with SMTP id d2e1a72fcca58-8414acdeba9mr2010643b3a.17.1779349213557;
        Thu, 21 May 2026 00:40:13 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e22f1esm477039b3a.47.2026.05.21.00.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 00:40:13 -0700 (PDT)
Message-ID: <4979e748-ce4e-4244-8906-e22a1e6472e7@oss.qualcomm.com>
Date: Thu, 21 May 2026 13:10:07 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
 down
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>, o.rempel@pengutronix.de,
        kernel@pengutronix.de, andi.shyti@kernel.org, Frank.Li@nxp.com,
        s.hauer@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com,
        haibo.chen@nxp.com
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA3MyBTYWx0ZWRfX83o7fHchQ2/E
 xmCRP1xjpurLg7j4z3CDllkLz68duXxowOIKL/+A4CbJLXkq5D7hKUrZxomp8S427tDuvHEXs7l
 d1kcZR2QR1+TAQDB86LLo6TjsQLbKKIpCsZuPv2nX7eTsg7TKvdKt5CB3rNi/riHdC7py1TIIT8
 c3e328ku9zXzae0NHzvHMXwsjMcX2SM3NSiVKiKJeoOBJFKcnZRlt7G1Xx3TCaXgGi02QCKc55h
 4ztBRsmBSBC+DrUDfhjwUJ/XEkBaGE8mLQTs3JiF2LE9Gxnh4kJ0n9zGcTzodREyS2pu8bR9Vdl
 Ts+CgUrDaYINtaTntw7OdR6hcgzVIWEgSI6lJwjoS7tFyoVD05lu21eN+sUG0QW7ClMhX/o0yLq
 tMqQTpK35fa8W1kSbOf/9SjblBxFpqLmlXR6ooFMXU9N+yyE6Z2tnR5yQchrAGIer6OEnp/Ryi/
 y6nwQK9rcUEEA91IiuA==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0eb6de cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=KOk9-1IoVFRPxriqIuUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: I8_ZKfIgqQBwdk8Fgila9nYreibjw4MK
X-Proofpoint-GUID: I8_ZKfIgqQBwdk8Fgila9nYreibjw4MK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253466-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.nxp.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7C9955A0455
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Carlos,

On 5/20/2026 3:45 PM, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> Mark the I2C adapter as suspended during system suspend to block further
> transfers, and resume it on system resume. This prevents potential hangs
> when the hardware is powered down but clients still attempt I2C transfers.
> 
Code changes looks fine to me but have comment on commit log.

It seems, you are adding support of _noirq() callbacks to allow 
transfers during suspend/resume noirq phase of PM.

Would it make sense if you can write "Replace system PM callbacks with 
noirq PM callbacks" OR "Allow transfers during _noirq phase of the PM 
ops" instead of "mark I2C adapter when hardware is powered down" ?

> Fixes: 358025ac091e ("i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
> Change for v3:
>    - Add hrtimer_cancel in i2c_imx_suspend_noirq to cancel slave_timer for
>      safe suspend in i2c slave mode.
> Change for v2:
>    - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
>      to prevent potential deadlock if a transfer is active during suspend.
>    - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
>      fails.
> ---

[...]


