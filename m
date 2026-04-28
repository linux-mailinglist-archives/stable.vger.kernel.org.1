Return-Path: <stable+bounces-241676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK54JdHT8GkSZQEAu9opvQ
	(envelope-from <stable+bounces-241676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:35:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A08C1487FB0
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD3BA35BDA50
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF7A472790;
	Tue, 28 Apr 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YeSWX8zH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PepiAa20"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EAE46AEDB
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386222; cv=none; b=nOwkkeLgNTd+7bgc/a2wdr82PvKhENvDdND88gDlJZmIlL/yOMMEapOpIMHuq6cbj5r1kedj20a1GDOexML7CXcV/cUh0TwEOIYSoDy92Um64UaeWZui8aX6cWPrsGfIECy75QuBhLW1rUdk0XUm91MiXk6y1n9EGtkuhnjBuc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386222; c=relaxed/simple;
	bh=2YNsiTXzXOv2m74/OS8Ei+h+JPVuKtHh0iQ7A9nDFxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWT1P+zLYZgzNiNpFdGOxzMPVW0dXc2VDEEQWsE9le1sRENdL1Au7xM42sjOY4tFtW9AZhSoLvVlo7PF8guVu8CGEfONc02OkIP//+jQoOxeKkvvUI9r6ihn7i2BbbUOLgkfcRmoTGy2baEx6NksKuO0oxlDTtPnSWkOczinPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YeSWX8zH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PepiAa20; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SAGRql1329658
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 14:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jmxuff+2VurCFsBMSjVHjuC/5j3liv6ORO4lRuTXi1A=; b=YeSWX8zHTFpVjfOZ
	1TvwasJuLc6tZR6qWVFZ5/D+VqQMOc5XEvweZtcjneATHIW6Qam1L/asVbiW3AFZ
	26ZbDI5WXvtwX75MY9/gSWNQZ81zHkfIhQT9B0H8JthJVrJ3ECPsvANPZwBTtYC0
	rfCzp4COezjGHZsbLcyvA+x45yKA151lSZTykgAGtkd+lnzXjjkPRKZwoGH58sx3
	4nU9qonJVXMWLo1C6xMuYNaY7IrL48Aam/0GCGn/EM/YdT9ZeL3OSeeqxAzhr6XM
	lq0NmTjSP34soslkXXI37NPJo0HbNZsMFHnRwBoFdVIo5R7Q7h9SiR/oIdiwqz7r
	wyvXAg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhaja2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 14:23:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2d93379001eso27343611eec.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386214; x=1777991014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmxuff+2VurCFsBMSjVHjuC/5j3liv6ORO4lRuTXi1A=;
        b=PepiAa20QXOwsbUCYBuK/ape8Nz2spomDgKN6X3hemnWovCIG9/OO48ohMtjrY4TrT
         HeGuWYc3+NI639YOoa4C7lfNCRXIMAzo9X/Ng2TDM0cwUvv/UriqXMToA+aed98B4F4n
         GCmCpsuw/T6sQ717FXUAptQDo1K0TpKa4cUmIPAfoXNAeiYnDxlln48ROOpYS8og9GtC
         jrpqy3fXUknZMNHzM4YZrk/NgVL8et8Rt3LtS1oUzMfAJZQuxq+CRH/BM/z2lDGG8/tS
         Af0jQceVsBYoEuk6eQ682wR0F3X5QzB+LYFLd9gs8lng/5u6a8+lLgitl/OS7UJuaHaC
         8GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386214; x=1777991014;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmxuff+2VurCFsBMSjVHjuC/5j3liv6ORO4lRuTXi1A=;
        b=Iy2TfZNX0ykjKr7hMe/cHPEJrUVS1Wj0KE0VzdEJ4GRbP/AxPMmbMIfYC3oSXyzmoz
         pn80jw5gZBPFUu7WMm/MlBNgKS/lz2Sl7M2OodMkYPL+4cnOwu32IOIX5eBshOAuEGeB
         ULjPGHjnJza05QyzzPuMQdTqcUUaEkT9EVEtRzHApHUhsce0X3UOG9GeP3PqLZxJFRoq
         MnQaYLeqRnKZvPGZVOM9dZtBo+fS/HLA3qxkiPk8o8DNIOkdrXA4xtg0u7UkkxUe6cqa
         KjjZv2K1dej/2wlEVbGwGe5NEqHdA4aWRDzy5rrzFtmy7mf7JQH5oVMRCgb2/YOwRLrX
         aYow==
X-Forwarded-Encrypted: i=1; AFNElJ+cdOoLw71Es4WbIJlabRyLqyjPyaMIrMf1A/62upA3mx/bOPt3wKgxe4nuE2XkSDo7nhzUAkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbweO818blYCarRxc0YqEb6nTEinhVVxBFEUE43QOmea6N6KHi
	jZOZCbTi6bl2CkIGG7RbvUvlFRUVrorYHfPG2l6MJ515IXiC2r321qzR5xPqM90pkp5WAuMLDA6
	wb9vsLaz38apz8XxuJp/VZIyJ/22WR59An9VB9SpN+bB0XAXSY4zn/SKkj9M=
X-Gm-Gg: AeBDies60oHLSuJXKTx9nzSBCvKVfJG2hU1OCX36nBkpg11mllmS1MK/n5tPg2b8Y4B
	8P9+YBksrBs3DYp5KDsIQtEIUCd5X/DxrmxyBEcY8m41gy/CxDeoyLSN2rn/4MvPn2FKzIY/Mg8
	E1khhdHlzJCd/Du/GJkzcqCc5qcmgZMn94IcFIGPyy+3fHoLX1PU33dxtS31aV5/zN6m6aw3c5C
	fY/X+zjIpfC7zMpOWat9LDscZPrAqiX/Ov0+yo2sRy6qxvvKesw7PQLKPqZoKAtCrvpLIevs1qS
	2g5eUcRhmiw/ZssFNF4v5wn9u6njeG9af/RVCNfjE2Lkt2b9dXotyaWEEvAfZ46C+srUZZwImYg
	kYpBarnsMYtgR9a8l2Rc6afBi6SUy/WJP7miIrL7DEcUzA5QBZzNWhC6iVwEhwMcZdHD3tgPgCt
	iq0QxONwpV0m3m4cy+WE/4bl7h
X-Received: by 2002:a05:7300:a148:b0:2ca:8099:ffc0 with SMTP id 5a478bee46e88-2ed09fcf030mr1547167eec.7.1777386214150;
        Tue, 28 Apr 2026 07:23:34 -0700 (PDT)
X-Received: by 2002:a05:7300:a148:b0:2ca:8099:ffc0 with SMTP id 5a478bee46e88-2ed09fcf030mr1547152eec.7.1777386213538;
        Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a10678csm2467904eec.24.2026.04.28.07.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 07:23:32 -0700 (PDT)
Message-ID: <17d5b91c-026f-4539-a39a-cfd976860273@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 07:23:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: drop stray 'static' from fast-RX
 rx_result
To: Catherine <enderaoelyther@gmail.com>, linux-wireless@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260424131435.83212-2-enderaoelyther@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424131435.83212-2-enderaoelyther@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfXzK9Rpc5kfJWE
 aRF5+/LYQ4WGdNaq+iQvfMJSZwfbxX92aUzJKurRNlAnaYJ2uGP242/t0oVj1rX1n8f+L/eHM5D
 wluaTBT0TvexAODrEjuvtdZWwIrSMWQLoPCsfDz8/RXhgx6JJv2mvlU8aXr5Qf/3VE3vy8D+Udd
 kGCNjq3UvcFiQJa8YfbNMxZNmRtcmKVWBNcP15VFZAPLHrxZxl0xOsoq5C2pw8XgG4T2f/9Qxj0
 1bkEL/qh8l2SVnULadh8t2jkSdFHiMEMk3MIPkO3bhJhNjeJQIwPinvAn/R9H2826/iB8XcpS7q
 MpAzHrNhC8gh99s+LZysFqgBbKeCccZ+bYyALRHd6y1ooIh66DQFTIyrzKdFK6h4AydwIFiEOnQ
 S2edVlBEN8IVZ63FatRKZg7ESHqy1MFaFu9zJI62M6q5SIB7st8SNQFvPnwzaF3oYWi7xVcGOIt
 ZqTpvGvgCm3w+6+HrPA==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f0c2e7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=vluirgkKQf0QiLCMEdgA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: vWxeicHBqDH8P2IcwkUWsksy0PF3-RpN
X-Proofpoint-ORIG-GUID: vWxeicHBqDH8P2IcwkUWsksy0PF3-RpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136
X-Rspamd-Queue-Id: A08C1487FB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241676-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,nbd.name];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/24/2026 6:14 AM, Catherine wrote:
> ieee80211_invoke_fast_rx() is documented as safe for parallel RX, but
> its per-invocation rx_result is declared static. Concurrent callers then
> share one instance and can overwrite each other's result between
> ieee80211_rx_mesh_data() and the switch on res.
> 
> That can make a packet that was queued or consumed by
> ieee80211_rx_mesh_data() fall through into ieee80211_rx_8023(), or make
> a packet that should continue return as queued.
> 
> Make res an automatic variable so each invocation keeps its own result.
> 
> Fixes: 3468e1e0c639 ("wifi: mac80211: add mesh fast-rx support")

@Felix: Any recollection why this was static in your original patch?

> Cc: stable@vger.kernel.org
> Signed-off-by: Catherine <enderaoelyther@gmail.com>

Is this an identity you commonly use? Note that anonymous contributions are
not allowed:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

> ---
>  net/mac80211/rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 3e5d1c47a..8719db8f3 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -4971,7 +4971,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
>  	struct sk_buff *skb = rx->skb;
>  	struct ieee80211_hdr *hdr = (void *)skb->data;
>  	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
> -	static ieee80211_rx_result res;
> +	ieee80211_rx_result res;
>  	int orig_len = skb->len;
>  	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
>  	int snap_offs = hdrlen;

Actual patch seem reasonable..

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


