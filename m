Return-Path: <stable+bounces-222847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMp9L4+1pmk7TAAAu9opvQ
	(envelope-from <stable+bounces-222847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 11:18:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 429DA1EC91E
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 11:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB03B30C520F
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E53394799;
	Tue,  3 Mar 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ERzbbXTV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D83750BE;
	Tue,  3 Mar 2026 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532844; cv=none; b=P3Wo6VepQMkM3cAtfKuWAqeu0nAOW7lyUAqRyyZJWfa3nyU+D8hW41LRMUguY2G8Cum4Fk0IGBoG0s4rrdLziD6OpTqdlzGXtQw/T310Hy3OcpiG9tU06ixzl3Py9U7j7BXcTl84j9SOvh0XOGruOM3IQqPkil1Ygw6ku1DZJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532844; c=relaxed/simple;
	bh=dRlgEQRxiqTwWF1+uuOD6cFd2o5236c9WsojWE0YC3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8dhKmMbMJsit+gTvO8wu6LGlR306LAL8B8oFOL/wqC6phDyKIjx6I4lzSrBD9upsU0tXVoTJ0yTn2UqnW/+cPV11MdZy/k7YEswh1janR59kkTR2gT5szye70/LbFFkUfK5025JjDOQ+rmkxpEEcQRMxwNPdMyf8o37ljT45h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ERzbbXTV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6232V1li1517870;
	Tue, 3 Mar 2026 10:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lChQ92
	53pajFtzuxe2MbIXO0swUhj0a914oqMgjhyZc=; b=ERzbbXTVo73Id0ik0sztWi
	EM0LJEBwu0Fc9UBuHFMwswqE55DaLNXMIIj6SrBxpTzRg0mYScDWxQirCbHwAnuk
	tMb2QFVsYA2gD2zDdnpVaVn6o6l9cqe0b8u7X8PewJLd67Ch2tABbAP76ZJLPsuN
	Ryg1/iCQJ/zYg5vdn0yWza9PYT0ayUTx4W59aHkon7WIstMA4AJJJM/TVVA/7SDw
	UTOl652ExStaDgDOTZESEDVe1D03ouMkTsaMmvW95VXgC9KQs9wifLR6iy+LVTjg
	/Y7d39GesVy+zf1yoEhSsh4GMLU5sOatG8JHZKtUZZIBaNaquEndwZKYKGF7RFlA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskctfkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 10:13:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6235DuA3010284;
	Tue, 3 Mar 2026 10:13:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k1pfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 10:13:45 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623ADiD36816322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 10:13:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC4F758052;
	Tue,  3 Mar 2026 10:13:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A43B95805E;
	Tue,  3 Mar 2026 10:13:41 +0000 (GMT)
Received: from [9.124.211.174] (unknown [9.124.211.174])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 10:13:41 +0000 (GMT)
Message-ID: <50bccaf9-9bd8-43b4-8e0f-ddb347a9484d@linux.ibm.com>
Date: Tue, 3 Mar 2026 15:43:40 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/pseries: Correct MSI allocation tracking
To: Nam Cao <namcao@linutronix.de>, Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260302003948.1452016-1-namcao@linutronix.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260302003948.1452016-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: H3acRpo8jaYiuOvgFu8zs_NHG2147jbf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NyBTYWx0ZWRfXw9xLJB5imsXy
 +ECmE2s7b+1OWlfr7IbzoQ2QCF4I0122JyJmK3u8O0UNTuSpDS5swvARLUvfSo9y4NIFh51WzjP
 CEpMD5krId7jY2LCfvUtuBw9/VZ2Y4OS3wCt7abv2lvSlfK8ICPTTT/LGrMtZz8q+GGDKf4pmmS
 4EO47DzQkE5jqmO4e5Pc/lE2194ppLJ35K+af3jgTe041I8S0kQIbvRXNPtsSyZlm5aJhaoNNrt
 eQsuCje6z8hNzLDiUuXbwbNGqZ0Ech8TJMG8jsLAfYdd+uJVbPaVclIy4S2DKuGs/hp6Q5rYwV5
 +NmN3PYDuy7YHe2NbiM8vz0GeSEmFY557KqJyMHMc9ST84FC5DtRPgI8RPgjTJ2O+bUXEd201kG
 hDL39hLhAhiSc1YGovoIEXDgZ2TX3Z3aKCd5Lp6t5N0MDaNrohZZSWpdAx89DRFPHSiUO6Ji7Q5
 FbZD6jTfPNTJ7CJ2xNg==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a6b45b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ExDeZcIHuf4lvlsAU-IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JR31GefV_aJ9Bhzm_9hkjqkRTt-Sc6b0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030077
X-Rspamd-Queue-Id: 429DA1EC91E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222847-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linutronix.de,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:mid,linutronix.de:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On 3/2/26 6:09 AM, Nam Cao wrote:
> The per-device MSI allocation calculation in pseries_irq_domain_alloc()
> is clearly wrong. It can still happen to work when nr_irqs is 1.
> 
> Correct it.
> 
> Fixes: c0215e2d72de ("powerpc/pseries: Fix MSI-X allocation failure when quota is exceeded")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>   arch/powerpc/platforms/pseries/msi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 64ffc6476ad6..8285b9a29fbf 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -605,7 +605,7 @@ static int pseries_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
>   					      &pseries_msi_irq_chip, pseries_dev);
>   	}
>   
> -	pseries_dev->msi_used++;
> +	pseries_dev->msi_used += nr_irqs;
>   	return 0;
>   
>   out:

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>



