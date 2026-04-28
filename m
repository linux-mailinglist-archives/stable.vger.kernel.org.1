Return-Path: <stable+bounces-241464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LmnEmQb8GkoOgEAu9opvQ
	(envelope-from <stable+bounces-241464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:28:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBD347CC26
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49C1F300D0F0
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B8C3939DB;
	Tue, 28 Apr 2026 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h3aSYlyt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DRbAS4NL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2C63921F6
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343329; cv=none; b=bsBY/UPnhqYgVtp4pjP7o63WEzij/FG/9qoP3mifNLtARzHG3y5wYTaQSbMvdTYX8GnC3ZjNiBB3g5nOMpC+pfbLTnU5ot++9TRU7t0bS0N8T1uPyIDhTYr4/7hKOuBDsXba8FxGiqsH0ZSAyMhJSPnhWuoJD7xOPEONqZtTi6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343329; c=relaxed/simple;
	bh=wizFbC0Fd5PGOQYPtrvBHZWYwMpeaMfcNees1Z9iPto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkfWdGZTkQdA72JOHcqEQYb7rx/KIDK+Gf8lhyDdE0Ap2A3ggYoWPSMUpbam/g7WeiGUUehhtveq0FSPoBNCy8x1wPF5XarNkBWo1ojAsUmx2todBhJA3UID/pHtRxtsGYxTFI8MWh3Y2cQHxCOuM1mJKbwIwNTvub0d653rjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h3aSYlyt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DRbAS4NL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RHc5lO1238182
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 02:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VPzxcDFXiWrzals8bQN+wr9M8M/HVCUe6SSz/woMcQk=; b=h3aSYlytsmDR/39V
	+6ytcNIFPZujdq0Wb9bC47o0MwcyGknAGminCRam3kpnmk6J9NQMYp6e4WSMqjEL
	xbJ2h3RyCHdXIVjafoqhk2HnWnb1dJFovlMPlQE1v386PS0/UG9Nbn1Vi4fIioE5
	UpUOphmEOn/OsGfgHS+9zaFVmC4JEoAg1mAzkMYQAxGTw8k7xr3jf7Bhd+ooTzOu
	fsmUnTl/Bwg4UBH6h15HggCtIKTX2e+kitTw6qB1rHkdFaNOMa7WYUOjryLs6VDE
	D2JIIwkJpHpF/huPj2zDE8SSPzHayR9KgbDurFjJAODLTm2+oPtqwuXo0k4P9O0P
	6YQoBg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4k5hu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 02:28:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f220f1dabso8007755b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 19:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777343326; x=1777948126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPzxcDFXiWrzals8bQN+wr9M8M/HVCUe6SSz/woMcQk=;
        b=DRbAS4NLy0VZccbFcwfaZJHkegKL2gyg2aEjxI4S8czPOFgOhTpsBeBQYpKhC9OG4s
         vMqTI9M0AAXcj7qUb14IWNrq0z4j+EFZoHBqL+dDHBVPPtV25KP8sYd3ZKjconM/h6At
         bmH/GP/D3hOie2a4NeT5Z0qIItftop411TmjtfLkMBD0lcEEHg9QocF3oPXeptbo2k6s
         hPAP60X5rPE9jJHUWGrk9ixXoqp1N8Wi+kQBNsh2Xb7DL5PhkFdK/ti2NoP6CJj2VgeP
         Nm3M+137YInzSE8b3//XzhAER7O6bc3WNL3EfJ13sWcNYpv/MzNpL6aWs2q/I0voZojG
         JilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777343326; x=1777948126;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPzxcDFXiWrzals8bQN+wr9M8M/HVCUe6SSz/woMcQk=;
        b=BBgnfGuNvkFSsMvYtCTVeL3L71HCPJGoOo38GUzfGP1jARrIcZF2ymsJlAj6VOLAyc
         mBmvTBhgSvAUqaXK+dg2wO5ma78ZYXqDCd9+jQur+lwqaLHi7PVkUubH8MrwS2aIwJSs
         Rl60PgLPJf98jKj4wW8BbakLqprREzV2I2rG7sM8BPtv9/kVxBWtg3tLLfgmSJw5Geek
         OFjOHuLAlPq26wOlG6hzRF2dg11dSgPLannwJQTA9Kv0zm8i7UpKNgJAHogzWO7C7tEy
         pd71eL/qImU5Gb/X5evm98piSKKL9m6R+dddCWw7zfw49ZBRFnAya3aWSiCujdTbbMyK
         /fRg==
X-Forwarded-Encrypted: i=1; AFNElJ/FBWa/h70aHQkThM8rl6nyMA/NC3YzxAunFd64ODOp5KV7yV5i3nb68THx5bAD3kc5Bs4+sck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXY4KhrwZm5C08lJlUApj52xuw5DSgRTVgEo39DxuVordG/rIk
	+itGL40X6TAyefVw3zoFET5JKobtz8M2smjXQAAk4IVWsC1byVj++vpUOzuFBRYeTY7mbHQBVsV
	sUx4DgNcd4aoEKYlAYt4E79wzOW9CyEQYRvg9MXiBJmydoXTMhITiddqBesrv2wGBbEPuxw==
X-Gm-Gg: AeBDiesowiM0hnYlIZxFfoeES+3LMrFqvVY4IvI4cizHBsxscprWp5mfUrhtwicJZzT
	uCC2WMx+2oB8ioi5AcIhKZvm4pJAvZep8zRTGsW+k0M22wdopIlhmi/pRoTxDjae2eht+TA/KNK
	ObTiULoSR0NyyAmSCUWFSNyIPFW2egMMgUURk/WPKqu765lQgp15aO8Qppm+V7KZA7G1u4pVw7Z
	WhYjNmLbPqdo1uBWkOaNghUyqz3bgS1Unrj/neRz94rUlzzaGXYGtNFk0dwALE2OZNGOIoXujqZ
	lEC0v7+DX1xSRsay12fX+mCaqriavTTouNgKG/LbOtqim+k2Ahyo3i+2Im79poCsy/U/5q9qTLS
	iF2kUNz3EFU1jqcU21qWrEGtSkkpvqd5qA0qLV0Txl/VOKujsiW/EvzpQqppeHZ6O5r+Xz5SqD6
	dx7ECK/8RWNPJYZRjb7AoF9+ca2IEY1A==
X-Received: by 2002:a05:6a00:6c83:b0:82c:ae0e:dea with SMTP id d2e1a72fcca58-834ddb9f511mr1033695b3a.32.1777343325938;
        Mon, 27 Apr 2026 19:28:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c83:b0:82c:ae0e:dea with SMTP id d2e1a72fcca58-834ddb9f511mr1033664b3a.32.1777343325496;
        Mon, 27 Apr 2026 19:28:45 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm930726b3a.42.2026.04.27.19.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 19:28:45 -0700 (PDT)
Message-ID: <c0d2b6df-4109-4c93-b229-7eb2d3fca6a7@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:28:41 +0800
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
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260420110130.509670-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hQO2vZ4KJCvR0JYZOkqx_bNV_su2G6eU
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69f01b5f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=oU0rmw-L0ToDbzm52QUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: hQO2vZ4KJCvR0JYZOkqx_bNV_su2G6eU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyMSBTYWx0ZWRfX2yN2B+dIl/wb
 8akew9+HyF0Zb5Iw/BGOcn4SrgDw5eU5tKBSFJiLYd+KKCFDlcJHD6D6ysB1IiqUYNw31q7WPXx
 V6evZDbfX4HHZ0+Rf9VtwADymGdCv6ZkMoCBY0M18PVaDEX818cfLcI2SPQgET8+6RUi1Nn3OaZ
 o9G3kgF+OHPvtQ3QtU0No2vUAXLwVJHf8DcJZ+Aan7o3N+hZFLU903UJ3HpoYYNttXodyZtiXAz
 3NBTColqld4+k0imLUmUoWfrYlgR/Wrhrh0sPaRaNJmbCv+QLPhwYKtBFsa3lhGku9D2py5O9vC
 9QlJi4rD1/9BY1CbxQ1qRZ39RwlFqPgd3h8umd0hUVFBWn0iGYO9ANW2O+Zdk6MlHMmOHXenf5k
 wW5UN/S8ZDEedXgotctBFtwM4O9UtudpWhmyora0iWv7KJDv40K8J6aFPaAG49Tj2wVHvTs9MIT
 f/9gin79/5QUhUhFYQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280021
X-Rspamd-Queue-Id: DFBD347CC26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-241464-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/20/2026 7:01 PM, Jose Ignacio Tornos Martinez wrote:
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

MSI initialization runs at probe time but I don't see an error path doing
dp->tx_ring[i].tx_status release. So can you help elaborate? what is the call path when
the dp->tx_ring[i].tx_status is first released?

> 
> In order to fix the issue, just set the buffers to NULL after releasing in
> order to avoid the double free.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
> index bbb86f165141..5a50b623bd07 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.c
> +++ b/drivers/net/wireless/ath/ath11k/dp.c
> @@ -1040,6 +1040,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
>  		idr_destroy(&dp->tx_ring[i].txbuf_idr);
>  		spin_unlock_bh(&dp->tx_ring[i].tx_idr_lock);
>  		kfree(dp->tx_ring[i].tx_status);
> +		dp->tx_ring[i].tx_status = NULL;
>  	}
>  
>  	/* Deinit any SOC level resource */


