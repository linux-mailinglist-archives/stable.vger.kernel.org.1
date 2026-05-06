Return-Path: <stable+bounces-244439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNPwL0aG+2kscQMAu9opvQ
	(envelope-from <stable+bounces-244439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 20:19:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F644DF3C2
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 20:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E474F30075D4
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C3D4B8DEC;
	Wed,  6 May 2026 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Brj8A/Zb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KqSeVHBs"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31808318EC4
	for <stable@vger.kernel.org>; Wed,  6 May 2026 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091587; cv=none; b=q3wleWdMiFo9zeOMLwHkm9XXOHs3yzaqbV/OeazFBFrL5HvWSVsmRuDpc4wWg5KTC37GIvJGDko11KL2UrElMoG+uwOnk6nZbpoKGwv9WFEsP2wUGDNMd1Gpb5VoEmjTHBxP5smVslLlHSkJhGFqHQ/eYslXSI/+i+X+xAQaPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091587; c=relaxed/simple;
	bh=7aiu2JUFoolSsX24+en1TLO4jHhLy4ztH/j+S3dnKmU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KV8H9ZHXbPtydR4vEZ8FxzgCRDvcnITaLlphDe4G8hPTiSx/F5x2yUnVDpLvsFufQr0Ux356e1jWA00PxouCPnWom5VhU7PmpWABi+SnOBNq/76Z8Of4YZeeH/6PtJLHf6dH6V8pxJxbceV7PqAtLXlbx07gtgz2TJMT4GGzeko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Brj8A/Zb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KqSeVHBs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646ELaVI2428125
	for <stable@vger.kernel.org>; Wed, 6 May 2026 18:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fW7+cAaB9tFYadSH4iU2QxnEOPZYkbnvDwiqGGx9hdw=; b=Brj8A/Zb65emycac
	3xJRMK4BCeAN+LdEAaWbPQMYPEBe5q8uyeizOGzX6DRYj4OHH8BiNdJ63U0NDtTx
	/oFQzG5Y2gm+cdTRQ6gb16EuD2zyg67CAraf1umrds9vnhLY8DwvOLAoeMQf/sj8
	QBdnnN+WLmIlan7uJurTmsrAhiXLx544xLzVXBcZy+NYSe1SYKAOxCwXChQT3uJS
	JinWIQAz2m5cELZZkxA8n41TdSAKjv60TyM4XvTcX7WKppmNWY1QKFZENrYl+5CH
	9RJafTx3bwp4UQNy1ujM256AZz3O+vVQsMnQTwmJDHiOH04FdQRhwjmXwyyyz67W
	Feuucg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e01ph2d2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 06 May 2026 18:19:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c797e31a9b7so7430043a12.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778091584; x=1778696384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fW7+cAaB9tFYadSH4iU2QxnEOPZYkbnvDwiqGGx9hdw=;
        b=KqSeVHBsijfBsWIKu7/rieMJBPMeHnmA9GcYPzvwAOY3htFjq+LFmRQCBrqNQNOnS7
         66b2rRmGlZSgHRhGSKyEFJvkTFLZkaXl1ndweVV+qGxEmAeXsrJr1X+FgrOeBt68KMYW
         vd5m/VD2hzq/hl8shrcEb/XjcggNfGopgV430WXe9jzt6ZFn07Z7RvMpBOG4sczCltj7
         yYy8AbBcxoPeihVoNZsPYlmZ+Yj1eyQvKw11+mMx21AU2wrabxqstWCCj0ktrePsBwcB
         MyA1c/tV1GfTCPXHDlF6b0GcBRn5bL+OrW6pWZo1xXT2jKQXNtAbj9L283AGdiJWnjmj
         2TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091584; x=1778696384;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fW7+cAaB9tFYadSH4iU2QxnEOPZYkbnvDwiqGGx9hdw=;
        b=r5jgXS1GQ3kwu7o2D1hw02F+AQFyotuJaTYlXvDigw3PQYB2P1tcGrubrBKkTpvzFs
         6fEwNtTj/nSjTqeY5R445P9B/aDhgyH2YA0RMYQpwdyuu9MG+uQBgMQmzchG0fbzw2ll
         LEpDMfrs+gYsKFLLpS41xHaU4mUb2Miquu8c6JWJXPrHLx7W7nQSyqTApyKow9DavSv1
         4Dypk03xdiHfMxtUcxCZFpdCcT/KdSWXl6rInILdEJa6LPnAzeTgYXkj3P/ryM0/nUnv
         rDkx16vsTPvSmByhAO2tF3yGKuEyZKg04noAlEIBc5qIaLlDW3AJMWk/7mvyF1RE0TpF
         V2Hg==
X-Forwarded-Encrypted: i=1; AFNElJ+QV02fy8e4i+96Mr/gKf4TGiZNANHtWBI4El8YexokTf8kInqoQo1n8qXHoZmr6/P693jGaUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ol6WxpLadJENcOuIvMU/+oywZC6tOwvYbgaBW56NGTJsxzpK
	ulhHG3Ctb+BAhrVZS9P54YV5sJ8My9N3X4Glu0htUP1/ozw2FuZX4TcuRq5JGInHQnZFApOMPsD
	V2v5lRlH7uRylG/uO96k0HJ5FW+oCGt2LmHb8tWUPvPQpv/waI048e4+ZrP4=
X-Gm-Gg: AeBDieu+4trtDaY52giSXmEOJk00KqilonqlSmAL4/4cT5pap9xGLFKwhuKgrqa8HtA
	XZdcD/dsEK9H4ie/eH6wL1P5//0Y0uPR3AEds5BfWw9aXsXbX7rbpDd5Ew88Q10R+BZw54D6BGM
	k/ZwaGNRZ7/gcIo4vQYdLpFPCILUPvjfBnd2CJt48w2lJs15u7wZU6IgvfiMkOJrFAF/hAg5D2G
	9CtCdg/8lPDKqzKQ6EzwuOq6Xk730USSeRCSr4cdZCUfW+q66LkV0bHSeUfNQNa0MyfyPMpkwzf
	Yze4OHgH3YZx5Ov0yb5CvC8bym52XT8Q5cweocmcOU3itW5cZnDVhuB7BFSNlxNNcmRA+fPByYf
	PagAl3R9gSPKk4K42+LF/2mzx6Oc+NbPBcutmr6Qkzoq8GyZQBOTERW8c8FpLFBC2uaGVIlEIx5
	Fw
X-Received: by 2002:a05:6a00:4517:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-83a58a2afc1mr3812503b3a.0.1778091583959;
        Wed, 06 May 2026 11:19:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:4517:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-83a58a2afc1mr3812477b3a.0.1778091583464;
        Wed, 06 May 2026 11:19:43 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659487afsm5831890b3a.18.2026.05.06.11.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 11:19:43 -0700 (PDT)
Message-ID: <005af843-da19-4df9-af67-2cd148b24d62@oss.qualcomm.com>
Date: Wed, 6 May 2026 23:49:38 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260420110130.509670-1-jtornosm@redhat.com>
Content-Language: en-US
In-Reply-To: <20260420110130.509670-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3OSBTYWx0ZWRfX/c8XmulPNIaN
 ybehjpa5026g891wou3h+2zlUHBLAw6ErU74SbZpcknx+fdx7DS5oq7RTZaOaZUR5gjZafc15/h
 owZ4m9PloLSosFT53MhEsc8hUwNZifCIKD2djLaR3mBW/dd+SAVCxl9eCoa1U9zrFyIPaUmgDEr
 8MPoNxy+Vfg0wzKLVZPzpviV9BycA/oOKnNp/X0CC+ZO/8OzMqMGuCVdFqnnM3thHMNxuAO0f8a
 E1aUkM/u7flAHUgBnJkA2VvTgjiMEgd1A4hVMCj7vuc0K9c0oKlFywTSdTsVckqfwB/0svb1t09
 CIw1diXpe/Bjr2hDiZ284UT2i0lqIKwXancW2MaUoHcE599kX/U5rSzfBqqzhSv/jLJzOOmbWbC
 K/UQkV16CT4xCenv9LTlpkhf8mtOwZguf+5Jn8KyuaZgLbnD6r25BqOOOGci0knoiUz2ETcL6MH
 jTzxG6V2WAslBhK0GGw==
X-Proofpoint-GUID: yMyg9QxiHXUYFdD7c0nbK0QHOocnTlpD
X-Proofpoint-ORIG-GUID: yMyg9QxiHXUYFdD7c0nbK0QHOocnTlpD
X-Authority-Analysis: v=2.4 cv=MYhcfZ/f c=1 sm=1 tr=0 ts=69fb8641 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=20KFwNOVAAAA:8 a=vrVOvOPcliifg5cE6R0A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060179
X-Rspamd-Queue-Id: 31F644DF3C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244439-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

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
> ---
>   drivers/net/wireless/ath/ath11k/dp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
> index bbb86f165141..5a50b623bd07 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.c
> +++ b/drivers/net/wireless/ath/ath11k/dp.c
> @@ -1040,6 +1040,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
>   		idr_destroy(&dp->tx_ring[i].txbuf_idr);
>   		spin_unlock_bh(&dp->tx_ring[i].tx_idr_lock);
>   		kfree(dp->tx_ring[i].tx_status);
> +		dp->tx_ring[i].tx_status = NULL;
>   	}
>   
>   	/* Deinit any SOC level resource */

On which hardware did you observe this issue? is it QCA6390, WCN6855, 
QCA2066 or QCA6698AQ ? Also, where do you see the initial failure ? Is 
it somewhere in ath11k_core_qmi_firmware_ready() ?

I am asking because this looks like it may be exposed by commit 
6fe62a8cec51 ("wifi: ath11k: Add cold boot calibration support on 
WCN6750") [1]. That commit added the ATH11K_QMI_EVENT_FW_READY path, but 
the return value from ath11k_core_qmi_firmware_ready() is not handled 
there. If that call fails after ath11k_dp_free() has already run on the 
error path, ATH11K_FLAG_QMI_FAIL is not set. Later, ath11k_pci_remove() 
does not take the QMI-fail cleanup path and calls ath11k_core_deinit(), 
which calls ath11k_dp_free() and other cleanup functions again.

This is similar to the failure case fixed earlier by a19c0e104db9
("ath11k: Handle failure in qmi firmware ready") [2], where failure from
ath11k_core_qmi_firmware_ready() needed to be handled.


[1] 
https://lore.kernel.org/r/20220720134909.15626-3-quic_mpubbise@quicinc.com
[2] 
https://lore.kernel.org/r/1645079195-13564-1-git-send-email-quic_seevalam@quicinc.com



--
Ramesh

