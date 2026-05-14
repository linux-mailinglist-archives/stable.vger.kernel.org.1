Return-Path: <stable+bounces-247129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PbAN0hyBWoTXAIAu9opvQ
	(envelope-from <stable+bounces-247129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:57:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF12C53E9A8
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8F56300D4E7
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B413C3C0E;
	Thu, 14 May 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oiF7XGDW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iP8l8PSQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAE3ACEE6
	for <stable@vger.kernel.org>; Thu, 14 May 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741827; cv=none; b=h/pveIp9c3amKfo9o0FN2Xdo5Ame/ZlOqZChAO1cIicFsdHZyLWqQz7T5Y5fqtzVVqLdgOhwgtDQKKOs5157X1GlmxUSKDAMTs1ROlXn2WhLH6Q0uAn3YxFMcoNQ9xaTkTPve/LWd9awcxl/KI387YeSvqwLaE+czZJlSDiM+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741827; c=relaxed/simple;
	bh=pdvdZzFyvj7r5a+JOqv+W6phlXqLzR/vzZUDYAo0xLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsFgi+1QgtNwayBMhhspXvf5iga5ncxrKDgSZd6ApllrXaAKEBKubt9zmzI10SZD4jdNLStc6VB+yx0MS2SmZA6Y4HUF767LEzDHtfwj4xSH4QzULZb4O7ouwac1CjZYGjyKjz+MOjto17yWhSmsFB8I2vZ01nbSkPwfh8rVeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oiF7XGDW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iP8l8PSQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E56mr0828347
	for <stable@vger.kernel.org>; Thu, 14 May 2026 06:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wz6dvE8LGwOUZGMUJOvXpxjfIIF55LCZblzwZIa6w8s=; b=oiF7XGDW2xjVtxEZ
	jc1sy6T1dwL2hkP+Ln27H09ExZVGJCKp5/9oRr6Zz8Ra/CE57av6cASdYeA59OHz
	p2Rzn2YxE25Qw6sYgX2oQmefoWbno5GZIlKr8v0sgJQ1po3uuFK1APu9sJg6jlzR
	oT0M8W1Dv/e001ZBy9MxPuuOuRdLE3aXyBLXy1cUQqDY3CsfDxb2fAP1P/OHrDIo
	omAhBtL1/w2kvf6S5BHwGH2blHqNC/JsFlcVlvA18EEy5m5jD9+7rTyhA5lX20p8
	KeVO2nnP24PIgJkmjYm7jMrxq5bb++hjJVg/0hyfs8L7vuZUrRW2L8ltXL5w2q89
	n8MnEw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57y7gb10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 14 May 2026 06:57:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2babbeff9e4so90003135ad.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778741825; x=1779346625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wz6dvE8LGwOUZGMUJOvXpxjfIIF55LCZblzwZIa6w8s=;
        b=iP8l8PSQ7TWXaNJ4Ke+OMu8reJ/I+Ycio2PJQ7LLZZ0Liq3KCU1wX6jjriub18PfR0
         IYKQyQ9nc9FyxqLodatvDNi7gI2VgiHwkmbG5nzFYax2eGcNVFzktSvYrf/w4pz130hh
         8wPLoJ6DmNXrLszHq47Dgtv2GAiiOmAV7WhcRsvaDOuEuwVTSLAR4GFUlB80YInDRIHe
         FqRNd+wcOmTSj0bANoZH7lgA5HqnRe3+kqpP+GwV60fFd6vltgHoKcy1PBrf8tlhlxlS
         /zse5c83hAiEO2q8sFaBtBXp0wmeb4QzbC8JZmWNWG5VtNWpZ9ezCByCQVg8/GLYayyp
         P7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741825; x=1779346625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wz6dvE8LGwOUZGMUJOvXpxjfIIF55LCZblzwZIa6w8s=;
        b=TzcQ/1Lm6/LF3Ik7SNo6bYWNbBghQFBHhEs6bI5pjipjYmAknYDNaSVr6UH/1WQ1le
         nT/PCt4Ll69Lle9Wd74XVtQE9kE1I9j6KLu818TtxTvSMmwGqLEjOrF98m1YYvXlDDg+
         6i0rMXFkjG635cxAbOKNLLBJqqoQtjo8dFmUB/sSQONvBLcXvy6JP0BYsDtcUXsNIwl7
         CUc5dNNgEIhr5bXTr5Dln3QYvY6TC36OEONvhymHIR37y48U96+OFfJf2dzWbnYLN3+u
         VeNi1vmalEglUJ8uWbKaKSv4nph1ozEXvBDvkpaxRJqxH+prdzIq9Gy6eyxSbJgIZN1I
         EcdQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dZ2z97BZN2JlMo3h2xHzFo8JgtOU20oeVjtY/vgdkGrV3wjXvOi9C7XtPNJKy5lECKQHvz0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7VG6dIU4fOchXQ0R6vPr/4rF4UF5jQrRB5w0/1ZGD9PWchUj
	ecvcaff0q2v653VnYQgqfjMZ2hxB/LbKQPsau6SXaIOQIuupjRoHeTJkJKZNxXXJczrTyJqUa/V
	DnUCqs0BTFlEU/LzGmrlCsgpQ0e4Sg4NfOj/kFFm65c4pvkqNhlJYe8Ogc+0=
X-Gm-Gg: Acq92OEa28P4keL4kqgPHcWcN3GobRAnb92UtEV9tEFdDdc9uykdXtq9tcYNP9JbL6Q
	nJRcKMyIM6zDC/ArqzznYWYGsVxIKFEXCuoxbErw/nn+J7XNKpjf+QGr5D+2Ty28UXGqhs92SRM
	fZn5yTbs3vgBKzojm4r7xoZoMb6xSOyS54JLeXcthCLy5MTB9kk9mztAjqtsjbvlDSDIHw/mdz5
	GGe+KWFwpXlt9zFLwUijeRt/gaGNg728699j1A28dTcD9Vj5SOBw4T9ZITMDBw5YUbb3neObR2D
	SkXQjzet81dVahN9JLZWSXMqQVRUkZ148p+0dkMScE/CMqJ/Ob63XYWih/wzieYFmS3TDaGSKdv
	7eKrI7VCvCaU8+F75lrttfgxmrIG1pvXvha4xuPbw2YCstSwae5kL+zXjfnSv/Q==
X-Received: by 2002:a17:903:2ecd:b0:2bd:3c21:a053 with SMTP id d9443c01a7336-2bd5283e0c5mr21138825ad.24.1778741824883;
        Wed, 13 May 2026 23:57:04 -0700 (PDT)
X-Received: by 2002:a17:903:2ecd:b0:2bd:3c21:a053 with SMTP id d9443c01a7336-2bd5283e0c5mr21138275ad.24.1778741823967;
        Wed, 13 May 2026 23:57:03 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062695sm1283497a12.4.2026.05.13.23.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 23:57:03 -0700 (PDT)
Message-ID: <c20aee84-d9a1-432c-9cf4-f5fb2219c966@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:26:59 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260420110130.509670-1-jtornosm@redhat.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260420110130.509670-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3H05nhJ2jTSys8XrKWyJTwopTDjRyCvV
X-Authority-Analysis: v=2.4 cv=UY9hjqSN c=1 sm=1 tr=0 ts=6a057241 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=qhnAyV4-s4WfS2nNwg8A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 3H05nhJ2jTSys8XrKWyJTwopTDjRyCvV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2NyBTYWx0ZWRfX/N0MPSmUxlxp
 KFoxAji/rWZEf3iFB9DETacNJ9lnUyEQY1XiVicuGj9rXY6jHMpfxtDE/cxepWp58tDb95NEjmC
 1mP7/c8950JuqGqj0NjqUHIX14d/rebGIblcX6KEvs+ZrzrBqiP1ZS3F11wDVuZ1Wdhmoiwdkqz
 RaDnagVFCuaZbLtQWvwIYzQ5zOdcOnt0gebjChZ2ZYTvkpFbhowhSznbIr5MldTTzTjHur+ATSq
 7y/5a3iNPM8s4YJwYghIT0MGPQXbjDIdgpq6/xU69jENhgu8wJtJyXxH2vYxD2sIgjRjtheiS0m
 Hc9i9OMeOAdRk4tgJbr972X/tHMVNv/ojEmxkS+bbLGrml3lBYm09uknaVNO3nsCut+0OYkfN8Y
 3dcZQwcKJ406PHczQACh7Td+CV0TAMmeCFXUjOkrwuMlK94uneil1GRvNk/GHUQPtlP65ovPLB+
 7zCU2D7q7gWwfcPZH+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140067
X-Rspamd-Queue-Id: DF12C53E9A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247129-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 4/20/2026 4:31 PM, Jose Ignacio Tornos Martinez wrote:
> If there is an error during some initialization related to firmware,
> the buffers dp->tx_ring[i].tx_status are released.
> However this is released again when the device is unbinded (ath11k_pci),
> and we get:
> WARNING: CPU: 0 PID: 6231 at mm/slub.c:4368 free_large_kmalloc+0x57/0x90
> Call Trace:
> free_large_kmalloc
> ath11k_dp_free
> ath11k_core_deinit
> ath11k_pci_remove
> ...
> 
> The issue is always reproducible from a VM because the MSI addressing
> initialization is failing.
> 
> In order to fix the issue, just set the buffers to NULL after releasing in
> order to avoid the double free.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

