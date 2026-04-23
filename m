Return-Path: <stable+bounces-240397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eRbnKilj6WmIYQIAu9opvQ
	(envelope-from <stable+bounces-240397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 02:09:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E1344BE43
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 02:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE07301DB96
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 00:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB21E555;
	Thu, 23 Apr 2026 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oAjAijl2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RYp1e3K/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC08462
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776902945; cv=none; b=cbuS/b+bALvjyOxIftsjKBw1mlzjUfmn3l/fMeEP72OIfmsQK2v70bebnEcpuyiFBMOBoXjj3sp1Np2cnBsphqw2ml8d2ycNi9o0RwFw1hog0nmcnCKkwIjtU27vA9c5MB3e8W2q3Ffria9OUJJEd1tsdExGSUgpUNGr8f9Cf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776902945; c=relaxed/simple;
	bh=rLPavQEjKiGCm/1i9ObQoJKxtMmFhSazrvpzFsXtwgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Day0kZiDctSdRIM/NiP55xZLXK+APai5WI1jRLTpuRZbs4m/D3Wcwd2XEGea7lojf4e7NwX7qrK4F60wUGu9/nJOG05CGzr/9BhoWHFLMs8yFyzKiC/LcQ+F1di/VL8Ovaw8/iUkFOQ0h2gsxfhDKqfug+xED44kZ0DdxR77mK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oAjAijl2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RYp1e3K/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG3fZZ1230196
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 00:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IWiDxia8+21/EnLpUDLYxaappdjnTVX+sv5Q6Lm37J8=; b=oAjAijl2V/B6zjKU
	JdlIPbGSC8Z/KacsqJymS3Tos/sMGQcfVIaaazhcnooh6Gbq1ajsGO9ZrCnqPSvQ
	OJlY9DpAujICd3KhexKCzxpl4GWSliQ6hnNkw7xUjwf4CZgEPFQa435CnUhiW43Z
	DwG/m32pun/9xK5yecilxH6W1xnX0QswkZ7ZIcYEG1M6TQFUc5+GRzmapFBNtBCK
	ZcgUcRRx1jmTuvBn8D7rkhN0/xS8Qorha1ZX+3SJ3Os6olxrj+TOPaFBgiICOFaN
	QTKqoCkx0vXUDUwd23Ctxwe8PMgRztMatsDkjEIxu8BmkjvoS7epcI4VfPq1bQXL
	ReWLyQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h69g77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 00:09:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2d9da2559aeso15205209eec.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776902942; x=1777507742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWiDxia8+21/EnLpUDLYxaappdjnTVX+sv5Q6Lm37J8=;
        b=RYp1e3K/W5ljIB3lodic10OKcq9/igTVDUbOzcOm5Krm4Rbf9+HQKk1LPT56Ka1GH0
         9M+nca3MHsnjku9s8v4VdHzmMR0+CSxm27BHDZrho7rXD8B+arpLA55ptiVbFkkxJ3r5
         L9AVFWu/c/elUTG1aFwZlRPymjp8rRUw430ofAh2/jmxmDNRgRGbzqDYR+HguDR6IPLW
         TkmQl8cTmR1kYQplpfgd53HeZZh3W1f7NkrZw75RkILyzWckWg9zFQn5ZJ9Rew0TiCrg
         pYkd7lHeCuxRxXwLyeq3TtUNSLJktjzlsKFc8x4ruw1raCBbPtYdCGvKWe8B8cP4qz7J
         uZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776902942; x=1777507742;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWiDxia8+21/EnLpUDLYxaappdjnTVX+sv5Q6Lm37J8=;
        b=bAcL3YqJc/jtnH5ErCnzb4Xdcv6s87rvaFdZI6F7VzkYGduXW5jEx8Fl/Ne0VITMc6
         s4CjAmezuagDzHpCKwOCGVdA1JWmT2JhFpzVBpbf5lZG9V+ehYgSqBcRP9OXlG1xBGBT
         lytHCHiTjPaN3nZjAWB2RGcCgwOOGxpgoYtRAKOoKnTKI3WFk8R+5O1RFvpGRttqYTEa
         3Pe7DqOtFuUeU3hBEHNXGdh6JorIJXqHpXpNYJAqdqGtxXI04Ju5wgQfPt7lbPRICOCT
         n4Hh+cn8AUXCT/QbWhbkE4fhgPwJY2QCZYGA6dCkJSDASYK7TY2TMKA0e7hHqrQteo2W
         Vifg==
X-Forwarded-Encrypted: i=1; AFNElJ9/nDQcB+rTXr+xYJsVJKvCUcXvDwzzW9gqsiAc0dP1ic50A0O1bkRZou6Wqwjb9GqYue3wdKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHoeGvnYFR2JVzCPIyBD/3KjhcMYcbVukKDApltHn6mrx1aXE
	zzbLbIyuu54CCzuX0RIhsOAqIfokYDwrfhcsozX1yv/VnmN0BaX+rprhdXJ22FQQq9Px6V9/iOJ
	LEdQUdVY35h6AFJTcGZ7nync+XqKNbBx9GZQ0cf6wV5hg/5SJW+0sGCczM0k=
X-Gm-Gg: AeBDieuQJXgHfXbs8HV5Um5ITDUwpn/9VE1bJnJItWzORIsxGi9jHL0DCN4JxfnMiq6
	8dmCZYaY6nOsonJS7gJ1XuqINGPQZllNZvEOQszvRwQa3bdBbsDJ/8OLcxgQqaSUDw0Zbvoc5J6
	t5WYsKXyZ/35CiKIQzUEpnjlzjnYlTCXomHHfRP+spZlo+eicn5Emnyn4FfVlY4jtCYepuEIIgk
	oRIuA7S+NPDMkhghxIPWDwv4U3r7s4WkPqDwe13D/j/nNM/urrvNMgjrPtNFXRc4/ARP83KEJ/j
	CKikVSXJOy7CKdmpTdmgwN4PIdXp9bmYf9xa8BuhiNWXfYUB1GhrIeHToTo9CtCpEzBAfPzx/NN
	H3v34idPJLCfpmUBwtLJYzReOy1db3jEawrwnbn6uT/HIAW2NffXEFjDU0bOF2o3wkUftAKrFXt
	fRiHHk48uzD6IF0uSXXBbQ79O4
X-Received: by 2002:a05:7300:2203:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2e47951a762mr18013157eec.28.1776902941768;
        Wed, 22 Apr 2026 17:09:01 -0700 (PDT)
X-Received: by 2002:a05:7300:2203:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2e47951a762mr18013135eec.28.1776902941163;
        Wed, 22 Apr 2026 17:09:01 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c86sm30774921eec.1.2026.04.22.17.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 17:09:00 -0700 (PDT)
Message-ID: <0456ecb5-130e-481d-97d9-e88a7aaca02d@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 17:08:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath] wifi: ath12k: fix leak in some ath12k_wmi_xxx()
 functions
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, stable@vger.kernel.org
References: <20260422163258.3013872-1-nico.escande@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260422163258.3013872-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69e9631e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=BklQrkN0B_13ZYhzje0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIzNyBTYWx0ZWRfXzbMhnG1z0Y43
 2Xnz/PyJrqVUQpQa6bim5WEaifrQ+gSXGlgRxh791YvFVRboOGdG2jyA/F4xo2jXtgcOFavsIIi
 5/5Ii/Dnn1pJeJOYW6PVBpEBU3rz/2O9vH+WJkwtItVvf0tL+iK1XzQtxQQm/2AGSfeLpVIKLDP
 alz5o1dskPo6pirIDszlZH7rUYTA4l7B9NrsdxXSMpCB+X3U0Ac70gk+lEAFz7c2ff92s0aFc7E
 OS1epg4mcUDKReixyvAj/OTsHgL2UmDI7aUxxQesSJNxtPrLlxLYIKwWq4v/ZYQ41X+sep83H3P
 a59QStUFPnmZ2WMJjuyzcjkLkh0nPm0BTdYWUHN/F+T7MyjddQZm7FBYmk0mWjQcsiKJQR65xeH
 ChyVmpJ/trHi1VunK1a0PKjlRe+C7mSNNdKLkO2UaQb88tgnsYtvEqMe2TEINdQuTJYU4f0gUUS
 4lKjznSHbkzC1y04c6A==
X-Proofpoint-GUID: 2yNsxLyiSKzP570w8q8VHKL9rhgH2kLp
X-Proofpoint-ORIG-GUID: 2yNsxLyiSKzP570w8q8VHKL9rhgH2kLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220237
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240397-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 01E1344BE43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/2026 9:32 AM, Nicolas Escande wrote:
> Some wmi functions were using plain 'return ath12k_wmi_cmd_send(...)'
> without explicitly handling the error code. This leads to leaking the skb
> in case of error.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 66a9448b1b89 ("wifi: ath12k: implement hardware data filter")
> Fixes: 593174170919 ("wifi: ath12k: implement WoW enable and wakeup commands")
> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> Fixes: 16f474d6d49d ("wifi: ath12k: add WoW net-detect functionality")
> Fixes: 1666108c74c4 ("wifi: ath12k: support ARP and NS offload")
> Fixes: aab4ae566fa1 ("wifi: ath12k: support GTK rekey offload")
> Fixes: 7af01e569529 ("wifi: ath12k: handle keepalive during WoWLAN suspend and resume")

@Stable team:

are you OK with one patch that fixes a bunch of places, or would you prefer a
separate patch per fixed commit?

/jeff

> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 103 ++++++++++++++++++++++----
>  1 file changed, 88 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 65a05a9520ff..75c87edd2a8a 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -10251,7 +10251,7 @@ int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar, struct wmi_hw_data_filter_a
>  {
>  	struct wmi_hw_data_filter_cmd *cmd;
>  	struct sk_buff *skb;
> -	int len;
> +	int ret, len;
>  
>  	len = sizeof(*cmd);
>  	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
> @@ -10275,7 +10275,13 @@ int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar, struct wmi_hw_data_filter_a
>  		   "wmi hw data filter enable %d filter_bitmap 0x%x\n",
>  		   arg->enable, arg->hw_filter_bitmap);
>  
> -	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
> +	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_HW_DATA_FILTER_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar)
> @@ -10283,6 +10289,7 @@ int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar)
>  	struct wmi_wow_host_wakeup_cmd *cmd;
>  	struct sk_buff *skb;
>  	size_t len;
> +	int ret;
>  
>  	len = sizeof(*cmd);
>  	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
> @@ -10295,14 +10302,20 @@ int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar)
>  
>  	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow host wakeup ind\n");
>  
> -	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
> +	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  int ath12k_wmi_wow_enable(struct ath12k *ar)
>  {
>  	struct wmi_wow_enable_cmd *cmd;
>  	struct sk_buff *skb;
> -	int len;
> +	int ret, len;
>  
>  	len = sizeof(*cmd);
>  	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
> @@ -10317,7 +10330,13 @@ int ath12k_wmi_wow_enable(struct ath12k *ar)
>  	cmd->pause_iface_config = cpu_to_le32(WOW_IFACE_PAUSE_ENABLED);
>  	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow enable\n");
>  
> -	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
> +	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_WOW_ENABLE_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
> @@ -10327,6 +10346,7 @@ int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
>  	struct wmi_wow_add_del_event_cmd *cmd;
>  	struct sk_buff *skb;
>  	size_t len;
> +	int ret;
>  
>  	len = sizeof(*cmd);
>  	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
> @@ -10343,7 +10363,13 @@ int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
>  	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow add wakeup event %s enable %d vdev_id %d\n",
>  		   wow_wakeup_event(event), enable, vdev_id);
>  
> -	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID);
> +	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  int ath12k_wmi_wow_add_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id,
> @@ -10356,6 +10382,7 @@ int ath12k_wmi_wow_add_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id,
>  	struct sk_buff *skb;
>  	void *ptr;
>  	size_t len;
> +	int ret;
>  
>  	len = sizeof(*cmd) +
>  	      sizeof(*tlv) +			/* array struct */
> @@ -10435,7 +10462,13 @@ int ath12k_wmi_wow_add_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id,
>  	ath12k_dbg_dump(ar->ab, ATH12K_DBG_WMI, NULL, "wow bitmask: ",
>  			bitmap->bitmaskbuf, pattern_len);
>  
> -	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ADD_WAKE_PATTERN_CMDID);
> +	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ADD_WAKE_PATTERN_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_WOW_ADD_WAKE_PATTERN_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  int ath12k_wmi_wow_del_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id)
> @@ -10443,6 +10476,7 @@ int ath12k_wmi_wow_del_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id)
>  	struct wmi_wow_del_pattern_cmd *cmd;
>  	struct sk_buff *skb;
>  	size_t len;
> +	int ret;
>  
>  	len = sizeof(*cmd);
>  	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
> @@ -10459,7 +10493,13 @@ int ath12k_wmi_wow_del_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id)
>  	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow del pattern vdev_id %d pattern_id %d\n",
>  		   vdev_id, pattern_id);
>  
> -	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
> +	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_WOW_DEL_WAKE_PATTERN_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  static struct sk_buff *
> @@ -10595,6 +10635,7 @@ int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
>  			      struct wmi_pno_scan_req_arg  *pno_scan)
>  {
>  	struct sk_buff *skb;
> +	int ret;
>  
>  	if (pno_scan->enable)
>  		skb = ath12k_wmi_op_gen_config_pno_start(ar, vdev_id, pno_scan);
> @@ -10604,7 +10645,13 @@ int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
>  	if (IS_ERR_OR_NULL(skb))
>  		return -ENOMEM;
>  
> -	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
> +	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  static void ath12k_wmi_fill_ns_offload(struct ath12k *ar,
> @@ -10717,6 +10764,7 @@ int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
>  	void *buf_ptr;
>  	size_t len;
>  	u8 ns_cnt, ns_ext_tuples = 0;
> +	int ret;
>  
>  	ns_cnt = offload->ipv6_count;
>  
> @@ -10752,7 +10800,13 @@ int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
>  	if (ns_ext_tuples)
>  		ath12k_wmi_fill_ns_offload(ar, offload, &buf_ptr, enable, 1);
>  
> -	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
> +	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_SET_ARP_NS_OFFLOAD_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
> @@ -10762,7 +10816,7 @@ int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
>  	struct wmi_gtk_rekey_offload_cmd *cmd;
>  	struct sk_buff *skb;
>  	__le64 replay_ctr;
> -	int len;
> +	int ret, len;
>  
>  	len = sizeof(*cmd);
>  	skb =  ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
> @@ -10789,7 +10843,13 @@ int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
>  
>  	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "offload gtk rekey vdev: %d %d\n",
>  		   arvif->vdev_id, enable);
> -	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
> +	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_GTK_OFFLOAD_CMDID offload\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
> @@ -10797,7 +10857,7 @@ int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
>  {
>  	struct wmi_gtk_rekey_offload_cmd *cmd;
>  	struct sk_buff *skb;
> -	int len;
> +	int ret, len;
>  
>  	len = sizeof(*cmd);
>  	skb =  ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
> @@ -10811,7 +10871,13 @@ int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
>  
>  	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "get gtk rekey vdev_id: %d\n",
>  		   arvif->vdev_id);
> -	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
> +	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_GTK_OFFLOAD_CMDID getinfo\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  int ath12k_wmi_sta_keepalive(struct ath12k *ar,
> @@ -10822,6 +10888,7 @@ int ath12k_wmi_sta_keepalive(struct ath12k *ar,
>  	struct wmi_sta_keepalive_cmd *cmd;
>  	struct sk_buff *skb;
>  	size_t len;
> +	int ret;
>  
>  	len = sizeof(*cmd) + sizeof(*arp);
>  	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
> @@ -10849,7 +10916,13 @@ int ath12k_wmi_sta_keepalive(struct ath12k *ar,
>  		   "wmi sta keepalive vdev %d enabled %d method %d interval %d\n",
>  		   arg->vdev_id, arg->enabled, arg->method, arg->interval);
>  
> -	return ath12k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
> +	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_STA_KEEPALIVE_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>  }
>  
>  int ath12k_wmi_mlo_setup(struct ath12k *ar, struct wmi_mlo_setup_arg *mlo_params)


