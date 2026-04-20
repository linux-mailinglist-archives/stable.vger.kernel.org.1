Return-Path: <stable+bounces-238673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJhgEZ1v5Wm3jwEAu9opvQ
	(envelope-from <stable+bounces-238673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 02:13:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F45425E41
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 02:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B140330128DB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 00:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81040855;
	Mon, 20 Apr 2026 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YMCfY0nv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5F27442;
	Mon, 20 Apr 2026 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643990; cv=none; b=PQvESL1NEltHbTE9+VkEu1g+3k+9UGS76fbZFPjrjrLmXgqH1i4zt+dj2Ws0S7Y6r4IqEs2wXESTJo8BpPPcj+3E8LyOgGkXwrez4QmNtd1kk3kRgQezQCJfMpTCgVlT4DKizDFbM9+Ntu+dzkC1XT3hIGyAUGEacfn08s3AnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643990; c=relaxed/simple;
	bh=miPJmafxGYa/0nBAUppkC8i1uJWsAyk0QLELmzPA81s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVlj8gbZpeFROJ5G5w9kGnMpwMrnxsKQfQhrDs1oW2mEmb2g6NpX0LFiyQleEhjPO81TfBGmEHbQSOV4Qok2VEun6gqaINazwmA0wfys3gNdbAJ2ct4znCUTpZRgC1yUf3ozRUfCUIFNBD6soglDDJIjFV9HaIbijz+hT50muC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YMCfY0nv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JJjOLY2986195;
	Mon, 20 Apr 2026 00:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aZBdIt
	kfAsnP3W4OIPRwFKg8WBJUd9YO47VwRzMsse4=; b=YMCfY0nvUOHNNv1jrxoaGT
	HCdM/0wahsGi1rWOXRjIBLkUl6sfW84NefA+Q6ax5sIY9GgaxO2g3zF6yTBh6Lvz
	/8m10na03tz6nLUl4rXq/FBOOJbWEbGhd8Rv7iRckYfBXf1csEREf1mUGgzILOTq
	zT0BoAJqyJ4L6TZEQFjNVKJbfL2lOYQUzwFvrtsvaZI+NQwY+O13gSqDe3/BvdiC
	KM5oZtUQGS5dB6AuQPWm9HeWoAzXURJFPrvSeu9NfPapm/TYmdtqeNCrlKvJUVI8
	rxIFCoXFgaH1bvh2xYU8UHqlDZNg0v5a3V4h9EJLMqGPUs9826k3zryY8erlcV8g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6dj2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 00:12:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K05Ktf031623;
	Mon, 20 Apr 2026 00:12:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg2mms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 00:12:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63K0CgYo27918956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 00:12:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BE1B58058;
	Mon, 20 Apr 2026 00:12:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AB205805B;
	Mon, 20 Apr 2026 00:12:40 +0000 (GMT)
Received: from [9.61.89.198] (unknown [9.61.89.198])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 00:12:40 +0000 (GMT)
Message-ID: <dcc2b7b2-47ac-475d-af6b-d5c2f2b812b6@linux.ibm.com>
Date: Sun, 19 Apr 2026 17:12:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ibmveth: Disable GSO for packets with small MSS
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org, shaik.abdulla1@ibm.com, naveedaus@in.ibm.com
References: <20260417172910.81433-1-mmc@linux.ibm.com>
 <20260418175451.122193-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260418175451.122193-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDI1NSBTYWx0ZWRfXywkL4mbph7pn
 y9NDpS8ktWEK/Wt4Fwq5/CuAM97+q0nNiMhqGZaFuUiQw9x1UCKTP/kkMPoF7J1fRI9KDZWut9T
 P6MiRMGKehdZtNTgQLsvcMnwuWQDrOpTYJd8baM/IM5HZc7QQd4ojtHZTXuVNVHVYe0Y4LHkUy8
 NLXDUIQyljIQdV/2gUNYnMZnRxeV9F4/XSM3cTdU4uyborwffjqa3yZNNJ+REwSF8X0BXgHHV9D
 XURHdprmg7h/F8Lyp/aDfZN4bs547Ay8rRr/LF4UFwawjc0/8UfBU0kWrbasJrnjrLUhifaP5fo
 yZ3oB8TRpMysbe1KB3sdrIgAgH7raUfWm3i2SmhibM2HlOo2RxuwTzeE2HVK86A1TgDWoBud/Ck
 2+Gnh8NnRboVZPUgCc6J5xTbI1lpjtjH+rGkQbUGfehvw0910gk2l0UApS1sayntunEe6ZKUeP5
 GxSKH4WS5DraFJaozAQ==
X-Proofpoint-GUID: t6hNByzCcWjgl0WInHRfkkYPE8JpykPZ
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e56f7d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=sDADSKU7Kdt2IJdVO5YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e1yCFhD-mX4ZlgjEllJFepkfqH0W5lmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604190255
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-238673-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B0F45425E41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/18/26 10:54 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Thanks for the review and the questions!

> ---
> ibmveth: Disable GSO for packets with small MSS
>
> This commit adds an ndo_features_check callback to the ibmveth driver to
> disable segmentation offload when the MSS is less than 224 bytes. This
> prevents physical adapters in SEA configurations from freezing when given
> small MSS packets.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1756,6 +1756,25 @@ static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
>>   	return 0;
>>   }
>>   
>> +static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
>> +						struct net_device *dev,
>> +						netdev_features_t features)
>> +{
>> +	/* Some physical adapters do not support segmentation offload with
>> +	 * MSS < 224. Disable GSO for such packets to avoid adapter freeze.
>> +	 */
>> +	if (skb_is_gso(skb)) {
> The commit message mentions this matches the ibmvnic hardware errata from
> commit f10b09ef687f. That commit disabled GSO for both gso_size < 224 and
> gso_segs == 1.
>
> By omitting the check for skb_shinfo(skb)->gso_segs == 1, could a
> single-segment GSO packet still cause the adapter to freeze?
Good question. Unlike ibmvnic, ibmveth does not need to check for 
single-segment GSO packets (gso_segs == 1).

In ibmvnic, the firmware processes all GSO packets, including 
single-segment ones, through the same LSO code path. This means even 
gso_segs == 1 packets can trigger the hardware errata.

In ibmveth, the PowerVM hypervisor intelligently bypasses the LSO path 
for single-segment packets. When gso_segs == 1, the hypervisor treats 
the packet as a regular (non-GSO) packet and transmits it directly 
without invoking the problematic hardware segmentation logic. Therefore, 
single-segment GSO packets never reach the code path that causes the freeze.

This architectural difference is why ibmvnic needs the gso_segs check 
but ibmveth does not.
>
>> +		if (skb_shinfo(skb)->gso_size < IBMVETH_MIN_LSO_MSS) {
>> +			netdev_warn_once(dev,
>> +					 "MSS %u too small for LSO, disabling GSO\n",
>> +					 skb_shinfo(skb)->gso_size);
>> +			features &= ~NETIF_F_GSO_MASK;
>> +		}
>> +	}
>> +
>> +	return features;
> When implementing a custom ndo_features_check callback, netif_skb_features()
> will bypass the standard dflt_features_check() function. Does this mean
> vlan_features_check() is no longer called for this driver?
>
> If vlan_features_check() is skipped, multi-tagged (QinQ) VLAN packets
> might retain GSO and protocol-specific checksum offloads that the hardware
> parser cannot handle.
>
> Should this return vlan_features_check(skb, features) instead?

You’re correct about the interaction with the default feature filtering. 
With a custom ndo_features_check(), the standard dflt_features_check() 
path is bypassed, so vlan_features_check() must be called explicitly to 
preserve existing VLAN/QinQ and checksum handling.

Thank you for catching this! I'll send v3 shortly with:
1. The vlan_features_check() call added
2. Updated commit message explaining why gso_segs check is not needed 
for ibmveth

Best regards,

Mingming


>> +}

